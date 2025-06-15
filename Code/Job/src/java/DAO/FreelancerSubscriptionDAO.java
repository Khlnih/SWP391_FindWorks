/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;
import java.sql.*;
import java.util.ArrayList;
import Model.FreelancerSubscription;
import Model.RecruiterSubscription;
import java.util.List;
/**
 * 
 *
 * @author ADMIN
 */
public class FreelancerSubscriptionDAO extends DBContext{
    public List<FreelancerSubscription> getActiveFreelancerSubscriptions() {
        List<FreelancerSubscription> list = new ArrayList<>();
        String sql = "SELECT f.freelancerID, f.username, f.first_name, f.last_name, " +
                     "f.email_contact, f.phone_contact, " +
                     "uts.subscriptionID, uts.tierID, uts.startDate, uts.endDate, uts.isActiveSubscription, ats.tierName,ats.price " +
                     "FROM Freelancer f " +
                     "JOIN UserTierSubscriptions uts ON f.freelancerID = uts.freelancerID "+
                     "JOIN AccountTiers ats ON uts.tierID = ats.tierID " +
                     "WHERE uts.isActiveSubscription = 1";

        try (
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
        ) {
            while (rs.next()) {
                FreelancerSubscription fs = new FreelancerSubscription();
                fs.setFreelancerID(rs.getInt("freelancerID"));
                fs.setUsername(rs.getString("username"));
                fs.setFirst_name(rs.getString("first_name"));
                fs.setLast_name(rs.getString("last_name"));
                fs.setEmail_contact(rs.getString("email_contact"));
                fs.setPhone_contact(rs.getString("phone_contact"));
                fs.setSubscriptionID(rs.getInt("subscriptionID"));
                fs.setTierID(rs.getInt("tierID"));
                fs.setStartDate(rs.getString("startDate"));
                fs.setEndDate(rs.getString("endDate"));
                fs.setIsActiveSubscription(rs.getBoolean("isActiveSubscription"));
                fs.setTierName(rs.getString("tierName"));
                fs.setPrice(rs.getDouble("price"));

                list.add(fs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
    public boolean updateStatus(int subscriptionId, int status) {
        if (connection == null) {
            System.err.println("Database connection is null");
            return false;
        }
        
        String sql = "UPDATE UserTierSubscriptions SET isActiveSubscription = ? WHERE subscriptionID = ?";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, status);
            stm.setInt(2, subscriptionId);
            
            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error updating subscription status: " + e.getMessage());
            return false;
        }
    }
}
