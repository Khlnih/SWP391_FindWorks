package Model;

import java.sql.Date;

public class Jobseeker {
    private int freelanceID;
    private String username;
    private String password;
    private String firstName;
    private String lastName;
    private String image;
    private boolean gender;
    private Date dob;
    private String describe;
    private String emailContact;
    private String phoneContact;
    private String status;

    // Constructor mặc định
    public Jobseeker() {
    }

    // Constructor đầy đủ
    public Jobseeker(int freelanceID, String username, String password, String firstName, String lastName,
                    String image, boolean gender, Date dob, String describe,
                    String emailContact, String phoneContact, String status) {
        this.freelanceID = freelanceID;
        this.username = username;
        this.password = password;
        this.firstName = firstName;
        this.lastName = lastName;
        this.image = image;
        this.gender = gender;
        this.dob = dob;
        this.describe = describe;
        this.emailContact = emailContact;
        this.phoneContact = phoneContact;
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

    public String getEmailContact() {
        return emailContact;
    }

    public void setEmailContact(String emailContact) {
        this.emailContact = emailContact;
    }

    public String getPhoneContact() {
        return phoneContact;
    }

    public void setPhoneContact(String phoneContact) {
        this.phoneContact = phoneContact;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    

    @Override
    public String toString() {
        return "Jobseeker{" +
                "freelanceID=" + freelanceID +
                ", username='" + username + '\'' +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", gender=" + gender +
                ", dob=" + dob +
                ", emailContact='" + emailContact + '\'' +
                ", phoneContact='" + phoneContact + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}
