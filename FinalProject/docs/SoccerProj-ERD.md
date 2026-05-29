# Soccer Project ER Diagram (`soccer_proj`)

Use this Mermaid ERD in your Deliverable 2 doc (or export screenshot from a Mermaid preview).

```mermaid
erDiagram
    Country {
        BIGINT id PK
        TEXT name
    }

    League {
        BIGINT id PK
        BIGINT country_id
        TEXT name
    }

    Team {
        BIGINT id PK
        BIGINT team_api_id UK
        BIGINT team_fifa_api_id
        TEXT team_long_name
        TEXT team_short_name
    }

    Team_Attributes {
        BIGINT id PK
        BIGINT team_fifa_api_id
        BIGINT team_api_id
        TEXT date
        TEXT buildUpPlaySpeedClass
        TEXT chanceCreationPassingClass
        TEXT defenceDefenderLineClass
    }

    Player {
        BIGINT id PK
        BIGINT player_api_id
        BIGINT player_fifa_api_id UK
        TEXT player_name
        TEXT birthday
    }

    Player_Attributes {
        BIGINT id PK
        BIGINT player_fifa_api_id
        BIGINT player_api_id
        TEXT date
        BIGINT overall_rating
        BIGINT potential
    }

    Match_tbl {
        BIGINT id PK
        BIGINT country_id
        BIGINT league_id FK
        BIGINT match_api_id UK
        BIGINT home_team_api_id FK
        BIGINT away_team_api_id FK
        BIGINT home_team_goal
        BIGINT away_team_goal
        TEXT date
    }

    League ||--o{ Match_tbl : "id = league_id"
    Team ||--o{ Match_tbl : "team_api_id = home_team_api_id"
    Team ||--o{ Match_tbl : "team_api_id = away_team_api_id"
    Team ||--o{ Team_Attributes : "team_api_id = team_api_id"

    %% Optional logical links from source data (not enforced FK in Postgres):
    %% Country ||--o{ League : "id = country_id"
    %% Country ||--o{ Match_tbl : "id = country_id"
    %% Player ||--o{ Player_Attributes : "player_fifa_api_id = player_fifa_api_id"
```

## Notes for Deliverable 2 text

- Enforced foreign keys are shown as solid relationships in the diagram.
- Some source relationships were left as logical-only due orphan values in source data during migration.
