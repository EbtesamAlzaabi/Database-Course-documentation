CREATE DATABASE LibraryDB1;
use LibraryDB1;

-----------------------
-- LIBRARY-Table---
----------------------

CREATE TABLE LIBRARY_Table (
    LibraryID INT IDENTITY(1,1) PRIMARY KEY,
    LName NVARCHAR(100) NOT NULL UNIQUE,
    Lib_Location NVARCHAR(100) NOT NULL,
    ContactNumber NVARCHAR(20) NOT NULL,
    EstablishedYear INT
);

INSERT INTO LIBRARY_Table (LName, Lib_Location, ContactNumber, EstablishedYear)
VALUES
('Shinas Library', 'shinas_UTAS', '123-456-7890', 1990),
('Suhar Library', 'UNIVERSITY', '987-654-3210', 2010),
('SUR Library', 'COLLEGE', '987-654-1235', 2011);

SELECT * from  LIBRARY_Table;




-----------------------
-- BOOK-Table---
----------------------
CREATE TABLE Book (
    BookID INT IDENTITY(1,1) PRIMARY KEY,
    ISBN NVARCHAR(20) NOT NULL UNIQUE,
    Title NVARCHAR(200) NOT NULL,
    Genre NVARCHAR(50) NOT NULL CHECK (Genre IN ('Fiction','Non-fiction','Reference','Children')),
    Price DECIMAL(10,2) NOT NULL CHECK (Price > 0),
    IsAvailable BIT NOT NULL DEFAULT 1,
    ShelfLocation NVARCHAR(50) NOT NULL,
    LibraryID INT NOT NULL,
    CONSTRAINT FK_Book_Library FOREIGN KEY (LibraryID)
        REFERENCES LIBRARY_Table(LibraryID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO Book (ISBN, Title, Genre, Price, ShelfLocation, LibraryID)
VALUES
('978-0140449136', 'HARRY POTTER', 'Fiction', 15.99, 'A1', 1),
('987-0131103627', 'TOM AND JARRY', 'Reference', 40.50, 'B2', 1),
('369-0064400558', 'FOOTBALL', 'Fiction', 12.75, 'C3', 2),
('258-0195153446', 'SALLY History ', 'Non-fiction', 18.00, 'D4', 2);

SELECT * from  Book;


-------------
-- MEMBER---
-------------

CREATE TABLE MEMBER_TABLE1 (
    MEMB_ID INT IDENTITY(1,1) PRIMARY KEY,
    FULL_NAME VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    PhoneNumber VARCHAR(15),
    MembershipStartDate DATE,
    BOOK_ID INT,
    FOREIGN KEY (BOOK_ID) REFERENCES BOOK(BookID)
);

INSERT INTO MEMBER_TABLE1 (FULL_NAME, Email, PhoneNumber, MembershipStartDate)
VALUES
('EBTESAM', 'EBTESAM@GOOGLE.com', '333-1234', '2025-02-03'),
('AHMED', 'AHMED@OUTLOOK.com', '111-5678', '2022-09-04'),
('FATMA', 'FATMA@HOTMAIL.com', '222-5678', '2020-11-11');

SELECT * from  MEMBER_TABLE1;

---------------
-- STAFF-----
--------------
CREATE TABLE STAFF_TABLE (
    StaffID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100),
    Position NVARCHAR(50),
    ContactNumber NVARCHAR(20),
    LibraryID INT NOT NULL,
    CONSTRAINT FK_Staff_Library FOREIGN KEY (LibraryID)
        REFERENCES LIBRARY_Table(LibraryID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO STAFF_TABLE (FullName, Position, ContactNumber, LibraryID)
VALUES
('EBTESAM ALZAABI', 'Librarian', '777-1111', 1),
('NURA ALHOSANI', 'Assistant Librarian', '888-2222', 1),
('AMANI ALSALHI', 'Auditor', '999-3333', 2);

SELECT * from  STAFF_TABLE;

--------------------------

--------------------
-- LOAN---
-----------------
CREATE TABLE Loan_table (
    LoanID INT IDENTITY(1,1) PRIMARY KEY,
    MemberID INT NOT NULL,
    BookID INT NOT NULL,
    LoanDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    ReturnDate DATE NULL,
    Status NVARCHAR(20) NOT NULL DEFAULT 'Issued' CHECK (Status IN ('Issued', 'Returned', 'Overdue')),
    
    CONSTRAINT chk_ReturnDate CHECK (ReturnDate IS NULL OR ReturnDate >= LoanDate),

    CONSTRAINT FK_Loan_Member FOREIGN KEY (MemberID)
        REFERENCES MEMBER_TABLE1(MEMB_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT FK_Loan_Book FOREIGN KEY (BookID)
        REFERENCES dbo.Book(BookID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO Loan_table (MemberID, BookID, LoanDate, DueDate, ReturnDate, Status)
VALUES
(1, 1, '2025-12-01', '2025-12-15', NULL, 'Issued'),
(1, 2, '2025-12-02', '2025-12-16', '2025-12-14', 'Returned'),
(2, 3, '2025-12-05', '2025-12-20', NULL, 'Issued');

SELECT * from  Loan_table;

--------------------------
-- PAYMENT----
-----------
CREATE TABLE Payment (
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    LoanID INT NOT NULL,
    PaymentDate DATE NOT NULL,
    Amount DECIMAL(10,2) NOT NULL CHECK (Amount > 0),
    Method NVARCHAR(50),
    CONSTRAINT FK_Payment_Loan FOREIGN KEY (LoanID)
        REFERENCES Loan_table(LoanID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO Payment (LoanID, PaymentDate, Amount, Method)
VALUES
(2, '2025-12-14', 5.00, 'Cash'),
(2, '2025-12-14', 3.50, 'Card');

SELECT * from  Payment;

---------------------
-- REVIEW----
-------------------
CREATE TABLE Review (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
    BookID INT NOT NULL,
    MemberID INT NOT NULL,
    Rating INT NOT NULL CHECK (Rating BETWEEN 1 AND 5),
    Comments NVARCHAR(500) DEFAULT 'No comments',
    ReviewDate DATE NOT NULL,
    CONSTRAINT FK_Review_Book FOREIGN KEY (BookID)
        REFERENCES dbo.Book(BookID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT FK_Review_Member FOREIGN KEY (MemberID)
        REFERENCES MEMBER_TABLE1(MEMB_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


INSERT INTO Review (BookID, MemberID, Rating, Comments, ReviewDate)
VALUES
(1, 1, 5, 'Amazing read!', '2025-12-10'),
(2, 1, 4, 'so happy.', '2025-12-12'),
(3, 2, 5, 'sad', '2025-12-15'); 

SELECT * from  Review;

-----------------------------------