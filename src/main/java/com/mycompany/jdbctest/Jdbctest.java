
package com.mycompany.jdbctest;

import java.sql.*;
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Jdbctest {

    public static void main(String[] args) {
        String usuario = "root";
        String contraseña = "987654";
        String url = "jdbc:mysql://localhost:3306/jdbctest";

        try (Connection conexion = DriverManager.getConnection(url, usuario, contraseña);
             Scanner sc = new Scanner(System.in)) {

            int opcion;
            do {
                System.out.println("\n===== MENU USUARIOS =====");
                System.out.println("Por favor ingrese/digite la opción de la acción que necesite realizar con los registros de Usuarios en la Base de datos : 1, 2, 3 etc...");
                System.out.println("1. Consultar usuarios");
                System.out.println("2. Insertar usuario");
                System.out.println("3. Actualizar usuario");
                System.out.println("4. Eliminar usuario");
                System.out.println("5. Salir");
                System.out.print("Elija una opción: ");
                opcion = sc.nextInt();
                sc.nextLine(); // Toma o lee la linea completa de texto o bueno la entrada que realiza en consola el cliente 

                switch (opcion) { //
                    case 1 -> consultarUsuarios(conexion);
                    case 2 -> insertarUsuario(conexion, sc);
                    case 3 -> actualizarUsuario(conexion, sc);
                    case 4 -> eliminarUsuario(conexion, sc);
                    case 5 -> System.out.println("Saliendo del Menu ...");
                    default -> System.out.println("Opción no válida, por favor intentelo de nuevo, GRACIAS.");
                }

            } while (opcion != 5);

        } catch (SQLException ex) {
            Logger.getLogger(Jdbctest.class.getName()).log(Level.SEVERE, null, ex); // Esto corresponde al try bueno si sale un error lo especificara en la consola
        }
    }

    // Consultar todos los usuarios
    private static void consultarUsuarios(Connection conexion) throws SQLException {
        String sql = "SELECT * FROM usuarios";
        try (Statement st = conexion.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            System.out.println("\nLista de usuarios actualmeente registrados en la BD (tabla usuarios):");
            while (rs.next()) {
                System.out.printf("%d | %s %s | %s%n",
                        rs.getInt("idUsuario"),
                        rs.getString("Nombres"),
                        rs.getString("Apellidos"),
                        rs.getString("Email"));
            }
        }
    }

    // Insertar usuario
    private static void insertarUsuario(Connection conexion, Scanner sc) throws SQLException {
        System.out.print("Ingrese los nombres del nuevo usuario: ");
        String nombre = sc.nextLine();
        System.out.print("Ingrese los apellidos del nuevo usuario: ");
        String apellido = sc.nextLine();
        System.out.print("Ingrese el email del nuevo usuario: ");
        String email = sc.nextLine();

        String sql = "INSERT INTO usuarios (Nombres, Apellidos, Email) VALUES (?, ?, ?)";
        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setString(1, nombre);
            ps.setString(2, apellido);
            ps.setString(3, email);
            ps.executeUpdate();
            System.out.println("Nuevo usuario registrado exitosamente.\n");
            consultarUsuarios(conexion); // Reutilizamos el metodo para consultar los usuarios que quedan en la tbla usuarios y los muestra en consola
        }
    }

    // Actualizar usuario
    private static void actualizarUsuario(Connection conexion, Scanner sc) throws SQLException {
        System.out.print("Ingrese el ID del usuario que desea actualizar/modifciar: ");
        int id = sc.nextInt();
        sc.nextLine(); // toma el registro del dato de entrada (ID)

        System.out.print("Nuevo nombre del usuario seleccionado: ");
        String nombre = sc.nextLine();
        System.out.print("Nuevo apellido del usuario seleccionado: ");
        String apellido = sc.nextLine();
        System.out.print("Nuevo email del usuario seleccionado: ");
        String email = sc.nextLine();

        String sql = "UPDATE usuarios SET Nombres = ?, Apellidos = ?, Email = ? WHERE idUsuario = ?";
        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setString(1, nombre);
            ps.setString(2, apellido);
            ps.setString(3, email);
            ps.setInt(4, id);
            int filas = ps.executeUpdate();
            if (filas > 0) {
                System.out.println("Datos del usuario actualizados de manera exitosa.\n");
                 consultarUsuarios(conexion); // Reutilizamos el metodo para consultar los usuarios que quedan en la tbla usuarios y los muestra en consola
            } else {
                System.out.println("No se encontró un usuario con el ID especificado.");
            }
        }
    }

    // Eliminar usuario
    private static void eliminarUsuario(Connection conexion, Scanner sc) throws SQLException {
        System.out.print("Ingrese ID del usuario que desea eliminar de la tabla (base de datos): ");
        int id = sc.nextInt();
        sc.nextLine(); 

        String sql = "DELETE FROM usuarios WHERE idUsuario = ?";
        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setInt(1, id);
            int filas = ps.executeUpdate();
            if (filas > 0) {
                System.out.println("El usuario especificado ha diso eliminado.\n");
                consultarUsuarios(conexion); // Reutilizamos el metodo para consultar los usuarios que quedan en la tbla usuarios y los muestra en consola
            } else {
                System.out.println("No se encontró un usuario con el ID especificado.");
            }
        }
    }
}