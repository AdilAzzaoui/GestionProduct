<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>

<%@ page import="java.util.*"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="db.Projets"%>
<%@ page import="db.Tache"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<!-- Include jQuery -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<!-- Bootstrap JavaScript -->
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<!-- Include jQuery UI -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<title>Project Dashboard</title>
<style>
caption {
	border: 1px solid #ccc; /* Ajouter une bordure */
	caption-side: top; /* Positionner la légende au-dessus du tableau */
	text-align: center; /* Centrer le texte à l'intérieur de la légende */
	font-size: 1.5em;
	font-weight: bold;
	background-color: #007bff;
	color: #fff;
	padding: 10px;
	margin-bottom: 10px;
	border-radius: 5px;
}

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

	<%
	if (request.getAttribute("projets") != null) {
	%>
	<%
	ArrayList<Projets> projets = (ArrayList<Projets>) request.getAttribute("projets");
	%>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
		<a class="navbar-brand" href="Projects">Votre Logo</a>

		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarNav" aria-controls="navbarNav"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item active"><a class="nav-link" href="Projects"><i
						class="fas fa-home"></i> Accueil</a></li>
				<li class="nav-item"><a class="nav-link" href=""><i
						class="fas fa-user"></i> Hello <%=session.getAttribute("login")%></a>
				</li>
				<li class="nav-item"><a class="nav-link" href="AddProject"><i
						class="fas fa-plus"></i> Ajouter Projet</a></li>
				<li class="nav-item"><a class="nav-link" href="Logout"><i
						class="fas fa-sign-out-alt"></i> Déconnexion</a></li>
			</ul>
		</div>
	</nav>
	<br>
	<br>
	<br>
	<table>
		<caption>Liste des Projets</caption>
		<thead>
			<tr>
				<th>ID</th>
				<th>Libellé du Projet</th>
				<th>Description du Projet</th>
				<th>Tâches</th>
				<th>Action</th>
			</tr>
		</thead>
		<tbody>
			<%
			for (Projets p : projets) {
			%>
			<tr>
				<td><%=p.getId()%></td>
				<td><%=p.getLibelle()%></td>
				<td><%=p.getDescription()%></td>
				<td>
					<ul class="task-list">
						<%
						List<Tache> taches = p.getTaches();
						%>
						<%
						for (Tache tache : taches) {
						%>
						<li class="task">
							<div>
								<strong><%=tache.getDescription()%></strong>
							</div>
							<div>
								Date début:
								<%=tache.getDateDebut()%>
							</div>
							<div>
								Date fin:
								<%=tache.getDateFin()%>
							</div>
							<div class="status-text" data-tache-id="<%=tache.getId()%>">
								Statut:
								<%=tache.getStatut()%>
							</div> <select class="status-select"
							data-tache-id="<%=tache.getId()%>">
								<option value="ToDo"
									<%=tache.getStatut().equals("ToDo") ? "selected" : ""%>>To
									Do</option>
								<option value="Doing"
									<%=tache.getStatut().equals("Doing") ? "selected" : ""%>>Doing</option>
								<option value="Done"
									<%=tache.getStatut().equals("Done") ? "selected" : ""%>>Done</option>
						</select> <a
							href="<%="ModifierTache?id=" + URLEncoder.encode(String.valueOf(tache.getId()), "UTF-8")%>">
								<i class="fas fa-edit"></i> <!-- Icône de modification -->
						</a> <a
							href="<%="SupprimerTache?id=" + URLEncoder.encode(String.valueOf(tache.getId()), "UTF-8")%>">
								<i class="fas fa-trash"></i> <!-- Icône de suppression -->
						</a>
						</li>
						<%
						}
						%>
					</ul> <a href="AddTache.jsp?idProject=<%=p.getId()%>">Ajouter
						Tache</a>
				</td>
				<td><a href="DeleteProject?id=<%=p.getId()%>">
					<i class="fas fa-trash"></i> <!-- Icône de suppression -->
				</a></td>
			</tr>
			<%
			}
			%>
		</tbody>
	</table>
	<a href="AddProject.jsp">Ajouter projet</a>

	<%
	}
	%>

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

		$(document)
				.ready(

						function() {
							$(document)
									.on(
											'change',
											'.status-select',
											function() {
												var tacheId = $(this).data(
														'tache-id');
												var newStatus = $(this).val();

												// Stocker une référence à l'élément '.status-select'
												var statusSelect = $(this);

												// Stocker une référence au div contenant le statut
												var statusDiv = statusSelect
														.closest('.task')
														.find(
																'.status-text[data-tache-id="'
																		+ tacheId
																		+ '"]');

												// Envoyer la requête Ajax pour mettre à jour le statut sur le serveur
												$
														.ajax({
															type : 'POST',
															url : 'UpdateTache',
															data : {
																tacheId : tacheId,
																newStatus : newStatus,
															},
															success : function(
																	response) {
																// Gérer la réponse du serveur si nécessaire
																console
																		.log("success");

																// Mettre à jour le texte du div contenant le statut
																statusDiv
																		.text("Statut: "
																				+ newStatus);
																statusSelect
																		.closest(
																				'.task')
																		.removeClass(
																				'alert alert-danger alert-warning alert-success')
																		.addClass(
																				getTaskStatusClass(newStatus));

															},
															error : function(
																	error) {
																console
																		.error("failure");
															}
														});
											});
						});
	</script>

</body>
</html>
