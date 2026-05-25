# Deliverable 4 Presentation — Slide-by-Slide Deep Dive

**Author:** Emmanuel Arthur (emmanart)  
**Deck:** `Deliverable4_Presentation-emmanart.pptx`  
**Schema:** `soccer_proj` (PostgreSQL)  
**Purpose:** This document explains every element on every slide of the 8-minute video handout—what it means, why it is there, and how to talk about it on camera.

---

## Slide 1 — Title: European Soccer Database

### What appears on the slide

- **Green header bar** with white text: “European Soccer Database”
- Subtitle on bar: “Final Project · Deliverable 4 · soccer_proj”
- Below the bar: “Emmanuel Arthur · Database Class · Spring 2026”

### Deep dive

| Element | Meaning |
|--------|---------|
| **European Soccer Database** | Names the Kaggle “European Soccer Database” project—the factual subject of the final project. |
| **Final Project · Deliverable 4** | Tells the grader this is the culminating assignment (write-up + video), not a weekly homework. |
| **soccer_proj** | The PostgreSQL **schema** name where all tables and views live. In DBeaver you expand `Databases → postgres → Schemas → soccer_proj`. |
| **Your name + term** | Course requirement: identify who is presenting; all team members must appear in the video (solo project = you only). |

### What to say (~30 seconds)

Introduce yourself, the dataset, and that you will cover design, SQL reflection, a live (or screenshot) demo, and business relevance. Mention the video link is in the Deliverable 4 document.

### Speaker notes (from deck)

Postgres schema `soccer_proj`; video covers design, reflection, and a short demo.

---

## Slide 2 — Dataset overview

### Bullets on the slide

1. Source: Kaggle European Soccer Database (SQLite export → CSV → PostgreSQL)
2. Scope: 11 countries, 11 leagues, ~26K matches (2008–2016), teams, players, attributes
3. Business context: data clubs, sports media, and analytics vendors use for reporting
4. Schema `soccer_proj` with 7 base tables + views for common joins
5. Total loaded rows across all tables: **222,796**

### Deep dive

**Pipeline (SQLite → CSV → PostgreSQL)**  
The raw Kaggle file is SQLite. For class you typically export tables to CSV, then load into PostgreSQL with `CREATE TABLE` scripts (`postgres_schema_tables_only.sql`) and bulk insert. That migration forces you to pick PostgreSQL types (`integer`, `numeric`, `timestamp`, `text`) and handle NULLs and quoting.

**Scope numbers**

- **11 countries** — e.g. England, Spain, Germany; dimension table `Country`.
- **11 leagues** — one league per country in this extract; `League` links to `Country` via `country_id`.
- **~26K matches** — fact table `Match_tbl` (name avoids reserved word `Match`); each row is one game with scores, date, odds, lineups.
- **Teams / players / attributes** — `Team`, `Player`, plus `Team_Attributes` and `Player_Attributes` for time-series ratings and tactics.

**222,796 total rows**  
Sum of row counts across all seven base tables (largest: `Player_Attributes` ~184K). Use this to show the database is non-trivial but still manageable in DBeaver.

**Business context**  
Organizations do not “query for fun”—they track performance, compare leagues, and support content and betting products. This slide frames the project as professional analytics, not a toy dataset.

### What to say (~1 minute)

Walk through source → load path, then scope, then one sentence on who uses this data in industry.

---

## Slide 3 — Why I chose this dataset

### Bullets on the slide

1. Personal interest: European club soccer (Man United, then Bayern Munich)
2. Familiar domain: leagues, seasons, home/away, points, streaks, betting odds
3. Business-style questions: scoring trends, defensive strength, player development, odds vs results
4. Good mix of dimensions (country, league, team, player) and facts (matches, ratings)
5. Graduate requirement: 30 English questions mapping to real SELECT workloads

### Deep dive

**Personal narrative**  
Makes the presentation memorable and satisfies “why this project” without sounding generic.

**Domain familiarity**  
You already understand home/away, clean sheets, seasons—so English questions are easier to validate against real soccer logic.

