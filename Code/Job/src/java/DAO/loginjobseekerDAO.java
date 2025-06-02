package DAO; // Đã đổi từ dal sang DAO theo file bạn cung cấp

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import Model.UserLoginInfo; // Đảm bảo UserLoginInfo đã được cập nhật

public class loginjobseekerDAO {

    /**
     * Lấy thông tin đăng nhập (email và password hash) cho người dùng dựa trên email.
     * Tìm kiếm trong các bảng Freelancer, Recruiter, và Admin.
     *
     * @param email Email của người dùng.
     * @return UserLoginInfo nếu tìm thấy, ngược lại null.
     */
    public UserLoginInfo getUserLoginInfo(String email) {
        // Giả sử cột lưu mật khẩu băm có tên là 'password_hash' trong Freelancer, Recruiter
        // và 'password' trong Admin (nhưng nên thống nhất và đảm bảo đó là hash)
        String sql =
                "SELECT email__contact AS email, password_hash AS password FROM Freelancer WHERE email__contact = ? " +
                "UNION ALL " +
                "SELECT email_contact AS email, password_hash AS password FROM Recruiter WHERE email_contact = ? " +
                "UNION ALL " +
                "SELECT email, password AS password FROM Admin WHERE email = ?"; // Nếu Admin.password cũng là hash

        // Sử dụng try-with-resources cho DBContext nếu nó implement AutoCloseable
        // Nếu DBContext không implement AutoCloseable, bạn cần quản lý đóng nó thủ công.
        // Giả sử DBContext xử lý việc đóng connection riêng của nó.
        DBContext db = new DBContext(); // Cần đảm bảo DBContext được quản lý đúng cách
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = db.connection; // Lấy connection từ DBContext
            if (conn == null) {
                System.err.println("Database connection is null in loginjobseekerDAO.getUserLoginInfo");
                return null;
            }
            ps = conn.prepareStatement(sql);
            ps.setString(1, email); // Cho Freelancer
            ps.setString(2, email); // Cho Recruiter
            ps.setString(3, email); // Cho Admin

            rs = ps.executeQuery();
            if (rs.next()) {
                // UserLoginInfo giờ chỉ nhận email và password
                return new UserLoginInfo(
                        rs.getString("email"),
                        rs.getString("password") // Đây nên là password hash từ DB
                );
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Cân nhắc sử dụng một framework logging tốt hơn
        } finally {
            // Đóng ResultSet, PreparedStatement. Connection thường được DBContext quản lý.
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                // Nếu DBContext không tự đóng connection, bạn cần đóng ở đây hoặc trong khối try-with-resources của DBContext
                // if (conn != null && !conn.isClosed() && db.shouldCloseConnectionManually()) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            // Nếu DBContext cần được đóng (ví dụ nó không phải AutoCloseable và cần gọi hàm close())
            // db.close(); // Hoặc phương thức tương tự
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
        String sql = "SELECT email__contact AS email FROM Freelancer WHERE email__contact = ? "
                   + "UNION ALL "
                   + "SELECT email_contact AS email FROM Recruiter WHERE email_contact = ? "
                   + "UNION ALL "
                   + "SELECT email FROM Admin WHERE email = ?";

        DBContext db = new DBContext();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = db.connection;
             if (conn == null) {
                System.err.println("Database connection is null in loginjobseekerDAO.checkEmailExists");
                return false;
            }
            ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, email);
            ps.setString(3, email);

            rs = ps.executeQuery();
            return rs.next(); // Trả về true nếu có ít nhất một dòng kết quả
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            // db.close(); // Nếu cần
        }
        return false;
    }

    /**
     * Cập nhật mật khẩu cho người dùng dựa trên email.
     * LƯU Ý: newPassword NÊN LÀ MẬT KHẨU ĐÃ ĐƯỢC BĂM AN TOÀN trước khi truyền vào hàm này.
     *
     * @param email Email của người dùng cần cập nhật mật khẩu.
     * @param newHashedPassword Mật khẩu MỚI ĐÃ ĐƯỢC BĂM.
     * @return true nếu cập nhật thành công ở một trong các bảng, false nếu không.
     */
    public boolean updatePasswordByEmail(String email, String newHashedPassword) {
        // Giả sử các cột mật khẩu là password_hash trong Freelancer, Recruiter và password trong Admin
        String[] updateSQLs = {
            "UPDATE Freelancer SET password_hash = ? WHERE email__contact = ?",
            "UPDATE Recruiter SET password_hash = ? WHERE email_contact = ?",
            "UPDATE Admin SET password = ? WHERE email = ?" // Nếu Admin.password cũng là hash
        };

        DBContext db = new DBContext();
        Connection conn = null;
        boolean updatedSuccessfully = false;

        try {
            conn = db.connection;
             if (conn == null) {
                System.err.println("Database connection is null in loginjobseekerDAO.updatePasswordByEmail");
                return false;
            }
            // Cân nhắc việc bắt đầu một transaction ở đây nếu bạn muốn tất cả các update thành công hoặc không gì cả
            // conn.setAutoCommit(false);

            for (String sql : updateSQLs) {
                try (PreparedStatement ps = conn.prepareStatement(sql)) { // PreparedStatement nên được đóng trong vòng lặp
                    ps.setString(1, newHashedPassword);
                    ps.setString(2, email);
                    int affectedRows = ps.executeUpdate();
                    if (affectedRows > 0) {
                        updatedSuccessfully = true;
                        // Nếu bạn muốn dừng ngay khi cập nhật được một bảng, có thể bỏ comment dòng dưới
                        // break; // hoặc return true;
                    }
                }
            }

            // Nếu sử dụng transaction:
            // if (updatedSuccessfully) {
            // conn.commit();
            // } else {
            // conn.rollback(); // Có thể không cần rollback nếu chỉ có 1 update thành công là đủ
            // }

        } catch (SQLException e) {
            e.printStackTrace();
            // Nếu sử dụng transaction và có lỗi:
            // try { if (conn != null) conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            return false; // Trả về false nếu có lỗi SQL
        } finally {
            // Nếu sử dụng transaction, khôi phục auto-commit
            // try { if (conn != null) conn.setAutoCommit(true); } catch (SQLException ex) { ex.printStackTrace(); }
            // DBContext sẽ quản lý việc đóng connection chính nó, hoặc bạn phải đóng ở đây.
            // try { if (conn != null && !conn.isClosed()) conn.close(); } catch (SQLException ex) { ex.printStackTrace(); }
            // db.close(); // Nếu cần
        }
        return updatedSuccessfully;
    }
}