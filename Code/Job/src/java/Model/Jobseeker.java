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
public class Jobseeker {
    
    private int freelancerID;
    private String username;
    private String password;
    private String first_Name;
    private String last_Name;
    private String image; 
    private boolean gender;
    private Date dob;
    private String describe;
    private String email_contact;
    private String phone_contact;
    private String status;
    private Integer statusChangedByAdminID;
    public Jobseeker() {
    }

    public Jobseeker(int freelancerID, String username, String password, String first_Name, String last_Name, String image, boolean gender, Date dob, String describe, String email_contact, String phone_contact, String status, Integer statusChangedByAdminID) {
        this.freelancerID = freelancerID;
        this.username = username;
        this.password = password;
        this.first_Name = first_Name;
        this.last_Name = last_Name;
        this.image = image;
        this.gender = gender;
        this.dob = dob;
        this.describe = describe;
        this.email_contact = email_contact;
        this.phone_contact = phone_contact;
        this.status = status;
        this.statusChangedByAdminID = statusChangedByAdminID;
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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFirst_Name() {
        return first_Name;
    }

    public void setFirst_Name(String first_Name) {
        this.first_Name = first_Name;
    }

    public String getLast_Name() {
        return last_Name;
    }

    public void setLast_Name(String last_Name) {
        this.last_Name = last_Name;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public boolean isGender() {
        return gender;
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public String getDescribe() {
        return describe;
    }

    public void setDescribe(String describe) {
        this.describe = describe;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Integer getStatusChangedByAdminID() {
        return statusChangedByAdminID;
    }

    public void setStatusChangedByAdminID(Integer statusChangedByAdminID) {
        this.statusChangedByAdminID = statusChangedByAdminID;
    }

    
    
}
