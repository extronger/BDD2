import java.sql.*;
public class params {
	public static void main (String args []) throws SQLException  {
		Connection conn = Con();
		Statement stmt = conn.createStatement();
		String query = "";
		System.out.println(args[0]);
		if (args[0].equals("hombres")) {
			query = "SELECT SEXO, COUNT(*) FROM AMIGOS WHERE SEXO = 'M' GROUP BY SEXO";
		}
		if (args[0].equals("mujeres")) {
			query = "SELECT SEXO, COUNT(*) FROM AMIGOS WHERE SEXO = 'F' GROUP BY SEXO";
		}

		ResultSet rs = stmt.executeQuery(query);
		while (rs.next()) {
			String resultado = rs.getString(2);
			System.out.println(resultado);
		}
		stmt.close();
	}

	public static Connection Con() throws SQLException {
		DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
		Connection conn = null;
		try {
			conn = DriverManager.getConnection
			       ("jdbc:oracle:thin:@oracle.localdomain:1521:orcl", "xxx", "xxx");
		} catch (SQLException exception) {
			System.out.println("Error en la conexion de bd");
			System.exit(-1);
		}
		return conn;
	}
}