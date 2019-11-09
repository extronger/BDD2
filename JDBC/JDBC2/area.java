import java.sql.*;
public class area {
	public static void main (String args []) throws SQLException  {
		Connection conn = Con();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT * FROM RECTANGULO");
		int cont = 0;

		if (args.length != 0) {
			int area = Integer.parseInt(args[0]);
			while (rs.next()) {
				int XL = Integer.parseInt(rs.getString(2));
				int YL = Integer.parseInt(rs.getString(3));
				int XH = Integer.parseInt(rs.getString(4));
				int YH = Integer.parseInt(rs.getString(5));

				CallableStatement cs = conn.prepareCall ("begin ? := area(?,?,?,?); end;");
				cs.registerOutParameter(1, Types.INTEGER);
				cs.setInt(2, XL);
				cs.setInt(3, YL);
				cs.setInt(4, XH);
				cs.setInt(5, YH);
				cs.executeUpdate();

				int areaRectangulo = Integer.parseInt(cs.getString(1));
				if (areaRectangulo > area ) {
					System.out.println("El rectangulo " + rs.getString(1) + " tiene un area de: " + areaRectangulo);
					cont++;
				}

			}
		} else {
			System.out.println("Ingrese un area como parametro");
		}

		if (cont == 0) {
			System.out.println("No hay rectangulos con area mayor");
		}
		stmt.close();
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
