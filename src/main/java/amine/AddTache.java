package amine;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.util.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import db.DataBase;

/**
 * Servlet implementation class AddTache
 */
public class AddTache extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddTache() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		RequestDispatcher dispatcher = request.getRequestDispatcher("Logout");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		if(session == null) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("Authentification.jsp");
			dispatcher.forward(request, response);
			return;
		}

		
		String description = request.getParameter("description");
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date dateDebut = null;
        Date dateFin = null;
		try {
			 dateDebut =  dateFormat.parse(request.getParameter("dateDebut"));
			 dateFin =  dateFormat.parse(request.getParameter("dateFin"));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String etat = request.getParameter("etat");
		int idProject = Integer.parseInt(request.getParameter("idProject"));
		String sql = "INSERT INTO tache(id_tache , id_projet , description , date_debut , date_fin , etat) VALUES(? ,? , ? , ? , ? , ?)";
		Connection conn = DataBase.getConnection();
		try {
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, 0);
			stmt.setInt(2, idProject);
			stmt.setString(3, description);
			stmt.setDate(4, new java.sql.Date(dateDebut.getTime()));
			stmt.setDate(5, new java.sql.Date(dateFin.getTime()));
			stmt.setString(6, etat);
			int row = stmt.executeUpdate();
			if(row > 0) {
				RequestDispatcher dispatcher = request.getRequestDispatcher("Projects");
		        dispatcher.forward(request, response);
		    }
			else System.out.println("ERROOOR");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

}
