# -*- coding: utf-8 -*-
"""Align Part 3 (Q9) answers with Spy ERD agent table."""
from pathlib import Path

from docx import Document

REPO_ROOT = Path(__file__).resolve().parents[2]
DOC = REPO_ROOT / "Homework" / "docx" / "CS 486_586 – Homework 4-emmanart.docx"

REPLACEMENTS = {
    "The statement creates a new table named newagent with the same column names and data types as agent, but with zero rows.": (
        "The statement creates a new table named newagent with the same column names and data types as agent, but with zero rows. "
        "From the Spy ERD, agent has: agent_id, first, middle, last, address, city, country, salary, clearance_id — "
        "newagent gets those nine columns with matching types and no data."
    ),
    "[SCREENSHOT: \\d agent and \\d newagent in psql, or DBeaver column list for both tables showing matching columns]": (
        "[SCREENSHOT: \\d agent and \\d newagent in psql, or DBeaver column list for both tables — "
        "show the nine columns above match (agent_id, first, middle, last, address, city, country, salary, clearance_id)]"
    ),
    "No. CREATE TABLE ... AS SELECT copies columns and data types (and data if any), but it does not copy primary keys, foreign keys, unique constraints, indexes, or defaults from the source table. I would need ALTER TABLE statements to add those constraints to newagent if I wanted them.": (
        "No. CREATE TABLE ... AS SELECT copies columns and data types only; it does not copy constraints from agent. "
        "On the ERD, agent has a primary key on agent_id and a foreign key clearance_id -> securityclearance.sc_id — "
        "those are not recreated on newagent unless I add them with ALTER TABLE."
    ),
}


def main() -> None:
    doc = Document(str(DOC))
    changed = 0
    for para in doc.paragraphs:
        text = para.text.strip()
        if text in REPLACEMENTS:
            para.text = REPLACEMENTS[text]
            changed += 1
    if changed != len(REPLACEMENTS):
        raise RuntimeError(f"Expected {len(REPLACEMENTS)} replacements, got {changed}")
    doc.save(str(DOC))
    print(f"Updated {changed} Q9 paragraphs in {DOC.name}")


if __name__ == "__main__":
    main()
