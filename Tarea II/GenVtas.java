import java.sql.*;
import java.util.*;
import java.io.*;
import java.util.Random;
public class GenVtas {
	public static void main(String[] args) throws SQLException {
		DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
		Connection conn = Con();

		PreparedStatement ps = conn.prepareStatement("INSERT INTO VENTAS VALUES(?,?,?,?,?)");
		long dia = 24 * 3600 * 1000; // milisegundos x día
		int ntuplas = 50;
		// Locales
		int l1 = 1;
		int l2 = 3;
		// Productos
		int p1 = 1;
		int p2 = 30;
		// Cantidades
		int q1 = 10;
		int q2 = 20;
		// Montos
		int m1 = 2000;
		int m2 = 50000;
		java.sql.Date f1 =  java.sql.Date.valueOf("2012-01-01");
		java.sql.Date f2 =  java.sql.Date.valueOf("2018-01-01");
		int df = (int) ((f2.getTime() - f1.getTime()) / dia);
		Random rand = new Random();
		for (int i = 0; i < ntuplas; i++) {
			java.sql.Date f =  new  java.sql.Date (f1.getTime()  + rand.nextInt(df) * dia);
			int idLocal  = l1 + rand.nextInt(l2 - l1 + 1) ;
			int idProducto = p1 + rand.nextInt(p2 - p1 + 1);
			int cantidad  = q1 + rand.nextInt(q2 - q1 + 1);
			int monto   = m1 + rand.nextInt(m2 - m1 + 1);
			ps.setDate(1, f);
			ps.setInt(2, idProducto);
			ps.setInt(3, idLocal);
			ps.setInt(4, cantidad);
			ps.setInt(5, monto);
			ps.executeUpdate();
			System.out.println(f + " " + idLocal + " " + idProducto + " " +  cantidad + " " + monto);
		}


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

