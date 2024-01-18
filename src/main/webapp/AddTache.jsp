<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%int idProject = Integer.parseInt(request.getParameter("idProject")); %>

	<form action="AddTache" method="post">
		<input type="hidden" name="idProject" value="<%= idProject %>">
		Description : <textarea name="description" maxlength="200"></textarea>
		Date Début : <input type="date" name="dateDebut">
		Date Fin : <input type="date" name="dateFin">
		Etat : <select name="etat">
			<option value="ToDo">To Do</option>
			<option value="Doing">Doing</option>
			<option value="Done">Done</option>
		</select>
		<input type="submit" value="Ajouter Tache">
	</form>
</body>
</html>