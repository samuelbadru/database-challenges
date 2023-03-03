CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  content text,
  author_name text
);

CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text,
  content text,
  comment_id int,
  constraint fk_comment foreign key(comment_id)
    references comments(id)
    on delete cascade
);