package TareaII;

import java.sql.*;
import java.util.Scanner;

/*Cantidad  zonas  año: 9999  Producto: xxxxxxx. Para obtener esta tabla se debe proporcionar
un periodo en años y el producto que se necesita analizar.*/
//Tablas VENTAS -> PRODUCTO, LOCAL -> COMUNA -> REGION
public class ejercicioCuatro {

    public static void main(String[] args) throws SQLException {
        Scanner tec = new Scanner(System.in);
        DriverManager.registerDriver(new oracle.jdbc.OracleDriver());

        String usuario = "cuenta"; //cambiar el nombre
        String pass = "pass"; //cambiar la contraseña

        Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@colvin.chillan.ubiobio.cl:1521:orcl", usuario, pass);
        Statement stmt = conn.createStatement();
        Statement stmtDos = conn.createStatement();

        System.out.print("Producto: ");
        String descripcion = tec.nextLine();
        System.out.print("Anio: ");
        int anio = tec.nextInt();

        //Obtener regiones
        ResultSet regiones = stmt.executeQuery(traerConsulta1(descripcion, anio));

        int idRegion = 0;
        String region;
        int totalRegion = 0;
        int totalComuna = 0;
        int totalMeses[] = new int[13];
        int mes[] = new int[12];

        //Obtener comunas
        System.out.format("%-15s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s", "Zonas/meses", "Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic", "Total");
        System.out.println();

        while (regiones.next()) {
            idRegion = regiones.getInt(1);
            region = regiones.getString(2);

            for (int i = 0; i < 12; i++) {
                mes[i] = regiones.getInt(i + 3);
            }

            for (int i = 0; i < 12; i++) {
                totalMeses[i] = totalMeses[i] + mes[i];
            }

            totalRegion = totalRegion + mes[0] + mes[1] + mes[2] + mes[3] + mes[4] + mes[5] + mes[6] + mes[7] + mes[8] + mes[9] + mes[10] + mes[11];
            totalMeses[12] = totalMeses[12] + totalRegion;

            System.out.format("%-15s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s", region, mes[0], mes[1], mes[2], mes[3], mes[4], mes[5], mes[6], mes[7], mes[8], mes[9], mes[10], mes[11], totalRegion);
            System.out.println();

            ResultSet comunas = stmtDos.executeQuery(traerConsulta2(descripcion, anio, idRegion));
            while (comunas.next()) {
                region = comunas.getString(1);//COMUNA
                for (int i = 0; i < 12; i++) {
                    mes[i] = comunas.getInt(i + 2);
                }
                totalComuna = totalComuna + mes[0] + mes[1] + mes[2] + mes[3] + mes[4] + mes[5] + mes[6] + mes[7] + mes[8] + mes[9] + mes[10] + mes[11];
                System.out.println(totalComuna);
                System.out.format("%-15s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s", "- " + region, mes[0], mes[1], mes[2], mes[3], mes[4], mes[5], mes[6], mes[7], mes[8], mes[9], mes[10], mes[11], totalRegion);
                System.out.println();

                totalComuna = 0;
            }
            totalRegion = 0;
        }
        System.out.format("%-15s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s", "TOTAL", totalMeses[0], totalMeses[1], totalMeses[2], totalMeses[3], totalMeses[4], totalMeses[5], totalMeses[6], totalMeses[7], totalMeses[8], totalMeses[9], totalMeses[10], totalMeses[11], totalMeses[12]);
        System.out.println();
    }

