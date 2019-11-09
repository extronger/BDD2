/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
//DIEGOINOSTROZA

import java.sql.*;

public class question4 {

    public static void main(String[] args) throws SQLException {
        consulta(Con());
    }

    public static Connection Con() throws SQLException {
        DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
        Connection conn = null;
        try {
            conn = DriverManager.getConnection("jdbc:oracle:thin:@oracle.localdomain:1521:orcl", "cuenta", "pass");
        } catch (SQLException exception) {
            System.out.println("Error en la conexion de bd");
            System.exit(-1);
        }
        return conn;
    }

    public static void consulta(Connection con) throws SQLException {
        Statement stmt = con.createStatement();
        CallableStatement cs = con.prepareCall("begin ? := fechacercana; end;");
        cs.registerOutParameter(1, Types.NUMERIC);
        cs.execute();

        int idAmigo = cs.getInt(1);
        ResultSet rs = stmt.executeQuery("SELECT * FROM AMIGOS WHERE ID =" + idAmigo);
        rs.next();

        String nombreAmigo = rs.getString(2);
        String telefono = rs.getString(3);
        String sexo = rs.getString(5);
        String sexoString = "";
        String nombrePadre = "";
        String nombreMadre = "";
        String idMadre = rs.getString(6);
        String idPadre = rs.getString(7);
        int edad = edadAmigo(con, cs, idAmigo);

        if (sexo.equals("M")) {
            sexoString = "Hombre";
        } else {
            sexoString = "Mujer";
        }

        nombreMadre = verificarPadres(idMadre, rs, stmt);
        nombrePadre = verificarPadres(idPadre, rs, stmt);

        System.out.println("Datos del amigo");
        System.out.println("Nombre: " + nombreAmigo + " telefono " + telefono + " sexo " + sexoString + " edad " + edad);
        System.out.println("Datos de los padres");
        System.out.println("Madre: " + nombreMadre);
        System.out.println("Padre: " + nombrePadre);

    }

    public static int edadAmigo(Connection con, CallableStatement cs, int idAmigo) throws SQLException {
        cs = con.prepareCall("begin ? := edad(?); end;"); //funcion almacenada en mi base de datos que me devuelve la edad del amigo que envio por parametro
        cs.registerOutParameter(1, Types.NUMERIC);
        cs.setInt(2, idAmigo);
        cs.execute();
        int edad = cs.getInt(1);
        return edad;
    }

    public static String verificarPadres(String idPadre, ResultSet rs, Statement stmt) throws SQLException {
        String nombrePadre = "";

        if (idPadre == null) {
            nombrePadre = "No existe informacion";
        } else {
            rs = stmt.executeQuery("SELECT nombre FROM AMIGOS WHERE ID =" + idPadre);
            rs.next();
            nombrePadre = rs.getString(1);
        }
        return nombrePadre;
    }

}
