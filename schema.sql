-- schema.sql
-- Create the database and the three required tables: Books, Members, Loans
CREATE DATABASE IF NOT EXISTS simple_library_db;
USE simple_library_db;

-- Books table (no publisher column yet; Part D includes ALTER TABLE to add that)
CREATE TABLE Books (
  book_id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  author VARCHAR(255) NOT NULL,
  publication_year SMALLINT UNSIGNED,
  genre ENUM('Fiction','Science','History','Biography','Children','Fantasy','Mystery','Non-Fiction','Technology','Art') DEFAULT 'Fiction',
  is_available BOOLEAN NOT NULL DEFAULT TRUE
);

-- Members table
CREATE TABLE Members (
  member_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  join_date DATE NOT NULL
);

-- Loans table that links Books and Members
CREATE TABLE Loans (
  loan_id INT AUTO_INCREMENT PRIMARY KEY,
  book_id INT NOT NULL,
  member_id INT NOT NULL,
  loan_date DATE NOT NULL,
  return_date DATE DEFAULT NULL,
  CONSTRAINT fk_loan_book FOREIGN KEY (book_id)
    REFERENCES Books(book_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_loan_member FOREIGN KEY (member_id)
    REFERENCES Members(member_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
