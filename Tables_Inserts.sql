--CREATE DATABASE [TF SegurosVidaSegura]

use [TF SegurosVidaSegura]

--------------------------------------- TABLAS ---------------------------------------

-- Table: Empleado
CREATE TABLE Empleado (
    codigo int  NOT NULL,
    nombre varchar(100)  NOT NULL,
    apellido varchar(100)  NOT NULL,
    dni int  NOT NULL,
    telefono int  NOT NULL,
    salario money  NOT NULL,
    sucursales_codigo int  NOT NULL,
    CONSTRAINT Empleado_pk PRIMARY KEY  (codigo)
);

-- Table: administradores
CREATE TABLE administradores (
    codigo int  NOT NULL,
    nombre varchar(100)  NOT NULL,
    apellido varchar(100)  NOT NULL,
    dni int  NOT NULL,
    cargo varchar(100)  NOT NULL,
    sucursales_codigo int  NOT NULL,
    CONSTRAINT administradores_pk PRIMARY KEY  (codigo)
);

-- Table: agentes
CREATE TABLE agentes (
    codigo int  NOT NULL,
    nombre varchar(100)  NOT NULL,
    apellido varchar(100)  NOT NULL,
    direccion varchar(255)  NOT NULL,
    sueldo money  NOT NULL,
    comision money  NOT NULL,
    historial_ventas varchar(max)  NOT NULL,
    telefono int  NOT NULL,
    correo varchar(255)  NOT NULL,
    sucursales_codigo int  NOT NULL,
    CONSTRAINT agentes_pk PRIMARY KEY  (codigo)
);

-- Table: asegurados
CREATE TABLE asegurados (
    codigo int  NOT NULL,
    nombre varchar(100)  NOT NULL,
    apellido varchar(100)  NOT NULL,
    direccion varchar(255)  NOT NULL,
    telefono int  NOT NULL,
    correo varchar(255)  NOT NULL,
    fecha_nacimiento date  NOT NULL,
    estado_civil varchar(100)  NOT NULL,
    hisotriales_medicos_codigo int  NOT NULL,
    CONSTRAINT asegurados_pk PRIMARY KEY  (codigo)
);

-- Table: beneficiarios
CREATE TABLE beneficiarios (
    codigo int  NOT NULL,
    nombre varchar(100)  NOT NULL,
    apellido varchar(100)  NOT NULL,
    dni int  NOT NULL,
    CONSTRAINT beneficiarios_pk PRIMARY KEY  (codigo)
);

-- Table: contactos
CREATE TABLE contactos (
    codigo int  NOT NULL,
    nombre varchar(100)  NOT NULL,
    apellido varchar(100)  NOT NULL,
    telefono int  NOT NULL,
    correo varchar(255)  NOT NULL,
    agentes_codigo int  NOT NULL,
    CONSTRAINT contactos_pk PRIMARY KEY  (codigo)
);

-- Table: hisotriales_medicos
CREATE TABLE hisotriales_medicos (
    codigo int  NOT NULL,
    fecha_creacion date  NOT NULL,
    fecha_actualizacion date  NOT NULL,
    medico varchar(100)  NOT NULL,
    motivo_visita varchar(max)  NOT NULL,
    diagnostico varchar(max)  NOT NULL,
    tratamiento varchar(max)  NOT NULL,
    medicamentos varchar(max)  NOT NULL,
    resultados varchar(max)  NOT NULL,
    observaciones varchar(max)  NOT NULL,
    CONSTRAINT hisotriales_medicos_pk PRIMARY KEY  (codigo)
);

-- Table: pagos
CREATE TABLE pagos (
    codigo int  NOT NULL,
    tipo_pago varchar(100)  NOT NULL,
    asegurados_codigo int  NOT NULL,
    CONSTRAINT pagos_pk PRIMARY KEY  (codigo)
);

-- Table: polizas
CREATE TABLE polizas (
    codigo int  NOT NULL,
    descripcion varchar(max)  NOT NULL,
    tipo_poliza varchar(100)  NOT NULL,
    monto_Seguro money  NOT NULL,
    fecha_inicio date  NOT NULL,
    fecha_fin date  NOT NULL,
    prima money  NOT NULL,
    asegurados_codigo int  NOT NULL,
    agentes_codigo int  NOT NULL,
    CONSTRAINT polizas_pk PRIMARY KEY  (codigo)
);

-- Table: polizas_para_beneficiarios
CREATE TABLE polizas_para_beneficiarios (
    polizas_codigo int  NOT NULL,
    beneficiarios_codigo int  NOT NULL,
    CONSTRAINT polizas_para_beneficiarios_pk PRIMARY KEY  (polizas_codigo,beneficiarios_codigo)
);

