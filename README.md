Simple Library DB Worksheet
Michael Dave

Read the instructions for each section carefully.

Step A: Redo your databases. New records will be seeded later. This is to ensure that the whole class will be working on the same records consistent enough to complete the levels discussed in this worksheet.

DROP DATABASE 
simple_library_db;

Run the following script to recreate the database and its tables:

Step B: Create schema.sql and run it on your working directory using SOURCE. Or copy and paste on your MySQL Command-Line.

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
Step C: Seed the tables with records by running the following scripts:
Create seed-books.sql and run it on your working directory using SOURCE. Or copy and paste on your MySQL Command-Line.
INSERT INTO Books (title, author, publication_year, genre, is_available) VALUES
('To Kill a Mockingbird', 'Harper Lee', 1960, 'Fiction', TRUE),
('A Brief History of Time', 'Stephen Hawking', 1988, 'Science', TRUE),
('1984', 'George Orwell', 1949, 'Fiction', TRUE),
('The Art of Computer Programming', 'Donald E. Knuth', 1968, 'Fiction', TRUE),
('The Diary of a Young Girl', 'Anne Frank', 1947, 'Fiction', TRUE),
('Green Eggs and Ham', 'Dr. Seuss', 1960, 'Children', TRUE),
('The Hobbit', 'J.R.R. Tolkien', 1937, 'Fiction', TRUE),
('The Da Vinci Code', 'Dan Brown', 2003, 'Fiction', TRUE),
('Sapiens: A Brief History of Humankind', 'Yuval Noah Harari', 2011, 'Fiction', TRUE),
('The Story of Art', 'E. H. Gombrich', 1950, 'Art', TRUE),
('Cosmos', 'Carl Sagan', 1980, 'Science', TRUE),
('The Hitchhiker''s Guide to the Galaxy', 'Douglas Adams', 1979, 'Fantasy', TRUE),
('Dune', 'Frank Herbert', 1965, 'Science', TRUE),
('Educated', 'Tara Westover', 2018, 'Biography', TRUE),
('The Great Gatsby', 'F. Scott Fitzgerald', 1925, 'Fiction', TRUE),
('Pride and Prejudice', 'Jane Austen', 1813, 'Fiction', TRUE),
('The Lord of the Rings', 'J.R.R. Tolkien', 1954, 'Fantasy', TRUE),
('The Martian', 'Andy Weir', 2011, 'Science', TRUE),
('Becoming', 'Michelle Obama', 2018, 'Biography', TRUE),
('Atomic Habits', 'James Clear', 2018, 'Non-Fiction', TRUE),
('The Silent Patient', 'Alex Michaelides', 2019, 'Mystery', TRUE),
('Where the Crawdads Sing', 'Delia Owens', 2018, 'Fiction', TRUE),
('The Very Hungry Caterpillar', 'Eric Carle', 1969, 'Children', TRUE),
('Steve Jobs', 'Walter Isaacson', 2011, 'Biography', TRUE),
('Clean Code', 'Robert C. Martin', 2008, 'Technology', TRUE),
('Thinking, Fast and Slow', 'Daniel Kahneman', 2011, 'Science', TRUE),
('The Alchemist', 'Paulo Coelho', 1988, 'Fiction', TRUE),
('A People''s History of the United States', 'Howard Zinn', 1980, 'History', TRUE),
('The Girl with the Dragon Tattoo', 'Stieg Larsson', 2005, 'Mystery', TRUE),
('Leonardo daVinci', 'Walter Isaacson', 2017, 'Biography', TRUE);
Step D: Create seed-members.sql and run it on your working directory using SOURCE. Or copy and paste on your MySQL Command-Line.
INSERT INTO Members (first_name, last_name, email, join_date) VALUES 
('Maria', 'Santos', 'maria.santos@example.com', '2023-01-10'),
('Jose', 'Rizal', 'jose.rizal@example.com', '2022-05-20'),
('Luzviminda', 'Garcia', 'luzviminda.garcia@example.com', '2024-03-01'),
('Juan', 'Dela Cruz', 'juan.delacruz@example.com', '2021-11-15'),
('Sofia', 'Reyes', 'sofia.reyes@example.com', '2023-07-22'),
('Daniel', 'Lim', 'daniel.lim@example.com', '2022-09-05'),
('Isabel', 'Gonzales', 'isabel.gonzales@example.com', '2024-01-18'),
('Miguel', 'Tan', 'miguel.tan@example.com', '2021-08-30'),
('Patricia', 'Aquino', 'patricia.aquino@example.com', '2023-04-12'),
('Renato', 'Castro', 'renato.castro@example.com', '2022-10-01'),
('Angelica', 'Mercado', 'angelica.mercado@example.com', '2024-02-28'),
('Carlo', 'Perez', 'carlo.perez@example.com', '2021-07-07'),
('Christine', 'David', 'christine.david@example.com', '2023-06-03'),
('Emmanuel', 'Cruz', 'emmanuel.cruz@example.com', '2022-12-19'),
('Grace', 'Sy', 'grace.sy@example.com', '2024-04-05'),
('Ricardo', 'Villanueva', 'ricardo.villanueva@example.com', '2021-09-25'),
('Samantha', 'Lopez', 'samantha.lopez@example.com', '2023-02-14'),
('Victor', 'Tolentino', 'victor.tolentino@example.com', '2022-08-08'),
('Andrea', 'Santiago', 'andrea.santiago@example.com', '2024-01-01'),
('Benito', 'Mendoza', 'benito.mendoza@example.com', '2021-10-10')
Step E: Create seed-loans.sql and run it on your working directory using SOURCE. Or copy and paste on your MySQL Command-Line.
INSERT INTO Loans (book_id, member_id, loan_date, return_date) VALUES
-- Returned loan
(1, 1, DATE_SUB(CURDATE(), INTERVAL 20 DAY), DATE_SUB(CURDATE(), INTERVAL 5 DAY)),
-- Currently borrowed book (not yet returned)
(2, 2, DATE_SUB(CURDATE(), INTERVAL 10 DAY), NULL),
-- Overdue loan (>14 days, still borrowed)
(3, 3, DATE_SUB(CURDATE(), INTERVAL 25 DAY), NULL),
-- Returned same-day loan
(4, 1, DATE_SUB(CURDATE(), INTERVAL 2 DAY), DATE_SUB(CURDATE(), INTERVAL 1 DAY)),
-- Long-term member borrowing two books
(5, 2, DATE_SUB(CURDATE(), INTERVAL 8 DAY), NULL);

