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
public class Report {
    private int reportID;
    private int reporterFreelancerID;
    private int reportedPostID;
    private Date dateReport; 
    private String message;
    private int handledByAdminID; 
    private String handlingStatus;
    private String adminNotes;

    public Report() {
    }

    public Report(int reportID, int reporterFreelancerID, int reportedPostID, Date dateReport, String message, int handledByAdminID, String handlingStatus, String adminNotes) {
        this.reportID = reportID;
        this.reporterFreelancerID = reporterFreelancerID;
        this.reportedPostID = reportedPostID;
        this.dateReport = dateReport;
        this.message = message;
        this.handledByAdminID = handledByAdminID;
        this.handlingStatus = handlingStatus;
        this.adminNotes = adminNotes;
    }

    public int getReportID() {
        return reportID;
    }

    public void setReportID(int reportID) {
        this.reportID = reportID;
    }

    public int getReporterFreelancerID() {
        return reporterFreelancerID;
    }

    public void setReporterFreelancerID(int reporterFreelancerID) {
        this.reporterFreelancerID = reporterFreelancerID;
    }

    public int getReportedPostID() {
        return reportedPostID;
    }

    public void setReportedPostID(int reportedPostID) {
        this.reportedPostID = reportedPostID;
    }

    public Date getDateReport() {
        return dateReport;
    }

    public void setDateReport(Date dateReport) {
        this.dateReport = dateReport;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public int getHandledByAdminID() {
        return handledByAdminID;
    }

    public void setHandledByAdminID(int handledByAdminID) {
        this.handledByAdminID = handledByAdminID;
    }

    public String getHandlingStatus() {
        return handlingStatus;
    }

    public void setHandlingStatus(String handlingStatus) {
        this.handlingStatus = handlingStatus;
    }

    public String getAdminNotes() {
        return adminNotes;
    }

    public void setAdminNotes(String adminNotes) {
        this.adminNotes = adminNotes;
    }
    
    
}