-- Table: recaudadores
CREATE TABLE recaudadores (
    codigo int  NOT NULL,
    nombre varchar(100)  NOT NULL,
    apellido varchar(100)  NOT NULL,
    historial_pago varchar(max)  NOT NULL,
    CONSTRAINT recaudadores_pk PRIMARY KEY  (codigo)
);

-- Table: recaudadores_por_sucursal
CREATE TABLE recaudadores_por_sucursal (
    recaudadores_codigo int  NOT NULL,
    sucursales_codigo int  NOT NULL,
    CONSTRAINT recaudadores_por_sucursal_pk PRIMARY KEY  (sucursales_codigo,recaudadores_codigo)
);

-- Table: sucursales
CREATE TABLE sucursales (
    codigo int  NOT NULL,
    ubicacion varchar(100)  NOT NULL,
    telefono int  NOT NULL,
    CONSTRAINT sucursales_pk PRIMARY KEY  (codigo)
);

-- Table: trabajos
CREATE TABLE trabajos (
    codigo int  NOT NULL,
    tipo varchar(100)  NOT NULL,
    salario money  NOT NULL,
    asegurados_codigo int  NOT NULL,
    CONSTRAINT trabajos_pk PRIMARY KEY  (codigo)
);

-- foreign keys
-- Reference: Empleado_sucursales (table: Empleado)
ALTER TABLE Empleado ADD CONSTRAINT Empleado_sucursales
    FOREIGN KEY (sucursales_codigo)
    REFERENCES sucursales (codigo);

-- Reference: administradores_sucursales (table: administradores)
ALTER TABLE administradores ADD CONSTRAINT administradores_sucursales
    FOREIGN KEY (sucursales_codigo)
    REFERENCES sucursales (codigo);

-- Reference: agentes_sucursales (table: agentes)
ALTER TABLE agentes ADD CONSTRAINT agentes_sucursales
    FOREIGN KEY (sucursales_codigo)
    REFERENCES sucursales (codigo);

-- Reference: asegurados_hisotriales_medicos (table: asegurados)
ALTER TABLE asegurados ADD CONSTRAINT asegurados_hisotriales_medicos
    FOREIGN KEY (hisotriales_medicos_codigo)
    REFERENCES hisotriales_medicos (codigo);

-- Reference: contactos_agentes (table: contactos)
ALTER TABLE contactos ADD CONSTRAINT contactos_agentes
    FOREIGN KEY (agentes_codigo)
    REFERENCES agentes (codigo);

-- Reference: pagos_asegurados (table: pagos)
ALTER TABLE pagos ADD CONSTRAINT pagos_asegurados
    FOREIGN KEY (asegurados_codigo)
    REFERENCES asegurados (codigo);

-- Reference: polizas_agentes (table: polizas)
ALTER TABLE polizas ADD CONSTRAINT polizas_agentes
    FOREIGN KEY (agentes_codigo)
    REFERENCES agentes (codigo);

-- Reference: polizas_asegurados (table: polizas)
ALTER TABLE polizas ADD CONSTRAINT polizas_asegurados
    FOREIGN KEY (asegurados_codigo)
    REFERENCES asegurados (codigo);

-- Reference: polizas_para_beneficiarios_beneficiarios (table: polizas_para_beneficiarios)
ALTER TABLE polizas_para_beneficiarios ADD CONSTRAINT polizas_para_beneficiarios_beneficiarios
    FOREIGN KEY (beneficiarios_codigo)
    REFERENCES beneficiarios (codigo);

-- Reference: polizas_para_beneficiarios_polizas (table: polizas_para_beneficiarios)
ALTER TABLE polizas_para_beneficiarios ADD CONSTRAINT polizas_para_beneficiarios_polizas
    FOREIGN KEY (polizas_codigo)
    REFERENCES polizas (codigo);

-- Reference: recaudadores_por_sucursal_recaudadores (table: recaudadores_por_sucursal)
ALTER TABLE recaudadores_por_sucursal ADD CONSTRAINT recaudadores_por_sucursal_recaudadores
    FOREIGN KEY (recaudadores_codigo)
    REFERENCES recaudadores (codigo);

-- Reference: recaudadores_por_sucursal_sucursales (table: recaudadores_por_sucursal)
ALTER TABLE recaudadores_por_sucursal ADD CONSTRAINT recaudadores_por_sucursal_sucursales
    FOREIGN KEY (sucursales_codigo)
    REFERENCES sucursales (codigo);

