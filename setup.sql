\c social_db

DROP TABLE IF EXISTS post_tags;
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS posts;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  user_id   SERIAL PRIMARY KEY,
  username  TEXT   NOT NULL UNIQUE,
  email     TEXT   NOT NULL UNIQUE
);

CREATE TABLE posts (
  post_id  SERIAL  PRIMARY KEY,
  title    TEXT    NOT NULL,
  body     TEXT    NOT NULL,
  user_id  INTEGER REFERENCES users(user_id)
);

CREATE TABLE tags (
  tag_id  SERIAL PRIMARY KEY,
  name    TEXT   NOT NULL UNIQUE
);

CREATE TABLE post_tags (
  post_tag_id  SERIAL  PRIMARY KEY,
  post_id      INTEGER REFERENCES posts(post_id),
  tag_id       INTEGER REFERENCES tags(tag_id)
);

INSERT INTO users (username, email) VALUES
  ('ann_duong', 'ann@example.com'),
  ('reuben_o',  'reuben@example.com'),
  ('carmen_s',  'carmen@example.com'),
  ('ben_s',     'ben@example.com');   -- no posts (useful for LEFT JOIN demo)

INSERT INTO posts (title, body, user_id) VALUES
  ('My First Post',     'Hello world!',               1),
  ('Learning SQL',      'Joins are powerful.',         1),
  ('Postgres Tips',     'Use named IDs.',              2),
  ('Why I Love Coding', 'It is creative work.',        3),
  ('Advanced Joins',    'LEFT JOIN is underused.',     2);

INSERT INTO tags (name) VALUES
  ('javascript'),
  ('sql'),
  ('databases'),
  ('beginner');

INSERT INTO post_tags (post_id, tag_id) VALUES
  (1, 4),  -- My First Post:   beginner
  (2, 2),  -- Learning SQL:    sql
  (2, 3),  -- Learning SQL:    databases
  (3, 2),  -- Postgres Tips:   sql
  (3, 3),  -- Postgres Tips:   databases
  (5, 2);  -- Advanced Joins:  sql