    public static String traerConsulta1(String descripcion, int anio) {

        String consulta = "SELECT reg.idregion, reg.nombre, "
                + "SUM(CASE WHEN extract(month FROM ven.fecha) = 1 THEN ven.cantidad ELSE 0 END) as enero, "
                + "SUM(CASE WHEN extract(month FROM ven.fecha) = 2 THEN ven.cantidad ELSE 0 END) as febrero, "
                + "SUM(CASE WHEN extract(month FROM ven.fecha) = 3 THEN ven.cantidad ELSE 0 END) as marzo, "
                + "SUM(CASE WHEN extract(month FROM ven.fecha) = 4 THEN ven.cantidad ELSE 0 END) as abril, "
                + "SUM(CASE WHEN extract(month FROM ven.fecha) = 5 THEN ven.cantidad ELSE 0 END) as mayo, "
                + "SUM(CASE WHEN extract(month FROM ven.fecha) = 6 THEN ven.cantidad ELSE 0 END) as junio, "
                + "SUM(CASE WHEN extract(month FROM ven.fecha) = 7 THEN ven.cantidad ELSE 0 END) as julio, "
                + "SUM(CASE WHEN extract(month FROM ven.fecha) = 8 THEN ven.cantidad ELSE 0 END) as agosto, "
                + "SUM(CASE WHEN extract(month FROM ven.fecha) = 9 THEN ven.cantidad ELSE 0 END) as septiembre, "
                + "SUM(CASE WHEN extract(month FROM ven.fecha) = 10 THEN ven.cantidad ELSE 0 END) as octubre, "
                + "SUM(CASE WHEN extract(month FROM ven.fecha) = 11 THEN ven.cantidad ELSE 0 END) as noviembre, "
                + "SUM(CASE WHEN extract(month FROM ven.fecha) = 12 THEN ven.cantidad ELSE 0 END) as diciembre "
                + "FROM (((VENTAS ven JOIN PRODUCTO pro ON ven.idproducto = pro.idproducto) JOIN LOCALES loc ON loc.idlocal = ven.idlocal) "
                + "JOIN COMUNA comu ON comu.idcomuna = loc.idcomuna) JOIN REGION reg ON reg.idregion = comu.idregion "
                + "WHERE pro.descripcion = '" + descripcion + "' and extract(year FROM ven.fecha) = " + anio + " GROUP BY reg.idregion, reg.nombre";

        return consulta;
    }

    public static String traerConsulta2(String descripcion, int anio, int idRegion) {
        String consulta = "SELECT comu.nombre, "
                + "SUM(CASE WHEN extract(month FROM ven.fecha) = 1 THEN ven.cantidad ELSE 0 END) as enero, "
                + "SUM(CASE WHEN extract(month FROM ven.fecha) = 2 THEN ven.cantidad ELSE 0 END) as febrero, "
                + "SUM(CASE WHEN extract(month FROM ven.fecha) = 3 THEN ven.cantidad ELSE 0 END) as marzo, "
                + "SUM(CASE WHEN extract(month FROM ven.fecha) = 4 THEN ven.cantidad ELSE 0 END) as abril, "
                + "SUM(CASE WHEN extract(month FROM ven.fecha) = 5 THEN ven.cantidad ELSE 0 END) as mayo, "
                + "SUM(CASE WHEN extract(month FROM ven.fecha) = 6 THEN ven.cantidad ELSE 0 END) as junio, "
                + "SUM(CASE WHEN extract(month FROM ven.fecha) = 7 THEN ven.cantidad ELSE 0 END) as julio, "
                + "SUM(CASE WHEN extract(month FROM ven.fecha) = 8 THEN ven.cantidad ELSE 0 END) as agosto, "
                + "SUM(CASE WHEN extract(month FROM ven.fecha) = 9 THEN ven.cantidad ELSE 0 END) as septiembre, "
                + "SUM(CASE WHEN extract(month FROM ven.fecha) = 10 THEN ven.cantidad ELSE 0 END) as octubre, "
                + "SUM(CASE WHEN extract(month FROM ven.fecha) = 11 THEN ven.cantidad ELSE 0 END) as noviembre, "
                + "SUM(CASE WHEN extract(month FROM ven.fecha) = 12 THEN ven.cantidad ELSE 0 END) as diciembre "
                + "FROM (((VENTAS ven JOIN PRODUCTO pro ON ven.idproducto = pro.idproducto) JOIN LOCALES loc ON loc.idlocal = ven.idlocal) "
                + "JOIN COMUNA comu ON comu.idcomuna = loc.idcomuna) "
                + "WHERE pro.descripcion = '" + descripcion + "' and extract(year FROM ven.fecha) = " + anio + "  and comu.idregion = " + idRegion + " GROUP BY comu.nombre ";

        return consulta;
    }
}