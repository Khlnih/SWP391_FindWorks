package Model;

public class UserLoginInfo {

    private int userID;
    private String username;
    private String emailContact;
    private String password;
    private String userType; // "recruiter" hoặc "freelancer"

    public UserLoginInfo() {
    }

    public UserLoginInfo(String username, String emailContact, String password) {
        this.username = username;
        this.emailContact = emailContact;
        this.password = password;
    }

    public UserLoginInfo(int userID, String username, String emailContact, String password, String userType) {
        this.userID = userID;
        this.username = username;
        this.emailContact = emailContact;
        this.password = password;
        this.userType = userType;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmailContact() {
        return emailContact;
    }

    public void setEmailContact(String emailContact) {
        this.emailContact = emailContact;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    @Override
    public String toString() {
        return "UserLoginInfo{" +
               "userID=" + userID +
               ", username='" + username + '\'' +
               ", emailContact='" + emailContact + '\'' +
               ", userType='" + userType + '\'' +
               '}';
    }
}