package Model;

import java.math.BigDecimal;
import java.sql.Date;

public class Recruiter {
    private int recruiterID;
    private String password_hash;
    private String first_name;
    private String last_name;
    private boolean gender; // 0: nữ, 1: nam
    private Date dob;
    private String image;
    private BigDecimal money;
    private String email_contact;
    private String phone_contact;
    private String status;
    private Integer statusChangedByAdminID;

    // Constructor mặc định
    public Recruiter() {
    }

    // Constructor đầy đủ
    public Recruiter(int recruiterID, String password_hash, String first_name, String last_name,
                    boolean gender, Date dob, String image, BigDecimal money, String email_contact,
                    String phone_contact, String status, Integer statusChangedByAdminID) {
        this.recruiterID = recruiterID;
        this.password_hash = password_hash;
        this.first_name = first_name;
        this.last_name = last_name;
        this.gender = gender;
        this.dob = dob;
        this.image = image;
        this.money = money;
        this.email_contact = email_contact;
        this.phone_contact = phone_contact;
        this.status = status;
        this.statusChangedByAdminID = statusChangedByAdminID;
    }

    // Getters and Setters

    public int getRecruiterID() {
        return recruiterID;
    }

    public void setRecruiterID(int recruiterID) {
        this.recruiterID = recruiterID;
    }

    public String getPassword_hash() {
        return password_hash;
    }

    public void setPassword_hash(String password_hash) {
        this.password_hash = password_hash;
    }
    
    // Để tương thích với code cũ
    public String getPassword() {
        return password_hash;
    }

    public void setPassword(String password) {
        this.password_hash = password;
    }

    public String getFirst_name() {
        return first_name;
    }

    public void setFirst_name(String first_name) {
        this.first_name = first_name;
    }
    
    // Để tương thích với code cũ
    public String getFirstName() {
        return first_name;
    }

    public void setFirstName(String firstName) {
        this.first_name = firstName;
    }

    public String getLast_name() {
        return last_name;
    }

    public void setLast_name(String last_name) {
        this.last_name = last_name;
    }
    
    // Để tương thích với code cũ
    public String getLastName() {
        return last_name;
    }

    public void setLastName(String lastName) {
        this.last_name = lastName;
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

    public String getEmail_contact() {
        return email_contact;
    }

    public void setEmail_contact(String email_contact) {
        this.email_contact = email_contact;
    }
    
    // Để tương thích với code cũ
    public String getEmailContact() {
        return email_contact;
    }

    public void setEmailContact(String emailContact) {
        this.email_contact = emailContact;
    }

    public String getPhone_contact() {
        return phone_contact;
    }

    public void setPhone_contact(String phone_contact) {
        this.phone_contact = phone_contact;
    }
    
    // Để tương thích với code cũ
    public String getPhoneContact() {
        return phone_contact;
    }

    public void setPhoneContact(String phoneContact) {
        this.phone_contact = phoneContact;
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
        return "Recruiter{" +
                "recruiterID=" + recruiterID +
                ", password_hash='" + password_hash + '\'' +
                ", first_name='" + first_name + '\'' +
                ", last_name='" + last_name + '\'' +
                ", gender=" + gender +
                ", dob=" + dob +
                ", money=" + money +
                ", email_contact='" + email_contact + '\'' +
                ", phone_contact='" + phone_contact + '\'' +
                ", status='" + status + '\'' +
                ", statusChangedByAdminID=" + statusChangedByAdminID +
                '}';
    }
}
