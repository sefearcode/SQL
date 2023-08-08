/* Sprint Final
* Sebastián Araya. 
*/

-- Creación Base de datos
CREATE DATABASE telovendosprint;

-- Creación usuario
CREATE USER 'telovendosprint'@'localhost' IDENTIFIED BY 'telovendosprint';

-- Creación privilegios de usuario
GRANT ALL PRIVILEGES ON telovendosprint.* TO 'telovendosprint'@'localhost';
FLUSH PRIVILEGES;
-- Seleccionar BD
USE telovendosprint;

-- Creación tabla stock
CREATE TABLE stock (
	id_stock integer primary key auto_increment,
	id_producto integer,
    cantidad integer
    );

-- Creación tabla categoria
CREATE TABLE categoria (
	id_categoria integer primary key auto_increment,
    nombre_categoria varchar(50),
	descripcion_categoria varchar(50)
    );

-- Creación tabla clientes
CREATE TABLE clientes (
	id_clientes integer primary key auto_increment,
    nombre varchar(50),
    apellido varchar(50),
    direccion varchar(50)
    );
    
-- Creación tabla proveedores
CREATE TABLE proveedores (
	id_proveedor integer primary key auto_increment,
    nombre_representante_legal varchar(50),
    nombre_corporativo varchar(50),    
    telefono_1 varchar(50),
    telefono_2 varchar(50),
    nombre_recepcion varchar(50),
    correo_electronico varchar(50)
    );

-- Creación tabla productos
CREATE TABLE productos (
	id_productos integer primary key auto_increment,
    nombre_producto varchar(50),
    precio integer,
    id_categoria integer,
    id_proveedor integer,
    color varchar(50),
    id_stock integer,
    foreign key (id_categoria) references categoria (id_categoria),
	foreign key (id_proveedor) references proveedores (id_proveedor),
    foreign key (id_stock) references stock (id_stock)
    );

-- Creación tabla compras
CREATE TABLE compras (
	id_compra integer primary key auto_increment,
	id_producto integer,
    id_clientes integer,
    fecha_hora_de_compra timestamp default current_timestamp,
    cantidad_compra integer,
    foreign key (id_producto) references productos (id_productos),
    foreign key (id_clientes) references clientes (id_clientes)
    );
    
ALTER TABLE compras MODIFY cantidad_compra int;

-- Creación tabla devoluciones
CREATE TABLE devoluciones (
	id_devolucion integer primary key auto_increment,
	id_compra integer,
    fecha_hora_de_devolucion timestamp default current_timestamp,
    foreign key (id_compra) references compras (id_compra)
    );

-- Insertar Datos tabla Stock
INSERT INTO stock (id_producto, cantidad)
VALUES
(1, 40),
(2, 20),
(3, 50),
(4, 60),
(5, 150),
(6, 23),
(7, 65),
(8, 450),
(9, 350),
(10, 50);

-- Insertar Datos tabla Categoría
INSERT INTO categoria (nombre_categoria, descripcion_categoria)
VALUES
('Alimentos perecederos', 'comida'),
('Productos de limpieza', 'comida'),
('Frutas y verduras', 'comida'),
('Carnes y embutidos', 'comida'),
('Pan y productos de panadería', 'comida');

 /*TeLoVendo tiene actualmente muchos clientes, pero nos piden que ingresemos solo 5 para probar la
nueva base de datos.*/   

INSERT INTO clientes (id_clientes, nombre, apellido, direccion)
VALUES
(1, 'Juan', 'Gómez', 'Calle Principal 123'),
(2, 'María', 'López', 'Avenida Central 456'),
(3, 'Carlos', 'Fernández', 'Plaza Mayor 789'),
(4, 'Laura', 'Martínez', 'Calle Secundaria 321'),
(5, 'Pedro', 'Ramírez', 'Avenida Principal 987');

-- Agregue 5 proveedores a la base de datos

