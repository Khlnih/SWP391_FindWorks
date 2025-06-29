package DAO;

import Model.Category;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    // Các phương thức không phân trang của bạn đã đúng, giữ nguyên
    public List<Category> getAllActiveCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT categoryID, category_name, category_img, description, isActive "
                + "FROM Categories WHERE isActive = 1 ORDER BY category_name";

        try (Connection conn = DBContext.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql); 
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Category category = new Category();
                category.setCategoryID(rs.getInt("categoryID"));
                category.setCategoryName(rs.getString("category_name"));
                category.setCategoryImg(rs.getString("category_img"));
                category.setDescription(rs.getString("description"));
                category.setStatus(rs.getBoolean("isActive"));
                categories.add(category);
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error getting active categories: " + e.getMessage());
            e.printStackTrace();
        }
        return categories;
    }

    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT categoryID, category_name, category_img, description, isActive "
                + "FROM Categories ORDER BY category_name";

        try (Connection conn = DBContext.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql); 
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Category category = new Category();
                category.setCategoryID(rs.getInt("categoryID"));
                category.setCategoryName(rs.getString("category_name"));
                category.setCategoryImg(rs.getString("category_img"));
                category.setDescription(rs.getString("description"));
                category.setStatus(rs.getBoolean("isActive"));
                categories.add(category);
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error getting all categories: " + e.getMessage());
            e.printStackTrace();
        }
        return categories;
    }

    public Category getCategoryById(int categoryID) {
        String sql = "SELECT categoryID, category_name, category_img, description, isActive "
                + "FROM Categories WHERE categoryID = ?";

        try (Connection conn = DBContext.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, categoryID);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Category category = new Category();
                    category.setCategoryID(rs.getInt("categoryID"));
                    category.setCategoryName(rs.getString("category_name"));
                    category.setCategoryImg(rs.getString("category_img"));
                    category.setDescription(rs.getString("description"));
                    category.setStatus(rs.getBoolean("isActive"));
                    return category;
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error getting category by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public boolean createCategory(Category category) {
        String sql = "INSERT INTO Categories (category_name, category_img, description, isActive) "
                + "VALUES (?, ?, ?, ?)";

        try (Connection conn = DBContext.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, category.getCategoryName());
            ps.setString(2, category.getCategoryImg());
            ps.setString(3, category.getDescription());
            ps.setBoolean(4, category.isStatus());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error creating category: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateCategory(Category category) {
        String sql = "UPDATE Categories SET category_name = ?, category_img = ?, "
                + "description = ?, isActive = ? WHERE categoryID = ?";

        try (Connection conn = DBContext.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, category.getCategoryName());
            ps.setString(2, category.getCategoryImg());
            ps.setString(3, category.getDescription());
            ps.setBoolean(4, category.isStatus());
            ps.setInt(5, category.getCategoryID());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error updating category: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteCategory(int categoryID) {
        String sql = "UPDATE Categories SET isActive = 0 WHERE categoryID = ?";

        try (Connection conn = DBContext.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, categoryID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error deleting category: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean hardDeleteCategory(int categoryID) {
        String sql = "DELETE FROM Categories WHERE categoryID = ?";
        try (Connection conn = DBContext.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, categoryID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error hard deleting category (ID: " + categoryID + "): " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Cannot delete category due to database constraint.", e);
        } catch (ClassNotFoundException e) {
            System.err.println("Database driver not found: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public int getTotalCategories() {
        String sql = "SELECT COUNT(*) FROM Categories";
        try (Connection conn = DBContext.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql); 
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error getting total categories: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }
    
    // ----- PHẦN SỬA LỖI BẮT ĐẦU TỪ ĐÂY -----

    /**
     * SỬA LỖI: Phương thức này đã được sửa để dùng cú pháp của SQL Server.
     * Lấy danh sách danh mục có phân trang.
     * @param offset Vị trí bắt đầu lấy.
     * @param limit Số lượng bản ghi cần lấy.
     * @return Danh sách danh mục.
     */
    public List<Category> getAllCategories(int offset, int limit) {
        List<Category> categories = new ArrayList<>();
        // SỬA LỖI 1: Thay đổi cú pháp SQL từ LIMIT/OFFSET sang OFFSET/FETCH
        String sql = "SELECT categoryID, category_name, category_img, description, isActive "
                + "FROM Categories "
                + "ORDER BY category_name " // Mệnh đề ORDER BY là bắt buộc cho phân trang trong SQL Server
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        try (Connection conn = DBContext.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            // SỬA LỖI 2: Đảo ngược thứ tự tham số: offset trước, limit sau
            ps.setInt(1, offset);
            ps.setInt(2, limit);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Category category = new Category();
                    category.setCategoryID(rs.getInt("categoryID"));
                    category.setCategoryName(rs.getString("category_name"));
                    category.setCategoryImg(rs.getString("category_img"));
                    category.setDescription(rs.getString("description"));
                    category.setStatus(rs.getBoolean("isActive"));
                    categories.add(category);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error getting paginated categories: " + e.getMessage());
            e.printStackTrace();
        }
        return categories;
    }
     
    /**
     * Phương thức này đã đúng, không cần sửa. Nó đếm số lượng bản ghi khớp với từ khóa.
     * @param keyword Từ khóa tìm kiếm.
     * @return Tổng số danh mục tìm thấy.
     */
    public int countCategories(String keyword) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Categories");
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" WHERE category_name LIKE ? OR description LIKE ?");
        }

        try (Connection conn = DBContext.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            if (keyword != null && !keyword.trim().isEmpty()) {
                String searchKeyword = "%" + keyword.trim() + "%";
                ps.setString(1, searchKeyword);
                ps.setString(2, searchKeyword);
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error counting categories: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * SỬA LỖI: Phương thức này đã được sửa để dùng cú pháp của SQL Server.
     * Tìm kiếm và phân trang danh sách danh mục.
     * @param keyword Từ khóa tìm kiếm.
     * @param offset Vị trí bắt đầu lấy.
     * @param limit Số lượng bản ghi cần lấy.
     * @return Danh sách danh mục đã được lọc và phân trang.
     */
    public List<Category> searchAndPaginateCategories(String keyword, int offset, int limit) {
        List<Category> categories = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT categoryID, category_name, category_img, description, isActive FROM Categories");
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" WHERE category_name LIKE ? OR description LIKE ?");
        }
        
        // SỬA LỖI 1: Thay đổi cú pháp SQL từ LIMIT/OFFSET sang OFFSET/FETCH
        sql.append(" ORDER BY category_name OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (Connection conn = DBContext.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            int paramIndex = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                String searchKeyword = "%" + keyword.trim() + "%";
                ps.setString(paramIndex++, searchKeyword);
                ps.setString(paramIndex++, searchKeyword);
            }
            
            // SỬA LỖI 2: Đảo ngược thứ tự tham số: offset trước, limit sau
            ps.setInt(paramIndex++, offset);
            ps.setInt(paramIndex, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Category category = new Category();
                    category.setCategoryID(rs.getInt("categoryID"));
                    category.setCategoryName(rs.getString("category_name"));
                    category.setCategoryImg(rs.getString("category_img"));
                    category.setDescription(rs.getString("description"));
                    category.setStatus(rs.getBoolean("isActive"));
                    categories.add(category);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error getting paginated/searched categories: " + e.getMessage());
            e.printStackTrace();
        }
        return categories;
    }
}