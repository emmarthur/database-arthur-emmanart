# CS 486/586 — Database (Portland State)

Coursework and final project for **CS 486/586 Database Systems** — Emmanuel Arthur ([emmarthur](https://github.com/emmarthur)).

## Repository layout

Files are grouped by **course area**. Inside each area, related files are kept together when possible; `scripts/` and `soccer_data/` stay separate for tooling.

```
DatabaseClass/
├── README.md
├── Homework/
│   ├── docx/          # Submitted Word documents
│   ├── pdf/
│   ├── markdown/      # Reference notes
│   ├── assets/        # Screenshots (e.g. Spy ERD)
│   ├── answers/       # Short text answers
│   └── scripts/       # Regenerate or patch Homework 4 docx
├── InClass/
│   ├── docx/ | pdf/ | markdown/
│   ├── prompts/ | answers/
│   ├── sql/ | reference/
├── Labs/
│   ├── sql/
│   └── pdf/
├── Setup/
│   ├── guides/
│   └── pdf/
├── Scripts/
│   ├── python/
│   └── powershell/
├── Handouts/
│   ├── pdf/           # Instructor slide PDFs
│   └── text/          # Text copies for search/study
├── TestPrep/
│   └── text/          # Practice questions and cheatsheets
├── Reference/         # Textbook PDF (gitignored; personal study only)
└── FinalProject/
    ├── docs/          # Planning guides (markdown, txt, pdf/)
    ├── deliverables/
    │   ├── docx/      # Write-ups and deliverable Word files
    │   └── text/      # Instructions and demo SQL handout
    ├── presentation/
    │   ├── slides/    # pptx, pdf
    │   ├── markdown/  # Slide-by-slide deep dive
    │   └── screenshots/
    ├── demo/
    ├── assets/        # ERD images (erd/ subfolder for exports)
    ├── scripts/
    └── soccer_data/   # Migration SQL + CSV (large files gitignored)
```

## Final project (soccer)

- **Dataset:** [Kaggle European Soccer Database](https://www.kaggle.com/datasets/hugomathien/soccer)
- **Stack:** SQLite source → CSV → PostgreSQL (`soccer_proj`)
- **Load guide:** [FinalProject/docs/DBeaver-Table-and-Data-Load-Steps.md](FinalProject/docs/DBeaver-Table-and-Data-Load-Steps.md)
- **Presentation:** [FinalProject/presentation/slides/Deliverable4_Presentation-emmanart.pptx](FinalProject/presentation/slides/Deliverable4_Presentation-emmanart.pptx)
- **Slide-by-slide guide:** [FinalProject/presentation/markdown/Deliverable4_Presentation_Deep_Dive-emmanart.md](FinalProject/presentation/markdown/Deliverable4_Presentation_Deep_Dive-emmanart.md)

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
