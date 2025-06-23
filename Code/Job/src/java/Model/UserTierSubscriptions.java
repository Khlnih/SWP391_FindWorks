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
public class UserTierSubscriptions {
    private int subscriptionID;
    private int recruiterID;      
    private int freelancerID;      
    private int tierID;
    private Date startDate;
    private Date endDate;             
    private int transactionID;    
    private int isActiveSubscription;

    public UserTierSubscriptions() {
    }

    public UserTierSubscriptions(int subscriptionID, int recruiterID, int freelancerID, int tierID, Date startDate, Date endDate, int transactionID, int isActiveSubscription) {
        this.subscriptionID = subscriptionID;
        this.recruiterID = recruiterID;
        this.freelancerID = freelancerID;
        this.tierID = tierID;
        this.startDate = startDate;
        this.endDate = endDate;
        this.transactionID = transactionID;
        this.isActiveSubscription = isActiveSubscription;
    }

    public int getSubscriptionID() {
        return subscriptionID;
    }

    public void setSubscriptionID(int subscriptionID) {
        this.subscriptionID = subscriptionID;
    }

    public int getRecruiterID() {
        return recruiterID;
    }

    public void setRecruiterID(int recruiterID) {
        this.recruiterID = recruiterID;
    }

    public int getFreelancerID() {
        return freelancerID;
    }

    public void setFreelancerID(int freelancerID) {
        this.freelancerID = freelancerID;
    }

    public int getTierID() {
        return tierID;
    }

    public void setTierID(int tierID) {
        this.tierID = tierID;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public int getTransactionID() {
        return transactionID;
    }

    public void setTransactionID(int transactionID) {
        this.transactionID = transactionID;
    }

    public int getIsActiveSubscription() {
        return isActiveSubscription;
    }

    public void setIsActiveSubscription(int isActiveSubscription) {
        this.isActiveSubscription = isActiveSubscription;
    }
    
    
}
