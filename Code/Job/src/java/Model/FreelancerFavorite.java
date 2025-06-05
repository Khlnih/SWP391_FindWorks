package Model;

import java.util.Date;


public class FreelancerFavorite {
    private int favoritesID;
    private int freelancerID;
    private int postID;
    private Date favoritedDate;
    
    private Post post; 
    private String freelancerName; 

    public FreelancerFavorite() {
    }

    public FreelancerFavorite(int freelancerID, int postID) {
        this.freelancerID = freelancerID;
        this.postID = postID;
        this.favoritedDate = new Date();
    }

    public FreelancerFavorite(int favoritesID, int freelancerID, int postID, Date favoritedDate) {
        this.favoritesID = favoritesID;
        this.freelancerID = freelancerID;
        this.postID = postID;
        this.favoritedDate = favoritedDate;
    }

    public int getFavoritesID() {
        return favoritesID;
    }

    public void setFavoritesID(int favoritesID) {
        this.favoritesID = favoritesID;
    }

    public int getFreelancerID() {
        return freelancerID;
    }

    public void setFreelancerID(int freelancerID) {
        this.freelancerID = freelancerID;
    }

    public int getPostID() {
        return postID;
    }

    public void setPostID(int postID) {
        this.postID = postID;
    }

    public Date getFavoritedDate() {
        return favoritedDate;
    }

    public void setFavoritedDate(Date favoritedDate) {
        this.favoritedDate = favoritedDate;
    }

    public Post getPost() {
        return post;
    }

    public void setPost(Post post) {
        this.post = post;
    }

    public String getFreelancerName() {
        return freelancerName;
    }

    public void setFreelancerName(String freelancerName) {
        this.freelancerName = freelancerName;
    }

    @Override
    public String toString() {
        return "FreelancerFavorite{" +
                "favoritesID=" + favoritesID +
                ", freelancerID=" + freelancerID +
                ", postID=" + postID +
                ", favoritedDate=" + favoritedDate +
                '}';
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        
        FreelancerFavorite that = (FreelancerFavorite) obj;
        return freelancerID == that.freelancerID && postID == that.postID;
    }

    @Override
    public int hashCode() {
        return freelancerID * 31 + postID;
    }
}
