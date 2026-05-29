# Dataset selection questionnaire (graduate final project)

Fill this in **before** you lock in a dataset. Your answers should line up with the **Final Project Overview** (public data, citation + link, **6–10** tables, **≥10,000** total rows, rich **multi-table** joins, **view joining ≥4 tables**, real data—not mostly mocked).

Use this file as your own record; you can paste answers back when you want feedback.

---

## A. Subject and motivation

1. **What domain or story do you want your database to support?** (e.g. transit, healthcare claims, sports, e-commerce, environmental sensors—one sentence is enough to start.)
Sports specifically soccer

2. **Why this domain?** (Interest, career relevance, curiosity—helps you finish when loading gets tedious.)
Because I am heavily interested in and follow soccer especially club and International soccer
3. **Are you OK if the topic is slightly narrowed** (e.g. one city, one season, one category) **as long as row counts and joins still work?**

well as long as I can do kind of complicated row counts joins and other table manipulations

---

## B. Source, access, and citation (required by the syllabus)

4. **Exact URL(s)** to the dataset landing page or download (instructor must be able to browse it).
 I don't know any public sources yet (You Cursor need to find  a couple of them that I can select from)

5. **Who publishes it, and under what license / terms?** (Can you use it for a class project and cite it?)
I don't know  (We will use the sources with their datasets that you select )

6. **How will you cite it in your writeup?** (Title, publisher, date retrieved, URL—rough draft is fine.)
Title published by [Publisher] retrieved on [date retrieved]

7. **Is the data actually downloadable** (files or API you can persist), **not only** behind a paywall or “request access” with uncertain approval?
Yes I would like data that is easily and publicly downloadable

---

## C. Format and ingestion (Deliverable 1.3 and real loading)

8. **File format(s):** CSV, JSON, SQLite dump, XML, GeoJSON, multiple files, etc.
CSV

9. **Approximate total uncompressed size** (MB/GB). **Will your machine and DB handle it comfortably?**
Yeah I think so and I don't have a specific size in mind. I would say anything less than 500 MB would not be a pain
10. **How do you plan to load it?** (e.g. `COPY`, `\copy`, ETL script in Python, DB import wizard, staging tables then `INSERT`…)
I plan to load it into DBeaver for creating the data base

11. **Is the data “clean enough”** or will you need serious cleaning (encoding, dates, nulls, duplicates)? **Any deal-breakers** (e.g. no stable keys, everything in one blob)?

I don't really have a preference here 

## D. Scale vs graduate requirement (≥10,000 rows total)

12. **Rough row counts per file or main entity** (even estimates from documentation or a quick line count).
use the one that was given in the overview document

13. **Sum across the tables you expect to load:** will you **clearly exceed 10,000 total rows** after splitting into normalized tables? If not, can you **add another related public dataset** with a clean join key?
I am not sure 

14. **Could any “thin” tables** (lookup/dimension) break the spirit of the project? **Plan:** combine or enrich so fact tables still carry weight.
I am not sure 

---

## E. Relational shape (6–10 tables, not one wide sheet)

15. **List the natural entities** you see (e.g. User, Order, OrderLine, Product, Category…). **Count them:** is **6–10** after normalization realistic?

16. **What are the obvious keys and relationships?** (Which IDs link which files?)

17. **Is there a risk everything collapses into one denormalized table?** If yes, **how will you normalize** into multiple tables without losing meaning?

18. **One dataset or combined?** If combined: **what is the shared key** (e.g. `station_id`, `movie_id`, `date`+`region`)? **Any join ambiguity** you need to resolve?

---

## F. Query depth (many multi-table joins; 4–6 tables typical; view ≥4 tables)

19. **Name 5–10 questions** you already imagine asking **that clearly need 2+ tables.** (Sanity check: if they’re all “count rows in one table,” keep looking.)

20. **Can you envision at least a few questions** that would **join about 4–6 tables** once modeled (facts + dimensions + bridges)?

21. **For the required view (≥4 tables joined):** what business meaning could it have? (e.g. “trip with route, stop, agency, calendar attributes.”)

---

## G. Graduate extras (constraints, advanced SQL, tuning)

22. **Where could you enforce ≥3 constraints beyond PK/FK?** (e.g. non-negative amounts, valid status codes, date ranges, UNIQUE business keys.)

23. **What might warrant a materialized view** (heavy aggregates refreshed periodically)?

24. **What might warrant indexes** (filter columns, join keys, large sorts)?

25. **Could a stored procedure or function** fit naturally (e.g. parameterized report, reusable calculation)—or will you design one small, clear example?

---

## H. Risk check (avoid week-10 surprises)

26. **What would make you abandon this dataset?** (License change, broken download, keys don’t match, too messy.) **What is your backup topic or second source?**

27. **Anything unclear after a 30-minute trial** (download one file, open in a tool, sketch 6 entities)? If yes, **resolve before** you write Deliverable 1.

---

## I. Answers (your space)

_Copy the questions you care about below and answer inline, or append dated notes._

**Dataset name / working title:**

**Primary URL:**

**One-paragraph summary of what you’ll build:**

**Estimated total rows after load:**

**Planned tables (draft names):**

**Link keys between files:**

**Top risks + mitigations:**

---

## Quick “go / no-go” checklist

| Criterion | Met? (Y/N / notes) |
|-----------|---------------------|
| Public + link + citable | |
| Can load real data at scale | |
| ≥10,000 rows total (planned) | |
| 6–10 tables realistic | |
| Multi-table questions plausible | |
| View across ≥4 tables plausible | |
| Room for CHECK/UNIQUE/NOT NULL beyond PK/FK | |
| Room for MVs / indexes / procedure | |

When **every row you care about** is **Y** or has a concrete plan, you’re in good shape to commit and write Deliverable 1.
