
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="db.Tache" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <title>Update Task</title>
    <style>
        body {
            background-color: rgb(230, 230, 230); /* Couleur de fond RGB */
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
        }

        nav {
            background-color: #343a40; /* Couleur de fond de la barre de navigation */
        }

        .navbar-brand, .nav-link {
            color: #fff !important; /* Couleur du texte de la barre de navigation */
        }

        form {
            max-width: 600px;
            margin: 50px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        textarea, input[type="date"], input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        input[type="submit"] {
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<% if(!request.getAttribute("tache").equals(null)) {%>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
            <a class="navbar-brand" href="Projects">Votre Logo</a>
    
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item active">
                <a class="nav-link" href="Projects"><i class="fas fa-home"></i> Accueil</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href=""><i class="fas fa-user"></i> Hello <%= session.getAttribute("login") %></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="AddProject"><i class="fas fa-plus"></i> Ajouter Projet</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="Logout"><i class="fas fa-sign-out-alt"></i> Déconnexion</a>
            </li>
        </ul>
    </div>
    </nav>
    <br><br><br>
    <div class="container">
        <% Tache tache = (Tache)request.getAttribute("tache"); %>
        <form action="ModifierTache" method="post">
            <input type="hidden" name="idTache" value="<%=tache.getId()%>">
            <div class="form-group">
                <label for="description">Description :</label>
                <textarea class="form-control" name="description"><%=tache.getDescription()%></textarea>
            </div>
            <div class="form-group">
                <label for="dateDebut">Date Debut :</label>
                <input class="form-control" type="date" name="dateDebut" value="<%=tache.getDateDebut()%>">
            </div>
            <div class="form-group">
                <label for="dateFin">Date Fin :</label>
                <input class="form-control" type="date" name="dateFin" value="<%=tache.getDateFin()%>">
            </div>
            <button class="btn btn-primary" type="submit">Modifier la tache</button>
        </form>
    </div>
<%} %>

</body>
</html>
