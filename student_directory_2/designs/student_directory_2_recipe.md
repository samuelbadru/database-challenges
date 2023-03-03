# Two Tables Design Recipe Template

## 1. Extract nouns from the user stories or specification

```
# USER STORY:

As a coach
So I can get to know all students
I want to see a list of students' names.

As a coach
So I can get to know all students
I want to see a list of cohorts' names.

As a coach
So I can get to know all students
I want to see a list of cohorts' starting dates.

As a coach
So I can get to know all students
I want to see a list of students' cohorts.
```

```
Nouns:

students, names, cohorts, starting dates
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| student               | name, cohort
| cohort                | name, starting_date 

1. Name of the first table: `students` 

    Column names: `name`, `cohort`

2. Name of the second table: `cohort` 

    Column names: `name`, `starting_date`

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

Table: students
id: SERIAL
name: text
cohort: text

Table: cohorts
id: SERIAL
name: text
starting_date: text
```

## 4. Decide on The Tables Relationship

Most of the time, you'll be using a **one-to-many** relationship, and will need a **foreign key** on one of the two tables.

To decide on which one, answer these two questions:



Therefore:

1. **cohort has many students**
2. And on the other side, **students belongs to cohorts**
3. In that case, the foreign key is in the table students


```
# EXAMPLE

1. Can one student have many cohorts? NO
2. Can one cohort have many students? YES

-> Therefore,
-> A cohort HAS MANY students
-> A student BELONGS TO a cohort

-> Therefore, the foreign key is on the students table.
```

## 4. Write the SQL.

```sql
-- EXAMPLE
-- file: schema/students_cohorts_tables

-- Replace the table name, columm names and types.

-- Create the table without the foreign key first.
CREATE TABLE cohorts (
  id SERIAL PRIMARY KEY,
  name text,
  starting_date text
);

-- Then the table with the foreign key.
CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  name text,
  cohort text,
-- The foreign key name is always {other_table_singular}_id   
  cohort_id int,
-- constraint (named fk_cohort here) ensures that numbers in cohort_id (foreign key) match the numbers cohorts(id) (reference)
  constraint fk_cohort foreign key(cohort_id)
    references cohorts(id)
-- on delete cascasde means if rows are deleted in the parent table(cohorts) they also get deleted in the child table (students)
    on delete cascade
);
```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 student_directory_2 < schema/cohorts_students_table.sql
```
