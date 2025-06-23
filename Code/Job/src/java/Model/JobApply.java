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
public class JobApply {
    private int applyID;
    private int freelancerID;
    private int postID;
    private String statusApply;
    private Date dateApply;
    private String coverLetter;
    private String resumePath;

    public JobApply() {
    }

    public JobApply(int applyID, int freelancerID, int postID, String statusApply, Date dateApply, String coverLetter, String resumePath) {
        this.applyID = applyID;
        this.freelancerID = freelancerID;
        this.postID = postID;
        this.statusApply = statusApply;
        this.dateApply = dateApply;
        this.coverLetter = coverLetter;
        this.resumePath = resumePath;
    }

    public int getApplyID() {
        return applyID;
    }

    public void setApplyID(int applyID) {
        this.applyID = applyID;
    }

    public int getFreelancerID() {
        return freelancerID;
    }

    public void setFreelancerID(int freelancerID) {
        this.freelancerID = freelancerID;
    }

    public int getPostID() {
        return postID;
    }

    public void setPostID(int postID) {
        this.postID = postID;
    }

    public String getStatusApply() {
        return statusApply;
    }

    public void setStatusApply(String statusApply) {
        this.statusApply = statusApply;
    }

    public Date getDateApply() {
        return dateApply;
    }

    public void setDateApply(Date dateApply) {
        this.dateApply = dateApply;
    }

    public String getCoverLetter() {
        return coverLetter;
    }

    public void setCoverLetter(String coverLetter) {
        this.coverLetter = coverLetter;
    }

    public String getResumePath() {
        return resumePath;
    }

    public void setResumePath(String resumePath) {
        this.resumePath = resumePath;
    }

    
    
    
}
