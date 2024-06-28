<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Dashboard - Medicos</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
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
        }
        .container form {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            grid-column-gap: 40px;
            grid-row-gap: 15px;
            width: 100%;
            max-width: 1000px;
            margin: 0px auto;
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
    </style>
</head>
<body>

<jsp:include page="masterPage.jsp" /> 

<h1>Gesti�n de Medicos</h1>
<div id="formularioAlta" class="container">
    <h2>Alta M�dico</h2>
    <c:if test="${not empty errorMessage}">
        <div class="error-message">${errorMessage}</div>
    </c:if>
    <c:if test="${not empty successMessage}">
        <div class="success-message">${successMessage}</div>
    </c:if>

    <form id="formAltaMedico" action="guardar_medico.html" method="post">
        <div class="item">
            <label for="nombre">Nombre:</label>
            <input type="text" id="nombre" name="nombre" required><br>
        </div>
        
        <div class="item">
            <label for="apellido">Apellido:</label>
            <input type="text" id="apellido" name="apellido" required><br>
        </div>
        <div class="item">
            <label for="sexo">Seleccione su sexo:</label>
            <select id="sexo" name="sexo" required>
                <option value="" disabled selected>sexo</option>
                <option value="M">Masculino</option>
                <option value="F">Femenino</option>
                <option value="O">Otro</option>
                <option value="N">Prefiero no decirlo</option>
            </select><br>
        </div>
        
        <div class="item">
            <label for="fechaDeNac">Fecha de nacimiento:</label>
            <input type="date" name="fechaDeNac"/>
        </div>
        
        <div class="item">
            <label for="direccion">Direcci�n:</label>
            <input type="text" id="direccion" name="direccion"><br>
        </div>
        
        <div class="item">
            <label for="localidad">Localidad:</label>
            <input type="text" id="localidad" name="localidad"><br>
        </div>
        
        <div class="item">
            <label for="correo">Correo electr�nico:</label>
            <input type="email" id="correo" name="correo"><br>
        </div>
        
        <div class="item">
            <label for="telefono">Tel�fono:</label>
            <input type="number" id="telefono" name="telefono"><br>
        </div>
        
        <div class="item">
            <label for="usuario">Nombre de usuario:</label>
            <input type="text" id="usuario" name="usuario"><br>
        </div>
        
        <div class="item">
            <label for="contrasenia">Contrase�a:</label>
            <input type="password" id="contrasenia" name="contrasenia"><br>
        </div>
        
        <div class="item">
            <label for="especialidad">Seleccione una especialidad:</label>
            <select id="especialidad" name="especialidad">
                <option value="" disabled selected>especialidad</option>
                <c:forEach items="${especialidades}" var="especialidad">
                    <option value="${especialidad.id}">${especialidad.nombre}</option>
                </c:forEach>
            </select>
        </div>
        
        <div class="item">
            <button type="submit">Guardar</button>
        </div>
    </form>
</div>

<!-- Modal -->
<div class="modal fade" id="successModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">�xito</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                El m�dico se guard� correctamente.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<script>
    $(document).ready(function() {
        var successMessage = "${successMessage}";
        if (successMessage) {
            $('#successModal').modal('show');
        }
        
        // Manejar el cierre del modal con la cruz y el bot�n "Cerrar"
        $('#successModal .close, #successModal .btn-danger').on('click', function () {
            $('#successModal').modal('hide');
        });
    });
</script>

</body>
</html>
