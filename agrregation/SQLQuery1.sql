CREATE DATABASE task9;
use task9;

------------------ 
 ---- TABLE Instructors-----
 ------------------

CREATE TABLE Instructors (
InstructorID INT PRIMARY KEY,
FullName VARCHAR(100),
Email VARCHAR(100),
JoinDate DATE
);


INSERT INTO Instructors VALUES
(1, 'Sarah Ahmed', 'sarah@learnhub.com', '2023-01-10'),
(2, 'Mohammed Al-Busaidi', 'mo@learnhub.com', '2023-05-21');


SELECT * from  Instructors;

 
------------------ 
 ---- TABLE Categories-----
 ------------------


 CREATE TABLE Categories (
CategoryID INT PRIMARY KEY,
CategoryName VARCHAR(50)
);

INSERT INTO Categories VALUES
(1, 'Web Development'),
(2, 'Data Science'),
(3, 'Business');


SELECT * from  Categories;

------------------ 
 ---- TABLE Courses-----
 ------------------


CREATE TABLE Courses (
CourseID INT PRIMARY KEY,
Title VARCHAR(100),
InstructorID INT,
CategoryID INT,
Price DECIMAL(6,2),
PublishDate DATE,
FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID),
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

INSERT INTO Courses VALUES
(101, 'HTML & CSS Basics', 1, 1, 29.99, '2023-02-01'),
(102, 'Python for Data Analysis', 2, 2, 49.99, '2023-03-15'),
(103, 'Excel for Business', 2, 3, 19.99, '2023-04-10'),
(104, 'JavaScript Advanced', 1, 1, 39.99, '2023-05-01');

SELECT * from  Courses;


------------------ 
 ---- TABLE Students-----
 ------------------
 

CREATE TABLE Students (
StudentID INT PRIMARY KEY,
FullName VARCHAR(100),
Email VARCHAR(100),
JoinDate DATE
);

INSERT INTO Students VALUES
(201, 'Ali Salim', 'ali@student.com', '2023-04-01'),
(202, 'Layla Nasser', 'layla@student.com', '2023-04-05'),
(203, 'Ahmed Said', 'ahmed@student.com', '2023-04-10');

SELECT * from  Students;




------------------ 
 ---- TABLE Enrollments-----
 ------------------
 

CREATE TABLE Enrollments (
EnrollmentID INT PRIMARY KEY,
StudentID INT,
CourseID INT,
EnrollDate DATE,
CompletionPercent INT,
Rating INT CHECK (Rating BETWEEN 1 AND 5),
FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
)

 
INSERT INTO Enrollments VALUES
(1, 201, 101, '2023-04-10', 100, 5),
(2, 202, 102, '2023-04-15', 80, 4),
(3, 203, 101, '2023-04-20', 90, 4),
(4, 201, 102, '2023-04-22', 50, 3),
(5, 202, 103, '2023-04-25', 70, 4),
(6, 203, 104, '2023-04-28', 30, 2),
(7, 201, 104, '2023-05-01', 60, 3)



SELECT * from  Enrollments;


-----------


---------SQL Aggregation Functions -----


---Part 1: Warm-Up ----
--1--

SELECT 
    CourseID,
    Title AS CourseTitle,
    Price
FROM Courses;


--2--
SELECT 
    StudentID,
    FullName AS StudentName,
    JoinDate
FROM Students;


--3--
SELECT 
    EnrollmentID,
    StudentID,
    CourseID,
    EnrollDate,
    CompletionPercent,
    Rating
FROM Enrollments;


---4---

SELECT COUNT(*) AS InstructorsJoined2023
FROM Instructors
WHERE YEAR(JoinDate) = 2023;



---5--
SELECT COUNT(*) AS StudentsJoinedApril2023
FROM Students
WHERE YEAR(JoinDate) = 2023
  AND MONTH(JoinDate) = 4;




  ------------------------------------
  --Part 2: Beginner Aggregation-----
  ------------------------------------

  ----1---

