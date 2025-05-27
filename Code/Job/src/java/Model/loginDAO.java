package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import Model.UserLoginInfo;

public class loginDAO {

    public UserLoginInfo getUserLoginInfo(String userIdentifier) {
        String sql
                = "SELECT username, email_contact AS email, password FROM Recruiter WHERE username = ? OR email_contact = ? "
                + "UNION ALL "
                + "SELECT username, email__contact AS email, password FROM Freelancer WHERE username = ? OR email__contact = ? "
                + "UNION ALL "
                + "SELECT username, email, password FROM Admin WHERE username = ? OR email = ?";

        try (DBContext db = new DBContext()) {
            Connection conn = db.connection;
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, userIdentifier);
                ps.setString(2, userIdentifier);
                ps.setString(3, userIdentifier);
                ps.setString(4, userIdentifier);
                ps.setString(5, userIdentifier);
                ps.setString(6, userIdentifier);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        return new UserLoginInfo(
                                rs.getString("username"),
                                rs.getString("email"),
                                rs.getString("password")
                        );
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    public boolean checkEmailExists(String email) {
    String sql = "SELECT email_contact AS email FROM Recruiter WHERE email_contact = ? "
               + "UNION ALL "
               + "SELECT email__contact AS email FROM Freelancer WHERE email__contact = ? "
               + "UNION ALL "
               + "SELECT email FROM Admin WHERE email = ?";

    try (DBContext db = new DBContext()) {
        Connection conn = db.connection;
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, email);
            ps.setString(3, email);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}


    public boolean updatePasswordByEmail(String email, String newPassword) {
        String[] updateSQLs = {
            "UPDATE Recruiter SET password = ? WHERE email_contact = ?",
            "UPDATE Freelancer SET password = ? WHERE email__contact = ?",
            "UPDATE Admin SET password = ? WHERE email = ?"
        };

        try (DBContext db = new DBContext()) {
            for (String sql : updateSQLs) {
                try (PreparedStatement ps = db.connection.prepareStatement(sql)) {
                    ps.setString(1, newPassword);
                    ps.setString(2, email);
                    int affected = ps.executeUpdate();
                    if (affected > 0) return true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

}