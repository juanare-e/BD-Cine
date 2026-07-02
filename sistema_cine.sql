create database sistema_cine;

use sistema_cine;

-- creacion de las tablas
--  HECHO POR JUAN ESTEBAN ARENAS Y ANGEL FERNANDO SALAZAR

-- Tabla tipo de pelicula
create table tipo_pelicula(
id_tipo_pelicula INT NOT NULL,
tipo_pelicula VARCHAR(100) NOT NULL,
primary key(id_tipo_pelicula)
);


-- Tabla pelicualas
create table peliculas(
id_pelicula INT NOT NULL,
nombre_pelicula VARCHAR(100) NOT NULL,
duracion_pelicula INT NOT NULL,
id_tipo_pelicula INT NOT NULL,
primary key(id_pelicula),
constraint id_tipo_pelicula foreign key (id_tipo_pelicula) references tipo_pelicula(id_tipo_pelicula)
);

-- Tabla salas
create table salas(
id_sala int not null,
tipo_sala varchar(100) not null,
capacidad int not null,
primary key(id_sala)
);

-- TAbla Sillas
create table sillas(
id_silla int not null,
fila int not null,
numero int not null,
id_sala int not null,
primary key(id_silla),
constraint id_sala foreign key (id_sala) references salas(id_sala)
);

-- Table funciones
create table funciones(
id_funcion int not null,
fecha_hora datetime not null,
precio int not null,
id_pelicula int not null,
id_sala int not null,
primary key(id_funcion)
);

alter table funciones add constraint id_pelicula foreign key (id_pelicula) references peliculas(id_pelicula);
alter table funciones add constraint id_sala_funciones foreign key (id_sala) references salas(id_sala);

-- Tabla clientes
create table clientes(
id_cliente int not null,
nombre_cliente varchar(200) not null,
edad_cliente int not null,
telefono_cliente varchar(15) not null,
correo_cliente varchar(150) not null,
primary key(id_cliente)
);

-- TAbla empleado
create table empleados(
id_empleado int not null,
nombre_empleado varchar(200) not null,
cargo varchar(150) not null,
telefono_empleado varchar(15),
primary key(id_empleado)
);

-- Tabl comida
create table comida(
id_producto int not null,
nombre_producto varchar(150) not null,
tipo_producto varchar(150) not null,
precio_producto decimal(7) not null,
stock_producto int,
primary key(id_producto)
); 

-- Tabla ventas
create table venta(
id_venta int not null,
id_cliente int not null,
id_empleado int not null,
id_funcion int not null,
total decimal(7) not null,
metodo_pago varchar(100),
primary key(id_venta)
);

select * from venta;

-- Llamado de las llaves pirmarias
alter table venta add constraint id_cliente_fk foreign key (id_cliente) references clientes(id_cliente);
alter table venta add constraint id_empleado foreign key (id_empleado) references empleados(id_empleado);
alter table venta add constraint id_funcion foreign key (id_funcion) references funciones(id_funcion);
alter table venta add column id_producto int not null;
alter table venta add constraint id_producto foreign key (id_producto) references comida(id_producto);

-- Creacion tabla boletos
create table boletos(
id_boleto int not null,

id_venta int not null,
id_funcion int not null,
id_silla int not null,
id_cliente int not null,
precio_final decimal(8) not null,

primary key(id_boleto)
);

alter table boletos add constraint id_venta foreign key (id_venta) references venta(id_venta);
alter table boletos add constraint id_funcion_fk foreign key (id_funcion) references funciones(id_funcion);
alter table boletos add constraint id_silla foreign key (id_silla) references sillas(id_silla);
alter table boletos add constraint id_cliente foreign key (id_cliente) references clientes(id_cliente);

-- Fin base de datos

-- Solucion temas de redundancia
-- Quitamos primero los candados (Constraints)
ALTER TABLE venta DROP FOREIGN KEY id_funcion;
ALTER TABLE venta DROP FOREIGN KEY id_producto;

-- Ahora sí borramos las columnas
ALTER TABLE venta DROP COLUMN id_funcion;
ALTER TABLE venta DROP COLUMN id_producto;

-- Quitamos el candado del cliente en boletos
ALTER TABLE boletos DROP FOREIGN KEY id_cliente;

-- Borramos la columna sobrante
ALTER TABLE boletos DROP COLUMN id_cliente;

CREATE TABLE detalle_venta_comida (
    id_detalle INT NOT NULL AUTO_INCREMENT,
    id_venta INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    subtotal DECIMAL(7,2),
    PRIMARY KEY (id_detalle),
    CONSTRAINT fk_venta_comida FOREIGN KEY (id_venta) REFERENCES venta(id_venta),
    CONSTRAINT fk_producto_comida FOREIGN KEY (id_producto) REFERENCES comida(id_producto)
);

-- Creo que ahi ya estaria bien

-- Ahora toca ingresar los datos a cada una de las tablas

