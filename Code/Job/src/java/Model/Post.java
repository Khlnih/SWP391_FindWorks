/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.Date;

/**
 *
 * @author ADMIN
 */
public class Post {
    private int postId;         // từ [postID] [int] IDENTITY(1,1) NOT NULL
    private String title;       // từ [title] [nvarchar](50) NULL
    private String image;       // từ [image] [nvarchar](220) NULL
    private int jobTypeId;      // từ [job_type_ID] [int] NOT NULL
    private int durationId;     // từ [durationID] [int] NOT NULL
    private Date datePost;      // từ [date_post] [date] NOT NULL
    private Date expired;       // từ [expired] [date] NULL
    private int quantity;       // từ [quantity] [int] NOT NULL
    private String description; // từ [description] [nvarchar](max) NULL
    private Integer budget;     // từ [budget] [int] NULL (Integer cho phép null)
    private String location;    // từ [location] [nvarchar](50) NULL
    private String skill;       // từ [skill] [nvarchar](50) NULL
    private int recruiterId;    // từ [recruiterID] [int] NOT NULL
    private Integer status;     // từ [status] [int] NULL (Integer cho phép null)
    private int caId;           // từ [caID] [int] NOT NULL
    private Integer checking;   // từ [checking] [int] NULL (Integer cho phép null)
    private Integer approvedByAdminID;   // từ [approvedByAdminID] [int] NULL (Integer cho phép null)


    // Constructors
    public Post() {
    }

    public Post(int postId, String title, String image, int jobTypeId, int durationId,
                Date datePost, Date expired, int quantity, String description, Integer budget,
                String location, String skill, int recruiterId, Integer status, int caId, Integer checking) {
        this.postId = postId;
        this.title = title;
        this.image = image;
        this.jobTypeId = jobTypeId;
        this.durationId = durationId;
        this.datePost = datePost;
        this.expired = expired;
        this.quantity = quantity;
        this.description = description;
        this.budget = budget;
        this.location = location;
        this.skill = skill;
        this.recruiterId = recruiterId;
        this.status = status;
        this.caId = caId;
        this.checking = checking;
    }

    // Getters and Setters
    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getJobTypeId() {
        return jobTypeId;
    }

    public void setJobTypeId(int jobTypeId) {
        this.jobTypeId = jobTypeId;
    }

    public int getDurationId() {
        return durationId;
    }

    public void setDurationId(int durationId) {
        this.durationId = durationId;
    }

    public Date getDatePost() {
        return datePost;
    }

    public void setDatePost(Date datePost) {
        this.datePost = datePost;
    }

    public Date getExpired() {
        return expired;
    }

    public void setExpired(Date expired) {
        this.expired = expired;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getBudget() {
        return budget;
    }

    public void setBudget(Integer budget) {
        this.budget = budget;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getSkill() {
        return skill;
    }

    public void setSkill(String skill) {
        this.skill = skill;
    }

    public int getRecruiterId() {
        return recruiterId;
    }

    public void setRecruiterId(int recruiterId) {
        this.recruiterId = recruiterId;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public int getCaId() {
        return caId;
    }

    public void setCaId(int caId) {
        this.caId = caId;
    }

    public Integer getChecking() {
        return checking;
    }

    public void setChecking(Integer checking) {
        this.checking = checking;
    }

    public Integer getApprovedByAdminID() {
        return approvedByAdminID;
    }

    public void setApprovedByAdminID(Integer approvedByAdminID) {
        this.approvedByAdminID = approvedByAdminID;
    }
}
