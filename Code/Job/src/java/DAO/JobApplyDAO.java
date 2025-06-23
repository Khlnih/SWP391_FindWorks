package DAO;

import Model.JobApply;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

/**
 *
 * @author ADMIN
 */
public class JobApplyDAO extends DBContext {

    public boolean addJobApply(JobApply jobApply) {
        String sql = "INSERT INTO JobApply (postID, freelancerID, coverLetter, resumePath, dateApply, statusApply) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, jobApply.getPostID());
            st.setInt(2, jobApply.getFreelancerID());
            st.setString(3, jobApply.getCoverLetter());
            st.setString(4, jobApply.getResumePath());
            st.setTimestamp(5, new Timestamp(jobApply.getDateApply().getTime()));
            st.setString(6, jobApply.getStatusApply());

            int result = st.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            System.out.println("Error in addJobApply DAO: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean isFavorite(int freelancerID, int postID) {
        String sql = "SELECT COUNT(*) FROM JobApply WHERE freelancerID = ? AND postID = ?";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, freelancerID);
            ps.setInt(2, postID);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error checking favorite: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    public boolean applyJob(int freelancerID, int postID, String coverLetter, String resumePath) {
        String sql = "INSERT INTO JobApply (freelancerID, postID, dateApply, coverLetter, resumePath) " +
                   "VALUES (?, ?, GETDATE(), ?, ?)";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, freelancerID);
            ps.setInt(2, postID);
            ps.setString(3, coverLetter);
            ps.setString(4, resumePath);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error applying job: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

}
