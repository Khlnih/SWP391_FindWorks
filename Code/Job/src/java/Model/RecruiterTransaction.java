package Model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class RecruiterTransaction {
    private int transactionID;
    private int recruiterID;
    private String type;
    private BigDecimal amount;
    private String description;
    private Timestamp transactionDate;
    private Integer relatedID;

    public RecruiterTransaction() {
    }

    public RecruiterTransaction(int transactionID, int recruiterID, String type, 
                              BigDecimal amount, String description, 
                              Timestamp transactionDate, Integer relatedID) {
        this.transactionID = transactionID;
        this.recruiterID = recruiterID;
        this.type = type;
        this.amount = amount;
        this.description = description;
        this.transactionDate = transactionDate;
        this.relatedID = relatedID;
    }

    // Getters and Setters
    public int getTransactionID() { return transactionID; }
    public void setTransactionID(int transactionID) { this.transactionID = transactionID; }
    
    public int getRecruiterID() { return recruiterID; }
    public void setRecruiterID(int recruiterID) { this.recruiterID = recruiterID; }
    
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    
    public BigDecimal getAmount() { return amount; }
    public void setAmount(BigDecimal amount) { this.amount = amount; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public Timestamp getTransactionDate() { return transactionDate; }
    public void setTransactionDate(Timestamp transactionDate) { this.transactionDate = transactionDate; }
    
    public Integer getRelatedID() { return relatedID; }
    public void setRelatedID(Integer relatedID) { this.relatedID = relatedID; }
}
