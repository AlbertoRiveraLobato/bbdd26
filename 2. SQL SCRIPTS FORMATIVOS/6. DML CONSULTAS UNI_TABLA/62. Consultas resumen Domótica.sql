-- Código SQL para crear una base de datos de domótica en el hogar, con tablas, inserción de datos y ejemplos de vistas.

-- Creación de la base de datos de domótica
CREATE DATABASE domotica_db;
USE domotica_db;

-- Tabla de dispositivos
CREATE TABLE dispositivos (
    id_dispositivo INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    tipo VARCHAR(50),
    ubicacion VARCHAR(100),
    estado ENUM('activado', 'desactivado', 'modo_ahorro') DEFAULT 'desactivado',
    consumo_watts DECIMAL(8,2),
    fecha_instalacion DATE
);

-- Tabla de registros de uso
CREATE TABLE registros_uso (
    id_registro INT PRIMARY KEY AUTO_INCREMENT,
    id_dispositivo INT,
    fecha_hora DATETIME,
    accion ENUM('encendido', 'apagado', 'ajuste'),
    valor_ajuste DECIMAL(10,2)
);

-- Tabla de consumos energéticos
CREATE TABLE consumos (
    id_consumo INT PRIMARY KEY AUTO_INCREMENT,
    id_dispositivo INT,
    fecha DATE,
    horas_uso DECIMAL(5,2),
    consumo_total DECIMAL(10,2)
);

-- Inserción de datos de ejemplo
INSERT INTO dispositivos (nombre, tipo, ubicacion, estado, consumo_watts, fecha_instalacion) VALUES
('Termostato Salón', 'climatización', 'Salón', 'activado', 5.50, '2023-01-15'),
('Luces LED Cocina', 'iluminación', 'Cocina', 'activado', 15.75, '2023-02-10'),
('Persianas Dormitorio', 'automatización', 'Dormitorio Principal', 'desactivado', 8.25, '2023-03-05'),
('Cámara Seguridad', 'seguridad', 'Entrada', 'activado', 12.30, '2023-01-20'),
('Aspiradora Robot', 'limpieza', 'Salón', 'modo_ahorro', 45.00, '2023-04-12'),
('Aire Acondicionado', 'climatización', 'Salón', 'desactivado', 850.00, '2023-05-20');

INSERT INTO registros_uso (id_dispositivo, fecha_hora, accion, valor_ajuste) VALUES
(1, '2024-01-15 08:00:00', 'encendido', 21.5),
(1, '2024-01-15 12:00:00', 'ajuste', 23.0),
(1, '2024-01-15 22:00:00', 'ajuste', 19.0),
(2, '2024-01-15 18:00:00', 'encendido', NULL),
(2, '2024-01-15 23:00:00', 'apagado', NULL),
(3, '2024-01-15 09:00:00', 'encendido', NULL),
(4, '2024-01-15 00:00:00', 'encendido', NULL),
(5, '2024-01-15 10:00:00', 'encendido', NULL),
(5, '2024-01-15 11:30:00', 'apagado', NULL);

INSERT INTO consumos (id_dispositivo, fecha, horas_uso, consumo_total) VALUES
(1, '2024-01-15', 8.5, 46.75),
(2, '2024-01-15', 5.0, 78.75),
(3, '2024-01-15', 2.5, 20.63),
(4, '2024-01-15', 24.0, 295.20),
(5, '2024-01-15', 1.5, 67.50),
(1, '2024-01-16', 7.0, 38.50),
(2, '2024-01-16', 4.5, 70.88);

