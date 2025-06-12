package DAO;

import DAO.DBContext; // Sửa lại nếu package của bạn khác
import Model.Freelancer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FreelancerListDAO extends DBContext {

    // Định nghĩa các cột để tránh lặp lại và dễ bảo trì
    private final String ALL_COLUMNS_WITH_ALIAS = 
            "[freelancerID] AS freelanceID, " + // <<< ĐẶT ALIAS Ở ĐÂY
            "[username], [password], [first_name], [last_name], [image], [gender], " +
            "[dob], [describe], [email_contact], [phone_contact], [status], [statusChangedByAdminID]";

    /**
     * Lấy tất cả các freelancer có trạng thái là 'Active'.
     */
    public List<Freelancer> getAllActiveFreelancers() {
        List<Freelancer> list = new ArrayList<>();
        // Sử dụng danh sách cột đã định nghĩa với alias
        String sql = "SELECT " + ALL_COLUMNS_WITH_ALIAS + " FROM [Freelancer] WHERE [status] = 'Active'"; 
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapResultSetToFreelancer(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Tìm kiếm freelancer đang hoạt động theo từ khóa trong tên và mô tả.
     */
    public List<Freelancer> searchFreelancers(String searchQuery) {
        List<Freelancer> list = new ArrayList<>();
        // Sử dụng danh sách cột đã định nghĩa với alias
        String sql = "SELECT " + ALL_COLUMNS_WITH_ALIAS + " FROM [Freelancer] "
                   + "WHERE [status] = 'Active' AND (([first_name] + ' ' + [last_name]) LIKE ? OR [describe] LIKE ?)";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String searchPattern = "%" + searchQuery + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToFreelancer(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    private Freelancer mapResultSetToFreelancer(ResultSet rs) throws SQLException {
        Freelancer f = new Freelancer();
        // Bây giờ, ta có thể dùng 'freelanceID' vì đã đặt alias trong câu lệnh SQL
        f.setFreelanceID(rs.getInt("freelanceID")); // <<< ĐÃ KHỚP VỚI MODEL
        f.setUsername(rs.getString("username"));
        f.setPassword(rs.getString("password"));
        f.setFirstName(rs.getString("first_name"));
        f.setLastName(rs.getString("last_name"));
        f.setImage(rs.getString("image"));
        f.setGender(rs.getBoolean("gender"));
        f.setDob(rs.getString("dob"));
        f.setDescribe(rs.getString("describe"));
        f.setEmailContact(rs.getString("email_contact"));
        f.setPhoneContact(rs.getString("phone_contact"));
        f.setStatus(rs.getString("status"));
        f.setStatusChangedByAdminID((Integer) rs.getObject("statusChangedByAdminID"));
        return f;
    }
}