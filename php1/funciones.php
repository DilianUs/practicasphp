<?php
    function EjecutarSQL ($servidor, $usuario, $contrasena, $basedatos, $sentenciaSQL){

        $conexion = mysqli_connect($servidor, $usuario, $contrasena, $nombreDB);

        if(!$conexion){
            die("Error al conectarse a la base de datos: " . mysqli_connect_error());
        }else{
            //consulta de resultados con query
            $result = mysqli_query($conexion, $sentenciaSQL );
        }
        mysqli_close($conexion);
    }
?>