/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Date;

/**
 * Model class for Experience table
 * @author Cascade
 */
public class Experience {
    private int experienceID;
    private String experienceWorkName;
    private String position;
    private Date startDate;
    private Date endDate;
    private String yourProject;
    private int freelanceID;
    
    // Default constructor
    public Experience() {
    }
    
    // Full constructor
    public Experience(int experienceID, String experienceWorkName, String position, 
                      Date startDate, Date endDate, String yourProject, int freelanceID) {
        this.experienceID = experienceID;
        this.experienceWorkName = experienceWorkName;
        this.position = position;
        this.startDate = startDate;
        this.endDate = endDate;
        this.yourProject = yourProject;
        this.freelanceID = freelanceID;
    }
    
    // Constructor without experienceID (for insertion)
    public Experience(String experienceWorkName, String position, 
                      Date startDate, Date endDate, String yourProject, int freelanceID) {
        this.experienceWorkName = experienceWorkName;
        this.position = position;
        this.startDate = startDate;
        this.endDate = endDate;
        this.yourProject = yourProject;
        this.freelanceID = freelanceID;
    }

    // Getters and Setters
    public int getExperienceID() {
        return experienceID;
    }

    public void setExperienceID(int experienceID) {
        this.experienceID = experienceID;
    }

    public String getExperienceWorkName() {
        return experienceWorkName;
    }

    public void setExperienceWorkName(String experienceWorkName) {
        this.experienceWorkName = experienceWorkName;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
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

    public String getYourProject() {
        return yourProject;
    }

    public void setYourProject(String yourProject) {
        this.yourProject = yourProject;
    }

    public int getFreelanceID() {
        return freelanceID;
    }

    public void setFreelanceID(int freelanceID) {
        this.freelanceID = freelanceID;
    }

    @Override
    public String toString() {
        return "Experience{" +
                "experienceID=" + experienceID +
                ", experienceWorkName='" + experienceWorkName + '\'' +
                ", position='" + position + '\'' +
                ", startDate=" + startDate +
                ", endDate=" + endDate +
                ", yourProject='" + yourProject + '\'' +
                ", freelanceID=" + freelanceID +
                '}';
    }
}
