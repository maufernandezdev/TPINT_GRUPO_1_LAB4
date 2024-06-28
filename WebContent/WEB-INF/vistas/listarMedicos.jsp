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

<div class="container mt-5">
    <h1 class="text-center">Gestión de medicos</h1>
    <h2 class="text-center">Lista de medicos</h2>
    
    <c:if test="${not empty listaMedicos}">
        <table id="tablaMedicos" class="table table-striped table-bordered">
            <thead>
                <tr>
                    <th>Legajo</th>
                    <th>Nombre</th>
                    <th>Apellido</th>
                    <th>Correo</th>
                    <th>Teléfono</th>
                    <th>Dirección</th>
                    <th>Localidad</th>
                    <th>Fecha de nacimiento</th>
                    <th>estado</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${listaMedicos}" var="medico">
                    <tr>
                        <td>${medico.legajo}</td>
                        <td>${medico.nombre}</td>
                        <td>${medico.apellido}</td>
                        <td>${medico.correo}</td>
                        <td>${medico.telefono}</td>
                        <td>${medico.direccion}</td>
                        <td>${medico.localidad}</td>
                        <td>${medico.fechaNac}</td>
                        <td>${medico.estado}</td>
                        <td>
							<button type="button" class="btn btn-primary btn-sm editar-medico" data-toggle="modal" data-target="#modalEditar" data-legajo="${medico.legajo}">Modificar</button>
							<button type="button" class="btn btn-danger btn-sm">Eliminar</button>
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
                    <div class="form-group">
                        <label for="correoEditar">Correo electrónico:</label>
                        <input type="email" class="form-control" id="correoEditar" name="correo" required>
                    </div>
                    <div class="form-group">
                        <label for="telefonoEditar">Teléfono:</label>
                        <input type="text" class="form-control" id="telefonoEditar" name="telefono" required>
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
                    <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                </div>
            </form>
        </div>
    </div>
</div>

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
	    
	    $('.editar-medico').click(function() {
	        var legajo = $(this).data('legajo');
	        var nombre = $(this).closest('tr').find('td:eq(1)').text();
	        var apellido = $(this).closest('tr').find('td:eq(2)').text();
	        var correo = $(this).closest('tr').find('td:eq(3)').text();
	        var telefono = $(this).closest('tr').find('td:eq(4)').text();
	        var direccion = $(this).closest('tr').find('td:eq(5)').text();
	        var localidad = $(this).closest('tr').find('td:eq(6)').text();
	        var fechaNac = $(this).closest('tr').find('td:eq(7)').text();
	        
	        console.log("legajo: ", legajo);
	        console.log("nombre: ", nombre);
	        console.log("apellido: ", apellido);
	        console.log("correo: ", correo);
	
	        $('#legajoEditar').val(legajo);
	        $('#nombreEditar').val(nombre);
	        $('#apellidoEditar').val(apellido);
	        $('#correoEditar').val(correo);
	        $('#telefonoEditar').val(telefono);
	        $('#direccionEditar').val(direccion);
	        $('#localidadEditar').val(localidad);
	        $('#fechaNacEditar').val(fechaNac);
	        $('#modalEditar').modal('show');
	    });
	});
</script>
</body>
</html>