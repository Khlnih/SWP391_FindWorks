package DAO;

import Model.SkillSet;
import java.sql.*;
import java.util.ArrayList;
import java.util.List; // Import List cho các phương thức phân trang

public class SkillDAO {

    // Phương thức trợ giúp để ánh xạ một dòng từ ResultSet sang đối tượng SkillSet
    // Đảm bảo tên cột trong rs.getXXX("ten_cot_trong_db") khớp với CSDL
    private SkillSet mapResultSetToSkillSet(ResultSet rs) throws SQLException {
        return new SkillSet(
            rs.getInt("skill_set_ID"),      // Tên cột trong CSDL
            rs.getString("skill_set_name"), // Tên cột trong CSDL
            rs.getString("description"),    // Tên cột trong CSDL
            rs.getInt("statusSkill"),       // Tên cột trong CSDL
            rs.getInt("ExpertiID")          // Tên cột trong CSDL
        );
    }

    // Lấy tất cả các kỹ năng
    public ArrayList<SkillSet> getAllSkills() throws Exception {
        ArrayList<SkillSet> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        // SỬA TÊN BẢNG: SkillSet -> Skill_Set
        String sql = "SELECT * FROM Skill_Set ORDER BY skill_set_name";

        try {
            con = DBContext.getConnection(); // Lấy kết nối từ DBContext
            ps = con.prepareStatement(sql);  // Chuẩn bị câu lệnh SQL
            rs = ps.executeQuery();          // Thực thi câu lệnh và lấy kết quả

            while (rs.next()) { // Duyệt qua từng dòng kết quả
                list.add(mapResultSetToSkillSet(rs)); // Ánh xạ và thêm vào danh sách
            }
        } finally {
            // Đóng tài nguyên để tránh rò rỉ
            if (rs != null) try { rs.close(); } catch (SQLException e) { /* Bỏ qua lỗi khi đóng */ }
            if (ps != null) try { ps.close(); } catch (SQLException e) { /* Bỏ qua lỗi khi đóng */ }
            if (con != null) try { con.close(); } catch (SQLException e) { /* Bỏ qua lỗi khi đóng */ }
        }
        return list;
    }

    // Thêm một kỹ năng mới
    public boolean addSkill(SkillSet skill) throws Exception {
        Connection con = null;
        PreparedStatement ps = null;
        // SỬA TÊN BẢNG: SkillSet -> Skill_Set
        // Tên cột trong VALUES() phải khớp với tên cột trong CSDL và thứ tự của các dấu ?
        String sql = "INSERT INTO Skill_Set (skill_set_name, description, statusSkill, ExpertiID) VALUES (?, ?, ?, ?)";
        int affectedRows = 0; // Số dòng bị ảnh hưởng bởi câu lệnh INSERT

        try {
            con = DBContext.getConnection();
            ps = con.prepareStatement(sql);
            // Gán giá trị cho các tham số ?
            ps.setString(1, skill.getSkillSetName()); // Giá trị cho skill_set_name
            ps.setString(2, skill.getDescription());  // Giá trị cho description
            ps.setInt(3, skill.getStatusSkill());     // Giá trị cho statusSkill
            ps.setInt(4, skill.getExpertId());        // Giá trị cho ExpertiID

            affectedRows = ps.executeUpdate(); // Thực thi câu lệnh INSERT
        } finally {
            if (ps != null) try { ps.close(); } catch (SQLException e) { /* Bỏ qua */ }
            if (con != null) try { con.close(); } catch (SQLException e) { /* Bỏ qua */ }
        }
        return affectedRows > 0; // Trả về true nếu có ít nhất 1 dòng được thêm
    }

