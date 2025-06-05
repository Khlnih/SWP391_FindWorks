package DAO;

import Model.JobType;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class JobTypeDAO {
    
   
    public List<JobType> getAllJobTypes() {
        List<JobType> jobTypes = new ArrayList<>();
        String sql = "SELECT jobTypeID, job_type_name FROM JobType ORDER BY job_type_name";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                JobType jobType = new JobType();
                jobType.setJobTypeID(rs.getInt("jobTypeID"));
                jobType.setJobTypeName(rs.getString("job_type_name"));
                jobTypes.add(jobType);
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error getting all job types: " + e.getMessage());
            e.printStackTrace();
        }
        
        return jobTypes;
    }
    
    public JobType getJobTypeById(int jobTypeID) {
        String sql = "SELECT jobTypeID, job_type_name FROM JobType WHERE jobTypeID = ?";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, jobTypeID);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    JobType jobType = new JobType();
                    jobType.setJobTypeID(rs.getInt("jobTypeID"));
                    jobType.setJobTypeName(rs.getString("job_type_name"));
                    return jobType;
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error getting job type by ID: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    public boolean createJobType(JobType jobType) {
        String sql = "INSERT INTO JobType (job_type_name) VALUES (?)";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, jobType.getJobTypeName());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error creating job type: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean updateJobType(JobType jobType) {
        String sql = "UPDATE JobType SET job_type_name = ? WHERE jobTypeID = ?";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, jobType.getJobTypeName());
            ps.setInt(2, jobType.getJobTypeID());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error updating job type: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteJobType(int jobTypeID) {
        String sql = "DELETE FROM JobType WHERE jobTypeID = ?";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, jobTypeID);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error deleting job type: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
