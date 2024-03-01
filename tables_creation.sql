CREATE TABLE `Books` (
  `BookID` int unsigned NOT NULL,
  `Title` varchar(255) NOT NULL,
  `Authors` varchar(255) NOT NULL,
  `ISBN` int unsigned NOT NULL,
  `PublicationDate` date NOT NULL,
  `Genre` varchar(100) DEFAULT NULL,
  `Edition` varchar(100) DEFAULT NULL,
  `Publisher` varchar(255) DEFAULT NULL,
  `Language` varchar(50) DEFAULT NULL,
  `PageCount` int unsigned DEFAULT NULL,
  `Description` text,
  `CoverImageURL` varchar(255) DEFAULT NULL,
  `AvailabilityStatus` varchar(50) NOT NULL,
  `LocationShelf` varchar(100) DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `AverageRating` decimal(3,2) DEFAULT NULL,
  `TotalRatings` int DEFAULT NULL,
  `CreatedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdatedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Stock` int unsigned NOT NULL,
  `NumberCheckedOut` int unsigned NOT NULL,
  `NumberHeld` int unsigned NOT NULL,
  `NumberAvailable` int unsigned NOT NULL,
  PRIMARY KEY (`ISBN`)
);

CREATE TABLE `Computer` (
  `ComputerNumber` int NOT NULL,
  `CheckedOut` tinyint(1) DEFAULT NULL,
  `TimeCheckedOut` int DEFAULT NULL,
  PRIMARY KEY (`ComputerNumber`)
);

CREATE TABLE `DigitalMediaItem` (
  `CallNumber` varchar(255) NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Producer` varchar(255) DEFAULT NULL,
  `Stock` int unsigned NOT NULL,
  `NumberCheckedOut` int unsigned NOT NULL DEFAULT '0',
  `NumberHeld` int unsigned NOT NULL DEFAULT '0',
  `NumberAvailable` int unsigned NOT NULL,
  PRIMARY KEY (`CallNumber`)
);

CREATE TABLE `Faculty` (
  `FacultyID` int NOT NULL,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `DateOfBirth` date NOT NULL,
  `Gender` enum('Man','Woman','Nonbinary','Gender Queer','Gender Nonconformng','Other') NOT NULL,
  `Address` varchar(100) DEFAULT NULL,
  `ContactNumber` varchar(20) DEFAULT NULL,
  `EmailAddress` varchar(100) NOT NULL,
  `Department` varchar(50) NOT NULL,
  `Position` varchar(20) NOT NULL,
  `SchoolIDNumber` varchar(50) NOT NULL,
  `DateHired` date NOT NULL,
  `Status` varchar(20) NOT NULL,
  `CreatedDate` datetime NOT NULL,
  `UpdatedDate` datetime NOT NULL,
  PRIMARY KEY (`FacultyID`)
);

CREATE TABLE `Fines` (
  `FineID` int NOT NULL AUTO_INCREMENT,
  `TransactionID` int NOT NULL,
  `MemberID` int NOT NULL,
  `FineAmount` decimal(10,2) NOT NULL,
  `FineDate` datetime NOT NULL,
  `DueDate` datetime NOT NULL,
  `PaymentStatus` enum('Paid','Unpaid') NOT NULL,
  `PaymentDate` datetime DEFAULT NULL,
  `Notes` text,
  `CreatedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdatedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `TypeOfFine` enum('Late','damaged','lost') NOT NULL,
  PRIMARY KEY (`FineID`),
  KEY `TransactionID` (`TransactionID`),
  KEY `MemberID` (`MemberID`),
  CONSTRAINT `fines_ibfk_1` FOREIGN KEY (`TransactionID`) REFERENCES `transactions` (`TransactionID`),
  CONSTRAINT `fines_ibfk_2` FOREIGN KEY (`MemberID`) REFERENCES `students` (`StudentID`)
);

CREATE TABLE `Holds` (
  `HoldID` int NOT NULL AUTO_INCREMENT,
  `StudentID` int DEFAULT NULL,
  `FacultyID` int DEFAULT NULL,
  `BookISBN` int unsigned DEFAULT NULL,
  `DigitalCallNum` varchar(225) DEFAULT NULL,
  `SerialISSN` int unsigned DEFAULT NULL,
  `Pending` tinyint NOT NULL,
  `HoldPosted` datetime NOT NULL,
  `CheckInDate` date DEFAULT NULL,
  `ExprirationDate` date DEFAULT NULL,
  `HoldResult` enum('Checked Out','Hold Expired','Voided') DEFAULT NULL,
  PRIMARY KEY (`HoldID`),
  KEY `StudentHold_idx` (`StudentID`),
  KEY `BookHold_idx` (`BookISBN`),
  KEY `DigiHold_idx` (`DigitalCallNum`),
  KEY `SerialHold_idx` (`SerialISSN`),
  KEY `FacultyHold_idx` (`FacultyID`),
  CONSTRAINT `BookHold` FOREIGN KEY (`BookISBN`) REFERENCES `books` (`ISBN`),
  CONSTRAINT `DigiHold` FOREIGN KEY (`DigitalCallNum`) REFERENCES `digitalmediaitem` (`CallNumber`),
  CONSTRAINT `FacultyHold` FOREIGN KEY (`FacultyID`) REFERENCES `faculty` (`FacultyID`),
  CONSTRAINT `SerialHold` FOREIGN KEY (`SerialISSN`) REFERENCES `serialpublication` (`ISSN`),
  CONSTRAINT `StudentHold` FOREIGN KEY (`StudentID`) REFERENCES `students` (`StudentID`)
);

