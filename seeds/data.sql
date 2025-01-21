-- Insert data into the Departments table
INSERT INTO Departments (name) VALUES ('Antioquia');
INSERT INTO Departments (name) VALUES ('Atlántico');
INSERT INTO Departments (name) VALUES ('Bogotá');
INSERT INTO Departments (name) VALUES ('Valle del Cauca');
INSERT INTO Departments (name) VALUES ('Cundinamarca');

-- Insert data into the Cities table
INSERT INTO Cities (department_id, name) VALUES (1, 'Medellín');
INSERT INTO Cities (department_id, name) VALUES (1, 'Envigado');
INSERT INTO Cities (department_id, name) VALUES (2, 'Barranquilla');
INSERT INTO Cities (department_id, name) VALUES (2, 'Soledad');
INSERT INTO Cities (department_id, name) VALUES (3, 'Bogotá');
INSERT INTO Cities (department_id, name) VALUES (4, 'Cali');
INSERT INTO Cities (department_id, name) VALUES (4, 'Palmira');
INSERT INTO Cities (department_id, name) VALUES (5, 'Chía');
INSERT INTO Cities (department_id, name) VALUES (5, 'Soacha');