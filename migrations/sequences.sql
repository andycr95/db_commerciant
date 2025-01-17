-- delete sequence seq_comerciants
DROP SEQUENCE seq_comerciants;

-- delete sequence seq_establishments
DROP SEQUENCE seq_establishments;

-- Create sequence for Comerciants table
CREATE SEQUENCE seq_comerciants
    START WITH 1
    INCREMENT BY 1;

-- Create sequence for Establishments table
CREATE SEQUENCE seq_establishments
    START WITH 1
    INCREMENT BY 1;