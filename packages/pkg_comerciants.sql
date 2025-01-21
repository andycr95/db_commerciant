CREATE OR REPLACE PACKAGE pkg_comerciants AS

    -- Datatype for comerciant registration
    TYPE ComerciantRecord IS RECORD (
        name VARCHAR2(255),
        department VARCHAR2(255),
        city VARCHAR2(255),
        phone VARCHAR2(20),
        email VARCHAR2(255),
        registration_date DATE,
        status VARCHAR2(50),
        total_assets NUMBER(20),
        number_of_employees NUMBER(10)
    );

    -- Function to query a comerciant by ID
    FUNCTION consult_by_id(p_id IN NUMBER) RETURN ComerciantRecord;

    -- Function to query comerciant with filters and pagination
    FUNCTION consult (
        p_name IN Comerciants.name%TYPE DEFAULT NULL,
        p_city IN Comerciants.city_id%TYPE DEFAULT NULL,
        p_registration_date IN Comerciants.registration_date%TYPE DEFAULT NULL,
        p_status IN Comerciants.status%TYPE DEFAULT NULL,
        p_page IN NUMBER DEFAULT 1,
        p_records_by_page IN NUMBER DEFAULT 10
    ) RETURN SYS_REFCURSOR;

    -- Function to query total comerciants
    FUNCTION total_comerciants (
        p_name IN Comerciants.name%TYPE DEFAULT NULL,
        p_city IN Comerciants.city_id%TYPE DEFAULT NULL,
        p_registration_date IN Comerciants.registration_date%TYPE DEFAULT NULL,
        p_status IN Comerciants.status%TYPE DEFAULT NULL
    ) RETURN NUMBER;

    -- Procedure to create a new xomerciant
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
        p_id OUT NUMBER,
        p_error_message OUT VARCHAR2
    );

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
    );

    -- Procedure to update an existing comerciant
    PROCEDURE update_comerciant_status (
        p_id IN Comerciants.id%TYPE,
        p_status IN Comerciants.status%TYPE,
        p_updated_by IN NUMBER,
        p_error_code OUT NUMBER,
        p_error_message OUT VARCHAR2
    );

    -- Procedure to delete a comerciant
    PROCEDURE delete_comerciant (
        p_id IN Comerciants.id%TYPE,
        p_error_code OUT NUMBER,
        p_error_message OUT VARCHAR2
    );

    PROCEDURE delete_establishments_comerciant (
        p_commerciant_id IN Comerciants.id%TYPE,
        p_error_code OUT NUMBER,
        p_error_message OUT VARCHAR2
    );

    -- Function for reporting comerciants
    FUNCTION report_comerciants RETURN SYS_REFCURSOR;

END pkg_comerciants;
/