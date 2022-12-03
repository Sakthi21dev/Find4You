package Connection;

import java.sql.*;

public class ConnectionProvider {
	
	public static Connection getcon() {
		try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/find4u","root","S@kthi21");
		return con;
		}catch(Exception e) {
			System.out.println(e);
			return null;
		}
		
	}
	
}
