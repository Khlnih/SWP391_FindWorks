package DAO;

import Model.Freelancer;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class FreelancerDAO {

    // Kiểm tra username đã tồn tại chưa
    public boolean isUsernameExist(String username) {
        String sql = "SELECT 1 FROM Freelancer WHERE username = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
            return true;
        }
    }

    // Kiểm tra email đã tồn tại chưa
    public boolean isEmailExist(String email) {
        String sql = "SELECT 1 FROM Freelancer WHERE email_contact = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
            return true;
        }
    }

    // Đăng ký freelancer mới
    public boolean registerFreelancer(Freelancer f) {
        String sql = "INSERT INTO Freelancer (username, password_hash, first_name, last_name, image, gender, dob, describe, email_contact, phone_contact, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, f.getUsername());
            ps.setString(2, f.getPassword());
            ps.setString(3, f.getFirstName());
            ps.setString(4, f.getLastName());
            ps.setString(5, f.getImage());
            ps.setBoolean(6, f.isGender());
            ps.setDate(7, f.getDob());
            ps.setString(8, f.getDescribe());
            ps.setString(9, f.getEmailContact());
            ps.setString(10, f.getPhoneContact());
            ps.setString(11, f.getStatus());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Đăng nhập: tìm freelancer theo username và password
    public Freelancer login(String username, String password) {
        String sql = "SELECT * FROM Freelancer WHERE username = ? AND password_hash = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapResultSetToFreelancer(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Lấy freelancer theo ID
    public Freelancer getFreelancerByID(int id) {
        String sql = "SELECT * FROM Freelancer WHERE freelanceID = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapResultSetToFreelancer(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Cập nhật thông tin freelancer (trừ password)
    public boolean updateFreelancer(Freelancer f) {
        String sql = "UPDATE Freelancer SET first_name = ?, last_name = ?, image = ?, gender = ?, dob = ?, describe = ?, email_contact = ?, phone_contact = ?, status = ? " +
                     "WHERE freelanceID = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, f.getFirstName());
            ps.setString(2, f.getLastName());
            ps.setString(3, f.getImage());
            ps.setBoolean(4, f.isGender());
            ps.setDate(5, f.getDob());
            ps.setString(6, f.getDescribe());
            ps.setString(7, f.getEmailContact());
            ps.setString(8, f.getPhoneContact());
            ps.setString(9, f.getStatus());
            ps.setInt(10, f.getFreelanceID());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Helper: Chuyển ResultSet -> Freelancer
    private Freelancer mapResultSetToFreelancer(ResultSet rs) throws Exception {
        Freelancer f = new Freelancer();
        f.setFreelanceID(rs.getInt("freelanceID"));
        f.setUsername(rs.getString("username"));
        f.setPassword(rs.getString("password_hash"));
        f.setFirstName(rs.getString("first_name"));
        f.setLastName(rs.getString("last_name"));
        f.setImage(rs.getString("image"));
        f.setGender(rs.getBoolean("gender"));
        f.setDob(rs.getDate("dob"));
        f.setDescribe(rs.getString("describe"));
        f.setEmailContact(rs.getString("email_contact"));
        f.setPhoneContact(rs.getString("phone_contact"));
        f.setStatus(rs.getString("status"));
        return f;
    }
}
