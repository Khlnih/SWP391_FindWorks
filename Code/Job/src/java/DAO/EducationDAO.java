package DAO;

import Model.Education;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for Education table
 * @author Cascade
 */
public class EducationDAO extends DBContext {
    
    /**
     * Get all education records for a specific jobseeker
     * 
     * @param freelancerID The ID of the jobseeker
     * @return ArrayList of Education objects
     */
    public ArrayList<Education> getEducationByFreelancerID(int freelancerID) {
        ArrayList<Education> list = new ArrayList<>();
        
        if (connection == null) {
            System.err.println("Database connection is null");
            return list;
        }
        
        String sql = "SELECT e.*, d.degree_name " +
                     "FROM Education e " +
                     "JOIN Degree d ON e.degreeID = d.degreeID " +
                     "WHERE e.freelancerID = ? " +
                     "ORDER BY e.start_date DESC";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, freelancerID);
            ResultSet rs = stm.executeQuery();
            
            while (rs.next()) {
                Education education = new Education();
                education.setEducationID(rs.getInt("educationID"));
                education.setUniversityName(rs.getString("university_name"));
                education.setStartDate(rs.getDate("start_date"));
                education.setEndDate(rs.getDate("end_date"));
                education.setFreelancerID(rs.getInt("freelancerID"));
                education.setDegreeID(rs.getInt("degreeID"));
                education.setDegreeName(rs.getString("degree_name"));
                
                list.add(education);
            }
        } catch (SQLException e) {
            Logger.getLogger(EducationDAO.class.getName()).log(Level.SEVERE, null, e);
            System.err.println("Error getting education by freelancer ID: " + e.getMessage());
        }
        
        return list;
    }
    
    /**
     * Add a new education record
     * 
     * @param education The Education object to add
     * @return true if successful, false otherwise
     */
    public boolean addEducation(Education education) {
        if (connection == null) {
            System.err.println("Database connection is null");
            return false;
        }
        
        String sql = "INSERT INTO Education (university_name, start_date, end_date, freelancerID, degreeID) " +
                     "VALUES (?, ?, ?, ?, ?)";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, education.getUniversityName());
            stm.setDate(2, education.getStartDate());
            stm.setDate(3, education.getEndDate());
            stm.setInt(4, education.getFreelancerID());
            stm.setInt(5, education.getDegreeID());
            
            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            Logger.getLogger(EducationDAO.class.getName()).log(Level.SEVERE, null, e);
            System.err.println("Error adding education: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Update an existing education record
     * 
     * @param education The Education object with updated information
     * @return true if successful, false otherwise
     */
    public boolean updateEducation(Education education) {
        if (connection == null) {
            System.err.println("Database connection is null");
            return false;
        }
        
        String sql = "UPDATE Education SET university_name = ?, start_date = ?, end_date = ?, degreeID = ? " +
                     "WHERE educationID = ? AND freelancerID = ?";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, education.getUniversityName());
            stm.setDate(2, education.getStartDate());
            stm.setDate(3, education.getEndDate());
            stm.setInt(4, education.getDegreeID());
            stm.setInt(5, education.getEducationID());
            stm.setInt(6, education.getFreelancerID());
            
            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            Logger.getLogger(EducationDAO.class.getName()).log(Level.SEVERE, null, e);
            System.err.println("Error updating education: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Delete an education record
     * 
     * @param educationID The ID of the education record to delete
     * @param freelancerID The ID of the jobseeker (for security check)
     * @return true if successful, false otherwise
     */
    public boolean deleteEducation(int educationID, int freelancerID) {
        if (connection == null) {
            System.err.println("Database connection is null");
            return false;
        }
        
        String sql = "DELETE FROM Education WHERE educationID = ? AND freelancerID = ?";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, educationID);
            stm.setInt(2, freelancerID);
            
            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            Logger.getLogger(EducationDAO.class.getName()).log(Level.SEVERE, null, e);
            System.err.println("Error deleting education: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Get a single education record by its ID
     * 
     * @param educationID The ID of the education record
     * @return Education object or null if not found
     */
    public Education getEducationByID(int educationID) {
        if (connection == null) {
            System.err.println("Database connection is null");
            return null;
        }
        
        String sql = "SELECT e.*, d.degree_name " +
                     "FROM Education e " +
                     "JOIN Degree d ON e.degreeID = d.dregeeID " +
                     "WHERE e.educationID = ?";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, educationID);
            ResultSet rs = stm.executeQuery();
            
            if (rs.next()) {
                Education education = new Education();
                education.setEducationID(rs.getInt("educationID"));
                education.setUniversityName(rs.getString("university_name"));
                education.setStartDate(rs.getDate("start_date"));
                education.setEndDate(rs.getDate("end_date"));
                education.setFreelancerID(rs.getInt("freelancerID"));
                education.setDegreeID(rs.getInt("degreeID"));
                education.setDegreeName(rs.getString("degree_name"));
                
                return education;
            }
        } catch (SQLException e) {
            Logger.getLogger(EducationDAO.class.getName()).log(Level.SEVERE, null, e);
            System.err.println("Error getting education by ID: " + e.getMessage());
        }
        
        return null;
    }
}
