package amine;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
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
 * Servlet implementation class Inscription
 */
public class Inscription extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Inscription() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		request.getParameter("");
		response.sendRedirect(request.getContextPath() + "/Authentification.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// TODO Auto-generated method stub
		doGet(request, response);
		String url = "jdbc:mysql://localhost:3304/GestionProjet";
		String user = "root";
		String pass = "";
		/*
		 * if ("Login".equals(request.getParameter("action"))) { String login =
		 * request.getParameter("login"); String password =
		 * request.getParameter("password");
		 * 
		 * try (Connection connection = DriverManager.getConnection(url, user, pass)) {
		 * String sql = "SELECT * FROM user WHERE username = ? AND password = ?";
		 * 
		 * try (PreparedStatement stmt = connection.prepareStatement(sql)) {
		 * stmt.setString(1, login); stmt.setString(2, password);
		 * 
		 * try (ResultSet result = stmt.executeQuery()) { if (result.next()) { //
		 * Successful login response.sendRedirect("/hello.jsp"); } } } } catch
		 * (SQLException e) {
		 * 
		 * } catch (Exception e) {
		 * 
		 * } }
		 */


		
			String nom = request.getParameter("name");
			String prenom = request.getParameter("lsname");
			String email = request.getParameter("email");
			String username = request.getParameter("username");
			String password = request.getParameter("pass");
			String confirmPassword = request.getParameter("confpass");
			if (nom != null && prenom != null && email != null && username != null && password != null
					&& confirmPassword != null && password.equals(confirmPassword)) {
				try (Connection connection = DriverManager.getConnection(url, user, pass)) {
					HttpSession session = request.getSession();

					String sql = "INSERT INTO user (username, nom, prenom, email, password) VALUES (?, ?, ?, ?, ?)";

					try (PreparedStatement stmt = connection.prepareStatement(sql)) {
						stmt.setString(1, username);
						stmt.setString(3, nom);
						stmt.setString(2, prenom);
						stmt.setString(4, email);
						stmt.setString(5, password);

						int rowsAffected = stmt.executeUpdate();

						if (rowsAffected > 0) {
							session.setAttribute("login", username);
							// response.sendRedirect(request.getContextPath() + "/Authentification.jsp");
							System.out.println("success !!");
						} else {
							session.setAttribute("Error", "Impossible d'insérer l'utilisateur.");
							doGet(request, response);
						}
					}
				} catch (SQLException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			} else {
				HttpSession session = request.getSession();
				session.setAttribute("Error", "Veuillez remplir tous les champs correctement.");
				response.sendRedirect(request.getContextPath() + "/Test.jsp");
			}

		}
	}

 
