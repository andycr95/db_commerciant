-- Insert data into the Roles table
INSERT INTO ROLES (role_name, description, creation_date, created_by) VALUES ('Admin', 'Administrador', SYSDATE, 'seed');
INSERT INTO ROLES (role_name, description, creation_date, created_by) VALUES ('User', 'Auxiliar de registro', SYSDATE, 'seed');

-- Insert data into the Users table
INSERT INTO USERS (name, password, email, role_id, creation_date, created_by) VALUES ('admin', '$2a$10$1qgZqIsWvuLrluOsXuDNWuEuFT6aQtG6fdCx4OB5umGtsAL/0Jjoi', 'admin@example.com', 1, SYSDATE, 1);