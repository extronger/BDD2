 import java.sql.*;
 public class getOneRow {
 public static void main (String args []) throws SQLException  {    
    DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
    Connection conn = DriverManager.getConnection 
      ("jdbc:oracle:thin:@oracle.localdomain:1521:orcl", "cuenta", "pass");
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT NOMBRE  FROM AMIGOS WHERE ID =1051");
    rs.next();
    String elNombre = rs.getString("NOMBRE");
    System.out.println("Mi amigo/a con ID = 1051 Se llama " +  elNombre);
    stmt.close();
  }
 } // end clase getOneRow
