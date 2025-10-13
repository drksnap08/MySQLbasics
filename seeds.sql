-- seeds.sql
USE github_clone;

-- Insert sample users
INSERT INTO users (username, email) VALUES
('alice', 'alice@example.com'),
('bob', 'bob@example.com'),
('charlie', 'charlie@example.com');

-- Insert sample repositories
INSERT INTO repositories (name, description, owner_id) VALUES
('project-alpha', 'A web app for task management', 1),
('project-beta', 'Machine learning library', 2),
('project-gamma', 'Open-source blog platform', 1);

-- Insert sample contributors
INSERT INTO contributors (user_id, repo_id, role) VALUES
(1, 1, 'owner'), -- Alice owns project-alpha
(2, 1, 'collaborator'), -- Bob contributes to project-alpha
(2, 2, 'owner'), -- Bob owns project-beta
(3, 2, 'collaborator'), -- Charlie contributes to project-beta
(1, 3, 'owner'), -- Alice owns project-gamma
(3, 3, 'collaborator'); -- Charlie contributes to project-gamma
