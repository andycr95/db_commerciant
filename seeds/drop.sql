-- Delete data from Establishments
DELETE FROM Establishments;

-- Delete data from Comerciants
DELETE FROM Comerciants;

-- Truncate Establishments sequence
ALTER SEQUENCE seq_comerciants RESTART;

-- Truncate Comerciants sequence
ALTER SEQUENCE seq_establishments RESTART;


-- Delete data from Cities
DELETE FROM Cities;

-- Delete data from Departments
DELETE FROM Departments;

-- Truncate Cities table
TRUNCATE TABLE Cities;

-- Truncate Departments table
TRUNCATE TABLE Departments;


-- Delete data from Users
DELETE FROM Users;

-- Delete data from Roles
DELETE FROM Roles;

-- Truncate Users table
TRUNCATE TABLE Users;

-- Truncate Roles table
TRUNCATE TABLE Roles;