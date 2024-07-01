<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reportes</title>
</head>
<body>
	<jsp:include page="masterPage.jsp" /> 
	<h1>Reportes</h1>
	<div>	
		<h2>Reporte de turnos presentes/ausentes entre enero y marzo 2024</h2>
    	<p>Total turnos: ${cantidadTotal}</p>
    	<p>Presentes: ${cantidadPresentes}</p>
    	<p>Ausentes: ${cantidadAusentes}</p>
    	<p>porcentaje de presentes: ${porcentajePresentes}</p>
    	<p>porcentaje de ausentes: ${porcentajeAusentes}</p>
	</div>
</body>
</html>