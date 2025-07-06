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
    
    
    
    public boolean updateCompanyBasic(Company company) {
        if (connection == null) {
            System.err.println("Database connection is null");
            return false;
        }
        
        String sql = "UPDATE Company SET "
                   + "company_name = ?, "
                   + "website = ?, "
                   + "describe = ?, "
                   + "location = ? "
                   + "WHERE companyID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, company.getCompany_name());
            ps.setString(2, company.getWebsite());
            ps.setString(3, company.getDescribe());
            ps.setString(4, company.getLocation());
            ps.setInt(5, company.getCompanyID());

            int affected = ps.executeUpdate();
            return affected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating company basic info: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
