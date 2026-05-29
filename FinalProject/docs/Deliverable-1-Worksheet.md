# Deliverable 1 — Worksheet (Graduate)

**Course:** Final Project  
**Student level:** Graduate (individual)

**Selected dataset (your choice):** **European Soccer Database** (Kaggle)  
**Data source link (for instructor):** [https://www.kaggle.com/datasets/hugomathien/soccer](https://www.kaggle.com/datasets/hugomathien/soccer)

Use the sections below for your submission. Replace the placeholders with your own writing.

---

## Deliverable 1

### 1.1. Subject area selection

**Requirement (from syllabus):** Select a subject area on which you wish to build a database. Write **one or two paragraphs** that give a general description / background information on that subject area.

**Your response:**

The subject area I wish to build a database around is European soccer. I have personally been following European club soccer since I was 7 years old, supporting Manchester United for England and then switching to Bayern Munich in 2011, which I still support to this day.

Over recent years, a lot of data has been gathered from club soccer. At first, the basics were what you would see on a typical league table and in match summaries: goals scored by each team, fouls, and yellow or red cards. League tables were mainly points, wins, and losses. More recently, leagues and analysts rely on richer metrics—goal difference to break ties in points, home versus away records, cards accumulated over a season, goals per game for top scorers, and similar statistics.

### 1.2. Plain-English questions (graduate)

**Requirement (from syllabus):** For **Grad:** Go through your dataset and submit your **30 questions in Plain English** that you can generate from the dataset.

**Additional instructions (from syllabus):** These English questions should reflect **realistic** questions that someone might ask about the domain. You will translate the questions from this part into queries of the project data. You are **permitted to revise** these questions later if needed. It is difficult to predict what questions you will be able to answer until later in the project, but this is a **starting point**.

**Your 30 questions:**

1. Which league had the highest average total goals per match (home + away) in each season?
2. Which teams earned the most home wins in each season?
3. Which teams earned the most away wins in each season?
4. Which teams had the best overall goal difference in each season?
5. Which teams had the highest average goals scored per match across all matches in a given season?
6. Which teams had the lowest average goals conceded per match in a given season?
7. Which match had the largest goal margin in the dataset, and which teams were involved?
8. How many matches in each league ended in a draw each season?
9. Which league had the highest percentage of home-team wins by season?
10. Which teams had the longest unbeaten streak (win or draw) within a season?
11. Which teams improved the most from one season to the next based on total points?
12. Which teams had the biggest difference between home performance and away performance?
13. For each league and season, what was the average betting odds implied probability for home wins, draws, and away wins?
14. How often did the bookmaker favorite (lowest odds) actually win the match?
15. Which matches had the largest disagreement between different bookmakers on the likely winner?
16. Which countries had the highest average goals per match across all their leagues?
17. Which stages (round numbers) in each league had the highest average number of goals?
18. Which teams most frequently kept clean sheets (conceded zero goals)?
19. Which teams most frequently failed to score in a match?
20. Which players appeared most often in starting lineups across all recorded matches?
21. Which players had the highest average overall_rating in Player_Attributes across their recorded dates?
22. Which players showed the largest increase in overall_rating over time?
23. Do players with higher overall_rating also tend to have higher potential, and by how much on average?
24. Which teams had the highest average player overall_rating in their starting XI for each season?
25. Which positions (based on lineup slot fields) are associated with the highest-rated players on average?
26. Which teams had the most aggressive defensive profiles based on Team_Attributes defenceAggression and defencePressure?
27. How did team tactical style (buildUpPlaySpeedClass, chanceCreationCrossingClass, defenceDefenderLineClass) relate to average goals scored and conceded?
28. Which teams changed tactical attributes the most over time, and did those changes correlate with better results?
29. In matches where possession data exists, how strongly does possession share correlate with match outcomes and goal difference?
30. Which leagues and seasons contain the highest proportion of matches with complete advanced event fields (goal, shoton, shotoff, foulcommit, card, possession) available?

---

### 1.3. Data source and ingestion

**Requirement (from syllabus):** Describe what source you intend to use for data, and how you intend to ingest the data into your database. You should choose a subject area where you can **easily get several hundred rows** of data. This should be written as **another paragraph** (you may use more than one paragraph if needed) and should include **specific details**, such as the **website or organization** where you will find the data and the **format** of the data. **Include a link** to your data source so the instructor can browse it too.

**Reminder (from syllabus):** You do not want to get to week 10 and then “discover” that you cannot find the data or cannot load it. If you cannot find available data, it is likely time for you to change subject areas.

**Your response:**

I’m planning to use the **European Soccer Database** on **Kaggle** as my main source. Here’s the link so you can browse the same page I’m using: [https://www.kaggle.com/datasets/hugomathien/soccer](https://www.kaggle.com/datasets/hugomathien/soccer). Kaggle hosts the files; the dataset page describes what’s inside and who originally pulled it together. When you download it, you get a zip with a **SQLite** database in it (basically one file—something like `database.sqlite`—with all the tables already there). It’s not CSV, but that’s fine because there are way more than “several hundred” rows—we’re talking tens of thousands of matches and players, so I’m not worried about having enough data for the grad requirements.

For actually getting it into *my* project database, I’m going to use **DBeaver**, since that’s what I’m already using for class stuff. My first step is to open that SQLite file in DBeaver and click through the tables so I understand what’s in each one and what I can ask in my English questions. Longer term, I’m planning to build the real project in **PostgreSQL**, because the graduate rubric expects things like materialized views and stored procedures, and Postgres is a much better fit for that than staying in SQLite forever. So the workflow I have in mind is: explore in DBeaver off the Kaggle SQLite file, then create my schema in Postgres and load the data over (using whatever import or transfer approach ends up being cleanest once I’m at that stage).

---

## Checklist before you submit Deliverable 1

- [ ] **1.1** — At least one solid paragraph; two if needed for context.
- [ ] **1.2** — Exactly **30** plain-English questions, domain-realistic.
- [ ] **1.3** — Source named, **format** stated, **ingestion** steps clear, **working link** to Kaggle dataset page.
- [ ] Filename / upload matches your instructor’s naming convention (if any).