/* BATERÍA 1: CONSULTAS DOMÓTICA SIN JOINS

1. SELECT básico - Mostrar todos los dispositivos del sistema
2. WHERE con operadores de comparación - Mostrar dispositivos con consumo superior a 50W
3. WHERE con operadores lógicos (AND, OR) - Mostrar dispositivos activados con consumo menor a 20W
4. WHERE con BETWEEN (rango) - Mostrar dispositivos con consumo entre 10W y 100W
5. WHERE con IN (conjunto) - Mostrar dispositivos de climatización o iluminación
6. WHERE con LIKE (patrones) - % cualquier cadena - Mostrar dispositivos que contengan "Salón" en su nombre
7. WHERE con LIKE (patrones) - _ un solo carácter - Mostrar dispositivos en ubicaciones que coincidan con el patrón "S_l_n"
8. WHERE con IS NULL - Mostrar registros de uso donde no se especificó valor de ajuste
9. OPERADORES ARITMÉTICOS - Campos calculados - Calcular consumo diario y costo diario de cada dispositivo
10. GROUP BY con COUNT - Contar número de dispositivos por tipo
11. GROUP BY con múltiples columnas - Contar dispositivos por tipo y estado
12. HAVING con condición sobre agregación - Mostrar tipos de dispositivo con consumo promedio superior a 50W
13. HAVING con operadores aritméticos - Mostrar tipos de dispositivo con consumo diario total superior a 100W
14. Sub-consulta en WHERE - Mostrar dispositivos que han tenido consumos superiores a 50W
15. Sub-consulta en FROM - Mostrar tipos de dispositivo con consumo promedio superior a 20W (usando subconsulta en FROM)
16. Sub-consulta en SELECT - Mostrar dispositivos con el número total de acciones registradas
17. Sub-consulta correlacionada - Mostrar consumos superiores al promedio de su dispositivo
18. Consulta con NOT y operadores lógicos - Mostrar dispositivos no desactivados con consumo no inferior a 10W, instalados antes de junio 2023
19. Consulta con múltiples condiciones y operadores - Reporte de consumo por ubicación para dispositivos activados que no son de seguridad
20. Consulta final con todos los operadores - Reporte final de consumo por tipo con todos los filtros aplicados

*/

-- 1. SELECT básico
-- Mostrar todos los dispositivos del sistema
SELECT * FROM dispositivos;

-- 2. WHERE con operadores de comparación
-- Mostrar dispositivos con consumo superior a 50W
SELECT * FROM dispositivos WHERE consumo_watts > 50;

-- 3. WHERE con operadores lógicos (AND, OR)
-- Mostrar dispositivos activados con consumo menor a 20W
SELECT * FROM dispositivos 
WHERE estado = 'activado' AND consumo_watts < 20;

-- 4. WHERE con BETWEEN (rango)
-- Mostrar dispositivos con consumo entre 10W y 100W
SELECT * FROM dispositivos 
WHERE consumo_watts BETWEEN 10 AND 100;

-- 5. WHERE con IN (conjunto)
-- Mostrar dispositivos de climatización o iluminación
SELECT * FROM dispositivos 
WHERE tipo IN ('climatización', 'iluminación');

-- 6. WHERE con LIKE (patrones) - % cualquier cadena
-- Mostrar dispositivos que contengan "Salón" en su nombre
SELECT * FROM dispositivos 
WHERE nombre LIKE '%Salón%';

-- 7. WHERE con LIKE (patrones) - _ un solo carácter
-- Mostrar dispositivos en ubicaciones que coincidan con el patrón "S_l_n"
SELECT * FROM dispositivos 
WHERE ubicacion LIKE 'S_l_n';

-- 8. WHERE con IS NULL
-- Mostrar registros de uso donde no se especificó valor de ajuste
SELECT * FROM registros_uso 
WHERE valor_ajuste IS NULL;

-- 9. OPERADORES ARITMÉTICOS - Campos calculados
-- Calcular consumo diario y costo diario de cada dispositivo
SELECT nombre, 
       consumo_watts,
       consumo_watts * 24 as consumo_diario,
       consumo_watts * 24 * 0.30 as costo_diario
FROM dispositivos;

-- 10. GROUP BY con COUNT
-- Contar número de dispositivos por tipo
SELECT tipo, COUNT(*) as cantidad_dispositivos
FROM dispositivos 
GROUP BY tipo;

-- 11. GROUP BY con múltiples columnas
-- Contar dispositivos por tipo y estado
SELECT tipo, estado, COUNT(*) as cantidad
FROM dispositivos 
GROUP BY tipo, estado;

-- 12. HAVING con condición sobre agregación
-- Mostrar tipos de dispositivo con consumo promedio superior a 50W
SELECT tipo, AVG(consumo_watts) as consumo_promedio
FROM dispositivos 
GROUP BY tipo
HAVING AVG(consumo_watts) > 50;

-- 13. HAVING con operadores aritméticos
-- Mostrar tipos de dispositivo con consumo diario total superior a 100W
SELECT tipo, 
       SUM(consumo_watts) as consumo_total,
       SUM(consumo_watts) * 24 as consumo_diario_total
FROM dispositivos 
GROUP BY tipo
HAVING SUM(consumo_watts) * 24 > 100;

-- 14. Sub-consulta en WHERE
-- Mostrar dispositivos que han tenido consumos superiores a 50W
SELECT * FROM dispositivos 
WHERE id_dispositivo IN (
    SELECT id_dispositivo 
    FROM consumos 
    WHERE consumo_total > 50
);

