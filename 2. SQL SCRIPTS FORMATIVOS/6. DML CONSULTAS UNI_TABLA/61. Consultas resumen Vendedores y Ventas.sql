-- Ejercicio: Consultas resumen Vendedores y Ventas.

-- Creación de la base de datos de vendedores y ventas
CREATE DATABASE ventas_db;
USE ventas_db;

-- Tabla de vendedores
CREATE TABLE vendedores (
    id_vendedor INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    telefono VARCHAR(15),
    fecha_contratacion DATE,
    salario_base DECIMAL(10,2),
    comision DECIMAL(5,2) DEFAULT 0.10
);

-- Tabla de ventas
CREATE TABLE ventas (
    id_venta INT PRIMARY KEY AUTO_INCREMENT,
    id_vendedor INT,
    fecha_venta DATE,
    producto VARCHAR(100),
    cantidad INT,
    precio_unitario DECIMAL(10,2),
    region VARCHAR(50)
);

-- Inserción de datos de ejemplo
INSERT INTO vendedores (nombre, apellido, email, telefono, fecha_contratacion, salario_base, comision) VALUES
('María', 'García', 'maria.garcia@empresa.com', '611223344', '2022-01-15', 25000.00, 0.15),
('Juan', 'López', 'juan.lopez@empresa.com', '622334455', '2021-03-10', 28000.00, 0.12),
('Ana', 'Martínez', 'ana.martinez@empresa.com', '633445566', '2023-02-20', 23000.00, 0.18),
('Carlos', 'Rodríguez', 'carlos.rodriguez@empresa.com', '644556677', '2020-11-05', 30000.00, 0.10),
('Laura', 'Sánchez', 'laura.sanchez@empresa.com', '655667788', '2022-08-12', 26000.00, 0.14);

INSERT INTO ventas (id_vendedor, fecha_venta, producto, cantidad, precio_unitario, region) VALUES
(1, '2024-01-15', 'Portátil Gaming', 2, 1200.00, 'Norte'),
(1, '2024-01-20', 'Monitor 24"', 3, 250.00, 'Norte'),
(2, '2024-01-10', 'Teclado Mecánico', 5, 80.00, 'Sur'),
(2, '2024-01-25', 'Ratón Inalámbrico', 10, 45.00, 'Sur'),
(3, '2024-01-05', 'Tablet', 4, 350.00, 'Este'),
(3, '2024-01-18', 'Smartphone', 6, 600.00, 'Este'),
(4, '2024-01-12', 'Impresora', 2, 450.00, 'Oeste'),
(4, '2024-01-22', 'Altavoces', 8, 120.00, 'Oeste'),
(5, '2024-01-08', 'Cámara Web', 15, 60.00, 'Centro'),
(5, '2024-01-28', 'Disco Duro Externo', 7, 180.00, 'Centro'),
(1, '2024-02-01', 'Tablet', 3, 350.00, 'Norte'),
(2, '2024-02-05', 'Monitor 24"', 4, 250.00, 'Sur');

/* BATERÍA 1: CONSULTAS SIN JOINS

1. SELECT básico - Mostrar todos los datos de los vendedores
2. SELECT con columnas específicas - Mostrar nombre, apellido y salario base de los vendedores
3. WHERE con operadores de comparación - Mostrar vendedores con salario superior a 25,000€
4. WHERE con operadores lógicos (AND, OR) - Mostrar vendedores con salario mayor a 24,000€ y comisión mayor al 12%
5. WHERE con BETWEEN (rango) - Mostrar vendedores con salario entre 23,000€ y 27,000€
6. WHERE con IN (conjunto) - Mostrar vendedores llamados María, Juan o Ana
7. WHERE con LIKE (patrones) - % cualquier cadena - Mostrar vendedores cuyo nombre empiece con 'M'
8. WHERE con LIKE (patrones) - _ un solo carácter - Mostrar vendedores cuyo segundo carácter sea 'a'
9. WHERE con IS NULL - Mostrar vendedores que no tienen email registrado
10. OPERADORES ARITMÉTICOS - Campos calculados - Calcular salario anual y comisión estimada de cada vendedor
11. GROUP BY con COUNT - Contar número de ventas por región
12. GROUP BY con múltiples columnas - Contar ventas por región y producto
13. HAVING con condición sobre agregación - Mostrar regiones con más de 2 ventas
14. HAVING con operadores aritméticos - Mostrar regiones con ventas totales superiores a 1,500€
15. Sub-consulta en WHERE - Mostrar vendedores que tienen ventas superiores a 1,000€
16. Sub-consulta en FROM - Mostrar regiones con más de 1 venta (usando subconsulta en FROM)
17. Sub-consulta en SELECT - Mostrar vendedores con el número total de ventas que tienen
18. Sub-consulta correlacionada - Mostrar ventas cuyo valor es superior al promedio de su región
19. Consulta compleja con múltiples operadores - Reporte de productos vendidos en enero 2024 en Norte o Sur con valor total superior a 500€
20. Consulta con NOT y operadores lógicos - Mostrar vendedores con salario no inferior a 25,000€ o comisión no inferior al 12%, contratados después de 2022

*/

