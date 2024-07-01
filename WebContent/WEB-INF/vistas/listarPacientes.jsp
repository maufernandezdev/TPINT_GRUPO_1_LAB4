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
                    <th>Localidad</th>
                    <th>Provincia</th>
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
                        <td>${paciente.localidad}</td>
                        <td>${paciente.provincia}</td>
                        <td>${paciente.fechaNac}</td>
                        <td>
                            <button type="button" class="btn btn-primary btn-sm editar-paciente" data-toggle="modal" data-target="#modalEditar" data-dni="${paciente.dni}">Modificar</button>
                            <button type="button" class="btn btn-danger btn-sm eliminar-paciente" data-toggle="modal" data-target="#modalEliminar" data-dni="${paciente.dni}">Eliminar</button>
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
                    <div class="form-group">
                        <label for="localidadEditar">Localidad:</label>
                        <input type="text" class="form-control" id="localidadEditar" name="localidad" required>
                    </div>
                    <div class="form-group">
                        <label for="provinciaEditar">Provincia:</label>
                        <input type="text" class="form-control" id="provinciaEditar" name="provincia" required>
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
    // Configurar el modal de edición al hacer click en Modificar
    $('.editar-paciente').click(function() {
        var dni = $(this).data('dni');
        var nombre = $(this).closest('tr').find('td:eq(1)').text();
        var apellido = $(this).closest('tr').find('td:eq(2)').text();
        var correo = $(this).closest('tr').find('td:eq(3)').text();
        var telefono = $(this).closest('tr').find('td:eq(4)').text();
        var direccion = $(this).closest('tr').find('td:eq(5)').text();
        var localidad = $(this).closest('tr').find('td:eq(6)').text();
        var provincia = $(this).closest('tr').find('td:eq(7)').text();
        var fechaNac = $(this).closest('tr').find('td:eq(8)').text();
        $('#dniEditar').val(dni);
        $('#nombreEditar').val(nombre);
        $('#apellidoEditar').val(apellido);
        $('#correoEditar').val(correo);
        $('#telefonoEditar').val(telefono);
        $('#direccionEditar').val(direccion);
        $('#localidadEditar').val(localidad);
        $('#provinciaEditar').val(provincia);
        $('#fechaNacEditar').val(fechaNac);
    });
});
</script>

</body>
</html>