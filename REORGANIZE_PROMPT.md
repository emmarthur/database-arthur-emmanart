# Cursor prompt: reorganize DatabaseClass

Copy everything between **PROMPT START** and **PROMPT END** into a new Cursor chat with this folder open (or reference `@DatabaseClass`).

---

**PROMPT START**

Reorganize and clean this repository recursively:

Workspace: C:\Users\emmak\Desktop\CodingProjects\DatabaseClass

CS 486/586 Database Systems coursework repo. Organize by **course area and assignment**, not by file type alone. Keep homework submissions, in-class work, labs, handouts, and final project material together per topic.

Organize by **content and name**, not primarily by file extension. Use type-based subfolders (`scripts/`, `assets/`, `archive/`) only where they help tooling.

### Goals

1. **Clean the repo root** — only `README.md`, `.gitignore`, config entry points, and essential top-level files. Move loose files into the correct folder.
2. **Reorganize recursively** — every subfolder should follow the same rules; fix mixed-purpose folders, duplicates, and stray files at any depth.
3. **Group by content/name** — folder names reflect purpose (feature, assignment, topic, deliverable), not primarily file extension.
4. **Preserve git history** — use `git mv` for tracked files when this is a git repo.
5. **Update references** — fix paths in scripts, READMEs, configs, imports, and build tooling after moves.
6. **Do not break workflows** — smoke-test scripts, apps, and notebooks you touch.

### Suggested top-level layout (adapt to what actually exists)

    DatabaseClass/
    ├── README.md
    ├── .gitignore
    ├── Homework/                 # Per assignment: Homework1/, Homework4/, etc.
    ├── InClass/                  # Per activity: Activity_03-1/, etc.
    ├── Labs/                     # SQL scripts and lab PDFs by chapter/lab
    ├── Handouts/                 # Per chapter/topic (pdf + text together)
    ├── TestPrep/
    ├── Setup/                    # Postgres/DBeaver guides
    ├── Scripts/                  # Repo utilities
    ├── Reference/                # Textbook PDF (gitignored)
    └── FinalProject/
        ├── docs/
        ├── deliverables/         # Per deliverable subfolders
        ├── presentation/
        ├── demo/
        ├── scripts/
        └── soccer_data/

### Rules for placement

- **Same assignment** → one folder (docx, pdf, sql, screenshots, answers together).
- **Handouts** → folder per chapter; keep PDF and text copy together.
- **Final project** → group by deliverable (1, 2, 3, 4) and artifact type only where tooling requires (`scripts/`, `soccer_data/`).
- **Build scripts** → `Homework/scripts/`, `FinalProject/scripts/` with `REPO_ROOT` paths updated.
- **Large data** → stay in `FinalProject/soccer_data/`; gitignore sqlite and huge CSVs.

### Cleanup checklist

- [ ] Root has no stray loose files that belong in subfolders
- [ ] Related files (source + docs + tests for same feature) live together
- [ ] Scripts and automation paths updated
- [ ] README documents the final tree
- [ ] `.gitignore` covers venv, caches, large binaries, and secrets
- [ ] `git status` clean after commit
- [ ] HW4 docx and spy assets in same homework folder
- [ ] Pptx builder paths point to presentation folder

### Execution

1. Survey the full tree first (list root + all subfolders, note loose files).
2. Propose a short move plan in chat, then execute moves.
3. Update scripts, imports, and docs.
4. Commit with message: "Organize DatabaseClass by content and clean repo layout"
5. Push only if `origin` exists and I have asked to push (otherwise stop after commit).

### Constraints

- Minimize scope: don't rewrite content inside files, only move/rename and fix paths.
- Don't edit any plan files in `.cursor/plans/` if present.
- Ask before deleting anything that might be the only copy of important work.
- Keep `.env` and secrets out of git; don't commit credentials.
- Gitignore caches (`__pycache__`, `.venv`, `node_modules`, `.ipynb_checkpoints`) rather than moving them.

Start by listing everything at the repo root and one level down, then proceed with the reorganization.

**PROMPT END**

---

## Tips

1. **Open this folder in Cursor** — File → Open Folder → `DatabaseClass`.
2. **Git** — If this isn't a repo yet, add to the prompt: *"Initialize git if missing, then commit."*
3. **Push** — Add at the end: *"Push to origin when done."* only if you want that automatically.
