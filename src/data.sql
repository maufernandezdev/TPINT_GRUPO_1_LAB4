INSERT INTO usuario (nombreUser, contrasenia, tipoDeUsuario) VALUES ('admin', 'admin', 1);
INSERT INTO usuario (nombreUser, contrasenia, tipoDeUsuario) VALUES ('frgp_admin', '1234', 1);
/*Usuarios medico*/
INSERT INTO usuario (nombreUser, contrasenia, tipoDeUsuario) VALUES ('medico1', 'medico1', 0);
INSERT INTO usuario (nombreUser, contrasenia, tipoDeUsuario) VALUES ('medico2', 'medico2', 0);
INSERT INTO usuario (nombreUser, contrasenia, tipoDeUsuario) VALUES ('medico3', 'medico3', 0);
INSERT INTO usuario (nombreUser, contrasenia, tipoDeUsuario) VALUES ('medico4', 'medico4', 0);
INSERT INTO usuario (nombreUser, contrasenia, tipoDeUsuario) VALUES ('medico5', 'medico5', 0);
INSERT INTO usuario (nombreUser, contrasenia, tipoDeUsuario) VALUES ('medico6', 'medico6', 0);
INSERT INTO usuario (nombreUser, contrasenia, tipoDeUsuario) VALUES ('medico7', 'medico7', 0);
INSERT INTO usuario (nombreUser, contrasenia, tipoDeUsuario) VALUES ('medico8', 'medico8', 0);
INSERT INTO usuario (nombreUser, contrasenia, tipoDeUsuario) VALUES ('medico9', 'medico9', 0);
INSERT INTO usuario (nombreUser, contrasenia, tipoDeUsuario) VALUES ('medico10', 'medico10', 0);

INSERT INTO especialidad (nombre) VALUES
('Cardiología'),
('Dermatología'),
('Endocrinología'),
('Radiología'),
('Neurología'),
('Oftalmología'),
('Ortopedia'),
('Pediatría'),
('Psiquiatría');
/*Pacientes*/
INSERT INTO Pacientes (dni, nombre, apellido, telefono, direccion, provincia, localidad, fechaNac, correo, estado) 
VALUES 
(12345678, 'Juan', 'Perez', '1234567890', 'Calle Falsa 123', 'Buenos Aires', 'Ciudad Autonoma de Buenos Aires', '1990-01-01', 'juan.perez@example.com', 1),
(87654321, 'Maria', 'Gomez', '0987654321', 'Av. Siempre Viva 742', 'Cordoba', 'Cordoba', '1985-05-15', 'maria.gomez@example.com', 1),
(56789012, 'Carlos', 'Lopez', '1122334455', 'Calle Luna 333', 'Santa Fe', 'Rosario', '1978-12-30', 'carlos.lopez@example.com', 1),
(34567890, 'Ana', 'Martinez', '2233445566', 'Calle Sol 1234', 'Mendoza', 'Mendoza', '1992-08-25', 'ana.martinez@example.com', 1),
(78901234, 'Luis', 'Fernandez', '3344556677', 'Av. Libertador 1234', 'Buenos Aires', 'San Isidro', '1980-11-12', 'luis.fernandez@example.com', 1);
/*turnos de prueba*/
INSERT INTO turnos (estado_turno, estado, fecha, hora, observacion, idMedico, idPaciente)
VALUES 
(1, 'ACTIVO', '2024-01-10', '09:00:00', 'Observación 1', 1, 12345678),
(2, 'ACTIVO', '2024-01-15', '10:00:00', 'Observación 2', 2, 87654321),
(2, 'ACTIVO', '2024-01-20', '11:00:00', 'Observación 3', 3, 56789012),
(2, 'ACTIVO', '2024-01-25', '12:00:00', 'Observación 4', 1, 34567890),
(1, 'ACTIVO', '2024-01-30', '13:00:00', 'Observación 5', 2, 78901234),
(1, 'ACTIVO', '2024-02-05', '14:00:00', 'Observación 6', 3, 12345678),
(1, 'ACTIVO', '2024-02-10', '15:00:00', 'Observación 7', 1, 87654321),
(1, 'ACTIVO', '2024-02-15', '16:00:00', 'Observación 8', 2, 56789012),
(1, 'ACTIVO', '2024-02-20', '17:00:00', 'Observación 9', 3, 34567890),
(1, 'ACTIVO', '2024-02-25', '18:00:00', 'Observación 10', 1, 78901234),
(0, 'ACTIVO', '2024-07-05', '09:00:00', 'Observación 11', 2, 12345678),
(0, 'ACTIVO', '2024-08-10', '10:00:00', 'Observación 12', 3, 87654321),
(0, 'ACTIVO', '2024-09-15', '11:00:00', 'Observación 13', 1, 56789012),
(0, 'ACTIVO', '2024-09-20', '12:00:00', 'Observación 14', 2, 34567890),
(0, 'ACTIVO', '2024-10-25', '13:00:00', 'Observación 15', 3, 78901234);

