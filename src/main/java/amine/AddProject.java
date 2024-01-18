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
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.mysql.cj.Session;

import db.DataBase;

/**
 * Servlet implementation class AddProject
 */
public class AddProject extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddProject() {
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
		RequestDispatcher dispatcher = request.getRequestDispatcher("AddProject.jsp");
        dispatcher.forward(request, response);
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

		String libelle = request.getParameter("libelle");
		String description = request.getParameter("description");
		Connection conn = DataBase.getConnection();
		if(conn != null) {
			try {
				PreparedStatement stmt = conn.prepareStatement(
						"INSERT INTO projet (id_projet , libelle , description , idUser) VALUES(? , ? , ? , ?)"
						);
				stmt.setInt(1, 0);
				stmt.setString(2, libelle);
				stmt.setString(3, description);
				stmt.setString(4, (String) session.getAttribute("login"));
				int row = stmt.executeUpdate();
				if(row > 0) {
			           RequestDispatcher dispatcher = request.getRequestDispatcher("Projects");
			           dispatcher.forward(request, response);
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
	}

}
