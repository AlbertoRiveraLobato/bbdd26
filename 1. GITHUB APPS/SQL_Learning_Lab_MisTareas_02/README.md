# SQL_Learning_Lab_MisTareas_02

App didáctica de SQL para gestionar tareas y categorías dentro del navegador.

## Funcionalidades

- Crea tareas, modifícalas y bórralas con SQL.
- Marca tareas como `terminadas`, `urgentes` y/o `Hoy`.
- Clasifica tareas por `categorías`, `Urgentes` y `Hoy`.
- Edita categorías y genera consultas SQL de actualización.
- Colapsa y expande secciones por categorías, urgentes y hoy usando paneles `details`.
- Visualiza el código SQL generado y ejecútalo desde el editor.

## Archivos principales

- `index.html`: interfaz de usuario, lógica de SQL.js y panel de tareas.
- `README.md`: esta documentación.

## Cómo usar

1. Abre `index.html` en un navegador moderno.
2. Usa los botones para inicializar o eliminar la base de datos.
3. Haz clic en cualquier tarea para generar la consulta SQL correspondiente en el editor.
4. Edita el valor del nombre, descripción o estado si quieres y pulsa `Ejecutar SQL`.
5. Usa las secciones de `Urgentes`, `Hoy` y `Por categorías` para organizar y colapsar tus tareas.

## Notas

- El motor SQL se ejecuta en el navegador usando `sql.js`.
- El botón `Actualizar vista` refresca la visualización de tareas.
- La aplicación se diseñó para aprender SQL y controlar tareas con acciones guiadas.
