<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Lista de medicos</title>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">

<!-- jQuery y DataTables -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>

<style>
    .modal-dialog {
        max-width: 800px !important;
    }
</style>

</head>
<body>

<jsp:include page="masterPage.jsp" /> 

<h1 class="text-center">Gestión de Médicos</h1>
    <h2 class="text-center">Lista de Médicos</h2> 
<div class="container mt-3">

      <!-- Barra de búsqueda -->
        <form id="barraBusqueda" action="listarMedico_xNombre.html" method="post" class="mb-4">
            <div class="row">
                <div class="col-md-6">
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">Buscar por nombre:</span>
                        </div>
                        <input type="text" name="txtBuscarMedico_xNombre" class="form-control" placeholder="Escribe aquí..." required >
                        <div class="input-group-append">
                        	<input type="submit" name="btnBuscarMedico" class="btn btn-primary" value="Buscar">                            
                        </div>
                    </div>
                </div>
            </div>
        </form>

<div class="w-100">
    <nav class="navbar navbar-expand-sm ">
        <div class="row w-100">
            <div class="col-md-0">
                <div class="input-group form-inline">
                    <div class="input-group-prepend">
                        <span class="input-group-text">Filtrar por :</span>
                    </div>
                    <form action="listarMedico_xSexo.html" method="post" id="sexoForm" class="mr-2">
                        <select id="sexo" name="ddl_sexo" class="form-control" required onchange="document.getElementById('sexoForm').submit();">
                            <option value="" disabled selected>sexo</option>
                            <option value="M">Masculino</option>
                            <option value="F">Femenino</option>
                            <option value="O">Otro</option>
                            <option value="N">Prefiero no decirlo</option>
                        </select>
                    </form>
                    <form action="listarMedico_xEspecialidad.html" method="post" id="especialidadForm">
                        <select id="especialidad" name="ddl_especialidad" class="form-control" required onchange="document.getElementById('especialidadForm').submit();">
                            <option value="" disabled selected>especialidad</option>
                            <c:forEach items="${especialidades}" var="especialidad">
                                <option value="${especialidad.id}">${especialidad.nombre}</option>
                            </c:forEach>
                        </select>
                    </form>
                </div>
            </div>
        </div>
    </nav>
</div>

	<form action="listarMedicos.html" method="post">
	    <div class="row">
	        <div class="col-md-6">
	            <input type="submit" name="btnMostrarTodo" class="btn btn-secondary" value="Mostrar todo">
	        </div>
	    </div>
    </form>
    <br>
    
    <c:if test="${not empty listaMedicos}">
        <table id="tablaMedicos" class="table table-striped table-bordered ">
            <thead>
                <tr>
                    <th>Legajo</th>
                    <th>Nombre</th>
                    <th>Apellido</th>
                    <th>Especialidad</th>
                    <th>Sexo</th>
                    <th>Correo</th>
                    <th>Teléfono</th>
                    <th>Dirección</th>
                    <th>Localidad</th>
                    <th>Fecha de nacimiento</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${listaMedicos}" var="medico">
                    <tr>
                        <td>${medico.legajo}</td>
                        <td>${medico.nombre}</td>
                        <td>${medico.apellido}</td>
                        <td>
                        	${medico.especialidad.nombre}
                        	<input value="${medico.especialidad.id}" hidden />
                        </td>
                        <td>${medico.sexo}</td>
                        <td>${medico.correo}</td>
                        <td>${medico.telefono}</td>
                        <td>${medico.direccion}</td>
                        <td>${medico.localidad}</td>
                        <td>${medico.fechaNac}</td>
                        <!--  
                        <td style="visibility: hidden;">${medico.especialidad.id}</td>
                         -->
                        <td>
							<button type="button" class="btn btn-primary btn-sm editar-medico" style="width: 100px;" data-toggle="modal" data-target="#modalEditar" 
								data-legajo="${medico.legajo}">Modificar</button>
							<button type="button" class="btn btn-danger btn-sm eliminar-medico" style="width: 100px;" data-toggle="modal" data-target="#modalEliminar"
							 	data-legajo2="${medico.legajo}">Eliminar</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
    <c:if test="${empty listaMedicos}">
     <table  class="table table-striped table-bordered">
      <thead>
                <tr>
                    <th class="text-center" style="color: red;">No hay Medicos cargados en el sistema</th>
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
                <h5 class="modal-title" id="modalEditarLabel">Modificar Medico</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form id="formEditarMedico" action="modificar_medico.html" method="post">
                <div class="modal-body">
                <input type="hidden" id="legajoEditar" name="legajo" value="1">
                    <div class="form-group">
                        <label for="nombreEditar">Nombre:</label>
                        <input type="text" class="form-control" id="nombreEditar" name="nombre" required>
                    </div>
                    <div class="form-group">
                        <label for="apellidoEditar">Apellido:</label>
                        <input type="text" class="form-control" id="apellidoEditar" name="apellido" required>
                    </div>
                    
                    <!-- 
                    <div class="form-group">
                        <label for="especialidadEditar">Especialidad:</label>
                        <input type="text" class="form-control" id="especialidadEditar" name="especialidad" required>
                    </div>
                     -->
                    
                    <div class="form-group"> 
			        	<label for="especialidadEditar">Seleccione una especialidad:</label>
				        <select id="especialidadEditar" name="especialidad" class="form-control" required>
				        	<option value="" disabled selected>especialidad</option>
					        <c:forEach items="${especialidades}" var="especialidad">
					         <option value="${especialidad.id}">${especialidad.nombre}</option>
				            </c:forEach>
				        </select>
		        	 </div>
		        	 
                    <div class=form-group>
			       		<label for="sexoEditar">Seleccione su sexo:</label>
			       		<select id="sexoEditar" name="sexo" class="form-control" required>
			            <option value="" disabled selected>sexo</option>
			            <option value="M">Masculino</option>
			            <option value="F">Femenino</option>
			            <option value="O">Otro</option>
			            <option value="N">Prefiero no decirlo</option>
			        	</select>
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
                    <div class="form-group">
                        <label for="localidadEditar">Localidad:</label>
                        <input type="text" class="form-control" id="localidadEditar" name="localidad" required>
                    </div>
                    <div class="form-group">
                        <label for="fechaNacEditar">Fecha de Nacimiento:</label>
                        <input type="date" class="form-control" id="fechaNacEditar" name="fechaNac" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary modificar-medico">Guardar Cambios</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal de Eliminar -->