-- Update corresponding book availability
UPDATE Books SET is_available = FALSE WHERE book_id IN (2, 3, 5);
UPDATE Books SET is_available = TRUE WHERE book_id IN (1, 4);
We’ve already gone through basic operations but I suggest that you still perform tasks from the beginning. Repetition is key to mastery. There will be new concepts in later parts of this worksheet.
REMINDER: Take the time to WRITE YOUR QUERIES BY HAND! It strengthens your muscle memory and helps you truly understand each command.
Level 1: The Library Opens (Basic Retrieval)
1. View all books
See everything the library owns.
SELECT * FROM Books;
2. View all members
Check who’s registered.
SELECT * FROM Members;
3. View only available books
Filter only books that can be borrowed.
SELECT title, author FROM Books WHERE is_available = TRUE;
4. Find books by genre
Show all Science books.
SELECT title, author FROM Books WHERE genre = 'Science';

5. List books published before 1980
SELECT title, publication_year FROM Books WHERE publication_year < 1980;
Level 2: Catalog Management (INSERT Operations)
6. Add a new member
INSERT INTO Members (first_name, last_name, email, join_date) 
VALUES ('Lara', 'Croft', 'lara.croft@example.com', CURDATE());
CURDATE() is a function that returns the current date based on the server system date.
7. Add a new book
INSERT INTO Books (title, author, publication_year, genre, is_available)
VALUES ('SQL Mastery', 'Gerald Villaran', 2025, 'Technology', TRUE);
8. Add a book with minimal info (auto-increment and defaults fill gaps)
INSERT INTO Books (title, author) VALUES ('Mystery of NULL Island', 'Jane Query');
9. Insert multiple books at once
INSERT INTO Books (title, author, publication_year, genre, is_available) VALUES
('AI 101', 'Sam GPT', 2024, 'Science', TRUE),
('The Data Whisperer', 'Lin Ada', 2023, 'Non-Fiction', TRUE);
10. Insert a loan record
INSERT INTO Loans (book_id, member_id, loan_date) 
VALUES (1, 1, CURDATE());
Level 3: Borrowing Transaction (UPDATE Operations)
11. Mark a book as borrowed
UPDATE Books SET is_available = FALSE WHERE book_id = 1;
12. Return a book (update loan return_date)
UPDATE Loans SET return_date = CURDATE() WHERE loan_id = 1;
13. Mark the returned book as available again
UPDATE Books SET is_available = TRUE WHERE book_id = 1;
14. Update member email
UPDATE Members SET email = 'lara.new@example.com' WHERE member_id = 1;
15. Change book genre
UPDATE Books SET genre = 'Mystery' WHERE book_id = 2;
Level 4: Filtering Mastery (SELECT + WHERE)
16. Find members without loans
SELECT * FROM Members 
WHERE member_id NOT IN (SELECT member_id FROM Loans);
17. Find books currently loaned out
SELECT * FROM Books 
WHERE book_id IN (SELECT book_id FROM Loans WHERE return_date IS NULL);
18. Find overdue loans (assume more than 14 days)
SELECT * FROM Loans 
WHERE DATEDIFF(CURDATE(), loan_date) > 14 AND return_date IS NULL;
19. Show loan details with book title and member name
SELECT Loans.loan_id, Members.first_name, Books.title, Loans.loan_date
FROM Loans
JOIN Members ON Loans.member_id = Members.member_id
JOIN Books ON Loans.book_id = Books.book_id;
20. Count total books by genre
This query counts the total number of books for each genre in the Books table.
SELECT genre, COUNT(*) AS total FROM Books GROUP BY genre;
Level 5: Joins & Reporting
21. List all borrowed books with member names
SELECT b.title, m.first_name, m.last_name
FROM Loans l
JOIN Books b ON l.book_id = b.book_id
JOIN Members m ON l.member_id = m.member_id
WHERE l.return_date IS NULL;
22. List all members and count of books borrowed
SELECT m.first_name, m.last_name, COUNT(l.loan_id) AS loans_count
FROM Members m
LEFT JOIN Loans l ON m.member_id = l.member_id
GROUP BY m.member_id;
23. Show most borrowed book(s)
SELECT b.title, COUNT(l.loan_id) AS times_borrowed
FROM Books b
JOIN Loans l ON b.book_id = l.book_id
GROUP BY b.book_id
ORDER BY times_borrowed DESC
LIMIT 1;
24. Show Top 3 most active members
SELECT m.first_name, COUNT(l.loan_id) AS total_loans
FROM Members m
JOIN Loans l ON m.member_id = l.member_id
GROUP BY m.member_id
ORDER BY total_loans DESC
LIMIT 3;
25. Show total available vs borrowed
This query counts the total number of books for each genre in the Books table.
SELECT 
SUM(is_available = TRUE) AS available_books,
SUM(is_available = FALSE) AS borrowed_books
FROM Books;

Skills Demo Assignment:
BSCS 2A - Oct 16
Explain syntax of the assigned query
Demonstrate another example outside what’s already given
Look into library scenarios from own experience
Same set of operations but different output
Demo during class (Live Coding)

Example AI Prompt for Studying SQL Statements:
break this sql query down to smaller examples. build on top of the basics until we reach the full sql statement:

SELECT b.title, COUNT(l.loan_id) AS times_borrowed
FROM Books b
JOIN Loans l ON b.book_id = l.book_id
GROUP BY b.book_id
ORDER BY times_borrowed DESC



