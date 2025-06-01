package DAO;

import Model.AccountTier;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;

public class AccountTierDAO extends DBContext {
    
    public Map<Integer, AccountTier> getAllTiers() {
        Map<Integer, AccountTier> tiers = new HashMap<>();
        String sql = "SELECT * FROM AccountTier";
        
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
