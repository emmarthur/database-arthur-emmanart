# Soccer dataset options (research for your final project)

**Based on your answers (Q1–11):** club + international soccer interest, **CSV** preferred, publicly downloadable, comfortable under **~500 MB**, plan to build/load via **DBeaver**.  
**Graduate bar (from syllabus):** cite the source with a link, **≥10,000 total rows** across tables, **6–10** normalized tables, **many multi-table joins** (often **4–6** tables), **one view joining ≥4 tables**, mostly **real** data.

These options are **starting points**—always re-check **license/terms** on the site or repo before you submit, and **download a sample** to confirm keys and row counts.

---

## 1. Football-Data.co.uk (league results, stats, odds) — **native CSV**

| | |
|--|--|
| **Landing / index** | [https://www.football-data.co.uk/data.php](https://www.football-data.co.uk/data.php) |
| **Column documentation** | [https://www.football-data.co.uk/notes.txt](https://www.football-data.co.uk/notes.txt) |
| **Example file** | [https://www.football-data.co.uk/example.csv](https://www.football-data.co.uk/example.csv) |

**What it is:** Free CSV/Excel files for many **domestic leagues** (England, Spain, Germany, Italy, France, plus “extra” countries, MLS, etc.): full-time/half-time results, match stats (shots, cards, corners, etc., depending on league/season), and **betting odds** columns for many seasons.

**Why it can work for your project:** You download **many separate CSVs** (per country/season or bundled). You **normalize** into tables such as `League`, `Season`, `Team`, `Match`, `MatchStats`, `BookmakerOdds` (or similar)—that gets you toward **6–10 tables** and **huge** row counts once you load several divisions/seasons. **Joins + odds + stats** give natural **intermediate/advanced** SQL.

**Caveats:** Site is betting-oriented; your writeup can focus on **football analytics**, not gambling. Read their **notes** for column meanings. **Combine multiple files** deliberately so you are not “one giant denormalized table only.”

**Citation:** Attribute **Football-Data.co.uk** (and date retrieved + URL) as your instructor requires; see site **Contact** / terms if they publish explicit wording.

---

## 2. martj42 — International match results (GitHub + Kaggle) — **native CSV**

| | |
|--|--|
| **GitHub repository** | [https://github.com/martj42/international_results](https://github.com/martj42/international_results) |
| **Kaggle mirror** | [https://www.kaggle.com/datasets/martj42/international-football-results-from-1872-to-2017](https://www.kaggle.com/datasets/martj42/international-football-results-from-1872-to-2017) |

**What it is:** Three related CSVs: **`results.csv`** (~49k+ men’s full internationals, 1872 onward—check repo for current count), **`goalscorers.csv`**, **`shootouts.csv`**. Columns include date, home/away team, scores, tournament, city, country, neutral venue, etc.

**Why it can work:** Strong fit for **international** soccer; **row counts** easily meet **10k+**. You model **`Team`**, **`Tournament`**, **`Venue`/`HostCountry`**, **`Match`**, **`Goal`**, **`Shootout`** (and maybe **`Scorer`** dimensions)—natural **multi-table** questions and a **4+ table view** (e.g. match + tournament + teams + venue).

**Caveats:** Team names are **strings**; you will design **surrogate keys** and handle **name consistency**. Confirm **license** on the repo (often **CC0** on Kaggle/GitHub—verify before citing).

---

## 3. StatsBomb Open Data — **JSON (not CSV out of the box)**

| | |
|--|--|
| **Repository** | [https://github.com/statsbomb/open-data](https://github.com/statsbomb/open-data) |

**What it is:** **Event-level** data (passes, shots, etc.), matches, lineups, competitions—**very rich** for advanced SQL and for a **graduate** project if you invest in **ETL**.

**Why consider it:** Excellent depth for **club** analysis and **complex queries**; clearly **public** and widely used in teaching.

**Caveats:** Data is **JSON**, not CSV. You would **convert** (e.g. small Python or jq pipelines) to tabular files, or load JSON into staging then normalize—still fine for class, but **more work** than pure CSV. StatsBomb may require **specific citation / branding** if you publish analysis—read their **terms** and repo **README** carefully.

---

## 4. Kaggle — “European Soccer Database” — **SQLite bundle (exportable to CSV / loadable in DBeaver)**

| | |
|--|--|
| **Dataset page** | [https://www.kaggle.com/datasets/hugomathien/soccer](https://www.kaggle.com/datasets/hugomathien/soccer) |

**What it is:** Classic **`database.sqlite`** with **25,000+ matches**, **10,000+ players**, leagues/countries, **Match**, **Player**, **Player_Attributes**, **Team**, **Team_Attributes**, **Country**, **League**, **Team_Lineup**-style structures (exact names in schema).

**Why it can work:** Already **relational**—maps cleanly to **6–10 tables**, **10k+ rows**, and **join-heavy** questions. **DBeaver** can connect to **SQLite** directly, or you can **export each table to CSV** if you want CSV-first workflow.

**Caveats:** **Kaggle account** required to download. **License:** use Kaggle’s dataset license + citation; **attribute** original compiler on the dataset page. Data is **older** (roughly **2008–2016** era)—fine for coursework if you do not need 2024–2025 seasons.

---

## 5. dcaribou — Transfermarkt-derived open data — **high volume; check format**

| | |
|--|--|
| **GitHub project** | [https://github.com/dcaribou/transfermarkt-datasets](https://github.com/dcaribou/transfermarkt-datasets) |
| **Kaggle (example entry point)** | [https://www.kaggle.com/datasets/davidcariboo/player-scores](https://www.kaggle.com/datasets/davidcariboo/player-scores) |

**What it is:** Pipeline that publishes **clubs, players, games, appearances, transfers, events**, etc.—**many tables** and **millions of rows**, strong for **graduate** scale and for **club + international** coverage if you pick the right slices.

**Caveats:** Releases may be **Parquet** or other formats depending on version—not always “download one CSV.” Read the **README** and **Kaggle dataset description** for **format**, **update cadence**, and **license** (**CC0** is commonly stated—confirm). Total size can exceed **500 MB** if you take **everything**; you can often **subset** (one competition, date range) to stay smaller **while still clearing 10k rows**.

---

## 6. Open Football (football.db / football.csv ecosystem)

| | |
|--|--|
| **Organization** | [https://github.com/openfootball](https://github.com/openfootball) |
| **Prebuilt SQLite DBs** | [https://github.com/openfootball/build/releases](https://github.com/openfootball/build/releases) |
| **Docs** | [https://openfootball.github.io/docs/](https://openfootball.github.io/docs/) |

**What it is:** Open **structured** football data; **prebuilt SQLite** databases and **football.csv**-style exports for several countries (see their **news/docs** for which leagues are auto-updated).

**Why it can work:** Good if you want **fixtures/results** in a **relational** form; **DBeaver + SQLite** works well.

**Caveats:** Coverage is **per-country repos**; you may **combine** countries or seasons to hit **join complexity** and **row counts**. Confirm **public domain** / project terms on their site.

---

## Quick comparison (for *your* constraints)

| Option | Club | International | CSV out of the box | Easy in DBeaver | Typical effort to hit 6–10 tables + 10k rows |
|--------|------|---------------|--------------------|-----------------|-----------------------------------------------|
| Football-Data.co.uk | Strong | No | Yes | Yes (import CSV) | Medium (you design schema across files) |
| martj42 international | No | Strong | Yes | Yes | Medium (normalize teams/tournaments) |
| StatsBomb open | Strong | Some competitions | No (JSON) | After ETL | Higher (ETL + normalization) |
| Kaggle European Soccer | Strong | European leagues | SQLite (CSV export optional) | Yes | Lower (schema exists) |
| transfermarkt-datasets | Strong | Often included | Varies | After format check | Medium–high (subset + format) |
| Open Football | Strong | Varies by dataset | Partial / SQLite | Yes | Medium |

---

## Combining sources (optional)

The syllabus **allows** combining datasets if they **link cleanly**. Examples:

- **martj42** (internationals) + a small **country / FIFA code** lookup (if you add a vetted public reference)—only if keys align.
- **Football-Data.co.uk**: multiple **leagues/seasons** as separate files merged into one **logical** database (same column layout per file family).

Avoid combining **incompatible keys** (e.g. club name in one file vs different spelling in another) without a **clear mapping** plan.

---

## Suggested next step for you

1. Pick **one primary** option above (often **Football-Data.co.uk** *or* **martj42** *or* **Kaggle European Soccer** for fastest path).  
2. Download **one season or one file group**, open in a spreadsheet or DBeaver, and **sketch 6–8 entities**.  
3. Run through **questions 12–27** in `Dataset-Selection-Questionnaire.md` for **that** candidate only.

---

## Disclaimer

Links and dataset sizes/licenses **change**. This note was assembled from **public pages and repos**; **verify** downloads, **terms**, and **citation** requirements before you submit **Deliverable 1**.