/* Provincias y localidades*/

insert into provincias(nombre) values
('Buenos Aires'),
('Cordoba'),
('Mendoza'),
('Entre Rios') ;


insert into localidades (nombre, id_provincia) values
('Tigre', 1),
('Escobar', 1),
('Pilar', 1),
('Río Cuarto', 2),
('Santa Maria', 2),
('Calamuchita', 2),
('Tunuyán', 3),
('Malargue', 3),
('Guaymallén',3),
('Colón', 4),
('Gualeguaychú', 4),
('Paraná', 4)


/*medicos*/
INSERT INTO medicos (apellido, correo, direccion, estado, fechaNac, horario_id, nombre, sexo, telefono, id_especialidad, id_localidad, usuario_c)
VALUES ('Gonzalez', 'gonzalez@example.com', 'Calle 123', 1, '1980-05-15', 1, 'Juan', 'M', '123456789', 1, 2, 'medico1');

INSERT INTO medicos (apellido, correo, direccion, estado, fechaNac, horario_id, nombre, sexo, telefono, id_especialidad, id_localidad, usuario_c)
VALUES ('Perez', 'perez@example.com', 'Avenida 456', 1, '1975-02-20', 1, 'Maria', 'F', '987654321', 1, 2, 'medico2');

INSERT INTO medicos (apellido, correo, direccion, estado, fechaNac, horario_id, nombre, sexo, telefono, id_especialidad, id_localidad, usuario_c)
VALUES ('Rodriguez', 'rodriguez@example.com', 'Boulevard 789', 1, '1988-11-11', 1, 'Carlos', 'M', '112233445', 1, 2, 'medico3');

INSERT INTO medicos (apellido, correo, direccion, estado, fechaNac, horario_id, nombre, sexo, telefono, id_especialidad, id_localidad, usuario_c)
VALUES ('Martinez', 'martinez@example.com', 'Pasaje 101', 1, '1992-09-25', 1, 'Lucia', 'F', '223344556', 1, 2, 'medico4');

INSERT INTO medicos (apellido, correo, direccion, estado, fechaNac, horario_id, nombre, sexo, telefono, id_especialidad, id_localidad, usuario_c)
VALUES ('Lopez', 'lopez@example.com', 'Calle 202', 1, '1985-07-30', 1, 'Pedro', 'M', '334455667', 1, 2, 'medico5');

INSERT INTO medicos (apellido, correo, direccion, estado, fechaNac, horario_id, nombre, sexo, telefono, id_especialidad, id_localidad, usuario_c)
VALUES ('Fernandez', 'fernandez@example.com', 'Avenida 303', 1, '1978-12-12', 1, 'Ana', 'F', '445566778', 1, 2, 'medico6');

INSERT INTO medicos (apellido, correo, direccion, estado, fechaNac, horario_id, nombre, sexo, telefono, id_especialidad, id_localidad, usuario_c)
VALUES ('Garcia', 'garcia@example.com', 'Boulevard 404', 1, '1990-03-14', 1, 'Miguel', 'M', '556677889', 1, 2, 'medico7');

INSERT INTO medicos (apellido, correo, direccion, estado, fechaNac, horario_id, nombre, sexo, telefono, id_especialidad, id_localidad, usuario_c)
VALUES ('Hernandez', 'hernandez@example.com', 'Pasaje 505', 1, '1983-08-22', 1, 'Elena', 'F', '667788990', 1, 2, 'medico8');

INSERT INTO medicos (apellido, correo, direccion, estado, fechaNac, horario_id, nombre, sexo, telefono, id_especialidad, id_localidad, usuario_c)
VALUES ('Torres', 'torres@example.com', 'Calle 606', 1, '1986-01-01', 1, 'Jorge', 'M', '778899001', 1, 2, 'medico9');

INSERT INTO medicos (apellido, correo, direccion, estado, fechaNac, horario_id, nombre, sexo, telefono, id_especialidad, id_localidad, usuario_c)
VALUES ('Sanchez', 'sanchez@example.com', 'Avenida 707', 1, '1993-04-04', 1, 'Isabel', 'F', '889900112', 1, 2, 'medico10');


