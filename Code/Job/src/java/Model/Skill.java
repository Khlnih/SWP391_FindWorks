/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 * Model class for Skills table
 * @author Cascade
 */
public class Skill {
    private int skillID;
    private int skillSetID;
    private int freelancerID;
    private int level;
    private String skillSetName; // Additional field to store skill name when joining with Skill_Set table
    private String description; // Additional field for skill description
    private int expertiseID; // Additional field to connect to Expertise category
    private String expertiseName; // Additional field for expertise name
    
    // Default constructor
    public Skill() {
    }
    
    // Full constructor
    public Skill(int skillID, int skillSetID, int freelancerID, int level, 
                String skillSetName, String description, int expertiseID, String expertiseName) {
        this.skillID = skillID;
        this.skillSetID = skillSetID;
        this.freelancerID = freelancerID;
        this.level = level;
        this.skillSetName = skillSetName;
        this.description = description;
        this.expertiseID = expertiseID;
        this.expertiseName = expertiseName;
    }
    
    // Constructor for basic skill information (for insertion)
    public Skill(int skillSetID, int freelancerID, int level) {
        this.skillSetID = skillSetID;
        this.freelancerID = freelancerID;
        this.level = level;
    }
    
    // Getters and Setters
    public int getSkillID() {
        return skillID;
    }

    public void setSkillID(int skillID) {
        this.skillID = skillID;
    }

    public int getSkillSetID() {
        return skillSetID;
    }

    public void setSkillSetID(int skillSetID) {
        this.skillSetID = skillSetID;
    }

    public int getFreelancerID() {
        return freelancerID;
    }

    public void setFreelancerID(int freelancerID) {
        this.freelancerID = freelancerID;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    public String getSkillSetName() {
        return skillSetName;
    }

    public void setSkillSetName(String skillSetName) {
        this.skillSetName = skillSetName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getExpertiseID() {
        return expertiseID;
    }

    public void setExpertiseID(int expertiseID) {
        this.expertiseID = expertiseID;
    }

    public String getExpertiseName() {
        return expertiseName;
    }

    public void setExpertiseName(String expertiseName) {
        this.expertiseName = expertiseName;
    }

    @Override
    public String toString() {
        return "Skill{" +
                "skillID=" + skillID +
                ", skillSetID=" + skillSetID +
                ", freelancerID=" + freelancerID +
                ", level=" + level +
                ", skillSetName='" + skillSetName + '\'' +
                ", description='" + description + '\'' +
                ", expertiseID=" + expertiseID +
                ", expertiseName='" + expertiseName + '\'' +
                '}';
    }
}
