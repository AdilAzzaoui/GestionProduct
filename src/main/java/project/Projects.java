package project;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DataBase;
import db.Projets;
import db.Tache;

/**
 * Servlet implementation class projects
 */
@WebServlet("/Projects")

public class Projects extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Projects() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		HttpSession session = request.getSession();
		if(session == null) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("Authentification.jsp");
			dispatcher.forward(request, response);
			return;
		}

		String login = (String) session.getAttribute("login");
		Connection conn = DataBase.getConnection();
		if(conn != null) {
			String query = "SELECT * FROM projet WHERE idUser = ?";
			try {
				PreparedStatement stmt = conn.prepareStatement(query);
				stmt.setString(1, login);
				ResultSet result = stmt.executeQuery();
				List<Projets> projets = new ArrayList<>();
				
				while (result.next()) {
					Projets p = new Projets();
					p.setId(result.getInt("id_projet"));
					
					p.setLibelle(result.getString("libelle"));
					p.setDescription(result.getString("description"));
					p.setIdUser(result.getString("idUser"));
					List<Tache> taches = getTasksForProject(conn, p.getId());
					p.setTaches(taches);
					projets.add(p);
				}
				request.setAttribute("projets", projets);
				RequestDispatcher dispacher = request.getRequestDispatcher("test.jsp");
				dispacher.forward(request, response);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		
	}
    private List<Tache> getTasksForProject(Connection conn, int projectId) throws SQLException {
        String tasksQuery = "SELECT * FROM tache WHERE id_projet = ?";
        List<Tache> taches = new ArrayList<>();

        try (PreparedStatement tasksStmt = conn.prepareStatement(tasksQuery)) {
            tasksStmt.setInt(1, projectId);
            ResultSet tasksResult = tasksStmt.executeQuery();

            while (tasksResult.next()) {
                Tache tache = new Tache();
                tache.setId(tasksResult.getInt("id_tache"));
                tache.setIdProject(tasksResult.getInt("id_projet"));
                tache.setDateDebut(tasksResult.getDate("date_debut"));
                tache.setDateFin(tasksResult.getDate("date_fin"));
                tache.setDescription(tasksResult.getString("description"));
                tache.setStatut(tasksResult.getString("etat"));

                taches.add(tache);
            }
        }

        return taches;
    }


}
