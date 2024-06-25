<head>
	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
	
	<!-- jQuery library -->
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
	
	<!-- Popper JS -->
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>	
	
	
    <link rel="stylesheet" href="https://unpkg.com/bootstrap-table@1.21.1/dist/bootstrap-table.min.css"/>
    <script src="https://cdn.jsdelivr.net/npm/jquery/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/bootstrap-table@1.21.1/dist/bootstrap-table.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.1.js" integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI=" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css">
    <script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js" ></script>
</head>

<div class="w-100">
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
	  <a class="navbar-brand" href="#">Consultorio</a>
	  <ul class="navbar-nav w-100">
	  	   <li class="nav-item dropdown">
		      <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">Médicos</a>
		      <div class="dropdown-menu">
		        <a class="dropdown-item" href="medicos.html" >Alta Médico</a>
		        <a class="dropdown-item" >Baja Médico</a>

		        <a class="dropdown-item" >Modificar Médico</a>
		        <a class="dropdown-item" >Listado Médico</a>

		      </div>
		   </li>
		   
		    <li class="nav-item dropdown">
		      <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">Pacientes</a>
		      <div class="dropdown-menu">
		        <a class="dropdown-item" >Alta Paciente</a>
		        <a class="dropdown-item" >Baja Paciente</a>
		        <a class="dropdown-item" >Modificacion Paciente</a>
		        <a class="dropdown-item" href="listarPacientes.html" >Listado Paciente</a>
		      </div>
		    </li>
		    <li class="nav-item">
		      <a class="nav-link" >Asignación de Turnos</a>
		    </li>
		    <li class="nav-item">
		      <a class="nav-link" >Informes y/o Reportes</a>
		    </li>
		
			<li class="mt-0 mr-0 mb-0 ml-auto d-flex align-items-center" style="gap: 1rem;">
				<span style="color: white;">Usuario Admin</span>
				<a class="btn btn-danger" href="dashboard-admin.html" > Cerrar sesion</a>
			</li>
	  </ul>
	</nav>
</div>