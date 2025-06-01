package Model;

import java.sql.Timestamp;

public class UserTransaction {
    private int transactionID;
    private int userID;
    private String transactionType;
    private Timestamp transactionDate;
    private String status;
    private String description;

    public UserTransaction() {
    }

    public UserTransaction(int transactionID, int userID, String transactionType, 
                         Timestamp transactionDate, String status, String description) {
        this.transactionID = transactionID;
        this.userID = userID;
        this.transactionType = transactionType;
        this.transactionDate = transactionDate;
        this.status = status;
        this.description = description;
    }

    // Getters and Setters
    public int getTransactionID() { return transactionID; }
    public void setTransactionID(int transactionID) { this.transactionID = transactionID; }
    
    public int getUserID() { return userID; }
    public void setUserID(int userID) { this.userID = userID; }
    
    public String getTransactionType() { return transactionType; }
    public void setTransactionType(String transactionType) { this.transactionType = transactionType; }
    
    public Timestamp getTransactionDate() { return transactionDate; }
    public void setTransactionDate(Timestamp transactionDate) { this.transactionDate = transactionDate; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
}
