package DAO;

import Model.Admin;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AdminDAO {
    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public AdminDAO() {
    }

    // Đăng nhập admin
    public Admin login(String username, String password) {
        String sql = "SELECT * FROM Admin WHERE username = ? AND password = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new Admin(
                    rs.getInt("adminID"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("first_name"),
                    rs.getString("last_name"),
                    rs.getString("phone"),
                    rs.getString("email"),
                    rs.getString("image"),
                    rs.getString("status")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Lấy danh sách tất cả admin
    public List<Admin> getAllAdmins() {
        List<Admin> list = new ArrayList<>();
        String sql = "SELECT * FROM Admin";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Admin(
                    rs.getInt("adminID"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("first_name"),
                    rs.getString("last_name"),
                    rs.getString("phone"),
                    rs.getString("email"),
                    rs.getString("image"),
                    rs.getString("status")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Thêm mới admin
    public boolean addAdmin(Admin admin) {
        String sql = "INSERT INTO Admin(username, password, first_name, last_name, phone, email, image, status) VALUES(?,?,?,?,?,?,?,?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, admin.getUsername());
            ps.setString(2, admin.getPassword());
            ps.setString(3, admin.getFirstName());
            ps.setString(4, admin.getLastName());
            ps.setString(5, admin.getPhone());
            ps.setString(6, admin.getEmail());
            ps.setString(7, admin.getImage());
            ps.setString(8, admin.getStatus());
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật thông tin admin
    public boolean updateAdmin(Admin admin) {
        String sql = "UPDATE Admin SET username = ?, password = ?, first_name = ?, last_name = ?, phone = ?, email = ?, image = ?, status = ? WHERE adminID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, admin.getUsername());
            ps.setString(2, admin.getPassword());
            ps.setString(3, admin.getFirstName());
            ps.setString(4, admin.getLastName());
            ps.setString(5, admin.getPhone());
            ps.setString(6, admin.getEmail());
            ps.setString(7, admin.getImage());
            ps.setString(8, admin.getStatus());
            ps.setInt(9, admin.getAdminID());
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa admin
    public boolean deleteAdmin(int adminID) {
        String sql = "DELETE FROM Admin WHERE adminID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, adminID);
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Kiểm tra username đã tồn tại
    public boolean checkUsernameExists(String username) {
        String sql = "SELECT * FROM Admin WHERE username = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
