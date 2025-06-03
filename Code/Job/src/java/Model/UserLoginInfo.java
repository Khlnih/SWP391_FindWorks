package Model;

public class UserLoginInfo {

    private String username;
    private String emailContact;
    private String password;

    public UserLoginInfo() {
    }

    public UserLoginInfo(String username, String emailContact, String password) {
        this.username = username;
        this.emailContact = emailContact;
        this.password = password;
    }

    public String getUsername() {
        return username;
    }

    public String getEmailContact() {
        return emailContact;
    }

    public String getPassword() {
        return password;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setEmailContact(String emailContact) {
        this.emailContact = emailContact;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String toString() {
        return "UserLoginInfo{" +
               "username='" + username + '\'' +
               ", emailContact='" + emailContact + '\'' +
               '}';
    }
}