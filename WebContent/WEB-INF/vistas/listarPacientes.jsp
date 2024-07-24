<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Lista de Pacientes</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">
    
   
    <style>
	    .modal-dialog {
	        max-width: 800px !important;
	    }
        .container {
            padding-top: 20px;
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
</head>
<body>

<jsp:include page="masterPage.jsp" /> 

<div class="container mt-5">
    <h1 class="text-center">Gestión de Pacientes</h1>
    <h2 class="text-center">Lista de Pacientes</h2>
    
      <!-- Barra de búsqueda -->
        <form id="barraBusqueda" action="listarPaciente_xDni.html" method="post" class="mb-4">
            <div class="row">
                <div class="col-md-6">
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">Buscar por dni:</span>
                        </div>
                        <input type="text" name="txtBuscarPaciente_xDni" class="form-control" placeholder="Escribe aquí..." required >
                        <div class="input-group-append">
                        	<input type="submit" name="btnBuscarPaciente" class="btn btn-primary" value="Buscar">                            
                        </div>
                    </div>
                </div>
            </div>
        </form>      
        	<form action="listarPacientes.html" method="post">
	    <div class="row">
	        <div class="col-md-6">
	            <input type="submit" name="btnMostrarTodo" class="btn btn-secondary" value="Mostrar todo">
	        </div>
	    </div>
    </form>
    <br>
    <!-- Mensajes de éxito y error -->
    <c:if test="${not empty errorMessage}">
        <div class="error-message">${errorMessage}</div>
    </c:if>
    <c:if test="${not empty successMessage}">
        <div class="success-message">${successMessage}</div>
    </c:if>

    <c:if test="${not empty listaPacientes}">
        <table id="tablaPacientes" class="table table-striped table-bordered">
            <thead>
                <tr>
                    <th>DNI</th>
                    <th>Nombre</th>
                    <th>Apellido</th>
                    <th>Correo</th>
                    <th>Teléfono</th>
                    <th>Dirección</th>
                    <th>Provincia</th>
                    <th>Localidad</th>
                    <th>Fecha Nac</th>
                    <th>Acciones</th>
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
                        <!-- Agregado 7-5 localidad y provincia-->
                        <td>
                                <input type="hidden" value="${paciente.localidad.provincia.id_provincia}" />
                                ${paciente.localidad.provincia.nombre}
                        </td>
                        <td>
                        <input type="hidden" value="${paciente.localidad.id_localidad}" />
                        ${paciente.localidad.nombre}
                        </td>
                        <td>${paciente.fechaNac}</td>
                        <td>
                            <button type="button" class="btn btn-primary btn-sm editar-paciente" style="width: 100px;" data-toggle="modal" data-target="#modalEditar" data-dni="${paciente.dni}">Modificar</button>
                            <button type="button" class="btn btn-danger btn-sm eliminar-paciente" style="width: 100px;" data-toggle="modal" data-target="#modalEliminar" data-dni="${paciente.dni}">Eliminar</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>

        <c:if test="${empty listaPacientes}">
     <table  class="table table-striped table-bordered">
      <thead>
                <tr>
                    <th class="text-center" style="color: red;">Sin resultados.</th>
                </tr>
            </thead>
     </table>
    </c:if>
</div>

<!-- Modal de Edición -->
<div class="modal fade" id="modalEditar" tabindex="-1" role="dialog" aria-labelledby="modalEditarLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalEditarLabel">Modificar Paciente</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form id="formEditarPaciente" action="modificar_paciente.html" method="post">
                <div class="modal-body">
                    <input type="hidden" id="dniEditar" name="dni" value="">
                    <div class="form-group">
                        <label for="nombreEditar">Nombre:</label>
                        <input type="text" class="form-control" id="nombreEditar" name="nombre" required>
                    </div>
                    <div class="form-group">
                        <label for="apellidoEditar">Apellido:</label>
                        <input type="text" class="form-control" id="apellidoEditar" name="apellido" required>
                    </div>
                    <div class="form-group">
                        <label for="correoEditar">Correo electrónico:</label>
                        <input type="email" class="form-control" id="correoEditar" name="correo" required>
                    </div>
                    <div class="form-group">
                        <label for="telefonoEditar">Teléfono:</label>
                        <input type="number" class="form-control" id="telefonoEditar" name="telefono" required>
                    </div>
                    <div class="form-group">
                        <label for="direccionEditar">Dirección:</label>
                        <input type="text" class="form-control" id="direccionEditar" name="direccion" required>
                    </div>
                    <!-- Dropdown de Provincias -->
					<div class="form-group">
					    <label for="provinciaEditar">Provincia:</label>
					    <select id="provinciaEditar" name="provincia" class="form-control" required>
					        <option value="">Selecciona una provincia</option>
					        <c:forEach items="${provincias}" var="provincia">
					            <option value="${provincia.id_provincia}">${provincia.nombre}</option>
					        </c:forEach>
					    </select>
					</div>
					
					<!-- Dropdown de Localidades -->
					<div class="form-group">
					    <label for="localidadEditar">Localidad:</label>
					    <select id="localidadEditar" name="localidad" class="form-control" required>
					        <!-- Options se cargarán dinámicamente con JavaScript -->
					    </select>
					</div>
                    <div class="form-group">
                        <label for="fechaNacEditar">Fecha de Nacimiento:</label>
                        <input type="date" class="form-control" id="fechaNacEditar" name="fechaNac" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                </div>
                
            </form>
            
        </div>
    </div>
</div>

<!-- Modal de Confirmación de Eliminación -->
<div class="modal fade" id="modalEliminar" tabindex="-1" role="dialog" aria-labelledby="modalEliminarLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalEliminarLabel">Confirmar Eliminación</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>¿Está seguro que desea eliminar este paciente?</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-danger" id="confirmarEliminar">Eliminar</button>
            </div>
        </div>
    </div>
</div>

<!-- jQuery y DataTables -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
<script>
$(document).ready(function() {
    $('#tablaPacientes').DataTable({
        "searching": false,
        "lengthMenu": [5, 10, 15, 30, 60],
        "language": {
            "zeroRecords": "No se encontraron datos",
            "infoEmpty": "No hay datos para mostrar",
            "info": "Mostrando del _START_ al _END_, de un total de _TOTAL_ entradas",
            "lengthMenu": "Mostrar _MENU_ registros",
            "paginate": {
                "first": "Primeros",
                "last": "Últimos",
                "next": "Siguiente",
                "previous": "Anterior"
            }
        }
    });

    // Modal eliminar
    $('.eliminar-paciente').click(function() {
        var dni = $(this).data('dni');
        $('#confirmarEliminar').data('dni', dni);
        $('#modalEliminar').modal('show');
    });

    // Confirmar eliminar desde el modal
    $('#confirmarEliminar').click(function() {
        var dni = $(this).data('dni');
        window.location.href = "eliminar_paciente.html?dni=" + dni;
    });
    
    $('.modal button.close, .modal .btn-secondary').click(function() {
        $('.modal-backdrop').remove();
    });
    
    // Configurar el modal de edición al hacer click en Modificar
    $('.editar-paciente').click(function() {
        var dni = $(this).data('dni');
        var nombre = $(this).closest('tr').find('td:eq(1)').text();
        var apellido = $(this).closest('tr').find('td:eq(2)').text();
        var correo = $(this).closest('tr').find('td:eq(3)').text();
        var telefono = $(this).closest('tr').find('td:eq(4)').text();
        var direccion = $(this).closest('tr').find('td:eq(5)').text();
        var provinciaId = $(this).closest('tr').find('td:eq(6) input').val(); // Cambiado a ID de la provincia
        var localidadId = $(this).closest('tr').find('td:eq(7) input').val();
        var fechaNac = $(this).closest('tr').find('td:eq(8)').text();
        $('#dniEditar').val(dni);
        $('#nombreEditar').val(nombre);
        $('#apellidoEditar').val(apellido);
        $('#correoEditar').val(correo);
        $('#telefonoEditar').val(telefono);
        $('#direccionEditar').val(direccion);
        /*         $('#provinciaEditar').val(provincia);  */
        /*         $('#localidadEditar').val(localidad);  */
        $('#fechaNacEditar').val(fechaNac);
        
     // Asignar provincia y cargar localidades
        $('#provinciaEditar').val(provinciaId);
        cargarLocalidadesEditar(localidadId);
    });
});

	 //Función para cargar localidades basadas en la provincia seleccionada
	function cargarLocalidadesEditar(localidadSeleccionadaId) {
	    var provinciaId = document.getElementById("provinciaEditar").value;
	    var localidadDropdown = document.getElementById("localidadEditar");
	    localidadDropdown.innerHTML = "";  // Limpiar opciones existentes
	
	    // Mostrar solo las localidades correspondientes a la provincia seleccionada
	    <c:forEach items="${localidades}" var="localidad">
	        if ("${localidad.provincia.id_provincia}" === provinciaId) {
	            var option = document.createElement("option");
	            option.value = "${localidad.id_localidad}";
	            option.textContent = "${localidad.nombre}";
	            if ("${localidad.id_localidad}" === localidadSeleccionadaId) {
	                option.selected = true;
	            }
	            localidadDropdown.appendChild(option);
	        }
	    </c:forEach>
	
	    // Habilitar el dropdown de localidades
	    localidadDropdown.disabled = false;
	}
	
	// Cargar localidades cuando se cambia la provincia en el modal de edición
    document.getElementById("provinciaEditar").addEventListener("change", function() {
        cargarLocalidadesEditar();
    });
	//document.getElementById("provinciaEditar").addEventListener("change", cargarLocalidadesEditar);
</script>

</body>
</html>