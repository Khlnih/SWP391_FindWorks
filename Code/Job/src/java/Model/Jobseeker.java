/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Date;

/**
 * Model lớp Jobseeker mapping với bảng Freelancer trong CSDL
 * @author ADMIN
 */
public class Jobseeker {
    
    private int freelancerID;
    private String password_hash;
    private String first_name;
    private String last_name;
    private String image; 
    private boolean gender;
    private Date dob;
    private String describe;
    private String email_contact;
    private String phone_contact;
    private String status;
    private Integer statusChangedByAdminID; // Có thể null

    public Jobseeker() {
    }

    public Jobseeker(int freelancerID, String password_hash, String first_name, String last_name, String image, boolean gender, Date dob, String describe, String email_contact, String phone_contact, String status, Integer statusChangedByAdminID) {
        this.freelancerID = freelancerID;
        this.password_hash = password_hash;
        this.first_name = first_name;
        this.last_name = last_name;
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

   

    public String getPassword_hash() {
        return password_hash;
    }

    public void setPassword_hash(String password_hash) {
        this.password_hash = password_hash;
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
    
    @Override
    public String toString() {
        return "Jobseeker{" +
                "freelancerID=" + freelancerID +
                ", password_hash='" + password_hash + '\'' +
                ", first_name='" + first_name + '\'' +
                ", last_name='" + last_name + '\'' +
                ", image='" + image + '\'' +
                ", gender=" + gender +
                ", dob=" + dob +
                ", describe='" + describe + '\'' +
                ", email_contact='" + email_contact + '\'' +
                ", phone_contact='" + phone_contact + '\'' +
                ", status='" + status + '\'' +
                ", statusChangedByAdminID=" + statusChangedByAdminID +
                '}';
    }
}
