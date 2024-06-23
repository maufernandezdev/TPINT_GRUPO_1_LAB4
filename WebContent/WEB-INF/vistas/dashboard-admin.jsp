<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Dashboard Administradores</title>
    <style>
 
        .nav {
            background-color: #f3f3f3;
            padding: 10px;
        }
        .nav ul {
            list-style-type: none;
            padding: 0;
        }
        .nav li {
            display: inline;
            margin-right: 10px;
        }
        .nav a {
            text-decoration: none;
            color: #000;
        }
    </style>
    <script>
        function loadPage(page) {
            var xhr = new XMLHttpRequest();
            xhr.open('GET', page, true);
            xhr.onreadystatechange = function() {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    document.getElementById('content').innerHTML = xhr.responseText;
                }
            };
            xhr.send();
        }
    </script>
</head>
<body>
    <h1>Dashboard Administradores</h1>
    <h2>Bienvenido ${user}!</h2>
    
    <div class="nav">
        <ul>
            <li><a href="#" onclick="loadPage('pacientes.jsp')">Pacientes</a></li>
            <li><a href="#" onclick="loadPage('medicos.jsp')">Médicos</a></li>
            <li><a href="#" onclick="loadPage('asignacionTurnos.jsp')">Asignación de Turnos</a></li>
            <li><a href="#" onclick="loadPage('informes.jsp')">Informes</a></li>
        </ul>
    </div>
    
    <div id="content">
       
    </div>
</body>
</html>