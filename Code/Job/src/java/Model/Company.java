package Model;

import java.sql.Date;


import java.time.LocalDate; 

public class Company {
    private int companyID;
    private String company_name;
    private int team_number;
    private String established_on; 
    private String logo;
    private String website;
    private String describe;
    private String location;
    private int recruiterID; 

    public Company() {
    }

    public Company(int companyID, String company_name, int team_number, String established_on,
                   String logo, String website, String describe, String location, int recruiterID) {
        this.companyID = companyID;
        this.company_name = company_name;
        this.team_number = team_number;
        this.established_on = established_on;
        this.logo = logo;
        this.website = website;
        this.describe = describe;
        this.location = location;
        this.recruiterID = recruiterID;
    }

    public int getCompanyID() {
        return companyID;
    }

    public void setCompanyID(int companyID) {
        this.companyID = companyID;
    }

    public String getCompany_name() {
        return company_name;
    }

    public void setCompany_name(String company_name) {
        this.company_name = company_name;
    }

    public int getTeam_number() {
        return team_number;
    }

    public void setTeam_number(int team_number) {
        this.team_number = team_number;
    }

    public String getEstablished_on() {
        return established_on;
    }

    public void setEstablished_on(String established_on) {
        this.established_on = established_on;
    }

    // Nếu bạn dùng LocalDate:
    // public LocalDate getEstablished_on() { return established_on; }
    // public void setEstablished_on(LocalDate established_on) { this.established_on = established_on; }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public String getDescribe() {
        return describe;
    }

    public void setDescribe(String describe) {
        this.describe = describe;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public int getRecruiterID() {
        return recruiterID;
    }

    public void setRecruiterID(int recruiterID) {
        this.recruiterID = recruiterID;
    }
    
}