--       |||
--       |||
--       |||
--       |||
--       |||
--       |||
--       |||
--       |||
--   \   |||   /
--    \  |||  /
--     \ ||| /
--      \ | /
--       \ /
--        V

-- 1. TIPOS DE PELÍCULA
INSERT INTO tipo_pelicula (id_tipo_pelicula, tipo_pelicula) VALUES 
(1, 'Acción'), (2, 'Comedia'), (3, 'Drama'), (4, 'Terror'), (5, 'Ciencia Ficción'), 
(6, 'Animación'), (7, 'Romance'), (8, 'Documental'), (9, 'Suspenso'), (10, 'Fantasía'), 
(11, 'Musical'), (12, 'Aventura'), (13, 'Crimen'), (14, 'Misterio'), (15, 'Western');

-- 2. PELÍCULAS (Duración en minutos)
INSERT INTO peliculas (id_pelicula, nombre_pelicula, duracion_pelicula, id_tipo_pelicula) VALUES 
(1, 'Avengers: Endgame', 181, 1), (2, 'Toy Story 4', 100, 6), (3, 'El Conjuro', 112, 4), 
(4, 'Interstellar', 169, 5), (5, 'Parasite', 132, 9), (6, 'La La Land', 128, 11), 
(7, 'Joker', 122, 3), (8, 'Spider-Man: No Way Home', 148, 1), (9, 'Coco', 105, 6), 
(10, 'Inception', 148, 5), (11, 'The Batman', 176, 1), (12, 'Super Mario Bros', 92, 6), 
(13, 'Dune', 155, 5), (14, 'John Wick 4', 169, 1), (15, 'Barbie', 114, 2);

-- 3. SALAS
INSERT INTO salas (id_sala, tipo_sala, capacidad) VALUES 
(1, '2D Estándar', 50), (2, '2D Estándar', 50), (3, '3D Plus', 40), (4, '3D Plus', 40), (5, 'IMAX', 60), 
(6, 'VIP Lounge', 20), (7, 'VIP Lounge', 20), (8, 'Macro XE', 80), (9, '2D Estándar', 50), (10, '4DX', 30), 
(11, 'Junior', 40), (12, 'IMAX', 60), (13, 'VIP Lounge', 20), (14, '2D Estándar', 50), (15, 'Black', 25);

-- 4. SILLAS (Ejemplo para Sala 1 y Sala 6)
INSERT INTO sillas (id_silla, fila, numero, id_sala) VALUES 
(1, 1, 1, 1), (2, 1, 2, 1), (3, 1, 3, 1), (4, 1, 4, 1), (5, 2, 1, 1),
(6, 2, 2, 1), (7, 2, 3, 1), (8, 2, 4, 1), (9, 3, 1, 1), (10, 3, 2, 1),
(11, 1, 1, 6), (12, 1, 2, 6), (13, 2, 1, 6), (14, 2, 2, 6), (15, 3, 1, 6);

-- 5. FUNCIONES (Precios en pesos/moneda entera)
INSERT INTO funciones (id_funcion, fecha_hora, precio, id_pelicula, id_sala) VALUES 
(1, '2026-05-20 14:00:00', 15000, 1, 5), (2, '2026-05-20 15:30:00', 12000, 2, 1), 
(3, '2026-05-20 18:00:00', 18000, 3, 10), (4, '2026-05-20 20:00:00', 25000, 11, 6), 
(5, '2026-05-21 13:00:00', 12000, 15, 2), (6, '2026-05-21 16:00:00', 15000, 8, 8), 
(7, '2026-05-21 19:00:00', 20000, 13, 12), (8, '2026-05-22 14:00:00', 10000, 9, 11), 
(9, '2026-05-22 17:00:00', 12000, 12, 3), (10, '2026-05-22 21:00:00', 25000, 14, 7), 
(11, '2026-05-23 11:00:00', 8000, 12, 1), (12, '2026-05-23 15:00:00', 15000, 4, 5), 
(13, '2026-05-23 18:00:00', 15000, 10, 5), (14, '2026-05-24 20:00:00', 18000, 5, 15), 
(15, '2026-05-24 22:00:00', 12000, 7, 9);

-- 6. CLIENTES
INSERT INTO clientes (id_cliente, nombre_cliente, edad_cliente, telefono_cliente, correo_cliente) VALUES 
(1, 'Juan Perez', 25, '3001234567', 'juan@mail.com'), (2, 'Maria Lopez', 30, '3007654321', 'maria@mail.com'), 
(3, 'Carlos Ruiz', 19, '3112223344', 'carlos@mail.com'), (4, 'Ana Silva', 45, '3159998877', 'ana@mail.com'), 
(5, 'Luis Gomez', 22, '3104445566', 'luis@mail.com'), (6, 'Sonia Cano', 28, '3012345678', 'sonia@mail.com'), 
(7, 'Pedro Paez', 35, '3123456789', 'pedro@mail.com'), (8, 'Elena Marín', 21, '3201112233', 'elena@mail.com'), 
(9, 'Jorge Tovar', 50, '3187776655', 'jorge@mail.com'), (10, 'Marta Gil', 27, '3174441122', 'marta@mail.com'), 
(11, 'Andrés Soto', 18, '3160001122', 'andres@mail.com'), (12, 'Lucía Ríos', 32, '3213334455', 'lucia@mail.com'), 
(13, 'Kevin Caro', 24, '3145556677', 'kevin@mail.com'), (14, 'Rosa Soler', 40, '3198889900', 'rosa@mail.com'), 
(15, 'Hugo Velez', 29, '3001110011', 'hugo@mail.com');