SELECT COUNT(*) AS TotalStudents
FROM Students;



----2---
SELECT COUNT(*) AS TotalEnrollments
FROM Enrollments;



---3---
SELECT 
    C.Title AS CourseTitle,
    AVG(E.Rating) AS AvgRating
FROM Courses C
JOIN Enrollments E
    ON C.CourseID = E.CourseID
GROUP BY C.Title;


---4---

SELECT 
    I.FullName AS InstructorName,
    COUNT(C.CourseID) AS TotalCourses
FROM Instructors I
LEFT JOIN Courses C
    ON I.InstructorID = C.InstructorID
GROUP BY I.FullName;



---5---
SELECT 
    Cat.CategoryName,
    COUNT(C.CourseID) AS TotalCourses
FROM Categories Cat
LEFT JOIN Courses C
    ON Cat.CategoryID = C.CategoryID
GROUP BY Cat.CategoryName;


----6----

SELECT 
    C.Title AS CourseTitle,
    COUNT(E.StudentID) AS TotalStudents
FROM Courses C
LEFT JOIN Enrollments E
    ON C.CourseID = E.CourseID
GROUP BY C.Title;



---7--
SELECT 
    Cat.CategoryName,
    AVG(C.Price) AS AvgCoursePrice
FROM Categories Cat
LEFT JOIN Courses C
    ON Cat.CategoryID = C.CategoryID
GROUP BY Cat.CategoryName;



--8----

SELECT MAX(Price) AS MaxCoursePrice
FROM Courses;



---9---

SELECT 
    C.Title AS CourseTitle,
    MIN(E.Rating) AS MinRating,
    MAX(E.Rating) AS MaxRating,
    AVG(E.Rating) AS AvgRating
FROM Courses C
JOIN Enrollments E
    ON C.CourseID = E.CourseID
GROUP BY C.Title;


---10---

SELECT COUNT(*) AS StudentsWithRating5
FROM Enrollments
WHERE Rating = 5;



----- Part 3: Extended Beginner Practice  ----

----1---



SELECT 
    YEAR(EnrollDate) AS EnrollYear,
    MONTH(EnrollDate) AS EnrollMonth,
    COUNT(*) AS TotalEnrollments
FROM Enrollments
GROUP BY YEAR(EnrollDate), MONTH(EnrollDate)
ORDER BY EnrollYear, EnrollMonth;



---2---


SELECT AVG(Price) AS AvgCoursePrice
FROM Courses;



---3--
SELECT 
    YEAR(JoinDate) AS JoinYear,
    MONTH(JoinDate) AS JoinMonth,
    COUNT(*) AS TotalStudents
FROM Students
GROUP BY YEAR(JoinDate), MONTH(JoinDate)
ORDER BY JoinYear, JoinMonth;


---4---

SELECT 
    Rating,
    COUNT(*) AS CountPerRating
FROM Enrollments
GROUP BY Rating
ORDER BY Rating;



---5---
SELECT 
    C.CourseID,
    C.Title AS CourseTitle
FROM Courses C
LEFT JOIN Enrollments E
    ON C.CourseID = E.CourseID
GROUP BY C.CourseID, C.Title
HAVING SUM(CASE WHEN E.Rating = 5 THEN 1 ELSE 0 END) = 0;



---6---
SELECT COUNT(*) AS CoursesAbove30
FROM Courses
WHERE Price > 30;



---7---

SELECT AVG(CompletionPercent) AS AvgCompletionPercent
FROM Enrollments;



---8---
SELECT TOP 1
    C.CourseID,
    C.Title AS CourseTitle,
    AVG(E.Rating) AS AvgRating
FROM Courses C
JOIN Enrollments E
    ON C.CourseID = E.CourseID
GROUP BY C.CourseID, C.Title
ORDER BY AVG(E.Rating) ASC;
