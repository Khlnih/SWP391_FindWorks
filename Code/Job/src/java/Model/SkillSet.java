package Model;

public class SkillSet {
    private int skillSetId;
    private String skillSetName;
    private String description;
    private int statusSkill;
    private int expertId;

    public SkillSet() {}

    public SkillSet(int skillSetId, String skillSetName, String description, int statusSkill, int expertId) {
        this.skillSetId = skillSetId;
        this.skillSetName = skillSetName;
        this.description = description;
        this.statusSkill = statusSkill;
        this.expertId = expertId;
    }

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

    public int getStatusSkill() {
        return statusSkill;
    }

    public void setStatusSkill(int statusSkill) {
        this.statusSkill = statusSkill;
    }

    public int getExpertId() {
        return expertId;
    }

    public void setExpertId(int expertId) {
        this.expertId = expertId;
    }
}
