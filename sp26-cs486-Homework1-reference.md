# CS 486/586 — Homework 1 (reference)

Extracted from `sp26-cs486-Homework1.docx.pdf` for quick lookup. **Submit answers in the official PDF/DOC per course instructions.**

## Submission & format

- **Group:** Table on page 1 — each member + sections completed. **Each member submits their own copy**; submissions should be **identical** across the group.
- **Answers:** Edit the homework document; answer **immediately below each question**, **same order** as questions.
- **Screenshots (where required):** Show **column names**, **required row count**, and **full query result pane** (not cropped values only).
- **Tech:** **PostgreSQL** only; **DBeaver** / **psql** recommended (other dialects may get no credit).
- **Dataset:** Yelp donut sample (2023) — course use only; do not redistribute.
- **Points:** **5 points per question**. **Q1–2 are “free” points** if done correctly (no screenshots).

## Lab / data (you completed loading)

1. **Schema creation** — Run **`Lab1-tables.sql`** (schema + table). *No screenshot.*
2. **Data loading** — Run **`Lab1-data.sql`** (~5,000 rows). *No screenshot.*  
   - Notes: DBeaver ~50s off-campus possible; DataGrip may hang; **`psql -f`** on ada path `~rchaney/Classes/cs486/Labs/Lab1` also listed.

## Questions (remaining work for the write-up)

### Q3 — Data validation
- SQL: `SELECT COUNT(*) FROM yelp_donut.donut_data;` (expect 5,000).
- Include **query + screenshot**.

### Q4 — First 10 rows
- `SELECT * … LIMIT 10` — **no `ORDER BY`**.
- **Query + screenshot** (10 rows).

### Q5 — Order by county
- Modify Q4: **sort by county**.
- **Query + screenshot** (first 10 rows).
- **Short answer:** What seems odd about the **first row** vs how counties are usually named/ordered?

### Q6 — `OFFSET`
- Modify Q5: **skip first 1,000 rows** with **`OFFSET`**; still show 10 rows (typically `LIMIT 10`).
- **Query + screenshot** (10 rows).
- **Answer in format:**  
  `City: ___`  
  `County: ___`  
  **Where is A J’s Donuts located?**

### Q7–13 — Column subset
For **Q7–13 only**, return **only:**  
`name, city, county, state, country, rating, review_count, price_indicator`

| # | Task |
|---|------|
| **7** | Donut shops in **Oregon**. Query + screenshot (**first 5 rows**). |
| **8** | Oregon shops with **most reviews** — sort by `review_count`. Query + screenshot (first 5). |
| **9** | Modify Q8: Oregon shops with **fewest** reviews. Query + screenshot (first 5). |
| **10** | Modify Q8: Oregon, **at least 100** reviews. Query + screenshot (first 5). |
| **11** | Modify Q10: Oregon, **highest rating** among those. Query + screenshot (first 5). |
| **12** | City name **Portland** (any state). **Do not order.** Query + screenshot (first 5). |
| **13** | **Portland, Oregon** only. **Do not order.** Query + screenshot (first 5). |

### Q14–16 — Column changes

| # | Task |
|---|------|
| **14** | **Distinct** states with donut shops; **order by state**. Query + screenshot (**first 5 rows**). |
| **15** | Modify Q14: distinct states that have a shop in a city named **Portland**. Query + screenshot (**all** results per doc). |
| **16** | Columns **`name, city, liked_by_vegans`** only — **Portland, Oregon**, **liked by vegans**. Query + screenshot (results). |

### Q17–23 — “Final queries” column set
For **Q17–20 and 22**, use again:  
`name, city, county, state, country, rating, review_count, price_indicator`

| # | Task |
|---|------|
| **17** | **Highest rating** donut shop in **Oregon**. Query + screenshot (first 5). |
| **18** | Modify Q17: **nationwide**, rating **= 5**; **order by state, city**. Query + screenshot (first 5). |
| **19** | Modify Q18: **how many** shops have rating 5 — use **`COUNT()`**. Query + screenshot. |
| **20** | Modify Q17: **California**, name begins with **`'Co'`**. Query + screenshot (first 5). |
| **21** | Modify Q20: name begins with **`'co'`** (lowercase). Query + screenshot. |
| **22** | Modify Q21: begins with **`'co'`** in **any capitalization**. Query + screenshot (first 5). |
| **23** | Oregon shops whose **name** contains **`'donut'`** (any capitalization) **anywhere** in the name. Query + screenshot (results). |

---

## Your progress (from chat)

- **Parts 1–2 (Q1–2):** Schema + ~5k rows loaded successfully (e.g. via merged `Lab1-data-1.sql` + DBeaver script execution).
- **Still to do for submission:** **Q3–23** — write SQL in DBeaver/psql, paste queries + screenshots + written answers where required into the **official homework document**.
