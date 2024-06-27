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
    <h1 class="text-center">Gestión de Pacientes</h1>
    <h2 class="text-center">Lista de Pacientes</h2>
    
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
                            <button type="button" class="btn btn-danger btn-sm">Eliminar</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
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

        $('#modalEditar').modal('show');
    });
});
</script>

</body>
</html>