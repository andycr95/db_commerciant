-- Insert data into the Roles table
INSERT INTO ROLES (id, role_name, description, creation_date, created_by) VALUES (1, 'Admin', 'Administrador', SYSDATE, 'seed');
INSERT INTO ROLES (id, role_name, description, creation_date, created_by) VALUES (2, 'User', 'Auxiliar de registro', SYSDATE, 'seed');

-- Insert data into the Users table
INSERT INTO USERS (id, name, password, email, role_id, creation_date, created_by) VALUES (1, 'admin', 'admin123', 'admin@example.com', 1, SYSDATE, 'seed');
INSERT INTO USERS (id, name, password, email, role_id, creation_date, created_by) VALUES (2, 'user1', 'user123', 'user1@example.com', 2, SYSDATE, 'seed');