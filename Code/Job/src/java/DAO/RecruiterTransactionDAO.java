package DAO;

import Model.Recruiter;
import Model.RecruiterTransaction;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RecruiterTransactionDAO extends DBContext {
    
    public BigDecimal getTotalRevenue() {
        String sql = "SELECT COALESCE(SUM(amount), 0) AS totalRevenue " +
                   "FROM RecruiterTransaction WHERE type = 'PAYMENT' OR type = 'TOPUP'";
        
        try (PreparedStatement stm = connection.prepareStatement(sql);
             ResultSet rs = stm.executeQuery()) {
            if (rs.next()) {
                return rs.getBigDecimal("totalRevenue");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }
    
    public List<RecruiterTransaction> getRecentTransactions(int limit) {
        List<RecruiterTransaction> transactions = new ArrayList<>();
        String sql = "SELECT TOP (?) t.*, r.username, r.first_name, r.last_name, r.image " +
                   "FROM RecruiterTransaction t " +
                   "JOIN Recruiter r ON t.recruiterID = r.recruiterID " +
                   "WHERE t.type = 'PAYMENT' OR t.type = 'TOPUP' " +
                   "ORDER BY t.transactionDate DESC";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, limit);
            ResultSet rs = stm.executeQuery();
            
            while (rs.next()) {
                RecruiterTransaction rt = new RecruiterTransaction();
                rt.setTransactionID(rs.getInt("transactionID"));
                rt.setRecruiterID(rs.getInt("recruiterID"));
                rt.setType(rs.getString("type"));
                rt.setAmount(rs.getBigDecimal("amount"));
                rt.setDescription(rs.getString("description"));
                rt.setTransactionDate(rs.getTimestamp("transactionDate"));
                
                // Set recruiter info
                Recruiter recruiter = new Recruiter();
                recruiter.setRecruiterID(rt.getRecruiterID());
                recruiter.setUsername(rs.getString("username"));
                recruiter.setFirstName(rs.getString("first_name"));
                recruiter.setLastName(rs.getString("last_name"));
                recruiter.setImage(rs.getString("image"));
                rt.setRecruiter(recruiter);
                
                transactions.add(rt);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return transactions;
    }
    
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
    
    public List<RecruiterTransaction> getAllTransactionsByRecruiter() {
        List<RecruiterTransaction> transactions = new ArrayList<>();
        String sql = "SELECT * FROM RecruiterTransaction ORDER BY transactionDate DESC";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            
            while (rs.next()) {
                RecruiterTransaction rt = new RecruiterTransaction();
                rt.setTransactionID(rs.getInt("transactionID"));
                rt.setRecruiterID(rs.getInt("recruiterID"));
                rt.setType(rs.getString("transactionType"));
                rt.setAmount(rs.getBigDecimal("amount"));
                rt.setDescription(rs.getString("description"));
                rt.setTransactionDate(rs.getTimestamp("transactionDate"));
                
                int relatedID = rs.getInt("relatedPostID");
                rt.setRelatedID(rs.wasNull() ? null : relatedID);
                
                transactions.add(rt);
            }
        } catch (SQLException e) {
            System.err.println("Error getting recruiter transactions: " + e.getMessage());
            e.printStackTrace();
        }
        return transactions;
    }
    
    
    public List<RecruiterTransaction> getAllTransactionsByFreelancer() {
        List<RecruiterTransaction> transactions = new ArrayList<>();
        String sql = "SELECT * FROM FreelancerTransaction ORDER BY transactionDate DESC";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            
            while (rs.next()) {
                RecruiterTransaction rt = new RecruiterTransaction();
                rt.setTransactionID(rs.getInt("transactionID"));
                rt.setRecruiterID(rs.getInt("freelancerID"));
                rt.setType(rs.getString("transactionType"));
                rt.setAmount(rs.getBigDecimal("amount"));
                rt.setDescription(rs.getString("description"));
                rt.setTransactionDate(rs.getTimestamp("transactionDate"));
                
                int relatedID = rs.getInt("relatedPostID");
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
    
    public boolean insertDepositTransaction(int recruiterID, BigDecimal amount) {
        String sql = "INSERT INTO RecruiterTransaction (recruiterID,transactionType,amount,transactionDate,description,statusTransaction) " +
                     "VALUES (?, 'Deposit', ?, GETDATE(), 'Nạp tiền vào tài khoản', 'Completed')";
        try (
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, recruiterID);
            ps.setBigDecimal(2, amount);

            return  ps.executeUpdate()>0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean insertTransaction(int recruiterID, BigDecimal amount) {
        String sql = "INSERT INTO RecruiterTransaction (recruiterID,transactionType,amount,transactionDate,description,statusTransaction) " +
                     "VALUES (?, 'TierSubscription', ?, GETDATE(), 'Thanh toán cho account tier', 'Completed')";
        try (
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, recruiterID);
            ps.setBigDecimal(2, amount);

            return  ps.executeUpdate()>0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean insertDepositTransactionJobseeker(int jobseekerID, BigDecimal amount) {
        String sql = "INSERT INTO FreelancerTransaction (freelancerID,transactionType,amount,transactionDate,description,statusTransaction) " +
                     "VALUES (?, 'Deposit', ?, GETDATE(), 'Nạp tiền vào tài khoản', 'Completed')";
        try (
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, jobseekerID);
            ps.setBigDecimal(2, amount);

            return  ps.executeUpdate()>0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean insertTransactionJobseeker(int jobseekerID, BigDecimal amount) {
        String sql = "INSERT INTO FreelancerTransaction (freelancerID,transactionType,amount,transactionDate,description,statusTransaction) " +
                     "VALUES (?, 'TierSubscription', ?, GETDATE(), 'Thanh toán cho account tier', 'Completed')";
        try (
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, jobseekerID);
            ps.setBigDecimal(2, amount);

            return  ps.executeUpdate()>0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
