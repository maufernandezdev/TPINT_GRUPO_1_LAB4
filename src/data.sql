/*Usuarios admin y medico*/
INSERT INTO usuario (nombreUser, contrasenia, tipoDeUsuario) VALUES 
('admin', 'admin', 1),
('frgp_admin', '1234', 1),
('medico1', 'medico1', 0),
('medico2', 'medico2', 0),
('medico3', 'medico3', 0),
('medico4', 'medico4', 0),
('medico5', 'medico5', 0),
('medico6', 'medico6', 0),
('medico7', 'medico7', 0),
('medico8', 'medico8', 0),
('medico9', 'medico9', 0),
('medico10', 'medico10', 0),
('medico11', 'medico11', 0),
('medico12', 'medico12', 0),
('medico13', 'medico13', 0),
('medico14', 'medico14', 0),
('medico15', 'medico15', 0);

/*Especialidad*/
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
('Tres Arroyos', 1),
('Río Cuarto', 2),
('Santa Maria', 2),
('Calamuchita', 2),
('Carlos Paz', 2),
('Tunuyán', 3),
('Malargue', 3),
('Guaymallén',3),
('San Rafael',3),
('Colón', 4),
('Gualeguaychú', 4),
('Paraná', 4) ;

/*Pacientes*/
INSERT INTO pacientes (dni, nombre, apellido, telefono, direccion,  id_localidad, fechaNac, correo, estado) 
VALUES 
(12345678, 'Juan', 'Perez', '1234567890', 'Calle Falsa 123',  '2', '1990-01-01', 'juan.perez@example.com', 1),
(87654321, 'Maria', 'Gomez', '0987654321', 'Av. Siempre Viva 742',  '3', '1985-05-15', 'maria.gomez@example.com', 1),
(56789012, 'Carlos', 'Lopez', '1122334455', 'Calle Luna 333',  '4', '1978-12-30', 'carlos.lopez@example.com', 1),
(34567890, 'Ana', 'Martinez', '2233445566', 'Calle Sol 1234',  '5', '1992-08-25', 'ana.martinez@example.com', 1),
(78901234, 'Luis', 'Fernandez', '3344556677', 'Av. Libertador 1234',  '1', '1980-11-12', 'luis.fernandez@example.com', 1),
(11111111, 'Gabriel', 'Rodriguez', '1111111111', 'Calle Alegre 111',  '1', '1987-04-10', 'gabriel.rodriguez@example.com', 1),
(22222222, 'Laura', 'Garcia', '2222222222', 'Av. Esperanza 222',  '2', '1995-09-20', 'laura.garcia@example.com', 1),
(33333333, 'Diego', 'Sanchez', '3333333333', 'Calle Primavera 333',  '3', '1982-03-05', 'diego.sanchez@example.com', 1),
(44444444, 'Valeria', 'Lopez', '4444444444', 'Av. Paz 444',  '4', '1976-07-15', 'valeria.lopez@example.com', 1),
(55555555, 'Javier', 'Martinez', '5555555555', 'Calle Libertad 555',  '5', '1990-12-25', 'javier.martinez@example.com', 1),
(66666666, 'Lucia', 'Fernandez', '6666666666', 'Av. Unión 666',  '6', '1988-06-30', 'lucia.fernandez@example.com', 1),
(77777777, 'Sofia', 'Alvarez', '7777777777', 'Calle Sol y Luna 777',  '7', '1984-02-18', 'sofia.alvarez@example.com', 1),
(88888888, 'Matias', 'Perez', '8888888888', 'Av. del Sol 888',  '8', '1993-10-08', 'matias.perez@example.com', 1),
(99999999, 'Camila', 'Gomez', '9999999999', 'Calle del Mar 999',  '9', '1975-11-05', 'camila.gomez@example.com', 1),
(10101010, 'Maximiliano', 'Rodriguez', '1010101010', 'Av. Esperanza 1010',  '10', '1998-08-15', 'maximiliano.rodriguez@example.com', 1);