CREATE TABLE `LibraryEvents` (
  `EventID` int NOT NULL AUTO_INCREMENT,
  `EventName` varchar(255) NOT NULL,
  `Description` text,
  `EventDate` datetime NOT NULL,
  `EventLocation` varchar(255) DEFAULT NULL,
  `Organizer` varchar(255) NOT NULL,
  `ContactEmail` varchar(255) NOT NULL,
  `ContactPhone` varchar(20) DEFAULT NULL,
  `MaxAttendees` int DEFAULT NULL,
  `CurrentAttendees` int DEFAULT NULL,
  `RegistrationRequired` tinyint(1) NOT NULL DEFAULT '0',
  `RegistrationDeadline` datetime DEFAULT NULL,
  `EventStatus` varchar(50) NOT NULL,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `UpdatedDate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`EventID`)
);

CREATE TABLE `LibraryStaff` (
  `StaffID` int unsigned NOT NULL,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `DateOfBirth` date DEFAULT NULL,
  `Gender` enum('Man','Woman','Nonbinary','Gender Queer','Gender Nonconformng','Other') DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `ContactNumber` varchar(20) DEFAULT NULL,
  `EmailAddress` varchar(100) DEFAULT NULL,
  `Position` varchar(100) NOT NULL,
  `Department` varchar(100) NOT NULL,
  `JoiningDate` date NOT NULL,
  `Salary` decimal(10,2) NOT NULL,
  `SupervisorID` int unsigned DEFAULT NULL,
  `Status` enum('Active','Inactive','On Leave') NOT NULL,
  `CreatedDate` datetime NOT NULL,
  `UpdatedDate` datetime NOT NULL,
  PRIMARY KEY (`StaffID`),
  KEY `SupervisorID_idx` (`StaffID`,`SupervisorID`)
);

CREATE TABLE `SerialPublication` (
  `ISSN` int unsigned NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Publisher` varchar(255) DEFAULT NULL,
  `Stock` int unsigned NOT NULL,
  `NumberCheckedOut` int unsigned NOT NULL,
  `NumberHeld` int unsigned NOT NULL,
  `NumberAvailable` int unsigned NOT NULL,
  PRIMARY KEY (`ISSN`)
);

CREATE TABLE `Students` (
  `StudentID` int NOT NULL,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `DateOfBirth` date NOT NULL,
  `Gender` enum('Man','Woman','Nonbinary','Gender Queer','Gender Nonconformng','Other') NOT NULL,
  `Address` varchar(100) DEFAULT NULL,
  `ContactNumber` varchar(20) DEFAULT NULL,
  `EmailAddress` varchar(100) NOT NULL,
  `GuardiansName` varchar(100) DEFAULT NULL,
  `GuardiansContactNumber` varchar(20) DEFAULT NULL,
  `GradeYearLevel` varchar(20) NOT NULL,
  `Section` varchar(50) DEFAULT NULL,
  `SchoolIDNumber` varchar(50) NOT NULL,
  `DateEnrolled` date NOT NULL,
  `Status` varchar(20) NOT NULL,
  `CreatedDate` datetime NOT NULL,
  `UpdatedDate` datetime NOT NULL,
  PRIMARY KEY (`StudentID`)
);

CREATE TABLE `Transactions` (
  `TransactionID` int NOT NULL AUTO_INCREMENT,
  `BookISBN` int unsigned NOT NULL,
  `MemberID` int NOT NULL,
  `TransactionType` varchar(50) NOT NULL,
  `TransactionDate` datetime NOT NULL,
  `DueDate` datetime DEFAULT NULL,
  `ReturnDate` datetime DEFAULT NULL,
  `ReservationExpiryDate` datetime DEFAULT NULL,
  `TransactionStatus` varchar(50) NOT NULL,
  `FineAmount` decimal(10,2) DEFAULT NULL,
  `FinePaid` tinyint(1) NOT NULL DEFAULT '0',
  `FinePaidDate` datetime DEFAULT NULL,
  `Notes` text,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `UpdatedDate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`TransactionID`),
  KEY `MemberID` (`MemberID`),
  KEY `transactions_ibfk_1_idx` (`BookISBN`),
  CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`BookISBN`) REFERENCES `books` (`ISBN`),
  CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`MemberID`) REFERENCES `students` (`StudentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;





