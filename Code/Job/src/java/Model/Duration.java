package Model;

/**
 * Model class for Duration table
 */
public class Duration {
    private int durationID;
    private String durationName;

    // Constructors
    public Duration() {
    }

    public Duration(int durationID, String durationName) {
        this.durationID = durationID;
        this.durationName = durationName;
    }

    public Duration(String durationName) {
        this.durationName = durationName;
    }

    // Getters and Setters
    public int getDurationID() {
        return durationID;
    }

    public void setDurationID(int durationID) {
        this.durationID = durationID;
    }

    public String getDurationName() {
        return durationName;
    }

    public void setDurationName(String durationName) {
        this.durationName = durationName;
    }

    @Override
    public String toString() {
        return "Duration{" +
                "durationID=" + durationID +
                ", durationName='" + durationName + '\'' +
                '}';
    }
}
