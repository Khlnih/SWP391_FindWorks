package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import Model.UserLoginInfo; // Đảm bảo lớp UserLoginInfo đã được cập nhật không còn username

public class loginDAO {

    /**
     * Lấy thông tin đăng nhập (email và password hash) cho người dùng dựa trên email.
     *
     * @param email Email của người dùng.
     * @return UserLoginInfo nếu tìm thấy, ngược lại null.
     */
    public UserLoginInfo getUserLoginInfo(String email) {
        // Giả sử cột lưu mật khẩu băm có tên là 'password_hash' trong Recruiter và Freelancer
        // và 'password' trong Admin (nhưng nên thống nhất và đảm bảo đó là hash)
        String sql =
                "SELECT email_contact AS email, password_hash AS password FROM Recruiter WHERE email_contact = ? " +
                "UNION ALL " +
                "SELECT email_contact AS email, password_hash AS password FROM Freelancer WHERE email_contact = ? " +
                "UNION ALL " +
                "SELECT email, password_hash AS password FROM Admin WHERE email = ?"; // Nếu Admin.password cũng là hash

        try (DBContext db = new DBContext()) {
            Connection conn = db.connection;
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, email); // Cho Recruiter
                ps.setString(2, email); // Cho Freelancer
                ps.setString(3, email); // Cho Admin

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        // UserLoginInfo giờ chỉ nhận email và password
                        return new UserLoginInfo(
                                rs.getString("email"),
                                rs.getString("password") // Đây nên là password hash từ DB
                        );
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Cân nhắc sử dụng một framework logging tốt hơn
        }
        return null;
    }

    /**
     * Kiểm tra xem một email đã tồn tại trong bất kỳ bảng người dùng nào chưa.
     *
     * @param email Email cần kiểm tra.
     * @return true nếu email tồn tại, false nếu không.
     */
    public boolean checkEmailExists(String email) {
        String sql = "SELECT email_contact AS email FROM Recruiter WHERE email_contact = ? "
                   + "UNION ALL "
                   + "SELECT email_contact AS email FROM Freelancer WHERE email_contact = ? "
                   + "UNION ALL "
                   + "SELECT email FROM Admin WHERE email = ?";

        try (DBContext db = new DBContext()) {
            Connection conn = db.connection;
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, email);
                ps.setString(2, email);
                ps.setString(3, email);

                try (ResultSet rs = ps.executeQuery()) {
                    return rs.next(); // Trả về true nếu có ít nhất một dòng kết quả
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Cập nhật mật khẩu cho người dùng dựa trên email.
     * LƯU Ý: newPassword NÊN LÀ MẬT KHẨU ĐÃ ĐƯỢC BĂM AN TOÀN trước khi truyền vào hàm này.
     * Nếu bạn truyền mật khẩu dạng plain text, bạn cần băm nó trước khi thực hiện ps.setString().
     *
     * @param email Email của người dùng cần cập nhật mật khẩu.
     * @param newHashedPassword Mật khẩu MỚI ĐÃ ĐƯỢC BĂM.
     * @return true nếu cập nhật thành công ở một trong các bảng, false nếu không.
     */
    public boolean updatePasswordByEmail(String email, String newHashedPassword) {
        // Giả sử các cột mật khẩu là password_hash trong Recruiter, Freelancer và password trong Admin
        String[] updateSQLs = {
            "UPDATE Recruiter SET password_hash = ? WHERE email_contact = ?",
            "UPDATE Freelancer SET password_hash = ? WHERE email_contact = ?",
            "UPDATE Admin SET password = ? WHERE email = ?" // Nếu Admin.password cũng là hash
        };

        try (DBContext db = new DBContext()) {
            Connection conn = db.connection; // Lấy connection một lần
            boolean updated = false;
            for (String sql : updateSQLs) {
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    // Tham số 1 là mật khẩu mới (đã băm)
                    ps.setString(1, newHashedPassword);
                    // Tham số 2 là email
                    ps.setString(2, email);

                    int affectedRows = ps.executeUpdate();
                    if (affectedRows > 0) {
                        updated = true; // Đánh dấu đã cập nhật thành công
                        // Nếu bạn muốn chỉ cập nhật ở bảng đầu tiên tìm thấy và dừng lại:
                        // return true;
                    }
                }
            }
            return updated; // Trả về true nếu có ít nhất một bảng được cập nhật
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}