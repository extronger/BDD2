import java.sql.*;
import java.util.Scanner;
public class insertPrepared {
	public static void main (String args []) throws SQLException  {
		Connection conn = Con();
		Scanner sc = new Scanner(System.in);

		PreparedStatement ps = conn.prepareStatement("INSERT INTO AMIGOS VALUES(?,?,?,?,?,?,?)");

		int id = 0;
		String nombre = "";
		int fono = 0;
		Date fnac;
		String sexo = "";;

		System.out.println("Para salir ID = -1");
		do {
			System.out.println("ID");
			id = sc.nextInt();
			System.out.println("Nombre");
			nombre = sc.next();
			System.out.println("Fono");
			fono = sc.nextInt();
			System.out.println("Fecha de nacimiento");
			fnac = Date.valueOf(sc.next());
			System.out.println("Sexo");
			sexo = sc.next();
			ps.setInt(1, id);
			ps.setString(2, nombre);
			ps.setInt(3, fono);
			ps.setDate(4, fnac);
			ps.setString(5, sexo);
			ps.setNull(6, java.sql.Types.INTEGER);
			ps.setNull(7, java.sql.Types.INTEGER);
			ps.executeUpdate();
		} while ( Integer.parseInt(args[0]) != -1);
		System.out.println("Fin");
		ps.close();
	}

	public static Connection Con() throws SQLException {
		DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
		Connection conn = null;
		try {
			conn = DriverManager.getConnection
			       ("jdbc:oracle:thin:@oracle.localdomain:1521:orcl", "cuenta", "pass");
		} catch (SQLException exception) {
			System.out.println("Error en la conexion de bd");
			System.exit(-1);
		}
		return conn;
	}
}