-- queries.sql
-- JOIN practice queries for social_db
-- Run against social_db: psql social_db (Mac) or sudo -u postgres psql social_db (WSL)

----------------------------------------
-- INNER JOIN
----------------------------------------

-- All posts with their author's username
SELECT users.username, posts.post_id, posts.title
FROM users
  INNER JOIN posts ON users.user_id = posts.user_id;

-- All posts written by ann_duong
SELECT posts.title
FROM users
  INNER JOIN posts ON users.user_id = posts.user_id
WHERE users.username = 'ann_duong';

-- Who wrote the post titled 'Advanced Joins'?
SELECT users.username
FROM users
  INNER JOIN posts ON users.user_id = posts.user_id
WHERE posts.title = 'Advanced Joins';

-- How many posts has reuben_o written?
SELECT COUNT(*) AS post_count
FROM users
  INNER JOIN posts ON users.user_id = posts.user_id
WHERE users.username = 'reuben_o';

----------------------------------------
-- LEFT JOIN
----------------------------------------

-- All users and their posts (include users with no posts)
SELECT users.username, posts.post_id, posts.title
FROM users
  LEFT JOIN posts ON users.user_id = posts.user_id;

-- Users who have written no posts
SELECT users.username
FROM users
  LEFT JOIN posts ON users.user_id = posts.user_id
WHERE posts.post_id IS NULL;

-- Every user's post count, including zero-post users
SELECT users.username, COUNT(posts.post_id) AS post_count
FROM users
  LEFT JOIN posts ON users.user_id = posts.user_id
GROUP BY users.user_id
ORDER BY post_count DESC;

----------------------------------------
-- GROUP BY with smart GROUP BY (primary key)
----------------------------------------

-- Post count per user — Postgres smart GROUP BY
-- Grouping by users.user_id (PK) allows username and email in SELECT
SELECT
  users.user_id,
  users.username,
  users.email,
  COUNT(posts.post_id) AS post_count
FROM users
  LEFT JOIN posts ON users.user_id = posts.user_id
GROUP BY users.user_id
ORDER BY post_count DESC;

----------------------------------------
-- Many-to-many: post_tags
----------------------------------------

-- All tags on 'Learning SQL'
SELECT posts.title, tags.name AS tag
FROM posts
  INNER JOIN post_tags ON posts.post_id = post_tags.post_id
  INNER JOIN tags      ON post_tags.tag_id = tags.tag_id
WHERE posts.title = 'Learning SQL';

-- All posts tagged 'sql', with their authors
SELECT posts.title, users.username
FROM posts
  INNER JOIN post_tags ON posts.post_id = post_tags.post_id
  INNER JOIN tags      ON post_tags.tag_id = tags.tag_id
  INNER JOIN users     ON posts.user_id = users.user_id
WHERE tags.name = 'sql';

-- Number of posts per tag
SELECT tags.name, COUNT(post_tags.post_id) AS post_count
FROM tags
  LEFT JOIN post_tags ON tags.tag_id = post_tags.tag_id
GROUP BY tags.tag_id
ORDER BY post_count DESC;
