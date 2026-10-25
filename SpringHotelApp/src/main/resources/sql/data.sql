USE hoteldb;

INSERT INTO usuarios (username, password, rol) VALUES
('recepcion1', 'recep123', 'RECEPCIONISTA'),
('supervisor1', 'super123', 'SUPERVISOR');

INSERT INTO habitaciones (numero, tipo, precio, disponible) VALUES
('101', 'Individual', 45.00, TRUE),
('102', 'Individual', 48.00, TRUE),
('201', 'Doble', 70.00, TRUE),
('202', 'Doble', 75.00, TRUE),
('301', 'Suite', 120.00, TRUE),
('302', 'Suite', 130.00, TRUE),
('401', 'Familiar', 95.00, TRUE),
('402', 'Familiar', 100.00, TRUE);

INSERT INTO huespedes (nombre, apellidos, dni, telefono, email) VALUES
('Carlos', 'Ramirez Soto', '11111111A', '600111111', 'carlos@example.com'),
('Lucia', 'Martinez Diaz', '22222222B', '600222222', 'lucia@example.com'),
('Pedro', 'Gomez Ruiz', '33333333C', '600333333', 'pedro@example.com'),
('Ana', 'Lopez Perez', '44444444D', '600444444', 'ana@example.com'),
('Sofia', 'Hernandez Gil', '55555555E', '600555555', 'sofia@example.com');

INSERT INTO reservas (huesped_id, habitacion_id, fecha_entrada, fecha_salida) VALUES
(1, 1, '2024-05-10', '2024-05-12'),
(2, 3, '2024-06-01', '2024-06-05'),
(3, 5, '2024-07-15', '2024-07-20'),
(4, 7, '2024-08-02', '2024-08-04'),
(5, 2, '2024-09-10', '2024-09-12');

INSERT INTO incidencias (habitacion_id, descripcion, estado, prioridad, fecha_reporte) VALUES
(1, 'Aire acondicionado gotea', 'abierta', 'alta', '2024-05-11'),
(3, 'Bombilla fundida', 'cerrada', 'baja', '2024-05-20'),
(3, 'TV no funciona', 'abierta', 'baja', '2024-05-20'),
(5, 'Grifo con fuga', 'en curso', 'media', '2024-06-01'),
(7, 'Puerta no cierra correctamente', 'cerrada', 'alta', '2024-06-03');