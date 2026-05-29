# DBeaver Steps: Create Tables + Load Data (SQLite -> PostgreSQL)

Use this when your `database.sqlite` has already been converted into migration artifacts.

## Why your error happened

Error:

`SQL Error [42830]: there is no unique constraint matching given keys for referenced table "Player"`

Meaning:

- PostgreSQL only allows a foreign key to reference a column that is `PRIMARY KEY` or `UNIQUE`.
- The original SQLite FK metadata references some non-unique parent columns (valid in SQLite metadata, but not enforceable in PostgreSQL).

## Files to use

From `FinalProject/soccer_data/migration_artifacts`:

- `postgres_schema_tables_only.sql` (safe for table creation)
- `postgres_schema_fks_safe.sql` (only FKs that are valid in PostgreSQL)
- `csv/*.csv` (data files)
- `migration_summary.txt` (expected row counts)

## Clean rerun (recommended)

If a previous script run partially created objects, run this first in DBeaver:

```sql
drop schema if exists soccer_proj cascade;
create schema soccer_proj;
```

## Step 1: Create tables (no FK failures)

1. Open `postgres_schema_tables_only.sql`
2. Execute script
3. Refresh `soccer_proj` schema

## Step 2: Import CSV data

For each table in `soccer_proj`:

1. Right-click table -> **Import Data**
2. Choose **CSV**
3. Pick the matching file from `migration_artifacts/csv`
4. Keep header row enabled
5. Confirm mappings and run import

Name mapping:

- `"Country"` <- `Country.csv`
- `"League"` <- `League.csv`
- `"Team"` <- `Team.csv`
- `"Player"` <- `Player.csv`
- `"Team_Attributes"` <- `Team_Attributes.csv`
- `"Player_Attributes"` <- `Player_Attributes.csv`
- `"Match_tbl"` <- `Match.csv`

## Step 3: Add safe foreign keys

1. Open `postgres_schema_fks_safe.sql`
2. Execute script

This applies only FK constraints that PostgreSQL can enforce from the generated schema.

## Step 4: Verify row counts

```sql
select 'Country' as table_name, count(*) from soccer_proj."Country"
union all
select 'League', count(*) from soccer_proj."League"
union all
select 'Team', count(*) from soccer_proj."Team"
union all
select 'Player', count(*) from soccer_proj."Player"
union all
select 'Team_Attributes', count(*) from soccer_proj."Team_Attributes"
union all
select 'Player_Attributes', count(*) from soccer_proj."Player_Attributes"
union all
select 'Match_tbl', count(*) from soccer_proj."Match_tbl";
```

Expected totals are listed in `migration_summary.txt`.
