package amine;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

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
		//doGet(request, response);
		String url = "jdbc:mysql://localhost:3304/GestionProjet";
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
		                	HttpSession session = request.getSession();
		                	session.setAttribute("login", login);
		                	RequestDispatcher dispacher = request.getRequestDispatcher("Projects");
		                	dispacher.forward(request, response);
		                } 
		                else {
		                	try {
		                	    String error = "Login or Password Incorrect!";
		                	    request.setAttribute("ERROR", error);
		                	    request.setAttribute("login", login);
		                	    RequestDispatcher dispatcher = request.getRequestDispatcher("Authentification.jsp");
		                	    dispatcher.forward(request, response);
		                	} catch (ServletException | IOException e) {
		                	    System.out.println(e.getMessage()); 
		                	}

		            }
		        }
		    } catch (SQLException e) {
		        
		    } catch (Exception e) {
		        
		    }
		//}

		    } catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
	}
