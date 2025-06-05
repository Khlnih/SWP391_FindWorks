package DAO;

import Model.FreelancerFavorite;
import Model.Post;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FreelancerFavoriteDAO {
    
   
    public boolean addFavorite(int freelancerID, int postID) {
        String sql = "INSERT INTO FreelancerFavorites (freelancerID, postID, favoritedDate) VALUES (?, ?, GETDATE())";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, freelancerID);
            ps.setInt(2, postID);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error adding favorite: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean removeFavorite(int freelancerID, int postID) {
        String sql = "DELETE FROM FreelancerFavorites WHERE freelancerID = ? AND postID = ?";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, freelancerID);
            ps.setInt(2, postID);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error removing favorite: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    
    public boolean isFavorite(int freelancerID, int postID) {
        String sql = "SELECT COUNT(*) FROM FreelancerFavorites WHERE freelancerID = ? AND postID = ?";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, freelancerID);
            ps.setInt(2, postID);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error checking favorite: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    
    public List<FreelancerFavorite> getFavoritesByFreelancer(int freelancerID) {
        List<FreelancerFavorite> favorites = new ArrayList<>();
        String sql = "SELECT ff.favoritesID, ff.freelancerID, ff.postID, ff.favoritedDate, " +
                    "p.title, p.image, p.jobTypeID, p.durationID, p.expired_date, p.quantity, " +
                    "p.description, p.budget_min, p.budget_max, p.budget_type, p.location, " +
                    "p.recruiterID, p.date_post, p.statusPost, p.categoryID " +
                    "FROM FreelancerFavorites ff " +
                    "INNER JOIN Post p ON ff.postID = p.postID " +
                    "WHERE ff.freelancerID = ? AND p.statusPost = 'Approved' " +
                    "ORDER BY ff.favoritedDate DESC";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, freelancerID);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    FreelancerFavorite favorite = new FreelancerFavorite();
                    favorite.setFavoritesID(rs.getInt("favoritesID"));
                    favorite.setFreelancerID(rs.getInt("freelancerID"));
                    favorite.setPostID(rs.getInt("postID"));
                    favorite.setFavoritedDate(rs.getTimestamp("favoritedDate"));
                    
                    Post post = new Post();
                    post.setPostId(rs.getInt("postID"));
                    post.setTitle(rs.getString("title"));
                    post.setImage(rs.getString("image"));
                    post.setJobTypeId(rs.getInt("jobTypeID"));
                    post.setDurationId(rs.getInt("durationID"));
                    post.setExpiredDate(rs.getDate("expired_date"));
                    post.setQuantity(rs.getInt("quantity"));
                    post.setDescription(rs.getString("description"));
                    post.setBudgetMin(rs.getBigDecimal("budget_min"));
                    post.setBudgetMax(rs.getBigDecimal("budget_max"));
                    post.setBudgetType(rs.getString("budget_type"));
                    post.setLocation(rs.getString("location"));
                    post.setRecruiterId(rs.getInt("recruiterID"));
                    post.setDatePost(rs.getTimestamp("date_post"));
                    post.setStatusPost(rs.getString("statusPost"));
                    post.setCategoryId(rs.getInt("categoryID"));
                    
                    favorite.setPost(post);
                    favorites.add(favorite);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error getting favorites by freelancer: " + e.getMessage());
            e.printStackTrace();
        }
        
        return favorites;
    }
    
    
    public int getFavoriteCount(int freelancerID) {
        String sql = "SELECT COUNT(*) FROM FreelancerFavorites ff " +
                    "INNER JOIN Post p ON ff.postID = p.postID " +
                    "WHERE ff.freelancerID = ? AND p.statusPost = 'Approved'";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, freelancerID);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error getting favorite count: " + e.getMessage());
            e.printStackTrace();
        }
        
        return 0;
    }
    
    
    public List<Integer> getFavoritePostIds(int freelancerID) {
        List<Integer> postIds = new ArrayList<>();
        String sql = "SELECT postID FROM FreelancerFavorites WHERE freelancerID = ?";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, freelancerID);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    postIds.add(rs.getInt("postID"));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error getting favorite post IDs: " + e.getMessage());
            e.printStackTrace();
        }
        
        return postIds;
    }
    
    public boolean removeAllFavoritesByFreelancer(int freelancerID) {
        String sql = "DELETE FROM FreelancerFavorites WHERE freelancerID = ?";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, freelancerID);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected >= 0; // >= 0 vì có thể không có favorites nào
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error removing all favorites: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    
    public boolean removeAllFavoritesByPost(int postID) {
        String sql = "DELETE FROM FreelancerFavorites WHERE postID = ?";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, postID);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected >= 0;
            
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error removing favorites by post: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
