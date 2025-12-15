CREATE DATABASE CollegeDB;
USE CollegeDB;

---------
--TABLE Department----
---------
CREATE TABLE Department (
    Department_id INT IDENTITY PRIMARY KEY,
    D_name VARCHAR(100) NOT NULL
);
INSERT INTO Department (D_name)
values ('Computer Science'),
('Mathematics'),
('Physics'),
('Chemistry');

SELECT * FROM Department;




----------------
--TABLE Faculty--
-----------------

CREATE TABLE Faculty (
    F_id INT IDENTITY PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Mobile_no VARCHAR(15),
    Salary DECIMAL(10,2),
    Department_id INT,
    FOREIGN KEY (Department_id) REFERENCES Department(Department_id)
);

INSERT INTO Faculty (Name, Mobile_no, Salary, Department_id)
VALUES ('Ali','9779551111',5000,1),
       ('Ahmed','9779552222',6000,2),
	    ('MARYAM','98745645',40000,3)
	   ;

SELECT * FROM Faculty;


-------------------------
--- TABLE Hostel-----
------------------------
CREATE TABLE Hostel (
    Hostel_id INT IDENTITY PRIMARY KEY,
    Hostel_name VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    Address VARCHAR(200),
    Pin_code VARCHAR(10),
    No_of_seats INT
);


INSERT INTO Hostel (Hostel_name, City, State, Address, Pin_code, No_of_seats)
VALUES
('A_Hostel','Muscat','Oman','Street 1','12345',50),
('B_Hostel','Sohar','Oman','Street 2','54321',60);


SELECT * FROM Hostel;



-------------------------
---- TABLE Student-----
------------------------
CREATE TABLE Student (
    S_id INT IDENTITY(1,1) PRIMARY KEY,
    F_name VARCHAR(50) NOT NULL,
    L_name VARCHAR(50) NOT NULL,
    Phone_no VARCHAR(15),
    DOB DATE,
    Department_id INT,
    Hostel_id INT,
    FOREIGN KEY (Department_id) REFERENCES Department(Department_id),
    FOREIGN KEY (Hostel_id) REFERENCES Hostel(Hostel_id)
);
INSERT INTO Student (F_name, L_name, Phone_no, DOB, Department_id, Hostel_id)
VALUES
('AMANI','ABDULAAH','9779551010','2000-01-01',1,1),
('EBTESAM','OBAID','9779552020','2001-02-02',2,2),
('Ali','AHMED','9779553030','2000-03-03',1,1),
('Sara','Ahmed','9779554040','2002-04-04',3,2);


SELECT *FROM Student;


---------------------------
---- COURSETABLE -------
---------------------------

CREATE TABLE Course (
    Course_id INT IDENTITY PRIMARY KEY,
    Course_name VARCHAR(100),
    Duration VARCHAR(50),
    Department_id INT,
    FOREIGN KEY (Department_id) REFERENCES Department(Department_id)
);


INSERT INTO Course (Course_name, Duration, Department_id)
VALUES
('Database Systems','4 months',1),
('Calculus','6 months',2),
('Physics I','5 months',3);


SELECT * FROM Course;



-----------------------
---TABLE Subject----
--------------------
CREATE TABLE Subject (
    Subject_id INT IDENTITY PRIMARY KEY,
    Subject_name VARCHAR(100),
    Course_id INT,
    Faculty_id INT,
    FOREIGN KEY (Course_id) REFERENCES Course(Course_id),
    FOREIGN KEY (Faculty_id) REFERENCES Faculty(F_id)
);



INSERT INTO Subject (Subject_name, Course_id, Faculty_id)
VALUES
('SQL','1',1),
('Advanced Calculus','2',2),
('Mechanics','3',4);


SELECT * FROM Subject;




-----------------------
---TABLE Exams----
--------------------
CREATE TABLE Exams (
    Exam_code INT IDENTITY PRIMARY KEY,
    Exam_date DATE,
    Exam_time TIME,
    Room VARCHAR(20),
    Department_id INT,
    FOREIGN KEY (Department_id) REFERENCES Department(Department_id)
);


INSERT INTO Exams (Exam_date, Exam_time, Room, Department_id)
VALUES
('2025-12-20','09:00','Room A',1),
('2025-12-21','14:00','Room B',2);


SELECT * FROM Exams;




-----------------------
---TABLE Student_Course----
--------------------
CREATE TABLE Student_Course (
    S_id INT,
    Course_id INT,
    PRIMARY KEY (S_id, Course_id),
    FOREIGN KEY (S_id) REFERENCES Student(S_id),
    FOREIGN KEY (Course_id) REFERENCES Course(Course_id)
);


INSERT INTO Student_Course (S_id, Course_id)
VALUES
(1,1),
(2,2),
(3,1),
(4,3);


SELECT * FROM Student_Course;





-----------------------
---TABLE Student_Exam----
--------------------

CREATE TABLE Student_Exam (
    S_id INT,
    Exam_code INT,
    PRIMARY KEY (S_id, Exam_code),
    FOREIGN KEY (S_id) REFERENCES Student(S_id),
    FOREIGN KEY (Exam_code) REFERENCES Exams(Exam_code)
);


INSERT INTO Student_Exam (S_id, Exam_code)
VALUES
(1,1),
(2,2),
(3,1),
(4,2);


SELECT * FROM Student_Exam;