-- Reference: trabajos_asegurados (table: trabajos)
ALTER TABLE trabajos ADD CONSTRAINT trabajos_asegurados
    FOREIGN KEY (asegurados_codigo)
    REFERENCES asegurados (codigo);

-- end of file

------------------------------- INSERTS -------------------------------

-- sucursales
insert into sucursales values (1,'San Pedro Sula', 99865233);
insert into sucursales values (2,'Tegucigalpa', 998653978);
insert into sucursales values (3,'La Ceiba', 992865314);
insert into sucursales values (4,'Choluteca', 999863771);
insert into sucursales values (5,'Santa Rosa de Copan', 99987632);
insert into sucursales values (6,'Comas', 99987632);
insert into sucursales values (7,'San Juan de Lurigancho', 99987632);
insert into sucursales values (8,'Lince', 99987632);
insert into sucursales values (9,'Villa el Salvador', 99987632);
insert into sucursales values (10,'Lurin', 99987632);

-- Empleado

insert into Empleado values (1,'Juan','Perez', 77889366, 99799865, 1300,1);
insert into Empleado values (2,'Maria','Lopez', 77798629, 99798863, 1300,2);
insert into Empleado values (3,'Jose','Garcia', 77799631, 99865314, 1200,3);
insert into Empleado values (4,'Carlos','Gonzales', 77793214, 99798862, 1200,4);
insert into Empleado values (5,'Ana','Martinez', 79986324, 998663266, 1300,5);
insert into Empleado values (6,'Sofia','Garcia', 79986324, 998663266, 1300,6);
insert into Empleado values (7,'Alejandro','Rodriguez', 79986324, 998663266, 1500,7);
insert into Empleado values (8,'Valentina ','Gutierrez', 79986324, 998663266, 1300,8);
insert into Empleado values (9,'Martin ','Martinez', 79986324, 998663266, 1200,9);
insert into Empleado values (10,'Carolina','Herrera', 79986324, 998663266, 1300,10);
insert into Empleado values (11, 'Sebastian', 'Salas', 79912312, 987556712, 1200, 1);
insert into Empleado values (12, 'Arturo', 'Villanueva', 79943512, 987754612, 1300, 1);
insert into Empleado values (13, 'Andrea', 'Soto', 79954332, 981234712, 1300, 1);
insert into Empleado values (14, 'Rocio', 'Lujan', 79912312, 987556712, 1200, 2);
insert into Empleado values (15, 'Alberto', 'Carrion', 79431112, 987556734, 1300, 2);
insert into Empleado values (16, 'Anthony', 'Suarez', 79954231, 987254112, 1200, 3);
insert into Empleado values (17, 'Miguel', 'Santamaria', 79912563, 999556762, 1300, 4);
insert into Empleado values (18, 'Luciana', 'Castillo', 79909612, 978506915, 1300, 4);
insert into Empleado values (19, 'Joaquin', 'Cuevas', 79812312, 923550942, 1200, 5);
insert into Empleado values (20, 'Adrian', 'Hernandez', 79932112, 943559813, 1300, 5);

select * from Empleado;

-- administradores

insert into administradores values (1,'Abraham','Estrada', 77866936, 'administrador', 1);
insert into administradores values (2, 'Renzo', 'Garcia', 75315965, 'administrador', 2);
insert into administradores values (3, 'Luis', 'Ochoa', 66632574, 'administrador', 3);
insert into administradores values (4, 'Carlos', 'Alvarez', 15247695, 'administrador', 4);
insert into administradores values (5, 'Jose', 'Ramos', 36578946, 'administrador', 5);
insert into administradores values (6, 'Julian', 'Navarro', 7965543, 'administrador', 6);
insert into administradores values (7, 'Gabriela', 'Morales', 11144453, 'administrador', 7);
insert into administradores values (8, 'Leonardo', 'Vargaz', 14765369, 'administrador', 8);
insert into administradores values (9, 'Ana', 'Torres', 99965431, 'administrador', 9);
insert into administradores values (10, 'Diego', 'Mendoza', 15632478, 'administrador', 10);

select * from administradores;


-- agentes

