package it.unisa.connection;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    private static final String DATABASE_URL = "jdbc:mysql://localhost:3306/ecommerce";

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(DATABASE_URL,"root","");
    }

    public static boolean testConnection() {
        try {
            Connection connection = getConnection();
            if (connection != null) {
                connection.close();
                return true;
            }
        } catch (SQLException | ClassNotFoundException ex) {
            // Gestisci l'eccezione come preferisci
        }
        return false;
    }
}