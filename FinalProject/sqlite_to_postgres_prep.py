import argparse
import csv
import re
import sqlite3
from pathlib import Path


def quote_ident(name: str) -> str:
    return '"' + name.replace('"', '""') + '"'


def map_sqlite_type(sqlite_type: str) -> str:
    t = (sqlite_type or "").upper()
    if "INT" in t:
        return "BIGINT"
    if any(x in t for x in ("CHAR", "CLOB", "TEXT", "VARCHAR")):
        return "TEXT"
    if any(x in t for x in ("REAL", "FLOA", "DOUB")):
        return "DOUBLE PRECISION"
    if "NUMERIC" in t or "DECIMAL" in t:
        return "NUMERIC"
    if "DATE" in t and "TIME" in t:
        return "TIMESTAMP"
    if "DATE" in t:
        return "DATE"
    if "TIME" in t:
        return "TIME"
    return "TEXT"


def sanitize_table_name(name: str) -> str:
    # Keep original casing but avoid reserved words by suffixing.
    if name.lower() in {"match", "user", "order", "group"}:
        return f"{name}_tbl"
    return name


def export_csvs(conn: sqlite3.Connection, tables: list[str], out_dir: Path) -> None:
    out_dir.mkdir(parents=True, exist_ok=True)
    cur = conn.cursor()
    for table in tables:
        rows = cur.execute(f'SELECT * FROM {quote_ident(table)}')
        headers = [d[0] for d in rows.description]
        csv_path = out_dir / f"{table}.csv"
        with csv_path.open("w", newline="", encoding="utf-8") as f:
            writer = csv.writer(f)
            writer.writerow(headers)
            writer.writerows(rows)


def get_unique_column_sets(cur: sqlite3.Cursor, table: str) -> set[tuple[str, ...]]:
    unique_sets: set[tuple[str, ...]] = set()
    cols = list(cur.execute(f'PRAGMA table_info({quote_ident(table)})'))
    pk_cols = [c[1] for c in cols if c[5]]
    if pk_cols:
        unique_sets.add(tuple(pk_cols))

    for idx in cur.execute(f'PRAGMA index_list({quote_ident(table)})'):
        # index_list: seq, name, unique, origin, partial
        idx_name = idx[1]
        is_unique = idx[2]
        if not is_unique:
            continue
        idx_cols = [
            row[2] for row in cur.execute(f'PRAGMA index_info({quote_ident(idx_name)})')
        ]
        if idx_cols:
            unique_sets.add(tuple(idx_cols))
    return unique_sets


def fk_has_orphans(
    cur: sqlite3.Cursor,
    child_table: str,
    from_cols: list[str],
    parent_table: str,
    to_cols: list[str],
) -> bool:
    child_q = quote_ident(child_table)
    parent_q = quote_ident(parent_table)

    not_null_filter = " AND ".join(f'c.{quote_ident(c)} IS NOT NULL' for c in from_cols)
    join_predicate = " AND ".join(
        f'p.{quote_ident(pc)} = c.{quote_ident(cc)}'
        for cc, pc in zip(from_cols, to_cols)
    )
    sql = (
        f"SELECT EXISTS ("
        f"SELECT 1 FROM {child_q} c "
        f"WHERE {not_null_filter} "
        f"AND NOT EXISTS (SELECT 1 FROM {parent_q} p WHERE {join_predicate})"
        f")"
    )
    return bool(cur.execute(sql).fetchone()[0])


def build_postgres_ddl(conn: sqlite3.Connection, schema: str) -> tuple[str, str, str]:
    cur = conn.cursor()
    tables = [
        r[0]
        for r in cur.execute(
            "SELECT name FROM sqlite_master WHERE type='table' "
            "AND name NOT LIKE 'sqlite_%' ORDER BY name"
        )
    ]
    parts = [f'CREATE SCHEMA IF NOT EXISTS {quote_ident(schema)};', ""]
    rename_map: dict[str, str] = {}

    for table in tables:
        pg_table = sanitize_table_name(table)
        rename_map[table] = pg_table
        cols = list(cur.execute(f'PRAGMA table_info({quote_ident(table)})'))
        unique_sets = get_unique_column_sets(cur, table)
        col_defs = []
        pk_cols = []
        for _, name, ctype, notnull, default, pk in cols:
            pg_type = map_sqlite_type(ctype)
            line = f"    {quote_ident(name)} {pg_type}"
            if notnull:
                line += " NOT NULL"
            if default is not None:
                line += f" DEFAULT {default}"
            col_defs.append(line)
            if pk:
                pk_cols.append(name)
        if pk_cols:
            col_defs.append(
                "    CONSTRAINT "
                f'{quote_ident(f"{pg_table}_pk")} PRIMARY KEY '
                f"({', '.join(quote_ident(c) for c in pk_cols)})"
            )
        for idx, unique_cols in enumerate(unique_sets):
            if pk_cols and tuple(pk_cols) == tuple(unique_cols):
                continue
            col_defs.append(
                "    CONSTRAINT "
                f'{quote_ident(f"{pg_table}_uq_{idx}")} UNIQUE '
                f"({', '.join(quote_ident(c) for c in unique_cols)})"
            )

        parts.append(
            f"CREATE TABLE {quote_ident(schema)}.{quote_ident(pg_table)} (\n"
            + ",\n".join(col_defs)
            + "\n);"
        )
        parts.append("")

    tables_only_sql = "\n".join(parts) + "\n"

    # Foreign keys from sqlite metadata
    rename_lookup = {k.lower(): v for k, v in rename_map.items()}
    fks_safe_parts: list[str] = []
    fks_skipped_parts: list[str] = []
    unique_targets_by_table = {t: get_unique_column_sets(cur, t) for t in tables}

    for table in tables:
        fk_rows = list(cur.execute(f'PRAGMA foreign_key_list({quote_ident(table)})'))
        if not fk_rows:
            continue
        child = sanitize_table_name(table)
        # group by fk id
        grouped: dict[int, list[tuple]] = {}
        for row in fk_rows:
            grouped.setdefault(row[0], []).append(row)
        for fk_id, entries in grouped.items():
            parent_orig = entries[0][2]
            parent = rename_lookup.get(
                parent_orig.lower(), sanitize_table_name(parent_orig)
            )
            from_cols = [e[3] for e in entries]
            to_cols = [e[4] for e in entries]
            fk_sql = (
                f"ALTER TABLE {quote_ident(schema)}.{quote_ident(child)} "
                f"ADD CONSTRAINT {quote_ident(f'{child}_fk_{fk_id}')} "
                f"FOREIGN KEY ({', '.join(quote_ident(c) for c in from_cols)}) "
                f"REFERENCES {quote_ident(schema)}.{quote_ident(parent)} "
                f"({', '.join(quote_ident(c) for c in to_cols)});"
            )
            if tuple(to_cols) not in unique_targets_by_table.get(parent_orig, set()):
                fks_skipped_parts.append(
                    "-- Skipped (not PK/UNIQUE in parent): " + fk_sql
                )
                continue

            if fk_has_orphans(cur, table, from_cols, parent_orig, to_cols):
                fks_skipped_parts.append(
                    "-- Skipped (orphaned child values in source data): " + fk_sql
                )
                continue

            if tuple(to_cols) in unique_targets_by_table.get(parent_orig, set()):
                fks_safe_parts.append(fk_sql)

    fks_safe_sql = "\n".join(fks_safe_parts) + ("\n" if fks_safe_parts else "")
    fks_skipped_sql = "\n".join(fks_skipped_parts) + ("\n" if fks_skipped_parts else "")
    full_sql = tables_only_sql + ("\n" if fks_safe_sql else "") + fks_safe_sql + fks_skipped_sql
    return full_sql, tables_only_sql, fks_safe_sql


