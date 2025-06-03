package Model;

import java.math.BigDecimal;

public class AccountTier {
    private int tierID;
    private String tierName;
    private BigDecimal price;
    private int durationDays;
    private String description;
    private String userTypeScope;
    private int status;
    public AccountTier() {
    }

    public AccountTier(int tierID, String tierName, BigDecimal price, int durationDays, String description, String userTypeScope, int status) {
        this.tierID = tierID;
        this.tierName = tierName;
        this.price = price;
        this.durationDays = durationDays;
        this.description = description;
        this.userTypeScope = userTypeScope;
        this.status = status;
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

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    
}
