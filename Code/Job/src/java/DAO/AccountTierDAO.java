package DAO;

import Model.AccountTier;
import java.sql.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AccountTierDAO extends DBContext {
    private static final Logger logger = Logger.getLogger(AccountTierDAO.class.getName());
    
    public List<AccountTier> getAccountTiersWithPagination(int offset, int pageSize) {
        List<AccountTier> tiers = new ArrayList<>();
        
        if (connection == null) {
            System.err.println("Database connection is null");
            return tiers;
        }
        
        System.out.println("AccountTierDAO: Getting account tiers with offset=" + offset + ", pageSize=" + pageSize);
        
        String sql = "SELECT * FROM AccountTiers ORDER BY tierID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            
            stm.setInt(1, offset);
            stm.setInt(2, pageSize);
            
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    AccountTier tier = new AccountTier();
                    tier.setTierID(rs.getInt("tierID"));
                    tier.setTierName(rs.getString("tierName"));
                    tier.setPrice(rs.getBigDecimal("price"));
                    tier.setDurationDays(rs.getInt("durationDays"));
                    tier.setDescription(rs.getString("description"));
                    tier.setUserTypeScope(rs.getString("userTypeScope"));
                    tier.setStatus(rs.getInt("status"));
                    tiers.add(tier);
                }
            }
            return tiers;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error getting account tiers with pagination", e);
            return tiers;
        }
    }
    
    // Get total count of account tiers
    public int countTotalTiers() {
        if (connection == null) {
            System.err.println("Database connection is null");
            return 0;
        }
        
        String sql = "SELECT COUNT(*) as total FROM AccountTiers";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total");
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error counting total tiers", e);
        }
        return 0;
    }
    
    // Get account tier by ID
    public AccountTier getAccountTierById(int id) {
        if (connection == null) {
            System.err.println("Database connection is null");
            return null;
        }
        
        String sql = "SELECT * FROM AccountTiers WHERE tierID = ?";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, id);
            
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    AccountTier tier = new AccountTier();
                    tier.setTierID(rs.getInt("tierID"));
                    tier.setTierName(rs.getString("tierName"));
                    tier.setPrice(rs.getBigDecimal("price"));
                    tier.setDurationDays(rs.getInt("durationDays"));
                    tier.setDescription(rs.getString("description"));
                    tier.setUserTypeScope(rs.getString("userTypeScope"));
                    tier.setStatus(rs.getInt("status"));
                    return tier;
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error getting account tier by ID", e);
        }
        return null;
    }
    
    // Add new account tier
    public boolean addAccountTier(AccountTier tier) {
        if (connection == null) {
            System.err.println("Database connection is null");
            return false;
        }
        
        String sql = "INSERT INTO AccountTiers (tierName, price, durationDays, description, userTypeScope, status) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, tier.getTierName());
            stm.setBigDecimal(2, tier.getPrice());
            stm.setInt(3, tier.getDurationDays());
            stm.setString(4, tier.getDescription());
            stm.setString(5, tier.getUserTypeScope());
            stm.setInt(6, tier.getStatus());
            
            return stm.executeUpdate() > 0;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error adding account tier", e);
            return false;
        }
    }
    
    // Update account tier
    public boolean updateAccountTier(AccountTier tier) {
        if (connection == null) {
            System.err.println("Database connection is null");
            return false;
        }
        
        String sql = "UPDATE AccountTiers SET tierName = ?, price = ?, durationDays = ?, description = ?, userTypeScope = ?, status = ? WHERE tierID = ?";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, tier.getTierName());
            stm.setBigDecimal(2, tier.getPrice());
            stm.setInt(3, tier.getDurationDays());
            stm.setString(4, tier.getDescription());
            stm.setString(5, tier.getUserTypeScope());
            stm.setInt(6, tier.getStatus());
            stm.setInt(7, tier.getTierID());
            
            return stm.executeUpdate() > 0;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error updating account tier", e);
            return false;
        }
    }
    
    // Delete account tier
    public boolean deleteAccountTier(int id) {
        if (connection == null) {
            System.err.println("Database connection is null");
            return false;
        }
        
        String sql = "DELETE FROM AccountTiers WHERE tierID = ?";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, id);
            return stm.executeUpdate() > 0;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error deleting account tier", e);
            return false;
        }
    }
    
    // Search tiers with pagination
    public int countSearchResults(String keyword) {
        String sql = "SELECT COUNT(*) as total FROM AccountTiers WHERE tierName LIKE ? OR description LIKE ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            stm.setString(1, searchPattern);
            stm.setString(2, searchPattern);
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total");
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error counting search results for keyword: " + keyword, e);
        }
        return 0;
    }
    
    // Get paginated list of tiers
    public List<AccountTier> getTiersPaginated(int offset, int limit, String keyword) {
        List<AccountTier> tiers = new ArrayList<>();
        String sql = "SELECT * FROM AccountTiers";
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += " WHERE tierName LIKE ? OR description LIKE ?";
        }
        
        sql += " ORDER BY tierID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            int paramIndex = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                String searchPattern = "%" + keyword + "%";
                stm.setString(paramIndex++, searchPattern);
                stm.setString(paramIndex++, searchPattern);
            }
            stm.setInt(paramIndex++, offset);
            stm.setInt(paramIndex, limit);
            
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    AccountTier tier = new AccountTier();
                    tier.setTierID(rs.getInt("tierID"));
                    tier.setTierName(rs.getString("tierName"));
                    tier.setPrice(rs.getBigDecimal("price"));
                    tier.setDurationDays(rs.getInt("durationDays"));
                    tier.setDescription(rs.getString("description"));
                    tiers.add(tier);
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error getting paginated tiers", e);
        }
        return tiers;
    }
    
    public AccountTier getTierById(int tierId) {
        String sql = "SELECT * FROM AccountTiers WHERE tierID = ?";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, tierId);
            ResultSet rs = stm.executeQuery();
            
            if (rs.next()) {
                AccountTier tier = new AccountTier();
                tier.setTierID(rs.getInt("tierID"));
                tier.setTierName(rs.getString("tierName"));
                tier.setPrice(rs.getBigDecimal("price"));
                tier.setDurationDays(rs.getInt("durationDays"));
                tier.setDescription(rs.getString("description"));
                return tier;
            }
        } catch (SQLException e) {
            System.err.println("Error getting tier by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean addTier(AccountTier tier) {
        String sql = "INSERT INTO AccountTiers (tierName, price, durationDays, description) VALUES (?, ?, ?, ?)";
        
        try (PreparedStatement stm = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stm.setString(1, tier.getTierName());
            stm.setBigDecimal(2, tier.getPrice());
            stm.setInt(3, tier.getDurationDays());
            stm.setString(4, tier.getDescription());
            
            int affectedRows = stm.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stm.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        tier.setTierID(generatedKeys.getInt(1));
                        return true;
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Error adding tier: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean updateTier(AccountTier tier) {
        String sql = "UPDATE AccountTiers SET tierName = ?, price = ?, durationDays = ?, description = ? WHERE tierID = ?";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, tier.getTierName());
            stm.setBigDecimal(2, tier.getPrice());
            stm.setInt(3, tier.getDurationDays());
            stm.setString(4, tier.getDescription());
            stm.setInt(5, tier.getTierID());
            
            int affectedRows = stm.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.err.println("Error updating tier: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean deleteTier(int tierId) {
        String sql = "DELETE FROM AccountTiers WHERE tierID = ?";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, tierId);
            int affectedRows = stm.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting tier: " + e.getMessage());
            e.printStackTrace();
            
            // Check if the error is due to foreign key constraint
            if (e.getMessage().contains("FK_")) {
                throw new RuntimeException("Cannot delete this tier as it is currently in use by recruiters.");
            }
        }
        return false;
    }
    
    public AccountTier getCurrentTier(int recruiterID) {
        String sql = "SELECT TOP 1 a.* FROM AccountTier a " +
                    "JOIN UserTransaction ut ON a.tierID = ut.relatedID " +
                    "JOIN RecruiterTransaction rt ON ut.transactionID = rt.transactionID " +
                    "WHERE rt.recruiterID = ? AND rt.Type = 'TierSubscription' " +
                    "AND DATEADD(DAY, a.durationDays, ut.transactionDate) >= GETDATE() " +
                    "AND ut.status = 'Completed' " +
                    "ORDER BY ut.transactionDate DESC";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, recruiterID);
            ResultSet rs = stm.executeQuery();
            
            if (rs.next()) {
                AccountTier tier = new AccountTier();
                tier.setTierID(rs.getInt("tierID"));
                tier.setTierName(rs.getString("tierName"));
                tier.setPrice(rs.getBigDecimal("price"));
                tier.setDurationDays(rs.getInt("durationDays"));
                tier.setDescription(rs.getString("description"));
                return tier;
            }
        } catch (SQLException e) {
            System.err.println("Error getting current tier: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
}
