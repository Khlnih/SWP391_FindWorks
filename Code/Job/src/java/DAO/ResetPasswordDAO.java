package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ResetPasswordDAO {

    public boolean updatePasswordByEmail(String email, String newPassword) {
        String sql = "UPDATE Recruiter SET password = ? WHERE email_contact = ?"
                   + " OR EXISTS (SELECT 1 FROM Freelancer WHERE email_contact = ?)"
                   + " OR EXISTS (SELECT 1 FROM Admin WHERE email_contact = ?)";

        try (DBContext db = new DBContext()) {
            Connection conn = db.connection;

            // First, try updating Recruiter
            try (PreparedStatement ps = conn.prepareStatement(
                    "UPDATE Recruiter SET password = ? WHERE email_contact = ?")) {
                ps.setString(1, newPassword);
                ps.setString(2, email);
                int rows = ps.executeUpdate();
                if (rows > 0) return true;
            }

            // Next, try Freelancer
            try (PreparedStatement ps = conn.prepareStatement(
                    "UPDATE Freelancer SET password = ? WHERE email_contact = ?")) {
                ps.setString(1, newPassword);
                ps.setString(2, email);
                int rows = ps.executeUpdate();
                if (rows > 0) return true;
            }

            // Finally, try Admin
            try (PreparedStatement ps = conn.prepareStatement(
                    "UPDATE Admin SET password = ? WHERE email_contact = ?")) {
                ps.setString(1, newPassword);
                ps.setString(2, email);
                int rows = ps.executeUpdate();
                if (rows > 0) return true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
