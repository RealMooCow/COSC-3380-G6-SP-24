CREATE TABLE Books (
    BookID INT NOT NULL AUTO_INCREMENT,
    Title VARCHAR(255) NOT NULL,
    Authors VARCHAR(255) NOT NULL,
    ISBN VARCHAR(255) NOT NULL,
    PublicationDate DATE NOT NULL,
    Genre VARCHAR(100),
    Edition VARCHAR(100),
    Publisher VARCHAR(255),
    Language VARCHAR(50),
    PageCount INT,
    Description TEXT,
    CoverImageURL VARCHAR(255),
    AvailabilityStatus VARCHAR(50) NOT NULL,
    LocationShelf VARCHAR(100),
    Price DECIMAL(10,2),
    AverageRating DECIMAL(3,2),
    TotalRatings INT,
    CreatedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UpdatedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (BookID)
);

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender VARCHAR(10),
    Address VARCHAR(100),
    ContactNumber VARCHAR(20),
    EmailAddress VARCHAR(100),
    GuardiansName VARCHAR(100),
    GuardiansContactNumber VARCHAR(20),
    GradeYearLevel VARCHAR(20) NOT NULL,
    Section VARCHAR(50),
    SchoolIDNumber VARCHAR(50) NOT NULL,
    DateEnrolled DATE NOT NULL,
    Status VARCHAR(20) NOT NULL,
    CreatedDate DATETIME NOT NULL,
    UpdatedDate DATETIME NOT NULL
);

CREATE TABLE Library_Staff (
    StaffID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE,
    Gender ENUM('Male', 'Female', 'Other'),
    Address VARCHAR(255),
    ContactNumber VARCHAR(20),
    EmailAddress VARCHAR(100),
    Position VARCHAR(100) NOT NULL,
    Department VARCHAR(100) NOT NULL,
    JoiningDate DATE NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL,
    SupervisorID INT,
    Status ENUM('Active', 'Inactive', 'On Leave') NOT NULL,
    CreatedDate DATETIME NOT NULL,
    UpdatedDate DATETIME NOT NULL
);

CREATE TABLE Transactions (
    TransactionID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT NOT NULL,
    MemberID INT NOT NULL,
    TransactionType VARCHAR(50) NOT NULL,
    TransactionDate DATETIME NOT NULL,
    DueDate DATETIME,
    ReturnDate DATETIME,
    ReservationExpiryDate DATETIME,
    TransactionStatus VARCHAR(50) NOT NULL,
    FineAmount DECIMAL(10, 2),
    FinePaid BOOLEAN NOT NULL DEFAULT FALSE,
    FinePaidDate DATETIME,
    Notes TEXT,
    CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    UpdatedDate DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Students(StudentID)
);

CREATE TABLE Fines (
    FineID INT PRIMARY KEY AUTO_INCREMENT,
    TransactionID INT NOT NULL,
    MemberID INT NOT NULL,
    FineAmount DECIMAL(10, 2) NOT NULL,
    FineDate DATETIME NOT NULL,
    DueDate DATETIME NOT NULL,
    PaymentStatus ENUM('Paid', 'Unpaid') NOT NULL,
    PaymentDate DATETIME,
    Notes TEXT,
    CreatedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UpdatedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (TransactionID) REFERENCES Transactions(TransactionID),
    FOREIGN KEY (MemberID) REFERENCES Students(StudentID)
);

CREATE TABLE Library_Events (
    EventID INT AUTO_INCREMENT PRIMARY KEY,
    EventName VARCHAR(255) NOT NULL,
    Description TEXT,
    EventDate DATETIME NOT NULL,
    EventLocation VARCHAR(255),
    Organizer VARCHAR(255) NOT NULL,
    ContactEmail VARCHAR(255) NOT NULL,
    ContactPhone VARCHAR(20),
    MaxAttendees INT,
    CurrentAttendees INT,
    RegistrationRequired BOOLEAN NOT NULL DEFAULT FALSE,
    RegistrationDeadline DATETIME,
    EventStatus VARCHAR(50) NOT NULL,
    CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    UpdatedDate DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