/*Medicos*/
INSERT INTO medicos (apellido, correo, direccion, estado, fechaNac, horario_id, nombre, sexo, telefono, id_especialidad, id_localidad, usuario_c)
VALUES
('Gonzalez', 'gonzalez@example.com', 'Calle 123', 1, '1980-05-15', 1, 'Juan', 'M', '123456789', 1, 2, 'medico1'),
('Perez', 'perez@example.com', 'Avenida 456', 1, '1975-02-20', 1, 'Maria', 'F', '987654321', 1, 2, 'medico2'),
('Rodriguez', 'rodriguez@example.com', 'Boulevard 789', 1, '1988-11-11', 1, 'Carlos', 'M', '112233445', 1, 2, 'medico3'),
('Martinez', 'martinez@example.com', 'Pasaje 101', 1, '1992-09-25', 1, 'Lucia', 'F', '223344556', 1, 2, 'medico4'),
('Lopez', 'lopez@example.com', 'Calle 202', 1, '1985-07-30', 1, 'Pedro', 'M', '334455667', 1, 2, 'medico5'),
('Fernandez', 'fernandez@example.com', 'Avenida 303', 1, '1978-12-12', 1, 'Ana', 'F', '445566778', 1, 2, 'medico6'),
('Garcia', 'garcia@example.com', 'Boulevard 404', 1, '1990-03-14', 1, 'Miguel', 'M', '556677889', 1, 2, 'medico7'),
('Hernandez', 'hernandez@example.com', 'Pasaje 505', 1, '1983-08-22', 1, 'Elena', 'F', '667788990', 1, 2, 'medico8'),
('Torres', 'torres@example.com', 'Calle 606', 1, '1986-01-01', 1, 'Jorge', 'M', '778899001', 1, 2, 'medico9'),
('Sanchez', 'sanchez@example.com', 'Avenida 707', 1, '1993-04-04', 1, 'Isabel', 'F', '889900112', 1, 2, 'medico10'),
('Rojas', 'rojas@example.com', 'Calle 808', 1, '1982-06-15', 1, 'Julia', 'F', '998877665', 1, 2, 'medico11'),
('Gimenez', 'gimenez@example.com', 'Avenida 909', 1, '1976-03-10', 1, 'Gabriel', 'M', '887766554', 1, 2, 'medico12'),
('Moreno', 'moreno@example.com', 'Boulevard 1010', 1, '1991-09-20', 1, 'Valentina', 'F', '776655443', 1, 2, 'medico13'),
('Silva', 'silva@example.com', 'Pasaje 1112', 1, '1984-12-05', 1, 'Mateo', 'M', '665544332', 1, 2, 'medico14'),
('Luna', 'luna@example.com', 'Calle 1213', 1, '1987-07-08', 1, 'Camila', 'F', '554433221', 1, 2, 'medico15');


/*turnos de prueba*/
INSERT INTO turnos (estado_turno, estado, fecha, hora, observacion, idMedico, idPaciente)
VALUES 
('PRESENTE', 'ACTIVO', '2024-01-10', '09:00:00', 'Observación 1', 1, 12345678),
('AUSENTE', 'ACTIVO', '2024-01-15', '10:00:00', 'Observación 2', 2, 87654321),
('PRESENTE', 'ACTIVO', '2024-01-20', '11:00:00', 'Observación 3', 3, 56789012),
('AUSENTE', 'ACTIVO', '2024-01-25', '12:00:00', 'Observación 4', 1, 34567890),
('PRESENTE', 'ACTIVO', '2024-01-30', '13:00:00', 'Observación 5', 2, 78901234),
('AUSENTE', 'ACTIVO', '2024-02-05', '14:00:00', 'Observación 6', 3, 12345678),
('PRESENTE', 'ACTIVO', '2024-02-10', '15:00:00', 'Observación 7', 1, 87654321),
('AUSENTE', 'ACTIVO', '2024-02-15', '16:00:00', 'Observación 8', 2, 56789012),
('PRESENTE', 'ACTIVO', '2024-02-20', '17:00:00', 'Observación 9', 3, 34567890),
('AUSENTE', 'ACTIVO', '2024-02-25', '18:00:00', 'Observación 10', 1, 78901234),
('PRESENTE', 'ACTIVO', '2024-07-05', '09:00:00', 'Observación 11', 2, 12345678),
('PENDIENTE', 'ACTIVO', '2024-08-10', '10:00:00', 'Observación 12', 3, 87654321),
('PENDIENTE', 'ACTIVO', '2024-09-15', '11:00:00', 'Observación 13', 1, 56789012),
('PENDIENTE', 'ACTIVO', '2024-09-20', '12:00:00', 'Observación 14', 2, 34567890),
('PENDIENTE', 'ACTIVO', '2024-10-25', '13:00:00', 'Observación 15', 3, 78901234);

/*horarios de prueba*/
INSERT INTO horarios (dia, hora_inicio, hora_fin, medico_id) VALUES
('Lunes', '08:00:00', '20:00:00', 1),
('Martes', '13:00:00', '18:00:00', 1),

('Miércoles', '14:00:00', '20:00:00', 2),
('Viernes', '14:00:00', '20:00:00', 2),

('Lunes', '09:00:00', '12:00:00', 3),
('Jueves', '16:00:00', '18:00:00', 3),

('Martes', '08:00:00', '12:00:00', 4),
('Jueves', '08:00:00', '12:00:00', 4),

('Miércoles', '09:00:00', '13:00:00', 5),
('Viernes', '09:00:00', '13:00:00', 5),

('Martes', '10:00:00', '14:00:00', 6),
('Jueves', '11:00:00', '15:00:00', 6),

('Miércoles', '08:00:00', '12:00:00', 7),
('Viernes', '08:00:00', '12:00:00', 7),

('Lunes', '15:00:00', '19:00:00', 8),
('Miércoles', '15:00:00', '19:00:00', 8);
