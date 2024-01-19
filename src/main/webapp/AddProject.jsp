<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <title>Add Project</title>
  <style>
        body {
            padding-top: 56px; /* Ajuster la marge supérieure pour compenser la barre de navigation fixe */
            background: linear-gradient(135deg, #3494e6, #ec6ead); /* Dégradé de couleurs */
            background-size: cover;
            color: #fff;
        }
 .bg-lightblue {
        background-color: #D3D3D3; /* Light gray color */
    }


        .container {
            margin-top: 50px;
        }

        form {
            max-width: 400px;
            margin: auto;
            background-color: rgba(255, 255, 255, 0.9); /* Couleur de fond du formulaire (blanc semi-transparent) */
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Ombre légère */
        }

        input[type="text"] {
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
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }
            label {
        color: #000; /* Couleur du texte des labels */
    }
        
    </style>
    </head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-lightblue fixed-top">
    <a class="navbar-brand" href="Projects"><img alt="Logo" src="ehei.png"  height="30" class="d-inline-block align-top"></a>
    
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

<div class="container">
    <form action="AddProject" method="post">
        <div class="form-group">
            <label for="libelle">Libellé :</label>
            <input type="text" class="form-control" name="libelle" required>
        </div>
        <div class="form-group">
            <label for="description">Description :</label>
            <input type="text" class="form-control" name="description" required>
        </div>
        <button type="submit" class="btn btn-primary">Ajouter Projet</button>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

</body>
</html>