<div class="modal fade" id="modalEliminar" tabindex="-1" role="dialog" aria-labelledby="modalEliminarLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalEliminarLabel">¿Estas seguro de eliminar al Medico?</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" id="confirmarEliminarMedico">Eliminar</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                </div>
        </div>
    </div>
</div>


<!-- 
<div class="modal fade" id="modalModificar" tabindex="-1" role="dialog" aria-labelledby="modalModificarLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" th:text="${successMessage != null ? successMessage : errorMessage}"></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </div>
    </div>
</div>
--> 

<script>
	$(document).ready(function() {
	    $('#tablaMedicos').DataTable({
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
	    

	    
	});
	
    $('.editar-medico').click(function() {
        var legajo = $(this).data('legajo');
        var nombre = $(this).closest('tr').find('td:eq(1)').text();
        var apellido = $(this).closest('tr').find('td:eq(2)').text();
        var especialidad = $(this).closest('tr').find('td:eq(3)').text();
        var idEspecialidad = $(this).closest('tr').find('td:eq(3) input').val();
        var sexo = $(this).closest('tr').find('td:eq(4)').text();
        var correo = $(this).closest('tr').find('td:eq(5)').text();
        var telefono = $(this).closest('tr').find('td:eq(6)').text();
        var direccion = $(this).closest('tr').find('td:eq(7)').text();
        var localidad = $(this).closest('tr').find('td:eq(8)').text();
        var fechaNac = $(this).closest('tr').find('td:eq(9)').text();
        // var idEspecialidadText = $(this).closest('tr').find('td:eq(10)').text();
        idEspecialidad = parseInt(idEspecialidad, 10);
        console.log("legajo: ", legajo);
        console.log("nombre: ", nombre);
        console.log("apellido: ", apellido);
        console.log("correo: ", correo);

        $('#legajoEditar').val(legajo);
        $('#nombreEditar').val(nombre);
        $('#apellidoEditar').val(apellido);
        $('#especialidadEditar').val(idEspecialidad);
        $('#sexoEditar').val(sexo);
        $('#correoEditar').val(correo);
        $('#telefonoEditar').val(telefono);
        $('#direccionEditar').val(direccion);
        $('#localidadEditar').val(localidad);
        $('#fechaNacEditar').val(fechaNac);
        $('#modalEditar').modal('show');
    });
    
    $('.eliminar-medico').click(function() {	
        var legajo = $(this).data('legajo2');
        legajo = parseInt(legajo); 
    
        $('#confirmarEliminarMedico').data('legajo', legajo);
        $('#modalEliminar').modal('show');
    });
    
    // confirmar eliminar desde el modal
    $('#confirmarEliminarMedico').click(function() {
        var legajo = $(this).data('legajo');
        window.location.href = "eliminar_medico.html?legajo=" + legajo;
    });
    
    // modificar medico
    // $('.modificar-medico').click(function() {	
    //    $('#modalModificar').modal('show');
    // });
	
	
</script>
</body>
</html>