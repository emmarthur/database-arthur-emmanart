CREATE SCHEMA IF NOT EXISTS "soccer_proj";

CREATE TABLE "soccer_proj"."Country" (
    "id" BIGINT,
    "name" TEXT,
    CONSTRAINT "Country_pk" PRIMARY KEY ("id")
);

CREATE TABLE "soccer_proj"."League" (
    "id" BIGINT,
    "country_id" BIGINT,
    "name" TEXT,
    CONSTRAINT "League_pk" PRIMARY KEY ("id")
);

CREATE TABLE "soccer_proj"."Match_tbl" (
    "id" BIGINT,
    "country_id" BIGINT,
    "league_id" BIGINT,
    "season" TEXT,
    "stage" BIGINT,
    "date" TEXT,
    "match_api_id" BIGINT,
    "home_team_api_id" BIGINT,
    "away_team_api_id" BIGINT,
    "home_team_goal" BIGINT,
    "away_team_goal" BIGINT,
    "home_player_X1" BIGINT,
    "home_player_X2" BIGINT,
    "home_player_X3" BIGINT,
    "home_player_X4" BIGINT,
    "home_player_X5" BIGINT,
    "home_player_X6" BIGINT,
    "home_player_X7" BIGINT,
    "home_player_X8" BIGINT,
    "home_player_X9" BIGINT,
    "home_player_X10" BIGINT,
    "home_player_X11" BIGINT,
    "away_player_X1" BIGINT,
    "away_player_X2" BIGINT,
    "away_player_X3" BIGINT,
    "away_player_X4" BIGINT,
    "away_player_X5" BIGINT,
    "away_player_X6" BIGINT,
    "away_player_X7" BIGINT,
    "away_player_X8" BIGINT,
    "away_player_X9" BIGINT,
    "away_player_X10" BIGINT,
    "away_player_X11" BIGINT,
    "home_player_Y1" BIGINT,
    "home_player_Y2" BIGINT,
    "home_player_Y3" BIGINT,
    "home_player_Y4" BIGINT,
    "home_player_Y5" BIGINT,
    "home_player_Y6" BIGINT,
    "home_player_Y7" BIGINT,
    "home_player_Y8" BIGINT,
    "home_player_Y9" BIGINT,
    "home_player_Y10" BIGINT,
    "home_player_Y11" BIGINT,
    "away_player_Y1" BIGINT,
    "away_player_Y2" BIGINT,
    "away_player_Y3" BIGINT,
    "away_player_Y4" BIGINT,
    "away_player_Y5" BIGINT,
    "away_player_Y6" BIGINT,
    "away_player_Y7" BIGINT,
    "away_player_Y8" BIGINT,
    "away_player_Y9" BIGINT,
    "away_player_Y10" BIGINT,
    "away_player_Y11" BIGINT,
    "home_player_1" BIGINT,
    "home_player_2" BIGINT,
    "home_player_3" BIGINT,
    "home_player_4" BIGINT,
    "home_player_5" BIGINT,
    "home_player_6" BIGINT,
    "home_player_7" BIGINT,
    "home_player_8" BIGINT,
    "home_player_9" BIGINT,
    "home_player_10" BIGINT,
    "home_player_11" BIGINT,
    "away_player_1" BIGINT,
    "away_player_2" BIGINT,
    "away_player_3" BIGINT,
    "away_player_4" BIGINT,
    "away_player_5" BIGINT,
    "away_player_6" BIGINT,
    "away_player_7" BIGINT,
    "away_player_8" BIGINT,
    "away_player_9" BIGINT,
    "away_player_10" BIGINT,
    "away_player_11" BIGINT,
    "goal" TEXT,
    "shoton" TEXT,
    "shotoff" TEXT,
    "foulcommit" TEXT,
    "card" TEXT,
    "cross" TEXT,
    "corner" TEXT,
    "possession" TEXT,
    "B365H" NUMERIC,
    "B365D" NUMERIC,
    "B365A" NUMERIC,
    "BWH" NUMERIC,
    "BWD" NUMERIC,
    "BWA" NUMERIC,
    "IWH" NUMERIC,
    "IWD" NUMERIC,
    "IWA" NUMERIC,
    "LBH" NUMERIC,
    "LBD" NUMERIC,
    "LBA" NUMERIC,
    "PSH" NUMERIC,
    "PSD" NUMERIC,
    "PSA" NUMERIC,
    "WHH" NUMERIC,
    "WHD" NUMERIC,
    "WHA" NUMERIC,
    "SJH" NUMERIC,
    "SJD" NUMERIC,
    "SJA" NUMERIC,
    "VCH" NUMERIC,
    "VCD" NUMERIC,
    "VCA" NUMERIC,
    "GBH" NUMERIC,
    "GBD" NUMERIC,
    "GBA" NUMERIC,
    "BSH" NUMERIC,
    "BSD" NUMERIC,
    "BSA" NUMERIC,
    CONSTRAINT "Match_tbl_pk" PRIMARY KEY ("id")
);

