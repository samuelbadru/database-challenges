# Two Tables Design Recipe Template

## 1. Extract nouns from the user stories or specification

```
# USER STORY:

As a blogger
So I can write interesting stuff
I want to write posts having a title.

As a blogger
So I can write interesting stuff
I want to write posts having a content.

As a blogger
So I can let people comment on interesting stuff
I want to allow comments on my posts.

As a blogger
So I can let people comment on interesting stuff
I want the comments to have a content.

As a blogger
So I can let people comment on interesting stuff
I want the author to include their name in comments.
```

```
Nouns:

posts, title, content, comments, author, name
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| post                  | title, content, comment
| comment               | content, author_name 

1. Name of the first table: `posts` 

    Column names: `title`, `content`, `comment`

2. Name of the second table: `comments` 

    Column names: `content`, `author_name`

## 3. Decide the column types.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

Table: posts
id: SERIAL
title: text
content: text
comment: int(foreign_key)

Table: comments
id: SERIAL
content: text
author_name: text
```

## 4. Decide on The Tables Relationship

```
# EXAMPLE

1. Can one post have many comments? YES
2. Can one comment have many posts? NO

-> Therefore,
-> A post HAS MANY comments
-> A comment BELONGS TO a post

-> Therefore, the foreign key is on the comments table.
```

## 4. Write the SQL.

```sql
-- EXAMPLE
-- file: schema/blog_tables

-- Create the table without the foreign key first.
CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  content text,
  author_name text
);

-- Then the table with the foreign key.
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text,
  content text,
-- The foreign key name is always {other_table_singular}_id   
  comment_id int,
  constraint fk_comment foreign key(comment_id)
    references comments(id)
    on delete cascade
);
```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 blog < schema/comments_posts_table.sql
```
