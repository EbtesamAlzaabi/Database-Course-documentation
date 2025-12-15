CREATE DATABASE HOTAL_SYSTEM20;
USE HOTAL_SYSTEM20;




---------------
---BRANCH-TABLE---
---------------

CREATE TABLE Branch_TABLE (
    branch_id INT IDENTITY(1,1) PRIMARY KEY,
    bname VARCHAR(100) NOT NULL,
    blocation VARCHAR(200) NOT NULL
);


INSERT INTO Branch_TABLE (bname, blocation)
VALUES
('ali','muscat'),
('ASMA','SOHAR'),
('EBTESAM','SAHM');

SELECT * FROM Branch_TABLE;



---------------
---Room-TABLE---
---------------
CREATE TABLE Room_TABLE (
    room_id INT IDENTITY(1,1) PRIMARY KEY,
    branch_id INT NOT NULL,
    room_number VARCHAR(10) NOT NULL,
    room_type VARCHAR(50),
    nightly_rate DECIMAL(10,2)
);

INSERT INTO Room_TABLE (branch_id, room_number, room_type, nightly_rate)
VALUES
(1, '101','Single',10000.00),
(1, '102','Double',150000.00),
(2, '201','Single', 950000.00);

SELECT * FROM Room_TABLE;






---------------
---Customer-TABLE---
---------------
CREATE TABLE Customer_TABLE (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100)
);
INSERT INTO Customer_TABLE (full_name, phone, email)
VALUES
('AHMAD', '987456', 'AHMAD@example.com'),
(' FATMA', '123456', 'FATMA@example.com'),
('Ali', '258963', 'ali@example.com'),
('Sara', '147852', 'sara@example.com');


SELECT * FROM Customer_TABLE;


---------------
---Booking-TABLE---
---------------

CREATE TABLE Booking_TABLE (
    booking_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer_TABLE(customer_id)
);

INSERT INTO Booking_TABLE (customer_id, check_in_date, check_out_date)
VALUES
(1, '2025-01-10', '2025-01-15'),
(2, '2025-02-05', '2025-02-10'),
(3, '2025-03-12', '2025-03-18'),
(1, '2025-04-01', '2025-04-05');


SELECT * FROM Booking_TABLE;


---------------
---Booking_Room-TABLE---
---------------
CREATE TABLE Booking_Room_TABLE (
    booking_id INT NOT NULL,
    room_id INT NOT NULL,
    PRIMARY KEY (booking_id, room_id),
    FOREIGN KEY (booking_id) REFERENCES Booking_TABLE(booking_id),
    FOREIGN KEY (room_id) REFERENCES Room_TABLE(room_id)
);
INSERT INTO Booking_Room_TABLE (booking_id, room_id)
VALUES
(1, 1),  -- booking 1 FOR room 1
(1, 2),  -- booking 1 FOR room 2
(2, 3),  -- booking 2 FOR room 3
(3, 1);  -- booking 3 FOR room 1 again


SELECT *
FROM Booking_Room_TABLE;



---------------
---Staff-TABLE---
---------------
CREATE TABLE Staff (
    staff_id INT IDENTITY(1,1) PRIMARY KEY,
    branch_id INT NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    job_title VARCHAR(50),
    salary DECIMAL(10,2),
    FOREIGN KEY (branch_id) REFERENCES Branch_TABLE(branch_id)
);


INSERT INTO Staff (branch_id, full_name, job_title, salary)
VALUES
(1, 'Ahmed ', 'Manager', 5000.00),
(1, 'Fatma ', 'Receptionist', 3000.00),
(2, 'Omar ', 'Housekeeper', 2800.00),
(3, 'Huda ', 'Front Desk', 3200.00),
(3, 'MARYAM ', 'Concierge', 3100.00);


SELECT * FROM Staff;




---------------
---StaffCustomerAction-TABLE---
---------------

CREATE TABLE StaffCustomerAction_TABLE (
    staff_id INT NOT NULL,
    customer_id INT NOT NULL,
    action_datetime DATETIME NOT NULL,
    action_role VARCHAR(20), -- 'check-in' or 'check-out'
    PRIMARY KEY (staff_id, customer_id, action_datetime),
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id),
    FOREIGN KEY (customer_id) REFERENCES Customer_TABLE(customer_id)
);

INSERT INTO StaffCustomerAction_TABLE (staff_id, customer_id, action_datetime, action_role)
VALUES
(1, 1, '2025-01-10 14:00', 'check-in'),
(2, 2, '2025-02-05 15:30', 'check-in'),
(1, 1, '2025-01-15 10:00', 'check-out'),
(3, 3, '2025-03-12 13:45', 'check-in');


SELECT *
FROM StaffCustomerAction_TABLE;



;



-------

--DQL ----
-------

--1--

SELECT * 
FROM Customer_TABLE;


---2----
ALTER TABLE Customer_TABLE
ADD proof_id_type VARCHAR(50);

UPDATE Customer_TABLE
SET proof_id_type = CASE
    WHEN customer_id = 1 THEN 'Passport'
    WHEN customer_id = 2 THEN 'National ID'
    WHEN customer_id = 3 THEN 'Driver License'
    WHEN customer_id = 4 THEN 'Passport'
    ELSE NULL
END;
SELECT
    full_name AS GuestName,
    phone AS ContactNumber,
    proof_id_type AS ProofIDType
FROM Customer_TABLE;

);

---3-----
ALTER TABLE Booking_TABLE
ADD status VARCHAR(20),
    total_cost DECIMAL(10,2);

	UPDATE Booking_TABLE
SET status = 'Confirmed',
    total_cost = DATEDIFF(day, check_in_date, check_out_date) * 100.00;

	SELECT
    booking_id,
    check_in_date AS BookingDate,
    status,
    total_cost AS TotalCost
FROM Booking_TABLE;


----4-----
SELECT
    room_number AS RoomNumber,
    nightly_rate AS NightlyRate
FROM Room_TABLE;



----5-----
SELECT
    room_number AS RoomNumber,
    nightly_rate AS NightlyRate
FROM Room_TABLE
WHERE nightly_rate > 10000;



---6----
SELECT *
FROM Staff
WHERE job_title = 'Receptionist';

----7----
SELECT *
FROM Booking_TABLE
WHERE YEAR(check_in_date) = 2024;


---8----
SELECT
    booking_id,
    customer_id,
    check_in_date,
    check_out_date,
    total_cost
FROM Booking_TABLE
ORDER BY total_cost DESC;

----9---
SELECT
    MAX(nightly_rate) AS MaxPrice,
    MIN(nightly_rate) AS MinPrice,
    AVG(nightly_rate) AS AvgPrice
FROM Room_TABLE;


---10---
SELECT COUNT(*) AS TotalRooms
FROM Room_TABLE;


---11---
SELECT *
FROM Customer_TABLE
WHERE full_name LIKE 'M%';
