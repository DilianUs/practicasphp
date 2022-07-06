<?php

$servidor = "localhost";
$usuario = "root";
$contrasena = "";
$basedatos = "inventario";

$conexion = mysqli_connect($servidor, $usuario, $contrasena, $basedatos);
if (!$conexion) {
    die("Fallo: " . mysqli_connect_error());
}

//Completar la sentencia SQL
$sql = "SELECT usuario, contrasena FROM usuarios WHERE usuario ='" . $_REQUEST["usuario"] . "' AND contrasena = '".$_REQUEST["contrasena"]. "'";

$resultado = mysqli_query($conexion, $sql);
mysqli_close($conexion);

if (mysqli_num_rows($resultado) > 0) {
	//Si hay registro reenviar a la página menu.php
	header("location: menu.php");
} else {
	//Sino redirigir a la página index.html 
	header("location: index.php");
}

?>