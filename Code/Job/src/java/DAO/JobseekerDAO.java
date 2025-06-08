package DAO;

import Model.Jobseeker;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class JobseekerDAO extends DBContext {
    
    public boolean deleteJobseeker(int id) {
        if (connection == null) {
            System.err.println("Database connection is null");
            return false;
        }
        
        String sql = "UPDATE Freelancer SET status = 'inactive' WHERE freelancerID = ?";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, id);
            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error deleting jobseeker: " + e.getMessage());
            return false;
        }
    }

    public ArrayList<Jobseeker> getAllJobSeeker() {
        ArrayList<Jobseeker> list = new ArrayList<>();
        
        if (connection == null) {
            System.err.println("Database connection is null");
            return list;
        }
        
        String sql = "SELECT * FROM Freelancer WHERE status != 'inactive' ";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
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
                jobseeker.setStatusChangedByAdminID(rs.getInt("statusChangedByAdminID") != 0 ? rs.getInt("statusChangedByAdminID") : null);
                
                list.add(jobseeker);
            }
            System.out.println("Found " + list.size() + " jobseekers");
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error getting jobseekers: " + e.getMessage());
        }
        
        return list;
    }

    public boolean updateStatus(int id, String status) {
        if (connection == null) {
            System.err.println("Database connection is null");
            return false;
        }
        
        String sql = "UPDATE Freelancer SET status = ? WHERE freelancerID = ?";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, status);
            stm.setInt(2, id);
            
            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error updating jobseeker status: " + e.getMessage());
            return false;
        }
    }
    
    
    public int countTotalJobseekers() {
        String sql = "SELECT COUNT(*) as total FROM Freelancer WHERE status != 'inactive'";
        try (PreparedStatement stm = connection.prepareStatement(sql);
             ResultSet rs = stm.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public int countSearchResults(String keyword, String searchBy) {
        String sql = "SELECT COUNT(*) as total FROM Freelancer WHERE status != 'inactive' AND ";
        
        switch(searchBy.toLowerCase()) {
            case "username":
                sql += "username LIKE ?";
                break;
            case "email":
                sql += "email_contact LIKE ?";
                break;
            case "phone":
                sql += "phone_contact LIKE ?";
                break;
            default: // search all
                sql += "(username LIKE ? OR email_contact LIKE ? OR phone_contact LIKE ? OR first_name LIKE ? OR last_name LIKE ?)";
                break;
        }
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            String searchTerm = "%" + keyword + "%";
            
            if (searchBy.equalsIgnoreCase("all")) {
                for (int i = 1; i <= 5; i++) {
                    stm.setString(i, searchTerm);
                }
            } else {
                stm.setString(1, searchTerm);
            }
            
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public ArrayList<Jobseeker> searchJobseekers(String keyword, String searchBy, int page, int pageSize) {
        ArrayList<Jobseeker> list = new ArrayList<>();
        if (connection == null) return list;
        
        String sql = "SELECT * FROM Freelancer WHERE status != 'inactive' AND ";
        
        switch(searchBy.toLowerCase()) {
            case "username":
                sql += "username LIKE ? ";
                break;
            case "email":
                sql += "email_contact LIKE ? ";
                break;
            case "phone":
                sql += "phone_contact LIKE ? ";
                break;
            default: // search all
                sql += "(username LIKE ? OR email_contact LIKE ? OR phone_contact LIKE ? OR first_name LIKE ? OR last_name LIKE ?) ";
                break;
        }
        
        sql += "ORDER BY freelancerID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            int offset = (page - 1) * pageSize;
            String searchTerm = "%" + keyword + "%";
            
            if (searchBy.equalsIgnoreCase("all")) {
                for (int i = 1; i <= 5; i++) {
                    stm.setString(i, searchTerm);
                }
                stm.setInt(6, offset);
                stm.setInt(7, pageSize);
            } else {
                stm.setString(1, searchTerm);
                stm.setInt(2, offset);
                stm.setInt(3, pageSize);
            }
            
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    list.add(extractJobseekerFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    private Jobseeker extractJobseekerFromResultSet(ResultSet rs) throws SQLException {
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
        jobseeker.setStatusChangedByAdminID(rs.getInt("statusChangedByAdminID") != 0 ? rs.getInt("statusChangedByAdminID") : null);
        return jobseeker;
    }
    
    public ArrayList<Jobseeker> getJobseekersByPage(int page, int pageSize) {
        ArrayList<Jobseeker> list = new ArrayList<>();
        
        if (connection == null) {
            System.err.println("Database connection is null");
            return list;
        }
        
        int offset = (page - 1) * pageSize;
        String sql = "SELECT * FROM Freelancer WHERE status != 'inactive' ORDER BY freelancerID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, offset);
            stm.setInt(2, pageSize);
            
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    list.add(extractJobseekerFromResultSet(rs));
                }
            } catch (SQLException e) {
                e.printStackTrace();
                System.err.println("Error getting paginated jobseekers: " + e.getMessage());
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error preparing statement: " + e.getMessage());
        }
        
        return list;
    }
    
    // Các phương thức đã được đơn giản hóa và loại bỏ trùng lặp
    public Jobseeker getJobseekerById(int id) {
        if (connection == null) {
            System.err.println("Database connection is null");
            return null;
        }
        
        String sql = "SELECT * FROM Freelancer WHERE freelancerID = ?";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            
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
                jobseeker.setStatusChangedByAdminID(rs.getInt("statusChangedByAdminID") != 0 ? rs.getInt("statusChangedByAdminID") : null);
                
                return jobseeker;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error getting jobseeker by ID: " + e.getMessage());
        }
        
        return null;
    }
}
