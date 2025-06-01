package DAO;

import Model.RecruiterTransaction;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RecruiterTransactionDAO extends DBContext {
    
    public List<RecruiterTransaction> getTransactionsByRecruiter(int recruiterID) {
        List<RecruiterTransaction> transactions = new ArrayList<>();
        String sql = "SELECT * FROM RecruiterTransaction WHERE recruiterID = ? ORDER BY transactionDate DESC";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, recruiterID);
            ResultSet rs = stm.executeQuery();
            
            while (rs.next()) {
                RecruiterTransaction rt = new RecruiterTransaction();
                rt.setTransactionID(rs.getInt("transactionID"));
                rt.setRecruiterID(rs.getInt("recruiterID"));
                rt.setType(rs.getString("type"));
                rt.setAmount(rs.getBigDecimal("amount"));
                rt.setDescription(rs.getString("description"));
                rt.setTransactionDate(rs.getTimestamp("transactionDate"));
                
                int relatedID = rs.getInt("relatedID");
                rt.setRelatedID(rs.wasNull() ? null : relatedID);
                
                transactions.add(rt);
            }
        } catch (SQLException e) {
            System.err.println("Error getting recruiter transactions: " + e.getMessage());
            e.printStackTrace();
        }
        return transactions;
    }
    
    public Double getTotalSpent(int recruiterID) {
        String sql = "SELECT COALESCE(SUM(amount), 0) AS TotalAmount " +
                   "FROM RecruiterTransaction WHERE recruiterID = ?";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, recruiterID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getDouble("TotalAmount");
            }
        } catch (SQLException e) {
            System.err.println("Error calculating total spent: " + e.getMessage());
            e.printStackTrace();
        }
        return 0.0;
    }
}
