<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Dashboard - Medicos</title>
		<style>
	        input {
	        	outline: none;
	        }
	        .container {
	        	display: flex;
	        	justify-content: center;
	        	flex-wrap: wrap;
	        	padding-bottom: 2rem;
	        	font-family: helvetica, sand-serif;
	        }
	        .container h2 {
	        	width: 100%;
	        	text-align: center;
	        }
	        
	        .container form{
		        background-color: #ccc;
		        border-radius: 8px;
		        padding: 2rem 1rem;
	        }
	        .container form {
	         	display: grid; /* Cambiamos a display grid */
			    grid-template-columns: repeat(2, 1fr); /* Definimos dos columnas de igual tamaño */
			   	grid-column-gap: 40px; /* Espacio horizontal entre las columnas */
    			grid-row-gap: 15px; /* Espacio vertical entre las filas */
	        	/* display: flex;
	        	flex-wrap: wrap;*/
	        	width: 100%;
	        	max-width: 1000px;
	        	margin: 0px auto;
	        }
	        
	         .container form input,select {
	         	padding: 8px;
	         	border-radius: 4px;	
	         	border: none;
	         	background-color: #fff;
	         	
	         }
	        .container form .item {
	        	margin-bottom: 1rem;
	        	width: 100%;
	        	display:flex;
	        	align-items: center;
	        }
	        
	        .container form .item label {
			    flex: 0 0 auto; /* El label ocupa su tamaño natural y no crece */
			    margin-right: 10px; /* Espacio entre el label y el input (opcional) */
			}

			.container form .item input, select {
			    flex: 1; /* El input se expande para llenar el espacio restante */
			    width: 100%; /* Asegura que el input ocupe todo el espacio disponible */
			    box-sizing: border-box; /* Incluye el padding y el borde en el ancho total */
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
	      	
.checkboxes-container {
    display: flex; /* Mostrar los checkboxes en línea */
    flex-wrap: wrap; /* Permitir que los checkboxes se envuelvan en varias líneas si es necesario */
}

.checkbox-label {
    margin-right: 20px; /* Espacio entre los checkboxes */
}
.btn-danger {
    background-color: #dc3545;
    color: white;
    border: none;
    padding: 5px 10px;
    cursor: pointer;
}

.btn-danger:hover {
    background-color: #c82333;
}

#horariosAgregados div {
    margin-bottom: 5px;
}
.btn-outline-danger {
    color: #dc3545;
    background-color: transparent;
    border: none;
    padding: 0;
    cursor: pointer;
    font-size: 1rem; /* Tamaño de fuente ajustable */
    width: 10% !important;
}

