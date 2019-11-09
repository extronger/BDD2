import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
public class insert {
	public static void main (String args []) throws SQLException  {
		Connection conn = Con();
		Statement stmt = conn.createStatement();

		int id = Integer.parseInt(args[0]);
		String nombre = args[1];
		int fono = Integer.parseInt(args[2]);
		Date fnac = args[3];
		char sexo = args[4].charAt(0);

		stmt.executeUpdate( "INSERT INTO AMIGOS VALUES(" + id + "," +  "'"+nombre +"'" + "," + fono + "," + "date" + "'"+fnac+"'" + "," + "'"+sexo +"'"+ "," + null + "," + null + ")" );
		stmt.close();
	}

	public static Connection Con() throws SQLException {
		DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
		Connection conn = null;
		try {
			conn = DriverManager.getConnection
			       ("jdbc:oracle:thin:@oracle.localdomain:1521:orcl", "");
		} catch (SQLException exception) {
			System.out.println("Error en la conexion de bd");
			System.exit(-1);
		}
		return conn;
	}
}