package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DataBase {
	static String url = "jdbc:mysql://localhost:3306/gestiondeprojet";
	static String user = "root";
	static String pass = "";
	public static Connection getConnection() {
		try {
			Connection conn = DriverManager.getConnection(url , user , pass);
			return conn;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
}
