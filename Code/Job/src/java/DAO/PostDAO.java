package DAO;

import Model.Post;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PostDAO {
    
    // Phương thức ánh xạ ResultSet sang đối tượng Post
    private Post mapResultSetToPost(ResultSet rs) throws SQLException {
        Post post = new Post();
        post.setPostId(rs.getInt("postID"));
        post.setTitle(rs.getString("title"));
        post.setImage(rs.getString("image"));
        post.setJobTypeId(rs.getInt("job_type_ID"));
        post.setDurationId(rs.getInt("durationID"));
        post.setDatePost(rs.getDate("date_post"));
        post.setExpired(rs.getDate("expired"));
        post.setQuantity(rs.getInt("quantity"));
        post.setDescription(rs.getString("description"));
        post.setLocation(rs.getString("location"));
        post.setSkill(rs.getString("skill"));
        post.setRecruiterId(rs.getInt("recruiterID"));
        post.setCaId(rs.getInt("caID"));
        
        // Xử lý các giá trị có thể null
        if (rs.getObject("budget") != null) {
            post.setBudget(rs.getInt("budget"));
        }
        
        if (rs.getObject("status") != null) {
            post.setStatus(rs.getInt("status"));
        }
        
        if (rs.getObject("checking") != null) {
            post.setChecking(rs.getInt("checking"));
        }
        
        return post;
    }
    
    // Phương thức tìm kiếm công việc theo nhiều tiêu chí
    public List<Post> searchPosts(String keyword, String location, String category, String skill) {
        List<Post> searchResults = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM post WHERE status = 1 AND checking = 1");
        List<Object> params = new ArrayList<>();
        
        // Thêm điều kiện tìm kiếm theo từ khóa (tìm trong tiêu đề và mô tả)
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (title LIKE ? OR description LIKE ?)");
            params.add("%" + keyword.trim() + "%");
            params.add("%" + keyword.trim() + "%");
        }
        
        // Thêm điều kiện tìm kiếm theo địa điểm
        if (location != null && !location.trim().isEmpty()) {
            sql.append(" AND location LIKE ?");
            params.add("%" + location.trim() + "%");
        }
        
        // Thêm điều kiện tìm kiếm theo danh mục
        if (category != null && !category.trim().isEmpty()) {
            sql.append(" AND caID = ?");
            try {
                params.add(Integer.parseInt(category));
            } catch (NumberFormatException e) {
                // Nếu category không phải số, bỏ qua điều kiện này
                sql.setLength(sql.length() - 11); // Xóa điều kiện vừa thêm
            }
        }
        
        // Thêm điều kiện tìm kiếm theo kỹ năng
        if (skill != null && !skill.trim().isEmpty()) {
            sql.append(" AND skill LIKE ?");
            params.add("%" + skill.trim() + "%");
        }
        
        // Sắp xếp kết quả theo ngày đăng gần nhất
        sql.append(" ORDER BY date_post DESC");
        
        DBContext db = new DBContext();
        try (Connection conn = db.connection;
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            // Thiết lập các tham số
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Post post = mapResultSetToPost(rs);
                    searchResults.add(post);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error searching posts: " + e.getMessage());
            e.printStackTrace();
        }
        
        return searchResults;
    }
    
    public List<Post> getAllPosts() {
        List<Post> posts = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            String sql = "SELECT * FROM Post";
            System.out.println("PostDAO: Truy vấn - " + sql);
            
            con = DBContext.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Post post = mapResultSetToPost(rs);
                posts.add(post);
            }
            
            System.out.println("PostDAO: Đã tìm thấy " + posts.size() + " bài đăng");
            
        } catch (SQLException e) {
            System.err.println("PostDAO - Lỗi SQL: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("PostDAO - Lỗi: " + e.getMessage());
            e.printStackTrace();
        } finally {
            // Đóng tài nguyên
            if (rs != null) try { rs.close(); } catch (SQLException e) { /* Bỏ qua */ }
            if (ps != null) try { ps.close(); } catch (SQLException e) { /* Bỏ qua */ }
            if (con != null) try { con.close(); } catch (SQLException e) { /* Bỏ qua */ }
        }
        
        return posts;
    }

}