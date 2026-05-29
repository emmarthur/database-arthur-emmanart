# CS 486/586 — Database (Portland State)

Coursework and final project for **CS 486/586 Database Systems** — Emmanuel Arthur ([emmarthur](https://github.com/emmarthur)).

## Repository layout

```
DatabaseClass/
├── README.md
├── Homework/                    # Submissions and HW tooling
│   ├── CS 486_586 – Homework 4-emmanart.docx
│   ├── homework4 image - spy.png
│   └── scripts/                 # Regenerate or patch Homework 4 docx
├── InClass/                     # In-class activities (Spy DB, books, etc.)
├── Labs/                        # Lab and chapter SQL scripts
├── Setup/                       # Postgres + DBeaver / SQLTools setup
├── Scripts/                     # One-off utilities (docx/pdf helpers)
├── Handouts/                    # Instructor text copies (study only)
├── TestPrep/                    # Practice questions and cheatsheets
└── FinalProject/
    ├── docs/                    # Project planning and load guides
    ├── deliverables/            # Instructions, demo SQL handout, write-ups
    ├── presentation/            # Deliverable 4 pptx, pdf, deep-dive guide, screenshots
    ├── demo/                    # Video demo talking points + SQL notes
    ├── scripts/                 # Build docx/pptx, sqlite → postgres prep
    └── soccer_data/             # Migration SQL + CSV (large files gitignored)
```

## Final project (soccer)

- **Dataset:** [Kaggle European Soccer Database](https://www.kaggle.com/datasets/hugomathien/soccer)
- **Stack:** SQLite source → CSV → PostgreSQL (`soccer_proj`)
- **Load guide:** [FinalProject/docs/DBeaver-Table-and-Data-Load-Steps.md](FinalProject/docs/DBeaver-Table-and-Data-Load-Steps.md)
- **Presentation:** [FinalProject/presentation/Deliverable4_Presentation-emmanart.pptx](FinalProject/presentation/Deliverable4_Presentation-emmanart.pptx)
- **Slide-by-slide guide:** [FinalProject/presentation/Deliverable4_Presentation_Deep_Dive-emmanart.md](FinalProject/presentation/Deliverable4_Presentation_Deep_Dive-emmanart.md)

### Large files (not in Git)

- `FinalProject/soccer_data/database.sqlite` (~313 MB)
- `Match.csv` and `Player_Attributes.csv` under `migration_artifacts/csv/`

Regenerate artifacts:

```powershell
python FinalProject/scripts/sqlite_to_postgres_prep.py `
  --sqlite "FinalProject/soccer_data/database.sqlite" `
  --out-dir "FinalProject/soccer_data/migration_artifacts" `
  --schema soccer_proj
```

Then load with `postgres_schema_tables_only.sql` and `postgres_schema_fks_safe.sql` (see docs above).

## Build scripts

```powershell
python FinalProject/scripts/_build_deliverable3_docx.py
python FinalProject/scripts/_build_deliverable4_docx.py
python FinalProject/scripts/_build_deliverable4_pptx.py
```

Homework 4 docx helpers:

```powershell
python Homework/scripts/_complete_hw4_docx.py
python Homework/scripts/_update_hw4_spy_schema.py
```

## Note

Course handouts and textbook PDFs are for personal study only; do not redistribute instructor materials.
