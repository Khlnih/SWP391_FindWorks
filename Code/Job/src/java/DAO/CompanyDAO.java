package DAO;

import Model.Company;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CompanyDAO extends DBContext{
    
    public Company getCompanyByRecruiterId(int recruiterId) {
        String sql = "SELECT * FROM Company WHERE recruiterID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, recruiterId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Company(
                    rs.getInt("companyID"),
                    rs.getString("company_name"),
                    rs.getInt("team_numberID"),
                    rs.getString("established_on"),
                    rs.getString("logo"),
                    rs.getString("website"),
                    rs.getString("describe"),
                    rs.getString("location"),
                    rs.getInt("recruiterID")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
