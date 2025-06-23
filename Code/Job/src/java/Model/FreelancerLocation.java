/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author ADMIN
 */
public class FreelancerLocation {
    private int freelancerLocationID;
    private int freelancerID;
    private String city;          
    private String country;     
    private String workPreference;
    private String locationNotes;

    public FreelancerLocation() {
    }

    public FreelancerLocation(int freelancerLocationID, int freelancerID, String city, String country, String workPreference, String locationNotes) {
        this.freelancerLocationID = freelancerLocationID;
        this.freelancerID = freelancerID;
        this.city = city;
        this.country = country;
        this.workPreference = workPreference;
        this.locationNotes = locationNotes;
    }

    public int getFreelancerLocationID() {
        return freelancerLocationID;
    }

    public void setFreelancerLocationID(int freelancerLocationID) {
        this.freelancerLocationID = freelancerLocationID;
    }

    public int getFreelancerID() {
        return freelancerID;
    }

    public void setFreelancerID(int freelancerID) {
        this.freelancerID = freelancerID;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getWorkPreference() {
        return workPreference;
    }

    public void setWorkPreference(String workPreference) {
        this.workPreference = workPreference;
    }

    public String getLocationNotes() {
        return locationNotes;
    }

    public void setLocationNotes(String locationNotes) {
        this.locationNotes = locationNotes;
    }
    
}