**Dimensions vs facts (star-schema language)**  
- **Dimensions:** who/where/when context (`Country`, `League`, `Team`, `Player`).  
- **Facts:** events or measurements (`Match_tbl` goals; `Player_Attributes` ratings).  
Graders expect you to use this vocabulary.

**30 questions (grad)**  
Deliverable 3/4 require many English-to-SQL questions; soccer data supports joins, aggregates, subqueries, windows, and CASE—good exam of SQL mastery.

### What to say (~45 seconds)

Personal hook, then connect to the types of reports a front office or analyst would request.

---

## Slide 4 — ER diagram — soccer_proj

### What appears on the slide

- Full **entity-relationship diagram** image (7 base tables)
- Subtitle: “Initial and final use the same 7 tables”
- Caption: Country/League/Team/Player = who & where; Match_tbl = transactions; attributes = snapshots; views = reports

### Tables on the diagram (explain each)

| Table | Role | Key columns (conceptual) |
|-------|------|---------------------------|
| **Country** | Top geography dimension | `id` (PK), `name` |
| **League** | Competition within a country | `id` (PK), `country_id` (FK → Country), `name` |
| **Match_tbl** | Central fact: one row per match | `id`, `league_id`, `country_id`, `home_team_api_id`, `away_team_api_id`, goals, date, odds, lineups |
| **Team** | Club identity | `team_api_id` (used in matches), `team_long_name` |
| **Team_Attributes** | Team stats over time | `team_api_id`, `date`, tactical/rating columns |
| **Player** | Player identity | `player_api_id`, `player_name` |
| **Player_Attributes** | Player ratings over time | `player_api_id`, `date`, `overall_rating`, etc. |

### Arrows on the diagram

- **Solid arrows** — foreign keys enforced in PostgreSQL (e.g. `League.country_id → Country.id`, `Match_tbl.league_id → League.id`, team FKs on match).
- **Dashed arrows** — logical relationships in source data that may not be enforced as FK constraints (e.g. Country → Match direct link; Player → attributes history).

### Views (not drawn)

- **`league_match_summary_view`** — aggregates per league (match counts, avg goals).
- **`match_context_view`** — human-readable match row with country name, league name, home/away team names.

### “Initial vs final ERD”

You did not redesign into a different model; you **implemented** the planned model. Say that clearly so graders do not look for a second diagram.

### What to say (~1.5 minutes)

Walk center spine Country → League → Match_tbl; left Team stack; right Player stack; mention views sit on top for reporting.

---

## Slide 5 — Hardest part

### Bullets on the slide

1. Loading/typing: SQLite → CSV → Postgres, NULLs, column names
2. `Match_tbl` very wide — easy to get joins wrong
3. Multi-step SQL (CTEs, window functions) for streaks and lineups
4. Which FKs to enforce vs document-only (orphan keys in source)
5. Keeping 30 questions aligned with what data actually supports

### Deep dive

**Load/typing**  
SQLite is loose; PostgreSQL is strict. Dates, integers stored as text, and duplicate keys in CSV cause load failures or silent bad joins.

**Wide Match_tbl**  
Dozens of columns (bookmaker odds, many `*_player_*` lineup IDs). Easy to join on wrong team column (`team_api_id` vs `team_fifa_api_id`).

**CTEs / windows**  
Questions like unbeaten streaks need `ROW_NUMBER`, `LAG`, or grouped steps—harder than a single GROUP BY.

**FK enforcement**  
Kaggle data has orphans; enforcing every FK can block load. You may document logical links without `ALTER TABLE ... ADD CONSTRAINT`.

**Question alignment**  
A question about “coaches” fails if there is no coach table—hardest part is staying honest to the schema.

### What to say (~1 minute)

Give one concrete example (e.g. a streak query or a load error you fixed).

---

## Slide 6 — What I learned

### Bullets on the slide

1. Design first: ERD and keys before dozens of queries
2. JOIN choice (INNER vs LEFT) changes row counts—always verify
3. Views encapsulate 4–5 table joins; indexes help `Match_tbl`
4. Window functions for streaks and trends
5. Documentation + reproducible load scripts save time at deadline

### Deep dive

**Design first**  
Changing keys after 30 queries means rewriting SQL; ERD upfront is cheaper.

