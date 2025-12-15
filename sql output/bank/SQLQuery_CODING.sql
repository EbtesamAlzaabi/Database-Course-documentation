CREATE DATABASE bank_database;
use bank_database;



------
---Branch_table---
------
CREATE TABLE Branch_table (
    branch_id INT IDENTITY PRIMARY KEY,
    address VARCHAR(200) NOT NULL,
    phone_number VARCHAR(20)
);

INSERT INTO Branch_table (address, phone_number)
VALUES
('123 sur St, alsharqia', '977123450'),
('Al Khuwair Rd, Muscat', '977234561'),
('Sohar Commercial Rd, Sohar', '977345672'),
('Nizwa Old Town, Nizwa', '977456783'),
('Salalah Beach Rd, Salalah', '977567894');

SELECT * FROM Branch_table;




------
---Customer_table---
------
CREATE TABLE Customer_table1 (
    customer_id INT IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(200),
    phone_number VARCHAR(20),
    date_of_birth DATE
);
INSERT INTO Customer_table1(name, address, phone_number, date_of_birth)
VALUES
('ebtesam', '123 bebo, Muscat', '977001122', '1998-04-12'),
('Fatma ', '45 Sohar St, Sohar', '977334455', '1992-08-23'),
('Omar', '67 Nizwa Rd, Nizwa', '977556677', '1978-11-05'),
('Amani ', '89 swaiq Ave, albatinh', '977778899', '1989-01-20');

SELECT * FROM Customer_table1;


------
---Account_table---
------
CREATE TABLE Account_table (
    account_number INT IDENTITY PRIMARY KEY,
    customer_id INT NOT NULL,
    balance DECIMAL(15,2) NOT NULL,
    type VARCHAR(20) NOT NULL,   -- 'savings' or 'checking'
    date_creation DATE,
    FOREIGN KEY (customer_id) REFERENCES Customer_table1(customer_id)
);


INSERT INTO Account_table (customer_id, balance, type, date_creation)
VALUES
(1, 5000.00, 'savings', '2023-01-15'),
(1, 1200.00, 'checking', '2024-07-10'),
(2, 8000.00, 'savings', '2022-03-20'),
(3, 300.00, 'checking', '2025-02-05'),
(4, 15000.00, 'savings', '2023-11-11');

SELECT * FROM Account_table;



------
---Transaction_table---
------

CREATE TABLE Transaction_table (
    transaction_id INT IDENTITY PRIMARY KEY,
    account_number INT NOT NULL,
    transaction_date DATE NOT NULL,
    amount DECIMAL(15,2) NOT NULL,
    transaction_type VARCHAR(50),
    FOREIGN KEY (account_number) REFERENCES Account_table(account_number)
);
INSERT INTO Transaction_table (account_number, transaction_date, amount, transaction_type)
VALUES
(1, '2025-01-05', 500.00, 'Deposit'),
(1, '2025-01-10', 200.00, 'Withdrawal'),
(2, '2025-05-12', 1000.00, 'Deposit'),
(3, '2025-07-20', 150.00, 'Withdrawal'),
(4, '2025-08-01', 3000.00, 'Deposit');

SELECT * FROM Transaction_table;

------
---Employee_table---
------

CREATE TABLE Employee_table (
    employee_id INT IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    position VARCHAR(50),
    branch_id INT NOT NULL,
    FOREIGN KEY (branch_id) REFERENCES Branch_table(branch_id)
);
INSERT INTO Employee_table (name, position, branch_id)
VALUES
('Ahmed ', 'Manager', 1),
('Huda ', 'Loan Officer', 1),
('Khalid ', 'Teller', 2),
('Noura ', 'Customer Service', 3);

SELECT * FROM Employee_table;


------
---Loan_table---
------
CREATE TABLE Loan_table (
    loan_id INT IDENTITY PRIMARY KEY,
    customer_id INT NOT NULL,
    employee_id INT NOT NULL,
    loan_type VARCHAR(50),
    amount DECIMAL(15,2) NOT NULL,
    issue_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer_table1(customer_id),
    FOREIGN KEY (employee_id) REFERENCES Employee_table(employee_id)
);
INSERT INTO Loan_table (customer_id, employee_id, loan_type, amount, issue_date)
VALUES
(1, 2, 'Home Loan', 25000.00, '2024-06-15'),
(2, 2, 'Car Loan', 10000.00, '2025-03-10'),
(4, 4, 'Personal Loan', 5000.00, '2025-05-20');


SELECT * FROM Loan_table;

------
---EmployeeCustomerAction_table---
------
CREATE TABLE EmployeeCustomerAction_table (
    employee_id INT NOT NULL,
    customer_id INT NOT NULL,
    action_type VARCHAR(100),
    action_date DATE,
    PRIMARY KEY (employee_id, customer_id, action_date),
    FOREIGN KEY (employee_id) REFERENCES Employee_table(employee_id),
    FOREIGN KEY (customer_id) REFERENCES Customer_table1(customer_id)
);

INSERT INTO EmployeeCustomerAction_table (employee_id, customer_id, action_type, action_date)
VALUES
(1, 1, 'Opened Account', '2025-10-01'),
(2, 1, 'Processed Loan', '2025-10-05'),
(3, 2, 'Opened Account', '2025-11-12'),
(4, 3, 'Processed Loan', '2025-11-15');

SELECT *
FROM EmployeeCustomerAction_table;


