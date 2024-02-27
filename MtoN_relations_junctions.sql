-- M:N relationship between books and categories/genres
CREATE TABLE Books_Categories_Junction (
    BookID INT,
    CategoryID INT,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    PRIMARY KEY (BookID, CategoryID)
);

-- M:N relationship between books students and books
CREATE TABLE Students_Books_Junction (
    StudentID INT,
    BookID INT,
    TransactionID INT,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (TransactionID) REFERENCES Transactions(TransactionID),
    PRIMARY KEY (StudentID, BookID, TransactionID)
);

-- M:N relationship between library_staff and books
CREATE TABLE Library_Staff_Books_Junction (
    StaffID INT,
    BookID INT,
    TransactionID INT,
    FOREIGN KEY (StaffID) REFERENCES Library_Staff(StaffID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (TransactionID) REFERENCES Transactions(TransactionID),
    PRIMARY KEY (StaffID, BookID, TransactionID)
);
