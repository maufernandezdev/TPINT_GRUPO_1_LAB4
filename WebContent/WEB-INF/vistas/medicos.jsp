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
	      	
    	</style>
    	
    	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    	
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
	        
	        <div class="item"> 
	        	<label for="direccion">Dirección:</label>
	        	<input type="text" id="direccion" name="direccion" required><br>
	        </div>
	        
	         <div class="item"> 
		        <label for="localidad">Localidad:</label>
		        <input type="text" id="localidad" name="localidad" required><br>
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
	    		<button type="submit">Guardar</button>
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
    
</script> 

	</body>
</html>