insert into agentes values (1, 'Aaron', 'Wall', 'Av. Los Alamanos', 1500, 300, '150 regitros', 98623154 , 'aaron21@gmail.com', 1);
insert into agentes values (2, 'Abraham', 'Guerrero', 'Av. Procerez', 2000, 300, '150 regitros', 9862347, 'guerrero02@gmail.com', 2);
insert into agentes values (3, 'Fernando', 'Ramos ', 'Av. Chorrilos', 1500, 200, '100 regitros', 99871632, 'fer3365@gmail.com',3);
insert into agentes values (4, 'Gustavo ', 'Quispe', 'Av. Velazco', 2500, 300, '150 regitros', 89971717, 'quispe89@gmail.com',4);
insert into agentes values (5, 'Angelo', 'Garcia', 'Av. Salaverry', 1500, 200,'100 regitros', 99867123, 'angelo796@gmail.com',5);
INSERT INTO agentes VALUES (6, 'Juan', 'Gonzalez', 'Calle Principal 123', 2500, 500, '500 regitros', 123456789, 'juan.gonzalez@gmail.com', 6);
INSERT INTO agentes VALUES (7, 'Maria', 'Lopez', 'Avenida Central 456', 2800, 600, '550 regitros', 987654321, 'maria.lopez@gmail.com', 7);
INSERT INTO agentes VALUES (8, 'Pedro', 'Sanchez', 'Plaza Mayor 789', 2300, 400, '300 regitros', 125478369, 'pedro.sanchez@gmail.com', 8);
INSERT INTO agentes VALUES (9, 'Laura', 'Gomez', 'Calle Secundaria 321', 2700, 550, '520 regitros', 662359741, 'laura.gomez@gmail.com', 9);
INSERT INTO agentes VALUES (10, 'Carlos', 'Rodriguez', 'Avenida Principal 987', 3000, 700, '600 registros', 141238466, 'carlos.rodriguez@gmail.com', 10);

select * from agentes;


-- recudadores

INSERT INTO recaudadores VALUES (1, 'Ana', 'Gonzalez', 'Pago recibido el 2023-06-01 por $500.00, ...');
INSERT INTO recaudadores VALUES (2, 'Carlos', 'Lopez', 'Pago recibido el 2023-06-02 por $750.00, ...');
INSERT INTO recaudadores VALUES (3, 'Maria', 'Sanchez', 'Pago recibido el 2023-06-03 por $600.00, ...');
INSERT INTO recaudadores VALUES (4, 'Pedro', 'Gomez', 'Pago recibido el 2023-06-04 por $900.00, ...');
INSERT INTO recaudadores VALUES (5, 'Laura', 'Rodriguez', 'Pago recibido el 2023-06-05 por $800.00, ...');
INSERT INTO recaudadores VALUES (6, 'Javier', 'Hernandez', 'Pago recibido el 2023-06-06 por $700.00, ...');
INSERT INTO recaudadores VALUES (7, 'Sofia', 'Torres', 'Pago recibido el 2023-06-07 por $550.00, ...');
INSERT INTO recaudadores VALUES (8, 'Alejandro', 'Martinez', 'Pago recibido el 2023-06-08 por $400.00, ...');
INSERT INTO recaudadores VALUES (9, 'Carolina', 'Flores', 'Pago recibido el 2023-06-09 por $650.00, ...');
INSERT INTO recaudadores VALUES (10, 'Diego', 'Ramirez', 'Pago recibido el 2023-06-10 por $850.00, ...');
INSERT INTO recaudadores VALUES (11, 'Isabel', 'Vargas', 'Pago recibido el 2023-06-11 por $550.00, ...');
INSERT INTO recaudadores VALUES (12, 'Ricardo', 'Perez', 'Pago recibido el 2023-06-12 por $700.00, ...');
INSERT INTO recaudadores VALUES (13, 'Camila', 'Silva', 'Pago recibido el 2023-06-13 por $600.00, ...');
INSERT INTO recaudadores VALUES (14, 'Luis', 'Herrera', 'Pago recibido el 2023-06-14 por $800.00, ...');
INSERT INTO recaudadores VALUES (15, 'Fernanda', 'Gutierrez', 'Pago recibido el 2023-06-15 por $900.00, ...');
INSERT INTO recaudadores VALUES (16, 'Gabriel', 'Navarro', 'Pago recibido el 2023-06-16 por $500.00, ...');
INSERT INTO recaudadores VALUES (17, 'Valeria', 'Ortega', 'Pago recibido el 2023-06-17 por $750.00, ...');
INSERT INTO recaudadores VALUES (18, 'Andres', 'Fernandez', 'Pago recibido el 2023-06-18 por $400.00, ...');
INSERT INTO recaudadores VALUES (19, 'Paula', 'Mendoza', 'Pago recibido el 2023-06-19 por $650.00, ...');
INSERT INTO recaudadores VALUES (20, 'Sebastian', 'Rojas', 'Pago recibido el 2023-06-20 por $850.00, ...');
INSERT INTO recaudadores VALUES (21, 'Ana', 'Gonzalez', 'Pago recibido el 2023-06-01 por $500.00, ...');
INSERT INTO recaudadores VALUES (22, 'Carlos', 'Lopez', 'Pago recibido el 2023-06-02 por $750.00, ...');
INSERT INTO recaudadores VALUES (23, 'Maria', 'Sanchez', 'Pago recibido el 2023-06-03 por $600.00, ...');
INSERT INTO recaudadores VALUES (24, 'Pedro', 'Gomez', 'Pago recibido el 2023-06-04 por $900.00, ...');
INSERT INTO recaudadores VALUES (25, 'Laura', 'Rodriguez', 'Pago recibido el 2023-06-05 por $800.00, ...');
INSERT INTO recaudadores VALUES (26, 'Javier', 'Hernandez', 'Pago recibido el 2023-06-06 por $700.00, ...');
INSERT INTO recaudadores VALUES (27, 'Sofia', 'Torres', 'Pago recibido el 2023-06-07 por $550.00, ...');
INSERT INTO recaudadores VALUES (28, 'Alejandro', 'Martinez', 'Pago recibido el 2023-06-08 por $400.00, ...');
INSERT INTO recaudadores VALUES (29, 'Carolina', 'Flores', 'Pago recibido el 2023-06-09 por $650.00, ...');
INSERT INTO recaudadores VALUES (30, 'Diego', 'Ramirez', 'Pago recibido el 2023-06-10 por $850.00, ...');

