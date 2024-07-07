<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Dashboard - Pacientes</title>
    <style>
        input {
            outline: none;
        }
        .container {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            padding-bottom: 2rem;
            font-family: helvetica, sans-serif;
        }
        .container h2 {
            width: 100%;
            text-align: center;
        }
        .container form {
            background-color: #ccc;
            border-radius: 8px;
            padding: 2rem 1rem;
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            grid-column-gap: 40px;
            grid-row-gap: 15px;
            width: 100%;
            max-width: 1000px;
            margin: 0 auto;
        }
        .container form input, select {
            padding: 8px;
            border-radius: 4px;    
            border: none;
            background-color: #fff;
        }
        .container form .item {
            margin-bottom: 1rem;
            width: 100%;
            display: flex;
            align-items: center;
        }
        .container form .item label {
            flex: 0 0 auto;
            margin-right: 10px;
        }
        .container form .item input, select {
            flex: 1;
            width: 100%;
            box-sizing: border-box;
        }
        .container form .buttonContainer {
            display: flex;
            justify-content: center;
            width: 100%;
            margin-top: 1rem;
        }
        .container form button {
            padding: 12px 8px;
            background-color: #0066cc;
            color: #fff;
            outline: none;
            border-radius: 8px;    
            border: none;
            width: 100%;
        }
        .error-message {
            color: red;
            text-align: center;
            margin-bottom: 1rem;
        }
        .success-message {
            color: green;
            text-align: center;
            margin-bottom: 1rem;
        }
    </style>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            flatpickr("#fechaNac", {
                dateFormat: "Y-m-d"
            });
        });
    </script>
</head>
<body>

<jsp:include page="masterPage.jsp" /> 

<h1>Gestión de Pacientes</h1>
<div id="formularioAlta" class="container">
    <h2>Alta Paciente</h2>
    <c:if test="${not empty errorMessage}">
        <div class="error-message">${errorMessage}</div>
    </c:if>
    <c:if test="${not empty successMessage}">
        <div class="success-message">${successMessage}</div>
    </c:if>
    <form id="formAltaPaciente" action="guardar_paciente.html" method="post">
        <div class="item">
            <label for="dni">DNI:</label>
            <input type="text" id="dni" name="dni" value="${paciente.dni}" required><br>
        </div>
        <div class="item">
            <label for="nombre">Nombre:</label>
            <input type="text" id="nombre" name="nombre" value="${paciente.nombre}" required><br>
        </div>
        <div class="item">
            <label for="apellido">Apellido:</label>
            <input type="text" id="apellido" name="apellido" value="${paciente.apellido}" required><br>
        </div>
        <div class="item">
            <label for="fechaNac">Fecha de nacimiento:</label>
            <input type="text" id="fechaNac" name="fechaNac" value="${paciente.fechaNac}" required><br>
        </div>
        <div class="item">
            <label for="direccion">Dirección:</label>
            <input type="text" id="direccion" name="direccion" value="${paciente.direccion}" required><br>
        </div>
        
        <div class="item"> 
				    <label for="provinciaId">Provincia:</label>
				    <select id="provinciaId" onchange="cargarLocalidades()" required>
				        <option value="">Selecciona una provincia</option>
				        <c:forEach items="${provincias}" var="provincia">
				            <option value="${provincia.id_provincia}">${provincia.nombre}</option>
				        </c:forEach>
				   </select>
	        </div> 
        
        <div class="item"> 
	        <label for="localidadId">Localidad:</label>
	        <select id="localidadId" name="localidadId" value="${paciente.telefono}" required>
	            <!-- Options se cargarán dinámicamente con JavaScript -->
	        </select>
        </div> 
    
        <div class="item">
            <label for="telefono">Teléfono:</label>
            <input type="number" id="telefono" name="telefono" value="${paciente.telefono}" required><br>
        </div>
        <div class="item">
            <label for="correo">Correo electrónico:</label>
            <input type="email" id="correo" name="correo" value="${paciente.correo}" required><br>
        </div>
        <div class="buttonContainer">
            <button type="submit">Guardar</button>
        </div>
    </form>
</div>


<script>
function cargarLocalidades() {
    var provinciaId = document.getElementById("provinciaId").value;
    var localidadDropdown = document.getElementById("localidadId");
    localidadDropdown.innerHTML = "";  // Limpiar opciones existentes

    // Mostrar solo las localidades correspondientes a la provincia seleccionada
    <c:forEach items="${localidades}" var="localidad">
        if ("${localidad.provincia.id_provincia}" === provinciaId) {
            var option = document.createElement("option");
            option.value = "${localidad.id_localidad}";
            option.textContent = "${localidad.nombre}";
            localidadDropdown.appendChild(option);
        }
    </c:forEach>

    // Habilitar el dropdown de localidades
    localidadDropdown.disabled = false;
}

document.getElementById("provinciaId").addEventListener("change", cargarLocalidades);

document.querySelector("form").addEventListener("submit", function(event) {
    var localidadId = document.getElementById("localidadId").value;
});

</script>
</body>
</html>