package DAO;

import Model.Jobseeker;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import Model.FreelancerLocation;

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
    public boolean updateDes(String id, String describe) {
        if (connection == null) {
            System.err.println("Database connection is null");
            return false;
        }
        
        String sql = "UPDATE Freelancer SET describe = ? WHERE freelancerID = ?";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, describe);
            stm.setString(2, id);
            
            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error updating jobseeker describe: " + e.getMessage());
            return false;
        }
    }
    
    public boolean updateContact(String id, String email, String phone ) {
        if (connection == null) {
            System.err.println("Database connection is null");
            return false;
        }
        
        String sql = "Update Freelancer SET email_contact = ? , phone_contact = ? WHERE freelancerID = ?";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, email);
            stm.setString(2, phone);
            stm.setString(3, id);
            
            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error updating jobseeker describe: " + e.getMessage());
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
        // Normalize the keyword by trimming and replacing multiple spaces with a single space
        String normalizedKeyword = keyword.trim().replaceAll("\\s+", " ");
        
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
            case "name":
                // Split normalized keywords by space and create conditions for each word
                String[] keywords = normalizedKeyword.split(" ");
                StringBuilder nameCondition = new StringBuilder();
                
                for (int i = 0; i < keywords.length; i++) {
                    if (i > 0) {
                        nameCondition.append(" AND ");
                    }
                    nameCondition.append("(LOWER(first_name) LIKE LOWER(?) OR LOWER(last_name) LIKE LOWER(?))");
                }
                sql += "(" + nameCondition.toString() + ")";
                break;
            default: // search all
                sql += "(username LIKE ? OR email_contact LIKE ? OR phone_contact LIKE ? OR first_name LIKE ? OR last_name LIKE ?)";
                break;
        }
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            int paramIndex = 1;
            
            if (searchBy.equalsIgnoreCase("all")) {
                String searchTerm = "%" + keyword + "%";
                for (int i = 0; i < 5; i++) {
                    stm.setString(paramIndex++, searchTerm);
                }
            } else if (searchBy.equalsIgnoreCase("name")) {
                String[] keywords = keyword.trim().split("\\s+");
                for (String kw : keywords) {
                    String searchTerm = "%" + kw + "%";
                    stm.setString(paramIndex++, searchTerm); // first_name
                    stm.setString(paramIndex++, searchTerm); // last_name
                }
            } else {
                String searchTerm = "%" + keyword + "%";
                stm.setString(paramIndex++, searchTerm);
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
        
        // Normalize the keyword by trimming and replacing multiple spaces with a single space
        String normalizedKeyword = keyword.trim().replaceAll("\\s+", " ");
        
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
            case "name":
                // Split normalized keywords by space and create conditions for each word
                String[] keywords = normalizedKeyword.split(" ");
                StringBuilder nameCondition = new StringBuilder();
                
                for (int i = 0; i < keywords.length; i++) {
                    if (i > 0) {
                        nameCondition.append(" AND ");
                    }
                    nameCondition.append("(LOWER(first_name) LIKE LOWER(?) OR LOWER(last_name) LIKE LOWER(?))");
                }
                sql += "(" + nameCondition.toString() + ") ";
                break;
            default: // search all
                sql += "(username LIKE ? OR email_contact LIKE ? OR phone_contact LIKE ? OR first_name LIKE ? OR last_name LIKE ?) ";
                break;
        }
        
        sql += "ORDER BY freelancerID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            int offset = (page - 1) * pageSize;
            int paramIndex = 1;
            
            if (searchBy.equalsIgnoreCase("all")) {
                String searchTerm = "%" + keyword + "%";
                for (int i = 0; i < 5; i++) {
                    stm.setString(paramIndex++, searchTerm);
                }
            } else if (searchBy.equalsIgnoreCase("name")) {
                String[] keywords = keyword.trim().split("\\s+");
                for (String kw : keywords) {
                    String searchTerm = "%" + kw + "%";
                    stm.setString(paramIndex++, searchTerm); // first_name
                    stm.setString(paramIndex++, searchTerm); // last_name
                }
            } else {
                String searchTerm = "%" + keyword + "%";
                stm.setString(paramIndex++, searchTerm);
            }
            
            stm.setInt(paramIndex++, offset);
            stm.setInt(paramIndex, pageSize);
            
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
     public FreelancerLocation getFreelancerLocationById(int id) {
        FreelancerLocation location = null;
        String sql = "SELECT * " +
                     "FROM FreelancerLocation WHERE freelancerID  = ?";

        try (
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    location = new FreelancerLocation();
                    location.setFreelancerLocationID(rs.getInt("freelancerLocationID"));
                    location.setFreelancerID(rs.getInt("freelancerID"));
                    location.setCity(rs.getString("city"));
                    location.setCountry(rs.getString("country"));
                    location.setWorkPreference(rs.getString("work_preference")); 
                    location.setLocationNotes(rs.getString("location_notes"));
                    return location;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching FreelancerLocation by ID: " + id);
            e.printStackTrace();
        }
        return null; // Trả về null nếu không tìm thấy
    }
    public boolean updateLocation(String id, String city, String country, String pre, String note ) {
        if (connection == null) {
            System.err.println("Database connection is null");
            return false;
        }
        
        String sql = "Update FreelancerLocation SET city = ?, country = ?, work_preference = ?, location_notes = ? WHERE freelancerID = ?";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, city);
            stm.setString(2, country);
            stm.setString(3, pre);
            stm.setString(4, note);
            
            stm.setString(5, id);
            
            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error updating jobseeker describe: " + e.getMessage());
            return false;
        }
    }
    
    public boolean updateAvatar(int freelancerId, String avatarPath) {
        if (connection == null) {
            System.err.println("Database connection is null");
            return false;
        }
        
        String sql = "UPDATE Freelancer SET image = ? WHERE freelancerID = ?";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, avatarPath);
            stm.setInt(2, freelancerId);
            
            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error updating avatar: " + e.getMessage());
            return false;
        }
    }
     
}