**INNER vs LEFT**  
INNER drops non-matching rows; LEFT keeps left table rows with NULLs on the right. Wrong choice → wrong business totals.

**Views**  
Business users should not write 5-way joins; views are the “report API.”

**Indexes (grad)**  
`Match_tbl(league_id)`, `(home_team_api_id)`, `(away_team_api_id)` speed filters and joins—tie to `EXPLAIN`.

**Window functions**  
`PARTITION BY team_id ORDER BY date` lets you compare each match to prior matches (streaks, form).

### What to say (~1 minute)

Link each bullet to a class topic (normalization, SQL, physical design).

---

## Slide 7 — SQL confidence now

### Bullets on the slide

1. Comfortable: SELECT, JOINs, GROUP BY, HAVING, subqueries, CASE
2. Comfortable creating views (`league_match_summary_view`, `match_context_view`)
3. Much more confident than start of semester; debug by counting rows
4. DBeaver + EXPLAIN for expensive plans

### Deep dive

**Debugging by row count**  
Run `COUNT(*)` after each join step; if count explodes, you have a fan-out (often bad join or missing key).

**EXPLAIN**  
Shows sequential scan vs index scan; useful for justifying indexes in write-up.

**Honest limits**  
You can say advanced topics (recursive CTEs, complex isolation) are still learning areas—credibility matters.

### What to say (~45 seconds)

Self-assessment: what you can do independently vs with reference.

---

## Slide 8 — What I would do next (more time)

### Bullets on the slide

1. Enforce more FKs after cleaning; CHECK on goals and dates
2. Materialized views / summary tables for dashboards
3. More indexes tuned with EXPLAIN on slow queries
4. Data quality report (missing lineups, duplicate IDs, odds outliers)
5. Optional BI tool (Tableau/Power BI) on views

### Deep dive

**CHECK constraints**  
e.g. `home_team_goal >= 0` prevents garbage analytics.

**Materialized views**  
Pre-aggregate season stats; refresh nightly—pattern used in production warehouses.

**Data quality**  
Real projects spend time on profiling before trusting KPIs.

**BI layer**  
Views become datasets for non-SQL stakeholders.

### What to say (~45 seconds)

Tie improvements to faster, safer business decisions.

---

## Slide 9 — DEMO: Tables + row counts

### Bullets on the slide

| Table | Rows | Relationship note |
|-------|------|-------------------|
| Country | 11 | Parent of League |
| League | 11 | `country_id` → Country; Match_tbl.league_id → League |
| Team | 299 | Appears as home/away on Match_tbl |
| Match_tbl | 25,979 | Hub table |
| **All 7 tables** | **222,796** | Total footprint |

### Deep dive

**Why demo tables live**  
Proves the database is loaded and you know the hierarchy before running analytics SQL.

**DBeaver actions**  
1. Expand `soccer_proj` schema.  
2. Right-click table → **View data** or run `SELECT COUNT(*) FROM soccer_proj."Country";`  
3. `SELECT * FROM soccer_proj."Match_tbl" LIMIT 5;` — show goals and league_id columns.

**Player_Attributes**  
Mention ~184K rows as largest table; skip opening in a short video unless time allows.

**Foreign key vocabulary**  
Say “League’s country_id is a foreign key to Country’s id” — uses class terms from the handout.

### What to say (~1 minute)

Live or rehearsed: navigator tree + one COUNT per table + quick peek at match rows.

---

## Slide 10 — DEMO: Intermediate query (Q16)

### Title / subtitle

- **DEMO: Intermediate query (Q16)**
- **Joins + GROUP BY + AVG (no CASE)**

### Question

Which countries had the highest average goals per match across all their leagues?

### SQL on the slide

```sql
SELECT c.name AS country,
  AVG((m.home_team_goal + m.away_team_goal)::numeric) AS avg_goals_per_match
FROM soccer_proj."Match_tbl" m
JOIN soccer_proj."League" l ON l.id = m.league_id
JOIN soccer_proj."Country" c ON c.id = l.country_id
GROUP BY c.name
ORDER BY avg_goals_per_match DESC;
```

### Line-by-line explanation

