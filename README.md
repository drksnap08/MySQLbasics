# GitHub Clone Database

This repository contains the database schema, queries, and seed data for a simplified GitHub-like system implemented in MySQL. The database supports basic functionality such as user management, repository creation, and contributor relationships.

## Table of Contents
- [Overview](#overview)
- [Database Structure](#database-structure)
- [Files](#files)
- [Setup Instructions](#setup-instructions)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Overview
This project provides a MySQL database schema to mimic a simplified version of GitHub's core features. It includes tables for users, repositories, and contributors, along with sample queries and seed data for testing. The schema is designed to be lightweight yet extensible for further development.

## Database Structure
The database (`github_clone`) consists of three main tables:
- **`users`**: Stores user information (ID, username, email, creation timestamp).
- **`repositories`**: Stores repository details (ID, name, description, owner ID, creation timestamp).
- **`contributors`**: Manages the many-to-many relationship between users and repositories, with roles (`owner` or `collaborator`).

Foreign keys enforce referential integrity, and cascading deletes ensure data consistency.

## Files
- **`schema.sql`**: Defines the database and table structures.
- **`queries.sql`**: Contains common SQL queries for CRUD operations and repository management.
- **`seeds.sql`**: Populates the database with sample users, repositories, and contributors for testing.

## Setup Instructions
1. **Prerequisites**:
   - MySQL 5.7 or later installed.
   - MySQL client or a tool like MySQL Workbench.
   - Basic knowledge of SQL and database management.

2. **Create the Database**:
   - Run the `schema.sql` file to create the `github_clone` database and tables.
     ```bash
     mysql -u root -p < database/schema.sql
     ```

3. **Populate with Seed Data**:
   - Run the `seeds.sql` file to insert sample data.
     ```bash
     mysql -u root -p github_clone < database/seeds.sql
     ```

4. **Verify Setup**:
   - Connect to the MySQL server and check the `github_clone` database:
     ```sql
     USE github_clone;
     SHOW TABLES;
     SELECT * FROM users;
     ```

## Usage
- **Running Queries**:
  - Use the queries in `queries.sql` for common operations like:
    - Fetching a user's repositories.
    - Adding contributors to a repository.
    - Updating or deleting repositories.
    - Searching repositories by name.
  - Example (using a MySQL client or application):
    ```sql
    SELECT r.id, r.name, r.description, u.username AS owner
    FROM repositories r
    JOIN users u ON r.owner_id = u.id
    WHERE r.name LIKE '%project%';
    ```
  - In an application, use parameterized queries to prevent SQL injection (e.g., with Python’s `mysql-connector` or Node.js’s `mysql2`).

- **Extending the Schema**:
  - Add tables for features like issues, pull requests, or stars as needed.
  - Modify field lengths or add indexes for performance in production.

## Contributing
Contributions are welcome! To contribute:
1. Fork the repository.
2. Create a new branch (`git checkout -b feature/your-feature`).
3. Make changes and commit (`git commit -m "Add your feature"`).
4. Push to your branch (`git push origin feature/your-feature`).
5. Open a pull request.

Please ensure your changes include appropriate tests and documentation updates.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.