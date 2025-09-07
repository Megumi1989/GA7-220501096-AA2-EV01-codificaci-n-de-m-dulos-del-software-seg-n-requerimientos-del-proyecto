
package com.mycompany.jdbctest;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Jdbctest {

    public static void main(String[] args) {
      String usuario = "root";
      String contraseña = "987654";
      String url ="jdbc:mysql://localhost:3306/jdbctest";
        Connection conexion;
        Statement statement;
        ResultSet rs;
        try {
            //1.  Crea la conexion con la base de datos
            conexion = DriverManager.getConnection(url,usuario,contraseña);
            
            //2. Realizar la consulta con la base de datos
            statement = conexion.createStatement();
            rs = statement.executeQuery("SELECT * FROM usuarios");
            while(rs.next()){
                System.out.println(rs.getString("nombres"));
            }
            
            //3. Insertar un registro en la BD
            statement.execute("INSERT INTO usuarios (nombres, apellidos, email) VALUES ('Jairo','Matallana','Jairr@hotmail.com')");
            System.out.println("");
            rs = statement.executeQuery("SELECT * FROM usuarios");
            while(rs.next()){
                System.out.println(rs.getString("nombres"));
            }
            //4. Actualización de datos registros en la BD.      
            statement.execute("UPDATE `usuarios` SET `nombres` = 'Angie', `apellidos` = 'Mendoza', `email` = 'cambiocorreo1@corre.com ' WHERE (`id` = '2');");
            System.out.println("");
            rs = statement.executeQuery("SELECT * FROM usuarios");
            while(rs.next()){
                System.out.printf("%s %s %s%n",
                rs.getString("nombres"),
                rs.getString("apellidos"),
                rs.getString("email")
                );
            }
            
            //5. Borrado o eliminación de datos
            statement.execute("DELETE FROM `usuarios` WHERE (`id` = '3');");            
            System.out.println("");
            rs = statement.executeQuery("SELECT * FROM usuarios");
            while(rs.next()){
                System.out.printf("%s %s %s%n",
                rs.getString("nombres"),
                rs.getString("apellidos"),
                rs.getString("email")
                );
            }
             
        } catch (SQLException ex) {
            Logger.getLogger(Jdbctest.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }
}