-- 7. EMPLEADOS
INSERT INTO empleados (id_empleado, nombre_empleado, cargo, telefono_empleado) VALUES 
(1, 'Roberto Díaz', 'Cajero', '300111'), (2, 'Sandra Pola', 'Supervisor', '300222'), 
(3, 'Miguel Angel', 'Aseo', '300333'), (4, 'Laura Restrepo', 'Cajero', '300444'), 
(5, 'Oscar Wilde', 'Gerente', '300555'), (6, 'Felipe Cano', 'Cajero', '300666'), 
(7, 'Diana Luz', 'Seguridad', '300777'), (8, 'Camila Paz', 'Candy Bar', '300888'), 
(9, 'Raul Castro', 'Proyeccionista', '300999'), (10, 'Inés Perla', 'Cajero', '300101'), 
(11, 'Julian Gil', 'Aseo', '300202'), (12, 'Sofia Vergara', 'Atención VIP', '300303'), 
(13, 'Mario Bros', 'Mantenimiento', '300404'), (14, 'Luigi Bros', 'Mantenimiento', '300505'), 
(15, 'Wanda Maximoff', 'Taquilla', '300606');

-- 8. COMIDA
INSERT INTO comida (id_producto, nombre_producto, tipo_producto, precio_producto, stock_producto) VALUES 
(1, 'Palomitas Grandes', 'Snack', 12000, 100), (2, 'Palomitas Medianas', 'Snack', 9000, 150), 
(3, 'Gaseosa 16oz', 'Bebida', 5000, 200), (4, 'Gaseosa 22oz', 'Bebida', 7000, 200), 
(5, 'Perro Caliente', 'Comida Rapida', 10000, 80), (6, 'Nachos con Queso', 'Snack', 11000, 60), 
(7, 'Chocolatina Jet', 'Dulce', 2000, 300), (8, 'Agua Mineral', 'Bebida', 4000, 100), 
(9, 'Combo Pareja', 'Combo', 25000, 50), (10, 'Combo Niños', 'Combo', 18000, 50), 
(11, 'M&Ms', 'Dulce', 6000, 120), (12, 'Pizza Slice', 'Comida Rapida', 8000, 40), 
(13, 'Te Helado', 'Bebida', 6000, 90), (14, 'Crispetas Caramelo', 'Snack', 13000, 70), 
(15, 'Sandwich Jamon', 'Comida Rapida', 9000, 30);

-- 9. VENTAS
INSERT INTO venta (id_venta, id_cliente, id_empleado, total, metodo_pago) VALUES 
(1, 1, 1, 30000, 'Efectivo'), (2, 2, 4, 12000, 'Tarjeta'), (3, 3, 6, 45000, 'Nequi'), 
(4, 4, 1, 25000, 'Efectivo'), (5, 5, 10, 18000, 'Tarjeta'), (6, 6, 4, 15000, 'Efectivo'), 
(7, 7, 6, 50000, 'Tarjeta'), (8, 8, 1, 10000, 'Efectivo'), (9, 9, 10, 60000, 'Transferencia'), 
(10, 10, 4, 25000, 'Efectivo'), (11, 11, 6, 8000, 'Efectivo'), (12, 12, 1, 15000, 'Tarjeta'), 
(13, 13, 10, 15000, 'Efectivo'), (14, 14, 4, 18000, 'Tarjeta'), (15, 15, 6, 12000, 'Efectivo');

-- 10. BOLETOS (Conectados a la Venta y Función)
INSERT INTO boletos (id_boleto, id_venta, id_funcion, id_silla, precio_final) VALUES 
(1, 1, 1, 1, 15000), (2, 1, 1, 2, 15000), (3, 2, 2, 3, 12000), (4, 3, 3, 4, 18000), 
(5, 4, 4, 11, 25000), (6, 5, 11, 5, 8000), (7, 6, 12, 1, 15000), (8, 7, 7, 1, 20000), 
(9, 8, 8, 2, 10000), (10, 9, 10, 12, 25000), (11, 10, 4, 13, 25000), (12, 11, 11, 6, 8000), 
(13, 12, 1, 3, 15000), (14, 13, 13, 4, 15000), (15, 14, 14, 14, 18000);

select * from venta;