CREATE TABLE "soccer_proj"."Player" (
    "id" BIGINT,
    "player_api_id" BIGINT,
    "player_name" TEXT,
    "player_fifa_api_id" BIGINT,
    "birthday" TEXT,
    "height" BIGINT,
    "weight" BIGINT,
    CONSTRAINT "Player_pk" PRIMARY KEY ("id")
);

CREATE TABLE "soccer_proj"."Player_Attributes" (
    "id" BIGINT,
    "player_fifa_api_id" BIGINT,
    "player_api_id" BIGINT,
    "date" TEXT,
    "overall_rating" BIGINT,
    "potential" BIGINT,
    "preferred_foot" TEXT,
    "attacking_work_rate" TEXT,
    "defensive_work_rate" TEXT,
    "crossing" BIGINT,
    "finishing" BIGINT,
    "heading_accuracy" BIGINT,
    "short_passing" BIGINT,
    "volleys" BIGINT,
    "dribbling" BIGINT,
    "curve" BIGINT,
    "free_kick_accuracy" BIGINT,
    "long_passing" BIGINT,
    "ball_control" BIGINT,
    "acceleration" BIGINT,
    "sprint_speed" BIGINT,
    "agility" BIGINT,
    "reactions" BIGINT,
    "balance" BIGINT,
    "shot_power" BIGINT,
    "jumping" BIGINT,
    "stamina" BIGINT,
    "strength" BIGINT,
    "long_shots" BIGINT,
    "aggression" BIGINT,
    "interceptions" BIGINT,
    "positioning" BIGINT,
    "vision" BIGINT,
    "penalties" BIGINT,
    "marking" BIGINT,
    "standing_tackle" BIGINT,
    "sliding_tackle" BIGINT,
    "gk_diving" BIGINT,
    "gk_handling" BIGINT,
    "gk_kicking" BIGINT,
    "gk_positioning" BIGINT,
    "gk_reflexes" BIGINT,
    CONSTRAINT "Player_Attributes_pk" PRIMARY KEY ("id")
);

CREATE TABLE "soccer_proj"."Team" (
    "id" BIGINT,
    "team_api_id" BIGINT,
    "team_fifa_api_id" BIGINT,
    "team_long_name" TEXT,
    "team_short_name" TEXT,
    CONSTRAINT "Team_pk" PRIMARY KEY ("id")
);

