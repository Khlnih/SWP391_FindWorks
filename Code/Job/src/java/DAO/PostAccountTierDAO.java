package DAO;

import Model.PostAccountTier;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostAccountTierDAO extends DBContext {
    
    // Lấy thông tin gói đăng ký của bài đăng
    public PostAccountTier getPostTier(int postId, int tierId) {
        String sql = "SELECT * FROM PostAccountTier WHERE postID = ?  AND tierID = ? AND isActive = 1";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, postId);
            ps.setInt(2, tierId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                PostAccountTier tier = new PostAccountTier();
                tier.setPostAccountTierID(rs.getInt("postAccountTierID"));
                tier.setPostID(rs.getInt("postID"));
                tier.setTierID(rs.getInt("tierID"));
                tier.setPurchaseDate(rs.getDate("purchaseDate"));
                tier.setExpirationDate(rs.getDate("expirationDate"));
                tier.setIsActive(rs.getBoolean("isActive"));
                return tier;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
   public List<PostAccountTier> getAllPostTierActive() {
    List<PostAccountTier> list = new ArrayList<>();
    String sql = "SELECT * FROM PostAccountTier WHERE isActive = 1";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            PostAccountTier tier = new PostAccountTier();
            tier.setPostAccountTierID(rs.getInt("postAccountTierID"));
            tier.setPostID(rs.getInt("postID"));
            tier.setTierID(rs.getInt("tierID"));
            tier.setPurchaseDate(rs.getDate("purchaseDate"));
            tier.setExpirationDate(rs.getDate("expirationDate"));
            tier.setIsActive(rs.getBoolean("isActive"));
            list.add(tier);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}

    
    // Thêm mới gói đăng ký cho bài đăng
    public boolean addPostTier(int postId, int tierId, int expireDate) {
        String sql = "INSERT INTO PostAccountTier (postID, tierID, expirationDate) "
                   + "VALUES (?,?,DATEADD(DAY, ?, GETDATE()))";
        
        try {
           
            
            // Thêm gói mới
            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setInt(1, postId);
                ps.setInt(2, tierId);
                ps.setInt(3, expireDate);
                
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    
    public boolean extendExpiration(int postID, int extraDays) {
    String sql = "UPDATE PostAccountTier " +
                 "SET expirationDate = DATEADD(DAY, ?, expirationDate) " +
                 "WHERE postID = ? AND isActive = 1 AND expirationDate >= GETDATE()";

    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, extraDays); // số ngày gia hạn
        ps.setInt(2, postID);    // postID cụ thể

        return ps.executeUpdate() > 0; // true nếu có dòng được cập nhật
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return false;
}
}
