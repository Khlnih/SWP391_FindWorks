package DAO;


import Model.RecruiterSubscription;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.util.ArrayList;
import java.util.List;
/**
 * Data Access Object cho RecruiterSubscription
 */
public class RecruiterSubscriptionDAO extends DBContext {
    
    public boolean updateSubscriptionStatus(int subscriptionId, int status) {
        String sql = "UPDATE UserTierSubscriptions SET status = ? WHERE subscriptionID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, status);
            ps.setInt(2, subscriptionId);
            
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<RecruiterSubscription> getAllRecruiterSubscriptions() {
        List<RecruiterSubscription> list = new ArrayList<>();
        String sql = "SELECT \n" +
                    "    r.recruiterID,\n" +
                    "    c.company_name,\n" +
                    "    c.describe ,\n" +
                    "    r.email_contact,r.first_name,r.last_name, \n" +
                    "    r.phone_contact,\n" +
                    "    u.subscriptionID,\n" +
                    "    a.tierID,\n" +
                    "    u.startDate,\n" +
                    "    u.endDate,\n" +
                    "    CASE \n" +
                    "        WHEN u.endDate >= GETDATE() THEN 1\n" +
                    "        ELSE 0\n" +
                    "    END AS isActiveSubscription,\n" +
                    "    a.tierName,\n" +
                    "    a.price\n" +
                    "FROM UserTierSubscriptions u\n" +
                    "JOIN Recruiter r ON u.recruiterID = r.recruiterID\n" +
                    "JOIN Company c ON c.recruiterID = r.recruiterID\n" +
                    "JOIN AccountTiers a ON u.tierID = a.tierID WHERE u.isActiveSubscription = 1";

                try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                RecruiterSubscription subscription = new RecruiterSubscription();
                                subscription.setRecruiterID(rs.getInt("recruiterID"));
                subscription.setCompanyName(rs.getString("company_name"));
                subscription.setCompanyAddress(rs.getString("describe"));
                subscription.setCompanyEmail(rs.getString("email_contact"));
                subscription.setFirst_name(rs.getString("first_name"));
                subscription.setLast_name(rs.getString("last_name"));
                subscription.setCompanyPhone(rs.getString("phone_contact"));
                subscription.setSubscriptionID(rs.getInt("subscriptionID"));
                subscription.setTierID(rs.getInt("tierID"));
                subscription.setStartDate(rs.getString("startDate"));
                subscription.setEndDate(rs.getString("endDate"));
                subscription.setIsActiveSubscription(rs.getBoolean("isActiveSubscription"));
                subscription.setTierName(rs.getString("tierName"));
                subscription.setPrice(rs.getDouble("price"));
                list.add(subscription);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception for debugging
        }
        return list;
    }
}
