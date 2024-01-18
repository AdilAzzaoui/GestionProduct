<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
	
<%@ page import="java.util.*"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="db.Projets"%>
<%@ page import="db.Tache"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <!-- Include jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

    <!-- Bootstrap JavaScript -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

    <!-- Include jQuery UI -->
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<title>Project Dashboard</title>
<style>
.status-todo {
	background-color: red;
}

.status-doing {
	background-color: orange;
}

.status-done {
	background-color: green;
}

body {
	font-family: 'Arial', sans-serif;
	background-color: #f4f4f4;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
}

th, td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: left;
}

th {
	background-color: #f2f2f2;
}

.task-list {
	list-style-type: none;
	padding: 0;
	margin: 0;
}

.task {
	border-radius: 5px;
	margin-bottom: 10px;
	padding: 10px;
	cursor: pointer;
}

.card-placeholder {
	background-color: #f5f5f5;
	border: 2px dashed #ddd;
	height: 40px;
}
</style>

<!-- Include jQuery and jQuery UI -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
	<% if(request.getAttribute("projets") != null) { %>
	<% ArrayList<Projets> projets = (ArrayList<Projets>)request.getAttribute("projets"); %>
	<table>
		<thead>
			<tr>
				<th>ID</th>
				<th>Libellé du Projet</th>
				<th>Description du Projet</th>
				<th>ID de l'Utilisateur</th>
				<th>Tâches</th>
			</tr>
		</thead>
		<tbody>
			<% for(Projets p : projets) { %>
			<tr>
				<td><%= p.getId() %></td>
				<td><%= p.getLibelle() %></td>
				<td><%= p.getDescription() %></td>
				<td><%= p.getIdUser() %></td>
				<td>
					<ul class="task-list">
						<% List<Tache> taches = p.getTaches(); %>
					<% for(Tache tache : taches) { %>
    <li class="task">
        <div>
            <strong><%= tache.getDescription()%></strong>
        </div>
        <div>
            Date début: <%= tache.getDateDebut() %>
        </div>
        <div>
            Date fin: <%= tache.getDateFin() %>
        </div>
        <div class="status-text" data-tache-id="<%= tache.getId() %>">
            Statut: <%= tache.getStatut() %>
        </div>
        <select class="status-select" data-tache-id="<%= tache.getId() %>">
            <option value="ToDo" <%= tache.getStatut().equals("ToDo") ? "selected" : "" %>>To Do</option>
            <option value="Doing" <%= tache.getStatut().equals("Doing") ? "selected" : "" %>>Doing</option>
            <option value="Done" <%= tache.getStatut().equals("Done") ? "selected" : "" %>>Done</option>
        </select>
        
        <a href="<%= "ModifierTache?id=" + URLEncoder.encode(String.valueOf(tache.getId()), "UTF-8") %>">
            <i class="fas fa-edit"></i> <!-- Icône de modification -->
        </a>
        <a href="<%= "SupprimerTache?id=" + URLEncoder.encode(String.valueOf(tache.getId()), "UTF-8") %>">
            <i class="fas fa-trash"></i> <!-- Icône de suppression -->
        </a>
    </li>
<% } %>
					</ul>
				<a href="AddTache.jsp?idProject=<%= p.getId() %>">Ajouter Tache</a></td>
			</tr>
			<% } %>
		</tbody>
		<a href="AddProject.jsp">Ajouter projet</a>
	</table>
	<%} %>

	<script>
	 function getTaskStatusClass(status) {
	        var statusClass = "";
	        switch (status) {
	            case "ToDo":
	                statusClass = "alert alert-danger"; // Utiliser la classe Bootstrap pour la couleur rouge
	                break;
	            case "Doing":
	                statusClass = "alert alert-warning"; // Utiliser la classe Bootstrap pour la couleur orange
	                break;
	            case "Done":
	                statusClass = "alert alert-success"; // Utiliser la classe Bootstrap pour la couleur verte
	                break;
	            default:
	                statusClass = "";
	        }
	        return statusClass;
	    }

		$(document).ready(
				function() {
					$(document).on(
							'change',
							'.status-select',
							function() {
								var tacheId = $(this).data('tache-id');
								var newStatus = $(this).val();

								// Stocker une référence à l'élément '.status-select'
								var statusSelect = $(this);

								// Stocker une référence au div contenant le statut
								var statusDiv = statusSelect.closest('.task')
										.find(
												'.status-text[data-tache-id="'
														+ tacheId + '"]');

								// Envoyer la requête Ajax pour mettre à jour le statut sur le serveur
								$.ajax({
									type : 'POST',
									url : 'UpdateTache',
									data : {
										tacheId : tacheId,
										newStatus : newStatus,
									},
									success : function(response) {
										// Gérer la réponse du serveur si nécessaire
										console.log("success");

										// Mettre à jour le texte du div contenant le statut
										statusDiv.text("Statut: " + newStatus);
					                    statusSelect.closest('.task').removeClass('alert alert-danger alert-warning alert-success').addClass(getTaskStatusClass(newStatus));

									},
									error : function(error) {
										console.error("failure");
									}
								});
							});
				});
	</script>

</body>
</html>
