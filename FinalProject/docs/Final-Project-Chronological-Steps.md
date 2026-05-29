# Final Project — Chronological Steps (Graduate)

This checklist follows the course overview for **graduate students**: verify data **before** you are stuck late in the term, then design → load → query → document → present.

**Graduate rules (from the overview):** You complete the project **individually** (no group option).

---

## Before you start (once)

1. **Work solo** — You are a **graduate student**, so you complete the project **individually** by course rule (undergraduates may form groups; you do not). The final video is still **8 minutes** as specified in the syllabus.

2. **Know your graduate targets**  
   - **Tables:** about **6–10** after normalization; at least **one view** (that view must **join ≥ 4 tables** in the final project).  
   - **Rows (total across all tables):** ≥ **10,000**.  
   - **English questions (Deliverable 1):** **30** in Plain English.  
   - **Final SQL questions + solutions:** **40**, with this mix:  
     - **10** basic (filters, sorts, joins)  
     - **15** intermediate (GROUP BY/HAVING, multi-joins, subqueries, **1 view** among your requirements)  
     - **15** advanced (CTEs, subqueries, more views if needed, **materialized views**, **query tuning / indexing**, **stored procedures/functions** as appropriate)  
   - **Constraints beyond PK/FK:** at least **3** (e.g. CHECK, UNIQUE, NOT NULL where appropriate).

3. **Pick a dataset that fits the rules**  
   - Public, **citable**, with a **link** you will submit.  
   - Complex enough for **multi-table** questions (not a single wide table).  
   - **Prove early** you can download/load it at **graduate scale** (format, size, keys to link tables).

---

## Phase A — Deliverable 1 (subject, questions, data plan)

4. **Choose the subject area** and write **1–2 paragraphs** of background (Deliverable **1.1**).

5. **Draft 30 Plain-English questions** from the dataset (Deliverable **1.2**).  
   - Make them realistic for the domain; you may revise later after loading data (you will document changes in Deliverable 4).

6. **Data source and ingestion plan** (Deliverable **1.3**): one or more paragraphs — where the data lives, **format**, how you will load it, and the **URL**.  
   - If you cannot get real data at **~10k+ rows**, **change topics** before you invest more time.

7. **Start a short data dictionary** (required overall): what each planned table means and what key fields mean. Refine it when the schema stabilizes.

---

## Phase B — Deliverable 2 (design and database setup)

8. **Conceptual modeling** — Sketch messy reality, then refine toward **6–10 tables** and relationships.

9. **ER diagram** for your domain (Deliverable **2.1**).

10. **Relational schema** from the ERD: all **PKs, unique keys, FKs**, plus **≥ 3** constraints beyond PK/FK (CHECK, UNIQUE, NOT NULL, etc.) in the design/DDL.

11. **Create a dedicated schema** for the project and **implement tables** in the DB.

12. **Early evidence (required):** at least **one** table created and populated with **at least one row** (submit as instructed).

13. **Load real data** (Deliverable **2.2**); avoid mocking everything.  
    - **Total row count** across all tables: **≥ 10,000**.  
    - Capture **5 sample rows per table and per view** and **row counts** (reuse in Deliverable 4).

14. **Define at least one view**; ensure the required view **joins ≥ 4 tables**. Plan **materialized views** and **indexes** early if they support your advanced queries and writeup.

---

## Phase C — Deliverable 3 (SQL + complexity)

15. **Translate English questions to SQL** (Deliverable **3.1**) until you have **40** questions with solutions.  
    - If you replace a question, **document original → new** and **why** (repeat in Deliverable 4).

16. **Check query depth** (Deliverable **3.2**):  
    - **Many** queries should use **multiple tables**.  
    - Expect **4–6 table joins** for typical project answers.  
    - Avoid a final set that is only simple single-table selects.

17. **Meet the graduate query mix:** **10 basic / 15 intermediate / 15 advanced**, including CTEs, additional views/materialized views as needed, **indexing and tuning**, and **stored procedures/functions** where they fit the project.

18. **Indexes:** implement indexes for tuning and constraints as needed; you will list all **`CREATE INDEX`** statements in Deliverable 4.

---

## Phase D — Deliverable 4 (final writeup)

Assemble one cohesive submission that **accumulates** prior work:

19. **4.1.1** — Final **ER diagram** (as implemented).

20. **4.1.2** — All **`CREATE TABLE`** statements (PK, unique, FK, and **non–PK/FK constraints**) + all **`CREATE VIEW`** (and materialized view) statements.

21. **4.1.3** — All **`CREATE INDEX`** statements you used.

22. **4.1.4** — Thorough narrative: **how** you populated the database (tools, steps, cleaning, loads).

23. **4.1.5** — For **each** of the **40** questions: English → SQL → **full result** or **first 10 rows**; include **change log** for any revised questions vs Deliverable 1.

24. **4.1.6** — **5 rows** from **each** table + **row counts** for **all** tables.

---

## Phase E — Final presentation (video)

25. **Script and record** (**8 minutes**, strict):  
    1. Dataset overview and why you chose it.  
    2. **Initial ERD → final ERD** and what changed.  
    3. Demo a few tables + **row counts**.  
    4. Demo **two** queries — **one intermediate**, **one advanced**.  
    5. Reflect: hardest part, what you learned, SQL confidence, what you would do next with more time.

---

## Quick reference — grading weights

| Component           | Weight |
|---------------------|--------|
| Deliverable 1       | 10%    |
| Deliverable 2       | 20%    |
| Deliverable 3       | 20%    |
| Deliverable 4       | 35%    |
| Final presentation  | 15%    |

---

## Tips (from the overview)

- Keep **evidence** (diagrams, DDL, samples, counts) as you go so Deliverable 4 is assembly, not reconstruction.  
- If the data cannot support interesting joins, fix the **schema or dataset** before writing all SQL.  
- **Save** “initial ERD” artifacts when you first submit or finalize early design—you need them for the video comparison.  
- **Graduate depth:** weave in constraints, indexes, MVs, and procedures **during** design and implementation—not only at the end.