    // Lấy một kỹ năng theo ID
    public SkillSet getSkillById(int skillId) throws Exception {
        SkillSet skill = null; // Khởi tạo skill là null
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        // SỬA TÊN BẢNG: SkillSet -> Skill_Set
        String sql = "SELECT * FROM Skill_Set WHERE skill_set_ID = ?";

        try {
            con = DBContext.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, skillId); // Gán giá trị ID cho tham số ?
            rs = ps.executeQuery();

            if (rs.next()) { // Nếu tìm thấy kết quả
                skill = mapResultSetToSkillSet(rs); // Ánh xạ kết quả sang đối tượng SkillSet
            }
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { /* Bỏ qua */ }
            if (ps != null) try { ps.close(); } catch (SQLException e) { /* Bỏ qua */ }
            if (con != null) try { con.close(); } catch (SQLException e) { /* Bỏ qua */ }
        }
        return skill; // Trả về đối tượng skill (hoặc null nếu không tìm thấy)
    }

    // Cập nhật thông tin một kỹ năng
    public boolean updateSkill(SkillSet skill) throws Exception {
        Connection con = null;
        PreparedStatement ps = null;
        // SỬA TÊN BẢNG: SkillSet -> Skill_Set
        // Tên cột trong SET và WHERE PHẢI khớp với CSDL
        String sql = "UPDATE Skill_Set SET skill_set_name = ?, description = ?, statusSkill = ?, ExpertiID = ? WHERE skill_set_ID = ?";
        int affectedRows = 0;

        try {
            con = DBContext.getConnection();
            ps = con.prepareStatement(sql);
            // Gán giá trị cho các tham số ?
            ps.setString(1, skill.getSkillSetName());
            ps.setString(2, skill.getDescription());
            ps.setInt(3, skill.getStatusSkill());
            ps.setInt(4, skill.getExpertId());
            ps.setInt(5, skill.getSkillSetId()); // ID của skill cần cập nhật (cho mệnh đề WHERE)

            affectedRows = ps.executeUpdate(); // Thực thi câu lệnh UPDATE
        } finally {
            if (ps != null) try { ps.close(); } catch (SQLException e) { /* Bỏ qua */ }
            if (con != null) try { con.close(); } catch (SQLException e) { /* Bỏ qua */ }
        }
        return affectedRows > 0; // Trả về true nếu có ít nhất 1 dòng được cập nhật
    }

    // Xóa một kỹ năng theo ID
    public boolean deleteSkill(int skillId) throws Exception {
        Connection con = null;
        PreparedStatement ps = null;
        // SỬA TÊN BẢNG: SkillSet -> Skill_Set
        String sql = "DELETE FROM Skill_Set WHERE skill_set_ID = ?";
        int affectedRows = 0;

        try {
            con = DBContext.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, skillId); // Gán giá trị ID cho tham số ?
            affectedRows = ps.executeUpdate(); // Thực thi câu lệnh DELETE
        } finally {
            if (ps != null) try { ps.close(); } catch (SQLException e) { /* Bỏ qua */ }
            if (con != null) try { con.close(); } catch (SQLException e) { /* Bỏ qua */ }
        }
        return affectedRows > 0; // Trả về true nếu có ít nhất 1 dòng được xóa
    }

    // --- Các phương thức cần cho phân trang và tìm kiếm trên admin_skill.jsp ---

    // Đếm tổng số kỹ năng
    public int countTotalSkills() throws Exception {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        // SỬA TÊN BẢNG: SkillSet -> Skill_Set
        String sql = "SELECT COUNT(*) FROM Skill_Set";
        int count = 0; // Khởi tạo số lượng là 0
        try {
            con = DBContext.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1); // Lấy giá trị từ cột đầu tiên của kết quả (là COUNT(*))
            }
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { /* Bỏ qua */ }
            if (ps != null) try { ps.close(); } catch (SQLException e) { /* Bỏ qua */ }
            if (con != null) try { con.close(); } catch (SQLException e) { /* Bỏ qua */ }
        }
        return count;
    }

    // Lấy danh sách kỹ năng theo trang (cho phân trang)
    public List<SkillSet> getSkillsByPage(int currentPage, int pageSize) throws Exception {
        List<SkillSet> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        // SỬA TÊN BẢNG: SkillSet -> Skill_Set
        // ĐIỀU CHỈNH CÚ PHÁP SQL CHO PHÂN TRANG TRÊN SQL SERVER
        // Cú pháp cho SQL Server: ORDER BY ... OFFSET ... ROWS FETCH NEXT ... ROWS ONLY
        String sql = "SELECT * FROM Skill_Set ORDER BY skill_set_name OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        int offset = (currentPage - 1) * pageSize; // Tính toán vị trí bắt đầu lấy (bỏ qua bao nhiêu dòng)

        try {
            con = DBContext.getConnection();
            ps = con.prepareStatement(sql);
            // Gán giá trị cho các tham số của OFFSET và FETCH NEXT
            ps.setInt(1, offset);   // Số dòng cần bỏ qua (OFFSET)
            ps.setInt(2, pageSize); // Số dòng cần lấy (FETCH NEXT)
            rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapResultSetToSkillSet(rs));
            }
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { /* Bỏ qua */ }
            if (ps != null) try { ps.close(); } catch (SQLException e) { /* Bỏ qua */ }
            if (con != null) try { con.close(); } catch (SQLException e) { /* Bỏ qua */ }
        }
        return list;
    }

    // Đếm số lượng kỹ năng tìm thấy theo từ khóa (tìm theo tên kỹ năng)
    public int countSearchedSkills(String keyword) throws Exception {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        // SỬA TÊN BẢNG: SkillSet -> Skill_Set
        String sql = "SELECT COUNT(*) FROM Skill_Set WHERE skill_set_name LIKE ?";
        int count = 0;
        try {
            con = DBContext.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, "%" + keyword + "%"); // Tìm kiếm tên kỹ năng chứa từ khóa
            rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { /* Bỏ qua */ }
            if (ps != null) try { ps.close(); } catch (SQLException e) { /* Bỏ qua */ }
            if (con != null) try { con.close(); } catch (SQLException e) { /* Bỏ qua */ }
        }
        return count;
    }

    // Tìm kiếm kỹ năng theo từ khóa và phân trang
    public List<SkillSet> searchSkills(String keyword, int currentPage, int pageSize) throws Exception {
        List<SkillSet> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        // SỬA TÊN BẢNG: SkillSet -> Skill_Set
        // ĐIỀU CHỈNH CÚ PHÁP SQL CHO PHÂN TRANG VỚI TÌM KIẾM TRÊN SQL SERVER
        String sql = "SELECT * FROM Skill_Set WHERE skill_set_name LIKE ? ORDER BY skill_set_name OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        int offset = (currentPage - 1) * pageSize;

        try {
            con = DBContext.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, "%" + keyword + "%"); // Điều kiện tìm kiếm
            ps.setInt(2, offset);                  // Tham số cho OFFSET
            ps.setInt(3, pageSize);                // Tham số cho FETCH NEXT
            rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapResultSetToSkillSet(rs));
            }
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { /* Bỏ qua */ }
            if (ps != null) try { ps.close(); } catch (SQLException e) { /* Bỏ qua */ }
            if (con != null) try { con.close(); } catch (SQLException e) { /* Bỏ qua */ }
        }
        return list;
    }
}