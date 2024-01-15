package amine;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Servlet implementation class Login
 */
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		String url = "jdbc:mysql://localhost:3306/gestiondeprojet";
		String user = "root";
		String pass = "";
		//if ("Login".equals(request.getParameter("action"))) {
		    String login = request.getParameter("login");
		    String password = request.getParameter("password");
		    
		    try (Connection connection = DriverManager.getConnection(url, user, pass)) {
		        String sql = "SELECT * FROM user WHERE username = ? AND password = ?";
		        
		        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
		            stmt.setString(1, login);
		            stmt.setString(2, password);
		            
		            try (ResultSet result = stmt.executeQuery()) {
		                if (result.next()) {
		                    // Successful login
		                	
		                	response.sendRedirect(request.getContextPath() + "/hello.jsp");
		                } 
		                else {
		                	
		                }
		            }
		        }
		    } catch (SQLException e) {
		        
		    } catch (Exception e) {
		        
		    }
		//}

	}

}
