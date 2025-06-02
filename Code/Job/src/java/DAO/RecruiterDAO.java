package DAO;

import Model.Recruiter;
import Model.Company;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class RecruiterDAO extends DBContext {

    public ArrayList<Recruiter> getAllRecruiters() {
        ArrayList<Recruiter> list = new ArrayList<>();

        if (connection == null) {
            System.err.println("Database connection is null");
            return list;
        }

        String sql = "SELECT * FROM Recruiter WHERE status != 'inactive'";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Recruiter recruiter = new Recruiter();
                recruiter.setRecruiterID(rs.getInt("recruiterID"));
                // Trường username đã bị bỏ trong DB mới
                recruiter.setPassword_hash(rs.getString("password_hash"));
                recruiter.setFirst_name(rs.getString("first_name"));
                recruiter.setLast_name(rs.getString("last_name"));
                recruiter.setGender(rs.getBoolean("gender"));
                recruiter.setDob(rs.getDate("dob"));
                recruiter.setImage(rs.getString("image"));
                recruiter.setMoney(rs.getBigDecimal("money"));
                recruiter.setEmail_contact(rs.getString("email_contact"));
                recruiter.setPhone_contact(rs.getString("phone_contact"));
                recruiter.setStatus(rs.getString("status"));
                // Thêm trường statusChangedByAdminID
                Integer statusChangedByAdminID = rs.getInt("statusChangedByAdminID");
                if (rs.wasNull()) {
                    statusChangedByAdminID = null;
                }
                recruiter.setStatusChangedByAdminID(statusChangedByAdminID);

                list.add(recruiter);
            }
            System.out.println("Found " + list.size() + " recruiters");
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error getting recruiters: " + e.getMessage());
        }

        return list;
    }

    public boolean updateStatus(int id, String status) {
        if (connection == null) {
            System.err.println("Database connection is null");
            return false;
        }

        String sql = "UPDATE Recruiter SET status = ? WHERE recruiterID = ?";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, status);
            stm.setInt(2, id);

            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error updating recruiter status: " + e.getMessage());
            return false;
        }
    }

    public ArrayList<Recruiter> getRecruitersByPage(int page, int pageSize) {
        ArrayList<Recruiter> list = new ArrayList<>();

        if (connection == null) {
            System.err.println("Database connection is null");
            return list;
        }

        int offset = (page - 1) * pageSize;
        String sql = "SELECT * FROM Recruiter WHERE status != 'inactive' ORDER BY recruiterID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, offset);
            stm.setInt(2, pageSize);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Recruiter recruiter = new Recruiter();
                recruiter.setRecruiterID(rs.getInt("recruiterID"));
                // Trường username đã bị bỏ trong DB mới
                recruiter.setPassword_hash(rs.getString("password_hash"));
                recruiter.setFirst_name(rs.getString("first_name"));
                recruiter.setLast_name(rs.getString("last_name"));
                recruiter.setGender(rs.getBoolean("gender"));
                recruiter.setDob(rs.getDate("dob"));
                recruiter.setImage(rs.getString("image"));
                recruiter.setMoney(rs.getBigDecimal("money"));
                recruiter.setEmail_contact(rs.getString("email_contact"));
                recruiter.setPhone_contact(rs.getString("phone_contact"));
                recruiter.setStatus(rs.getString("status"));
                // Thêm trường statusChangedByAdminID
                Integer statusChangedByAdminID = rs.getInt("statusChangedByAdminID");
                if (rs.wasNull()) {
                    statusChangedByAdminID = null;
                }
                recruiter.setStatusChangedByAdminID(statusChangedByAdminID);

                list.add(recruiter);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error getting paginated recruiters: " + e.getMessage());
        }

        return list;
    }

    public int countTotalRecruiters() {
        int count = 0;

        if (connection == null) {
            System.err.println("Database connection is null");
            return count;
        }

        String sql = "SELECT COUNT(*) as total FROM Recruiter WHERE status != 'inactive'";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                count = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error counting recruiters: " + e.getMessage());
        }

        return count;
    }

    public ArrayList<Recruiter> searchRecruiters(String keyword, String searchBy, int page, int pageSize) {
        ArrayList<Recruiter> list = new ArrayList<>();

        if (connection == null) {
            System.err.println("Database connection is null");
            return list;
        }

        int offset = (page - 1) * pageSize;
        StringBuilder sql = new StringBuilder("SELECT * FROM Recruiter WHERE status != 'inactive' ");

        // Add search conditions based on searchBy parameter
        if (keyword != null && !keyword.trim().isEmpty()) {
            switch (searchBy) {
                case "name":
                    sql.append("AND (LOWER(first_name) LIKE ? OR LOWER(last_name) LIKE ?) ");
                    break;
                case "email":
                    sql.append("AND LOWER(email_contact) LIKE ? ");
                    break;
                case "phone":
                    sql.append("AND phone_contact LIKE ? ");
                    break;
                default: // all
                    sql.append("AND (LOWER(first_name) LIKE ? OR LOWER(last_name) LIKE ? OR "
                            + "LOWER(email_contact) LIKE ? OR phone_contact LIKE ?) ");
                    break;
            }
        }

        sql.append("ORDER BY recruiterID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement stm = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;

            // Set search parameters based on searchBy
            if (keyword != null && !keyword.trim().isEmpty()) {
                String searchTerm = "%" + keyword.toLowerCase() + "%";
                switch (searchBy) {
                    case "name":
                        stm.setString(paramIndex++, searchTerm);
                        stm.setString(paramIndex++, searchTerm);
                        break;
                    case "email":
                        stm.setString(paramIndex++, searchTerm);
                        break;
                    case "phone":
                        stm.setString(paramIndex++, "%" + keyword + "%");
                        break;
                    default: // all
                        stm.setString(paramIndex++, searchTerm);
                        stm.setString(paramIndex++, searchTerm);
                        stm.setString(paramIndex++, searchTerm);
                        stm.setString(paramIndex++, "%" + keyword + "%");
                        break;
                }
            }

            // Set pagination parameters
            stm.setInt(paramIndex++, offset);
            stm.setInt(paramIndex, pageSize);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Recruiter recruiter = new Recruiter();
                recruiter.setRecruiterID(rs.getInt("recruiterID"));
                // Trường username đã bị bỏ trong DB mới
                recruiter.setPassword_hash(rs.getString("password_hash"));
                recruiter.setFirst_name(rs.getString("first_name"));
                recruiter.setLast_name(rs.getString("last_name"));
                recruiter.setGender(rs.getBoolean("gender"));
                recruiter.setDob(rs.getDate("dob"));
                recruiter.setImage(rs.getString("image"));
                recruiter.setMoney(rs.getBigDecimal("money"));
                recruiter.setEmail_contact(rs.getString("email_contact"));
                recruiter.setPhone_contact(rs.getString("phone_contact"));
                recruiter.setStatus(rs.getString("status"));
                // Thêm trường statusChangedByAdminID
                Integer statusChangedByAdminID = rs.getInt("statusChangedByAdminID");
                if (rs.wasNull()) {
                    statusChangedByAdminID = null;
                }
                recruiter.setStatusChangedByAdminID(statusChangedByAdminID);

                list.add(recruiter);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error searching recruiters: " + e.getMessage());
        }

        return list;
    }

    public int countSearchResults(String keyword, String searchBy) {
        int count = 0;

        if (connection == null) {
            System.err.println("Database connection is null");
            return count;
        }

        StringBuilder sql = new StringBuilder("SELECT COUNT(*) as total FROM Recruiter WHERE status != 'inactive' ");

        // Add search conditions based on searchBy parameter
        if (keyword != null && !keyword.trim().isEmpty()) {
            switch (searchBy) {
                case "name":
                    sql.append("AND (LOWER(first_name) LIKE ? OR LOWER(last_name) LIKE ?) ");
                    break;
                case "email":
                    sql.append("AND LOWER(email_contact) LIKE ? ");
                    break;
                case "phone":
                    sql.append("AND phone_contact LIKE ? ");
                    break;
                default: // all
                    sql.append("AND (LOWER(first_name) LIKE ? OR LOWER(last_name) LIKE ? OR "
                            + "LOWER(email_contact) LIKE ? OR phone_contact LIKE ?) ");
                    break;
            }
        }

        try (PreparedStatement stm = connection.prepareStatement(sql.toString())) {
            // Set search parameters based on searchBy
            if (keyword != null && !keyword.trim().isEmpty()) {
                String searchTerm = "%" + keyword.toLowerCase() + "%";
                switch (searchBy) {
                    case "name":
                        stm.setString(1, searchTerm);
                        stm.setString(2, searchTerm);
                        break;
                    case "email":
                        stm.setString(1, searchTerm);
                        break;
                    case "phone":
                        stm.setString(1, "%" + keyword + "%");
                        break;
                    default: // all
                        stm.setString(1, searchTerm);
                        stm.setString(2, searchTerm);
                        stm.setString(3, searchTerm);
                        stm.setString(4, "%" + keyword + "%");
                        break;
                }
            }

            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                count = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error counting search results: " + e.getMessage());
        }

        return count;
    }

    public boolean deleteRecruiter(int id) {
        if (connection == null) {
            System.err.println("Database connection is null");
            return false;
        }

        String updateSql = "UPDATE Recruiter SET status = 'inactive' WHERE recruiterID = ?";

        try (PreparedStatement updateStm = connection.prepareStatement(updateSql)) {
            updateStm.setInt(1, id);
            int rowsAffected = updateStm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error deleting recruiter: " + e.getMessage());
            return false;
        }
    }

    public Recruiter getRecruiterById(int id) {
        if (connection == null) {
            System.err.println("Database connection is null");
            return null;
        }

        String sql = "SELECT * FROM Recruiter WHERE recruiterID = ?";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, id);

            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Recruiter recruiter = new Recruiter();
                recruiter.setRecruiterID(rs.getInt("recruiterID"));
                // Trường username đã bị bỏ trong DB mới
                recruiter.setPassword_hash(rs.getString("password_hash"));
                recruiter.setFirst_name(rs.getString("first_name"));
                recruiter.setLast_name(rs.getString("last_name"));
                recruiter.setGender(rs.getBoolean("gender"));
                recruiter.setDob(rs.getDate("dob"));
                recruiter.setImage(rs.getString("image"));
                recruiter.setMoney(rs.getBigDecimal("money"));
                recruiter.setEmail_contact(rs.getString("email_contact"));
                recruiter.setPhone_contact(rs.getString("phone_contact"));
                recruiter.setStatus(rs.getString("status"));
                // Thêm trường statusChangedByAdminID
                Integer statusChangedByAdminID = rs.getInt("statusChangedByAdminID");
                if (rs.wasNull()) {
                    statusChangedByAdminID = null;
                }
                recruiter.setStatusChangedByAdminID(statusChangedByAdminID);

                return recruiter;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error getting recruiter by ID: " + e.getMessage());
        }

        return null;
    }

    public String getTierName(int recruiterID) {
        String sql = "SELECT AT.tierName AS TierName\n"
                + "FROM AccountTiers AS AT\n"
                + "JOIN UserTierSubscriptions AS UTS ON AT.tierID = UTS.tierID\n"
                + "WHERE UTS.recruiterID = ? AND AT.isActive = 1;";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, recruiterID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getString("TierName");
            }
        } catch (SQLException e) {
            System.err.println("Error calculating total spent: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public String getTierNameDescription(int recruiterID) {
        String sql = "SELECT AT.description AS Description\n"
                + "FROM AccountTiers AS AT\n"
                + "JOIN UserTierSubscriptions AS UTS ON AT.tierID = UTS.tierID\n"
                + "WHERE UTS.recruiterID = ? AND AT.isActive = 1;";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, recruiterID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getString("Description");
            }
        } catch (SQLException e) {
            System.err.println("Error calculating total spent: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public boolean isEmailOrPhoneExists(String email, String phone) {
        try (Connection con = DBContext.getConnection()) {
            String sql = "SELECT recruiterID FROM Recruiter WHERE email_contact = ? OR phone_contact = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, phone);
            ResultSet rs = ps.executeQuery();
            return rs.next(); // trả về true nếu có bản ghi
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    public boolean addRecruiter(Recruiter recruiter) {
    String sql = "INSERT INTO Recruiter (password_hash, first_name, last_name, gender, dob, image, money, email_contact, phone_contact, status, statusChangedByAdminID) "
               + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    try (Connection con = DBContext.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setString(1, recruiter.getPassword_hash());
        ps.setString(2, recruiter.getFirst_name());
        ps.setString(3, recruiter.getLast_name());
        ps.setBoolean(4, recruiter.isGender());
        ps.setDate(5, recruiter.getDob());
        ps.setString(6, recruiter.getImage());
        ps.setBigDecimal(7, recruiter.getMoney() == null ? BigDecimal.ZERO : recruiter.getMoney());
        ps.setString(8, recruiter.getEmail_contact());
        ps.setString(9, recruiter.getPhone_contact());
        ps.setString(10, recruiter.getStatus() == null ? "Active" : recruiter.getStatus());
        if (recruiter.getStatusChangedByAdminID() != null)
            ps.setInt(11, recruiter.getStatusChangedByAdminID());
        else
            ps.setNull(11, java.sql.Types.INTEGER);
        return ps.executeUpdate() > 0;
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}
public boolean registerRecruiter(Recruiter recruiter) throws SQLException, ClassNotFoundException {
    String sql = "INSERT INTO Recruiter (password_hash, first_name, last_name, gender, dob, image, money, email_contact, phone_contact, status, statusChangedByAdminID) "
               + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    try (Connection con = DBContext.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setString(1, recruiter.getPassword_hash());
        ps.setString(2, recruiter.getFirst_name());
        ps.setString(3, recruiter.getLast_name());
        ps.setBoolean(4, recruiter.isGender());
        ps.setDate(5, recruiter.getDob());
        ps.setString(6, recruiter.getImage());
        ps.setBigDecimal(7, recruiter.getMoney() == null ? BigDecimal.ZERO : recruiter.getMoney());
        ps.setString(8, recruiter.getEmail_contact());
        ps.setString(9, recruiter.getPhone_contact());
        ps.setString(10, recruiter.getStatus() == null ? "Active" : recruiter.getStatus());
        if (recruiter.getStatusChangedByAdminID() != null)
            ps.setInt(11, recruiter.getStatusChangedByAdminID());
        else
            ps.setNull(11, java.sql.Types.INTEGER);
        return ps.executeUpdate() > 0;
    }
}

    public ArrayList<Company> getCompanies(int recruiterID) {
        ArrayList<Company> list = new ArrayList<>();

        if (connection == null) {
            System.err.println("Database connection is null for CompanyDAO");
            return list;
        }
        String sql = "SELECT * FROM Company WHERE recruiterID = ?";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, recruiterID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Company company = new Company();
                company.setCompanyID(rs.getInt("companyID"));
                company.setCompany_name(rs.getString("company_name"));
                company.setTeam_number(rs.getInt("team_number"));
                company.setEstablished_on(rs.getString("established_on"));
                company.setLogo(rs.getString("logo"));
                company.setWebsite(rs.getString("website"));
                company.setDescribe(rs.getString("describe"));
                company.setLocation(rs.getString("location"));
                company.setRecruiterID(rs.getInt("recruiterID"));

                list.add(company);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error getting paginated companies: " + e.getMessage());
        }
        return list;
    }
}
