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
import java.sql.SQLException;

import db.DataBase;

/**
 * Servlet implementation class SupprimerTache
 */
public class SupprimerTache extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SupprimerTache() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		HttpSession session = request.getSession();
		if(session == null) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("Authentification.jsp");
			dispatcher.forward(request, response);
			return;
		}

		doPost(request, response);
				
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session == null) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("Authentification.jsp");
			dispatcher.forward(request, response);
			return;
		}

	    int id = Integer.parseInt(request.getParameter("id"));
	    Connection conn = DataBase.getConnection();
	    try {
	        PreparedStatement stmt = conn.prepareStatement("DELETE FROM tache WHERE id_tache = ?");
	        stmt.setInt(1, id);
	        int row = stmt.executeUpdate();
	        if (row > 0) {
	           RequestDispatcher dispatcher = request.getRequestDispatcher("Projects");
	           dispatcher.forward(request, response);
	        } else {
	            System.out.println("Aucune ligne supprimée. Peut-être que l'ID n'existe pas.");
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	        System.out.println("Erreur SQL lors de la suppression de la tâche.");
	    } finally {
	        try {
	            conn.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	            System.out.println("Erreur lors de la fermeture de la connexion.");
	        }
	    }
	}

}
