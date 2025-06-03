/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package DAO;

import Model.Freelancer;
import Model.UserLoginInfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class FreelancerDAO {

    // Kiểm tra trùng username
    public boolean isUsernameExist(String username) {
        String sql = "SELECT 1 FROM Freelancer WHERE username = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            return rs.next(); // nếu có dòng → đã tồn tại
        } catch (Exception e) {
            e.printStackTrace();
            return true; // lỗi thì coi như đã tồn tại để ngăn đăng ký
        }
    }

    // Kiểm tra trùng email
    public boolean isEmailExist(String email) {
        String sql = "SELECT 1 FROM Freelancer WHERE email__contact = ?";
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

    // Thêm freelancer mới
    public boolean registerFreelancer(Freelancer f) {
        String sql = "INSERT INTO Freelancer " +
                "(username, password, first_name, last_name, image, gender, dob, describe, email__contact, phone_contact, status, statusChangedByAdminID) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, f.getUsername());
            ps.setString(2, f.getPassword());
            ps.setString(3, f.getFirstName());
            ps.setString(4, f.getLastName());
            ps.setString(5, f.getImage());
            ps.setBoolean(6, f.isGender());
            ps.setString(7, f.getDob());
            ps.setString(8, f.getDescribe());
            ps.setString(9, f.getEmailContact());
            ps.setString(10, f.getPhoneContact());
            ps.setString(11, f.getStatus());
            if (f.getStatusChangedByAdminID() != null) {
                ps.setInt(12, f.getStatusChangedByAdminID());
            } else {
                ps.setNull(12, java.sql.Types.INTEGER);
            }

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public void updateFreelancer(Freelancer f) {
    String sql = "UPDATE Freelancer SET password=?, firstName=?, lastName=?, image=?, gender=?, dob=?, describe=?, email__contact=?, phoneContact=? WHERE freelanceID=?";
    try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, f.getPassword());
        ps.setString(2, f.getFirstName());
        ps.setString(3, f.getLastName());
        ps.setString(4, f.getImage());
        ps.setBoolean(5, f.isGender());
        ps.setString(6, f.getDob());
        ps.setString(7, f.getDescribe());
        ps.setString(8, f.getEmailContact());
        ps.setString(9, f.getPhoneContact());
        ps.setInt(10, f.getFreelanceID());
        ps.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
}
public UserLoginInfo getUserLoginInfoByUsername(String username) {
    String sql = "SELECT * FROM UserLoginInfo WHERE username = ?";
    try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return new UserLoginInfo(
                rs.getString("username"),
                rs.getString("email"),
                rs.getString("password")
            );
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return null;
}
   public Freelancer getFreelancerByUsername(String username) {
    String sql = "SELECT * FROM Freelancer WHERE username = ?";
    try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            Freelancer f = new Freelancer();
            f.setFreelanceID(rs.getInt("freelanceID"));
            f.setUsername(rs.getString("username"));
            f.setPassword(rs.getString("password"));
            f.setFirstName(rs.getString("firstName"));
            f.setLastName(rs.getString("lastName"));
            f.setImage(rs.getString("image"));
            f.setGender(rs.getBoolean("gender"));
            f.setDob(rs.getString("dob"));
            f.setDescribe(rs.getString("describe"));
            f.setEmailContact(rs.getString("email__contact"));
            f.setPhoneContact(rs.getString("phoneContact"));
            f.setStatus(rs.getString("status"));
            f.setStatusChangedByAdminID(rs.getInt("statusChangedByAdminID"));
            return f;
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return null;
}
}