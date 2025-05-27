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
        
        String sql = "UPDATE Freelancer SET status = 'inactive' WHERE freelanceID = ?";
        
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
                jobseeker.setFreelanceID(rs.getInt("freelanceID"));
                jobseeker.setUsername(rs.getString("username"));
                jobseeker.setPassword(rs.getString("password"));
                jobseeker.setFirstName(rs.getString("first_name"));
                jobseeker.setLastName(rs.getString("last_name"));
                jobseeker.setImage(rs.getString("image"));
                jobseeker.setGender(rs.getBoolean("gender"));
                jobseeker.setDob(rs.getString("dob"));
                jobseeker.setDescribe(rs.getString("describe"));
                jobseeker.setEmail__contact(rs.getString("email__contact"));
                jobseeker.setPhone_contact(rs.getString("phone_contact"));
                jobseeker.setStatus(rs.getString("status"));
                
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
        
        String sql = "UPDATE Freelancer SET status = ? WHERE freelanceID = ?";
        
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
    
    
    public ArrayList<Jobseeker> getJobseekersByPage(int page, int pageSize) {
        ArrayList<Jobseeker> list = new ArrayList<>();
        
        if (connection == null) {
            System.err.println("Database connection is null");
            return list;
        }
        
        int offset = (page - 1) * pageSize;
        String sql = "SELECT * FROM Freelancer WHERE status != 'inactive' ORDER BY freelanceID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, offset);
            stm.setInt(2, pageSize);
            
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Jobseeker jobseeker = new Jobseeker();
                jobseeker.setFreelanceID(rs.getInt("freelanceID"));
                jobseeker.setUsername(rs.getString("username"));
                jobseeker.setPassword(rs.getString("password"));
                jobseeker.setFirstName(rs.getString("first_name"));
                jobseeker.setLastName(rs.getString("last_name"));
                jobseeker.setImage(rs.getString("image"));
                jobseeker.setGender(rs.getBoolean("gender"));
                jobseeker.setDob(rs.getString("dob"));
                jobseeker.setDescribe(rs.getString("describe"));
                jobseeker.setEmail__contact(rs.getString("email__contact"));
                jobseeker.setPhone_contact(rs.getString("phone_contact"));
                jobseeker.setStatus(rs.getString("status"));
                
                list.add(jobseeker);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error getting paginated jobseekers: " + e.getMessage());
        }
        
        return list;
    }
    
    public int countTotalJobseekers() {
        int count = 0;
        String sql = "SELECT COUNT(*) as total FROM Freelancer WHERE status != 'inactive' ";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                count = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error counting jobseekers: " + e.getMessage());
        }
        
        return count;
    }
    
    // Tìm kiếm jobseeker với nhiều điều kiện
    public ArrayList<Jobseeker> searchJobseekers(String keyword, String searchBy, int page, int pageSize) {
        ArrayList<Jobseeker> list = new ArrayList<>();
        
        if (connection == null) {
            System.err.println("Database connection is null");
            return list;
        }
        
        int offset = (page - 1) * pageSize;
        StringBuilder sql = new StringBuilder("SELECT * FROM Freelancer WHERE status = 'active' AND 1=1");
        
        // Thêm điều kiện tìm kiếm dựa trên searchBy
        if (keyword != null && !keyword.trim().isEmpty()) {
            switch(searchBy) {
                case "name":
                    sql.append(" AND (first_name LIKE ? OR last_name LIKE ?)");
                    break;
                case "email":
                    sql.append(" AND email__contact LIKE ?");
                    break;
                case "phone":
                    sql.append(" AND phone_contact LIKE ?");
                    break;
                default:
                    sql.append(" AND (first_name LIKE ? OR last_name LIKE ? OR email__contact LIKE ? OR phone_contact LIKE ?)");
            }
        }
        
        sql.append(" ORDER BY freelanceID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        
        try (PreparedStatement stm = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            
            // Thiết lập tham số cho điều kiện tìm kiếm
            if (keyword != null && !keyword.trim().isEmpty()) {
                String searchPattern = "%" + keyword.trim() + "%";
                
                switch(searchBy) {
                    case "name":
                        stm.setString(paramIndex++, searchPattern);
                        stm.setString(paramIndex++, searchPattern);
                        break;
                    case "email":
                        stm.setString(paramIndex++, searchPattern);
                        break;
                    case "phone":
                        stm.setString(paramIndex++, searchPattern);
                        break;
                    default:
                        stm.setString(paramIndex++, searchPattern);
                        stm.setString(paramIndex++, searchPattern);
                        stm.setString(paramIndex++, searchPattern);
                        stm.setString(paramIndex++, searchPattern);
                }
            }
            
            // Thiết lập tham số phân trang
            stm.setInt(paramIndex++, offset);
            stm.setInt(paramIndex, pageSize);
            
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Jobseeker jobseeker = new Jobseeker();
                jobseeker.setFreelanceID(rs.getInt("freelanceID"));
                jobseeker.setUsername(rs.getString("username"));
                jobseeker.setPassword(rs.getString("password"));
                jobseeker.setFirstName(rs.getString("first_name"));
                jobseeker.setLastName(rs.getString("last_name"));
                jobseeker.setImage(rs.getString("image"));
                jobseeker.setGender(rs.getBoolean("gender"));
                jobseeker.setDob(rs.getString("dob"));
                jobseeker.setDescribe(rs.getString("describe"));
                jobseeker.setEmail__contact(rs.getString("email__contact"));
                jobseeker.setPhone_contact(rs.getString("phone_contact"));
                jobseeker.setStatus(rs.getString("status"));
                
                list.add(jobseeker);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error searching jobseekers: " + e.getMessage());
        }
        
        return list;
    }
    
    // Đếm tổng số kết quả tìm kiếm
    public int countSearchResults(String keyword, String searchBy) {
        int count = 0;
        
        if (connection == null) {
            System.err.println("Database connection is null");
            return count;
        }
        
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) as total FROM Freelancer WHERE 1=1");
        
        // Thêm điều kiện tìm kiếm dựa trên searchBy
        if (keyword != null && !keyword.trim().isEmpty()) {
            switch(searchBy) {
                case "name":
                    sql.append(" AND (first_name LIKE ? OR last_name LIKE ?)");
                    break;
                case "email":
                    sql.append(" AND email__contact LIKE ?");
                    break;
                case "phone":
                    sql.append(" AND phone_contact LIKE ?");
                    break;
                default:
                    sql.append(" AND (first_name LIKE ? OR last_name LIKE ? OR email__contact LIKE ? OR phone_contact LIKE ?)");
            }
        }
        
        try (PreparedStatement stm = connection.prepareStatement(sql.toString())) {
            // Thiết lập tham số cho điều kiện tìm kiếm
            if (keyword != null && !keyword.trim().isEmpty()) {
                String searchPattern = "%" + keyword.trim() + "%";
                
                switch(searchBy) {
                    case "name":
                        stm.setString(1, searchPattern);
                        stm.setString(2, searchPattern);
                        break;
                    case "email":
                        stm.setString(1, searchPattern);
                        break;
                    case "phone":
                        stm.setString(1, searchPattern);
                        break;
                    default:
                        stm.setString(1, searchPattern);
                        stm.setString(2, searchPattern);
                        stm.setString(3, searchPattern);
                        stm.setString(4, searchPattern);
                }
            }
            
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                count = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error counting search results: " + e.getMessage());
        }
        
        return count;
    }
}
