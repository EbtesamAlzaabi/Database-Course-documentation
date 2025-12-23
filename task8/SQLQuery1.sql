CREATE DATABASE CAMPDB;
USE CAMPDB;

---1----

CREATE TABLE Employee (
    SSN INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Birthdate DATE,
    Gender BIT DEFAULT 0,
    SuperID INT,
    FOREIGN KEY (SuperID) REFERENCES Employee(SSN)
);

INSERT INTO Employee(FirstName, LastName, Birthdate, Gender)
VALUES
('Ahmed', 'Ali', '1985-04-12', 1),
('Omar', 'Hassan', '1990-09-23', 0),
('Fatima', 'Salim', '1978-01-30', 1),
('Yusuf', 'Khalid', '1988-06-18', 0),
('Layla', 'Mahmoud', '1995-12-05', 1);


select*from Employee;

SELECT
    Dnum        AS DepartmentID,
    Dname       AS DepartmentName,
    EmpSSN       AS ManagerID,
    e.FirstName + ' ' + e.LastName AS ManagerFullName
FROM Department808 d JOIN Employee e
    ON d.EmpSSN = e.SSN;



----2----

CREATE TABLE Department808 (
    Dnum INT PRIMARY KEY IDENTITY(1,1),
    Dname NVARCHAR(50) NOT NULL,
    HiringDate DATE,
    EmpSSN INT,
    FOREIGN KEY (EmpSSN) REFERENCES Employee(SSN)
);
ALTER TABLE Employee
ADD Dnum INT NOT NULL,
FOREIGN KEY (Dnum) REFERENCES Department(Dnum)
;

INSERT INTO Department808 (Dname, HiringDate, EmpSSN)
VALUES
('Human Resources', '2020-05-01', 1),
('Finance', '2019-03-15', 2),
('Information Technology', '2021-07-20', 3),
('Marketing', '2022-02-10', 4),
('Operations', '2018-11-25', 5);


select*from Department808;

SELECT
    d.Dname  AS DepartmentName,
    p.Pname  AS ProjectName
FROM Department808 d JOIN Project p
    ON d.Dnum = p.Dnum;




----3----

CREATE TABLE DLocation_tab (
    Dnum INT NOT NULL,
    Dlocation NVARCHAR(50) NOT NULL,
    PRIMARY KEY (Dnum, Dlocation),
    FOREIGN KEY (Dnum) REFERENCES Department808(Dnum)
);


INSERT INTO DLocation_tab (Dnum, Dlocation)
VALUES
(1, 'Building A'),
(2, 'Building B'),
(3, 'Building C'),
(4, 'Building D'),
(5, 'Headquarters');


select*from DLocation_tab;

-----4-----

CREATE TABLE Project (
    Pnum INT PRIMARY KEY IDENTITY(1,1),
    Pname NVARCHAR(50) NOT NULL,
    PLocation NVARCHAR(50),
    City NVARCHAR(50),
    Dnum INT NOT NULL,
    FOREIGN KEY (Dnum) REFERENCES Department808(Dnum)
);

INSERT INTO Project (Pname, PLocation, City, Dnum)
VALUES
('Payroll System', 'Main Office', 'Muscat', 2),
('Website Upgrade', 'Remote', 'Sohar', 3),
('Recruitment Drive', 'Branch Office', 'Nizwa', 1),
('Marketing Campaign', 'Main Office', 'Muscat', 4),
('Logistics Optimization', 'Warehouse', 'Barka', 5);

select*from Project;

----5----

CREATE TABLE EMPDependent (
    DepID INT PRIMARY KEY IDENTITY(1,1),
    EmpSSN INT NOT NULL,
    Dnum INT NOT NULL,
    Gender BIT DEFAULT 0,
    DBirthdate DATE,
    FOREIGN KEY (EmpSSN) REFERENCES Employee(SSN),
    FOREIGN KEY (Dnum) REFERENCES Department808(Dnum)
);

INSERT INTO EMPDependent (EmpSSN, Dnum, Gender, DBirthdate)
VALUES
(1, 1, 0, '2010-06-15'),
(2, 2, 1, '2012-11-03'),
(3, 3, 0, '2015-09-25'),
(4, 4, 1, '2018-04-12'),
(5, 5, 0, '2016-07-30');

select*from EMPDependent;


----6-----


CREATE TABLE WorkingHours (
    EmpSSN INT NOT NULL,
    Pnum INT NOT NULL,
    NumWhours DECIMAL(4,1),
    PRIMARY KEY (EmpSSN, Pnum),
    FOREIGN KEY (EmpSSN) REFERENCES Employee(SSN),
    FOREIGN KEY (Pnum) REFERENCES Project(Pnum)
);

