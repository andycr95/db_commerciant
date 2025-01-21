CREATE OR REPLACE PACKAGE BODY pkg_comerciants AS

    -- Function to query a comerciant by ID
    FUNCTION consult_by_id(p_id IN NUMBER) RETURN ComerciantRecord IS
        v_comerciant ComerciantRecord;
    BEGIN
        SELECT c.name, 
            d.name AS department,
            ct.name AS city, 
            c.phone, 
            c.email, 
            c.registration_date, 
            c.status,
            SUM(e.revenue) AS total_assets,
            SUM(e.employee_count) AS number_of_employees
        INTO v_comerciant
        FROM Comerciants c
        JOIN Departments d ON c.department_id = d.id
        JOIN Cities ct ON c.city_id = ct.id
        LEFT JOIN Establishments e ON c.id = e.commerciant_id
        WHERE c.id = p_id
        GROUP BY c.name, d.name, ct.name, c.phone, c.email, c.registration_date, c.status;
        RETURN v_comerciant;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
            RETURN NULL;
    END consult_by_id;


    FUNCTION consult (
        p_name IN Comerciants.name%TYPE DEFAULT NULL,
        p_city IN Comerciants.city_id%TYPE DEFAULT NULL,
        p_registration_date IN Comerciants.registration_date%TYPE DEFAULT NULL,
        p_status IN Comerciants.status%TYPE DEFAULT NULL,
        p_page IN NUMBER DEFAULT 1,
        p_records_by_page IN NUMBER DEFAULT 10
    ) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
        SELECT c.id, 
                c.name, 
               d.name AS department, 
               m.name AS city, 
               c.phone, 
               c.email, 
               c.registration_date, 
               c.status,
               SUM(e.revenue) AS total_assets, 
               SUM(e.employee_count) AS number_of_employees
        FROM Comerciants c
        JOIN Departments d ON c.department_id = d.id
        JOIN Cities m ON c.city_id = m.id
        LEFT JOIN Establishments e ON c.id = e.commerciant_id
        WHERE (p_name IS NULL OR c.name LIKE '%' || p_name || '%')
          AND (p_city IS NULL OR c.city_id = p_city)
          AND (p_registration_date IS NULL OR c.registration_date = p_registration_date)
          AND (p_status IS NULL OR c.status = p_status)
        GROUP BY c.id, c.name, d.name, m.name, c.phone, c.email, c.registration_date, c.status
        ORDER BY c.name
        OFFSET (p_page - 1) * p_records_by_page ROWS
        FETCH NEXT p_records_by_page ROWS ONLY;

        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN NULL;
    END consult;

    FUNCTION total_comerciants (
        p_name IN Comerciants.name%TYPE DEFAULT NULL,
        p_city IN Comerciants.city_id%TYPE DEFAULT NULL,
        p_registration_date IN Comerciants.registration_date%TYPE DEFAULT NULL,
        p_status IN Comerciants.status%TYPE DEFAULT NULL
    ) RETURN NUMBER IS
        v_total NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_total
        FROM Comerciants c
        WHERE (p_name IS NULL OR c.name LIKE '%' || p_name || '%')
          AND (p_city IS NULL OR c.city_id = p_city)
          AND (p_registration_date IS NULL OR c.registration_date = p_registration_date)
          AND (p_status IS NULL OR c.status = p_status);

        RETURN v_total;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN NULL;
    END total_comerciants;

    -- Procedure to create a new comerciant
    PROCEDURE create_comerciant (
        p_name IN Comerciants.name%TYPE,
        p_department_id IN Comerciants.department_id%TYPE,
        p_city_id IN Comerciants.city_id%TYPE,
        p_phone IN Comerciants.phone%TYPE DEFAULT NULL,
        p_email IN Comerciants.email%TYPE DEFAULT NULL,
        p_registration_date IN Comerciants.registration_date%TYPE,
        p_status IN Comerciants.status%TYPE,
        p_created_by IN NUMBER,
        p_error_code OUT NUMBER,
        p_error_message OUT VARCHAR2
    ) IS
    BEGIN
        IF p_name IS NULL 
        OR p_department_id IS NULL
        OR p_city_id IS NULL
        OR p_registration_date IS NULL
        OR p_status IS NULL THEN
            p_error_code := 1;
            p_error_message := 'All fields are required.';
            RETURN;
        END IF;

        INSERT INTO Comerciants (name, department_id, city_id, phone, email, registration_date, status, created_by) 
        VALUES (p_name, p_department_id, p_city_id, p_phone, p_email, p_registration_date, p_status, p_created_by);

        COMMIT;

        p_error_code := 0;
        p_error_message := NULL;
    EXCEPTION
        WHEN OTHERS THEN
            p_error_code := SQLCODE;
            p_error_message := SQLERRM;
    END create_comerciant;

    -- Procedure to update an existing comerciant
    PROCEDURE update_comerciant (
        p_id IN Comerciants.id%TYPE,
        p_name IN Comerciants.name%TYPE,
        p_department_id IN Comerciants.department_id%TYPE,
        p_city_id IN Comerciants.city_id%TYPE,
        p_phone IN Comerciants.phone%TYPE DEFAULT NULL,
        p_email IN Comerciants.email%TYPE DEFAULT NULL,
        p_registration_date IN Comerciants.registration_date%TYPE,
        p_status IN Comerciants.status%TYPE,
        p_updated_by IN NUMBER,
        p_error_code OUT NUMBER,
        p_error_message OUT VARCHAR2
    ) IS
    BEGIN
        IF p_name IS NULL 
        OR p_department_id IS NULL
        OR p_city_id IS NULL
        OR p_registration_date IS NULL
        OR p_status IS NULL THEN
            p_error_code := 1;
            p_error_message := 'All fields are required.';
            RETURN;
        END IF;

        UPDATE Comerciants 
        SET name = p_name, 
            department_id = p_department_id, 
            city_id = p_city_id, 
            phone = p_phone, 
            email = p_email, 
            registration_date = p_registration_date,
            status = p_status,
            updated_by = p_updated_by
        WHERE id = p_id;

        COMMIT;

        p_error_code := 0;
        p_error_message := NULL;
    EXCEPTION
        WHEN OTHERS THEN
            p_error_code := SQLCODE;
            p_error_message := SQLERRM;
    END update_comerciant;

    -- Procedimiento para eliminar un comerciant
    PROCEDURE delete_comerciant (
        p_id IN Comerciants.id%TYPE,
        p_error_code OUT NUMBER,
        p_error_message OUT VARCHAR2
    ) IS
    BEGIN
        DELETE FROM Comerciants WHERE id = p_id;
        
        COMMIT;
        
        p_error_code := 0;
        p_error_message := NULL;
    EXCEPTION
        WHEN OTHERS THEN
            p_error_code := SQLCODE;
            p_error_message := SQLERRM;
    END delete_comerciant;

    -- Function for reporting comerciants
    FUNCTION report_comerciants RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
        SELECT c.name, 
               d.name AS department, 
               m.name AS city, 
               c.phone, 
               c.email, 
               c.registration_date, 
               c.status,
               COUNT(e.id) AS number_of_establishments,
               SUM(e.revenue) AS total_assets, 
               SUM(e.employee_count) AS number_of_employees
        FROM Comerciants c
        JOIN Departments d ON c.department_id = d.id
        JOIN Cities m ON c.city_id = m.id
        LEFT JOIN Establishments e ON c.id = e.commerciant_id
        WHERE c.status IN ('Registrado', 'Activo')
        GROUP BY c.name, d.name, m.name, c.phone, c.email, c.registration_date, c.status
        ORDER BY number_of_establishments DESC;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN NULL;
    END report_comerciants;

END pkg_comerciants;
/