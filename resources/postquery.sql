USE jenkins;
CREATE TABLE Persons_details (
    PersonID int,
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
);

INSERT INTO Persons_details (PersonID, LastName, FirstName, Address, City)
VALUES (1, 'Doe', 'John', '123 Main St', 'New York'),
       (2, 'Smith', 'Jane', '456 Elm St', 'Los Angeles'),
       (3, 'Johnson', 'Michael', '789 Oak St', 'Chicago');
