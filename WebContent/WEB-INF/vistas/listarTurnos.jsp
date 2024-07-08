<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Medico - Listado de turnos</title>

</head>
<body>
<jsp:include page="masterPage.jsp" /> 

    <c:if test="${tipoUsuario == 'ADMINISTRADOR'}">
	    <h1 class="text-center">Listado de Turnos</h1>
	</c:if>
<div class="container mt-5">
 	<c:if test="${tipoUsuario == 'MEDICO'}">
	    <h1 class="text-center">Gestión de Turnos</h1>
	    <h2 class="text-center">Mis turnos asignados</h2>
	</c:if>
    
      <!-- Barra de búsqueda -->
        <form id="barraBusqueda" action="listarTurno_xDni.html" method="post" class="mb-4">
            <div class="row">
                <div class="col-md-6">
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">Buscar por dni:</span>
                        </div>
                        <input type="number" name="txtBuscarTurno_xDni" class="form-control" placeholder="Escribe aquí..." required >
                        <div class="input-group-append">
                        	<input type="submit" name="btnBuscarTurno" class="btn btn-primary" value="Buscar"> 

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
                    <form action="filtrarTurnos_xMedico.html" method="post" id="medicoForm">
                        <select id="medico" name="ddl_medico" class="form-control" required 
                                onchange="document.getElementById('medicoForm').submit();">
                            <option value="" disabled selected>Medico</option>
                            <c:forEach items="${medicos}" var="medico">
                                <option value="${medico.legajo}">${medico.nombre} ${medico.apellido}</option>
                            </c:forEach>
                        </select>
                    </form>
                    <form action="filtrarTurnos_xEstadoTurno.html" method="post" id="EstadoTurnoForm" class="mr-2">
                        <select id="estadoTurno" name="ddl_EstadoTurno" class="form-control" required 
                                onchange="document.getElementById('EstadoTurnoForm').submit();">
                            <option value="" disabled selected>Estado Turno</option>
                            <option value="PENDIENTE">PENDIENTE</option>
                            <option value="PRESENTE">PRESENTE</option>
                            <option value="AUSENTE">AUSENTE</option>
                        </select>
                    </form>
                </div>
            </div>
        </div>
    </nav>
</div>

	<form action="listarTurnos.html" method="post">
	    <div class="row">
	        <div class="col-md-6">
	            <input type="submit" name="btnMostrarTodo" class="btn btn-secondary" value="Mostrar todo">
	        </div>
	    </div>
    </form>
    <br>
        
    <c:if test="${not empty listaTurnos}">
        <table id="tablaTurnos" class="table table-striped table-bordered">
            <thead>
                <tr>
                    <th>Médico</th>
                    <th>Paciente</th>
					<th>Dni</th>
                    <th>Fecha</th>
                    <th>Hora</th>
                    <th>Estado</th>
                    <c:if test="${tipoUsuario == 'MEDICO'}">
                    	<th>Acción</th>
		            </c:if>
                </tr>
            </thead>
            
            <tbody>
                <c:forEach items="${listaTurnos}" var="turno">
                    <tr>
                        <td>${turno.medico.apellido} ${turno.medico.nombre}</td>
                        <td>${turno.paciente.apellido} ${turno.paciente.nombre}</td>
                        <td>${turno.paciente.dni}</td>
                        <td>${turno.fecha}</td>
                        <td>${turno.hora}</td>
						<td>${turno.estadoTurno == 'AUSENTE' ? 'AUSENTE' : turno.estadoTurno == 'PRESENTE' ? 'PRESENTE' : turno.estadoTurno == 'PENDIENTE' ? 'PENDIENTE' : '-'}</td>
                        <c:if test="${tipoUsuario == 'MEDICO'}">
                    	<td >
                            <c:choose>
                                <c:when test="${turno.estadoTurno != 'AUSENTE' && turno.estadoTurno != 'PRESENTE'}">
                                    <!-- Formulario para marcar como AUSENTE -->
                                    <form id="ausenteForm_${turno.idTurno}" action="marcarAusente.html" method="post" style="display:inline;">
                                        <input type="hidden" name="idTurno" value="${turno.idTurno}" />
                                        <button type="button" class="btn btn-danger" onclick="openConfirmModal(${turno.idTurno})">Marcar AUSENTE</button>
                                    </form>
                                    <!-- Botón para marcar como PRESENTE -->
                                    <button type="button" class="btn btn-success btn-sm" onclick="openModal(${turno.idTurno})">Marcar PRESENTE</button>
                                </c:when>
                                <c:otherwise>
                                    <span>-</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
		            	</c:if>
                        
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
        <c:if test="${empty listaTurnos}">
     <table  class="table table-striped table-bordered">
      <thead>
                <tr>
                    <th class="text-center" style="color: red;">No hay turnos asignados.</th>
                </tr>
            </thead>
     </table>
    </c:if>
</div>
<!-- Modal para observaciones -->
<div class="modal fade" id="observacionModal" tabindex="-1" role="dialog" aria-labelledby="observacionModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="observacionModalLabel">Observaciones</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="observacionForm" action="marcarPresente.html" method="post">
                    <input type="hidden" name="idTurno" id="idTurnoInput" />
                    <div class="form-group">
                        <label for="observaciones">Observaciones:</label>
                        <textarea class="form-control" id="observaciones" name="observaciones" rows="3" required></textarea>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-primary">Guardar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- Modal de Confirmación -->
<div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" aria-labelledby="confirmModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmModalLabel">Confirmar Acción</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>¿Está seguro de que desea marcar este turno como ausente?</p>
            </div>
            <div class="modal-footer">
                <form id="ausenteForm" action="marcarAusente.html" method="post">
                    <input type="hidden" id="ausenteIdTurno" name="idTurno">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                    <button type="submit" class="btn btn-primary">Guardar</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>


$(document).ready(function() {
    $('#tablaTurnos').DataTable({
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



    function openModal(idTurno) {
        $('#idTurnoInput').val(idTurno);
        $('#observacionModal').modal('show');
    }
    
    function openConfirmModal(idTurno) {
        document.getElementById('ausenteIdTurno').value = idTurno;
        $('#confirmModal').modal('show');
    }
    
    $(document).ready(function() {
        // Oculto modal
        $('#observacionModal .close, #observacionModal .btn-secondary').on('click', function() {
            $('#observacionModal').modal('hide');
        });
    });
    
    $(document).ready(function() {
        // Oculto modal
        $('#confirmModal .close, #confirmModal .btn-secondary').on('click', function() {
            $('#confirmModal').modal('hide');
        });
    });
</script>
</body>
</html>