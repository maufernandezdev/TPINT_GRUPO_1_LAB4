<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">
</head>
<body>

	<jsp:include page="masterPage.jsp" /> 
	
    <h1>Gestión de Pacientes</h1>
<div class="container mt-5">
    <h2 class="text-center">Lista de Pacientes</h2>	
	
<c:if test="${not empty listaPacientes}">	
	<table id="tablaPacientes" class="table table-sm">
        <thead>
            <tr>
                <th>DNI</th>
                <th>Nombre</th>
                <th>Apellido</th>
                <th>Correo</th>
                <th>Telefono</th>
                <th>Direccion</th>
                <th>Localidad</th>
                <th>Provincia</th>
                <th>Fecha Nac</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${listaPacientes}" var="paciente">
                <tr>
                    <td>${paciente.dni}</td>
                    <td>${paciente.nombre}</td>
                    <td>${paciente.apellido}</td>
                    <td>${paciente.correo}</td>
                    <td>${paciente.telefono}</td>
                    <td>${paciente.direccion}</td>
                    <td>${paciente.localidad}</td>
                    <td>${paciente.provincia}</td>
                    <td>${paciente.fechaNac}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</c:if>
</div>

<script>
$(document).ready( function () {
    $('#tablaPacientes').DataTable({
    	"searching": false,
    	"lengthMenu": [5, 10, 15, 30, 60],
    	"language": {
            "zeroRecords": "No se encontraron datos",
            "infoEmpty": "No hay datos para mostrar",
            "info": "Mostrando del _START_ al _END_, de un total de _TOTAL_ entradas",
            "lengthMenu": "Mostrar _MENU_ registros",
            "paginate": {
                "first": "Primeros",
                "last": "Ultimos",
                "next": "Siguiente",
                "previous": "Anterior"
            },
        },
    });
} );
</script>

</body>
</html>