| Clause | What it does |
|--------|----------------|
| `FROM Match_tbl m` | Start from every match (fact). |
| `JOIN League l ON l.id = m.league_id` | Attach league metadata; **INNER** drops matches with bad league_id. |
| `JOIN Country c ON c.id = l.country_id` | Attach country name via league. |
| `home_team_goal + away_team_goal` | Total goals in that match (entertainment / scoring intensity). |
| `AVG(...)::numeric` | Average per country across all matches in all leagues in that country. |
| `GROUP BY c.name` | One output row per country. |
| `ORDER BY ... DESC` | Highest average first (Netherlands ~3.08 in your screenshot). |

### Why “intermediate”

Multi-table **INNER JOIN** + **GROUP BY** + aggregate—no subquery, no CASE, no window. Appropriate “middle” demo.

### Business tie-in

Regional comparison for media (“which markets have highest-scoring leagues?”) or competition format discussions.

### What to say (~1 minute)

Run in DBeaver tab `demo1`; point at top 3 countries in results.

---

## Slide 11 — DEMO Q16 — Query results (screenshot)

### What appears on the slide

Full **DBeaver screenshot** of `demo1` tab: SQL editor + result grid.

### Reading your results (from your run)

| Rank | Country | avg_goals_per_match (approx.) |
|------|---------|--------------------------------|
| 1 | Netherlands | 3.08 |
| 2 | Switzerland | 2.93 |
| 3 | Germany | 2.90 |
| … | … | … |
| (11 rows total) | | |

### Deep dive

**11 rows** = one per country in the dataset—matches `Country` table size.

**Sticky note (ODIN / name)**  
Course identification on screen for academic integrity.

**Schema in navigator**  
Screenshot also shows `spy` schema on localhost—that is your Homework 4 database on the same server; demo queries use **`soccer_proj`** (class project), not `spy`. For video, use the connection where `soccer_proj` is loaded (often `dbclass` or local postgres with soccer data).

### What to say (~30 seconds)

“Here are live results—Netherlands tops average goals per match across its leagues in this 2008–2016 slice.”

---

## Slide 12 — DEMO: Advanced query (Q18)

### Title / subtitle

- **DEMO: Advanced query (Q18)**
- **Join with OR + conditional aggregates**

### Question

Which teams most frequently kept clean sheets?

**Clean sheet** = match where the team conceded **0** goals (opponent scored 0 against them).

### SQL on the slide

```sql
SELECT t.team_long_name,
  SUM(CASE WHEN m.home_team_api_id = t.team_api_id AND m.away_team_goal = 0 THEN 1 ELSE 0 END
     + CASE WHEN m.away_team_api_id = t.team_api_id AND m.home_team_goal = 0 THEN 1 ELSE 0 END) AS clean_sheets
FROM soccer_proj."Team" t
JOIN soccer_proj."Match_tbl" m
  ON m.home_team_api_id = t.team_api_id OR m.away_team_api_id = t.team_api_id
GROUP BY t.team_long_name
ORDER BY clean_sheets DESC
LIMIT 30;
```

### Line-by-line explanation

| Piece | Meaning |
|-------|---------|
| `JOIN ... OR ...` | Each team row matches **every** match where they played home **or** away—required so one team sees all its games. |
| First `CASE` | Team is home AND away score is 0 → +1 clean sheet. |
| Second `CASE` | Team is away AND home score is 0 → +1 clean sheet. |
| `SUM(... + ...)` | Adds both cases per match row (only one can be 1 per match for a given team). |
| `GROUP BY team_long_name` | Total clean sheets per club. |
| `LIMIT 30` | Top 30 for readable grid / slide. |

### Why “advanced”

- **OR in JOIN** (changes cardinality—must understand fan-out; here each match links to exactly two teams).  
- **Conditional aggregation** with **CASE** inside **SUM** (defensive KPI pattern).

### Caution (for Q&A)

OR joins can duplicate rows in other patterns; here each match row pairs with one home team and one away team row from `Team` when grouped correctly.

### What to say (~1 minute)

Run `demo2`; explain clean sheet as defensive KPI.

---

## Slide 13 — DEMO Q18 — Query results (screenshot)

