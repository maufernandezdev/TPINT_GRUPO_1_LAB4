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
	</head>
	<body>
		<h1>Gestión de Medicos</h1>
	    <div id="formularioAlta" class="container">
	        <h2>Alta Paciente</h2>
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
		        <input type="date"  name="fechaDeNac"/>
	        </div>
	        
	        <div class="item"> 
	        	<label for="direccion">Dirección:</label>
	        	<input type="text" id="direccion" name="direccion"><br>
	        </div>
	        
	         <div class="item"> 
		        <label for="localidad">Localidad:</label>
		        <input type="text" id="localidad" name="localidad"><br>
	         </div>
	        
	         <div class="item"> 
		        <label for="correo">Correo electrónico:</label>
		        <input type="email" id="correo" name="correo"><br>
	         </div>
	    	
	    	 <div class="item"> 
		        <label for="telefono">Teléfono:</label>
    	    	<input type="text" id="telefono" name="telefono"><br>
	    	 </div>    
        	
        	 <div class="item"> 
	        	<label for="usuario">Nombre de usuario:</label>
    	    	<input type="text" id="usuario" name="usuario"><br>
        	 </div>
        	
        	 <div class="item"> 
	        	<label for="contrasenia">Contraseña:</label>
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
	</body>
</html>