import java.sql.*;
public class rectangles {
	public static void main (String args []) throws SQLException  {
		Connection conn = Con();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT RID, XL, XH FROM RECTANGULO");
		PreparedStatement ps = conn.prepareStatement("UPDATE RECTANGULO SET XL = ?, XH = ? WHERE RID = ?");
		while (rs.next()) {
			String RID = rs.getString(1);
			String XL = rs.getString(2);
			String XH = rs.getString(3);
			System.out.println("ID " + RID + " XL " + XL + " XH " + XH);
			Double setXL = (Double.valueOf(XL)/10);
			Double setXH = (Double.valueOf(XH)/10);
			ps.setDouble(1, setXL);
			ps.setDouble(2, setXH);
			ps.setInt(3, (Integer.parseInt(RID)));
			ps.executeUpdate();
		}
		stmt.close();
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
