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
                <label for="paciente">Seleccione un Paciente:</label>
                <select id="paciente" name="paciente" class="form-control" required>
                    <option value="" disabled selected>Seleccione un Paciente</option>
                    <c:forEach items="${pacientes}" var="paciente">
                        <option value="${paciente.dni}">${paciente.nombre} ${paciente.apellido} (Dni.${paciente.dni})</option>
                    </c:forEach>
                </select>
            </div>
            
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
                        <option value="${medico.legajo}">${medico.nombre} ${medico.apellido} (Leg.${medico.legajo})</option>
                    </c:forEach>
			    </select>
            </div>
          
            <div class="form-group">
                <label for="fecha">Seleccione la Fecha:</label>
                <input type="date" id="fecha" name="fecha" class="form-control" required>
                 <div class="invalid-feedback">El medico no trabaja el dia seleccionado.</div>
            </div>

            <div class="form-group">
                <label for="horario">Seleccione el Horario:</label>
                <select id="horario" name="horario" class="form-control" required>
                    <option value="" disabled selected>Seleccione un Horario</option>
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
    console.log("allMedicos: ", allMedicos);
    $(document).ready(function() {
        var successMessage = "${successMessage}";
        var errorMessage = "${errorMessage}";
        
        if (successMessage || errorMessage) {
            $('#messageModal').modal('show');
        }
        
        // Manejar el cierre del modal con la cruz y el botón "Cerrar"
        $('#messageModal .close, #messageModal .btn-danger').on('click', function () {
            $('#messageModal').modal('hide');
            
        });
    });
    
    document.addEventListener('DOMContentLoaded', (event) => {
        var especialidadSelect = document.getElementById('especialidad');
        especialidadSelect.addEventListener('change', filtrarMedicos);
        
        var medicoSelect = document.getElementById('medico');
        medicoSelect.addEventListener('change', seleccionarEspecialidad);
    });
    
    function seleccionarEspecialidad() {
        var medicoId = document.getElementById('medico').value;
        var especialidadSelect = document.getElementById('especialidad');
        var selectedMedico = allMedicos.find(medico => medico.id == medicoId);

        if (selectedMedico) {
            especialidadSelect.value = selectedMedico.id_especialidad;
        }
    }
    
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
            option.text = medico.nombre + ' ' + medico.apellido + ' (Leg.'+ medico.id+')';
            medicoSelect.appendChild(option);
        });
    }
</script>
 <script>
		
		 function parseTime(timeString) {
		     const [hours, minutes, seconds] = timeString.split(":").map(Number);
		     const time = new Date();
		     time.setHours(hours, minutes, seconds, 0);
		     return time;
		 }
		
		 function formatTime(time) {
		     const hours = String(time.getHours()).padStart(2, '0');
		     const minutes = String(time.getMinutes()).padStart(2, '0');
		     const seconds = String(time.getSeconds()).padStart(2, '0');
		     const res = hours + ':' + minutes + ':' + seconds;
		     return res;
		 }
		 
		 function generateHorarios(horaInicio, horaFin, medicoId) {
		        const select = document.getElementById("horario");
		        select.innerHTML = '<option value="" disabled selected>Seleccione un Horario</option>';
		        const startTime = parseTime(horaInicio);
		        const endTime = parseTime(horaFin);
				const turnos = allTurnos.filter((turno)=> Number(turno.id_medico) === Number(medicoId));
		        for (let time = startTime; time <= endTime; time.setHours(time.getHours() + 1)) {
		        	const timeToAdd = formatTime(time);
		        	const exists = turnos.some(turno => turno.hora === timeToAdd);
		        	if(!exists){
		        		const option = document.createElement("option");
			            option.value = timeToAdd;
			            option.text = timeToAdd;
			            select.appendChild(option);	
		        	}
		        }
		}
        document.getElementById('fecha').addEventListener('input', function (event) {
            
            const input = event.target;
            const dateValue = new Date(input.value);
            const today = new Date();
            today.setHours(0, 0, 0, 0);

            if (dateValue < today) {
                input.value = ''; 
                input.classList.add('is-invalid');
                input.classList.remove('is-valid');
                input.nextElementSibling.textContent = 'No se puede seleccionar una fecha pasada.';
                input.nextElementSibling.style.display = 'block';
                return;
            }
            
            let diaDeLaSemana = dateValue.getUTCDay();
            if (diaDeLaSemana === 0) {
            	diaDeLaSemana = 7; // el getUTCday tra en 0 al domingo por eso si es dom se cambia a 7 para mantener
                				// la estructura
            }
            const dayOfWeek = diaDeLaSemana;

            const medicoId = document.getElementById("medico").value;
       	 	const doctorBusinessDays = allHorarios.filter((horario)=> Number(horario.id_medico) === Number(medicoId));
       	 	
       	 	console.log("doctorBusinessDays",doctorBusinessDays)
       	 	
       	 	const days = ["Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo"];
       	 	const businessDaysIds = doctorBusinessDays.map(day => days.indexOf(day.dia) + 1);
       	 	
       	 	console.log("businessDaysIds",businessDaysIds)
       	 	console.log("dayOfWeek", dayOfWeek);
       		const isBusinessDay = businessDaysIds.includes(dayOfWeek);
       		
       		console.log("isBusinessDay",isBusinessDay)
       	 	
            if (!isBusinessDay) {
                input.value = ''; 
                input.classList.add('is-invalid');
                input.classList.remove('is-valid');
                input.nextElementSibling.style.display = 'block';
            } else {
                input.classList.add('is-valid');
                input.classList.remove('is-invalid');
                input.nextElementSibling.style.display = 'none';
                const selectedDay = doctorBusinessDays.find(day => days.indexOf(day.dia) + 1 === dayOfWeek);
                generateHorarios(selectedDay.horaInicio, selectedDay.horaFin, medicoId);
            }
        });
</script>
<script>
/*Cargar de horarios y turnos en el front*/
 const allHorarios = [
        <c:forEach items="${horarios}" var="horario">
            {
                id: "${horario.id}",
                dia: "${horario.dia}",
                horaInicio: "${horario.horaInicio}",
                horaFin: "${horario.horaFin}",
                id_medico: "${horario.medico.legajo}",
            },
        </c:forEach>];
 
 const allTurnos = [
     <c:forEach items="${turnos}" var="turno">
         {
        	 idTurno: "${turno.idTurno}",
             estado: "${turno.estado}",
             fecha: "${turno.fecha}",
             hora: "${turno.hora}",
             observacion: "${turno.observacion}",
             id_medico: "${turno.medico.legajo}",
             dni_paciente: "${turno.paciente.dni}",
         },
     </c:forEach>];
 
 console.log("allHorarios: ", allHorarios);
 console.log("allTurnos: ", allTurnos);
 
 </script>
</body>
</html>
