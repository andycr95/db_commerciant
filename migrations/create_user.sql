-- Create a new user
DECLARE
    username VARCHAR2(30) := 'com_user';
    password VARCHAR2(30) := 'password';
    default_tablespace VARCHAR2(30) := 'USERS';
    temporary_tablespace VARCHAR2(30) := 'TEMP';
BEGIN
    EXECUTE IMMEDIATE 'CREATE USER ' || username || ' IDENTIFIED BY ' || password || 
                      ' DEFAULT TABLESPACE ' || default_tablespace || 
                      ' TEMPORARY TABLESPACE ' || temporary_tablespace || 
                      ' QUOTA UNLIMITED ON ' || default_tablespace;

    EXECUTE IMMEDIATE 'GRANT CONNECT TO ' || username; 
    EXECUTE IMMEDIATE 'GRANT CREATE SESSION TO ' || username; 
    EXECUTE IMMEDIATE 'GRANT CREATE TABLE TO ' || username;
    EXECUTE IMMEDIATE 'GRANT CREATE TRIGGER TO ' || username;
    EXECUTE IMMEDIATE 'GRANT CREATE SEQUENCE TO ' || username;
    EXECUTE IMMEDIATE 'GRANT CREATE ANY PROCEDURE TO ' || username;
    EXECUTE IMMEDIATE 'GRANT SELECT ANY TABLE, INSERT ANY TABLE, UPDATE ANY TABLE, DELETE ANY TABLE TO ' || username; 
    EXECUTE IMMEDIATE 'GRANT RESOURCE TO ' || username; 
    EXECUTE IMMEDIATE 'GRANT UNLIMITED TABLESPACE TO ' || username; 

    
    EXECUTE IMMEDIATE 'ALTER USER ' || username || ' ACCOUNT UNLOCK';
    
    
    DBMS_OUTPUT.PUT_LINE('Usuario ' || username || ' user created.');
END;
/
