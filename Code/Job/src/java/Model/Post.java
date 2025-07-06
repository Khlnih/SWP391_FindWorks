/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.math.BigDecimal;
import java.util.Date;

/**
 *
 * @author ADMIN
 */
public class Post {
    private int postId;                 // từ [postID] [int] IDENTITY(1,1) NOT NULL
    private String title;               // từ [title] [nvarchar](220) NULL
    private String image;               // từ [image] [nvarchar](220) NULL
    private int jobTypeId;              // từ [jobTypeID] [int] NOT NULL
    private int durationId;             // từ [durationID] [int] NOT NULL
    private Date datePost;              // từ [date_post] [datetime] NOT NULL
    private Date expiredDate;           // từ [expired_date] [datetime] NULL
    private int quantity;               // từ [quantity] [int] NOT NULL
    private String description;         // từ [description] [nvarchar](max) NULL
    private BigDecimal budgetMin;       // từ [budget_min] [decimal](18,2) NULL
    private BigDecimal budgetMax;       // từ [budget_max] [decimal](18,2) NULL
    private String budgetType;          // từ [budget_type] [nvarchar](20) NULL
    private String location;            // từ [location] [nvarchar](255) NULL
    private int recruiterId;            // từ [recruiterID] [int] NOT NULL
    private String statusPost;          // từ [statusPost] [nvarchar](20) NOT NULL
    private int categoryId;             // từ [categoryID] [int] NOT NULL
    private Integer approvedByAdminID;  // từ [approvedByAdminID] [int] NULL


    // Constructors
    public Post() {
    }

    public Post(int postId, String title, int jobTypeId) {
        this.postId = postId;
        this.title = title;
        this.jobTypeId = jobTypeId;
    }
    

    // Constructor đầy đủ
    public Post(int postId, String title, String image, int jobTypeId, int durationId,
                Date datePost, Date expiredDate, int quantity, String description,
                BigDecimal budgetMin, BigDecimal budgetMax, String budgetType,
                String location, int recruiterId, String statusPost, int categoryId,
                Integer approvedByAdminID) {
        this.postId = postId;
        this.title = title;
        this.image = image;
        this.jobTypeId = jobTypeId;
        this.durationId = durationId;
        this.datePost = datePost;
        this.expiredDate = expiredDate;
        this.quantity = quantity;
        this.description = description;
        this.budgetMin = budgetMin;
        this.budgetMax = budgetMax;
        this.budgetType = budgetType;
        this.location = location;
        this.recruiterId = recruiterId;
        this.statusPost = statusPost;
        this.categoryId = categoryId;
        this.approvedByAdminID = approvedByAdminID;
    }

    // Constructor cho tạo mới (không có ID)
    public Post(String title, String image, int jobTypeId, int durationId,
                Date expiredDate, int quantity, String description,
                BigDecimal budgetMin, BigDecimal budgetMax, String budgetType,
                String location, int recruiterId, String statusPost, int categoryId) {
        this.title = title;
        this.image = image;
        this.jobTypeId = jobTypeId;
        this.durationId = durationId;
        this.expiredDate = expiredDate;
        this.quantity = quantity;
        this.description = description;
        this.budgetMin = budgetMin;
        this.budgetMax = budgetMax;
        this.budgetType = budgetType;
        this.location = location;
        this.recruiterId = recruiterId;
        this.statusPost = statusPost;
        this.categoryId = categoryId;
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

    public Date getExpiredDate() {
        return expiredDate;
    }

    public void setExpiredDate(Date expiredDate) {
        this.expiredDate = expiredDate;
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

    public BigDecimal getBudgetMin() {
        return budgetMin;
    }

    public void setBudgetMin(BigDecimal budgetMin) {
        this.budgetMin = budgetMin;
    }

    public BigDecimal getBudgetMax() {
        return budgetMax;
    }

    public void setBudgetMax(BigDecimal budgetMax) {
        this.budgetMax = budgetMax;
    }

    public String getBudgetType() {
        return budgetType;
    }

    public void setBudgetType(String budgetType) {
        this.budgetType = budgetType;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public int getRecruiterId() {
        return recruiterId;
    }

    public void setRecruiterId(int recruiterId) {
        this.recruiterId = recruiterId;
    }

    public String getStatusPost() {
        return statusPost;
    }

    public void setStatusPost(String statusPost) {
        this.statusPost = statusPost;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public Integer getApprovedByAdminID() {
        return approvedByAdminID;
    }

    public void setApprovedByAdminID(Integer approvedByAdminID) {
        this.approvedByAdminID = approvedByAdminID;
    }

    @Override
    public String toString() {
        return "Post{" +
                "postId=" + postId +
                ", title='" + title + '\'' +
                ", image='" + image + '\'' +
                ", jobTypeId=" + jobTypeId +
                ", durationId=" + durationId +
                ", datePost=" + datePost +
                ", expiredDate=" + expiredDate +
                ", quantity=" + quantity +
                ", description='" + description + '\'' +
                ", budgetMin=" + budgetMin +
                ", budgetMax=" + budgetMax +
                ", budgetType='" + budgetType + '\'' +
                ", location='" + location + '\'' +
                ", recruiterId=" + recruiterId +
                ", statusPost='" + statusPost + '\'' +
                ", categoryId=" + categoryId +
                ", approvedByAdminID=" + approvedByAdminID +
                '}';
    }
}
