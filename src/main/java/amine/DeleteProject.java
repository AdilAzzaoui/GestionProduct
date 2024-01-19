package amine;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.DataBase;

/**
 * Servlet implementation class DeleteProject
 */
public class DeleteProject extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteProject() {
        super();
        // TODO Auto-generated constructor stub
    }
    

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		int id = Integer.parseInt(request.getParameter("id"));
		Connection conn = DataBase.getConnection();
		if(conn != null) {
			
				PreparedStatement stmt2;
				try {
					stmt2 = conn.prepareStatement("Select * From tache WHERE id_projet = ?");
					stmt2.setInt(1, id);
					ResultSet result = stmt2.executeQuery();
					if(result.next()) {
						PreparedStatement stmt = conn.prepareStatement("DELETE FROM tache WHERE id_projet = ?");
						stmt.setInt(1, id);
						int row = stmt.executeUpdate();
						PreparedStatement state = conn.prepareStatement("DELETE FROM projet WHERE id_projet = ?");
						state.setInt(1, id);
						state.executeUpdate();
						
					}else {
						PreparedStatement state = conn.prepareStatement("DELETE FROM projet WHERE id_projet = ?");
						state.setInt(1, id);
						state.executeUpdate();
					}
					RequestDispatcher dispatcher = request.getRequestDispatcher("Projects");
					dispatcher.forward(request, response);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				
		}
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