def make_idempotent_fk_sql(fk_sql: str) -> str:
    lines = [ln.strip() for ln in fk_sql.splitlines() if ln.strip()]
    blocks: list[str] = []
    for ln in lines:
        if "ADD CONSTRAINT" not in ln:
            continue
        constraint_name = ln.split("ADD CONSTRAINT", 1)[1].split("FOREIGN KEY", 1)[0].strip()
        if constraint_name.startswith('"') and constraint_name.endswith('"'):
            constraint_name = constraint_name[1:-1]
        constraint_name_literal = "'" + constraint_name.replace("'", "''") + "'"
        child_table = ln.split("ALTER TABLE", 1)[1].split("ADD CONSTRAINT", 1)[0].strip()
        # child_table format: "schema"."table"
        schema_name = child_table.split(".", 1)[0].strip().strip('"')
        table_name = child_table.split(".", 1)[1].strip().strip('"')
        schema_name_literal = "'" + schema_name.replace("'", "''") + "'"
        table_name_literal = "'" + table_name.replace("'", "''") + "'"
        blocks.append(
            "DO $$\n"
            "BEGIN\n"
            f"    IF NOT EXISTS (\n"
            f"        SELECT 1\n"
            f"        FROM pg_constraint c\n"
            f"        JOIN pg_class t ON t.oid = c.conrelid\n"
            f"        JOIN pg_namespace n ON n.oid = t.relnamespace\n"
            f"        WHERE c.conname = {constraint_name_literal}\n"
            f"          AND n.nspname = {schema_name_literal}\n"
            f"          AND t.relname = {table_name_literal}\n"
            "    ) THEN\n"
            f"        {ln}\n"
            "    END IF;\n"
            "END $$;\n"
        )
    return "\n".join(blocks)


def main() -> None:
    parser = argparse.ArgumentParser(description="Prepare SQLite -> PostgreSQL migration artifacts.")
    parser.add_argument("--sqlite", required=True, help="Path to SQLite database file")
    parser.add_argument("--out-dir", required=True, help="Output directory for CSV/SQL files")
    parser.add_argument("--schema", default="soccer_proj", help="Target PostgreSQL schema name")
    args = parser.parse_args()

    sqlite_path = Path(args.sqlite)
    out_dir = Path(args.out_dir)
    out_dir.mkdir(parents=True, exist_ok=True)

    conn = sqlite3.connect(str(sqlite_path))
    cur = conn.cursor()
    tables = [
        r[0]
        for r in cur.execute(
            "SELECT name FROM sqlite_master WHERE type='table' "
            "AND name NOT LIKE 'sqlite_%' ORDER BY name"
        )
    ]

    export_csvs(conn, tables, out_dir / "csv")
    ddl, ddl_tables_only, ddl_fks_safe = build_postgres_ddl(conn, args.schema)
    (out_dir / "postgres_schema.sql").write_text(ddl, encoding="utf-8")
    (out_dir / "postgres_schema_tables_only.sql").write_text(
        ddl_tables_only, encoding="utf-8"
    )
    (out_dir / "postgres_schema_fks_safe.sql").write_text(ddl_fks_safe, encoding="utf-8")
    (out_dir / "postgres_schema_fks_safe_rerunnable.sql").write_text(
        make_idempotent_fk_sql(ddl_fks_safe), encoding="utf-8"
    )

    summary_lines = ["Tables found:"]
    for t in tables:
        count = cur.execute(f'SELECT COUNT(*) FROM {quote_ident(t)}').fetchone()[0]
        summary_lines.append(f"- {t}: {count} rows")
    (out_dir / "migration_summary.txt").write_text("\n".join(summary_lines) + "\n", encoding="utf-8")
    conn.close()


if __name__ == "__main__":
    main()
