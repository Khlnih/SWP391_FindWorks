package DAO;

import Model.Category;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    public List<Category> getAllActiveCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT categoryID, category_name, category_img, description, isActive "
                + "FROM Categories WHERE isActive = 1 ORDER BY category_name";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

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

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

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

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

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

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

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

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

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

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, categoryID);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error deleting category: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    // Thêm phương thức này vào class CategoryDAO

    /**
     * Xóa vĩnh viễn một danh mục khỏi cơ sở dữ liệu. Cảnh báo: Hành động này
     * không thể hoàn tác.
     *
     * @param categoryID ID của danh mục cần xóa.
     * @return true nếu xóa thành công, false nếu thất bại.
     */
    public boolean hardDeleteCategory(int categoryID) {
        // Câu lệnh SQL để xóa một bản ghi
        String sql = "DELETE FROM Categories WHERE categoryID = ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, categoryID);

            // executeUpdate() trả về số dòng bị ảnh hưởng
            int rowsAffected = ps.executeUpdate();

            // Nếu có ít nhất một dòng bị ảnh hưởng, tức là xóa thành công
            return rowsAffected > 0;

        } catch (SQLException e) {
            // In ra lỗi SQL cụ thể, rất hữu ích khi gỡ lỗi, đặc biệt là lỗi khóa ngoại
            System.err.println("Error hard deleting category (ID: " + categoryID + "): " + e.getMessage());
            e.printStackTrace();
            // Ném lại ngoại lệ để lớp Controller có thể bắt và xử lý
            throw new RuntimeException("Cannot delete category due to database constraint.", e);
        } catch (ClassNotFoundException e) {
            System.err.println("Database driver not found: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Lấy tổng số danh mục trong cơ sở dữ liệu.
     *
     * @return Tổng số danh mục.
     */
    public int getTotalCategories() {
        String sql = "SELECT COUNT(*) FROM Categories";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error getting total categories: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Lấy danh sách danh mục theo phân trang.
     *
     * @param offset Vị trí bắt đầu.
     * @param limit Số lượng bản ghi mỗi trang.
     * @return Danh sách danh mục.
     */
    public List<Category> getAllCategories(int offset, int limit) {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT categoryID, category_name, category_img, description, isActive "
                + "FROM Categories ORDER BY category_name LIMIT ? OFFSET ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ps.setInt(2, offset);
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

}
