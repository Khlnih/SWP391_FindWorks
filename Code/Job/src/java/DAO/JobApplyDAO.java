package DAO;

import Model.JobApply;
import java.sql.PreparedStatement;
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
}
