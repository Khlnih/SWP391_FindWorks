package model;
import java.sql.Date;

public class Recruiter {

    private int recruiterID;
    private String username;
    private String password;
    private String firstName;
    private String lastName;
    private boolean gender;       // true hoặc false tương ứng với 1 hoặc 0
    private Date dob;
    private String image;
    private int money;
    private String emailContact;
    private String phoneContact;
    private String status;

    // Constructor mặc định
    public Recruiter() {
    }

    // Constructor đầy đủ
    public Recruiter(int recruiterID, String username, String password, String firstName, String lastName,
            boolean gender, Date dob, String image, int money, String emailContact,
            String phoneContact, String status) {
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
    }

    // Getter và Setter cho từng thuộc tính
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

    public int getMoney() {
        return money;
    }

    public void setMoney(int money) {
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

    // Có thể override toString() để dễ debug, in thông tin
    @Override
    public String toString() {
        return "Recruiter{"
                + "recruiterID=" + recruiterID
                + ", username='" + username + '\''
                + ", password='" + password + '\''
                + ", firstName='" + firstName + '\''
                + ", lastName='" + lastName + '\''
                + ", gender=" + gender
                + ", dob=" + dob
                + ", image='" + image + '\''
                + ", money=" + money
                + ", emailContact='" + emailContact + '\''
                + ", phoneContact='" + phoneContact + '\''
                + ", status='" + status + '\''
                + '}';
    }
}
