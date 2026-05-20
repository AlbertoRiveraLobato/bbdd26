<?php
// El nombre correcto es scandir
$archivos = scandir('.'); 
foreach($archivos as $archivo) {
    echo "<a href='$archivo'>$archivo</a><br>";
}
?>