-- 15. Sub-consulta en FROM
-- Mostrar tipos de dispositivo con consumo promedio superior a 20W (usando subconsulta en FROM)
SELECT t.tipo, t.consumo_promedio
FROM (
    SELECT tipo, AVG(consumo_watts) as consumo_promedio
    FROM dispositivos 
    GROUP BY tipo
) AS t
WHERE t.consumo_promedio > 20;

-- 16. Sub-consulta en SELECT
-- Mostrar dispositivos con el número total de acciones registradas
SELECT nombre, tipo,
       (SELECT COUNT(*) FROM registros_uso 
        WHERE registros_uso.id_dispositivo = dispositivos.id_dispositivo) as total_acciones
FROM dispositivos;

-- 17. Sub-consulta correlacionada
-- Mostrar consumos superiores al promedio de su dispositivo
SELECT * FROM consumos c1
WHERE consumo_total > (
    SELECT AVG(consumo_total)
    FROM consumos c2
    WHERE c2.id_dispositivo = c1.id_dispositivo
);

-- 18. Consulta con NOT y operadores lógicos
-- Mostrar dispositivos no desactivados con consumo no inferior a 10W, instalados antes de junio 2023
SELECT * FROM dispositivos 
WHERE NOT (estado = 'desactivado' OR consumo_watts < 10)
AND fecha_instalacion < '2023-06-01';

-- 19. Consulta con múltiples condiciones y operadores
-- Reporte de consumo por ubicación para dispositivos activados que no son de seguridad
SELECT ubicacion,
       COUNT(*) as total_dispositivos,
       SUM(consumo_watts) as consumo_total,
       AVG(consumo_watts) as consumo_promedio
FROM dispositivos
WHERE estado != 'desactivado'
AND tipo NOT IN ('seguridad')
GROUP BY ubicacion
HAVING AVG(consumo_watts) > 15
ORDER BY consumo_total DESC;

-- 20. Consulta final con todos los operadores
-- Reporte final de consumo por tipo con todos los filtros aplicados
SELECT tipo,
       COUNT(*) as cantidad,
       MAX(consumo_watts) as max_consumo,
       MIN(consumo_watts) as min_consumo,
       AVG(consumo_watts) as promedio_consumo
FROM dispositivos
WHERE fecha_instalacion BETWEEN '2023-01-01' AND '2023-12-31'
AND (estado LIKE 'act%' OR estado = 'modo_ahorro')
GROUP BY tipo
HAVING COUNT(*) >= 1 AND AVG(consumo_watts) BETWEEN 10 AND 500
ORDER BY promedio_consumo DESC;

/* BATERÍA 2: CONSULTAS AVANZADAS - SUBCONSULTAS Y FUNCIONES

21. EXISTS - Mostrar dispositivos que tienen al menos un registro de uso
22. NOT EXISTS - Mostrar dispositivos que no tienen registros de uso
23. ALL - Mostrar dispositivos cuyo consumo es mayor que todos los dispositivos instalados en enero 2023
24. ANY/SOME - Mostrar dispositivos cuyo consumo es menor que algún dispositivo de climatización
25. SUBSTRING - Extraer primeras 3 letras del nombre y tipo, y año de instalación
26. IF - Clasificar dispositivos por nivel de consumo (Alto/Bajo)
27. CASE - Clasificar dispositivos por categoría de eficiencia energética
28. COALESCE - Mostrar valor de ajuste o mensaje alternativo si no hay ajuste
29. IFNULL - Mostrar horas de uso o 'Sin uso registrado' si es NULL
30. NULLIF - Comparar consumo con un valor específico y mostrar NULL si coincide

*/

-- 21. EXISTS
-- Mostrar dispositivos que tienen al menos un registro de uso
SELECT * FROM dispositivos d
WHERE EXISTS (
    SELECT 1 FROM registros_uso r 
    WHERE r.id_dispositivo = d.id_dispositivo
);

-- 22. NOT EXISTS
-- Mostrar dispositivos que no tienen registros de uso
SELECT * FROM dispositivos d
WHERE NOT EXISTS (
    SELECT 1 FROM registros_uso r 
    WHERE r.id_dispositivo = d.id_dispositivo
);

-- 23. ALL
-- Mostrar dispositivos cuyo consumo es mayor que todos los dispositivos instalados en enero 2023
SELECT * FROM dispositivos
WHERE consumo_watts > ALL (
    SELECT consumo_watts 
    FROM dispositivos 
    WHERE MONTH(fecha_instalacion) = 1 AND YEAR(fecha_instalacion) = 2023
);

