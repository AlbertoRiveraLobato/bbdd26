
/*
-- =====================================================================
-- =====================================================================
-- =====================================================================
CREACIÓN Y GESTIÓN DE LA BASE DE DATOS:

# >> TIENDA ONLINE 01
-- =====================================================================
-- =====================================================================
-- =====================================================================
*/

-- 1. Crear y seleccionar la base de datos
CREATE DATABASE IF NOT EXISTS gestion_pedidos;
USE gestion_pedidos;

-- =====================================================================
-- 1. MODELO ENTIDAD-RELACIÓN EXTENDIDO (MERE)
-- =====================================================================
/*
REALIZAR.

- CLIENTES ([PK]IdCliente, Cliente, DireccionEntrega) -> cardinalidad lateral: (1, 1).
- PEDIDOS ([PK]IdPedido, IdCliente (FK), PrecioTotal) -> cardinalidad lateral: (1, N).

INCLUIR.

- PEDIDOS ([PK]IdPedido, IdCliente (FK), PrecioTotal) -> cardinalidad lateral: (1, N).
- PRODUCTOS ([PK]ProductoID, Producto) -> cardinalidad lateral: (1, M).
  */

-- =====================================================================
-- 2. MODELO RELACIONAL (MR)
-- =====================================================================
/*

- CLIENTES ([PK]IdCliente, Cliente, DireccionEntrega)
- PRODUCTOS ([PK]ProductoID, Producto)
- PEDIDOS ([PK]IdPedido, FK_CLIENTES.IdCliente, PrecioTotal)
- DETALLES_PEDIDOS ([PK]FK_PEDIDOS.IdPedido, [PK]FK_PRODUCTOS.ProductoID)
  */

-- =====================================================================
-- 3. CÓDIGO SQL - CREACIÓN E INSERCIÓN
-- =====================================================================

---

-- TABLA: CLIENTES (Tabla Padre / Independiente)
-- Almacena la información principal de los clientes de la tienda.

---

CREATE TABLE CLIENTES (
    IdCliente INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único autoincremental (PK)
    Cliente VARCHAR(100) NOT NULL,             -- Nombre completo del cliente (Obligatorio)
    DireccionEntrega VARCHAR(255) NOT NULL     -- Dirección física de entrega (Obligatorio)
);

---

-- TABLA: PEDIDOS (Tabla Hija / Relación 1:N con Clientes)
-- Un cliente puede realizar muchos pedidos, pero cada pedido pertenece a un único cliente.

---

CREATE TABLE PEDIDOS (
    IdPedido INT AUTO_INCREMENT PRIMARY KEY,   -- Identificador único del pedido (PK)
    IdCliente INT NOT NULL,                    -- Clave ajena que referencia al cliente que realiza el pedido
    PrecioTotal DECIMAL(10, 2) NOT NULL,       -- Coste total del pedido

    -- Restricción de Clave Ajena (FK) con políticas de integridad referencial
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (IdCliente)
        REFERENCES CLIENTES(IdCliente)
        ON DELETE RESTRICT ON UPDATE CASCADE   -- RESTRICT: No permite borrar un cliente si tiene pedidos activos.
                                               -- CASCADE: Si cambia el ID del cliente, se actualiza automáticamente aquí.
);

---

-- TABLA: PRODUCTOS (Catálogo Independiente)
-- Guarda los productos disponibles en el sistema.

---

CREATE TABLE PRODUCTOS (
    ProductoID INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único del producto (PK)
    Producto VARCHAR(100) NOT NULL             -- Nombre o descripción del producto (Obligatorio)
);

---

-- TABLA: DETALLES_PEDIDOS (Tabla Intermedia / Relación N:M)
-- Resuelve la relación de muchos a muchos entre Pedidos y Productos.

---