-- 1. SELECT básico
-- Mostrar todos los datos de los vendedores
SELECT * FROM vendedores;

-- 2. SELECT con columnas específicas
-- Mostrar nombre, apellido y salario base de los vendedores
SELECT nombre, apellido, salario_base FROM vendedores;

-- 3. WHERE con operadores de comparación
-- Mostrar vendedores con salario superior a 25,000€
SELECT * FROM vendedores WHERE salario_base > 25000;

-- 4. WHERE con operadores lógicos (AND, OR)
-- Mostrar vendedores con salario mayor a 24,000€ y comisión mayor al 12%
SELECT * FROM vendedores 
WHERE salario_base > 24000 AND comision > 0.12;

-- 5. WHERE con BETWEEN (rango)
-- Mostrar vendedores con salario entre 23,000€ y 27,000€
SELECT * FROM vendedores 
WHERE salario_base BETWEEN 23000 AND 27000;

-- 6. WHERE con IN (conjunto)
-- Mostrar vendedores llamados María, Juan o Ana
SELECT * FROM vendedores 
WHERE nombre IN ('María', 'Juan', 'Ana');

-- 7. WHERE con LIKE (patrones) - % cualquier cadena
-- Mostrar vendedores cuyo nombre empiece con 'M'
SELECT * FROM vendedores 
WHERE nombre LIKE 'M%';

-- 8. WHERE con LIKE (patrones) - _ un solo carácter
-- Mostrar vendedores cuyo segundo carácter sea 'a'
SELECT * FROM vendedores 
WHERE nombre LIKE '_a%';

-- 9. WHERE con IS NULL
-- Mostrar vendedores que no tienen email registrado
SELECT * FROM vendedores 
WHERE email IS NULL;

-- 10. OPERADORES ARITMÉTICOS - Campos calculados
-- Calcular salario anual y comisión estimada de cada vendedor
SELECT nombre, apellido, 
       salario_base * 12 AS salario_anual,
       salario_base * comision * 1000 AS comision_estimada
FROM vendedores;

-- 11. GROUP BY con COUNT
-- Contar número de ventas por región
SELECT region, COUNT(*) as total_ventas
FROM ventas 
GROUP BY region;
-- probar sin count y sin group by;
-- probar sin count y con group by;


-- 12. GROUP BY con múltiples columnas
-- Contar ventas por región y producto
SELECT region, producto, COUNT(*) as cantidad_ventas
FROM ventas 
GROUP BY region, producto;

-- 13.1 HAVING con condición sobre agregación
-- Mostrar regiones con más de 2 ventas
SELECT region, COUNT(*) as total_ventas
FROM ventas 
GROUP BY region
HAVING COUNT(*) > 2;

-- 13.2 HAVING con condición sobre agregación
-- Mostrar regiones que sean 'Norte' o 'Centro' y su número de ventas
SELECT region, COUNT(*) as total_ventas
FROM ventas 
GROUP BY region
HAVING region IN ('Norte', 'Centro');

-- 14. HAVING con operadores aritméticos
-- Mostrar regiones con ventas totales superiores a 1,500€
SELECT region, SUM(cantidad * precio_unitario) as total_ventas
FROM ventas 
GROUP BY region
HAVING SUM(cantidad * precio_unitario) > 1500;

-- 15. Sub-consulta en WHERE
-- Mostrar vendedores que tienen ventas superiores a 1,000€
SELECT * FROM vendedores 
WHERE id_vendedor IN (
    SELECT id_vendedor 
    FROM ventas 
    WHERE cantidad * precio_unitario > 1000
);

-- 16. Sub-consulta en FROM
-- Mostrar regiones con más de 1 venta (usando subconsulta en FROM)
SELECT v.region, v.total_ventas
FROM (
    SELECT region, COUNT(*) as total_ventas
    FROM ventas 
    GROUP BY region
) AS v
WHERE v.total_ventas > 1;

-- 17. Sub-consulta en SELECT
-- Mostrar vendedores con el número total de ventas que tienen
SELECT nombre, apellido,
       (SELECT COUNT(*) FROM ventas WHERE ventas.id_vendedor = vendedores.id_vendedor) as total_ventas
FROM vendedores;

-- 18. Sub-consulta correlacionada
-- Mostrar ventas cuyo valor es superior al promedio de su región
SELECT * FROM ventas v1
WHERE cantidad * precio_unitario > (
    SELECT AVG(cantidad * precio_unitario)
    FROM ventas v2
    WHERE v2.region = v1.region
);

-- 19. Consulta compleja con múltiples operadores
-- Reporte de productos vendidos en enero 2024 en Norte o Sur con valor total superior a 500€
SELECT producto,
       SUM(cantidad) as total_unidades,
       SUM(cantidad * precio_unitario) as valor_total,
       AVG(precio_unitario) as precio_promedio
FROM ventas
WHERE fecha_venta BETWEEN '2024-01-01' AND '2024-01-31'
AND region IN ('Norte', 'Sur')
GROUP BY producto
HAVING SUM(cantidad * precio_unitario) > 500
ORDER BY valor_total DESC;

