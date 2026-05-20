let db, ready = false;
const sqlInput = document.getElementById('sqlInput');
const btnEjecutar = document.getElementById('btnEjecutar');
const btnBorrar = document.getElementById('btnBorrar');
const btnReiniciar = document.getElementById('btnReiniciar');
const btnCrearTabla = document.getElementById('btnCrearTabla');
const btnInsertarDatos = document.getElementById('btnInsertarDatos');
const btnConsultarDatos = document.getElementById('btnConsultarDatos');
const btnActualizarDatos = document.getElementById('btnActualizarDatos');
const btnUnirTablas = document.getElementById('btnUnirTablas');
const output = document.getElementById('output');
const tableCards = document.getElementById('tableCards');

initSqlJs({ locateFile: file => `https://cdnjs.cloudflare.com/ajax/libs/sql.js/1.8.0/${file}` })
    .then(SQL => {
        db = new SQL.Database();
        ready = true;
        drawTables();
        showMessage('Base de datos lista. Escribe SQL o usa un botón de ejemplo.');
    })
    .catch(err => {
        showMessage('Error cargando SQL.js: ' + err.message, true);
    });

function showMessage(message, isError = false) {
    output.textContent = message;
    output.style.color = isError ? '#d32f2f' : '#1b5e20';
}

function printResult(rows) {
    if (!rows || rows.length === 0) {
        output.innerHTML = "<pre>No hay resultados para mostrar.</pre>";
        return;
    }
    let html = '<table><thead><tr>';
    for (const key in rows[0]) {
        html += `<th>${key}</th>`;
    }
    html += '</tr></thead><tbody>';
    rows.forEach(row => {
        html += '<tr>';
        for (const key in row) {
            html += `<td>${row[key]}</td>`;
        }
        html += '</tr>';
    });
    html += '</tbody></table>';
    output.innerHTML = html;
}

function runSQL() {
    if (!ready) return;
    const sql = sqlInput.value.trim();
    if (!sql) {
        showMessage('Escribe una consulta SQL antes de ejecutar.', true);
        return;
    }
    try {
        const results = db.exec(sql);
        
        // Si hay resultados (como en SELECT), mostrarlos
        if (results.length > 0 && results[0].values && results[0].values.length > 0) {
            const rows = results[0].values || [];
            const columns = results[0].columns || [];
            // Formatear como array de objetos
            let data = [];
            rows.forEach(row => {
                let obj = {};
                columns.forEach((col, i) => obj[col] = row[i]);
                data.push(obj);
            });
            printResult(data);
        } else {
            // Si no hay resultados pero la consulta fue exitosa
            showMessage('¡SQL ejecutado correctamente!');
        }
        
        drawTables();
    } catch (e) {
        showMessage('Error: ' + e.message, true);
    }
}

function clearEditor() {
    sqlInput.value = '';
    sqlInput.focus();
}

function resetDatabase() {
    if (!ready) return;
    try {
        const res = db.exec("SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%';");
        if (res[0]) {
            res[0].values.forEach(row => {
                db.exec(`DROP TABLE IF EXISTS ${row[0]};`);
            });
        }
        drawTables();
        showMessage('Base de datos reiniciada. Estructura borrada.');
    } catch (e) {
        showMessage('Error al reiniciar la base de datos: ' + e.message, true);
    }
}

function drawTables() {
    if (!ready) return;
    tableCards.innerHTML = '';
    const res = db.exec("SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' ORDER BY name;");
    if (!res[0] || res[0].values.length === 0) {
        tableCards.innerHTML = '<i>No hay tablas en la base de datos.</i>';
        return;
    }

    let colorIndex = 0;
    res[0].values.forEach(row => {
        const tableName = row[0];
        const pragmaRes = db.exec(`PRAGMA table_info(${tableName});`);
        const columns = pragmaRes[0]?.values || [];
        const card = document.createElement('div');
        card.className = `table-card room-color-${colorIndex % 5}`;
        card.innerHTML = `
            <div class="table-title">${tableName}</div>
            <div class="table-info">Columnas: ${columns.length}</div>
            <div class="table-columns">${columns.map(col => `${col[1]} (${col[2]})${col[5] ? ' PK' : ''}`).join('<br>')}</div>
        `;
        tableCards.appendChild(card);
        colorIndex += 1;
    });
}

function loadExample(type) {
    switch (type) {
        case 'create_table':
            sqlInput.value = `CREATE TABLE alumnos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    edad INTEGER,
    curso TEXT
);

CREATE TABLE cursos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    profesor TEXT
);`;
            showMessage('Ejemplo de creación de tablas cargado en el editor.');
            break;
        case 'insert_data':
            sqlInput.value = `INSERT INTO alumnos (nombre, edad, curso) VALUES
('Ana García', 20, 'Bases de Datos'),
('Luis Martínez', 22, 'Programación'),
('Marta Rodríguez', 21, 'Bases de Datos');

INSERT INTO cursos (nombre, profesor) VALUES
('Bases de Datos', 'Dra. Gómez'),
('Programación', 'Dr. Pérez');`;
            showMessage('Ejemplo de inserción de datos cargado en el editor.');
            break;
        case 'select_data':
            sqlInput.value = `SELECT * FROM alumnos;`;
            showMessage('Ejemplo de consulta de datos cargado en el editor.');
            break;
        case 'update_data':
            sqlInput.value = `UPDATE alumnos
SET edad = 23
WHERE nombre = 'Luis Martínez';`;
            showMessage('Ejemplo de actualización de datos cargado en el editor.');
            break;
        case 'join_tables':
            sqlInput.value = `SELECT a.nombre AS alumno, a.edad, a.curso, c.profesor
FROM alumnos a
JOIN cursos c ON a.curso = c.nombre;`;
            showMessage('Ejemplo de JOIN cargado en el editor.');
            break;
        default:
            sqlInput.value = '';
            showMessage('Tipo de ejemplo desconocido.', true);
    }
}

btnEjecutar.addEventListener('click', runSQL);
btnBorrar.addEventListener('click', clearEditor);
btnReiniciar.addEventListener('click', resetDatabase);
btnCrearTabla.addEventListener('click', () => loadExample('create_table'));
btnInsertarDatos.addEventListener('click', () => loadExample('insert_data'));
btnConsultarDatos.addEventListener('click', () => loadExample('select_data'));
btnActualizarDatos.addEventListener('click', () => loadExample('update_data'));
btnUnirTablas.addEventListener('click', () => loadExample('join_tables'));

sqlInput.addEventListener('keydown', function(e) {
    if (e.key === 'Tab') {
        e.preventDefault();
        const start = this.selectionStart;
        const end = this.selectionEnd;
        this.value = this.value.substring(0, start) + '    ' + this.value.substring(end);
        this.selectionStart = this.selectionEnd = start + 4;
    }
    if (e.key === 'Enter' && (e.ctrlKey || e.metaKey)) {
        e.preventDefault();
        runSQL();
    }
});
