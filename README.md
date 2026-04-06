# 6-6 JOIN Queries

Lecture code for [JOIN Queries](https://marcylabschool.gitbook.io/marcy-lab-school-docs/mod-6-databases/6-join-queries).

## Setup

**1. Create the database:**

```sh
createdb social_db                    # Mac
sudo -u postgres createdb social_db   # Windows/WSL
```

**2. Run the setup file to populate it:**

```sh
psql -f setup.sql                    # Mac
sudo -u postgres psql -f setup.sql   # Windows/WSL
```

**3. Connect:**

```sh
psql social_db                       # Mac
sudo -u postgres psql social_db      # Windows/WSL
```

## Files

- `setup.sql` — creates the schema and seeds `social_db` with `users`, `posts`, `tags`, and `post_tags`
- `queries.sql` — INNER JOIN, LEFT JOIN, GROUP BY, and many-to-many practice queries
