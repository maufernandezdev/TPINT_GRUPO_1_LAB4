<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
<!-- BOOTSTRAP5 -->
<link rel="stylesheet" type="text/css"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/1.11.3/css/dataTables.bootstrap5.min.css" />	
</head>
<body style="background-color: #F6F9FF">
	
	
		<!-- INICIO MAIN  -->
	<div id="main" class="main">
		<div class="container">
			<section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
				<div class="container">
					<div class="row justify-content-center">
						<div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">
							<div class="card mb-3">
								<div class="card-body">
									<div class="pt-4 pb-2">
										<h5 class="card-title text-center pb-0 fs-4">Ingrese a su cuenta</h5>
										<p class="text-center small">Ingrese su nombre de usuario y contraseña para iniciar sesión</p>
									</div>
									<form action="dashboard.html" method="post">
										<div class="col-12">
											<label for="username" class="form-label">Nombre de usuario</label>
											<div class="input-group has-validation">
												<input type="text" name="username" class="form-control" id="username" required>
											</div>
										</div>
										<div class="col-12">
											<label for="password" class="form-label">Contraseña</label>
											<input type="password" name="password" class="form-control" id="password" required>
										</div>
										<div class="col-12"></div>
										<br>
										<div class="col-12">
											<input class="btn btn-primary w-100" type="submit" value="Login">
										</div>
										<div id="errorMessage" class="col-12" style="color: red;"> <label>${error}</label> </div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
	</div>
	<!-- FIN MAIN  -->
	
	<script type="text/javascript"
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
	<script type="text/javascript"
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
	<script type="text/javascript"
		src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript"
		src="https://cdn.datatables.net/1.11.3/js/dataTables.bootstrap5.min.js"></script>
		
	<script type="text/javascript">
		// Oculto el mensaje de error después de 5 segundos
		document.addEventListener("DOMContentLoaded", function() {
			const errorMessage = document.getElementById("errorMessage");
			if (errorMessage.textContent.trim() !== "") {
				setTimeout(function() {
					errorMessage.style.display = "none";
				}, 5000);
			}
		});
	</script>
	
</body>
</html>