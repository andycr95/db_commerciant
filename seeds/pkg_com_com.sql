-- Insert data into the Comerciant table
DECLARE
    v_error_code NUMBER;
    v_error_message VARCHAR2(255);
BEGIN
    pkg_comerciants.create_comerciant(
        p_name => 'Vitam 2',
        p_department_id => 1,
        p_city_id => 1,
        p_phone => '31289478398',
        p_email => 'vitam2@example.com',
        p_registration_date => SYSDATE,
        p_status => 'Activo',
        p_created_by => 1,
        p_error_code => v_error_code,
        p_error_message => v_error_message
    );

    IF v_error_code != 0 THEN
        DBMS_OUTPUT.PUT_LINE('Error al crear el Comerciant: ' || v_error_message);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Comerciant creado exitosamente.');
    END IF;
END;
/

-- Procedure to update a comerciant
DECLARE
    v_error_code NUMBER;
    v_error_message VARCHAR2(255);
    v_comerciant_id NUMBER;
BEGIN
    SELECT seq_comerciants.NEXTVAL INTO v_comerciant_id FROM DUAL;
    pkg_comerciants.update_comerciant(
        p_id => v_comerciant_id - 1,
        p_name => 'Vitam Actualizado',
        p_department_id => 1,
        p_city_id => 1,
        p_phone => '31289478399',
        p_email => 'vitam_actualizado@example.com',
        p_registration_date => SYSDATE,
        p_status => 'Activo',
        p_updated_by => 1,
        p_error_code => v_error_code,
        p_error_message => v_error_message
    );

    IF v_error_code != 0 THEN
        DBMS_OUTPUT.PUT_LINE('Error al actualizar el Comerciant: ' || v_error_message);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Comerciant actualizado exitosamente.');
    END IF;
END;
/

-- Procedure to consult all comerciants
DECLARE
    v_error_code NUMBER;
    v_error_message VARCHAR2(255);
    v_cursor SYS_REFCURSOR;
BEGIN
    v_cursor := pkg_comerciants.consult(
        p_name => NULL,
        p_city => NULL,
        p_registration_date => NULL,
        p_status => NULL,
        p_page => 1,
        p_records_by_page => 10
    );

    IF v_cursor IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('Error al consultar los comerciants: ' || v_error_message);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Consulta de comerciants realizada exitosamente.');
        -- Aquí podrías agregar código para procesar el cursor y mostrar los resultados
    END IF;
END;
/

-- Procedure to consult a comerciant by ID
DECLARE
    v_comerciant pkg_comerciants.ComerciantRecord;
BEGIN
    v_comerciant := pkg_comerciants.consult_by_id(p_id => 1);

    IF v_comerciant.name IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('Error al consultar el Comerciant');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Comerciant encontrado: ' || v_comerciant.name || ', Email: ' || v_comerciant.email);
    END IF;
END;
/

Procedure to generate a report of all comerciants
DECLARE
    v_cursor SYS_REFCURSOR;
BEGIN
    v_cursor := pkg_comerciants.report_comerciants;

    IF v_cursor IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('Error al generar el reporte de comerciants.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Reporte de comerciants generado exitosamente.');
    END IF;
END;
/

-- Procedure to delete a comerciant
DECLARE
    v_error_code NUMBER;
    v_error_message VARCHAR2(255);
    v_comerciant_id NUMBER;
BEGIN
    SELECT seq_comerciants.NEXTVAL INTO v_comerciant_id FROM DUAL;
    DELETE FROM Comerciants WHERE id = v_comerciant_id;
    v_error_code := 0;
    v_error_message := 'Comerciant eliminado exitosamente.';
    
    DBMS_OUTPUT.PUT_LINE(v_error_message);
EXCEPTION
    WHEN OTHERS THEN
        v_error_code := SQLCODE;
        v_error_message := SQLERRM;
        DBMS_OUTPUT.PUT_LINE('Error al eliminar el Comerciant: ' || v_error_message);
END;
/

