-- queries.sql

-- Get all repositories owned by a specific user
SELECT r.id, r.name, r.description, r.created_at
FROM repositories r
WHERE r.owner_id = ?;

-- Get all contributors for a specific repository
SELECT u.id, u.username, u.email, c.role
FROM users u
JOIN contributors c ON u.id = c.user_id
WHERE c.repo_id = ?;

-- Add a new user
INSERT INTO users (username, email)
VALUES (?, ?);

-- Create a new repository
INSERT INTO repositories (name, description, owner_id)
VALUES (?, ?, ?);

-- Add a contributor to a repository
INSERT INTO contributors (user_id, repo_id, role)
VALUES (?, ?, ?);

-- Update repository description
UPDATE repositories
SET description = ?
WHERE id = ? AND owner_id = ?;

-- Delete a repository (cascades to contributors)
DELETE FROM repositories
WHERE id = ? AND owner_id = ?;

-- Find repositories by name (partial match)
SELECT r.id, r.name, r.description, u.username AS owner
FROM repositories r
JOIN users u ON r.owner_id = u.id
WHERE r.name LIKE ?;