select * from recaudadores;

-- recaudadores por sucursal

insert into recaudadores_por_sucursal values (1, 1);
insert into recaudadores_por_sucursal values (2, 2);
insert into recaudadores_por_sucursal values (3, 3);
insert into recaudadores_por_sucursal values (4, 4);
insert into recaudadores_por_sucursal values (5, 5);
insert into recaudadores_por_sucursal values (6, 6);
insert into recaudadores_por_sucursal values (7, 7);
insert into recaudadores_por_sucursal values (8, 8);
insert into recaudadores_por_sucursal values (9, 9);
insert into recaudadores_por_sucursal values (10, 10);
insert into recaudadores_por_sucursal values (11, 1);
insert into recaudadores_por_sucursal values (12, 1);
insert into recaudadores_por_sucursal values (13, 2);
insert into recaudadores_por_sucursal values (14, 4);
insert into recaudadores_por_sucursal values (15, 5);
insert into recaudadores_por_sucursal values (16, 3);
insert into recaudadores_por_sucursal values (17, 6);
insert into recaudadores_por_sucursal values (18, 7);
insert into recaudadores_por_sucursal values (19, 8);
insert into recaudadores_por_sucursal values (20, 5);
insert into recaudadores_por_sucursal values (21, 4);
insert into recaudadores_por_sucursal values (22, 4);
insert into recaudadores_por_sucursal values (23, 8);
insert into recaudadores_por_sucursal values (24, 9);
insert into recaudadores_por_sucursal values (25, 2);
insert into recaudadores_por_sucursal values (26, 3);
insert into recaudadores_por_sucursal values (27, 2);
insert into recaudadores_por_sucursal values (28, 10);
insert into recaudadores_por_sucursal values (29, 6);
insert into recaudadores_por_sucursal values (30, 8);

select * from recaudadores_por_sucursal;

-- contactos

