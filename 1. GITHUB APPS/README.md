# 3. GITHUB APPS

Este repositorio contiene varias aplicaciones de práctica de SQL y prototipos. Cada carpeta incluye una app HTML/JS independiente para ejecutar, crear y visualizar bases de datos SQLite en el navegador.

## Carpetas y funcionalidades

### `probatinas01`
- App interactiva de SQL con editor y botones para ejecutar, limpiar, inicializar y eliminar la base de datos.
- Carga y ejecuta SQL usando la librería `sql.js` desde CDN.
- Visualiza la información de las tablas creadas y muestra mensajes de estado.
- El título cambia de color cada vez que se ejecuta SQL.
- Permite cargar código de inicialización predefinido en formato SQL.

### `probatinas02`
- Editor de SQL con controles para ejecutar, borrar, inicializar, eliminar y actualizar la base de datos.
- Interfaz dividida en panel izquierdo (editor y botones) y panel derecho (visualización de la BBDD).
- La cabecera cambia de color aleatoriamente cuando un comando SQL se ejecuta correctamente.
- Si ocurre un error al ejecutar un comando, la cabecera se vuelve roja para indicar fallo.
- Incluye atajos de teclado: Ctrl+Enter para ejecutar y TAB para sangrar dentro del editor.
- Utiliza `sql.js` desde CDN para crear y ejecutar una base de datos SQLite en memoria.

### `SQL_Learning_Lab_DDL_01`
- Playground de SQL orientado a prácticas con ejemplos de creación de tabla, inserción, consulta, actualización y JOIN.
- Permite exportar e importar la base de datos desde el navegador y guardar consultas personalizadas en `localStorage`.
- Ofrece pestañas para ver resultados, mensajes y el esquema actual de la base de datos.
- Incluye mensajes de estado y una interfaz con botones para ejecutar, formatear, guardar y limpiar.

### `SQL_Learning_Lab_DDL_02`
- Editor enfocado en DDL (definición de estructuras de tablas).
- Permite ejecutar código SQL y ver la estructura actual de las tablas en tarjetas de colores.
- Incluye un botón de ejemplo que inserta un conjunto básico de `CREATE TABLE` para comenzar.
- Proporciona mensajes de ayuda si hay errores de SQL relacionados con diferencias entre SQLite y otros motores.
- Visualiza los nombres de tablas y sus campos con marcas de `PK`.

### `SQL_Learning_Lab_DDL_03`
- Combina la funcionalidad DDL de `DDL_02` con botones de ejemplos tipo `DDL_01`.
- Incluye botones para cargar SQL de ejemplo: crear tabla, insertar datos, consultar datos, actualizar datos y unir tablas.
- Añade un botón para reiniciar la base de datos, borrando toda la estructura existente.
- Muestra las tablas actuales y sus columnas en tarjetas de colores.
- Usa `sql.js` desde CDN para ejecutar SQLite en el navegador.

### `SQL_Learning_Lab_DML_03`
- App con un caso práctico de DML basado en habitaciones y sensores.
- Proporciona una base de datos de ejemplo con tablas `habitaciones`, `sensores` y `habitaciones_sensores`.
- Muestra las habitaciones como tarjetas y permite ejecutar consultas SQL personalizadas.
- Incluye un botón de lápiz en cada sensor que genera una sentencia `UPDATE` en el editor para que el usuario modifique el valor manualmente.
- Incluye botones para inicializar la BD, borrar la BD, borrar la consulta y actualizar la vista.
- Usa `sql-wasm.js` local para ejecutar SQLite en el navegador.

### `SQL_Learning_Lab_DML_04`
- Editor de SQL con visualización de tablas y datos en tiempo real.
- La cabecera cambia de color aleatoriamente cuando un comando se ejecuta correctamente, y se vuelve roja en caso de error.
- Incluye un área de resultados que muestra las consultas SELECT en formato de tabla.
- Botones para ejecutar, borrar el editor, inicializar la base de datos, eliminar la base de datos y actualizar la vista de tablas.
- Muestra la estructura de cada tabla (`PRAGMA table_info`) y sus datos actuales.
- Calcula restricciones como `NOT NULL`, `DEFAULT`, `PRIMARY KEY`, `AUTOINCREMENT`, `UNIQUE` y `CHECK`.
- Utiliza `sql.js` desde CDN y presenta una vista gráfica de las tablas creadas.

### `SQL_Learning_Lab_MisTareas_02`
- App de gestión de tareas con SQL en el navegador.
- Permite crear tareas, modificarlas, borrarlas y marcarlas como terminadas.
- Marca tareas como `urgentes` y/o `Hoy`.
- Clasifica tareas por categorías, urgentes y hoy.
- Permite editar categorías y colapsar/expandir secciones por categorías, urgentes y hoy.
- Genera consultas SQL desde la interfaz para aplicar cambios en las tareas.

## Cómo usar

1. Abre la carpeta de la aplicación que quieras probar.
2. Abre `index.html` en un navegador moderno.
3. Usa los controles de la interfaz para ejecutar SQL, inicializar o eliminar la base de datos.

> Nota: algunas apps usan `sql.js` desde CDN, mientras que `SQL_Learning_Lab_DML_03` también incluye `sql-wasm.js` local.

## Carpeta `0. OLD`

Esta carpeta contiene versiones antiguas y prototipos previos de las apps SQL. Se conservan como referencia histórica y para comparar la evolución del proyecto.

