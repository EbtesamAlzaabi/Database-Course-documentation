create database finalproject;
use finalproject;

---- how can create table:-----
--- 1-library table ---

create table libtab(
libID int identity(1,1) primary key,
libName nvarchar (100) not null unique,
libLocation nvarchar (100) not null,
contactNum nvarchar (20) not null,
establishedYear int

);
 ---how can insert data in table -----
 insert into libtab (libName,libLocation,contactNum,establishedYear)
 values 
 ('muscat lib','MUSCAT','1236987', 2021),
 ('suhar lib','suhar','1478963', 2022),
 ('shinas lib','shinas','258741', 2020),
 ('musnaa lib','musnaa','123456', 2019);

 --- run---

 select *from libtab;
 -----------------------------------------
 -----------------------------------------

 --- 2-BOOK table ---
 --------------------
 CREATE TABLE book_tab (
    BookID INT IDENTITY(1,1) PRIMARY KEY,
    ISBN NVARCHAR(20) NOT NULL UNIQUE,
    Title NVARCHAR(200) NOT NULL,
    Genre NVARCHAR(50) NOT NULL CHECK (Genre IN ('Fiction','Non-fiction','Reference','Children')),
    Price DECIMAL(10,2) NOT NULL CHECK (Price > 0),
    IsAvailable BIT NOT NULL DEFAULT 1,
    ShelfLocation NVARCHAR(50) NOT NULL,
    LibraryID INT NOT NULL,
    CONSTRAINT FK_Book_Library FOREIGN KEY (LibraryID)
        REFERENCES libtab(libID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO book_tab (ISBN, Title, Genre, Price, ShelfLocation, LibraryID)
VALUES

('111-0001', 'Data Science Basics', 'Non-fiction', 22.50, 'A2', 1),
('111-0002', 'SQL Mastery', 'Reference', 35.00, 'A3', 1),
('111-0003', 'Fairy Tales', 'Children', 12.00, 'A4', 1),
('111-0004', 'Mystery Island', 'Fiction', 18.00, 'A5', 1),
('111-0005', 'AI Future', 'Non-fiction', 28.00, 'A6', 1),
('222-0001', 'Football Legends', 'Fiction', 16.50, 'B3', 2),
('222-0002', 'World History', 'Non-fiction', 24.00, 'B4', 2),
('222-0003', 'Encyclopedia Vol 1', 'Reference', 50.00, 'B5', 2),
('222-0004', 'Kids Stories', 'Children', 10.00, 'B6', 2),
('222-0005', 'Science Explained', 'Reference', 45.00, 'B7', 2),
('333-0001', 'Modern Fiction', 'Fiction', 20.00, 'C1', 3),
('333-0002', 'Learning Python', 'Reference', 42.00, 'C2', 3),
('333-0003', 'Healthy Living', 'Non-fiction', 19.00, 'C3', 3),
('333-0004', 'Children Fun Book', 'Children', 11.50, 'C4', 3),
('333-0005', 'Advanced SQL', 'Reference', 48.00, 'C5', 3),
('333-0006', 'Short Stories', 'Fiction', 14.00, 'C6', 3),
('333-0007', 'History of Oman', 'Non-fiction', 26.00, 'C7', 3),
('333-0008', 'Math for Kids', 'Children', 9.50, 'C8', 3),
('333-0009', 'Tech Trends', 'Non-fiction', 30.00, 'C9', 3),
('333-0010', 'Fantasy World', 'Fiction', 17.00, 'C10', 3);

SELECT * from  book_tab;


--------------------------------
---------------------------------

 --- 3-MEMBER table ---
 ----------------------------
 CREATE TABLE MEMBER_TABLE (
    MemberID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100),
    Email NVARCHAR(100) NOT NULL UNIQUE,
    PhoneNumber NVARCHAR(20),
    MembershipStartDate DATE NOT NULL
);



INSERT INTO MEMBER_TABLE (FullName, Email, PhoneNumber, MembershipStartDate)
VALUES
('EBTESAM', 'EBTESAM@GOOGLE.com', '333-1234', '2025-02-03'),
('AMANI', 'AMANI@OUTLOOK.com', '111-5678', '2022-09-04'),
('FATMA', 'FATMA@HOTMAIL.com', '222-5678', '2020-11-11'),
('ALI', 'ALI@gmail.com', '900-1111', '2021-01-01'),
('SARA', 'SARA@gmail.com', '900-2222', '2021-03-10'),
('MOHAMMED', 'MOHAMMED@gmail.com', '900-3333', '2022-05-20'),
('HIND', 'HIND@gmail.com', '900-4444', '2022-08-15'),
('KHALID', 'KHALID@gmail.com', '900-5555', '2023-01-01'),
('AISHA', 'AISHA@gmail.com', '900-6666', '2023-02-14'),
('YOUSEF', 'YOUSEF@gmail.com', '900-7777', '2023-04-01');

SELECT * from  MEMBER_TABLE;

--------------------------------
---------------------------------

 --- 4-STAFF_TABLE ---
 ----------------------------
 CREATE TABLE STAFF_TABLE (
    StaffID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100),
    Position NVARCHAR(50),
    ContactNumber NVARCHAR(20),
    LibraryID INT NOT NULL,
    CONSTRAINT FK_Staff_Library FOREIGN KEY (LibraryID)
        REFERENCES libtab(libID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO STAFF_TABLE (FullName, Position, ContactNumber, LibraryID)
VALUES
('EBTESAM ALZAABI', 'Librarian', '777-1111', 1),
('NURA ALHOSANI', 'Assistant Librarian', '888-2222', 1),
('AMANI ALSALHI', 'Auditor', '999-3333', 2);

SELECT * from  STAFF_TABLE;


--------------------------------
---------------------------------

 --- 5-LOAN_TABLE ---
 ----------------------------
 CREATE TABLE Loan_table (
    LoanID INT IDENTITY(1,1) PRIMARY KEY,
    MemberID INT NOT NULL,
    BookID INT NOT NULL,
    LoanDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    ReturnDate DATE NULL,
    Status NVARCHAR(20) NOT NULL DEFAULT 'Issued' CHECK (Status IN ('Issued', 'Returned', 'Overdue')),
    
    CONSTRAINT chk_ReturnDate CHECK (ReturnDate IS NULL OR ReturnDate >= LoanDate),

);


INSERT INTO Loan_table (MemberID, BookID, LoanDate, DueDate, ReturnDate, Status)
VALUES
(1, 1, '2025-12-01', '2025-12-15', '2025-12-25', 'Issued'),
(1, 2, '2025-12-02', '2025-12-16', NULL, 'Returned'),
(2, 3, '2025-12-05', '2025-12-20', '2025-12-22', 'Overdue'),
(4, 1, '2025-04-01', '2025-04-15', '2025-04-20', 'Issued'),
(5, 2, '2025-05-03', '2025-04-18', NULL, 'Overdue'),
(6, 3, '2025-02-01', '2025-08-13', '2025-08-22', 'Issued'),
(7, 2, '2025-07-08', '2025-07-12', '2025-07-20', 'Overdue'),
(8, 1, '2025-03-09', '2025-09-11', NULL, 'Issued'),
(9, 1, '2025-06-03', '2025-10-10', NULL, 'Issued'),
(10,3, '2025-01-05', '2025-02-20', '2025-02-22', 'Returned');

SELECT * from  Loan_table;


--------------------------------
---------------------------------

 --- 6-PAYMENT_TABLE -----------
 --------------------------------
 CREATE TABLE PAYMENT_TABLE (
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

INSERT INTO PAYMENT_TABLE (LoanID, PaymentDate, Amount, Method)
VALUES
(2, '2025-12-14', 5.00, 'Cash'),
(2, '2025-12-14', 3.50, 'Card'),
(3, '2025-02-25', 6.00, 'Cash'),
(8, '2025-05-20', 8.50, 'Card');

SELECT * from  PAYMENT_TABLE;

---------------------------
--TABLE Review----
----------------------

CREATE TABLE Review (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
    BookID INT NOT NULL,
    MemberID INT NOT NULL,
    Rating INT NOT NULL CHECK (Rating BETWEEN 1 AND 5),
    Comments NVARCHAR(500) DEFAULT 'No comments',
    ReviewDate DATE NOT NULL,
    CONSTRAINT FK_Review_Book FOREIGN KEY (BookID)
        REFERENCES dbo.book_tab(BookID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT FK_Review_Member FOREIGN KEY (MemberID)
        REFERENCES MEMBER_TABLE(MemberID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


INSERT INTO Review (BookID, MemberID, Rating, Comments, ReviewDate)
VALUES
(1, 1, 5, 'Amazing read!', '2025-12-10'),
(2, 1, 4, 'so happy.', '2025-12-12'),
(3, 1, 4, ' happy.', '2025-12-11'),
(3, 2, 5, 'sad', '2025-12-15'); 

SELECT * from  Review;
------------------------------------------------------
----																		----------------------------------
------Section 1: Complex Queries with Joins------------
-----------------------------------------------------------

---- (1 )- Library Book Inventory Report----

SELECT 
    L.LName AS LibraryName,
    COUNT(B.book_tab) AS TotalBooks,
    SUM(CASE WHEN B.IsAvailable = 1 THEN 1 ELSE 0 END) AS AvailableBooks,
    SUM(CASE WHEN B.IsAvailable = 0 THEN 1 ELSE 0 END) AS BooksOnLoan
FROM libtab L
LEFT JOIN book_tab B ON L.libID = B.libID
GROUP BY L.LName;


------- (2) Active Borrowers Analysis--------

SELECT 
    M.FullName AS MemberName,
    M.Email,
    B.Title AS BookTitle,
    L.LoanDate,
    L.DueDate,
    L.Status
FROM Loan_table L
JOIN MEMBER_TABLE M ON L.MemberID = M.MemberID
JOIN Book B ON L.BookID = B.BookID
WHERE L.Status IN ('Issued', 'Overdue');



-----(3) Overdue Loans with Member Details---

SELECT 
    M.FullName AS MemberName,
    M.PhoneNumber,
    B.Title AS BookTitle,
    LT.LName AS LibraryName,
    DATEDIFF(DAY, L.DueDate, GETDATE()) AS DaysOverdue,
    ISNULL(SUM(P.Amount), 0) AS TotalFinePaid
FROM Loan_table L
JOIN MEMBER_TABLE M ON L.MemberID = M.MemberID
JOIN Book B ON L.BookID = B.BookID
JOIN LIBRARY_Table LT ON B.LibraryID = LT.LibraryID
LEFT JOIN Payment P ON L.LoanID = P.LoanID
WHERE L.Status = 'Overdue'
GROUP BY 
    M.FullName, M.PhoneNumber, B.Title, LT.LName, L.DueDate;



	----(4) Staff Performance Overview---------

	SELECT 
    LT.LName AS LibraryName,
    S.FullName AS StaffName,
    S.Position,
    COUNT(B.BookID) AS BooksManaged
FROM LIBRARY_Table LT
JOIN STAFF_TABLE S ON LT.LibraryID = S.LibraryID
LEFT JOIN Book B ON LT.LibraryID = B.LibraryID
GROUP BY 
    LT.LName, S.FullName, S.Position;



	---(5)  Book Popularity Report ---

	SELECT 
    B.Title,
    B.ISBN,
    B.Genre,
    COUNT(L.LoanID) AS TimesLoaned,
    AVG(R.Rating) AS AverageRating
FROM Book B
JOIN Loan_table L ON B.BookID = L.BookID
LEFT JOIN Review R ON B.BookID = R.BookID
GROUP BY 
    B.Title, B.ISBN, B.Genre
HAVING COUNT(L.LoanID) >= 1;


---(6) Member Reading History-----

SELECT 
    M.FullName AS MemberName,
    B.Title AS BookTitle,
    L.LoanDate,
    L.ReturnDate,
    R.Rating,
    R.Comments
FROM MEMBER_TABLE M
LEFT JOIN Loan_table L ON M.MemberID = L.MemberID
LEFT JOIN Book B ON L.BookID = B.BookID
LEFT JOIN Review R 
    ON R.MemberID = M.MemberID 
    AND R.BookID = B.BookID
ORDER BY 
    M.FullName, L.LoanDate;


	----- (7)  Revenue Analysis by Genre ----

	SELECT 
    B.Genre,
    COUNT(DISTINCT L.LoanID) AS TotalLoans,
    ISNULL(SUM(P.Amount), 0) AS TotalFineCollected,
    ISNULL(SUM(P.Amount) / NULLIF(COUNT(DISTINCT L.LoanID), 0), 0) 
        AS AverageFinePerLoan
FROM Book B
JOIN Loan_table L ON B.BookID = L.BookID
LEFT JOIN Payment P ON L.LoanID = P.LoanID
GROUP BY B.Genre;

								