package DAO;

import Model.Jobseeker;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class JobseekerDAO extends DBContext {
    
    public ArrayList<Jobseeker> getAllJobSeeker() {
        ArrayList<Jobseeker> list = new ArrayList<>();
        
        if (connection == null) {
            System.err.println("Database connection is null");
            return list;
        }
        
        String sql = "SELECT * FROM Freelancer";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Jobseeker jobseeker = new Jobseeker();
                jobseeker.setFreelanceID(rs.getInt("freelanceID"));
                jobseeker.setUsername(rs.getString("username"));
                jobseeker.setPassword(rs.getString("password"));
                jobseeker.setFirstName(rs.getString("first_name"));
                jobseeker.setLastName(rs.getString("last_name"));
                jobseeker.setImage(rs.getString("image"));
                jobseeker.setGender(rs.getBoolean("gender"));
                jobseeker.setDob(rs.getString("dob"));
                jobseeker.setDescribe(rs.getString("describe"));
                jobseeker.setEmail__contact(rs.getString("email__contact"));
                jobseeker.setPhone_contact(rs.getString("phone_contact"));
                jobseeker.setStatus(rs.getString("status"));
                
                list.add(jobseeker);
            }
            System.out.println("Found " + list.size() + " jobseekers");
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error getting jobseekers: " + e.getMessage());
        }
        
        return list;
    }
    
    
    
    
    
}
