-- Trigger to Comerciants table
CREATE OR REPLACE TRIGGER tr_comerciants
BEFORE INSERT ON Comerciants
FOR EACH ROW
BEGIN
    SELECT seq_comerciants.NEXTVAL INTO :NEW.id FROM DUAL;
END;
/

-- Trigger to Establishments table
CREATE OR REPLACE TRIGGER tr_establishments
BEFORE INSERT ON Establishments
FOR EACH ROW
BEGIN
    SELECT seq_establishments.NEXTVAL INTO :NEW.id FROM DUAL;
END;
/


-- Trigger to audit Establishments table
CREATE OR REPLACE TRIGGER tr_created_establishments
BEFORE INSERT ON Establishments
FOR EACH ROW
DECLARE
  v_user_name VARCHAR2(255);
BEGIN
  BEGIN
    SELECT name INTO v_user_name
    FROM Users
    WHERE id = :NEW.created_by;
    :NEW.created_by := v_user_name;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      :NEW.created_by := 'Usuario desconocido';
  END;

  :NEW.creation_date := SYSDATE;
END;
/


-- Trigger to audit Establishments table
CREATE OR REPLACE TRIGGER tr_created_establishments
BEFORE INSERT ON Establishments
FOR EACH ROW
DECLARE
  v_user_name VARCHAR2(255);
BEGIN
  BEGIN
    SELECT name INTO v_user_name
    FROM Users
    WHERE id = :NEW.created_by;
    :NEW.created_by := v_user_name;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      :NEW.created_by := 'Usuario desconocido';
  END;

  :NEW.creation_date := SYSDATE;
END;
/

-- Trigger to audit Comerciants table
CREATE OR REPLACE TRIGGER tr_auditoria_comerciants
BEFORE UPDATE ON Comerciants
FOR EACH ROW
DECLARE
  v_user_name VARCHAR2(255);
BEGIN
  BEGIN
    SELECT name INTO v_user_name
    FROM Users
    WHERE id = :NEW.updated_by;
    :NEW.updated_by := v_user_name;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      :NEW.updated_by := 'Usuario desconocido';
  END;

  :NEW.update_date := SYSDATE;

EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20001, 'Error en el trigger tr_auditoria_comerciants: ' || SQLERRM);
END;
/


-- Trigger to audit Establishments table
CREATE OR REPLACE TRIGGER tr_auditoria_establishments
BEFORE UPDATE ON Establishments
FOR EACH ROW
DECLARE
  v_user_name VARCHAR2(255);
BEGIN
  BEGIN
    SELECT name INTO v_user_name
    FROM Users
    WHERE id = :NEW.updated_by;
    :NEW.updated_by := v_user_name;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      :NEW.updated_by := 'Usuario desconocido';
  END;

  :NEW.update_date := SYSDATE;
END;
/