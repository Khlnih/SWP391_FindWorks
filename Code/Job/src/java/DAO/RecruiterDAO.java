package DAO;

import Model.Recruiter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RecruiterDAO {
    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public RecruiterDAO() {
    }

    public Recruiter login(String username, String password) {
        String sql = "SELECT * FROM Recruiter WHERE username = ? AND password = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new Recruiter(
                    rs.getInt("recruiterID"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("first_name"),
                    rs.getString("last_name"),
                    rs.getBoolean("gender"),
                    rs.getDate("dob"),
                    rs.getString("image"),
                    rs.getInt("money"),
                    rs.getString("email_contact"),
                    rs.getString("phone_contact"),
                    rs.getString("status")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Recruiter> getAllRecruiters() {
        List<Recruiter> list = new ArrayList<>();
        String sql = "SELECT * FROM Recruiter";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Recruiter(
                    rs.getInt("recruiterID"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("first_name"),
                    rs.getString("last_name"),
                    rs.getBoolean("gender"),
                    rs.getDate("dob"),
                    rs.getString("image"),
                    rs.getInt("money"),
                    rs.getString("email_contact"),
                    rs.getString("phone_contact"),
                    rs.getString("status")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addRecruiter(Recruiter recruiter) {
        String sql = "INSERT INTO Recruiter(username, password, first_name, last_name, gender, dob, image, money, email_contact, phone_contact, status) VALUES(?,?,?,?,?,?,?,?,?,?,?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, recruiter.getUsername());
            ps.setString(2, recruiter.getPassword());
            ps.setString(3, recruiter.getFirstName());
            ps.setString(4, recruiter.getLastName());
            ps.setBoolean(5, recruiter.isGender());
            ps.setDate(6, recruiter.getDob());
            ps.setString(7, recruiter.getImage());
            ps.setInt(8, recruiter.getMoney());
            ps.setString(9, recruiter.getEmailContact());
            ps.setString(10, recruiter.getPhoneContact());
            ps.setString(11, recruiter.getStatus());
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateRecruiter(Recruiter recruiter) {
        String sql = "UPDATE Recruiter SET username = ?, password = ?, first_name = ?, last_name = ?, gender = ?, dob = ?, image = ?, money = ?, email_contact = ?, phone_contact = ?, status = ? WHERE recruiterID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, recruiter.getUsername());
            ps.setString(2, recruiter.getPassword());
            ps.setString(3, recruiter.getFirstName());
            ps.setString(4, recruiter.getLastName());
            ps.setBoolean(5, recruiter.isGender());
            ps.setDate(6, recruiter.getDob());
            ps.setString(7, recruiter.getImage());
            ps.setInt(8, recruiter.getMoney());
            ps.setString(9, recruiter.getEmailContact());
            ps.setString(10, recruiter.getPhoneContact());
            ps.setString(11, recruiter.getStatus());
            ps.setInt(12, recruiter.getRecruiterID());
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteRecruiter(int recruiterID) {
        String sql = "DELETE FROM Recruiter WHERE recruiterID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, recruiterID);
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean checkUsernameExists(String username) {
        String sql = "SELECT * FROM Recruiter WHERE username = ?";
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

    public Recruiter getRecruiterByCompany(int companyID) {
        String sql = "SELECT r.* FROM Recruiter r JOIN Company c ON r.recruiterID = c.recruiterID WHERE c.companyID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, companyID);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new Recruiter(
                    rs.getInt("recruiterID"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("first_name"),
                    rs.getString("last_name"),
                    rs.getBoolean("gender"),
                    rs.getDate("dob"),
                    rs.getString("image"),
                    rs.getInt("money"),
                    rs.getString("email_contact"),
                    rs.getString("phone_contact"),
                    rs.getString("status")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
