<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="masterPage.jsp" /> 

<div class="container mt-5">
    <h1 class="text-center">Gestión de Turnos</h1>
    <h2 class="text-center">Lista de Turnos</h2>
    
    <c:if test="${not empty listaTurnos}">
        <table id="tablaTurnos" class="table table-striped table-bordered">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Médico</th>
                    <th>Paciente</th>
                    <th>Fecha</th>
                    <th>Hora</th>
                    <th>Estado</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${listaTurnos}" var="turno">
                    <tr>
                        <td>${turno.idTurno}</td>
						<td>${turno.medico.apellido} ${turno.medico.nombre}</td>
						<td>${turno.paciente.apellido} ${turno.paciente.nombre}</td>
                        <td>${turno.fecha}</td>
                        <td>${turno.hora}</td>
                        <td>${turno.estadoTurno}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
</div>
</body>
</html>