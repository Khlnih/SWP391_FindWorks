/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

public class Company {
    private String companyID;
    private String companyName;
    private String email;
    private String phone;
    private String address;
    private String description;
    private String password;

    public Company() {}

    public Company(String companyID, String companyName, String email, String phone,
                   String address, String description, String password) {
        this.companyID = companyID;
        this.companyName = companyName;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.description = description;
        this.password = password;
    }

    // Getters and Setters
    public String getCompanyID() { return companyID; }
    public void setCompanyID(String companyID) { this.companyID = companyID; }

    public String getCompanyName() { return companyName; }
    public void setCompanyName(String companyName) { this.companyName = companyName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
}

