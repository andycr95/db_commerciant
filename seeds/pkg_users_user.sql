-- Insert data into the User table
DECLARE
    v_error_code NUMBER;
    v_error_message VARCHAR2(255);
BEGIN
    pkg_users.create_user(
        p_name => 'andy rivas 3',
        p_password => 'andy123',
        p_email => 'andy21@example.com',
        p_role_id => 1,
        p_created_by => 1,
        p_error_code => v_error_code,
        p_error_message => v_error_message
    );

    IF v_error_code != 0 THEN
        DBMS_OUTPUT.PUT_LINE('Error al crear el usuario: ' || v_error_message);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Usuario creado exitosamente.');
    END IF;
END;
/

-- Ipdate data to user
DECLARE
    v_error_code NUMBER;
    v_error_message VARCHAR2(255);
BEGIN
    pkg_users.update_user(
        p_id => 2,
        p_name => 'andy rivas actualizado',
        p_password => 'andy1234',
        p_email => 'andy21actualizado@example.com',
        p_status => 'Activo',
        p_role_id => 1,
        p_updated_by => 1,
        p_error_code => v_error_code,
        p_error_message => v_error_message
    );

    IF v_error_code != 0 THEN
        DBMS_OUTPUT.PUT_LINE('Error al actualizar el usuario: ' || v_error_message);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Usuario actualizado exitosamente.');
    END IF;
END;
/

-- Delete user
DECLARE
    v_error_code NUMBER;
    v_error_message VARCHAR2(255);
BEGIN
    DELETE FROM Users WHERE id = 2;
    v_error_code := 0;
    v_error_message := 'Usuario eliminado exitosamente.';
    
    DBMS_OUTPUT.PUT_LINE(v_error_message);
EXCEPTION
    WHEN OTHERS THEN
        v_error_code := SQLCODE;
        v_error_message := SQLERRM;
        DBMS_OUTPUT.PUT_LINE('Error al eliminar el usuario: ' || v_error_message);
END;
/