CREATE TABLE "soccer_proj"."Team_Attributes" (
    "id" BIGINT,
    "team_fifa_api_id" BIGINT,
    "team_api_id" BIGINT,
    "date" TEXT,
    "buildUpPlaySpeed" BIGINT,
    "buildUpPlaySpeedClass" TEXT,
    "buildUpPlayDribbling" BIGINT,
    "buildUpPlayDribblingClass" TEXT,
    "buildUpPlayPassing" BIGINT,
    "buildUpPlayPassingClass" TEXT,
    "buildUpPlayPositioningClass" TEXT,
    "chanceCreationPassing" BIGINT,
    "chanceCreationPassingClass" TEXT,
    "chanceCreationCrossing" BIGINT,
    "chanceCreationCrossingClass" TEXT,
    "chanceCreationShooting" BIGINT,
    "chanceCreationShootingClass" TEXT,
    "chanceCreationPositioningClass" TEXT,
    "defencePressure" BIGINT,
    "defencePressureClass" TEXT,
    "defenceAggression" BIGINT,
    "defenceAggressionClass" TEXT,
    "defenceTeamWidth" BIGINT,
    "defenceTeamWidthClass" TEXT,
    "defenceDefenderLineClass" TEXT,
    CONSTRAINT "Team_Attributes_pk" PRIMARY KEY ("id")
);

