import java.sql.*;
public class getEdit {
    public static void main (String args []) throws SQLException  {

        DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
        Connection conn = null;

        try {
            conn = DriverManager.getConnection
                   ("jdbc:oracle:thin:@oracle.localdomain:1521:orcl", "cuenta", "pass");
        } catch (SQLException exception) {
            System.out.println("Error en la conexion de bd");
            System.exit(-1);
        }

        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT SEXO, COUNT(*) FROM AMIGOS GROUP BY SEXO");
       while (rs.next()) {
            String resultado = rs.getString(2);
            System.out.println(resultado);
        }
        stmt.close();
    }
}