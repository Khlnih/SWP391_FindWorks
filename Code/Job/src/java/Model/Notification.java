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
public class Notification {
    private int notificationID;
    private int recipientFreelancerID;
    private int recipientRecruiterID;
    private String message;
    private String notificationType;
    private int isRead; 
    private Date readDate;
    private int createdByAdminID;   

    public Notification() {
    }

    public Notification(int notificationID, int recipientFreelancerID, int recipientRecruiterID, String message, String notificationType, int isRead, Date readDate, Integer createdByAdminID) {
        this.notificationID = notificationID;
        this.recipientFreelancerID = recipientFreelancerID;
        this.recipientRecruiterID = recipientRecruiterID;
        this.message = message;
        this.notificationType = notificationType;
        this.isRead = isRead;
        this.readDate = readDate;
        this.createdByAdminID = createdByAdminID;
    }

    public int getNotificationID() {
        return notificationID;
    }

    public void setNotificationID(int notificationID) {
        this.notificationID = notificationID;
    }

    public int getRecipientFreelancerID() {
        return recipientFreelancerID;
    }

    public void setRecipientFreelancerID(int recipientFreelancerID) {
        this.recipientFreelancerID = recipientFreelancerID;
    }

    public int getRecipientRecruiterID() {
        return recipientRecruiterID;
    }

    public void setRecipientRecruiterID(int recipientRecruiterID) {
        this.recipientRecruiterID = recipientRecruiterID;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getNotificationType() {
        return notificationType;
    }

    public void setNotificationType(String notificationType) {
        this.notificationType = notificationType;
    }

    public int getIsRead() {
        return isRead;
    }

    public void setIsRead(int isRead) {
        this.isRead = isRead;
    }

    public Date getReadDate() {
        return readDate;
    }

    public void setReadDate(Date readDate) {
        this.readDate = readDate;
    }

    public int getCreatedByAdminID() {
        return createdByAdminID;
    }

    public void setCreatedByAdminID(int createdByAdminID) {
        this.createdByAdminID = createdByAdminID;
    }
    
    
}
