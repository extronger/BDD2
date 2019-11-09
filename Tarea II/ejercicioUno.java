package TareaII;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class ejercicioUno {

    public static int idRegion = 0;

    public static void main(String args[]) throws SQLException {
        Scanner sc = new Scanner(System.in);
        String[] regiones = consultaRegiones(Con());
        String region = "";
        int anioInicio = 0;
        int anioFin = 0;

        menuInicio(regiones);

        System.out.println("------------------------");
        System.out.println("Ingrese la region");
        region = sc.nextLine();
        System.out.println("Ingrese anio inicio");
        anioInicio = sc.nextInt();
        System.out.println("Ingrese anio fin");
        anioFin = sc.nextInt();

        System.out.println("Procesando...");
        buscarIDRegion(regiones, region);
        consultaProductos(Con(), region, anioInicio, anioFin);

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

    public static void menuInicio(String[] regiones) {
        int cont = 1;
        System.out.println("Las fechas deben estar entre 2012 y 2018");
        System.out.println("Las regiones que puede ingresar son las siguientes:");
        for (String reg : regiones) {
            System.out.println(" " + cont + " " + reg);
            cont++;
        }
    }


    public static String[] consultaRegiones(Connection con) throws SQLException {
        String[] regiones = new String[15];
        int cont = 0;
        if (con != null) {
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM REGION");
            while (rs.next()) {
                regiones[cont] = rs.getString(2);
                cont++;
            }
        }
        return regiones;
    }

    public static void buscarIDRegion(String[] regiones, String region) throws SQLException {
        int cont = 1;
        for (String reg : regiones) {
            if (reg.equalsIgnoreCase(region)) {
                idRegion = cont;
            }
            cont++;
        }
    }

    public static void consultaProductos(Connection con, String region, int anioInicio, int anioFin) throws SQLException {
        Statement stmt = con.createStatement();
        int cont = 1;
        List<String> idLocalesRegion = localesRegion(con);
        ResultSet rs = stmt.executeQuery("SELECT IDLOCAL, IDPRODUCTO, SUM(CANTIDAD) AS CANTIDAD FROM VENTAS where extract(year from fecha) between " + anioInicio + " and " + anioFin + " GROUP BY IDPRODUCTO, IDLOCAL ORDER BY CANTIDAD DESC");

        System.out.println("Los productos mas vendidos entre los anios " + anioInicio + " " + anioFin );
        System.out.println("De la region " + region);
        System.out.format("%-20s%-25s%-10s","ENUMERACION ","DESCRIPCION","CANTIDAD");
        System.out.println();


        while (rs.next() && cont < 11) {
            String idLocal = rs.getString(1);
            String nombreProducto = consultaProducto(con, rs.getString(2));
            String cantidadVendida = rs.getString(3);
            if (idLocalesRegion.contains(idLocal)) {
                System.out.format("%-20s%-25s%-10s",cont,nombreProducto,cantidadVendida);
                System.out.println();
                cont++;
            }
        }

    }

    public static List<String> localesRegion(Connection con) throws SQLException {
        List<String> localesRegion = new ArrayList<String>();
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT IDLOCAL FROM LOCALES L JOIN COMUNA C ON L.IDCOMUNA = C.IDCOMUNA AND C.IDREGION = " + idRegion);
        while (rs.next()) {
            localesRegion.add(rs.getString(1));
        }
        return localesRegion;
    }

    public static String consultaProducto(Connection con, String idProducto) throws SQLException {
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT DESCRIPCION FROM PRODUCTO WHERE IDPRODUCTO = " + idProducto);
        rs.next();
        String nombreProducto = rs.getString(1);
        if (nombreProducto.isEmpty()) {
            nombreProducto = "Sin nombre";
        }
        return nombreProducto;
    }
}