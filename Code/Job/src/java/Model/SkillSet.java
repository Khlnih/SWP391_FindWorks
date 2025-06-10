package Model;

/**
 * Lớp này đại diện cho một bộ kỹ năng (Skill Set) trong hệ thống.
 * Nó ánh xạ tới bảng 'Skill_Set' trong cơ sở dữ liệu.
 */
public class SkillSet {

    private int skillSetId;
    private String skillSetName;
    private String description;
    private boolean isActive;
    private int expertiseId; // Khóa ngoại tới bảng Expertise

    // Constructor không tham số
    public SkillSet() {
    }

    // Constructor đầy đủ tham số
    public SkillSet(int skillSetId, String skillSetName, String description, boolean isActive, int expertiseId) {
        this.skillSetId = skillSetId;
        this.skillSetName = skillSetName;
        this.description = description;
        this.isActive = isActive;
        this.expertiseId = expertiseId;
    }

    // Getters and Setters
    public int getSkillSetId() {
        return skillSetId;
    }

    public void setSkillSetId(int skillSetId) {
        this.skillSetId = skillSetId;
    }

    public String getSkillSetName() {
        return skillSetName;
    }

    public void setSkillSetName(String skillSetName) {
        this.skillSetName = skillSetName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public int getExpertiseId() {
        return expertiseId;
    }

    public void setExpertiseId(int expertiseId) {
        this.expertiseId = expertiseId;
    }

    // Phương thức toString() để dễ dàng debug
    @Override
    public String toString() {
        return "SkillSet{" +
                "skillSetId=" + skillSetId +
                ", skillSetName='" + skillSetName + '\'' +
                ", description='" + description + '\'' +
                ", isActive=" + isActive +
                ", expertiseId=" + expertiseId +
                '}';
    }
}