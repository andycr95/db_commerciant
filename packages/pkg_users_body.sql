CREATE OR REPLACE PACKAGE BODY pkg_users AS

    -- Procedure to create a new user
    PROCEDURE create_user (
        p_name IN Users.name%TYPE,
        p_password IN Users.password%TYPE,
        p_email IN Users.email%TYPE DEFAULT NULL,
        p_role_id IN Users.role_id%TYPE,
        p_created_by IN NUMBER,
        p_error_code OUT NUMBER,
        p_error_message OUT VARCHAR2
    ) IS
    BEGIN
        IF p_name IS NULL 
        OR p_password IS NULL
        OR p_role_id IS NULL THEN
            p_error_code := 1;
            p_error_message := 'All fields are required.';
            RETURN;
        END IF;

        INSERT INTO Users (name, password, email, role_id, created_by) 
        VALUES (p_name, p_password, p_email, p_role_id, p_created_by);

        COMMIT;


        p_error_code := 0;
        p_error_message := NULL;
    EXCEPTION
        WHEN OTHERS THEN
            p_error_code := SQLCODE;
            p_error_message := SQLERRM;
    END create_user;

    -- Procedure to update an existing user
    PROCEDURE update_user (
        p_id IN Users.id%TYPE,
        p_name IN Users.name%TYPE,
        p_password IN Users.password%TYPE,
        p_email IN Users.email%TYPE DEFAULT NULL,
        p_status IN Users.status%TYPE,
        p_role_id IN Users.role_id%TYPE,
        p_updated_by IN NUMBER,
        p_error_code OUT NUMBER,
        p_error_message OUT VARCHAR2
    ) IS
    BEGIN
        IF p_name IS NULL 
        OR p_role_id IS NULL
        OR p_email IS NULL
        OR p_password IS NULL
        OR p_status IS NULL THEN
            p_error_code := 1;
            p_error_message := 'All fields are required.';
            RETURN;
        END IF;

        UPDATE Users 
        SET name = p_name, 
            role_id = p_role_id, 
            email = p_email, 
            password = p_password,
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
    END update_user;

    -- Procedure to delete a user
    PROCEDURE delete_user (
        p_id IN Users.id%TYPE,
        p_error_code OUT NUMBER,
        p_error_message OUT VARCHAR2
    ) IS
    BEGIN
        DELETE FROM Users WHERE id = p_id;

        COMMIT;

        p_error_code := 0;
        p_error_message := NULL;
    EXCEPTION
        WHEN OTHERS THEN
            p_error_code := SQLCODE;
            p_error_message := SQLERRM;
    END delete_user;

END pkg_users;
/