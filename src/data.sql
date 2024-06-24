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
(56789012, 'Carlos', 'Lopez', '1122334455', 'Calle Luna 333', 'Santa Fe', 'Rosario', '1978-12-30', 'carlos.lopez@example.com', 0),
(34567890, 'Ana', 'Martinez', '2233445566', 'Calle Sol 1234', 'Mendoza', 'Mendoza', '1992-08-25', 'ana.martinez@example.com', 1),
(78901234, 'Luis', 'Fernandez', '3344556677', 'Av. Libertador 1234', 'Buenos Aires', 'San Isidro', '1980-11-12', 'luis.fernandez@example.com', 0);
