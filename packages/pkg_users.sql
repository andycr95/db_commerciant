CREATE OR REPLACE PACKAGE pkg_users AS

    -- Procedure to create a new user
    PROCEDURE create_user (
        p_name IN Users.name%TYPE,
        p_password IN Users.password%TYPE,
        p_email IN Users.email%TYPE DEFAULT NULL,
        p_role_id IN Users.role_id%TYPE,
        p_created_by IN NUMBER,
        p_error_code OUT NUMBER,
        p_error_message OUT VARCHAR2
    );

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
    );

    -- Procedure to delete a user
    PROCEDURE delete_user (
        p_id IN Users.id%TYPE,
        p_error_code OUT NUMBER,
        p_error_message OUT VARCHAR2
    );

END pkg_users;
/