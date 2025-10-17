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
