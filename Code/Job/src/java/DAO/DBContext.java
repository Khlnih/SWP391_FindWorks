package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBContext implements AutoCloseable {

    public Connection connection;

    public DBContext(){
        String user = "SE1903";
        String password = "123456";
        String url = "jdbc:sqlserver://DESKTOP-H6G4KKB\\MSSQLSERVER01:1433;databaseName=SU25_SWP391_V2";
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, user, password);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Optional: static method để lấy Connection trực tiếp
     */
    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        String user = "SE1903";
        String password = "123456";
        String url = "jdbc:sqlserver://localhost:1433;databaseName=SU25_SWP391_V2";
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(url, user, password);
    }

    @Override
    public void close() {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}
