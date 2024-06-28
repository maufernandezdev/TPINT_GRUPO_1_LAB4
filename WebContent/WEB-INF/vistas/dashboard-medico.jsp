<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Dashboard Médicos</title>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var links = document.querySelectorAll('.nav ul li a');
            links.forEach(function(link) {
                link.addEventListener('click', function() {
                    links.forEach(function(link) {
                        link.classList.remove('selected');
                    });
                    this.classList.add('selected');
                });
            });
        });
    </script>
    <style>
        .nav ul li a {
            text-decoration: none;
            color: black;
        }
        .nav ul li a.selected {
            text-decoration: underline;
            color: #0066cc;
        }
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
</head>
<body>

	<jsp:include page="masterPage.jsp" /> 

    <div class="container mt-5">
        <h1>Dashboard Médicos</h1>
        <h2>Bienvenido ${user}!</h2>
    </div>

</body>
</html>
