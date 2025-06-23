package DAO;

import Model.Notification;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NotificationDAO extends DBContext {
    
    // Create a new notification
    public void addFreelancerNotification(int id, String message, String notiType) throws SQLException {
            String sql = "INSERT INTO Notifications( recipient_freelancerID, message, notificationType, isRead, readDate, createdBy_adminID) \n" +
                            " VALUES ( ?, ?, ?, 0, GETDATE(), 1);";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.setString(2, message);
            stmt.setString(3, notiType);
            stmt.executeUpdate();
        }
    }
    public void addRecruiterNotification(int id, String message, String notiType) throws SQLException {
            String sql = "INSERT INTO Notifications( recipient_recruiterID, message, notificationType, isRead, readDate, createdBy_adminID) \n" +
                            " VALUES ( ?, ?, ?, 0, GETDATE(), 1);";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.setString(2, message);
            stmt.setString(3, notiType);
            stmt.executeUpdate();
        }
    }
    public int countNotificationsByFreelancerId(int freelancerId) {
        String sql = "SELECT COUNT(*) AS NumberOfNotifications " +
                     "FROM [Notifications] " +
                     "WHERE [recipient_freelancerID] = ? AND isRead = 0";
        int count = 0; 

        try (
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, freelancerId); 

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt("NumberOfNotifications");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error counting notifications for freelancer ID " + freelancerId + ": " + e.getMessage());
            e.printStackTrace();
            return -1; 
        }
        return count;
    }
}