INSERT INTO contactos VALUES (1, 'Maria', 'Gonzalez', 123456789, 'maria.gonzalez@email.com', 1);
INSERT INTO contactos VALUES (2, 'Juan', 'Lopez', 987654321, 'juan.lopez@email.com', 2);
INSERT INTO contactos VALUES (3, 'Pedro', 'Sanchez', 555555555, 'pedro.sanchez@email.com', 3);
INSERT INTO contactos VALUES (4, 'Laura', 'Gomez', 777777777, 'laura.gomez@email.com', 4);
INSERT INTO contactos VALUES (5, 'Carolina', 'Rodriguez', 111111111, 'carolina.rodriguez@email.com', 5);
INSERT INTO contactos VALUES (6, 'Sofia', 'Torres', 222222222, 'sofia.torres@email.com', 6);
INSERT INTO contactos VALUES (7, 'Diego', 'Hernandez', 333333333, 'diego.hernandez@email.com', 7);
INSERT INTO contactos VALUES (8, 'Gabriela', 'Martinez', 444444444, 'gabriela.martinez@email.com', 8);
INSERT INTO contactos VALUES (9, 'Javier', 'Fernandez', 555555555, 'javier.fernandez@email.com', 9);
INSERT INTO contactos VALUES (10, 'Valentina', 'Lopez', 666666666, 'valentina.lopez@email.com', 10);
INSERT INTO contactos VALUES (11, 'Andres', 'Gomez', 777777777, 'andres.gomez@email.com', 6);
INSERT INTO contactos VALUES (12, 'Isabella', 'Sanchez', 888888888, 'isabella.sanchez@email.com', 3);
INSERT INTO contactos VALUES (13, 'Ricardo', 'Perez', 999999999, 'ricardo.perez@email.com', 2);
INSERT INTO contactos VALUES (14, 'Camila', 'Hernandez', 111111111, 'camila.hernandez@email.com', 1);
INSERT INTO contactos VALUES (15, 'Luis', 'Rodriguez', 222222222, 'luis.rodriguez@email.com', 5);
INSERT INTO contactos VALUES (16, 'Fernanda', 'Martinez', 333333333, 'fernanda.martinez@email.com', 7);
INSERT INTO contactos VALUES (17, 'Alejandro', 'Gonzalez', 444444444, 'alejandro.gonzalez@email.com', 1);
INSERT INTO contactos VALUES (18, 'Paula', 'Sanchez', 555555555, 'paula.sanchez@email.com', 4);
INSERT INTO contactos VALUES (19, 'Jose', 'Torres', 666666666, 'jose.torres@email.com', 6);
INSERT INTO contactos VALUES (20, 'Mariana', 'Lopez', 777777777, 'mariana.lopez@email.com', 7);

select * from contactos;

-- polizas

INSERT INTO polizas VALUES (1, 'Poliza de Vida', 'Vida', 10000, '2023-01-01', '2024-01-01', 500, 1, 5);
INSERT INTO polizas VALUES (2, 'Poliza de Vida', 'Vida', 50000, '2023-02-01', '2024-02-01', 1000, 2, 3);
INSERT INTO polizas VALUES (3, 'Poliza contra accidentes', 'Seguridad', 20000, '2023-03-01', '2024-03-01', 800, 3, 9);
INSERT INTO polizas VALUES (4, 'Poliza contra robos', 'Seguridad', 30000, '2023-04-01', '2024-04-01', 600, 4, 6);
INSERT INTO polizas VALUES (5, 'Poliza de salud', 'Salud', 10000, '2023-05-01', '2024-05-01', 500, 5, 10);
INSERT INTO polizas VALUES (6, 'Poliza de Vida', 'Vida', 50000, '2023-06-01', '2024-06-01', 1000, 6, 2);
INSERT INTO polizas VALUES (7, 'Poliza de Vida', 'Vida', 50000, '2023-07-01', '2024-07-01', 1000, 7, 7);
INSERT INTO polizas VALUES (8, 'Poliza contra accidentes', 'Seguridad', 10000, '2023-08-01', '2024-08-01', 500, 8, 4);
INSERT INTO polizas VALUES (9, 'Poliza de Vida', 'Vida', 20000, '2023-09-01', '2024-09-01', 800, 9, 8);
INSERT INTO polizas VALUES (10, 'Poliza contra robos', 'Seguridad', 50000, '2023-10-01', '2024-10-01', 1000, 10, 1);

select * from polizas;

-- historial medico