INSERT INTO proveedores (nombre_representante_legal, nombre_corporativo, telefono_1, telefono_2, nombre_recepcion,  correo_electronico)
VALUES 
('Juan Martínez', 'Alimentos Directos S.A.', '+1 (555) 1234567', '+1 (555) 9876543', 'María Rodríguez', 'juan.martinez@alimentosdirectos.com'),
('Ana Gómez', 'Distribuciones Alimentarias S.A.', '+1 (555) 8765432', '+1 (555) 2345678', 'Pedro López',  'ana.gomez@distribucionesalimentarias.com'),
('Carlos Fernández', 'Frutas Frescas Ltda.', '+1 (555) 3456789', '+1 (555) 9876543', 'Laura Martínez',  'carlos.fernandez@frutasfrescas.com'),
('María López', 'Carnicería La Finca', '+1 (555) 6543210', '+1 (555) 2345678', 'Juan González', 'maria.lopez@carnicerialafinca.com'),
('Pedro Ramírez', 'Panadería El Trigo', '+1 (555) 9876543', '+1 (555) 8765432', 'Ana Sánchez',  'pedro.ramirez@panaderiaeltrigo.com');
  
  /*Ingrese 10 productos y su respectivo stock. Cada producto tiene información sobre su precio, su categoría, proveedor y color. 
  Los productos pueden tener muchos proveedores.*/

INSERT INTO productos (nombre_producto, precio, id_categoria, id_proveedor, color, id_stock)
VALUES 
('Arroz', '2500', 1, 5, 'Blanco', 1),
('Dulces', 50099, 3, 3, 'Blanco', 2),
('Porotos', 2999, 4, 2, 'Grises', 3),
('Manzanas', 150099, 5, 1, 'Rojo', 4),
('Carne de Vacuno', 8990, 5, 1, 'Rojo', 5),
('Pan', 3990, 1, 2, 'Cafe', 6),
('Leches', 67990, 2, 2, 'Blanco', 7),
('Cereales', 6990, 3, 1, 'Cafe', 8),
('Limones', 9990, 4, 1, 'Amarillo', 9),
('Tortas', 4990, 5, 2, 'Plateado', 10);

-- Datos tabla compras
INSERT INTO compras (id_producto, id_clientes ,fecha_hora_de_compra, cantidad_compra)
VALUES 
(1, 1, '2023-04-03', 1);

SELECT * FROM categoria;
SELECT * FROM stock;
SELECT * FROM clientes;
SELECT * FROM proveedores;
SELECT * FROM productos;
SELECT * FROM compras;

/* Luego debemos realizar consultas SQL que indiquen:

Cuál es la categoría de productos que más se repite.*/
SELECT id_categoria, COUNT(id_categoria) AS num_repetidos
FROM productos
GROUP BY id_categoria
ORDER BY num_repetidos DESC
LIMIT 1;
-- id_categoria: 5 ; num_repetidos: 3


-- Cuáles son los productos con mayor stock
SELECT id_producto, SUM(cantidad) AS total_stock
FROM stock
GROUP BY id_producto
ORDER BY total_stock DESC;
/*
id_producto, total_stock
'8', '450'
'9', '350'
'5', '150'
*/

-- Qué color de producto es más común en nuestra tienda.
SELECT color, COUNT(*) AS num_productos
FROM productos
GROUP BY color
ORDER BY num_productos DESC
LIMIT 1;
-- # color, num_productos 'Blanco', '3'

-- Cual o cuales son los proveedores con menor stock de productos.
SELECT p.nombre_representante_legal AS proveedores, MIN(s.cantidad) AS total_stock
FROM proveedores p
JOIN productos pr ON p.id_proveedor = pr.id_proveedor
JOIN stock s ON pr.id_stock = s.id_stock
GROUP BY p.id_proveedor
ORDER BY total_stock ASC;
/*
# proveedores, total_stock
'Carlos Fernández', '20'
'Ana Gómez', '23'
'Pedro Ramírez', '40'
*/

/*Por último:
Cambien la categoría de productos más popular por ‘Electrónica y computación’.
*/    
UPDATE categoria
SET nombre_categoria = 'Electrónica y computación'
WHERE id_categoria = (
    SELECT id_categoria
    FROM (
        SELECT id_categoria, COUNT(*) AS num_productos
        FROM productos
        GROUP BY id_categoria
        ORDER BY num_productos DESC
        LIMIT 1
    ) AS temp
);