.btn-outline-danger:hover {
    color: #c82333;
}
    	</style>
    	
    	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    	
    	<!-- verificacion de que ambas contraseñas ingresadas sean iguales -->
    	<script>
        function validarContrasenias() {
            var contrasenia = document.getElementById("contrasenia").value;
            var repetirContrasenia = document.getElementById("repetirContrasenia").value;

            if (contrasenia !== repetirContrasenia) {
            	Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'Las contraseñas no coinciden.'
                });
                return false;
            }
            return true;
        }
    </script>
    	
    	
	</head>
	<body>
	<jsp:include page="masterPage.jsp" /> 
	
		<h1>Gestión de Medicos</h1>
	    <div id="formularioAlta" class="container">
	        <h2>Alta Médico</h2>
	   
			<form id="formAltaMedico" action="guardar_medico.html" method="post" onsubmit="return validarContrasenias()">
	  		
	  		<div class="item">
	        	<label for="nombre">Nombre:</label>
	        	<input type="text" id="nombre" name="nombre" required><br>
	  		</div>
	        
	        <div class="item">
	        	<label for="apellido">Apellido:</label>
	        	<input type="text" id="apellido" name="apellido" required><br>
	        </div>
	         <div class="item">
	       		<label for="especialidad">Seleccione su sexo:</label>
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
		        <input type="date"  name="fechaDeNac" required/>
	        </div>
	        	           
			<!-- Dropdown de Provincias -->
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
        <select id="localidadId" name="localidadId" required>
            <!-- Options se cargarán dinámicamente con JavaScript -->
        </select>
    </div> 	    
		    
		    <div class="item"> 
	        	<label for="direccion">Dirección:</label>
	        	<input type="text" id="direccion" name="direccion" required><br>
	        </div> 	
	        
	         <div class="item"> 
		        <label for="correo">Correo electrónico:</label>
		        <input type="email" id="correo" name="correo" required><br>
	         </div>
	    	
	    	 <div class="item"> 
		        <label for="telefono">Teléfono:</label>
    	    	<input type="number" id="telefono" name="telefono" required><br>
	    	 </div>    
        	
        	 <div class="item"> 
	        	<label for="usuario">Nombre de usuario:</label>
    	    	<input type="text" id="usuario" name="usuario" required><br>
        	 </div>

			<div class="item">
				<label for="contrasenia">Contraseña:</label> <input type="password"
					id="contrasenia" name="contrasenia" required><br>
			</div>

			<div class="item">
				<label for="repetirContrasenia">Repetir Contraseña:</label> <input
					type="password" id="repetirContrasenia" name="repetirContrasenia" required><br>
			</div>

			<div class="item"> 
	        	<label for="especialidad">Seleccione una especialidad:</label>
		        <select id="especialidad" name="especialidad" required>
		        	<option value="" disabled selected>especialidad</option>
			        <c:forEach items="${especialidades}" var="especialidad">
			         <option value="${especialidad.id}">${especialidad.nombre}</option>
		            </c:forEach>
		        </select>
        	 </div>
  
<div class="item">
    <label>Días de la semana:</label>
    <div class="checkboxes-container">
        <c:forEach items="${diasSemana}" var="dia">
            <label class="checkbox-label">
                <input type="checkbox" name="diasSemana" value="${dia}"> ${dia}
            </label>
        </c:forEach>
    </div>
</div>

<div class="item">
    <label for="horaInicio">Hora Inicio:</label>
    <select id="horaInicio" name="horaInicio">
        <c:forEach begin="0" end="23" var="hora">
            <c:forEach items="${minutos}" var="minuto">
                <option value="${hora}:${minuto}">${hora}:${minuto}</option>
            </c:forEach>
        </c:forEach>
    </select>
</div>

<div class="item">
    <label for="horaFin">Hora Fin:</label>
    <select id="horaFin" name="horaFin">
        <c:forEach begin="0" end="23" var="hora">
            <c:forEach items="${minutos}" var="minuto">
                <option value="${hora}:${minuto}">${hora}:${minuto}</option>
            </c:forEach>
        </c:forEach>
    </select>
</div>

    <div class="item">
        <button type="button" onclick="agregarHorario()">Agregar Horario</button>
    </div>

    <div id="listaHorarios">
        <h4>Horarios Agregados</h4>
        <div id="horariosAgregados"></div>
    </div>

    <!-- Campos ocultos para enviar horarios -->
    <div id="camposHorarios"></div>
    <!-- Se pone como input hidden para poder asignarle los horarios que se agregan o sacan -->
	            <input type="hidden" id="horarios" name="horarios"> 
	        <div class="item"> 
	    		<button type="submit" id="btnGuardar">Guardar</button>
	    	</div>
	    	
	        </form>

    
	    </div>
	   <!-- Modal Agregado -->
<div class="modal fade" id="successModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Éxito</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                El médico se guardó correctamente.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>
	   <!-- Modal UsuarioExistente -->
<div class="modal fade" id="errorModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Error</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                El usuario ingresado ya existe.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>


<script>
    
    $(document).ready(function() {
        var successMessage = "${successMessage}";
        if (successMessage) {
            $('#successModal').modal('show');
        }
        
        // Manejar el cierre del modal con la cruz y el botón "Cerrar"
        $('#successModal .close, #successModal .btn-danger').on('click', function () {
            $('#successModal').modal('hide');
        });
    });

    $(document).ready(function() {
        var errorMessage = "${errorMessage}";
        if (errorMessage) {
            $('#errorModal').modal('show');
        }
        
        $('#errorModal .close, #errorModal .btn-danger').on('click', function () {
            $('#errorModal').modal('hide');
        });
    });
    
    //Para cargar las localidades dinamicamente segun las provincias
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

    //Listener para que al cambiar provincias cambien las localidades
    document.getElementById("provinciaId").addEventListener("change", cargarLocalidades);

    //actualiza el valor de localidadId
    document.querySelector("form").addEventListener("submit", function(event) {
        var localidadId = document.getElementById("localidadId").value;
    });
    
    
    var horarios = [];