INSERT INTO hisotriales_medicos VALUES (1, '2022-01-01', '2022-01-05', 'Juan Perez', 'Dolor de cabeza', 'Migrania', 'Descanso, analgesicos', 'Paracetamol', 'Mejora en el dolor de cabeza', 'Controlar la ingesta de cafeina');
INSERT INTO hisotriales_medicos VALUES (2, '2022-02-03', '2022-02-05', 'Laura Sanchez', 'Fiebre alta', 'Infeccion respiratoria', 'Antibioticos, reposo', 'Amoxicilina', 'Disminucion de la fiebre', 'Seguir tomando los medicamentos segun indicaciones');
INSERT INTO hisotriales_medicos VALUES (3, '2022-03-10', '2022-03-15', 'Carlos Gomez', 'Dolor de espalda', 'Hernia discal', 'Terapia fisica, analgesicos', 'Ibuprofeno, ejercicios de fortalecimiento', 'Reduccion del dolor y mejora de la movilidad', 'Realizar ejercicios de forma regular');
INSERT INTO hisotriales_medicos VALUES (4, '2022-04-15', '2022-04-20', 'Ana Garcia', 'Problemas digestivos', 'Intolerancia a la lactosa', 'Dieta libre de lactosa', 'N/A', 'Reduccion de los sintomas digestivos', 'Evitar consumir alimentos con lactosa');
INSERT INTO hisotriales_medicos VALUES (5, '2022-05-20', '2022-05-25', 'Pedro Lopez', 'Dolor en la rodilla', 'Lesion de ligamento', 'Reposo, fisioterapia', 'N/A', 'Mejora en la estabilidad de la rodilla', 'Evitar actividades de impacto');
INSERT INTO hisotriales_medicos VALUES (6, '2022-06-25', '2022-06-30', 'Maria Torres', 'Problemas respiratorios', 'Asma', 'Inhaladores, evitar alergenos', 'Salbutamol, corticosteroides', 'Control de los sintomas asmaticos', 'Llevar inhalador siempre disponible');
INSERT INTO hisotriales_medicos VALUES (7, '2022-07-03', '2022-07-05', 'Javier Hernandez', 'Dolor abdominal', 'Gastritis', 'Medicamentos para reducir la acidez, cambios en la dieta', 'Omeprazol, evitar alimentos picantes', 'Alivio del dolor y mejora en la digestion', 'Evitar comidas pesadas y llevar una alimentacion equilibrada');
INSERT INTO hisotriales_medicos VALUES (8, '2022-08-10', '2022-08-15', 'Sofia Ramirez', 'Mareos y vertigo', 'Vertigo posicional paroxistico benigno', 'Maniobras de reposicionamiento', 'N/A', 'Disminucion de los episodios de vertigo', 'Evitar cambios bruscos de posicion');
INSERT INTO hisotriales_medicos VALUES (9, '2022-09-15', '2022-09-20', 'Diego Martinez', 'Dolor en el hombro', 'Tendinitis del manguito rotador', 'Fisioterapia, antiinflamatorios', 'Ibuprofeno, ejercicios de fortalecimiento', 'Alivio del dolor y mejora de la movilidad', 'Realizar ejercicios de estiramiento y fortalecimiento');
INSERT INTO hisotriales_medicos VALUES (10, '2022-10-20', '2022-10-25', 'Carolina Flores', 'Ansiedad y estres', 'Trastorno de ansiedad generalizada', 'Terapia cognitivo-conductual, tecnicas de relajacion', 'N/A', 'Reduccion de los sintomas de ansiedad', 'Practicar tecnicas de relajacion regularmente');

select * from hisotriales_medicos;

-- asegurados

INSERT INTO asegurados VALUES (1, 'Juan', 'Gonzalez', 'Los Proceres 123', 123456789, 'juan.gonzalez@gmail.com', '1990-01-01', 'casado', 1);
INSERT INTO asegurados VALUES (2, 'Laura', 'Lopez', 'Av. Hualyas 456', 234567890, 'laura.lopez@hotmail.com', '1985-02-05', 'soltero', 2);
INSERT INTO asegurados VALUES (3, 'Carlos', 'Sanchez', 'Calle 3', 345678912, 'carlos.sanchez@gmail.com', '1992-03-10', 'soltero', 3);
INSERT INTO asegurados VALUES (4, 'Ana', 'Gomez', 'Av. Los Alicios 987', 456789123, 'ana.gomez@gmail.com', '1988-04-15', 'casado', 4);
INSERT INTO asegurados VALUES (5, 'Pedro', 'Rodriguez', 'Calle Central 321', 567901234, 'pedro.rodriguez@gmail.com', '1995-05-20', 'casado', 5);
INSERT INTO asegurados VALUES (6, 'Maria', 'Hernandez', 'Tupac Secundaria 654', 678012345, 'maria.hernandez@hotmail.com', '1993-06-25', 'casado', 6);
INSERT INTO asegurados VALUES (7, 'Javier', 'Torres', 'Calle Principal 234', 780123456, 'javier.torres@hotmail.com', '1991-07-03', 'casado', 7);
INSERT INTO asegurados VALUES (8, 'Sofia', 'Martinez', 'Los Sustipros 567', 890234567, 'sofia.martinez@gmail.com', '1989-08-10', 'soltero', 8);
INSERT INTO asegurados VALUES (9, 'Diego', 'Flores', 'Calle Almerarez 890', 901345678, 'diego.flores@hotmail.com', '1996-09-15', 'casado', 9);
INSERT INTO asegurados VALUES (10, 'Carolina', 'Ramirez', 'Av. Giron de la Union 876', 123567890, 'carolina.ramirez@hotmail.com', '1994-10-20', 'casado', 10);

select * from asegurados;

-- trabajos