CREATE TABLE DETALLES_PEDIDOS (
    IdPedido INT,                              -- Parte de la clave primaria compuesta y FK hacia Pedidos
    ProductoID INT,                            -- Parte de la clave primaria compuesta y FK hacia Productos

    -- Clave Primaria Compuesta para evitar duplicar el mismo producto en un mismo pedido
    PRIMARY KEY (IdPedido, ProductoID),

    -- Relación con PEDIDOS (Si se borra el pedido, sus detalles se eliminan en cascada: CASCADE)
    CONSTRAINT fk_detalle_pedido FOREIGN KEY (IdPedido)
        REFERENCES PEDIDOS(IdPedido)
        ON DELETE CASCADE ON UPDATE CASCADE,

    -- Relación con PRODUCTOS (No permite eliminar un producto si forma parte de algún detalle: RESTRICT)
    CONSTRAINT fk_detalle_producto FOREIGN KEY (ProductoID)
        REFERENCES PRODUCTOS(ProductoID)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- =====================================================================
-- INSERCIÓN DE DATOS DE PRUEBA (DML)
-- =====================================================================

-- Insertar registros en la tabla padre (CLIENTES)
INSERT INTO CLIENTES (Cliente, DireccionEntrega) VALUES
('Ana Pérez', 'Calle Mayor 1, Madrid'),
('Carlos López', 'Avenida de la Paz 4, Barcelona');

-- Insertar registros en el catálogo (PRODUCTOS)
INSERT INTO PRODUCTOS (Producto) VALUES
('Ratón USB'),
('Teclado Mecánico'),
('Alfombrilla');

-- Insertar registros en PEDIDOS asociándolos a sus respectivos clientes (IdCliente)
INSERT INTO PEDIDOS (IdPedido, IdCliente, PrecioTotal) VALUES
(101, 1, 35.00), -- Pedido realizado por Ana Pérez (IdCliente = 1)
(102, 2, 15.00); -- Pedido realizado por Carlos López (IdCliente = 2)

-- Insertar los detalles de los productos incluidos en cada pedido (Tabla intermedia N:M)
INSERT INTO DETALLES_PEDIDOS (IdPedido, ProductoID) VALUES
(101, 1), -- El pedido 101 incluye el producto 1 (Ratón USB)
(101, 3), -- El pedido 101 incluye el producto 3 (Alfombrilla)
(102, 1); -- El pedido 102 incluye el producto 1 (Ratón USB)

-- =====================================================================
-- 4. CÓDIGO SQL - CONSULTAS SIMPLES
-- =====================================================================

-- 1. Mostrar todos los clientes registrados
SELECT * FROM CLIENTES;

-- 2. Mostrar la descripción de todos los productos
SELECT * FROM PRODUCTOS;

-- 3. Consultar los pedidos cuyo precio total sea mayor a 20 €, renombrando la columna para mayor claridad visual
SELECT IdPedido, PrecioTotal AS "Precio > 20€"
FROM PEDIDOS
WHERE PrecioTotal > 20.00;












/*
-- =====================================================================
-- =====================================================================
-- =====================================================================
CREACIÓN Y GESTIÓN DE LA BASE DE DATOS:

# >> TIENDA ONLINE 02
-- =====================================================================
-- =====================================================================
-- =====================================================================
*/

-- 1. Crear y seleccionar la base de datos
CREATE DATABASE IF NOT EXISTS tienda_online_02;
USE tienda_online_02;

-- =====================================================================
-- 1. MODELO ENTIDAD-RELACIÓN EXTENDIDO (MERE)
-- =====================================================================
/*
REALIZAR.
    * CLIENTES ([PK]IdCliente, Cliente, Email) -> cardinalidad lateral: (1, 1).
    * PEDIDOS ([PK]IdPedido, FK_IdCliente, PrecioTotal) -> cardinalidad lateral: (1, N).

PERTENECER.
    * CATEGORÍAS ([PK]IdCategoria, Categoria) -> cardinalidad lateral: (1, N).
    * PRODUCTOS ([PK]IdProducto, Producto, Precio, FK_IdCategoria) -> cardinalidad lateral: (1, 1).

INCLUIR.
    * PEDIDOS ([PK]IdPedido, FK_IdCliente, PrecioTotal) -> cardinalidad lateral: (1, N).
    * PRODUCTOS ([PK]IdProducto, Producto, Precio, FK_IdCategoria) -> cardinalidad lateral: (1, M).
*/

-- =====================================================================
-- 2. MODELO RELACIONAL (MR)
-- =====================================================================
/*

- CLIENTES ([PK]IdCliente, Cliente, Email)
- CATEGORIAS ([PK]IdCategoria, Categoria)
- PEDIDOS ([PK]IdPedido, FK_CLIENTES.IdCliente, PrecioTotal)
- PRODUCTOS ([PK]IdProducto, Producto, Precio, FK_CATEGORIAS.IdCategoria)
- DETALLES_PEDIDOS ([PK]FK_PEDIDOS.IdPedido, [PK]FK_PRODUCTOS.IdProducto)
  */

-- =====================================================================
-- 3. CÓDIGO SQL - CREACIÓN E INSERCIÓN
-- =====================================================================

-- Tabla 1: CLIENTES (Tabla independiente / Padre)
CREATE TABLE CLIENTES (
    IdCliente INT AUTO_INCREMENT PRIMARY KEY,
    Cliente VARCHAR(100) NOT NULL,
    Email VARCHAR(150) NOT NULL UNIQUE
);

-- Tabla 2: CATEGORIAS (Tabla independiente / Padre)
CREATE TABLE CATEGORIAS (
    IdCategoria INT AUTO_INCREMENT PRIMARY KEY,
    Categoria VARCHAR(100) NOT NULL
);

-- Tabla 3: PEDIDOS (Relación 1:N con CLIENTES)
CREATE TABLE PEDIDOS (
    IdPedido INT AUTO_INCREMENT PRIMARY KEY,
    FK_IdCliente INT NOT NULL,
    PrecioTotal DECIMAL(10, 2) NOT NULL,
    -- PARTICIPACIÓN: Todo pedido debe pertenecer obligatoriamente a un cliente.
    -- ON DELETE RESTRICT: Impide borrar a un cliente si tiene pedidos registrados.
    CONSTRAINT fk_pedidos_clientes FOREIGN KEY (FK_IdCliente)
        REFERENCES CLIENTES(IdCliente)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabla 4: PRODUCTOS (Relación 1:N con CATEGORIAS)
CREATE TABLE PRODUCTOS (
    IdProducto INT AUTO_INCREMENT PRIMARY KEY,
    Producto VARCHAR(100) NOT NULL,
    Precio DECIMAL(10, 2) NOT NULL,
    FK_IdCategoria INT NOT NULL,
    -- PARTICIPACIÓN: Todo producto pertenece obligatoriamente a una categoría.
    -- ON DELETE RESTRICT: No permite eliminar una categoría con productos asignados.
    CONSTRAINT fk_productos_categorias FOREIGN KEY (FK_IdCategoria)
        REFERENCES CATEGORIAS(IdCategoria)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT chk_precio_positivo CHECK (Precio > 0)
);

-- Tabla 5: DETALLES_PEDIDOS (Relación M:N entre PEDIDOS y PRODUCTOS)
CREATE TABLE DETALLES_PEDIDOS (
    FK_IdPedido INT,
    FK_IdProducto INT,
    PRIMARY KEY (FK_IdPedido, FK_IdProducto),
    -- PARTICIPACIÓN: Si se elimina un pedido, sus detalles asociados se eliminan en cascada.
    CONSTRAINT fk_detalles_pedidos FOREIGN KEY (FK_IdPedido)
        REFERENCES PEDIDOS(IdPedido)
        ON DELETE CASCADE ON UPDATE CASCADE,
    -- PARTICIPACIÓN: No permite eliminar un producto si forma parte de algún detalle de pedido.
    CONSTRAINT fk_detalles_productos FOREIGN KEY (FK_IdProducto)
        REFERENCES PRODUCTOS(IdProducto)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- ==========================================
-- INSERCIÓN DE DATOS DE PRUEBA (DML)
-- ==========================================

-- Insertar Clientes (3 registros)
INSERT INTO CLIENTES (Cliente, Email) VALUES
('Ana García', 'ana.garcia@email.com'),
('Carlos López', 'carlos.lopez@email.com'),
('Lucía Fernández', 'lucia.f@email.com');

-- Insertar Categorías (3 registros)
INSERT INTO CATEGORIAS (Categoria) VALUES
('Periféricos'),
('Componentes'),
('Accesorios');

-- Insertar Pedidos (3 registros)
INSERT INTO PEDIDOS (FK_IdCliente, PrecioTotal) VALUES
(1, 45.00), -- Pedido realizado por Ana García
(2, 120.00), -- Pedido realizado por Carlos López
(1, 15.00); -- Segundo pedido realizado por Ana García

-- Insertar Productos (3 registros)
INSERT INTO PRODUCTOS (Producto, Precio, FK_IdCategoria) VALUES
('Ratón Óptico USB', 15.00, 1),      -- Categ. Periféricos
('Teclado Mecánico', 30.00, 1),     -- Categ. Periféricos
('Memoria RAM 16GB', 75.00, 2);      -- Categ. Componentes

-- Insertar Detalles de Pedidos (Tabla Intermedia N:M)
INSERT INTO DETALLES_PEDIDOS (FK_IdPedido, FK_IdProducto) VALUES
(1, 1), -- El pedido 1 incluye el Ratón Óptico USB
(1, 2), -- El pedido 1 incluye el Teclado Mecánico
(2, 3); -- El pedido 2 incluye la Memoria RAM 16GB

-- =====================================================================
-- 4. CÓDIGO SQL - CONSULTAS SIMPLES
-- =====================================================================

-- 1. Mostrar todos los clientes registrados
SELECT * FROM CLIENTES;

-- 2. Mostrar la descripción de todas las categorías disponibles
SELECT * FROM CATEGORIAS;

-- 3. Consultar los productos cuyo precio sea superior a 20 €, renombrando la columna para mayor claridad
SELECT Producto, Precio AS "Precio > 20€"
FROM PRODUCTOS
WHERE Precio > 20.00;












/*
-- =====================================================================
-- =====================================================================
-- =====================================================================
CREACIÓN Y GESTIÓN DE LA BASE DE DATOS:

# >> BIBLIOTECA 01
-- =====================================================================
-- =====================================================================
-- =====================================================================
*/

-- 1. Crear y seleccionar la base de datos
CREATE DATABASE IF NOT EXISTS gestion_biblioteca;
USE gestion_biblioteca;

-- =====================================================================
-- 1. MODELO RELACIONAL (MR)
-- =====================================================================
/*
- LECTORES ([PK] LectorID, NombreLector)
- LIBROS ([PK] LibroID, Libro)
- AUTORES ([PK] AutorID, Autor)
- PRESTAMOS ([PK] PrestamoID, FK_LectorID, FK_LibroID, FechaPrestamo, FechaDevolución)
- LIBROS_AUTORES ([PK] FK_LibroID, [PK] FK_AutorID)
*/

-- =====================================================================
-- 2. CÓDIGO SQL - CREACIÓN DE TABLAS (DDL)
-- =====================================================================

-- ---------------------------------------------------------------------
-- TABLA: LECTORES (Tabla Padre / Independiente)
-- Almacena la información de los lectores registrados en la biblioteca.
-- ---------------------------------------------------------------------
CREATE TABLE LECTORES (
    LectorID INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único del lector (PK)
    NombreLector VARCHAR(100) NOT NULL       -- Nombre completo del lector (Obligatorio)
);

-- ---------------------------------------------------------------------
-- TABLA: LIBROS (Tabla Padre / Independiente)
-- Almacena el catálogo de libros disponibles.
-- ---------------------------------------------------------------------
CREATE TABLE LIBROS (
    LibroID INT AUTO_INCREMENT PRIMARY KEY,  -- Identificador único del libro (PK)
    Libro VARCHAR(150) NOT NULL              -- Título o descripción del libro (Obligatorio)
);

-- ---------------------------------------------------------------------
-- TABLA: AUTORES (Tabla Padre / Independiente)
-- Almacena la información de los autores de los libros.
-- ---------------------------------------------------------------------
CREATE TABLE AUTORES (
    AutorID INT AUTO_INCREMENT PRIMARY KEY,  -- Identificador único del autor (PK)
    Autor VARCHAR(100) NOT NULL              -- Nombre del autor (Obligatorio)
);

-- ---------------------------------------------------------------------
-- TABLA: PRESTAMOS (Relación M:N entre Lectores y Libros con atributos)
-- Registra los préstamos realizados por los lectores.
-- ---------------------------------------------------------------------
CREATE TABLE PRESTAMOS (
    PrestamoID INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único del préstamo (PK)
    LectorID INT NOT NULL,                     -- Clave ajena hacia LECTORES
    LibroID INT NOT NULL,                      -- Clave ajena hacia LIBROS
    FechaPrestamo DATE NOT NULL,               -- Fecha en la que se realiza el préstamo
    FechaDevolucion DATE NULL,                 -- Fecha de devolución del libro (puede ser nula si está activo)
    
    -- Restricciones de Clave Ajena (FK)
    CONSTRAINT fk_prestamo_lector FOREIGN KEY (LectorID) 
        REFERENCES LECTORES(LectorID)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_prestamo_libro FOREIGN KEY (LibroID) 
        REFERENCES LIBROS(LibroID)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- ---------------------------------------------------------------------
-- TABLA: LIBROS_AUTORES (Tabla Intermedia / Relación M:N)
-- Resuelve la relación de muchos a muchos entre Libros y Autores.
-- ---------------------------------------------------------------------
CREATE TABLE LIBROS_AUTORES (
    LibroID INT,
    AutorID INT,
    
    -- Clave Primaria Compuesta
    PRIMARY KEY (LibroID, AutorID),
    
    -- Restricciones de Clave Ajena con borrado en cascada
    CONSTRAINT fk_rel_libro FOREIGN KEY (LibroID) 
        REFERENCES LIBROS(LibroID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_rel_autor FOREIGN KEY (AutorID) 
        REFERENCES AUTORES(AutorID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- =====================================================================
-- 3. INSERCIÓN DE DATOS DE PRUEBA (DML)
-- =====================================================================

-- Insertar lectores
INSERT INTO LECTORES (NombreLector) VALUES 
('Sofía Martínez'),
('Alejandro Gómez'),
('Lucía Fernández');

-- Insertar libros
INSERT INTO LIBROS (Libro) VALUES 
('Cien años de soledad'),
('El Quijote'),
('La sombra del viento');

-- Insertar autores
INSERT INTO AUTORES (Autor) VALUES 
('Gabriel García Márquez'),
('Miguel de Cervantes'),
('Carlos Ruiz Zafón');

-- Relacionar libros y autores (Tabla LIBROS_AUTORES)
INSERT INTO LIBROS_AUTORES (LibroID, AutorID) VALUES 
(1, 1), -- Cien años de soledad -> Gabriel García Márquez
(2, 2), -- El Quijote -> Miguel de Cervantes
(3, 3); -- La sombra del viento -> Carlos Ruiz Zafón

-- Insertar préstamos
INSERT INTO PRESTAMOS (LectorID, LibroID, FechaPrestamo, FechaDevolucion) VALUES 
(1, 1, '2026-10-01', '2026-10-15'),
(2, 2, '2026-10-05', NULL),
(3, 3, '2026-10-10', '2026-10-20');

-- =====================================================================
-- 4. CONSULTAS SENCILLAS (DQL)
-- =====================================================================

-- 1. Mostrar todos los lectores registrados
SELECT * FROM LECTORES;

-- 2. Mostrar la descripción de todos los libros
SELECT * FROM LIBROS;

-- 3. Mostrar todos los autores registrados
SELECT * FROM AUTORES;

-- 4. Consultar los préstamos realizados por un lector específico (por ejemplo, LectorID = 1)
SELECT PrestamoID AS "Préstamos con ID=1", LectorID, LibroID, FechaPrestamo, FechaDevolucion
FROM PRESTAMOS
WHERE LectorID = 1;

-- 5. Consultar los préstamos activos (cuya fecha de devolución sea nula), renombrando la columna para mayor claridad
SELECT PrestamoID, LectorID, LibroID, FechaPrestamo AS "Préstamos Activos (Sin Devolver)"
FROM PRESTAMOS 
WHERE FechaDevolucion IS NULL;