-- queries.sql
-- A collection of SQL queries based on the Simple Library DB Worksheet by Gerald Villaran

-- Level 1: Basic Retrieval
-- 1. View all books
SELECT * FROM Books;

-- 2. View all members
SELECT * FROM Members;

-- 3. View only available books
SELECT title, author FROM Books WHERE is_available = TRUE;

-- 4. Find books by genre (Science books)
SELECT title, author FROM Books WHERE genre = 'Science';

-- 5. List books published before 1980
SELECT title, publication_year FROM Books WHERE publication_year < 1980;

-- Level 2: Catalog Management (INSERT Operations)
-- 6. Add a new member
INSERT INTO Members (first_name, last_name, email, join_date)
VALUES ('Lara', 'Croft', 'lara.croft@example.com', CURDATE());

-- 7. Add a new book
INSERT INTO Books (title, author, publication_year, genre, is_available)
VALUES ('SQL Mastery', 'Gerald Villaran', 2025, 'Technology', TRUE);

-- 8. Add a book with minimal info (auto-increment and defaults fill gaps)
INSERT INTO Books (title, author) VALUES ('Mystery of NULL Island', 'Jane Query');

-- 9. Insert multiple books at once
INSERT INTO Books (title, author, publication_year, genre, is_available)
VALUES
('AI 101', 'Sam GPT', 2024, 'Science', TRUE),
('The Data Whisperer', 'Lin Ada', 2023, 'Non-Fiction', TRUE);

-- 10. Insert a loan record
INSERT INTO Loans (book_id, member_id, loan_date)
VALUES (1, 1, CURDATE());

-- Level 3: Borrowing Transaction (UPDATE Operations)
-- 11. Mark a book as borrowed
UPDATE Books SET is_available = FALSE WHERE book_id = 1;

-- 12. Return a book (update loan return_date)
UPDATE Loans SET return_date = CURDATE() WHERE loan_id = 1;

-- 13. Mark the returned book as available again
UPDATE Books SET is_available = TRUE WHERE book_id = 1;

-- 14. Update member email
UPDATE Members SET email = 'lara.new@example.com' WHERE member_id = 1;

-- 15. Change book genre
UPDATE Books SET genre = 'Mystery' WHERE book_id = 2;

-- Level 4: Filtering Mastery (SELECT + WHERE)
-- 16. Find members without loans
SELECT * FROM Members
WHERE member_id NOT IN (SELECT member_id FROM Loans);

-- 17. Find books currently loaned out
SELECT * FROM Books
WHERE book_id IN (SELECT book_id FROM Loans WHERE return_date IS NULL);

-- 18. Find overdue loans (assume more than 14 days)
SELECT * FROM Loans
WHERE DATEDIFF(CURDATE(), loan_date) > 14 AND return_date IS NULL;

-- 19. Show loan details with book title and member name
SELECT Loans.loan_id, Members.first_name, Books.title, Loans.loan_date
FROM Loans
JOIN Members ON Loans.member_id = Members.member_id
JOIN Books ON Loans.book_id = Books.book_id;

-- 20. Count total books by genre
SELECT genre, COUNT(*) AS total FROM Books GROUP BY genre;

-- Level 5: Joins & Reporting
-- 21. List all borrowed books with member names
SELECT b.title, m.first_name, m.last_name
FROM Loans l
JOIN Books b ON l.book_id = b.book_id
JOIN Members m ON l.member_id = m.member_id
WHERE l.return_date IS NULL;

-- 22. List all members and count of books borrowed
SELECT m.first_name, m.last_name, COUNT(l.loan_id) AS loans_count
FROM Members m
LEFT JOIN Loans l ON m.member_id = l.member_id
GROUP BY m.member_id;

-- 23. Show most borrowed book(s)
SELECT b.title, COUNT(l.loan_id) AS times_borrowed
FROM Books b
JOIN Loans l ON b.book_id = l.book_id
GROUP BY b.book_id
ORDER BY times_borrowed DESC
LIMIT 1;

-- 24. Show Top 3 most active members
SELECT m.first_name, COUNT(l.loan_id) AS total_loans
FROM Members m
JOIN Loans l ON m.member_id = l.member_id
GROUP BY m.member_id
ORDER BY total_loans DESC
LIMIT 3;

-- 25. Show total available vs borrowed
SELECT
SUM(is_available = TRUE) AS available_books,
SUM(is_available = FALSE) AS borrowed_books
FROM Books;