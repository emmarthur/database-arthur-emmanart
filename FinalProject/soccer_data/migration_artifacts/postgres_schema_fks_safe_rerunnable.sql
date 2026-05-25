DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_constraint c
        JOIN pg_class t ON t.oid = c.conrelid
        JOIN pg_namespace n ON n.oid = t.relnamespace
        WHERE c.conname = 'Match_tbl_fk_22'
          AND n.nspname = 'soccer_proj'
          AND t.relname = 'Match_tbl'
    ) THEN
        ALTER TABLE "soccer_proj"."Match_tbl" ADD CONSTRAINT "Match_tbl_fk_22" FOREIGN KEY ("away_team_api_id") REFERENCES "soccer_proj"."Team" ("team_api_id");
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_constraint c
        JOIN pg_class t ON t.oid = c.conrelid
        JOIN pg_namespace n ON n.oid = t.relnamespace
        WHERE c.conname = 'Match_tbl_fk_23'
          AND n.nspname = 'soccer_proj'
          AND t.relname = 'Match_tbl'
    ) THEN
        ALTER TABLE "soccer_proj"."Match_tbl" ADD CONSTRAINT "Match_tbl_fk_23" FOREIGN KEY ("home_team_api_id") REFERENCES "soccer_proj"."Team" ("team_api_id");
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_constraint c
        JOIN pg_class t ON t.oid = c.conrelid
        JOIN pg_namespace n ON n.oid = t.relnamespace
        WHERE c.conname = 'Match_tbl_fk_24'
          AND n.nspname = 'soccer_proj'
          AND t.relname = 'Match_tbl'
    ) THEN
        ALTER TABLE "soccer_proj"."Match_tbl" ADD CONSTRAINT "Match_tbl_fk_24" FOREIGN KEY ("league_id") REFERENCES "soccer_proj"."League" ("id");
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_constraint c
        JOIN pg_class t ON t.oid = c.conrelid
        JOIN pg_namespace n ON n.oid = t.relnamespace
        WHERE c.conname = 'Team_Attributes_fk_0'
          AND n.nspname = 'soccer_proj'
          AND t.relname = 'Team_Attributes'
    ) THEN
        ALTER TABLE "soccer_proj"."Team_Attributes" ADD CONSTRAINT "Team_Attributes_fk_0" FOREIGN KEY ("team_api_id") REFERENCES "soccer_proj"."Team" ("team_api_id");
    END IF;
END $$;
