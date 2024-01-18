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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import db.DataBase;
import db.Tache;

/**
 * Servlet implementation class ModifierTache
 */
public class ModifierTache extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ModifierTache() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		int idTache = Integer.parseInt(request.getParameter("id"));
		request.setAttribute("idTache", idTache);
		Connection conn = DataBase.getConnection();
		if(conn != null) {
			try {
				PreparedStatement stmt = conn.prepareStatement("SELECT * FROM tache WHERE id_tache = ?");
				stmt.setInt(1, idTache);
				ResultSet result = stmt.executeQuery();
				if(result.next()) {
					Tache tache = new Tache();
					tache.setId(idTache);
					tache.setIdProject(result.getInt("id_projet"));
					tache.setDescription(result.getString("description"));
					tache.setDateDebut(result.getDate("date_debut"));
					tache.setDateFin(result.getDate("date_fin"));
					request.setAttribute("tache", tache);
					RequestDispatcher dispatcher = request.getRequestDispatcher("UpdateTache.jsp");
					dispatcher.forward(request, response);
				}
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
		if(request.getParameter("idTache") != null && "POST".equalsIgnoreCase(request.getMethod())) {
			String description = request.getParameter("description");
			int idTache = Integer.parseInt(request.getParameter("idTache"));
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
			Connection conn = DataBase.getConnection();
			try {
				PreparedStatement stmt = conn.prepareStatement("UPDATE tache SET description = ? , date_debut = ? , date_fin = ? WHERE id_tache = ?");
				stmt.setString(1, description);
				stmt.setDate(2, new java.sql.Date(dateDebut.getTime()));
				stmt.setDate(3, new java.sql.Date(dateDebut.getTime()));
				stmt.setInt(4, idTache);
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
