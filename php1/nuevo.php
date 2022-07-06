<html>
<head>
	<title>Registrar usuario</title>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	
	<style></style>
	
	<script>
	window.onload = function () {
	
		document.forma.cancelar.onclick = function() {
			history.back();
		}
	
	}
	</script>
	
</head>
<body>
<h1>Registrar usuario</h1>
<form name="forma" action="guardar.php" method="post">
<table>
	<tr>
		<td>Usuario:</td>
		<td><input type="text" name="usuario" size="20"></td>
	</tr>
	<tr>
		<td>Contraseña:</td>
		<td><input type="password" name="contrasena" size="20"></td>
	</tr>
	<tr>
		<td>Confirmar contraseña:</td>
		<td><input type="password" name="contrasena" size="20"></td>
	</tr>
	<tr>
		<td>Nombre completo:</td>
		<td><input type="password" name="nombre" size="20"></td>
	</tr>
	<tr>
		<td colspan="2" align="right">
			<input type="button" name="cancelar" value="Cancelar">
			<input type="submit" name="boton" value="Registrar">
		</td>
	</tr>
	
</table>
</form>
<?php include("pie.php"); ?>
</body>
</html>
