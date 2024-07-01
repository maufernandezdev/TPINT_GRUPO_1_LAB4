INSERT INTO usuario (nombreUser, contrasenia, tipoDeUsuario) VALUES ('admin', 'admin', 1);
INSERT INTO usuario (nombreUser, contrasenia, tipoDeUsuario) VALUES ('frgp_admin', '1234', 1);
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
