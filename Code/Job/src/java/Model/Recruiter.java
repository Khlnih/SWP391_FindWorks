package Model;

import java.math.BigDecimal;
import java.sql.Date;

public class Recruiter {
    private int recruiterID;
    private String username;
    private String password;
    private String firstName;
    private String lastName;
    private boolean gender; // 0: nữ, 1: nam
    private String dob;
    private String image;
    private BigDecimal money;
    private String emailContact;
    private String phoneContact;
    private String status;
    private Integer statusChangedByAdminID;

    public Recruiter() {
    }

    public Recruiter(String username, String password, String firstName, String lastName, boolean gender, String dob, String image, String emailContact, String phoneContact) {
        this.username = username;
        this.password = password;
        this.firstName = firstName;
        this.lastName = lastName;
        this.gender = gender;
        this.dob = dob;
        this.image = image;
        this.emailContact = emailContact;
        this.phoneContact = phoneContact;
    }
    
    public Recruiter(int recruiterID, String username, String password, String firstName, String lastName, boolean gender, String dob, String image, BigDecimal money, String emailContact, String phoneContact, String status, Integer statusChangedByAdminID) {
        this.recruiterID = recruiterID;
        this.username = username;
        this.password = password;
        this.firstName = firstName;
        this.lastName = lastName;
        this.gender = gender;
        this.dob = dob;
        this.image = image;
        this.money = money;
        this.emailContact = emailContact;
        this.phoneContact = phoneContact;
        this.status = status;
        this.statusChangedByAdminID = statusChangedByAdminID;
    }

    public int getRecruiterID() {
        return recruiterID;
    }

    public void setRecruiterID(int recruiterID) {
        this.recruiterID = recruiterID;
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

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public BigDecimal getMoney() {
        return money;
    }

    public void setMoney(BigDecimal money) {
        this.money = money;
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

    public Integer getStatusChangedByAdminID() {
        return statusChangedByAdminID;
    }

    public void setStatusChangedByAdminID(Integer statusChangedByAdminID) {
        this.statusChangedByAdminID = statusChangedByAdminID;
    }
    
    

    
}
