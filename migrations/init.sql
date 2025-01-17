-- Create roles Table
CREATE TABLE pacificode_user.ROLES (
    id NUMBER NOT NULL,
    role_name VARCHAR2(100) NOT NULL,
    description VARCHAR2(255),
    creation_date DATE DEFAULT SYSDATE,
    created_by VARCHAR2(100),
    update_date DATE,
    CONSTRAINT pk_roles PRIMARY KEY (id),
    updated_by VARCHAR2(100)
);

-- Create users Table
CREATE TABLE pacificode_user.Users (
    id NUMBER NOT NULL,
    name VARCHAR2(100) NOT NULL,
    password VARCHAR2(100) NOT NULL,
    email VARCHAR2(150) NOT NULL UNIQUE,
    status VARCHAR2(50) DEFAULT 'ACTIVE',
    role_id NUMBER NOT NULL,
    creation_date DATE DEFAULT SYSDATE NOT NULL,
    created_by VARCHAR2(255) DEFAULT USER NOT NULL,
    update_date DATE DEFAULT SYSDATE NOT NULL,
    updated_by VARCHAR2(255) DEFAULT USER NOT NULL,
    CONSTRAINT pk_users PRIMARY KEY (id),
    CONSTRAINT fk_users_roles FOREIGN KEY (role_id) REFERENCES ROLES(id)
);


-- Create departments Table
CREATE TABLE pacificode_user.Departments (
    id NUMBER NOT NULL,
    name VARCHAR2(255) NOT NULL,
    CONSTRAINT pk_departments PRIMARY KEY (id)
);

-- Create cities Table
CREATE TABLE pacificode_user.Cities (
    id NUMBER NOT NULL,
    department_id NUMBER NOT NULL,
    name VARCHAR2(255) NOT NULL,
    CONSTRAINT pk_cities PRIMARY KEY (id),
    CONSTRAINT fk_municipalities_departments FOREIGN KEY (department_id) REFERENCES Departments(id)
);

-- Create comerciants Table
CREATE TABLE pacificode_user.Comerciants (
    id NUMBER NOT NULL,
    name VARCHAR2(255) NOT NULL,
    department_id NUMBER NOT NULL,
    city_id NUMBER NOT NULL,
    phone VARCHAR2(20),
    email VARCHAR2(255),
    registration_date DATE NOT NULL,
    status VARCHAR2(50) DEFAULT 'ACTIVE',
    creation_date DATE DEFAULT SYSDATE NOT NULL,
    created_by VARCHAR2(255) DEFAULT USER NOT NULL,
    update_date DATE DEFAULT SYSDATE NOT NULL,
    updated_by VARCHAR2(255) DEFAULT USER NOT NULL,
    CONSTRAINT pk_comerciants PRIMARY KEY (id),
    CONSTRAINT fk_commerciants_departments FOREIGN KEY (department_id) REFERENCES Departments(id),
    CONSTRAINT fk_commerciants_municipalities FOREIGN KEY (city_id) REFERENCES Cities(id)
);

-- Create establishments Table
CREATE TABLE pacificode_user.Establishments (
    id NUMBER NOT NULL,
    commerciant_id NUMBER NOT NULL,
    name VARCHAR2(255) NOT NULL,
    revenue NUMBER(10,2) NOT NULL,
    employee_count NUMBER NOT NULL,
    creation_date DATE DEFAULT SYSDATE NOT NULL,
    created_by VARCHAR2(255) DEFAULT USER NOT NULL,
    update_date DATE DEFAULT SYSDATE NOT NULL,
    updated_by VARCHAR2(255) DEFAULT USER NOT NULL,
    CONSTRAINT pk_establishments PRIMARY KEY (id),
    CONSTRAINT fk_establishments_commerciants FOREIGN KEY (commerciant_id) REFERENCES Comerciants(id)
);

