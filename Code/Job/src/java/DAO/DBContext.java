    package DAO;

    import java.sql.Connection;
    import java.sql.DriverManager;
    import java.sql.SQLException;
    import java.util.logging.Level;
    import java.util.logging.Logger;

    public class DBContext {

        protected Connection connection;

        public DBContext() {
            try {
                String user = "sa";
                String pass = "123";
                String url = "jdbc:sqlserver://localhost\\SQLEXPRESS:1433;databaseName=SU25_SWP391;encrypt=true;trustServerCertificate=true";
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                connection = DriverManager.getConnection(url, user, pass);
            } catch (ClassNotFoundException | SQLException ex) {
                Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    Connection getConnection() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    }
