-- delete sequence seq_comerciants
DROP SEQUENCE seq_comerciants;

-- delete sequence seq_establishments
DROP SEQUENCE seq_establishments;

-- delete sequence seq_users
DROP SEQUENCE seq_users;

-- delete sequence seq_departments
DROP SEQUENCE seq_departments;

-- delete sequence seq_cities
DROP SEQUENCE seq_cities;

-- delete sequence seq_roles
DROP SEQUENCE seq_roles;

-- Create sequence for Comerciants table
CREATE SEQUENCE seq_comerciants
    START WITH 1
    INCREMENT BY 1;

-- Create sequence for Establishments table
CREATE SEQUENCE seq_establishments
    START WITH 1
    INCREMENT BY 1;

-- Create sequence for Departments table
CREATE SEQUENCE seq_departments
    START WITH 1
    INCREMENT BY 1;

-- Create sequence for Establishments table
CREATE SEQUENCE seq_cities
    START WITH 1
    INCREMENT BY 1;

-- Create sequence for Users table
CREATE SEQUENCE seq_users
    START WITH 1
    INCREMENT BY 1;

-- Create sequence for Roles table
CREATE SEQUENCE seq_roles
    START WITH 1
    INCREMENT BY 1;