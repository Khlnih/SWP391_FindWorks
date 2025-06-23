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
    
    public ArrayList<Notification> getUnreadNotificationsForFreelancer(int freelancerID)  {
        ArrayList<Notification> list = new ArrayList<>();
        String sql = "SELECT * FROM Notifications WHERE recipient_freelancerID = ? AND isRead = 0";

        try { 
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, freelancerID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Notification noti = new Notification(
                    rs.getInt("notificationID"),
                    rs.getInt("recipient_freelancerID"),
                    rs.getInt("recipient_recruiterID"),
                    rs.getString("message"),
                    rs.getString("notificationType"),
                    rs.getInt("isRead"),
                    rs.getDate("readDate"),
                    (rs.getObject("createdBy_adminID") != null ? rs.getInt("createdBy_adminID") : null)
                );
                list.add(noti);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public ArrayList<Notification> getNotificationsForFreelancer(int freelancerID)  {
        ArrayList<Notification> list = new ArrayList<>();
        String sql = "SELECT * FROM Notifications WHERE recipient_freelancerID = ? AND isRead != 2";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, freelancerID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Notification noti = new Notification(
                    rs.getInt("notificationID"),
                    rs.getInt("recipient_freelancerID"),
                    rs.getInt("recipient_recruiterID"),
                    rs.getString("message"),
                    rs.getString("notificationType"),
                    rs.getInt("isRead"),
                    rs.getDate("readDate"),
                    (rs.getObject("createdBy_adminID") != null ? rs.getInt("createdBy_adminID") : null)
                );
                list.add(noti);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public boolean markAllNotificationsAsRead(int freelancerID, int notificationID) {
        String sql = "UPDATE Notifications SET isRead = 1 WHERE recipient_freelancerID = ? AND isRead = 0 AND notificationID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, freelancerID);
            ps.setInt(2, notificationID);
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean markAllNotificationsAsDeleted(int freelancerID, int notificationID) {
        String sql = "UPDATE Notifications SET isRead = 2 WHERE recipient_freelancerID = ? AND notificationID = ? AND isRead !=2";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, freelancerID);
            ps.setInt(2, notificationID);
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
