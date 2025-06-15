/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author ADMIN
 */
public class FreelancerSubscription {
    private int freelancerID;
    private String username;
    private String first_name;
    private String last_name;
    private String email_contact;
    private String phone_contact;
    private int subscriptionID;
    private int tierID;
    private String startDate;
    private String endDate;
    private boolean isActiveSubscription;
    private String tierName;
    private double price;
    public FreelancerSubscription() {
    }

    public FreelancerSubscription(int freelancerID, String username, String first_name, String last_name, String email_contact, String phone_contact, int subscriptionID, int tierID, String startDate, String endDate, boolean isActiveSubscription, String tierName, double price) {
        this.freelancerID = freelancerID;
        this.username = username;
        this.first_name = first_name;
        this.last_name = last_name;
        this.email_contact = email_contact;
        this.phone_contact = phone_contact;
        this.subscriptionID = subscriptionID;
        this.tierID = tierID;
        this.startDate = startDate;
        this.endDate = endDate;
        this.isActiveSubscription = isActiveSubscription;
        this.tierName = tierName;
        this.price = price;
    }

    public int getFreelancerID() {
        return freelancerID;
    }

    public void setFreelancerID(int freelancerID) {
        this.freelancerID = freelancerID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFirst_name() {
        return first_name;
    }

    public void setFirst_name(String first_name) {
        this.first_name = first_name;
    }

    public String getLast_name() {
        return last_name;
    }

    public void setLast_name(String last_name) {
        this.last_name = last_name;
    }

    public String getEmail_contact() {
        return email_contact;
    }

    public void setEmail_contact(String email_contact) {
        this.email_contact = email_contact;
    }

    public String getPhone_contact() {
        return phone_contact;
    }

    public void setPhone_contact(String phone_contact) {
        this.phone_contact = phone_contact;
    }

    public int getSubscriptionID() {
        return subscriptionID;
    }

    public void setSubscriptionID(int subscriptionID) {
        this.subscriptionID = subscriptionID;
    }

    public int getTierID() {
        return tierID;
    }

    public void setTierID(int tierID) {
        this.tierID = tierID;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public boolean isIsActiveSubscription() {
        return isActiveSubscription;
    }

    public void setIsActiveSubscription(boolean isActiveSubscription) {
        this.isActiveSubscription = isActiveSubscription;
    }

    public String getTierName() {
        return tierName;
    }

    public void setTierName(String tierName) {
        this.tierName = tierName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    
    
}
