package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import Model.UserLoginInfo;
import Model.Jobseeker;
import Model.Recruiter;
import Model.Admin;
public class loginDAO extends DBContext{

    public Jobseeker loginUserByJobseeker(String username, String password){
        String sql = "SELECT* FROM Freelancer WHERE username = ? OR email_contact = ? AND [password] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, username);
            ps.setString(3, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Jobseeker jobseeker = new Jobseeker();
                jobseeker.setFreelancerID(rs.getInt("freelancerID"));
                jobseeker.setUsername(rs.getString("username"));
                jobseeker.setPassword(rs.getString("password"));
                jobseeker.setFirst_Name(rs.getString("first_name"));
                jobseeker.setLast_Name(rs.getString("last_name"));
                jobseeker.setImage(rs.getString("image"));
                jobseeker.setGender(rs.getBoolean("gender"));
                jobseeker.setDob(rs.getDate("dob"));
                jobseeker.setDescribe(rs.getString("describe"));
                jobseeker.setEmail_contact(rs.getString("email_contact"));
                jobseeker.setPhone_contact(rs.getString("phone_contact"));
                jobseeker.setStatus(rs.getString("status"));
                jobseeker.setStatusChangedByAdminID(rs.getObject("statusChangedByAdminID") != null 
                    ? rs.getInt("statusChangedByAdminID") 
                    : null);

                return jobseeker;

            }
        } catch (SQLException e) {

        }
        
        return null;
    }
    
    public Recruiter loginUserByRecruiter(String username, String password) {
        String sql = "SELECT * FROM Recruiter WHERE (username = ? OR email_contact = ?) AND [password] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, username);  // Cho phép đăng nhập bằng email hoặc username
            ps.setString(3, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Recruiter recruiter = new Recruiter();
                recruiter.setRecruiterID(rs.getInt("recruiterID"));
                recruiter.setUsername(rs.getString("username"));
                recruiter.setPassword(rs.getString("password"));
                recruiter.setFirstName(rs.getString("first_name"));
                recruiter.setLastName(rs.getString("last_name"));
                recruiter.setGender(rs.getBoolean("gender"));
                recruiter.setDob(rs.getString("dob"));
                recruiter.setImage(rs.getString("image"));
                recruiter.setMoney(rs.getBigDecimal("money"));
                recruiter.setEmailContact(rs.getString("email_contact"));
                recruiter.setPhoneContact(rs.getString("phone_contact"));
                recruiter.setStatus(rs.getString("status"));
                recruiter.setStatusChangedByAdminID(
                    rs.getObject("statusChangedByAdminID") != null 
                    ? rs.getInt("statusChangedByAdminID") 
                    : null
                );

                return recruiter;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }
    public Admin loginUserByAdmin(String username, String password) {
        String sql = "SELECT * FROM Admin WHERE username = ?  AND [password_hash] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Admin admin = new Admin();
                admin.setAdminID(rs.getInt("adminID"));
                admin.setUsername(rs.getString("username"));
                admin.setPassword(rs.getString("password_hash"));
                admin.setFirstName(rs.getString("first_name"));
                admin.setLastName(rs.getString("last_name"));
                admin.setPhone(rs.getString("phone"));
                admin.setEmail(rs.getString("email_contact"));
                admin.setImage(rs.getString("image"));
                admin.setStatus(rs.getString("status"));

                return admin;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    
    
    
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
                    conn.setAutoCommit(true); 
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        }
        return false;
    }
}