//funcion para ir agregando los horarios seleccionados a una lista temporal antes de mandarlo
//despues se procesa como json al controller
    function agregarHorario() {

        var diasSeleccionados = document.querySelectorAll('input[name="diasSemana"]:checked');
        var horaInicio = document.getElementById("horaInicio").value;
        var horaFin = document.getElementById("horaFin").value;

        if (parseHoraAMinutos(horaInicio) >= parseHoraAMinutos(horaFin)) {
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'La hora de inicio debe ser menor a la hora de fin.'
            });
            return;
        }

        diasSeleccionados.forEach(function(dia) {
            var horario = {
                dia: dia.value,
                horaInicio: horaInicio,
                horaFin: horaFin
            };

            var horarioExistente = horarios.find(h => h.dia === horario.dia);
            if (horarioExistente) {
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'El horario para ' + horario.dia + ' ya está agregado.'
                });
            } else {
                horarios.push(horario);
                actualizarListaHorarios();
            }
        });

        // Actualizar el campo oculto de horarios
        document.getElementById("horarios").value = JSON.stringify(horarios);
        console.log(document.getElementById("horarios").value);
        
        // Restablecer los selectores de horario y desmarcar los checkboxes
    // Restablecer los selectores de hora a "0:0"
    document.getElementById("horaInicio").value = "0:00";
    document.getElementById("horaFin").value = "0:00";
        diasSeleccionados.forEach((checkbox) => {
            checkbox.checked = false;
        });
    }
//Aca se actualizan los horarios por si se agregan o sacan nuevos
    function actualizarListaHorarios() {
        var contenedorHorarios = document.getElementById("horariosAgregados");
        contenedorHorarios.innerHTML = "";

        horarios.forEach(function(horario, index) {
            var div = document.createElement("div");
            div.textContent = horario.dia + " de " + horario.horaInicio + " a " + horario.horaFin;

            var botonEliminar = document.createElement("button");
            botonEliminar.innerHTML = "&times;"; // Usar el símbolo de cruz (×)
            botonEliminar.setAttribute("onclick", "eliminarHorario(" + index + ")");
            botonEliminar.classList.add("btn", "btn-outline-danger", "ml-2", "p-1");

            div.appendChild(botonEliminar);

            contenedorHorarios.appendChild(div);
        });
    }
// por si se remueven horarios de la lista ya agregada
    function eliminarHorario(index) {
        horarios.splice(index, 1); // Elimina el horario del array
        actualizarListaHorarios();

        // Actualizar el campo oculto de horarios después de eliminar
        document.getElementById("horarios").value = JSON.stringify(horarios);
        
    }

    // Función para convertir hora en formato "HH:MM" a minutos desde la medianoche
    function parseHoraAMinutos(horaStr) {
        var partesHora = horaStr.split(":");
        var horas = parseInt(partesHora[0], 10);
        var minutos = parseInt(partesHora[1], 10);
        return horas * 60 + minutos;
    }
    
    // Función para validar que se haya agregado al menos un horario antes de enviar el formulario
    function validarAntesDeGuardar() {
        if (horarios.length === 0) {
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'Debes agregar al menos un horario antes de guardar.'
            });
            return false; // Evita que el formulario se envíe
        }
        return true; // Permite que el formulario se envíe
    }
    
    // Listener para el evento click del botón de guardar
    document.getElementById("btnGuardar").addEventListener("click", function(event) {
        // Llamar a la función de validación antes de enviar el formulario
        if (!validarAntesDeGuardar()) {
            event.preventDefault(); // Evita que el formulario se envíe si la validación falla
        }
    });
</script>

	</body>
</html>