-- 1:M
ALTER TABLE Transactions
ADD FOREIGN KEY (BookID) REFERENCES Books(BookID);

-- 1:M
ALTER TABLE Transactions
ADD FOREIGN KEY (StudentID) REFERENCES Students(StudentID);

-- 1:M
ALTER TABLE Transactions
ADD FOREIGN KEY (StaffID) REFERENCES Library_Staff(StaffID);

-- 1:M
ALTER TABLE Fines
ADD FOREIGN KEY (TransactionID) REFERENCES Transactions(TransactionID);


