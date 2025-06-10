package Model;

import java.math.BigDecimal;

public class AccountTier {
    private int tierID;
    private String tierName;
    private BigDecimal price;
    private int durationDays;
    private String description;
    private String userTypeScope;
    private boolean status;
    private int jobPostLimit;
    public AccountTier() {
    }

    public AccountTier(int tierID, String tierName, BigDecimal price, 
                      int durationDays, String description) {
        this.tierID = tierID;
        this.tierName = tierName;
        this.price = price;
        this.durationDays = durationDays;
        this.description = description;
    }

    public AccountTier(int tierID, String tierName, BigDecimal price, int durationDays, String description, String userTypeScope) {
        this.tierID = tierID;
        this.tierName = tierName;
        this.price = price;
        this.durationDays = durationDays;
        this.description = description;
        this.userTypeScope = userTypeScope;
    }

    public AccountTier(int tierID, String tierName, BigDecimal price, int durationDays, String description, String userTypeScope, boolean status, int jobPostLimit) {
        this.tierID = tierID;
        this.tierName = tierName;
        this.price = price;
        this.durationDays = durationDays;
        this.description = description;
        this.userTypeScope = userTypeScope;
        this.status = status;
        this.jobPostLimit = jobPostLimit;
    }
    
    public int getTierID() {
        return tierID;
    }

    public void setTierID(int tierID) {
        this.tierID = tierID;
    }

    public String getTierName() {
        return tierName;
    }

    public void setTierName(String tierName) {
        this.tierName = tierName;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getDurationDays() {
        return durationDays;
    }

    public void setDurationDays(int durationDays) {
        this.durationDays = durationDays;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getUserTypeScope() {
        return userTypeScope;
    }

    public void setUserTypeScope(String userTypeScope) {
        this.userTypeScope = userTypeScope;
    }
    
    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public int getJobPostLimit() {
        return jobPostLimit;
    }

    public void setJobPostLimit(int jobPostLimit) {
        this.jobPostLimit = jobPostLimit;
    }
    
    
}
