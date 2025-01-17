-- Insert data into the Departments table
INSERT INTO Departments (id, name) VALUES (1, 'Antioquia');
INSERT INTO Departments (id, name) VALUES (2, 'Atlántico');
INSERT INTO Departments (id, name) VALUES (3, 'Bogotá');
INSERT INTO Departments (id, name) VALUES (4, 'Valle del Cauca');
INSERT INTO Departments (id, name) VALUES (5, 'Cundinamarca');

-- Insert data into the Cities table
INSERT INTO Cities (id, department_id, name) VALUES (1, 1, 'Medellín');
INSERT INTO Cities (id, department_id, name) VALUES (2, 1, 'Envigado');
INSERT INTO Cities (id, department_id, name) VALUES (3, 2, 'Barranquilla');
INSERT INTO Cities (id, department_id, name) VALUES (4, 2, 'Soledad');
INSERT INTO Cities (id, department_id, name) VALUES (5, 3, 'Bogotá');
INSERT INTO Cities (id, department_id, name) VALUES (6, 4, 'Cali');
INSERT INTO Cities (id, department_id, name) VALUES (7, 4, 'Palmira');
INSERT INTO Cities (id, department_id, name) VALUES (8, 5, 'Chía');
INSERT INTO Cities (id, department_id, name) VALUES (9, 5, 'Soacha');