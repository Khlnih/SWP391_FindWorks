package DAO;

import Model.Jobseeker;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class JobseekerDAO {
    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public JobseekerDAO() {
    }

    // Đăng nhập jobseeker
    public Jobseeker login(String username, String password) {
        String sql = "SELECT * FROM Freelancer WHERE username = ? AND password = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new Jobseeker(
                    rs.getInt("freelanceID"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("first_name"),
                    rs.getString("last_name"),
                    rs.getString("image"),
                    rs.getBoolean("gender"),
                    rs.getDate("dob"),
                    rs.getString("describe"),
                    rs.getString("email__contact"),
                    rs.getString("phone_contact"),
                    rs.getString("status")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Lấy danh sách tất cả jobseeker
    public List<Jobseeker> getAllJobseekers() {
        List<Jobseeker> list = new ArrayList<>();
        String sql = "SELECT * FROM Freelancer";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Jobseeker jobseeker = new Jobseeker(
                    rs.getInt("freelanceID"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("first_name"),
                    rs.getString("last_name"),
                    rs.getString("image"),
                    rs.getBoolean("gender"),
                    rs.getDate("dob"),
                    rs.getString("describe"),
                    rs.getString("email__contact"),
                    rs.getString("phone_contact"),
                    rs.getString("status")
                );
                jobseeker.setEducations(getEducationsByFreelancerID(jobseeker.getFreelanceID()));
                jobseeker.setExperiences(getExperiencesByFreelancerID(jobseeker.getFreelanceID()));
                jobseeker.setSkills(getSkillsByFreelancerID(jobseeker.getFreelanceID()));
                list.add(jobseeker);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy thông tin học vấn của jobseeker
    public List<Model.Education> getEducationsByFreelancerID(int freelancerID) {
        List<Model.Education> list = new ArrayList<>();
        String sql = "SELECT * FROM Education WHERE freelanceID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, freelancerID);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Model.Education(
                    rs.getInt("educationID"),
                    rs.getString("university_name"),
                    rs.getDate("start_date"),
                    rs.getDate("end_date"),
                    rs.getInt("freelanceID"),
                    rs.getInt("degreeID")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy thông tin kinh nghiệm làm việc của jobseeker
    public List<Model.Experience> getExperiencesByFreelancerID(int freelancerID) {
        List<Model.Experience> list = new ArrayList<>();
        String sql = "SELECT * FROM Experience WHERE freelanceID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, freelancerID);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Model.Experience(
                    rs.getInt("experienceID"),
                    rs.getString("experience_work_name"),
                    rs.getString("position"),
                    rs.getDate("start_date"),
                    rs.getDate("end_date"),
                    rs.getString("your_project"),
                    rs.getInt("freelanceID")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy thông tin kỹ năng của jobseeker
    public List<Model.Skills> getSkillsByFreelancerID(int freelancerID) {
        List<Model.Skills> list = new ArrayList<>();
        String sql = "SELECT s.*, ss.skill_set_name 
                     FROM Skills s 
                     JOIN Skill_Set ss ON s.skill_set_ID = ss.skill_set_ID 
                     WHERE s.freelancerID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, freelancerID);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Model.Skills(
                    rs.getInt("skillID"),
                    rs.getInt("skill_set_ID"),
                    rs.getInt("freelancerID"),
                    rs.getInt("level"),
                    rs.getString("skill_set_name")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Thêm mới jobseeker
    public boolean addJobseeker(Jobseeker jobseeker) {
        String sql = "INSERT INTO Freelancer(username, password, first_name, last_name, image, gender, dob, describe, email__contact, phone_contact, status) VALUES(?,?,?,?,?,?,?,?,?,?,?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, jobseeker.getUsername());
            ps.setString(2, jobseeker.getPassword());
            ps.setString(3, jobseeker.getFirstName());
            ps.setString(4, jobseeker.getLastName());
            ps.setString(5, jobseeker.getImage());
            ps.setBoolean(6, jobseeker.isGender());
            ps.setDate(7, jobseeker.getDob());
            ps.setString(8, jobseeker.getDescribe());
            ps.setString(9, jobseeker.getEmailContact());
            ps.setString(10, jobseeker.getPhoneContact());
            ps.setString(11, jobseeker.getStatus());
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật thông tin jobseeker
    public boolean updateJobseeker(Jobseeker jobseeker) {
        String sql = "UPDATE Freelancer SET username = ?, password = ?, first_name = ?, last_name = ?, image = ?, gender = ?, dob = ?, describe = ?, email__contact = ?, phone_contact = ?, status = ? WHERE freelanceID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, jobseeker.getUsername());
            ps.setString(2, jobseeker.getPassword());
            ps.setString(3, jobseeker.getFirstName());
            ps.setString(4, jobseeker.getLastName());
            ps.setString(5, jobseeker.getImage());
            ps.setBoolean(6, jobseeker.isGender());
            ps.setDate(7, jobseeker.getDob());
            ps.setString(8, jobseeker.getDescribe());
            ps.setString(9, jobseeker.getEmailContact());
            ps.setString(10, jobseeker.getPhoneContact());
            ps.setString(11, jobseeker.getStatus());
            ps.setInt(12, jobseeker.getFreelanceID());
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa jobseeker
    public boolean deleteJobseeker(int freelanceID) {
        String sql = "DELETE FROM Freelancer WHERE freelanceID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, freelanceID);
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Kiểm tra username đã tồn tại
    public boolean checkUsernameExists(String username) {
        String sql = "SELECT * FROM Freelancer WHERE username = ?";
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

    // Lấy thông tin jobseeker theo ID
    public Jobseeker getJobseekerByID(int freelanceID) {
        String sql = "SELECT * FROM Freelancer WHERE freelanceID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, freelanceID);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new Jobseeker(
                    rs.getInt("freelanceID"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("first_name"),
                    rs.getString("last_name"),
                    rs.getString("image"),
                    rs.getBoolean("gender"),
                    rs.getDate("dob"),
                    rs.getString("describe"),
                    rs.getString("email__contact"),
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
