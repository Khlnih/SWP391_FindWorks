package DAO;

import Model.Skill;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for Skills table (jobseeker skills junction table)
 * @author Cascade
 */
public class JobseekerSkillDAO extends DBContext {
    
    /**
     * Get all skills for a specific jobseeker
     * 
     * @param freelancerID The ID of the jobseeker
     * @return ArrayList of Skill objects
     */
    public ArrayList<Skill> getSkillsByFreelancerID(int freelancerID) {
        ArrayList<Skill> list = new ArrayList<>();
        
        if (connection == null) {
            System.err.println("Database connection is null");
            return list;
        }
        
        String sql = "SELECT s.*, ss.skill_set_name, ss.description, ss.ExpertiID, e.ExpertiseName " +
                     "FROM Skills s " +
                     "JOIN Skill_Set ss ON s.skill_set_ID = ss.skill_set_ID " +
                     "LEFT JOIN Expertise e ON ss.ExpertiID = e.ExpertiseID " +
                     "WHERE s.freelancerID = ? " +
                     "ORDER BY e.ExpertiseName, ss.skill_set_name";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, freelancerID);
            ResultSet rs = stm.executeQuery();
            
            while (rs.next()) {
                Skill skill = new Skill();
                skill.setSkillID(rs.getInt("skillID"));
                skill.setSkillSetID(rs.getInt("skill_set_ID"));
                skill.setFreelancerID(rs.getInt("freelancerID"));
                skill.setLevel(rs.getInt("level"));
                skill.setSkillSetName(rs.getString("skill_set_name"));
                skill.setDescription(rs.getString("description"));
                skill.setExpertiseID(rs.getInt("ExpertiID"));
                skill.setExpertiseName(rs.getString("ExpertiseName"));
                
                list.add(skill);
            }
        } catch (SQLException e) {
            Logger.getLogger(JobseekerSkillDAO.class.getName()).log(Level.SEVERE, null, e);
            System.err.println("Error getting skills by freelancer ID: " + e.getMessage());
        }
        
        return list;
    }
    
    /**
     * Add a new skill for a jobseeker
     * 
     * @param skill The Skill object to add
     * @return true if successful, false otherwise
     */
    public boolean addSkill(Skill skill) {
        if (connection == null) {
            System.err.println("Database connection is null");
            return false;
        }
        
        String sql = "INSERT INTO Skills (skill_set_ID, freelancerID, level) VALUES (?, ?, ?)";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, skill.getSkillSetID());
            stm.setInt(2, skill.getFreelancerID());
            stm.setInt(3, skill.getLevel());
            
            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            Logger.getLogger(JobseekerSkillDAO.class.getName()).log(Level.SEVERE, null, e);
            System.err.println("Error adding skill: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Update skill level for a jobseeker
     * 
     * @param skill The Skill object with updated information
     * @return true if successful, false otherwise
     */
    public boolean updateSkillLevel(Skill skill) {
        if (connection == null) {
            System.err.println("Database connection is null");
            return false;
        }
        
        String sql = "UPDATE Skills SET level = ? WHERE skillID = ? AND freelancerID = ?";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, skill.getLevel());
            stm.setInt(2, skill.getSkillID());
            stm.setInt(3, skill.getFreelancerID());
            
            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            Logger.getLogger(JobseekerSkillDAO.class.getName()).log(Level.SEVERE, null, e);
            System.err.println("Error updating skill level: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Delete a skill for a jobseeker
     * 
     * @param skillID The ID of the skill record to delete
     * @param freelancerID The ID of the jobseeker (for security check)
     * @return true if successful, false otherwise
     */
    public boolean deleteSkill(int skillID, int freelancerID) {
        if (connection == null) {
            System.err.println("Database connection is null");
            return false;
        }
        
        String sql = "DELETE FROM Skills WHERE skillID = ? AND freelancerID = ?";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, skillID);
            stm.setInt(2, freelancerID);
            
            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            Logger.getLogger(JobseekerSkillDAO.class.getName()).log(Level.SEVERE, null, e);
            System.err.println("Error deleting skill: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Get a single skill record by its ID
     * 
     * @param skillID The ID of the skill record
     * @return Skill object or null if not found
     */
    public Skill getSkillByID(int skillID) {
        if (connection == null) {
            System.err.println("Database connection is null");
            return null;
        }
        
        String sql = "SELECT s.*, ss.skill_set_name, ss.description, ss.ExpertiID, e.ExpertiseName " +
                     "FROM Skills s " +
                     "JOIN Skill_Set ss ON s.skill_set_ID = ss.skill_set_ID " +
                     "LEFT JOIN Expertise e ON ss.ExpertiID = e.ExpertiseID " +
                     "WHERE s.skillID = ?";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, skillID);
            ResultSet rs = stm.executeQuery();
            
            if (rs.next()) {
                Skill skill = new Skill();
                skill.setSkillID(rs.getInt("skillID"));
                skill.setSkillSetID(rs.getInt("skill_set_ID"));
                skill.setFreelancerID(rs.getInt("freelancerID"));
                skill.setLevel(rs.getInt("level"));
                skill.setSkillSetName(rs.getString("skill_set_name"));
                skill.setDescription(rs.getString("description"));
                skill.setExpertiseID(rs.getInt("ExpertiID"));
                skill.setExpertiseName(rs.getString("ExpertiseName"));
                
                return skill;
            }
        } catch (SQLException e) {
            Logger.getLogger(JobseekerSkillDAO.class.getName()).log(Level.SEVERE, null, e);
            System.err.println("Error getting skill by ID: " + e.getMessage());
        }
        
        return null;
    }
    
    /**
     * Check if a jobseeker already has a specific skill
     * 
     * @param freelancerID The ID of the jobseeker
     * @param skillSetID The ID of the skill set
     * @return true if the jobseeker already has the skill, false otherwise
     */
    public boolean hasSkill(int freelancerID, int skillSetID) {
        if (connection == null) {
            System.err.println("Database connection is null");
            return false;
        }
        
        String sql = "SELECT COUNT(*) FROM Skills WHERE freelancerID = ? AND skill_set_ID = ?";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, freelancerID);
            stm.setInt(2, skillSetID);
            ResultSet rs = stm.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            Logger.getLogger(JobseekerSkillDAO.class.getName()).log(Level.SEVERE, null, e);
            System.err.println("Error checking if jobseeker has skill: " + e.getMessage());
        }
        
        return false;
    }
}
