package TareaII;

import java.sql.*;
import java.util.Scanner;

public class ejercicioTres {
    public static void main(String[] args) throws SQLException {
        Scanner tec = new Scanner(System.in);
        DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());

        String usuario = "cuenta"; //cambiar el nombre
        String pass = "pass"; //cambiar la contraseña

        Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@colvin.chillan.ubiobio.cl:1521:orcl", usuario, pass);
        Statement stmt = conn.createStatement();
        Statement stmtDos = conn.createStatement();
        //Solicitar anio
        System.out.print("Ingrese el anio a analizar: ");
        int anio = tec.nextInt();
        //Obtener categorias
        ResultSet categorias = stmt.executeQuery(traerConsulta1(anio));

        int id = 0;
        int totalCategoria = 0;
        int totalSubCategoria = 0;
        int totalEstacion[] = new int[5];

        //Obtener subcategoria
        System.out.println("Anio ingresado: " + anio);
        System.out.format("%-30s %-10s %-10s %-10s %-10s %-10s","DESCRIPCION","SUMMER","AUTUMN","WINTER","SPRING","TOTAL");
        System.out.println();
        //System.out.println("DESCRIPCION\t\tSUMMER\tAUTUMN\tWINTER\tSPRING\tTOTAL");
        while(categorias.next()){
            id = categorias.getInt("elId");
            String descripcion = categorias.getString("descrip");
            int verano = categorias.getInt("verano");
            int otonio = categorias.getInt("otonio");
            int invierno = categorias.getInt("invierno");
            int primavera = categorias.getInt("primavera");
            totalEstacion[0] = totalEstacion[0] + verano;
            totalEstacion[1] = totalEstacion[1] + otonio;
            totalEstacion[2] = totalEstacion[2] + invierno;
            totalEstacion[3] = totalEstacion[3] + primavera;
            totalCategoria = totalCategoria + verano + otonio + invierno + primavera;
            totalEstacion[4] = totalEstacion[4] + totalCategoria;
            if(descripcion.length()>14){
                System.out.format("%-32s %-10s %-10s %-10s %-10s %-10s",descripcion,verano,otonio,invierno,primavera,totalCategoria);
                System.out.println();
                //System.out.println(descripcion+"\t"+verano+"\t"+otonio+"\t"+invierno+"\t"+primavera+"\t"+totalCategoria);
            }else{
                System.out.format("%-32s %-10s %-10s %-10s %-10s %-10s",descripcion,verano,otonio,invierno,primavera,totalCategoria);
                System.out.println();
                //System.out.println(descripcion+"\t\t"+verano+"\t"+otonio+"\t"+invierno+"\t"+primavera+"\t"+totalCategoria);
            }
            ResultSet subCategorias = stmtDos.executeQuery(traerConsulta2(id, anio));
            while(subCategorias.next()){
                descripcion = subCategorias.getString("descrip");
                verano = subCategorias.getInt("verano");
                otonio = subCategorias.getInt("otonio");
                invierno = subCategorias.getInt("invierno");
                primavera = subCategorias.getInt("primavera");
                totalSubCategoria = totalSubCategoria + verano + otonio + invierno + primavera;
                if(descripcion.length()>12){
                    System.out.format("- %-30s %-10s %-10s %-10s %-10s %-10s",descripcion,verano,otonio,invierno,primavera,totalSubCategoria);
                    System.out.println();
                    //System.out.println("- "+descripcion+"\t"+verano+"\t"+otonio+"\t"+invierno+"\t"+primavera+"\t"+totalSubCategoria);
                }
                else{
                    System.out.format("- %-30s %-10s %-10s %-10s %-10s %-10s",descripcion,verano,otonio,invierno,primavera,totalSubCategoria);
                    System.out.println();
                    //System.out.println("- "+descripcion+"\t\t"+verano+"\t"+otonio+"\t"+invierno+"\t"+primavera+"\t"+totalSubCategoria);
                }
                totalSubCategoria = 0;
            }
            totalCategoria = 0;
        }
        System.out.format("%-32s %-10s %-10s %-10s %-10s %-10s","TOTAL",totalEstacion[0],totalEstacion[1],totalEstacion[2],totalEstacion[3],totalEstacion[4]);
        System.out.println();
        //System.out.println("TOTAL\t\t\t"+totalEstacion[0]+"\t"+totalEstacion[1]+"\t"+totalEstacion[2]+"\t"+totalEstacion[3]+"\t"+totalEstacion[4]+"\t");
    }

    public static String traerConsulta1(int anio) {
        return "SELECT cat.idcategoria as elId, cat.descripcion as descrip, "
                + "sum(CASE WHEN ven.fecha BETWEEN '01/01/" + anio + "' and '20/03/" + anio + "' and ven.fecha BETWEEN '21/12/" + anio + "' and '31/12/" + anio + "' THEN ven.montoventa ELSE 0 end) as verano, "
                + "sum(CASE WHEN ven.fecha BETWEEN '21/03/" + anio + "' and '21/06/" + anio + "' THEN ven.montoventa ELSE 0 end) as otonio, "
                + "sum(CASE WHEN ven.fecha BETWEEN '22/06/" + anio + "' and '23/09/" + anio + "' THEN ven.montoventa ELSE 0 end) as invierno, "
                + "sum(CASE WHEN ven.fecha BETWEEN '24/09/" + anio + "' and '20/12/" + anio + "' THEN ven.montoventa ELSE 0 end) as primavera "
                + "FROM ((VENTAS ven JOIN PRODUCTO pro ON ven.idproducto = pro.idproducto) JOIN subcategoria sub ON pro.idsubcat = sub.idsubcat) "
                + "JOIN CATEGORIA cat ON cat.idcategoria = sub.idcategoria GROUP BY cat.idcategoria, cat.descripcion";
    }

    public static String traerConsulta2(int id, int anio) {
        return "SELECT sub.descripcion as descrip, sum(CASE WHEN ven.fecha BETWEEN '01/01/" + anio + "' and '20/03/" + anio + "' and ven.fecha BETWEEN '21/12/" + anio + "' and '31/12/" + anio + "' THEN ven.montoventa ELSE 0 end) as verano, "
                + "sum(CASE WHEN ven.fecha BETWEEN '21/03/" + anio + "' and '21/06/" + anio + "' THEN ven.montoventa ELSE 0 end) as otonio, "
                + "sum(CASE WHEN ven.fecha BETWEEN '22/06/" + anio + "' and '23/09/" + anio + "' THEN ven.montoventa ELSE 0 end) as invierno, "
                + "sum(CASE WHEN ven.fecha BETWEEN '24/09/" + anio + "' and '20/12/" + anio + "' THEN ven.montoventa ELSE 0 end) as primavera "
                + "FROM ((VENTAS ven JOIN PRODUCTO pro ON ven.idproducto = pro.idproducto) JOIN subcategoria sub ON pro.idsubcat = sub.idsubcat) "
                + "JOIN CATEGORIA cat ON cat.idcategoria = sub.idcategoria WHERE sub.idcategoria = " + id + "GROUP BY sub.descripcion";
    }
}
