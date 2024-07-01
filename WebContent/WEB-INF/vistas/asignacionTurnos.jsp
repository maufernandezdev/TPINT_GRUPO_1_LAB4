<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Asignación de Turnos</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        .container {
            margin-top: 2rem;
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        .form-container {
            max-width: 600px;
            margin: 0 auto;
            padding: 2rem;
            background-color: #f9f9f9;
            border-radius: 8px;
        }
        .btn-submit {
            width: 100%;
        }
    </style>

</head>
<body>

<jsp:include page="masterPage.jsp" /> 

<div class="container">
    <h1 class="text-center">Asignación de Turnos</h1>
    <div class="form-container">
        <form action="guardar_turno.html" method="post">
			<div class="form-group">
			    <label for="especialidad">Seleccione una Especialidad:</label>
				<select id="especialidad" name="especialidad" class="form-control" onchange="filtrarMedicos()" required>
				    <option value="" disabled selected>Seleccione una Especialidad</option>
				    <c:forEach items="${especialidades}" var="especialidad">
				        <option value="${especialidad.id}">${especialidad.nombre}</option>
				    </c:forEach>
				</select>
			</div>
            <div class="form-group">
                <label for="medico">Seleccione un Médico:</label>
			    <select id="medico" name="medico" class="form-control" required>
			        <option value="" disabled selected>Seleccione un Médico</option>
			         <c:forEach items="${medicos}" var="medico">
							<option value="${medico.legajo}">${medico.nombre} ${medico.apellido}</option>
						</c:forEach>
			    </select>
            </div>
            <div class="form-group">
                <label for="paciente">Seleccione un Paciente:</label>
                <select id="paciente" name="paciente" class="form-control" required>
                    <option value="" disabled selected>Seleccione un Paciente</option>
                    <c:forEach items="${pacientes}" var="paciente">
                        <option value="${paciente.dni}">${paciente.nombre} ${paciente.apellido}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label for="fecha">Seleccione la Fecha:</label>
                <input type="date" id="fecha" name="fecha" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="horario">Seleccione el Horario:</label>
                <select id="horario" name="horario" class="form-control" required>
                    <option value="" disabled selected>Seleccione un Horario</option>
					<c:forEach var="hora" begin="8" end="20">
					        <option value="${hora}:00">${hora}:00</option>
					    </c:forEach>
                    <option value="20:00">20:00</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary btn-submit">Asignar Turno</button>
        </form>
    </div>
</div>
<!-- Modal -->
<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Mensaje</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <c:choose>
                    <c:when test="${not empty successMessage}">
                        ${successMessage}
                    </c:when>
                    <c:when test="${not empty errorMessage}">
                        ${errorMessage}
                    </c:when>
                </c:choose>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

<script>
    var allMedicos = [
        <c:forEach items="${medicos}" var="medico">
            {
                id: "${medico.legajo}",
                nombre: "${medico.nombre}",
                apellido: "${medico.apellido}",
                id_especialidad: "${medico.especialidad.id}"
            },
        </c:forEach>
    ];
    
    $(document).ready(function() {
        var successMessage = "${successMessage}";
        var errorMessage = "${errorMessage}";
        
        if (successMessage || errorMessage) {
            $('#messageModal').modal('show');
        }
        
        // Manejar el cierre del modal con la cruz y el botón "Cerrar"
        $('#messageModal .close, #messageModal .btn-danger').on('click', function () {
            $('#messageModal').modal('hide');
            
            window.location.href = "asignacionTurnos.html";

        });
    });
    
    document.addEventListener('DOMContentLoaded', (event) => {
        var especialidadSelect = document.getElementById('especialidad');
        especialidadSelect.addEventListener('change', filtrarMedicos);
    });
    
    function filtrarMedicos() {
        var especialidadId = document.getElementById('especialidad').value;
        var medicoSelect = document.getElementById('medico');
        medicoSelect.innerHTML = '<option value="" disabled selected>Seleccione un Médico</option>';
    
        var filteredMedicos = allMedicos.filter(function(medico) {
            return medico.id_especialidad == especialidadId;
        });
    
        filteredMedicos.forEach(function(medico) {
            var option = document.createElement('option');
            option.value = medico.id;
            option.text = medico.nombre + ' ' + medico.apellido;
            medicoSelect.appendChild(option);
        });
    }
</script>

</body>
</html>
