package Model;

/**
 * Model cho thông tin đăng ký gói cước của Nhà tuyển dụng
 */
public class RecruiterSubscription {
    private int recruiterID;
    private String companyName;
    private String companyAddress;
    private String companyEmail;
    private String first_name;
    private String last_name;
    private String companyPhone;
    private int subscriptionID;
    private int tierID;
    private String startDate;
    private String endDate;
    private boolean isActiveSubscription;
    private String tierName;
    private double price;

    public RecruiterSubscription() {
    }

    public RecruiterSubscription(int recruiterID, String companyName, String companyAddress, String companyEmail, String first_name, String last_name, String companyPhone, int subscriptionID, int tierID, String startDate, String endDate, boolean isActiveSubscription, String tierName, double price) {
        this.recruiterID = recruiterID;
        this.companyName = companyName;
        this.companyAddress = companyAddress;
        this.companyEmail = companyEmail;
        this.first_name = first_name;
        this.last_name = last_name;
        this.companyPhone = companyPhone;
        this.subscriptionID = subscriptionID;
        this.tierID = tierID;
        this.startDate = startDate;
        this.endDate = endDate;
        this.isActiveSubscription = isActiveSubscription;
        this.tierName = tierName;
        this.price = price;
    }

    public int getRecruiterID() {
        return recruiterID;
    }

    public void setRecruiterID(int recruiterID) {
        this.recruiterID = recruiterID;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getCompanyAddress() {
        return companyAddress;
    }

    public void setCompanyAddress(String companyAddress) {
        this.companyAddress = companyAddress;
    }

    public String getCompanyEmail() {
        return companyEmail;
    }

    public void setCompanyEmail(String companyEmail) {
        this.companyEmail = companyEmail;
    }

    public String getFirst_name() {
        return first_name;
    }

    public void setFirst_name(String first_name) {
        this.first_name = first_name;
    }

    public String getLast_name() {
        return last_name;
    }

    public void setLast_name(String last_name) {
        this.last_name = last_name;
    }

    public String getCompanyPhone() {
        return companyPhone;
    }

    public void setCompanyPhone(String companyPhone) {
        this.companyPhone = companyPhone;
    }

    public int getSubscriptionID() {
        return subscriptionID;
    }

    public void setSubscriptionID(int subscriptionID) {
        this.subscriptionID = subscriptionID;
    }

    public int getTierID() {
        return tierID;
    }

    public void setTierID(int tierID) {
        this.tierID = tierID;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public boolean isIsActiveSubscription() {
        return isActiveSubscription;
    }

    public void setIsActiveSubscription(boolean isActiveSubscription) {
        this.isActiveSubscription = isActiveSubscription;
    }

    public String getTierName() {
        return tierName;
    }

    public void setTierName(String tierName) {
        this.tierName = tierName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
    
   
}
