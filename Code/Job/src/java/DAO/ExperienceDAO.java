package DAO;

import Model.Experience;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for Experience table
 * @author Cascade
 */
public class ExperienceDAO extends DBContext {
    
    /**
     * Get all experience records for a specific jobseeker
     * 
     * @param freelancerID The ID of the jobseeker
     * @return ArrayList of Experience objects
     */
    public ArrayList<Experience> getExperienceByFreelancerID(int freelancerID) {
        ArrayList<Experience> list = new ArrayList<>();
        
        if (connection == null) {
            System.err.println("Database connection is null");
            return list;
        }
        
        String sql = "SELECT * FROM Experience WHERE freelancerID = ? ORDER BY start_date DESC";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, freelancerID);
            ResultSet rs = stm.executeQuery();
            
            while (rs.next()) {
                Experience experience = new Experience();
                experience.setExperienceID(rs.getInt("experienceID"));
                experience.setExperienceWorkName(rs.getString("experience_work_name"));
                experience.setPosition(rs.getString("position"));
                experience.setStartDate(rs.getDate("start_date"));
                experience.setEndDate(rs.getDate("end_date"));
                experience.setYourProject(rs.getString("your_project"));
                experience.setFreelancerID(rs.getInt("freelancerID"));
                
                list.add(experience);
            }
        } catch (SQLException e) {
            Logger.getLogger(ExperienceDAO.class.getName()).log(Level.SEVERE, null, e);
            System.err.println("Error getting experience by freelancer ID: " + e.getMessage());
        }
        
        return list;
    }
    
    /**
     * Add a new experience record
     * 
     * @param experience The Experience object to add
     * @return true if successful, false otherwise
     */
    public boolean addExperience(Experience experience) {
        if (connection == null) {
            System.err.println("Database connection is null");
            return false;
        }
        
        String sql = "INSERT INTO Experience (experience_work_name, position, start_date, end_date, your_project, freelancerID) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, experience.getExperienceWorkName());
            stm.setString(2, experience.getPosition());
            stm.setDate(3, experience.getStartDate());
            stm.setDate(4, experience.getEndDate());
            stm.setString(5, experience.getYourProject());
            stm.setInt(6, experience.getFreelancerID());
            
            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            Logger.getLogger(ExperienceDAO.class.getName()).log(Level.SEVERE, null, e);
            System.err.println("Error adding experience: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Update an existing experience record
     * 
     * @param experience The Experience object with updated information
     * @return true if successful, false otherwise
     */
    public boolean updateExperience(Experience experience) {
        if (connection == null) {
            System.err.println("Database connection is null");
            return false;
        }
        
        String sql = "UPDATE Experience SET experience_work_name = ?, position = ?, " +
                     "start_date = ?, end_date = ?, your_project = ? " +
                     "WHERE experienceID = ? AND freelancerID = ?";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, experience.getExperienceWorkName());
            stm.setString(2, experience.getPosition());
            stm.setDate(3, experience.getStartDate());
            stm.setDate(4, experience.getEndDate());
            stm.setString(5, experience.getYourProject());
            stm.setInt(6, experience.getExperienceID());
            stm.setInt(7, experience.getFreelancerID());
            
            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            Logger.getLogger(ExperienceDAO.class.getName()).log(Level.SEVERE, null, e);
            System.err.println("Error updating experience: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Delete an experience record
     * 
     * @param experienceID The ID of the experience record to delete
     * @param freelancerID The ID of the jobseeker (for security check)
     * @return true if successful, false otherwise
     */
    public boolean deleteExperience(int experienceID, int freelancerID) {
        if (connection == null) {
            System.err.println("Database connection is null");
            return false;
        }
        
        String sql = "DELETE FROM Experience WHERE experienceID = ? AND freelancerID = ?";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, experienceID);
            stm.setInt(2, freelancerID);
            
            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            Logger.getLogger(ExperienceDAO.class.getName()).log(Level.SEVERE, null, e);
            System.err.println("Error deleting experience: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Get a single experience record by its ID
     * 
     * @param experienceID The ID of the experience record
     * @return Experience object or null if not found
     */
    public Experience getExperienceByID(int experienceID) {
        if (connection == null) {
            System.err.println("Database connection is null");
            return null;
        }
        
        String sql = "SELECT * FROM Experience WHERE experienceID = ?";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, experienceID);
            ResultSet rs = stm.executeQuery();
            
            if (rs.next()) {
                Experience experience = new Experience();
                experience.setExperienceID(rs.getInt("experienceID"));
                experience.setExperienceWorkName(rs.getString("experience_work_name"));
                experience.setPosition(rs.getString("position"));
                experience.setStartDate(rs.getDate("start_date"));
                experience.setEndDate(rs.getDate("end_date"));
                experience.setYourProject(rs.getString("your_project"));
                experience.setFreelancerID(rs.getInt("freelancerID"));
                
                return experience;
            }
        } catch (SQLException e) {
            Logger.getLogger(ExperienceDAO.class.getName()).log(Level.SEVERE, null, e);
            System.err.println("Error getting experience by ID: " + e.getMessage());
        }
        
        return null;
    }
}