### What appears on the slide

DBeaver screenshot of `demo2` with top teams by `clean_sheets`.

### Reading your results (from your run)

| Rank | team_long_name | clean_sheets |
|------|----------------|--------------|
| 1 | Celtic | 153 |
| 2 | FC Barcelona | 140 |
| 3 | Manchester United | 133 |
| 4 | Juventus | 132 |
| 5 | FC Porto | 128 |
| … | … | … |

### Deep dive

High counts reflect **strong defenses** and **many matches** in the dataset window—not necessarily “best ever” without normalizing by matches played (extension you could mention in Q&A).

Celtic leading fits Scottish league sample + dominant era in data.

### What to say (~30 seconds)

Point at top 3–5 clubs; tie to scouting/tactics narrative.

---

## Slide 14 — Business applications

### Bullets on the slide

1. Club/league ops: season KPIs (goals, clean sheets, home vs away)
2. Media/broadcasting: market comparison (avg goals by country)
3. Betting/risk: odds vs outcomes in Match_tbl
4. Talent/HR analog: Player_Attributes over time like performance reviews
5. Same patterns as retail (sales by region) or finance (metrics over time)

### Deep dive

**Operations**  
Coaches and sporting directors use aggregates like your demos for tactics and squad planning.

**Media**  
High-scoring leagues → programming and narrative (“Eredivisie is high-scoring”).

**Betting**  
Match_tbl includes bookmaker columns; historical edge analysis is a real use case (with compliance caveats).

**HR analog**  
Helps non-soccer audience understand **slowly changing attributes**—same as employee skill snapshots.

**Pattern transfer**  
Star schema + fact table is industry-standard; soccer is the teaching example.

### What to say (~45 seconds)

Pick **two** bullets and connect directly to Q16 (markets) and Q18 (defense).

---

## Slide 15 — Thank you

### What appears on the slide

- Large green text: **Questions?**
- Gray subtext: **Deliverable 4 write-up + video link in submission**

### Deep dive

Remind graders:

1. **Working video URL** at top of Deliverable 4 docx/PDF.  
2. **Same link** in Canvas submission comments.  
3. Video length **~8 minutes**; you appear on camera per instructions.

### What to say (~15 seconds)

Thank the audience; repeat where to find the write-up and video.

---

## Appendix A — 8-minute timing guide

| Slide | Topic | Suggested time |
|-------|--------|----------------|
| 1 | Title | 0:30 |
| 2 | Dataset overview | 1:00 |
| 3 | Why chosen | 0:45 |
| 4 | ERD | 1:30 |
| 5 | Hardest part | 1:00 |
| 6 | What I learned | 1:00 |
| 7 | SQL confidence | 0:45 |
| 8 | What next | 0:45 |
| 9 | Demo tables | 1:00 |
| 10–11 | Q16 + results | 1:30 |
| 12–13 | Q18 + results | 1:30 |
| 14 | Business apps | 0:45 |
| 15 | Thank you | 0:15 |
| **Total** | | **~8:00** (adjust live demo vs screenshots) |

---

## Appendix B — Files related to this handout

| File | Purpose |
|------|---------|
| `Deliverable4_Presentation-emmanart.pptx` | Slide deck |
| `Deliverable4_Demo_SQL_Handout.txt` | Copy-paste SQL only |
| `Demo_Q16_Q18_Answers.txt` | Demo scripts + talking points |
| `demo_q16_results.png` / `demo_q18_results.png` | Screenshot assets embedded in pptx |
| `_build_deliverable4_pptx.py` | Regenerates deck from source |

---

## Appendix C — Grading checklist (Deliverable 4 video)

- [ ] Dataset overview + why chosen  
- [ ] ERD shown (initial → final story)  
- [ ] Demo tables + row counts  
- [ ] One **intermediate** query (Q16)  
- [ ] One **advanced** query (Q18)  
- [ ] Hardest part, learned, SQL confidence, what next  
- [ ] All presenters on camera (you)  
- [ ] ~8 minutes  
- [ ] Video link in document + submission  

---

*End of deep dive — Emmanuel Arthur, emmanart, Spring 2026.*
