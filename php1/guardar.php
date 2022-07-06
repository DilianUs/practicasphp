<?php
//incluir un archivo de bibliotecas funciones.php que defina la función
include ('funciones.php');
//acceso a servidor
$servidor = "localhost" ;
$usuario= "root";
$contraseña="";
$nombreDB="inventario";

//sentenciaSQL
$sentenciaSQL = "INSERT INTO usuarios (usuario, contrasena, nombre) VALUES ('".$_REQUEST['usuario']. "', '" .$_REQUEST['contrasena']. "','". $_REQUEST['nombre']. "' )";

// EjecutarSQL ($servidor, $usuario, $contrasena, $basedatos, $sentenciaSQL)
EjecutarSQL ($servidor, $usuario, $contrasena, $nombreDB, $sentenciaSQL);

//Guardar el nombre de usuario, contraseña y nombre en la tabla de usuarios usando la función EjecutarSQL()
// function Suma ($a, $b) { return ($a + $b); };

header("location: menu.php");

?>