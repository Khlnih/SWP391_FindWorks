package DAO;

import Model.Recruiter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class RecruiterDAO extends DBContext {

    public ArrayList<Recruiter> getAllRecruiters() {
        ArrayList<Recruiter> list = new ArrayList<>();

        if (connection == null) {
            System.err.println("Database connection is null");
            return list;
        }

        String sql = "SELECT * FROM Recruiter WHERE status != 'inactive'";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Recruiter recruiter = new Recruiter();
                recruiter.setRecruiterID(rs.getInt("recruiterID"));
                recruiter.setUsername(rs.getString("username"));
                recruiter.setPassword(rs.getString("password"));
                recruiter.setFirstName(rs.getString("first_name"));
                recruiter.setLastName(rs.getString("last_name"));
                recruiter.setGender(rs.getBoolean("gender"));
                recruiter.setDob(rs.getDate("dob"));
                recruiter.setImage(rs.getString("image"));
                recruiter.setMoney(rs.getInt("money"));
                recruiter.setEmailContact(rs.getString("email_contact"));
                recruiter.setPhoneContact(rs.getString("phone_contact"));
                recruiter.setStatus(rs.getString("status"));

                list.add(recruiter);
            }
            System.out.println("Found " + list.size() + " recruiters");
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error getting recruiters: " + e.getMessage());
        }

        return list;
    }
    
    public boolean updateStatus(int id, String status) {
        if (connection == null) {
            System.err.println("Database connection is null");
            return false;
        }
        
        String sql = "UPDATE Recruiter SET status = ? WHERE recruiterID = ?";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, status);
            stm.setInt(2, id);
            
            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error updating recruiter status: " + e.getMessage());
            return false;
        }
    }
    
    public ArrayList<Recruiter> getRecruitersByPage(int page, int pageSize) {
        ArrayList<Recruiter> list = new ArrayList<>();
        
        if (connection == null) {
            System.err.println("Database connection is null");
            return list;
        }
        
        int offset = (page - 1) * pageSize;
        String sql = "SELECT * FROM Recruiter WHERE status != 'inactive' ORDER BY recruiterID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, offset);
            stm.setInt(2, pageSize);
            
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Recruiter recruiter = new Recruiter();
                recruiter.setRecruiterID(rs.getInt("recruiterID"));
                recruiter.setUsername(rs.getString("username"));
                recruiter.setPassword(rs.getString("password"));
                recruiter.setFirstName(rs.getString("first_name"));
                recruiter.setLastName(rs.getString("last_name"));
                recruiter.setGender(rs.getBoolean("gender"));
                recruiter.setDob(rs.getDate("dob"));
                recruiter.setImage(rs.getString("image"));
                recruiter.setMoney(rs.getInt("money"));
                recruiter.setEmailContact(rs.getString("email_contact"));
                recruiter.setPhoneContact(rs.getString("phone_contact"));
                recruiter.setStatus(rs.getString("status"));
                
                list.add(recruiter);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error getting paginated recruiters: " + e.getMessage());
        }
        
        return list;
    }
    
    public int countTotalRecruiters() {
        int count = 0;
        String sql = "SELECT COUNT(*) as total FROM Recruiter WHERE status != 'inactive'";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                count = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error counting recruiters: " + e.getMessage());
        }
        
        return count;
    }
    
    public ArrayList<Recruiter> searchRecruiters(String keyword, String searchBy, int page, int pageSize) {
        ArrayList<Recruiter> list = new ArrayList<>();
        
        if (connection == null) {
            System.err.println("Database connection is null");
            return list;
        }
        
        int offset = (page - 1) * pageSize;
        StringBuilder sql = new StringBuilder("SELECT * FROM Recruiter WHERE status != 'inactive' ");
        
        // Add search conditions based on searchBy parameter
        if (keyword != null && !keyword.trim().isEmpty()) {
            switch (searchBy) {
                case "name":
                    sql.append("AND (LOWER(first_name) LIKE ? OR LOWER(last_name) LIKE ?) ");
                    break;
                case "email":
                    sql.append("AND LOWER(email_contact) LIKE ? ");
                    break;
                case "phone":
                    sql.append("AND phone_contact LIKE ? ");
                    break;
                default: // all
                    sql.append("AND (LOWER(first_name) LIKE ? OR LOWER(last_name) LIKE ? OR " +
                           "LOWER(email_contact) LIKE ? OR phone_contact LIKE ?) ");
                    break;
            }
        }
        
        sql.append("ORDER BY recruiterID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        
        try (PreparedStatement stm = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            
            // Set search parameters based on searchBy
            if (keyword != null && !keyword.trim().isEmpty()) {
                String searchTerm = "%" + keyword.toLowerCase() + "%";
                switch (searchBy) {
                    case "name":
                        stm.setString(paramIndex++, searchTerm);
                        stm.setString(paramIndex++, searchTerm);
                        break;
                    case "email":
                        stm.setString(paramIndex++, searchTerm);
                        break;
                    case "phone":
                        stm.setString(paramIndex++, "%" + keyword + "%");
                        break;
                    default: // all
                        stm.setString(paramIndex++, searchTerm);
                        stm.setString(paramIndex++, searchTerm);
                        stm.setString(paramIndex++, searchTerm);
                        stm.setString(paramIndex++, "%" + keyword + "%");
                        break;
                }
            }
            
            // Set pagination parameters
            stm.setInt(paramIndex++, offset);
            stm.setInt(paramIndex, pageSize);
            
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Recruiter recruiter = new Recruiter();
                recruiter.setRecruiterID(rs.getInt("recruiterID"));
                recruiter.setUsername(rs.getString("username"));
                recruiter.setPassword(rs.getString("password"));
                recruiter.setFirstName(rs.getString("first_name"));
                recruiter.setLastName(rs.getString("last_name"));
                recruiter.setGender(rs.getBoolean("gender"));
                recruiter.setDob(rs.getDate("dob"));
                recruiter.setImage(rs.getString("image"));
                recruiter.setMoney(rs.getInt("money"));
                recruiter.setEmailContact(rs.getString("email_contact"));
                recruiter.setPhoneContact(rs.getString("phone_contact"));
                recruiter.setStatus(rs.getString("status"));
                
                list.add(recruiter);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error searching recruiters: " + e.getMessage());
        }
        
        return list;
    }
    
    public int countSearchResults(String keyword, String searchBy) {
        int count = 0;
        
        if (connection == null) {
            System.err.println("Database connection is null");
            return count;
        }
        
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) as total FROM Recruiter WHERE status != 'inactive' ");
        
        // Add search conditions based on searchBy parameter
        if (keyword != null && !keyword.trim().isEmpty()) {
            switch (searchBy) {
                case "name":
                    sql.append("AND (LOWER(first_name) LIKE ? OR LOWER(last_name) LIKE ?) ");
                    break;
                case "email":
                    sql.append("AND LOWER(email_contact) LIKE ? ");
                    break;
                case "phone":
                    sql.append("AND phone_contact LIKE ? ");
                    break;
                default: // all
                    sql.append("AND (LOWER(first_name) LIKE ? OR LOWER(last_name) LIKE ? OR " +
                           "LOWER(email_contact) LIKE ? OR phone_contact LIKE ?) ");
                    break;
            }
        }
        
        try (PreparedStatement stm = connection.prepareStatement(sql.toString())) {
            // Set search parameters based on searchBy
            if (keyword != null && !keyword.trim().isEmpty()) {
                String searchTerm = "%" + keyword.toLowerCase() + "%";
                switch (searchBy) {
                    case "name":
                        stm.setString(1, searchTerm);
                        stm.setString(2, searchTerm);
                        break;
                    case "email":
                        stm.setString(1, searchTerm);
                        break;
                    case "phone":
                        stm.setString(1, "%" + keyword + "%");
                        break;
                    default: // all
                        stm.setString(1, searchTerm);
                        stm.setString(2, searchTerm);
                        stm.setString(3, searchTerm);
                        stm.setString(4, "%" + keyword + "%");
                        break;
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
    
    public boolean deleteRecruiter(int id) {
        if (connection == null) {
            System.err.println("Database connection is null");
            return false;
        }
        
        String updateSql = "UPDATE Recruiter SET status = 'inactive' WHERE recruiterID = ?";
        
        try (PreparedStatement updateStm = connection.prepareStatement(updateSql)) {
            updateStm.setInt(1, id);
            int rowsAffected = updateStm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error deleting recruiter: " + e.getMessage());
            return false;
        }
    }
    public Recruiter getRecruiterById(int id) {
        if (connection == null) {
            System.err.println("Database connection is null");
            return null;
        }
        
        String sql = "SELECT * FROM Recruiter WHERE recruiterID = ?";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, id);
            
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Recruiter recruiter = new Recruiter();
                recruiter.setRecruiterID(rs.getInt("recruiterID"));
                recruiter.setUsername(rs.getString("username"));
                recruiter.setPassword(rs.getString("password"));
                recruiter.setFirstName(rs.getString("first_name"));
                recruiter.setLastName(rs.getString("last_name"));
                recruiter.setGender(rs.getBoolean("gender"));
                recruiter.setDob(rs.getDate("dob"));
                recruiter.setImage(rs.getString("image"));
                recruiter.setMoney(rs.getInt("money"));
                recruiter.setEmailContact(rs.getString("email_contact"));
                recruiter.setPhoneContact(rs.getString("phone_contact"));
                recruiter.setStatus(rs.getString("status"));
                
                return recruiter;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error getting recruiter by ID: " + e.getMessage());
        }
        
        return null;
    }
    
}
