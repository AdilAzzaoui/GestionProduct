<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trello-like Dashboard</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
        }

        header {
            background-color: #026aa7;
            color: white;
            padding: 10px;
            text-align: right;
        }

        .container-fluid {
            padding: 20px;
        }
.project-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .project-table th, .project-table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        .project-table th {
            background-color: #f2f2f2;
        }

        .task-table {
            width: 100%;
            border-collapse: collapse;
        }

        .task-table th, .task-table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        .task-table th {
            background-color: #f5f5f5;
        }

        .board {
            display: flex;
            overflow-x: auto;
        }
	 .list {
        /* ... (autres styles) */
        min-height: 200px; /* spécifiez une hauteur minimale pour que le glisser-déposer fonctionne correctement */
    }

    .card-placeholder {
        background-color: #f5f5f5;
        border: 2px dashed #ddd;
        height: 40px; /* spécifiez une hauteur pour l'aperçu de l'élément déplacé */
    }

    .list.dragging {
        background-color: #f9f9f9;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    .card.tilt {
        transform: rotate(3deg);
    }

        .list {
            min-width: 250px;
            margin-right: 20px;
            background-color: #ebecf0;
            border-radius: 5px;
            padding: 10px;
        }

        .list-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .card {
            background-color: #fff;
            border-radius: 5px;
            margin-bottom: 10px;
            padding: 10px;
            cursor: pointer;
        }

        .card-title {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .add-card-btn {
            cursor: pointer;
            color: #5e6c84;
        }

        .card-modal {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            z-index: 1000;
        }

        .overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 999;
        }

        .close-btn {
            cursor: pointer;
        }
    </style>
</head>
<body>
    <header>
        <div class="container">
            Welcome, <%if(session.getAttribute("login") != null){ %>
            <%=session.getAttribute("login") %>
            <%   } %>
            ! <a href="#" class="text-light">Logout</a>
        </div>
    </header>
<!-- 	 <div class="container-fluid">
        Liste de projets
        <table class="project-table">
            <thead>
                <tr>
                    <th>Projet</th>
                    <th>Liste de tâches</th>
                </tr>
            </thead>
            <tbody>
                Projet 1
                <tr>
                    <td>Projet 1</td>
                    <td>
                        Liste de tâches pour le Projet 1
                        <table class="task-table">
                            <thead>
                                <tr>
                                    <th>Tâche</th>
                                    <th>Statut</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                Tâche 1
                                <tr>
                                    <td>Tâche 1.1</td>
                                    <td>Doing</td>
                                    <td>
                                        Boutons Modifier et Supprimer
                                        <i class="fas fa-edit"></i> <i class="fas fa-trash"></i>
                                    </td>
                                </tr>
                                Ajoutez d'autres lignes pour d'autres tâches du Projet 1
                            </tbody>
                        </table>
                    </td>
                </tr>

                Ajoutez d'autres lignes pour d'autres projets avec leurs listes de tâches
            </tbody>
        </table>
    </div> -->
    <div class="container-fluid">
        <div class="board">
            <div class="list">
                <div class="list-title">To Do</div>
                <div class="card">Task 1</div>
                <div class="card">Task 2</div>
                <div class="add-card-btn" onclick="showCardModal('To Do')">+ Add a card</div>
            </div>
            
            <div class="list">
                <div class="list-title">In Progress</div>
                <div class="card">Task 3</div>
                <div class="add-card-btn" onclick="showCardModal('In Progress')">+ Add a card</div>
            </div>
            
            <div class="list">
                <div class="list-title">Done</div>
                <div class="card">Task 4</div>
                <div class="add-card-btn" onclick="showCardModal('Done')">+ Add a card</div>
            </div>
        </div>
    </div>

    <div class="card-modal" id="cardModal">
        <span class="close-btn" onclick="hideCardModal()">×</span>
        <div class="form-group">
            <label for="cardTitle">Card Title</label>
            <input type="text" class="form-control" id="cardTitle" placeholder="Enter card title">
        </div>
        <button class="btn btn-primary" onclick="addCard()">Add Card</button>
    </div>

    <div class="overlay" id="overlay" onclick="hideCardModal()"></div>

    <script>
        function showCardModal(listTitle) {
            document.getElementById('cardModal').style.display = 'block';
            document.getElementById('overlay').style.display = 'block';
            document.getElementById('cardTitle').value = '';
        }

        function hideCardModal() {
            document.getElementById('cardModal').style.display = 'none';
            document.getElementById('overlay').style.display = 'none';
        }

        function addCard() {
            const cardTitle = document.getElementById('cardTitle').value;
            if (cardTitle.trim() !== '') {
                const listTitle = document.querySelector('.card-modal').previousElementSibling.querySelector('.list-title').textContent;
                const card = document.createElement('div');
                card.classList.add('card');
                card.textContent = cardTitle;
                card.setAttribute('onclick', `showCardModal('${listTitle}')`);

                const addCardBtn = document.querySelector('.card-modal').previousElementSibling.querySelector('.add-card-btn');
                addCardBtn.before(card);
                hideCardModal();
            }
        }
 $(function () {
            $(".list").sortable({
                connectWith: ".list",
                placeholder: "card-placeholder",
                start: function (event, ui) {
                    ui.item.addClass("tilt");
                    $(".list").addClass("dragging");
                },
                stop: function (event, ui) {
                    ui.item.removeClass("tilt");
                    $(".list").removeClass("dragging");
                }
            }).disableSelection();

            $(".add-card-btn").on("click", function () {
                var listTitle = $(this).siblings(".list-title").text();
                showCardModal(listTitle);
            });
        });
    </script>
</body>
</html>
