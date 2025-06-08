package Model;


public class JobType {
    private int jobTypeID;
    private String jobTypeName;

    public JobType() {
    }

    public JobType(int jobTypeID, String jobTypeName) {
        this.jobTypeID = jobTypeID;
        this.jobTypeName = jobTypeName;
    }

    public JobType(String jobTypeName) {
        this.jobTypeName = jobTypeName;
    }

    public int getJobTypeID() {
        return jobTypeID;
    }

    public void setJobTypeID(int jobTypeID) {
        this.jobTypeID = jobTypeID;
    }

    public String getJobTypeName() {
        return jobTypeName;
    }

    public void setJobTypeName(String jobTypeName) {
        this.jobTypeName = jobTypeName;
    }

    @Override
    public String toString() {
        return "JobType{" +
                "jobTypeID=" + jobTypeID +
                ", jobTypeName='" + jobTypeName + '\'' +
                '}';
    }
}
