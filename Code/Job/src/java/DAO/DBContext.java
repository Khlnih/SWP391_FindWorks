package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBContext implements AutoCloseable {

    public Connection connection;

    public DBContext(){
        String user = "sa";
        String password = "123";
        String url = "jdbc:sqlserver://localhost:1433;databaseName=SU25_SWP391";
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
        String user = "sa";
        String password = "123";
        String url = "jdbc:sqlserver://localhost:1433;databaseName=SU25_SWP391_V2";
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(url, user, password);
    }

    /**
     * Đóng connection khi gọi close()
     */
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