ALTER TABLE "soccer_proj"."League" ADD CONSTRAINT "League_fk_0" FOREIGN KEY ("country_id") REFERENCES "soccer_proj"."Country" ("id");
ALTER TABLE "soccer_proj"."Match_tbl" ADD CONSTRAINT "Match_tbl_fk_0" FOREIGN KEY ("away_player_11") REFERENCES "soccer_proj"."Player" ("player_api_id");
ALTER TABLE "soccer_proj"."Match_tbl" ADD CONSTRAINT "Match_tbl_fk_1" FOREIGN KEY ("away_player_10") REFERENCES "soccer_proj"."Player" ("player_api_id");
ALTER TABLE "soccer_proj"."Match_tbl" ADD CONSTRAINT "Match_tbl_fk_2" FOREIGN KEY ("away_player_9") REFERENCES "soccer_proj"."Player" ("player_api_id");
ALTER TABLE "soccer_proj"."Match_tbl" ADD CONSTRAINT "Match_tbl_fk_3" FOREIGN KEY ("away_player_8") REFERENCES "soccer_proj"."Player" ("player_api_id");
ALTER TABLE "soccer_proj"."Match_tbl" ADD CONSTRAINT "Match_tbl_fk_4" FOREIGN KEY ("away_player_7") REFERENCES "soccer_proj"."Player" ("player_api_id");
ALTER TABLE "soccer_proj"."Match_tbl" ADD CONSTRAINT "Match_tbl_fk_5" FOREIGN KEY ("away_player_6") REFERENCES "soccer_proj"."Player" ("player_api_id");
ALTER TABLE "soccer_proj"."Match_tbl" ADD CONSTRAINT "Match_tbl_fk_6" FOREIGN KEY ("away_player_5") REFERENCES "soccer_proj"."Player" ("player_api_id");
ALTER TABLE "soccer_proj"."Match_tbl" ADD CONSTRAINT "Match_tbl_fk_7" FOREIGN KEY ("away_player_4") REFERENCES "soccer_proj"."Player" ("player_api_id");
ALTER TABLE "soccer_proj"."Match_tbl" ADD CONSTRAINT "Match_tbl_fk_8" FOREIGN KEY ("away_player_3") REFERENCES "soccer_proj"."Player" ("player_api_id");
ALTER TABLE "soccer_proj"."Match_tbl" ADD CONSTRAINT "Match_tbl_fk_9" FOREIGN KEY ("away_player_2") REFERENCES "soccer_proj"."Player" ("player_api_id");
ALTER TABLE "soccer_proj"."Match_tbl" ADD CONSTRAINT "Match_tbl_fk_10" FOREIGN KEY ("away_player_1") REFERENCES "soccer_proj"."Player" ("player_api_id");
ALTER TABLE "soccer_proj"."Match_tbl" ADD CONSTRAINT "Match_tbl_fk_11" FOREIGN KEY ("home_player_11") REFERENCES "soccer_proj"."Player" ("player_api_id");
ALTER TABLE "soccer_proj"."Match_tbl" ADD CONSTRAINT "Match_tbl_fk_12" FOREIGN KEY ("home_player_10") REFERENCES "soccer_proj"."Player" ("player_api_id");
ALTER TABLE "soccer_proj"."Match_tbl" ADD CONSTRAINT "Match_tbl_fk_13" FOREIGN KEY ("home_player_9") REFERENCES "soccer_proj"."Player" ("player_api_id");
ALTER TABLE "soccer_proj"."Match_tbl" ADD CONSTRAINT "Match_tbl_fk_14" FOREIGN KEY ("home_player_8") REFERENCES "soccer_proj"."Player" ("player_api_id");
ALTER TABLE "soccer_proj"."Match_tbl" ADD CONSTRAINT "Match_tbl_fk_15" FOREIGN KEY ("home_player_7") REFERENCES "soccer_proj"."Player" ("player_api_id");
ALTER TABLE "soccer_proj"."Match_tbl" ADD CONSTRAINT "Match_tbl_fk_16" FOREIGN KEY ("home_player_6") REFERENCES "soccer_proj"."Player" ("player_api_id");
ALTER TABLE "soccer_proj"."Match_tbl" ADD CONSTRAINT "Match_tbl_fk_17" FOREIGN KEY ("home_player_5") REFERENCES "soccer_proj"."Player" ("player_api_id");
ALTER TABLE "soccer_proj"."Match_tbl" ADD CONSTRAINT "Match_tbl_fk_18" FOREIGN KEY ("home_player_4") REFERENCES "soccer_proj"."Player" ("player_api_id");
ALTER TABLE "soccer_proj"."Match_tbl" ADD CONSTRAINT "Match_tbl_fk_19" FOREIGN KEY ("home_player_3") REFERENCES "soccer_proj"."Player" ("player_api_id");
ALTER TABLE "soccer_proj"."Match_tbl" ADD CONSTRAINT "Match_tbl_fk_20" FOREIGN KEY ("home_player_2") REFERENCES "soccer_proj"."Player" ("player_api_id");
ALTER TABLE "soccer_proj"."Match_tbl" ADD CONSTRAINT "Match_tbl_fk_21" FOREIGN KEY ("home_player_1") REFERENCES "soccer_proj"."Player" ("player_api_id");
ALTER TABLE "soccer_proj"."Match_tbl" ADD CONSTRAINT "Match_tbl_fk_22" FOREIGN KEY ("away_team_api_id") REFERENCES "soccer_proj"."Team" ("team_api_id");
ALTER TABLE "soccer_proj"."Match_tbl" ADD CONSTRAINT "Match_tbl_fk_23" FOREIGN KEY ("home_team_api_id") REFERENCES "soccer_proj"."Team" ("team_api_id");
ALTER TABLE "soccer_proj"."Match_tbl" ADD CONSTRAINT "Match_tbl_fk_24" FOREIGN KEY ("league_id") REFERENCES "soccer_proj"."League" ("id");
ALTER TABLE "soccer_proj"."Match_tbl" ADD CONSTRAINT "Match_tbl_fk_25" FOREIGN KEY ("country_id") REFERENCES "soccer_proj"."Country" ("id");
ALTER TABLE "soccer_proj"."Player_Attributes" ADD CONSTRAINT "Player_Attributes_fk_0" FOREIGN KEY ("player_api_id") REFERENCES "soccer_proj"."Player" ("player_api_id");
ALTER TABLE "soccer_proj"."Player_Attributes" ADD CONSTRAINT "Player_Attributes_fk_1" FOREIGN KEY ("player_fifa_api_id") REFERENCES "soccer_proj"."Player" ("player_fifa_api_id");
ALTER TABLE "soccer_proj"."Team_Attributes" ADD CONSTRAINT "Team_Attributes_fk_0" FOREIGN KEY ("team_api_id") REFERENCES "soccer_proj"."Team" ("team_api_id");
ALTER TABLE "soccer_proj"."Team_Attributes" ADD CONSTRAINT "Team_Attributes_fk_1" FOREIGN KEY ("team_fifa_api_id") REFERENCES "soccer_proj"."Team" ("team_fifa_api_id");
