package DAO;

import Model.AccountTier;
import java.math.BigDecimal;
import java.sql.*;
import java.util.*;

public class AccountTierDAO extends DBContext {
    
    public Map<Integer, AccountTier> getAllTiers() {
        Map<Integer, AccountTier> tiers = new HashMap<>();
        String sql = "SELECT * FROM AccountTiers";
        
        try (Statement stm = connection.createStatement();
             ResultSet rs = stm.executeQuery(sql)) {
            
            while (rs.next()) {
                AccountTier tier = new AccountTier();
                tier.setTierID(rs.getInt("tierID"));
                tier.setTierName(rs.getString("tierName"));
                tier.setPrice(rs.getBigDecimal("price"));
                tier.setDurationDays(rs.getInt("durationDays"));
                tier.setDescription(rs.getString("description"));
                
                tiers.put(tier.getTierID(), tier);
            }
        } catch (SQLException e) {
            System.err.println("Error getting all account tiers: " + e.getMessage());
            e.printStackTrace();
        }
        return tiers;
    }
    
    public boolean addAccountTier(AccountTier tier) {
        if (connection == null) {
            System.err.println("Database connection is null");
            return false;
        }

        String sql = "INSERT INTO AccountTiers (tierName, price, durationDays, description, isActive, postlimit, userTypeScope) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement stm = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stm.setString(1, tier.getTierName());
            stm.setBigDecimal(2, tier.getPrice());
            stm.setInt(3, tier.getDurationDays());
            stm.setString(4, tier.getDescription());
            stm.setBoolean(5, tier.isStatus());
            stm.setInt(6, tier.getJobPostLimit());
            stm.setString(7, tier.getUserTypeScope());
            
            int rowsAffected = stm.executeUpdate();
            
            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = stm.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        tier.setTierID(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            System.err.println("Error adding account tier: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    public ArrayList<AccountTier> getAllAccountTier() {
        ArrayList<AccountTier> list = new ArrayList<>();

        if (connection == null) {
            System.err.println("Database connection is null");
            return list;
        }

        String sql = "SELECT * FROM AccountTiers";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                AccountTier tier = new AccountTier();
                tier.setTierID(rs.getInt("tierID"));
                tier.setTierName(rs.getString("tierName"));
                tier.setPrice(rs.getBigDecimal("price"));
                tier.setDurationDays(rs.getInt("durationDays"));
                tier.setDescription(rs.getString("description"));
                tier.setStatus(rs.getBoolean("isActive"));
                tier.setJobPostLimit(rs.getInt("postlimit"));
                tier.setUserTypeScope(rs.getString("userTypeScope"));
                list.add(tier);
            }
            System.out.println("Found " + list.size() + " account tiers");
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error getting recruiters: " + e.getMessage());
        }

        return list;
    }
    
    
    public ArrayList<AccountTier> getAllAccountTierForJobseeker() {
        ArrayList<AccountTier> list = new ArrayList<>();

        if (connection == null) {
            System.err.println("Database connection is null");
            return list;
        }

        String sql = "SELECT * FROM AccountTiers WHERE userTypeScope = 'Jobseeker' AND isActive = 1";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                AccountTier tier = new AccountTier();
                tier.setTierID(rs.getInt("tierID"));
                tier.setTierName(rs.getString("tierName"));
                tier.setPrice(rs.getBigDecimal("price"));
                tier.setDurationDays(rs.getInt("durationDays"));
                tier.setDescription(rs.getString("description"));
                tier.setStatus(rs.getBoolean("isActive"));
                tier.setJobPostLimit(rs.getInt("postlimit"));
                tier.setUserTypeScope(rs.getString("userTypeScope"));
                list.add(tier);
            }
            System.out.println("Found " + list.size() + " account tiers");
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error getting recruiters: " + e.getMessage());
        }

        return list;
    }
    
    public boolean updateTier(AccountTier tier) {
        if (connection == null) {
            System.err.println("Database connection is null");
            return false;
        }

        String sql = "UPDATE AccountTiers SET tierName = ?, price = ?, durationDays = ?, "
                 + "description = ?, isActive = ?, postlimit = ?, userTypeScope = ? WHERE tierID = ?";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, tier.getTierName());
            stm.setBigDecimal(2, tier.getPrice());
            stm.setInt(3, tier.getDurationDays());
            stm.setString(4, tier.getDescription());
            stm.setBoolean(5, tier.isStatus());
            stm.setInt(6, tier.getJobPostLimit());
            stm.setString(7, tier.getUserTypeScope());
            stm.setInt(8, tier.getTierID());
            
            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating account tier: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteTier(int tierId) {
        if (connection == null) {
            System.err.println("Database connection is null");
            return false;
        }

        String sql = "DELETE FROM AccountTiers WHERE tierID = ?";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, tierId);
            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting account tier: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    public List<AccountTier> searchTiers(BigDecimal minPrice, BigDecimal maxPrice, Boolean isActive, Integer minDuration, Integer maxDuration, String userTypeScope) {
        List<AccountTier> tiers = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM AccountTiers WHERE 1=1");
        
        if (minPrice != null) {
            sql.append(" AND price >= ?");
        }
        if (maxPrice != null) {
            sql.append(" AND price <= ?");
        }
        if (isActive != null) {
            sql.append(" AND isActive = ?");
        }
        if (minDuration != null) {
            sql.append(" AND durationDays >= ?");
        }
        if (maxDuration != null) {
            sql.append(" AND durationDays <= ?");
        }
        if (userTypeScope != null && !userTypeScope.isEmpty()) {
            sql.append(" AND userTypeScope = ?");
        }
        
        try (PreparedStatement stm = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            
            if (minPrice != null) {
                stm.setBigDecimal(paramIndex++, minPrice);
            }
            if (maxPrice != null) {
                stm.setBigDecimal(paramIndex++, maxPrice);
            }
            if (isActive != null) {
                stm.setBoolean(paramIndex++, isActive);
            }
            if (minDuration != null) {
                stm.setInt(paramIndex++, minDuration);
            }
            if (maxDuration != null) {
                stm.setInt(paramIndex++, maxDuration);
            }
            if (userTypeScope != null && !userTypeScope.isEmpty()) {
                stm.setString(paramIndex, userTypeScope);
            }
            
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                AccountTier tier = new AccountTier();
                tier.setTierID(rs.getInt("tierID"));
                tier.setTierName(rs.getString("tierName"));
                tier.setPrice(rs.getBigDecimal("price"));
                tier.setDurationDays(rs.getInt("durationDays"));
                tier.setDescription(rs.getString("description"));
                tier.setStatus(rs.getBoolean("isActive"));
                tier.setJobPostLimit(rs.getInt("postlimit"));
                tier.setUserTypeScope(rs.getString("userTypeScope"));
                tiers.add(tier);
            }
        } catch (SQLException e) {
            System.err.println("Error searching tiers: " + e.getMessage());
            e.printStackTrace();
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
                tier.setStatus(rs.getBoolean("isActive"));
                tier.setJobPostLimit(rs.getInt("postlimit"));
                tier.setUserTypeScope(rs.getString("userTypeScope"));
                return tier;
            }
        } catch (SQLException e) {
            System.err.println("Error getting tier by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
}