-- 20. Consulta con NOT y operadores lógicos
-- Mostrar vendedores con salario no inferior a 25,000€ o comisión no inferior al 12%, contratados después de 2022
SELECT * FROM vendedores 
WHERE NOT (salario_base < 25000 OR comision < 0.12)
AND fecha_contratacion > '2022-01-01';

/* BATERÍA 2: CONSULTAS AVANZADAS - SUBCONSULTAS Y FUNCIONES

21. EXISTS - Mostrar vendedores que tienen al menos una venta
22. NOT EXISTS - Mostrar vendedores que no tienen ventas registradas
23. ALL - Mostrar vendedores cuyo salario es mayor que todos los salarios de vendedores contratados en 2021
24. ANY/SOME - Mostrar vendedores cuyo salario es mayor que algún vendedor contratado en 2022
25. SUBSTRING - Extraer códigos de área de teléfonos y primeras 3 letras del nombre
26. IF - Clasificar vendedores por nivel de salario (Alto/Bajo)
27. CASE - Clasificar vendedores por rango de comisión (Básica/Media/Alta/Premium)
28. COALESCE - Mostrar email o mensaje alternativo si no tienen email
29. IFNULL - Mostrar teléfono o 'Sin teléfono' si es NULL
30. NULLIF - Comparar salario con un valor específico y mostrar NULL si coincide

*/

-- 21. EXISTS (esta función no devuelve datos, solo verifica existencia)
-- Mostrar vendedores que tienen al menos una venta
SELECT * FROM vendedores v
WHERE EXISTS (
    SELECT 1 FROM ventas ve 
    WHERE ve.id_vendedor = v.id_vendedor
);

-- 22. NOT EXISTS
-- Mostrar vendedores que no tienen ventas registradas
SELECT * FROM vendedores v
WHERE NOT EXISTS (
    SELECT 1 FROM ventas ve 
    WHERE ve.id_vendedor = v.id_vendedor
);

-- 23. ALL
-- Mostrar vendedores cuyo salario es mayor que todos los salarios de vendedores contratados en 2021
SELECT * FROM vendedores
WHERE salario_base > ALL (
    SELECT salario_base 
    FROM vendedores 
    WHERE YEAR(fecha_contratacion) = 2021
);

-- 24. ANY/SOME
-- Mostrar vendedores cuyo salario es mayor que algún vendedor contratado en 2022
SELECT * FROM vendedores
WHERE salario_base > ANY (
    SELECT salario_base 
    FROM vendedores 
    WHERE YEAR(fecha_contratacion) = 2022
);

-- 25. SUBSTRING
-- Extraer códigos de área de teléfonos y primeras 3 letras del nombre
SELECT nombre, apellido,
       SUBSTRING(nombre, 1, 3) as iniciales_nombre,
       telefono,
       SUBSTRING(telefono, 1, 3) as codigo_area
FROM vendedores;

-- 26. IF
-- Clasificar vendedores por nivel de salario (Alto/Bajo)
SELECT nombre, apellido, salario_base,
       IF(salario_base > 26000, 'Alto', 'Bajo') as nivel_salario
FROM vendedores;

-- 27. CASE
-- Clasificar vendedores por rango de comisión (Básica/Media/Alta/Premium)
SELECT nombre, apellido, comision,
       CASE 
           WHEN comision <= 0.10 THEN 'Básica'
           WHEN comision <= 0.13 THEN 'Media'
           WHEN comision <= 0.16 THEN 'Alta'
           ELSE 'Premium'
       END as rango_comision
FROM vendedores;

-- 28. COALESCE
-- Mostrar email o mensaje alternativo si no tienen email
SELECT nombre, apellido,
       COALESCE(email, 'Sin email registrado') as contacto_email
FROM vendedores;

-- 29. IFNULL
-- Mostrar teléfono o 'Sin teléfono' si es NULL
SELECT nombre, apellido,
       IFNULL(telefono, 'Sin teléfono') as contacto_telefono
FROM vendedores;

-- 30. NULLIF
-- Comparar salario con un valor específico y mostrar NULL si coincide
SELECT nombre, apellido, salario_base,
       NULLIF(salario_base, 25000.00) as salario_ajustado
FROM vendedores;

-- 31. Consulta compleja combinando varias funciones
-- Reporte completo de vendedores con análisis avanzado
SELECT 
    nombre, 
    apellido,
    SUBSTRING(CONCAT(nombre, ' ', apellido), 1, 10) as nombre_corto,
    salario_base,
    comision,
    CASE 
        WHEN salario_base > 27000 AND comision > 0.15 THEN 'Ejecutivo Senior'
        WHEN salario_base > 25000 OR comision > 0.12 THEN 'Ejecutivo'
        ELSE 'Junior'
    END as categoria,
    IF(EXISTS(SELECT 1 FROM ventas WHERE ventas.id_vendedor = vendedores.id_vendedor), 
       'Con ventas', 'Sin ventas') as estado_ventas,
    COALESCE(email, CONCAT(LOWER(nombre), '@empresa.com')) as email_contacto
FROM vendedores
ORDER BY salario_base DESC, comision DESC;