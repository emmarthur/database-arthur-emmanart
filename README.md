# CS 486/586 — Database (Portland State)

Coursework and final project for **CS 486/586 Database Systems** — Emmanuel Arthur ([emmarthur](https://github.com/emmarthur)).

## Contents

| Area | Description |
|------|-------------|
| **FinalProject/** | European Soccer Database final project (`soccer_proj` schema): ERD, migration scripts, deliverables, presentation |
| **Homework / labs** | SQL homework, `students-examples.sql`, `books2-inclass.sql`, Lab1 scripts |
| **Handouts / test prep** | Text copies and practice questions from class materials |
| **In-class activities** | Spy database activities (joins, views, subqueries) |

## Final project (soccer)

- **Dataset:** [Kaggle European Soccer Database](https://www.kaggle.com/datasets/hugomathien/soccer)
- **Stack:** SQLite source → CSV → PostgreSQL (`soccer_proj`)
- **Artifacts:** `FinalProject/soccer_data/migration_artifacts/` (DDL, smaller CSVs, `migration_summary.txt`)
- **Docs:** `Postgres-Soccer-Database-Steps.md`, `Deliverable4_Presentation-emmanart.pptx` (+ PDF)

### Large files (not in Git)

GitHub size limits exclude:

- `FinalProject/soccer_data/database.sqlite` (~313 MB)
- `Match.csv` and `Player_Attributes.csv` under `migration_artifacts/csv/`

To regenerate from your own SQLite copy:

```powershell
python FinalProject/sqlite_to_postgres_prep.py `
  --sqlite "FinalProject/soccer_data/database.sqlite" `
  --out-dir "FinalProject/soccer_data/migration_artifacts" `
  --schema soccer_proj
```

Then load with `postgres_schema_tables_only.sql` and `postgres_schema_fks_safe.sql` (see `DBeaver-Table-and-Data-Load-Steps.md`).

## Build scripts

```powershell
python FinalProject/_build_deliverable3_docx.py
python FinalProject/_build_deliverable4_docx.py
python FinalProject/_build_deliverable4_pptx.py
```

## Note

Course handouts and textbook PDFs are for personal study only; do not redistribute instructor materials.
