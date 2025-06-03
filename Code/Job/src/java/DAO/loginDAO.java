package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import Model.UserLoginInfo;

public class loginDAO {

    public UserLoginInfo getUserLoginInfo(String userIdentifier) {
        String sql =
                "SELECT username, email_contact AS email_retrieved, password AS password FROM Recruiter WHERE username = ? OR email_contact = ? "
                + "UNION ALL "
                + "SELECT username, email_contact AS email_retrieved, password AS password FROM Freelancer WHERE username = ? OR email_contact = ? "
                + "UNION ALL "
                + "SELECT username, email_contact AS email_retrieved, password_hash AS password FROM Admin WHERE username = ? OR email_contact = ?";

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
                                rs.getString("email_retrieved"),
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

    public boolean checkEmailExists(String emailContact) {
        String sql = "SELECT email_contact_contact AS email_column FROM Recruiter WHERE email_contact_contact = ? "
                   + "UNION ALL "
                   + "SELECT email_contact_contact AS email_column FROM Freelancer WHERE email_contact_contact = ? "
                   + "UNION ALL "
                   + "SELECT email_contact AS email_column FROM Admin WHERE email_contact = ?";

        try (DBContext db = new DBContext()) {
            Connection conn = db.connection;
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, emailContact);
                ps.setString(2, emailContact);
                ps.setString(3, emailContact);

                try (ResultSet rs = ps.executeQuery()) {
                    return rs.next();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updatePasswordByEmail(String emailContact, String newPassword) {
        String[] updateSQLs = {
            "UPDATE Recruiter SET password = ? WHERE email_contact_contact = ?",
            "UPDATE Freelancer SET password = ? WHERE email_contact_contact = ?",
            "UPDATE Admin SET password = ? WHERE email_contact = ?"
        };

        boolean emailFoundAndUpdated = false;
        Connection conn = null;
        try (DBContext db = new DBContext()) {
            conn = db.connection;
            conn.setAutoCommit(false);

            for (String sql : updateSQLs) {
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setString(1, newPassword);
                    ps.setString(2, emailContact);
                    int affectedRows = ps.executeUpdate();
                    if (affectedRows > 0) {
                        emailFoundAndUpdated = true;
                    }
                }
            }

            if (emailFoundAndUpdated) {
                conn.commit();
                return true;
            } else {
                conn.rollback();
                return false;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true); // Restore default auto-commit behavior
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        }
        return false;
    }
}