package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import Model.UserLoginInfo;

/**
 * DAO này chỉ chịu trách nhiệm cho các hoạt động liên quan đến người dùng Freelancer (Job Seeker).
 */
public class loginjobseekerDAO {

   
    
    public UserLoginInfo getUserLoginInfo(String userIdentifier) {
        // Thử tìm trong bảng Recruiter trước
        String recruiterSQL = "SELECT recruiterID, username, email_contact, password FROM Recruiter WHERE username = ? OR email_contact = ?";
        try (DBContext db = new DBContext()) {
            Connection conn = db.connection;
            try (PreparedStatement ps = conn.prepareStatement(recruiterSQL)) {
                ps.setString(1, userIdentifier);
                ps.setString(2, userIdentifier);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        return new UserLoginInfo(
                                rs.getInt("recruiterID"),
                                rs.getString("username"),
                                rs.getString("email_contact"),
                                rs.getString("password"),
                                "recruiter"
                        );
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Thử tìm trong bảng Freelancer
        String freelancerSQL = "SELECT freelancerID, username, email_contact, password FROM Freelancer WHERE username = ? OR email_contact = ?";
        try (DBContext db = new DBContext()) {
            Connection conn = db.connection;
            try (PreparedStatement ps = conn.prepareStatement(freelancerSQL)) {
                ps.setString(1, userIdentifier);
                ps.setString(2, userIdentifier);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        return new UserLoginInfo(
                                rs.getInt("freelancerID"),
                                rs.getString("username"),
                                rs.getString("email_contact"),
                                rs.getString("password"),
                                "freelancer"
                        );
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Thử tìm trong bảng Admin
        String adminSQL = "SELECT adminID, username, email_contact, password_hash FROM Admin WHERE username = ? OR email_contact = ?";
        try (DBContext db = new DBContext()) {
            Connection conn = db.connection;
            try (PreparedStatement ps = conn.prepareStatement(adminSQL)) {
                ps.setString(1, userIdentifier);
                ps.setString(2, userIdentifier);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        return new UserLoginInfo(
                                rs.getInt("adminID"),
                                rs.getString("username"),
                                rs.getString("email_contact"),
                                rs.getString("password_hash"),
                                "admin"
                        );
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * SỬA Ở ĐÂY: Hàm này chỉ kiểm tra sự tồn tại của email trong bảng Freelancer.
     * @param email Email cần kiểm tra.
     * @return true nếu email đã tồn tại trong bảng Freelancer, ngược lại false.
     */
    public boolean checkEmailExists(String email) {
        String sql = "SELECT 1 FROM Freelancer WHERE email_contact = ?";

        try (DBContext db = new DBContext()) {
            Connection conn = db.connection;
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, email);
                try (ResultSet rs = ps.executeQuery()) {
                    return rs.next(); // rs.next() sẽ trả về true nếu có kết quả
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * SỬA Ở ĐÂY: Hàm này chỉ cập nhật mật khẩu cho một Freelancer dựa trên email.
     * Không cần vòng lặp hay transaction phức tạp vì chỉ tác động lên một bảng.
     * @param email Email của freelancer cần cập nhật mật khẩu.
     * @param newPassword Mật khẩu mới.
     * @return true nếu cập nhật thành công (có 1 dòng bị ảnh hưởng), ngược lại false.
     */
    public boolean updatePasswordByEmail(String email, String newPassword) {
        String sql = "UPDATE Freelancer SET password = ? WHERE email_contact = ?";
        
        try (DBContext db = new DBContext()) {
            Connection conn = db.connection;
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, newPassword);
                ps.setString(2, email);
                int affectedRows = ps.executeUpdate();
                return affectedRows > 0; // Trả về true nếu có dòng được cập nhật
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}