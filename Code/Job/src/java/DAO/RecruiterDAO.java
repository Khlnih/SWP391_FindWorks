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
                recruiter.setDob(rs.getString("dob"));
                recruiter.setImage(rs.getString("image"));
                recruiter.setMoney(rs.getBigDecimal("money"));
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
                recruiter.setDob(rs.getString("dob"));
                recruiter.setImage(rs.getString("image"));
                recruiter.setMoney(rs.getBigDecimal("money"));
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
        
        if (connection == null || keyword == null || keyword.trim().isEmpty()) {
            return list;
        }
        
        // Normalize the keyword by trimming and replacing multiple spaces with a single space
        String normalizedKeyword = keyword.trim().replaceAll("\\s+", " ");
        String[] searchKeywords = null;
        
        StringBuilder sql = new StringBuilder("SELECT * FROM Recruiter WHERE status != 'inactive' AND ");
        
        // Add search conditions based on searchBy parameter
        switch (searchBy.toLowerCase()) {
            case "username":
                sql.append("LOWER(username) LIKE LOWER(?)");
                break;
            case "email":
                sql.append("LOWER(email_contact) LIKE LOWER(?)");
                break;
            case "phone":
                sql.append("phone_contact LIKE ?");
                break;
            case "name":
                // Split normalized keywords by space
                searchKeywords = normalizedKeyword.split(" ");
                StringBuilder nameCondition = new StringBuilder();
                
                for (int i = 0; i < searchKeywords.length; i++) {
                    if (i > 0) {
                        nameCondition.append(" OR ");
                    }
                    nameCondition.append("(LOWER(first_name) LIKE LOWER(?) OR LOWER(last_name) LIKE LOWER(?))");
                }
                sql.append("(").append(nameCondition).append(")");
                break;
            default: // all
                sql.append("(LOWER(username) LIKE LOWER(?) " +
                         "OR LOWER(email_contact) LIKE LOWER(?) " +
                         "OR phone_contact LIKE ? " +
                         "OR LOWER(first_name) LIKE LOWER(?) " +
                         "OR LOWER(last_name) LIKE LOWER(?))");
                break;
        }
        
        sql.append(" ORDER BY recruiterID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        
        try (PreparedStatement stm = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            
            // Set search parameters based on searchBy
            if (searchBy.equalsIgnoreCase("all")) {
                String searchTerm = "%" + normalizedKeyword + "%";
                stm.setString(paramIndex++, searchTerm); // username
                stm.setString(paramIndex++, searchTerm); // email_contact
                stm.setString(paramIndex++, "%" + normalizedKeyword + "%"); // phone_contact
                stm.setString(paramIndex++, searchTerm); // first_name
                stm.setString(paramIndex++, searchTerm); // last_name
            } else if (searchBy.equalsIgnoreCase("name") && searchKeywords != null) {
                for (String kw : searchKeywords) {
                    String searchTerm = "%" + kw + "%";
                    stm.setString(paramIndex++, searchTerm); // first_name
                    stm.setString(paramIndex++, searchTerm); // last_name
                }
            } else {
                String searchTerm = "%" + normalizedKeyword + "%";
                stm.setString(paramIndex++, searchTerm);
            }
            
            // Set pagination parameters
            stm.setInt(paramIndex++, (page - 1) * pageSize);
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
                recruiter.setDob(rs.getString("dob"));
                recruiter.setImage(rs.getString("image"));
                recruiter.setMoney(rs.getBigDecimal("money"));
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
        
        if (connection == null || keyword == null || keyword.trim().isEmpty()) {
            return count;
        }
        
        // Normalize the keyword by trimming and replacing multiple spaces with a single space
        String normalizedKeyword = keyword.trim().replaceAll("\\s+", " ");
        String[] searchKeywords = null;
        
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) as total FROM Recruiter WHERE status != 'inactive' AND ");
        
        // Add search conditions based on searchBy parameter
        switch (searchBy.toLowerCase()) {
            case "username":
                sql.append("LOWER(username) LIKE LOWER(?)");
                break;
            case "email":
                sql.append("LOWER(email_contact) LIKE LOWER(?)");
                break;
            case "phone":
                sql.append("phone_contact LIKE ?");
                break;
            case "name":
                // Split normalized keywords by space
                searchKeywords = normalizedKeyword.split(" ");
                StringBuilder nameCondition = new StringBuilder();
                
                for (int i = 0; i < searchKeywords.length; i++) {
                    if (i > 0) {
                        nameCondition.append(" OR ");
                    }
                    nameCondition.append("(LOWER(first_name) LIKE LOWER(?) OR LOWER(last_name) LIKE LOWER(?))");
                }
                sql.append("(").append(nameCondition).append(")");
                break;
            default: // all
                sql.append("(LOWER(username) LIKE LOWER(?) " +
                         "OR LOWER(email_contact) LIKE LOWER(?) " +
                         "OR phone_contact LIKE ? " +
                         "OR LOWER(first_name) LIKE LOWER(?) " +
                         "OR LOWER(last_name) LIKE LOWER(?))");
                break;
        }
        
        try (PreparedStatement stm = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            
            // Set search parameters based on searchBy
            if (searchBy.equalsIgnoreCase("all")) {
                String searchTerm = "%" + normalizedKeyword + "%";
                stm.setString(paramIndex++, searchTerm); // username
                stm.setString(paramIndex++, searchTerm); // email_contact
                stm.setString(paramIndex++, "%" + normalizedKeyword + "%"); // phone_contact
                stm.setString(paramIndex++, searchTerm); // first_name
                stm.setString(paramIndex, searchTerm); // last_name
            } else if (searchBy.equalsIgnoreCase("name") && searchKeywords != null) {
                for (String kw : searchKeywords) {
                    String searchTerm = "%" + kw + "%";
                    stm.setString(paramIndex++, searchTerm); // first_name
                    stm.setString(paramIndex++, searchTerm); // last_name
                }
            } else {
                String searchTerm = "%" + normalizedKeyword + "%";
                stm.setString(paramIndex++, searchTerm);
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
                recruiter.setDob(rs.getString("dob"));
                recruiter.setImage(rs.getString("image"));
                recruiter.setMoney(rs.getBigDecimal("money"));
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

    public String getTierName(int recruiterID) {
        String sql = "SELECT AT.tierName AS TierName\n"
                + "FROM AccountTiers AS AT\n"
                + "JOIN UserTierSubscriptions AS UTS ON AT.tierID = UTS.tierID\n"
                + "WHERE UTS.recruiterID = ? AND AT.isActive = 1;";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, recruiterID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getString("TierName");
            }
        } catch (SQLException e) {
            System.err.println("Error calculating total spent: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public String getTierNameDescription(int recruiterID) {
        String sql = "SELECT AT.description AS Description\n"
                + "FROM AccountTiers AS AT\n"
                + "JOIN UserTierSubscriptions AS UTS ON AT.tierID = UTS.tierID\n"
                + "WHERE UTS.recruiterID = ? AND AT.isActive = 1;";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, recruiterID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getString("Description");
            }
        } catch (SQLException e) {
            System.err.println("Error calculating total spent: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

     public boolean isUsernameOrEmailExists(String username, String email) {
        String sql = "SELECT * FROM Recruiter WHERE username = ? OR email_contact = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, email);
            ResultSet rs = ps.executeQuery();
            return rs.next(); // Có bản ghi trùng
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return true; // Nếu có lỗi, cứ coi là trùng để tránh lỗi khi insert
    }

    public boolean registerRecruiter(Recruiter r) {
        String sql = "INSERT INTO Recruiter (username, password, first_name, last_name, gender, dob, image, money, email_contact, phone_contact, status, statusChangedByAdminID) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, 0, ?, ?, 'pending', NULL)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, r.getUsername());
            ps.setString(2, r.getPassword());
            ps.setString(3, r.getFirstName());
            ps.setString(4, r.getLastName());
            ps.setBoolean(5, r.isGender());
            ps.setString(6, r.getDob());
            ps.setString(7, r.getImage());
            ps.setString(8, r.getEmailContact());
            ps.setString(9, r.getPhoneContact());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
