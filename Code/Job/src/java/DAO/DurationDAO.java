package DAO;

import Model.Duration;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DurationDAO {
    
    public List<Duration> getAllDurations() {
        List<Duration> durations = new ArrayList<>();
        String sql = "SELECT durationID, duration_name FROM Duration ORDER BY durationID";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Duration duration = new Duration();
                duration.setDurationID(rs.getInt("durationID"));
                duration.setDurationName(rs.getString("duration_name"));
                durations.add(duration);
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error getting all durations: " + e.getMessage());
            e.printStackTrace();
        }
        
        return durations;
    }
    
    public Duration getDurationById(int durationID) {
        String sql = "SELECT durationID, duration_name FROM Duration WHERE durationID = ?";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, durationID);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Duration duration = new Duration();
                    duration.setDurationID(rs.getInt("durationID"));
                    duration.setDurationName(rs.getString("duration_name"));
                    return duration;
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error getting duration by ID: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    public boolean createDuration(Duration duration) {
        String sql = "INSERT INTO Duration (duration_name) VALUES (?)";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, duration.getDurationName());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error creating duration: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean updateDuration(Duration duration) {
        String sql = "UPDATE Duration SET duration_name = ? WHERE durationID = ?";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, duration.getDurationName());
            ps.setInt(2, duration.getDurationID());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error updating duration: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteDuration(int durationID) {
        String sql = "DELETE FROM Duration WHERE durationID = ?";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, durationID);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error deleting duration: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