INSERT INTO trabajos VALUES (1, 'Asistente de limpieza', 1000, 1);
INSERT INTO trabajos VALUES (2, 'Ayudante de cocina', 1200, 2);
INSERT INTO trabajos VALUES (3, 'Repartidor de volantes', 800, 3);
INSERT INTO trabajos VALUES (4, 'Cuidador de mascotas', 900, 4);
INSERT INTO trabajos VALUES (5, 'Empleado de tienda', 1100, 5);
INSERT INTO trabajos VALUES (6, 'Asistente de eventos', 1000, 6);
INSERT INTO trabajos VALUES (7, 'Auxiliar de almacen', 950, 7);
INSERT INTO trabajos VALUES (8, 'Ayudante de construccion', 1050, 8);
INSERT INTO trabajos VALUES (9, 'Vendedor ambulante', 800, 9);
INSERT INTO trabajos VALUES (10, 'Ayudante de reparto', 900, 10);

select * from trabajos;

-- pagos

INSERT INTO pagos VALUES (1, 'Visa', 1);
INSERT INTO pagos VALUES (2, 'MasterCard', 2);
INSERT INTO pagos VALUES (3, 'Visa', 3);
INSERT INTO pagos VALUES (4, 'Efectivo', 4);
INSERT INTO pagos VALUES (5, 'Visa', 5);
INSERT INTO pagos VALUES (6, 'MasterCard', 6);
INSERT INTO pagos VALUES (7, 'Visa', 7);
INSERT INTO pagos VALUES (8, 'Efectivo', 8);
INSERT INTO pagos VALUES (9, 'MasterCard', 9);
INSERT INTO pagos VALUES (10, 'Visa', 10);

select * from pagos;

-- beneficiarios

INSERT INTO beneficiarios VALUES (1, 'Juan', 'Gomez', 12345678);
INSERT INTO beneficiarios VALUES (2, 'Maria', 'Perez', 98765432);
INSERT INTO beneficiarios VALUES (3, 'Pedro', 'Lopez', 54321678);
INSERT INTO beneficiarios VALUES (4, 'Ana', 'Fernandez', 87654321);
INSERT INTO beneficiarios VALUES (5, 'Luis', 'Rodriguez', 56781234);
INSERT INTO beneficiarios VALUES (6, 'Laura', 'Sanchez', 43218765);
INSERT INTO beneficiarios VALUES (7, 'Carlos', 'Gonzalez', 76543218);
INSERT INTO dbo.beneficiarios VALUES (8, 'Sofia', 'Martinez', 21876543);
INSERT INTO dbo.beneficiarios VALUES (9, 'Andres', 'Hernandez', 65432187);
INSERT INTO dbo.beneficiarios VALUES (10, 'Julia', 'Torres', 32187654);
INSERT INTO dbo.beneficiarios VALUES (11, 'Gabriel', 'Lopez', 45678912);
INSERT INTO dbo.beneficiarios VALUES (12, 'Carolina', 'Ramirez', 89123456);
INSERT INTO dbo.beneficiarios VALUES (13, 'Daniel', 'Garcia', 67891234);
INSERT INTO dbo.beneficiarios VALUES (14, 'Elena', 'Flores', 34567891);
INSERT INTO dbo.beneficiarios VALUES (15, 'Alejandro', 'Soto', 78912345);

select * from beneficiarios;

-- polizas_para_belneficiairos

INSERT INTO polizas_para_beneficiarios VALUES (1, 1);
INSERT INTO polizas_para_beneficiarios VALUES (1, 2);
INSERT INTO polizas_para_beneficiarios VALUES (2, 3);
INSERT INTO polizas_para_beneficiarios VALUES (2, 4);
INSERT INTO polizas_para_beneficiarios VALUES (3, 5);
INSERT INTO polizas_para_beneficiarios VALUES (3, 6);
INSERT INTO polizas_para_beneficiarios VALUES (4, 7);
INSERT INTO polizas_para_beneficiarios VALUES (4, 8);
INSERT INTO polizas_para_beneficiarios VALUES (5, 9);
INSERT INTO polizas_para_beneficiarios VALUES (5, 10);
INSERT INTO polizas_para_beneficiarios VALUES (6, 11);
INSERT INTO polizas_para_beneficiarios VALUES (6, 12);
INSERT INTO polizas_para_beneficiarios VALUES (7, 13);
INSERT INTO polizas_para_beneficiarios VALUES (7, 14);
INSERT INTO polizas_para_beneficiarios VALUES (8, 15);

select * from polizas_para_beneficiarios;




