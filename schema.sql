-- Books table to store book information
CREATE TABLE Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(100) NOT NULL,
    isbn VARCHAR(13) UNIQUE NOT NULL,
    publication_year INT,
    genre VARCHAR(50),
    total_copies INT NOT NULL DEFAULT 1,
    available_copies INT NOT NULL DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CHECK (available_copies <= total_copies)
);

-- Members table to store member information
CREATE TABLE Members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    address VARCHAR(255),
    join_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);

-- Loans table to store book borrowing records
CREATE TABLE Loans (
    loan_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    loan_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    due_date TIMESTAMP NOT NULL,
    return_date TIMESTAMP,
    fine_amount DECIMAL(5,2) DEFAULT 0.00,
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE RESTRICT,
    FOREIGN KEY (member_id) REFERENCES Members(member_id) ON DELETE RESTRICT,
    CHECK (due_date > loan_date)
);