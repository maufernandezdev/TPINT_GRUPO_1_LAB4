<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
</head>
<body>
	<form action="dashboard.html" method="post">
	    <label for="username">Usuario:</label>
	    <input type="text" id="username" name="username">
	    <br>
	    <label for="password">Contraseņa:</label>
	    <input type="password" id="password" name="password">
	    <br>
	    <input type="submit" value="Login">
	</form>
	<label>${error}</label>
</body>
</html>