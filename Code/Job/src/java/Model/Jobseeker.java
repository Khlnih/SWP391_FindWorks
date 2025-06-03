/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author ADMIN
 */
public class Jobseeker {
    
    private int freelanceID;
    private String username;
    private String password;
    private String firstName;
    private String lastName;
    private String image; 
    private boolean gender;
    private String dob;
    private String describe;
    private String email__contact;
    private String phone_contact;
    private String status;

    public Jobseeker() {
    }

    public Jobseeker(int freelanceID, String username, String password, String firstName, String lastName, String image, boolean gender, String dob, String describe, String email__contact, String phone_contact, String status) {
        this.freelanceID = freelanceID;
        this.username = username;
        this.password = password;
        this.firstName = firstName;
        this.lastName = lastName;
        this.image = image;
        this.gender = gender;
        this.dob = dob;
        this.describe = describe;
        this.email__contact = email__contact;
        this.phone_contact = phone_contact;
        this.status = status;
    }

    public int getFreelanceID() {
        return freelanceID;
    }

    public void setFreelanceID(int freelanceID) {
        this.freelanceID = freelanceID;
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

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
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

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public String getDescribe() {
        return describe;
    }

    public void setDescribe(String describe) {
        this.describe = describe;
    }

    public String getEmail__contact() {
        return email__contact;
    }

    public void setEmail__contact(String email__contact) {
        this.email__contact = email__contact;
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
    
    
}
