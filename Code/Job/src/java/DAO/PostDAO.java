package DAO;

import Model.Post;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class PostDAO extends DBContext{

    // Phương thức ánh xạ ResultSet sang đối tượng Post
    private Post mapResultSetToPost(ResultSet rs) throws SQLException {
        Post post = new Post();
        post.setPostId(rs.getInt("postID"));
        post.setTitle(rs.getString("title"));
        post.setImage(rs.getString("image"));
        post.setJobTypeId(rs.getInt("jobTypeID"));
        post.setDurationId(rs.getInt("durationID"));
        post.setDatePost(rs.getTimestamp("date_post"));
        post.setExpiredDate(rs.getTimestamp("expired_date"));
        post.setQuantity(rs.getInt("quantity"));
        post.setDescription(rs.getString("description"));
        post.setBudgetMin(rs.getBigDecimal("budget_min"));
        post.setBudgetMax(rs.getBigDecimal("budget_max"));
        post.setBudgetType(rs.getString("budget_type"));
        post.setLocation(rs.getString("location"));
        post.setRecruiterId(rs.getInt("recruiterID"));
        post.setStatusPost(rs.getString("statusPost"));
        post.setCategoryId(rs.getInt("categoryID"));

        // Xử lý giá trị có thể null
        if (rs.getObject("approvedByAdminID") != null) {
            post.setApprovedByAdminID(rs.getInt("approvedByAdminID"));
        }

        return post;
    }
    
    // Phương thức tìm kiếm công việc theo nhiều tiêu chí
    public List<Post> searchPosts(String keyword, String location, String category, String skill) {
        List<Post> searchResults = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Post WHERE statusPost = 'Approved'");
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
            sql.append(" AND categoryID = ?");
            try {
                params.add(Integer.parseInt(category));
            } catch (NumberFormatException e) {
                // Nếu category không phải số, bỏ qua điều kiện này
                sql.setLength(sql.length() - 18); // Xóa điều kiện vừa thêm
            }
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

    // Tạo bài đăng mới
   public boolean createPost(Post post) {
        String sql = "INSERT INTO Post ("
                + "title, jobTypeID, durationID, date_post, expired_date, quantity, "
                + "budget_min, budget_max, location, categoryID, budget_type, description, "
                + "recruiterID"
                + ") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            int paramIndex = 1;
            ps.setString(paramIndex++, post.getTitle());
            ps.setInt(paramIndex++, post.getJobTypeId());
            ps.setInt(paramIndex++, post.getDurationId());

            // date_post - set to current time if null
            if (post.getDatePost() != null) {
                ps.setTimestamp(paramIndex++, new java.sql.Timestamp(post.getDatePost().getTime()));
            } else {
                ps.setTimestamp(paramIndex++, new java.sql.Timestamp(System.currentTimeMillis()));
            }

            // expired_date
            if (post.getExpiredDate() != null) {
                ps.setTimestamp(paramIndex++, new java.sql.Timestamp(post.getExpiredDate().getTime()));
            } else {
                throw new SQLException("Expired date is required");
            }

            ps.setInt(paramIndex++, post.getQuantity());
            ps.setBigDecimal(paramIndex++, post.getBudgetMin());
            ps.setBigDecimal(paramIndex++, post.getBudgetMax());
            ps.setString(paramIndex++, post.getLocation());
            ps.setInt(paramIndex++, post.getCategoryId());
            ps.setString(paramIndex++, post.getBudgetType());
            ps.setString(paramIndex++, post.getDescription());
            ps.setInt(paramIndex++, post.getRecruiterId());

            int rowsAffected = ps.executeUpdate();

            // Get the generated post ID
            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        post.setPostId(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
            return false;

        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error creating post: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }


    // Lấy bài đăng theo ID
    public Post getPostById(int postId) {
        String sql = "SELECT * FROM Post WHERE postID = ?";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, postId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToPost(rs);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error getting post by ID: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    // Lấy tất cả bài đăng của một recruiter
    public List<Post> getPostsByRecruiterId(int recruiterId) {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT * FROM Post WHERE recruiterID = ? ORDER BY date_post DESC";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, recruiterId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Post post = mapResultSetToPost(rs);
                    posts.add(post);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error getting posts by recruiter ID: " + e.getMessage());
            e.printStackTrace();
        }

        return posts;
    }
    
    public List<Post> getPostsActiveByRecruiterId(int recruiterId) {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT * FROM Post WHERE recruiterID = ? AND statusPost='Approved' ORDER BY date_post DESC";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, recruiterId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Post post = mapResultSetToPost(rs);
                    posts.add(post);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error getting posts by recruiter ID: " + e.getMessage());
            e.printStackTrace();
        }

        return posts;
    }
    
    public boolean updateStatus(int postId, String statusPost) {
        String sql = "UPDATE Post SET statusPost = ? WHERE postID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, statusPost);
            ps.setInt(2, postId);
            int affected = ps.executeUpdate();
            return affected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    
    public List<Post> getAllPostsExceptApproved() {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT * FROM Post WHERE statusPost = 'Pending' ORDER BY date_post DESC";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Post post = mapResultSetToPost(rs);
                posts.add(post);
            }

        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error getting posts: " + e.getMessage());
            e.printStackTrace();
        }

        return posts;
    }
    public boolean updatePost(Post post) {
        String sql = "UPDATE Post SET title = ?, image = ?, jobTypeID = ?, durationID = ?, " +
                    "expired_date = ?, quantity = ?, description = ?, budget_min = ?, " +
                    "budget_max = ?, budget_type = ?, location = ?, statusPost = ?, " +
                    "categoryID = ? WHERE postID = ? AND recruiterID = ?";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, post.getTitle());
            ps.setString(2, post.getImage());
            ps.setInt(3, post.getJobTypeId());
            ps.setInt(4, post.getDurationId());
            ps.setTimestamp(5, post.getExpiredDate() != null ?
                new java.sql.Timestamp(post.getExpiredDate().getTime()) : null);
            ps.setInt(6, post.getQuantity());
            ps.setString(7, post.getDescription());
            ps.setBigDecimal(8, post.getBudgetMin());
            ps.setBigDecimal(9, post.getBudgetMax());
            ps.setString(10, post.getBudgetType());
            ps.setString(11, post.getLocation());
            ps.setString(12, post.getStatusPost());
            ps.setInt(13, post.getCategoryId());
            ps.setInt(14, post.getPostId());
            ps.setInt(15, post.getRecruiterId());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error updating post: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Xóa bài đăng (soft delete - chuyển status thành 'Closed')
    public boolean deletePost(int postId, int recruiterId) {
        String sql = "UPDATE Post SET statusPost = 'Closed' WHERE postID = ? AND recruiterID = ?";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, postId);
            ps.setInt(2, recruiterId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error deleting post: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Xóa bài đăng vĩnh viễn (hard delete)
    public boolean hardDeletePost(int postId, int recruiterId) {
        String sql = "DELETE FROM Post WHERE postID = ? AND recruiterID = ?";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, postId);
            ps.setInt(2, recruiterId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error hard deleting post: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Lấy tất cả bài đăng đã được approve (cho public job listing)
    public List<Post> getAllApprovedPosts() {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT * FROM Post WHERE statusPost = 'Approved' ORDER BY date_post DESC";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Post post = mapResultSetToPost(rs);
                posts.add(post);
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error getting all approved posts: " + e.getMessage());
            e.printStackTrace();
        }

        return posts;
    }

    // Lấy số lượng bài đăng đã approve
    public int getApprovedPostCount() {
        String sql = "SELECT COUNT(*) FROM Post WHERE statusPost = 'Approved'";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error getting approved post count: " + e.getMessage());
            e.printStackTrace();
        }

        return 0;
    }
    
    private List<Post> getPostsByStatus(int recruiterId, String status) {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT * FROM Post WHERE recruiterID = ? AND statusPost = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, recruiterId);
            ps.setString(2, status);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Post post = new Post();
                    post.setPostId(rs.getInt("postID"));
                    post.setTitle(rs.getString("title"));
                    post.setImage(rs.getString("image"));
                    post.setJobTypeId(rs.getInt("jobTypeID"));
                    post.setDurationId(rs.getInt("durationID"));
                    post.setDatePost(rs.getTimestamp("date_post"));
                    post.setExpiredDate(rs.getTimestamp("expired_date"));
                    post.setQuantity(rs.getInt("quantity"));
                    post.setDescription(rs.getString("description"));
                    post.setBudgetMin(rs.getBigDecimal("budget_min"));
                    post.setBudgetMax(rs.getBigDecimal("budget_max"));
                    post.setBudgetType(rs.getString("budget_type"));
                    post.setLocation(rs.getString("location"));
                    post.setRecruiterId(rs.getInt("recruiterID"));
                    post.setStatusPost(rs.getString("statusPost"));
                    post.setCategoryId(rs.getInt("categoryID"));
                    int adminID = rs.getInt("approvedByAdminID");
                    post.setApprovedByAdminID(rs.wasNull() ? null : adminID);
                    posts.add(post);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    public List<Post> getApprovedPosts(int recruiterId) {
        return getPostsByStatus(recruiterId, "Approved");
    }

    public List<Post> getRejectedPosts(int recruiterId) {
        return getPostsByStatus(recruiterId, "Rejected");
    }

    public List<Post> getPendingPosts(int recruiterId) {
        return getPostsByStatus(recruiterId, "Pending");
    }

    public List<Post> getDraftPosts(int recruiterId) {
        return getPostsByStatus(recruiterId, "Draft");
    }
    
    
    public List<Post> getPostWithApplicationCountsByRecruiter(int recruiterID) {
    List<Post> results = new ArrayList<>();
    String sql = """
        SELECT p.postID, p.title, COUNT(j.applyID) AS countApplications
        FROM Post p
        LEFT JOIN JobApply j ON p.postID = j.postID
        WHERE p.recruiterID = ? AND p.statusPost = 'Approved'
        GROUP BY p.postID, p.title
        ORDER BY p.postID
        """;
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, recruiterID);
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Post pac = new Post();
                pac.setPostId(rs.getInt("postID"));
                pac.setTitle(rs.getString("title"));
                pac.setJobTypeId(rs.getInt("countApplications"));
                results.add(pac);
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return results;
}
}