INSERT INTO WorkingHours (EmpSSN, Pnum, NumWhours)
VALUES
(1, 1, 40.0),
(2, 2, 35.5),
(3, 3, 42.0),
(4, 4, 38.0),
(5, 5, 45.0);

select*from WorkingHours;

----- JOIN----

SELECT
    d.DepID,
    d.EmpSSN,
    d.Dnum,
    d.Gender,
    d.DBirthdate,
    e.FirstName + ' ' + e.LastName AS EmployeeFullName
FROM EMPDependent d  JOIN Employee e
    ON d.EmpSSN = e.SSN;


	--- --

	SELECT
    Pnum      AS ProjectID,
    Pname     AS ProjectName,
    PLocation AS ProjectLocation
FROM Project
WHERE City IN ('Muscat', 'Muscat');


--
SELECT *
FROM Project
WHERE Pname LIKE 'M%';


---

SELECT
    e.SSN AS EmployeeID,
    e.FirstName + ' ' + e.LastName AS EmployeeName,
    d.Dname AS DepartmentName
FROM Employee e
JOIN Department808 d
    ON e.Dnum = d.Dnum;

  ALTER TABLE Employee
ADD Salary DECIMAL(8,2);

UPDATE Employee
SET Salary = 1500
WHERE SSN = 1;

INSERT INTO Employee
VALUES ('Ahmed', 'Ali', '1985-04-12', 1, 2)

SELECT
    SSN AS EmployeeID,
    FirstName + ' ' + LastName AS EmployeeName
FROM Employee;


----

SELECT
    e.FirstName + ' ' + e.LastName AS EmployeeName
FROM Employee e
JOIN WorkingHours w
    ON e.SSN = w.EmpSSN
JOIN Project p
    ON w.Pnum = p.Pnum
WHERE e.Dnum = 10
  AND p.Pname = 'Payroll System'
  AND w.NumWhours >= 10;


  ALTER TABLE Employee
ADD Dnum INT;

ALTER TABLE Employee
ADD CONSTRAINT FK_Employee_Department
FOREIGN KEY (Dnum) REFERENCES Department808(Dnum);

UPDATE Employee
SET Dnum = 1 WHERE SSN = 1;
UPDATE Employee
SET Dnum = 2 WHERE SSN = 2;
UPDATE Employee
SET Dnum = 3 WHERE SSN = 3;
UPDATE Employee
SET Dnum = 4 WHERE SSN = 4;
UPDATE Employee
SET Dnum = 5 WHERE SSN = 5;

SELECT
    e.FirstName + ' ' + e.LastName AS EmployeeName
FROM Employee e
JOIN WorkingHours w
    ON e.SSN = w.EmpSSN
JOIN Project p
    ON w.Pnum = p.Pnum
WHERE e.Dnum = 10
  AND p.Pname = 'Payroll System'
  AND w.NumWhours >= 10;

  SELECT
    e.FirstName + ' ' + e.LastName AS EmployeeName
FROM Employee e
JOIN WorkingHours w
    ON e.SSN = w.EmpSSN
JOIN Project p
    ON w.Pnum = p.Pnum
WHERE e.Dnum = 10
  AND p.Pname = 'AL Rabwah'
  AND w.NumWhours >= 10;


  SELECT
    e.FirstName + ' ' + e.LastName AS EmployeeName
FROM Employee e
JOIN Employee s
    ON e.SuperID = s.SSN
WHERE s.FirstName = 'Fatima'
  AND s.LastName = 'Salim';


  ---
  SELECT
    e.FirstName + ' ' + e.LastName AS EmployeeName,
    p.Pname AS ProjectName
FROM Employee e
JOIN WorkingHours w
    ON e.SSN = w.EmpSSN
JOIN Project p
    ON w.Pnum = p.Pnum
ORDER BY p.Pname;


---
SELECT
    p.Pnum AS ProjectNumber,
    d.Dname AS DepartmentName,
    m.LastName AS ManagerLastName,
    m.SSN AS ManagerID,
    m.Birthdate AS ManagerBirthdate
FROM Project p
JOIN Department808 d
    ON p.Dnum = d.Dnum
JOIN Employee m
    ON d.EmpSSN = m.SSN
WHERE p.City = 'Muscat';


----

SELECT e.*
FROM Employee e
WHERE e.SSN IN (
    SELECT EmpSSN
    FROM Department808
    WHERE EmpSSN IS NOT NULL
);



------

SELECT
    e.SSN AS EmployeeID,
    e.FirstName + ' ' + e.LastName AS EmployeeName,
    d.DepID AS DependentID,
    d.Gender AS DependentGender,
    d.DBirthdate AS DependentBirthdate
FROM Employee e
LEFT JOIN EMPDependent d
    ON e.SSN = d.EmpSSN
ORDER BY e.SSN;
