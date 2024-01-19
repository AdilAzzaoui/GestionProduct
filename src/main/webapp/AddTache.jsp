<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Add Task</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            padding-top: 80px;
            background-color: #f8f9fa;
        }
         .bg-lightblue {
        background-color: #D3D3D3; /* Light gray color */
    }
        .navbar {
            background-color: #343a40;
        }
        .navbar-brand {
            color: #ffffff;
            font-weight: bold;
        }
        .navbar-dark .navbar-toggler-icon {
            background-color: #ffffff;
        }
        .navbar-nav .nav-link {
            color: #ffffff;
            margin-right: 10px;
        }
        form {
            max-width: 600px;
            margin: 0 auto;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        textarea, input, select {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            box-sizing: border-box;
        }
        select {
            height: 40px;
        }
        input[type="submit"] {
            background-color: #007bff;
            color: #ffffff;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <%int idProject = Integer.parseInt(request.getParameter("idProject")); %>
    <nav class="navbar navbar-expand-lg bg-lightblue fixed-top">
        <a class="navbar-brand" href="Projects"><img alt="Logo" src="ehei.png"  height="30" class="d-inline-block align-top"></a>
        
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="Projects"><i class="fas fa-home"></i> Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href=""><i class="fas fa-user"></i> Hello <%= session.getAttribute("login") %></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="AddProject"><i class="fas fa-plus"></i> Add Project</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="Logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </li>
            </ul>
        </div>
    </nav>

    <form action="AddTache" method="post">
        <input type="hidden" name="idProject" value="<%= idProject %>">
        <div class="form-group">
            <label for="description">Description:</label>
            <textarea class="form-control" name="description" maxlength="200" rows="4"></textarea>
        </div>
        <div class="form-group">
            <label for="dateDebut">Start Date:</label>
            <input type="date" class="form-control" name="dateDebut">
        </div>
        <div class="form-group">
            <label for="dateFin">End Date:</label>
            <input type="date" class="form-control" name="dateFin">
        </div>
        <div class="form-group">
            <label for="etat">Status:</label>
            <select class="form-control" name="etat">
                <option value="ToDo">To Do</option>
                <option value="Doing">Doing</option>
                <option value="Done">Done</option>
            </select>
        </div>
        <input type="submit" class="btn btn-primary" value="Add Task">
    </form>
</body>
</html>
