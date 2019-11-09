package TareaII;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class ejercicioDos {
    public static void main(String[] args) throws SQLException {
        Scanner sc = new Scanner(System.in);

        String[] categorias = selectCategoria(Con());
        String categoria = "";
        int anioInicio = 0;
        int anioFin = 0;

        menuInicio(categorias);
        System.out.println("------------------------");
        System.out.println("Ingrese la categoria");
        categoria = sc.nextLine();
        System.out.println("Ingrese anio inicio");
        anioInicio = sc.nextInt();
        System.out.println("Ingrese anio fin");
        anioFin = sc.nextInt();

        System.out.println("Procesando su consulta ...");
        consultaComunas(Con(), categoria, anioInicio, anioFin);

    }

    public static Connection Con() throws SQLException {
        DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
        Connection conn = null;
        try {
            conn = DriverManager.getConnection("jdbc:oracle:thin:@colvin.chillan.ubiobio.cl:1521:orcl", "cuenta", "pass");
        } catch (SQLException exception) {
            System.out.println("Error en la conexion de bd");
            System.exit(-1);
        }
        return conn;
    }

    public static String[] selectCategoria(Connection con) throws SQLException {
        List<String> categorias = new ArrayList<String>();
        int cont = 0;
        if (con != null) {
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM CATEGORIA");
            while (rs.next()) {
                categorias.add(rs.getString(2));
            }
        }
        return categorias.toArray(new String[0]);
    }

    public static void menuInicio(String[] categorias) {
        System.out.println("Las fechas deben estar entre 2012 y 2018");
        System.out.println("Las categorias que puede ingresar son las siguientes:");
        for (String com : categorias) {
            System.out.println(com);
        }
    }

    public static void consultaComunas(Connection con, String categoria, int anioInicio, int anioFin) throws SQLException {
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT c.NOMBRE, SUM(v.MONTOVENTA) AS MONTO FROM"
                + "(((((VENTAS v JOIN LOCALES l ON v.IDLOCAL = l.IDLOCAL) JOIN "
                + "COMUNA c on c.IDCOMUNA = l.IDCOMUNA) JOIN "
                + "PRODUCTO p ON p.IDPRODUCTO = v.IDPRODUCTO) JOIN "
                + "SUBCATEGORIA s ON s.IDSUBCAT = p.IDSUBCAT) JOIN "
                + "CATEGORIA c ON c.IDCATEGORIA = s.IDCATEGORIA) "
                + "WHERE c.DESCRIPCION = " + "'" + categoria + "'" + " AND extract(year from v.fecha) between " + anioInicio + " and " + anioFin
                + " GROUP BY c.NOMBRE ORDER BY MONTO DESC");
        System.out.println("---------------------------------");
        System.out.println("Anios: " + anioInicio + " " + anioFin);
        System.out.println("Comuna | Monto de venta ");
        System.out.println("---------------------------------");
        while (rs.next()) {
            System.out.println(rs.getString(1) + " | " + rs.getString(2));
            System.out.println("---------------------------------");
        }
    }

}
