/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import Model.UserTierSubscriptions;
import java.util.ArrayList;
import java.sql.ResultSet;
/**
 *
 * @author ADMIN
 */
public class UserTierSubscriptionDAO extends DBContext{
    public boolean insertUserTierSubscriptionWithOptionalDuration(int freelancerID, int tierID, int durationDays) {
        String sql;

        if (durationDays > 0) {
            sql = "INSERT INTO UserTierSubscriptions (freelancerID, tierID, startDate, endDate) " +
                  "VALUES (?, ?, GETDATE(), DATEADD(DAY, ?, GETDATE()))";
        } else {
            sql = "INSERT INTO UserTierSubscriptions (freelancerID, tierID, startDate) " +
                  "VALUES (?, ?, GETDATE())";
        }

        try (
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, freelancerID);
            ps.setInt(2, tierID);

            if (durationDays > 0) {
                ps.setInt(3, durationDays);
            }

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public ArrayList<UserTierSubscriptions> getActiveSubscriptionsByRecruiter(int recruiterID) {
        ArrayList<UserTierSubscriptions> list = new ArrayList<>();
        String sql = "SELECT * FROM UserTierSubscriptions WHERE recruiterID = ? AND isActiveSubscription = 0";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, recruiterID);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    UserTierSubscriptions sub = new UserTierSubscriptions();
                    sub.setSubscriptionID(rs.getInt("subscriptionID"));
                    sub.setRecruiterID(rs.getInt("recruiterID"));
                    sub.setFreelancerID(rs.getInt("freelancerID"));
                    sub.setTierID(rs.getInt("tierID"));
                    sub.setStartDate(rs.getDate("startDate"));
                    sub.setEndDate(rs.getDate("endDate"));
                    sub.setTransactionID(rs.getInt("transactionID"));
                    sub.setIsActiveSubscription(rs.getInt("isActiveSubscription"));
                    list.add(sub);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); 
        }

        return list;
    }
}
