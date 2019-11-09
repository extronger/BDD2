import java.sql.*;
 class getRows {
 public static void main (String args []) throws SQLException
  {    
    DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
    Connection conn = DriverManager.getConnection 
      ("jdbc:oracle:thin:@oracle.localdomain:1521:orcl", "cuenta", "pass");
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT ID, NOMBRE  FROM AMIGOS ORDER BY NOMBRE");
    while (rs.next()) {
      int id = rs.getInt("ID");
      String Nombre = rs.getString("NOMBRE");
      System.out.println(id + "  " + Nombre);
    }
    stmt.close();
  }
 } // end clase getRows

