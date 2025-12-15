CREATE DATABASE HotalDB;
USE HotalDB;


---------------
--TB-Branch----
---------------
CREATE TABLE Branch (
    BranchID INT PRIMARY KEY IDENTITY(1,1),
    BranchName VARCHAR(100) NOT NULL,
    Location1 VARCHAR(150) NOT NULL
)
INSERT INTO Branch (BranchID,BranchName,Location1)
values (101,'ali','muscat'),
       (102,'mohamed','suhar');


	   select * from Branch;


---------------
--TB-Room----
---------------
CREATE TABLE Room (
    RoomID INT PRIMARY KEY,
    RoomNumber VARCHAR(10) NOT NULL,
    RoomType VARCHAR(50),
    NightlyRate DECIMAL(10,2),
    BranchID INT NOT NULL,
    UNIQUE (BranchID, RoomNumber),
    FOREIGN KEY (BranchID) REFERENCES Branch(BranchID)
);

INSERT INTO Room (RoomID,RoomNumber,RoomType,NightlyRate,BranchID)
values (100, 'cb101','big',200.000,2000);


	   select * from Room;


---------------
--TB-Customer----
---------------
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    CUSName VARCHAR(100) NOT NULL,
    Phone VARCHAR(20),
    Email VARCHAR(100) UNIQUE
);
INSERT INTO Customer (CustomerID,CUSName,Phone,Email)
values (101,'ALI',987654 ,'WWW.WWW.WWW');

	   select * from Customer;

---------------
--TB-Booking----
---------------
CREATE TABLE Booking (
    BookingID INT PRIMARY KEY,
    CheckInDate DATE NOT NULL,
    CheckOutDate DATE NOT NULL,
    CustomerID INT NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    CHECK (CheckOutDate > CheckInDate)
);

INSERT INTO Booking (BookingID,CheckInDate,CheckOutDate,CustomerID)
values (222,'20-2-2021','30-20-2021',101);

	   select * from Booking;


---------------
--TB-BookingRoom----
---------------
CREATE TABLE BookingRoom (
    BookingID INT,
    RoomID INT,
    PRIMARY KEY (BookingID, RoomID),
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID),
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID)
);

INSERT INTO BookingRoom (BookingID,RoomID)
values (222,101);

	   select * from BookingRoom;


---------------
--TB-Staff----
---------------
CREATE TABLE Staff (
    StaffID INT PRIMARY KEY,
    STAName VARCHAR(100) NOT NULL,
    JobTitle VARCHAR(50),
    Salary DECIMAL(10,2),
    BranchID INT NOT NULL,
    FOREIGN KEY (BranchID) REFERENCES Branch(BranchID)
);

INSERT INTO Staff (StaffID,STAName,JobTitle,Salary,BranchID)
values (111,'a','manager',500,100);

	   select * from Staff;


---------------
--TB-StaffBookingAction----
---------------
CREATE TABLE StaffBookingAction (
    StaffID INT,
    BookingID INT,
    ActionType VARCHAR(20) CHECK (ActionType IN ('check-in', 'check-out')),
    ActionDateTime DATETIME NOT NULL,
    PRIMARY KEY (StaffID, BookingID, ActionType),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID),
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID)
);



INSERT INTO StaffBookingAction (StaffID,BookingID,ActionType,ActionDateTime)
values (111,22,'manager','2-2-2021');

	   select * from StaffBookingAction;

