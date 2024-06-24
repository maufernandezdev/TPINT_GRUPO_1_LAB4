<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Pacientes</title>
        <style>
        .formularioAlta {
            display: none;
        }
    </style>
    </head>
<body>

<h1>Gestión de Pacientes</h1>

<!-- Botón Alta Paciente -->
    <button type="button" onclick="mostrarFormularioAlta()">Alta Paciente</button>
    
    <!-- Formulario de alta  -->
    <div id="formularioAlta" style="display: none;">
        <h2>Alta Paciente</h2>
		<form id="formAltaPaciente" action="/guardarPaciente" method="post">
  
        <label for="dni">DNI:</label>
        <input type="text" id="dni" name="dni" required><br>
        
        <label for="nombre">Nombre:</label>
        <input type="text" id="nombre" name="nombre" required><br>
        
        <label for="apellido">Apellido:</label>
        <input type="text" id="apellido" name="apellido" required><br>
        
        <label for="telefono">Teléfono:</label>
        <input type="text" id="telefono" name="telefono"><br>
        
        <label for="direccion">Dirección:</label>
        <input type="text" id="direccion" name="direccion"><br>
        
        <label for="provincia">Provincia:</label>
        <input type="text" id="provincia" name="provincia"><br>
        
        <label for="localidad">Localidad:</label>
        <input type="text" id="localidad" name="localidad"><br>
        
        <label for="fechaNac">Fecha de Nacimiento:</label>
        <input type="date" id="fechaNac" name="fechaNac" required><br>
        
        <label for="correo">Correo electrónico:</label>
        <input type="email" id="correo" name="correo"><br>
            
    	<button type="submit">Guardar</button>
        </form>
    </div>
<hr>

<!-- Botón para listar pacientes -->
<form action="listarPacientes.html" method="get">
    <input type="submit" value="Listar Pacientes">
</form>

<!-- Mostrar lista de pcientes -->
<c:if test="${not empty pacientes}">
    <table border="1">
        <thead>
            <tr>
                <th>Nombre</th>
                <th>DNI</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${pacientes}" var="paciente">
                <tr>
                    <td>${paciente.nombre}</td>
                    <td>${paciente.dni}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</c:if>
<c:if test="${empty pacientes}">
    <p>No hay pacientes para mostrar.</p>
</c:if>

 <!-- Javascript -->
    <script>   
    /*Aca para hacer un toogle en el botón de alta */
    function mostrarFormularioAlta() {
        var formulario = document.getElementById("formularioAlta");
        if (formulario.style.display === "block") {
            formulario.style.display = "none";
        } else {
            formulario.style.display = "block";
        }
    }

    </script>
</body>
</html>

