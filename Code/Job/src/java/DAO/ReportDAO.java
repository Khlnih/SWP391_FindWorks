/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;
import java.sql.PreparedStatement;
import java.sql.SQLException;
/**
 *
 * @author ADMIN
 */
public class ReportDAO extends DBContext{
    public boolean insertReportBasic(int reporterFreelancerID, int reportedPostID, String message) {
        String sql = "INSERT INTO Report (reporter_freelancerID, reported_postID, message) VALUES (?, ?, ?)";

        try (
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, reporterFreelancerID);
            ps.setInt(2, reportedPostID);
            ps.setString(3, message);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
}
