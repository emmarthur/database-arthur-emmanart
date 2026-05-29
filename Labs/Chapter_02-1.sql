---------------------------------------------------------------------------
-- Practical SQL: A Beginner's Guide to Storytelling with Data, 2nd Edition
-- by Anthony DeBarros

-- Chapter 2 Code Examples
----------------------------------------------------------------------------

-- drop schema if exists teachers cascade;
CrEaTe ScHeMa IF NOT EXISTS teachers;

-- This command will remove (drop) the table.
-- DROP TABLE if exists teachers.teachers;
-- Listing 2-2: Creating a table named teachers with six columns
CrEaTe tAbLe IF NOT exists teachers.teachers (
    id bigserial
    , first_name varchar(25)
    , last_name varchar(50)
    , school varchar(50)
    , hire_date date
    , salary numeric
);


-- Listing 2-3 Inserting data into the teachers table
INSERT INTO teachers.teachers (first_name, last_name, school, hire_date, salary)
VALUES 
    ('Janet', 'Smith', 'F.D. Roosevelt HS', '2011-10-30', 36200)
    , ('Lee', 'Reynolds', 'F.D. Roosevelt HS', '1993-05-22', 65000)
    , ('Samuel', 'Cole', 'Myers Middle School', '2005-08-01', 43500)
    , ('Samantha', 'Bush', 'Myers Middle School', '2011-10-30', 36200)
    , ('Betty', 'Diaz', 'Myers Middle School', '2005-08-30', 43500)
    , ('Kathleen', 'Roush', 'F.D. Roosevelt HS', '2010-10-22', 38500)
;

CrEaTe tAbLe IF NOT exists teachers.teachers_nk (
    first_name varchar(25)
    , last_name varchar(50)
    , school varchar(50)
    , hire_date date
    , salary numeric
    , primary key(first_name, last_name)
);

INSERT INTO teachers.teachers_nk (first_name, last_name, school, hire_date, salary)
VALUES 
    ('Janet', 'Smith', 'F.D. Roosevelt HS', '2011-10-30', 36200)
    , ('Lee', 'Reynolds', 'F.D. Roosevelt HS', '1993-05-22', 65000)
    , ('Samuel', 'Cole', 'Myers Middle School', '2005-08-01', 43500)
    , ('Samantha', 'Bush', 'Myers Middle School', '2011-10-30', 36200)
    , ('Betty', 'Diaz', 'Myers Middle School', '2005-08-30', 43500)
    , ('Kathleen', 'Roush', 'F.D. Roosevelt HS', '2010-10-22', 38500)
;

select * from teachers.teachers;
