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
 * Servlet implementation class UpdateTache
 */
public class UpdateTache extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateTache() {
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

	    if ("POST".equalsIgnoreCase(request.getMethod())) {
	    	if(request.getParameter("id") != null) {
	    		
	    	}
	        String idTache = request.getParameter("tacheId");
	        String newState = request.getParameter("newStatus");
	        String sql = "UPDATE tache SET etat = ? WHERE id_tache = ?";
	        
	        try (Connection conn = DataBase.getConnection();
	             PreparedStatement stmt = conn.prepareStatement(sql)) {

	            stmt.setString(1, newState);
	            stmt.setInt(2, Integer.parseInt(idTache));
	            stmt.executeUpdate();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}

}