-- 24. ANY/SOME
-- Mostrar dispositivos cuyo consumo es menor que algún dispositivo de climatización
SELECT * FROM dispositivos
WHERE consumo_watts < ANY (
    SELECT consumo_watts 
    FROM dispositivos 
    WHERE tipo = 'climatización'
);

-- 25. SUBSTRING
-- Extraer primeras 3 letras del nombre y tipo, y año de instalación
SELECT nombre, tipo,
       SUBSTRING(nombre, 1, 3) as codigo_nombre,
       SUBSTRING(tipo, 1, 3) as codigo_tipo,
       SUBSTRING(fecha_instalacion, 1, 4) as año_instalacion
FROM dispositivos;

-- 26. IF
-- Clasificar dispositivos por nivel de consumo (Alto/Bajo)
SELECT nombre, tipo, consumo_watts,
       IF(consumo_watts > 50, 'Alto', 'Bajo') as nivel_consumo
FROM dispositivos;

-- 27. CASE
-- Clasificar dispositivos por categoría de eficiencia energética
SELECT nombre, tipo, consumo_watts,
       CASE 
           WHEN consumo_watts <= 10 THEN 'Muy Eficiente'
           WHEN consumo_watts <= 50 THEN 'Eficiente'
           WHEN consumo_watts <= 100 THEN 'Moderado'
           ELSE 'Alto Consumo'
       END as categoria_eficiencia
FROM dispositivos;

-- 28. COALESCE
-- Mostrar valor de ajuste o mensaje alternativo si no hay ajuste
SELECT id_registro, accion,
       COALESCE(valor_ajuste, 0) as valor_ajuste_seguro,
       COALESCE(CAST(valor_ajuste AS CHAR), 'Sin ajuste especificado') as detalle_ajuste
FROM registros_uso;

-- 29. IFNULL
-- Mostrar horas de uso o 'Sin uso registrado' si es NULL
SELECT fecha, 
       IFNULL(horas_uso, 0) as horas_uso_seguro,
       IFNULL(CAST(horas_uso AS CHAR), 'Sin uso registrado') as detalle_uso
FROM consumos;

-- 30. NULLIF
-- Comparar consumo con un valor específico y mostrar NULL si coincide
SELECT nombre, tipo, consumo_watts,
       NULLIF(consumo_watts, 15.75) as consumo_ajustado
FROM dispositivos;

-- 31. Consulta compleja combinando varias funciones
-- Reporte completo de dispositivos con análisis avanzado
SELECT 
    nombre,
    tipo,
    SUBSTRING(CONCAT(tipo, '-', ubicacion), 1, 15) as codigo_dispositivo,
    consumo_watts,
    estado,
    CASE 
        WHEN consumo_watts > 100 AND estado = 'activado' THEN 'Crítico - Alto Consumo'
        WHEN consumo_watts > 50 OR estado = 'activado' THEN 'Monitorear'
        WHEN estado = 'modo_ahorro' THEN 'Eficiente'
        ELSE 'Inactivo'
    END as categoria_energia,
    IF(EXISTS(SELECT 1 FROM registros_uso WHERE registros_uso.id_dispositivo = dispositivos.id_dispositivo), 
       'Con actividad', 'Sin actividad') as estado_actividad,
    COALESCE(ubicacion, CONCAT('Ubicación-', tipo)) as ubicacion_completa,
    IFNULL(NULLIF(consumo_watts, 0), 1) as consumo_calculado
FROM dispositivos
WHERE fecha_instalacion >= '2023-01-01'
ORDER BY consumo_watts DESC, nombre ASC;

-- 32. Análisis de eficiencia por tipo con subconsultas complejas
-- Comparar cada dispositivo con el promedio de su tipo
SELECT 
    d.nombre,
    d.tipo,
    d.consumo_watts,
    (SELECT AVG(consumo_watts) FROM dispositivos d2 WHERE d2.tipo = d.tipo) as promedio_tipo,
    CASE 
        WHEN d.consumo_watts > (SELECT AVG(consumo_watts) FROM dispositivos d2 WHERE d2.tipo = d.tipo) 
        THEN 'Por encima del promedio'
        ELSE 'Por debajo del promedio'
    END as comparacion_eficiencia,
    IF(EXISTS(SELECT 1 FROM consumos c WHERE c.id_dispositivo = d.id_dispositivo AND c.consumo_total > 50),
       'Alto consumo registrado', 'Consumo normal') as historial_consumo
FROM dispositivos d
WHERE d.consumo_watts > ANY (
    SELECT AVG(consumo_watts) 
    FROM dispositivos 
    GROUP BY tipo
)
ORDER BY d.tipo, d.consumo_watts DESC;