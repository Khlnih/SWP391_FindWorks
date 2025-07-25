/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.Date;

/**
 *
 * @author ADMIN
 */
public class PostAccountTier {
    private int postAccountTierID;
    private int postID;
    private int tierID;
    private Date purchaseDate;     // NOT NULL, DEFAULT GETDATE()
    private Date expirationDate;   // NULL
    private boolean isActive;  

    public PostAccountTier() {
    }

    public PostAccountTier(int postAccountTierID, int postID, int tierID, Date purchaseDate, Date expirationDate, boolean isActive) {
        this.postAccountTierID = postAccountTierID;
        this.postID = postID;
        this.tierID = tierID;
        this.purchaseDate = purchaseDate;
        this.expirationDate = expirationDate;
        this.isActive = isActive;
    }

    public int getPostAccountTierID() {
        return postAccountTierID;
    }

    public void setPostAccountTierID(int postAccountTierID) {
        this.postAccountTierID = postAccountTierID;
    }

    public int getPostID() {
        return postID;
    }

    public void setPostID(int postID) {
        this.postID = postID;
    }

    public int getTierID() {
        return tierID;
    }

    public void setTierID(int tierID) {
        this.tierID = tierID;
    }

    public Date getPurchaseDate() {
        return purchaseDate;
    }

    public void setPurchaseDate(Date purchaseDate) {
        this.purchaseDate = purchaseDate;
    }

    public Date getExpirationDate() {
        return expirationDate;
    }

    public void setExpirationDate(Date expirationDate) {
        this.expirationDate = expirationDate;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }
    
    
}
