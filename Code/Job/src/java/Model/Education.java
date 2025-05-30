/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Date;

/**
 * Model class for Education table
 * @author Cascade
 */
public class Education {
    private int educationID;
    private String universityName;
    private Date startDate;
    private Date endDate;
    private int freelanceID;
    private int degreeID;
    private String degreeName; // Additional field to store degree name when joining with Degree table
    
    // Default constructor
    public Education() {
    }
    
    // Full constructor
    public Education(int educationID, String universityName, Date startDate, Date endDate, int freelanceID, int degreeID, String degreeName) {
        this.educationID = educationID;
        this.universityName = universityName;
        this.startDate = startDate;
        this.endDate = endDate;
        this.freelanceID = freelanceID;
        this.degreeID = degreeID;
        this.degreeName = degreeName;
    }
    
    // Constructor without educationID (for insertion)
    public Education(String universityName, Date startDate, Date endDate, int freelanceID, int degreeID) {
        this.universityName = universityName;
        this.startDate = startDate;
        this.endDate = endDate;
        this.freelanceID = freelanceID;
        this.degreeID = degreeID;
    }

    // Getters and Setters
    public int getEducationID() {
        return educationID;
    }

    public void setEducationID(int educationID) {
        this.educationID = educationID;
    }

    public String getUniversityName() {
        return universityName;
    }

    public void setUniversityName(String universityName) {
        this.universityName = universityName;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public int getFreelanceID() {
        return freelanceID;
    }

    public void setFreelanceID(int freelanceID) {
        this.freelanceID = freelanceID;
    }

    public int getDegreeID() {
        return degreeID;
    }

    public void setDegreeID(int degreeID) {
        this.degreeID = degreeID;
    }
    
    public String getDegreeName() {
        return degreeName;
    }

    public void setDegreeName(String degreeName) {
        this.degreeName = degreeName;
    }

    @Override
    public String toString() {
        return "Education{" + 
                "educationID=" + educationID + 
                ", universityName=" + universityName + 
                ", startDate=" + startDate + 
                ", endDate=" + endDate + 
                ", freelanceID=" + freelanceID + 
                ", degreeID=" + degreeID + 
                ", degreeName=" + degreeName + 
                '}';
    }
}
