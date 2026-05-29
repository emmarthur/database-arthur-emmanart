# PostgreSQL Soccer Database Setup (DBeaver)

This guide documents how to build a PostgreSQL version of a soccer dataset in DBeaver for Final Project Deliverable 2.

## What we already did (your current state)

We already converted your SQLite source into PostgreSQL migration artifacts:

- Source SQLite file: `FinalProject/soccer_data/database.sqlite`
- Generated schema SQL: `FinalProject/soccer_data/migration_artifacts/postgres_schema.sql`
- Generated table CSVs: `FinalProject/soccer_data/migration_artifacts/csv`
- Generated row-count summary: `FinalProject/soccer_data/migration_artifacts/migration_summary.txt`
- Helper script used: `FinalProject/scripts/sqlite_to_postgres_prep.py`

Current dataset totals from the summary:

- `Country`: 11
- `League`: 11
- `Match`: 25,979
- `Player`: 11,060
- `Player_Attributes`: 183,978
- `Team`: 299
- `Team_Attributes`: 1,458

## How you originally opened/created SQLite in DBeaver

If you forget again, use this exact flow:

1. Open DBeaver -> **Database** -> **New Database Connection**
2. Search and select **SQLite**
3. For database/file path, browse to  
   `FinalProject/soccer_data/database.sqlite` (from repo root)
4. Click **Test Connection** (download driver if prompted)
5. Click **Finish**

That creates a SQLite connection in DBeaver pointing directly to the `.sqlite` file.

## Fastest path for your existing `database.sqlite`

Since your source is already SQLite, use this two-step flow:

1) Generate PostgreSQL-ready artifacts from SQLite  
2) Import into PostgreSQL with DBeaver

I prepared this helper script for you:

- `FinalProject/scripts/sqlite_to_postgres_prep.py`

Run it from PowerShell:

```powershell
python FinalProject/scripts/sqlite_to_postgres_prep.py `
  --sqlite FinalProject/soccer_data/database.sqlite `
  --out-dir FinalProject/soccer_data/migration_artifacts `
  --schema soccer_proj
```

This creates:

- `soccer_data/migration_artifacts/postgres_schema.sql` (table + FK DDL)
- `soccer_data/migration_artifacts/csv/*.csv` (one CSV per table)
- `soccer_data/migration_artifacts/migration_summary.txt` (row counts)

## 1) Create a project schema

Run:

```sql
create schema if not exists soccer_proj;
```

Use this schema for all project tables and views.

## 2) Create core relational tables

Use a 6-10 table design. A solid starting set:

- `soccer_proj.teams`
- `soccer_proj.players`
- `soccer_proj.competitions`
- `soccer_proj.stadiums`
- `soccer_proj.matches`
- `soccer_proj.referees` (optional)
- `soccer_proj.player_match_stats` (recommended junction/fact table)
- `soccer_proj.team_match_stats` (optional)

Start with parent tables first, then dependent tables with foreign keys.

### Example starter SQL

```sql
create table soccer_proj.teams (
  team_id bigint generated always as identity primary key,
  team_name text not null unique,
  country text not null
);

create table soccer_proj.players (
  player_id bigint generated always as identity primary key,
  team_id bigint references soccer_proj.teams(team_id),
  first_name text not null,
  last_name text not null,
  position text not null,
  shirt_number int check (shirt_number between 1 and 99)
);

create table soccer_proj.competitions (
  competition_id bigint generated always as identity primary key,
  competition_name text not null unique,
  season text not null
);

create table soccer_proj.stadiums (
  stadium_id bigint generated always as identity primary key,
  stadium_name text not null unique,
  city text not null,
  capacity int check (capacity > 0)
);

create table soccer_proj.matches (
  match_id bigint generated always as identity primary key,
  competition_id bigint not null references soccer_proj.competitions(competition_id),
  home_team_id bigint not null references soccer_proj.teams(team_id),
  away_team_id bigint not null references soccer_proj.teams(team_id),
  stadium_id bigint references soccer_proj.stadiums(stadium_id),
  match_date date not null,
  home_goals int not null check (home_goals >= 0),
  away_goals int not null check (away_goals >= 0),
  constraint chk_home_away_diff check (home_team_id <> away_team_id)
);
```

## 3) Create tables from generated SQL

In DBeaver (connected to PostgreSQL):

1. Open `postgres_schema.sql`
2. Run the script
3. Refresh `soccer_proj` schema

If any FK fails because of data-quality issues, comment out FK `ALTER TABLE ... ADD CONSTRAINT` lines first, load data, then add only the FK constraints you need for deliverable evidence.

## 4) Import dataset CSV files in DBeaver

For each table:

1. Right-click table -> **Import Data**
2. Choose CSV (or source file format)
3. Use files from `soccer_data/migration_artifacts/csv`
4. Map columns carefully
5. Confirm type conversions (date, integer, numeric)
6. Run import

## 5) Load data in dependency order

Recommended order:

1. `teams`
2. `competitions`
3. `stadiums`
4. `players`
5. `matches`
6. stats/junction tables

This avoids foreign key insertion errors.

## 6) Create at least one required view

```sql
create or replace view soccer_proj.match_results_view as
select
  m.match_id,
  c.competition_name,
  ht.team_name as home_team,
  at.team_name as away_team,
  m.home_goals,
  m.away_goals,
  m.match_date
from soccer_proj.matches m
join soccer_proj.competitions c
  on c.competition_id = m.competition_id
join soccer_proj.teams ht
  on ht.team_id = m.home_team_id
join soccer_proj.teams at
  on at.team_id = m.away_team_id;
```

## 7) Build Deliverable 2 evidence

For Deliverable 2 submission, include:

- ER diagram
- relational schema with PK, UNIQUE, FK
- proof that at least one table was created and at least one row inserted
- 5 sample rows from each table and each view
- row counts

### Example row-count query

```sql
select 'teams' as table_name, count(*) as row_count from soccer_proj.teams
union all
select 'players', count(*) from soccer_proj.players
union all
select 'competitions', count(*) from soccer_proj.competitions
union all
select 'stadiums', count(*) from soccer_proj.stadiums
union all
select 'matches', count(*) from soccer_proj.matches
union all
select 'match_results_view', count(*) from soccer_proj.match_results_view;
```

## 8) Target scale requirement

- Undergrad: at least 1,000 total rows across all project tables
- Grad: at least 10,000 total rows

## 9) Practical checklist

- [ ] New schema created (`soccer_proj`)
- [ ] 6-10 normalized tables created
- [ ] PK/UNIQUE/FK constraints added
- [ ] At least 1 view created
- [ ] Real data loaded
- [ ] 5 sample rows shown per table/view
- [ ] Row counts collected
- [ ] ERD exported for submission

