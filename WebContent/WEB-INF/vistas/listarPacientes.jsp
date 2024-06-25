<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<jsp:include page="masterPage.jsp" /> 
	
<c:if test="${not empty listaPacientes}">	
	<table class="table table-sm">
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

</body>
</html>