package DAO;

import Model.Skill;
import Model.SkillSet;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SkillDAO extends DBContext{

    private SkillSet mapResultSetToSkillSet(ResultSet rs) throws SQLException {
        return new SkillSet(
            rs.getInt("skill_set_ID"),
            rs.getString("skill_set_name"),
            rs.getString("description"),
            rs.getBoolean("isActive"),
            rs.getInt("expertiseID")
        );
    }
        public ArrayList<SkillSet> getAllSkillSets() {
        ArrayList<SkillSet> list = new ArrayList<>();
        String sql = "SELECT * FROM Skill_Set";
        
        try{
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                SkillSet s = new SkillSet(
                    rs.getInt("skill_set_ID"),
                    rs.getString("skill_set_name"),
                    rs.getString("description"),
                    rs.getBoolean("isActive"),
                    rs.getInt("expertiseID")
                );
                list.add(s);
            }
        }catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addSkillSet(SkillSet skillSet) throws SQLException {
        String sql = "INSERT INTO Skill_Set (skill_set_name, description, isActive, expertiseID) VALUES (?, ?, ?, ?)";
        try (
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, skillSet.getSkillSetName());
            ps.setString(2, skillSet.getDescription());
            ps.setBoolean(3, skillSet.isActive());
            ps.setInt(4, skillSet.getExpertiseId());
            return ps.executeUpdate() > 0;
        }
    }

    public SkillSet getSkillSetById(int skillSetId) throws SQLException {
        String sql = "SELECT * FROM Skill_Set WHERE skill_set_ID = ?";
        try (
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, skillSetId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToSkillSet(rs);
                }
            }
        }
        return null;
    }

    public boolean updateSkillSet(SkillSet skillSet) throws SQLException {
        String sql = "UPDATE Skill_Set SET skill_set_name = ?, description = ?, isActive = ?, expertiseID = ? WHERE skill_set_ID = ?";
        try (
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, skillSet.getSkillSetName());
            ps.setString(2, skillSet.getDescription());
            ps.setBoolean(3, skillSet.isActive());
            ps.setInt(4, skillSet.getExpertiseId());
            ps.setInt(5, skillSet.getSkillSetId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean deleteSkillSet(int skillSetId) throws SQLException {
        String sql = "DELETE FROM Skill_Set WHERE skill_set_ID = ?";
        try (
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, skillSetId);
            return ps.executeUpdate() > 0;
        }
    }

    public int countTotalSkillSets() throws SQLException {
        String sql = "SELECT COUNT(*) FROM Skill_Set";
        try (
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public List<SkillSet> getSkillSetsByPage(int currentPage, int pageSize) throws SQLException {
        List<SkillSet> list = new ArrayList<>();
        String sql = "SELECT * FROM Skill_Set ORDER BY skill_set_name OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        int offset = (currentPage - 1) * pageSize;
        try (
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, offset);
            ps.setInt(2, pageSize);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToSkillSet(rs));
                }
            }
        }
        return list;
    }

    public int countSearchedSkillSets(String keyword) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Skill_Set WHERE skill_set_name LIKE ?";
        try (
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    public List<SkillSet> searchSkillSets(String keyword, int currentPage, int pageSize) throws SQLException {
        List<SkillSet> list = new ArrayList<>();
        String sql = "SELECT * FROM Skill_Set WHERE skill_set_name LIKE ? ORDER BY skill_set_name OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        int offset = (currentPage - 1) * pageSize;
        try (
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ps.setInt(2, offset);
            ps.setInt(3, pageSize);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToSkillSet(rs));
                }
            }
        }
        return list;
    }

    // ================ SKILL ================
    public List<Skill> getSkillsByFreelancerID(int freelancerId)  {
        List<Skill> list = new ArrayList<>();
        String sql = "SELECT s.skillID, s.skill_set_ID, s.freelancerID, s.level, " +
                     "       ss.skill_set_name, ss.description, ss.expertiseID, " +
                     "       e.expertiseName " +
                     "FROM Skills s " +
                     "JOIN Skill_Set ss ON s.skill_set_ID = ss.skill_set_ID " +
                     "LEFT JOIN Expertise e ON ss.expertiseID = e.expertiseID " +
                     "WHERE s.freelancerID = ?";
        try (
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, freelancerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Skill skill = new Skill();
                    skill.setSkillID(rs.getInt("skillID"));
                    skill.setSkillSetID(rs.getInt("skill_set_ID"));
                    skill.setFreelancerID(rs.getInt("freelancerID"));
                    skill.setLevel(rs.getInt("level"));
                    skill.setSkillSetName(rs.getString("skill_set_name"));
                    skill.setDescription(rs.getString("description"));
                    skill.setExpertiseID(rs.getInt("expertiseID"));
                    skill.setExpertiseName(rs.getString("expertiseName"));
                    list.add(skill);
                }
            }
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public ArrayList<Skill> getSkillByFreelancerID(int freelancerId)  {
        ArrayList<Skill> list = new ArrayList<>();
        String sql = "SELECT s.skillID, s.skill_set_ID, s.freelancerID, s.level, " +
                     "       ss.skill_set_name, ss.description, ss.expertiseID, " +
                     "       e.expertiseName " +
                     "FROM Skills s " +
                     "JOIN Skill_Set ss ON s.skill_set_ID = ss.skill_set_ID " +
                     "LEFT JOIN Expertise e ON ss.expertiseID = e.expertiseID " +
                     "WHERE s.freelancerID = ?";
        try (
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, freelancerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Skill skill = new Skill();
                    skill.setSkillID(rs.getInt("skillID"));
                    skill.setSkillSetID(rs.getInt("skill_set_ID"));
                    skill.setFreelancerID(rs.getInt("freelancerID"));
                    skill.setLevel(rs.getInt("level"));
                    skill.setSkillSetName(rs.getString("skill_set_name"));
                    skill.setDescription(rs.getString("description"));
                    skill.setExpertiseID(rs.getInt("expertiseID"));
                    skill.setExpertiseName(rs.getString("expertiseName"));
                    list.add(skill);
                }
            }
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addSkillForFreelancer(Skill skill) throws SQLException {
        String sql = "INSERT INTO Skills (skill_set_ID, freelancerID, level) VALUES (?, ?, ?)";
        try (
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, skill.getSkillSetID());
            ps.setInt(2, skill.getFreelancerID());
            ps.setInt(3, skill.getLevel());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean deleteSkillForFreelancer(int skillId) throws SQLException {
        String sql = "DELETE FROM Skills WHERE skillID = ?";
        try (
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, skillId);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean updateSkillLevelForFreelancer(Skill skill) throws SQLException {
        String sql = "UPDATE Skills SET level = ? WHERE skillID = ?";
        try (
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, skill.getLevel());
            ps.setInt(2, skill.getSkillID());
            return ps.executeUpdate() > 0;
        }
    }
    
    public boolean doesSkillExistForFreelancer(int freelancerId, int skillSetId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Skills WHERE freelancerID = ? AND skill_set_ID = ?";
        try (
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, freelancerId);
            ps.setInt(2, skillSetId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    // Bổ sung thêm các phương thức cho Skill nếu cần (ví dụ: lấy chi tiết skill, lọc, sắp xếp...)
    public Skill getSkillById(int skillId) throws SQLException {
        String sql = "SELECT s.*, ss.skill_set_name, ss.description, ss.expertiseID, e.expertiseName " +
                     "FROM Skills s " +
                     "JOIN Skill_Set ss ON s.skill_set_ID = ss.skill_set_ID " +
                     "LEFT JOIN Expertise e ON ss.expertiseID = e.expertiseID " +
                     "WHERE s.skillID = ?";
        try (
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, skillId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Skill skill = new Skill();
                    skill.setSkillID(rs.getInt("skillID"));
                    skill.setSkillSetID(rs.getInt("skill_set_ID"));
                    skill.setFreelancerID(rs.getInt("freelancerID"));
                    skill.setLevel(rs.getInt("level"));
                    skill.setSkillSetName(rs.getString("skill_set_name"));
                    skill.setDescription(rs.getString("description"));
                    skill.setExpertiseID(rs.getInt("expertiseID"));
                    skill.setExpertiseName(rs.getString("expertiseName"));
                    return skill;
                }
            }
        }
        return null;
    }
}
