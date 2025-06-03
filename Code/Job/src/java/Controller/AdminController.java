package Controller;

import DAO.SkillDAO;
import DAO.JobseekerDAO;
import DAO.RecruiterDAO;
import DAO.EducationDAO;
import DAO.ExperienceDAO;
import DAO.JobseekerSkillDAO;
import DAO.RecruiterTransactionDAO;
import DAO.AccountTierDAO;
import DAO.CompanyDAO;
import Model.Jobseeker;
import Model.Recruiter;
import Model.SkillSet;
import Model.Education;
import Model.Experience;
import Model.Skill;
import Model.RecruiterTransaction;
import Model.AccountTier;
import Model.Company;
import java.math.BigDecimal;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List; // Import List
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;

/**
 * Servlet implementation class AdminController
 */
@WebServlet("/admin")
public class AdminController extends HttpServlet {
    private JobseekerDAO jobseekerDAO = new JobseekerDAO();
    private RecruiterDAO recruiterDAO = new RecruiterDAO();
    private SkillDAO skillDAO = new SkillDAO();
    private EducationDAO educationDAO = new EducationDAO();
    private ExperienceDAO experienceDAO = new ExperienceDAO();
    private JobseekerSkillDAO jobseekerSkillDAO = new JobseekerSkillDAO();
    private AccountTierDAO accountTierDAO = new AccountTierDAO();


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        if (action == null) {
            action = "dashboard"; 
        }

        
        clearSessionMessages(session, action);


        switch (action) {
            case "dashboard":
                request.getRequestDispatcher("admin.jsp").forward(request, response);
                break;
            case "jobseekers":
                showJobseekers(request, response);
                break;
            case "recruiters":
                showRecruiters(request, response);
                break;
            case "skills":
                showSkills(request, response);
                break;
            case "accounttier":
//                showAccountTier(request, response);
                break;
            case "addSkill":
                addSkill(request, response);
                break;
            case "editSkill":
                showEditSkillForm(request, response);
                break;
            case "updateSkill":
                updateSkill(request, response);
                break;
            case "deleteSkill":
                deleteSkill(request, response);
                break;
            case "settings":
                request.getRequestDispatcher("admin_settings.jsp").forward(request, response);
                break;
            case "changeStatus": 
                changeJobseekerStatus(request, response);
                break;
            case "deleteJobseeker":
                deleteJobseeker(request, response);
                break;
            case "changeRecruiterStatus":
                changeRecruiterStatus(request, response);
                break;
            case "deleteRecruiter":
                deleteRecruiter(request, response);
                break;
            case "viewRecruiter":
                viewRecruiter(request, response);
                break;
            case "viewJobseeker":
                viewJobseeker(request, response);
                break;
            default:
                request.getRequestDispatcher("admin.jsp").forward(request, response);
                break;
        }
    }
    
    private void clearSessionMessages(HttpSession session, String currentAction) {
        // Example: If current action is related to skills, clear any old jobseeker/recruiter messages
        // This needs to be tailored to your specific message usage.
        // A simpler approach is to always clear message/error before setting new ones for PRG.
        // For now, we'll handle message transfer in each 'showX' method.
    }

    private void transferSessionMessagesToRequest(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            if (session.getAttribute("message") != null) {
                request.setAttribute("message", session.getAttribute("message"));
                session.removeAttribute("message");
            }
            if (session.getAttribute("error") != null) {
                request.setAttribute("error", session.getAttribute("error"));
                session.removeAttribute("error");
            }
        }
    }


    private void showJobseekers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        transferSessionMessagesToRequest(request); // For PRG
        try {
            ArrayList<Jobseeker> jobseekers = jobseekerDAO.getAllJobSeeker();
            request.setAttribute("jobseekers", jobseekers);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading jobseekers: " + e.getMessage());
            request.setAttribute("jobseekers", new ArrayList<Jobseeker>()); // Ensure not null for JSP
        }
        request.getRequestDispatcher("admin_jobseeker.jsp").forward(request, response);
    }

    private void showRecruiters(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        transferSessionMessagesToRequest(request); 
        try {
            ArrayList<Recruiter> recruiters = recruiterDAO.getAllRecruiters();
            request.setAttribute("recruiters", recruiters);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading recruiters: " + e.getMessage());
            request.setAttribute("recruiters", new ArrayList<Recruiter>()); // Ensure not null for JSP
        }
        request.getRequestDispatcher("admin_recruiter.jsp").forward(request, response);
    }
   
    // --- Skill Management Methods ---

    private void showSkills(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        transferSessionMessagesToRequest(request); // For PRG messages

        try {
            String keyword = request.getParameter("keyword");
            int defaultPageSize = 10;
            int pageSize = defaultPageSize;
            String pageSizeParam = request.getParameter("pageSize");
            if (pageSizeParam != null && !pageSizeParam.isEmpty()) {
                try {
                    int customPageSize = Integer.parseInt(pageSizeParam);
                    if (customPageSize > 0) pageSize = customPageSize;
                } catch (NumberFormatException e) { /* use default */ }
            }

            int currentPage = 1;
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    currentPage = Integer.parseInt(pageParam);
                    if (currentPage < 1) currentPage = 1;
                } catch (NumberFormatException e) { /* use default */ }
            }

            int totalSkills;
            List<SkillSet> skillList;

            if (keyword != null && !keyword.trim().isEmpty()) {
                totalSkills = skillDAO.countSearchedSkills(keyword);
                skillList = skillDAO.searchSkills(keyword, currentPage, pageSize);
            } else {
                totalSkills = skillDAO.countTotalSkills();
                skillList = skillDAO.getSkillsByPage(currentPage, pageSize);
            }

            int totalPages = (int) Math.ceil((double) totalSkills / pageSize);
            if (totalPages == 0 && totalSkills > 0) totalPages = 1; // Handle case with few items

            if (currentPage > totalPages && totalPages > 0) {
                currentPage = totalPages;
                // Optionally re-fetch data if currentPage changed
                // skillList = (keyword != null && !keyword.trim().isEmpty()) ?
                //             skillDAO.searchSkills(keyword, currentPage, pageSize) :
                //             skillDAO.getSkillsByPage(currentPage, pageSize);
            }
             if (currentPage < 1) {
                currentPage = 1;
            }

            request.setAttribute("skillList", skillList != null ? skillList : new ArrayList<SkillSet>());
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalSkills", totalSkills);
            request.setAttribute("currentKeyword", keyword);
            request.setAttribute("pageSize", pageSize); // Send pageSize back to JSP

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading skills: " + e.getMessage());
            // Initialize to avoid nulls in JSP if error occurs before setting these
            request.setAttribute("skillList", new ArrayList<SkillSet>());
            request.setAttribute("currentPage", 1);
            request.setAttribute("totalPages", 0);
            request.setAttribute("totalSkills", 0);
            request.setAttribute("pageSize", 10);
        }
        request.getRequestDispatcher("admin_skill.jsp").forward(request, response);
    }

    private void addSkill(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String skillName = request.getParameter("skillName");
        String skillDescription = request.getParameter("skillDescription");
        String statusSkillStr = request.getParameter("statusSkill");
        String expertIdStr = request.getParameter("expertId");

        if (skillName == null || skillName.trim().isEmpty()) {
            session.setAttribute("error", "Skill name cannot be empty.");
            response.sendRedirect(request.getContextPath() + "/admin?action=skills");
            return;
        }
        
        try {
            int statusSkill = 1; // Default to active
            if (statusSkillStr != null && !statusSkillStr.trim().isEmpty()) {
                statusSkill = Integer.parseInt(statusSkillStr);
            }

            int expertId = 0; // Default (adjust if 0 is not suitable)
            if (expertIdStr != null && !expertIdStr.trim().isEmpty()) {
                expertId = Integer.parseInt(expertIdStr);
            }

            SkillSet newSkill = new SkillSet();
            newSkill.setSkillSetName(skillName.trim());
            newSkill.setDescription(skillDescription != null ? skillDescription.trim() : "");
            newSkill.setStatusSkill(statusSkill);
            newSkill.setExpertId(expertId);

            boolean success = skillDAO.addSkill(newSkill);
            if (success) {
                session.setAttribute("message", "Skill '" + newSkill.getSkillSetName() + "' added successfully!");
            } else {
                session.setAttribute("error", "Failed to add skill. It might already exist or there was a database error.");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid format for Status or Expert ID.");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Error adding skill: " + e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/admin?action=skills");
    }

    private void showEditSkillForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        transferSessionMessagesToRequest(request); // If redirecting here with messages
        String skillIdStr = request.getParameter("id");
        if (skillIdStr != null) {
            try {
                int skillId = Integer.parseInt(skillIdStr);
                SkillSet skill = skillDAO.getSkillById(skillId);
                if (skill != null) {
                    request.setAttribute("skillToEdit", skill);
                    request.getRequestDispatcher("admin_skill_edit.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Skill not found for editing (ID: " + skillId + ").");
                    // Forward to the list page with an error, or stay on edit page with error
                    showSkills(request, response); // Or custom error on edit page
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid skill ID format for editing.");
                showSkills(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Error retrieving skill for editing: " + e.getMessage());
                showSkills(request, response);
            }
        } else {
            request.setAttribute("error", "No skill ID provided for editing.");
            showSkills(request, response);
        }
    }

    private void updateSkill(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String skillSetIdStr = request.getParameter("skillSetId"); // Corrected parameter name
        String skillName = request.getParameter("skillName");
        String skillDescription = request.getParameter("skillDescription");
        String statusSkillStr = request.getParameter("statusSkill");
        String expertIdStr = request.getParameter("expertId");
        String redirectURL = request.getContextPath() + "/admin?action=skills";


        if (skillSetIdStr == null || skillName == null || skillName.trim().isEmpty()) {
            session.setAttribute("error", "Skill ID and Skill Name are required for update.");
            // Optionally redirect back to edit page with error
            // redirectURL = request.getContextPath() + "/admin?action=editSkill&id=" + skillSetIdStr;
            response.sendRedirect(redirectURL);
            return;
        }

        try {
            int skillSetId = Integer.parseInt(skillSetIdStr);
            
            int statusSkill = 1;
            if (statusSkillStr != null && !statusSkillStr.trim().isEmpty()) {
                statusSkill = Integer.parseInt(statusSkillStr);
            }

            int expertId = 0;
            if (expertIdStr != null && !expertIdStr.trim().isEmpty()) {
                expertId = Integer.parseInt(expertIdStr);
            }
            
            SkillSet skillToUpdate = new SkillSet();
            skillToUpdate.setSkillSetId(skillSetId);
            skillToUpdate.setSkillSetName(skillName.trim());
            skillToUpdate.setDescription(skillDescription != null ? skillDescription.trim() : "");
            skillToUpdate.setStatusSkill(statusSkill);
            skillToUpdate.setExpertId(expertId);

            boolean success = skillDAO.updateSkill(skillToUpdate);
            if (success) {
                session.setAttribute("message", "Skill '" + skillToUpdate.getSkillSetName() + "' updated successfully!");
            } else {
                session.setAttribute("error", "Failed to update skill. Skill not found or database error.");
                 // Optionally redirect back to edit page if update fails
                // redirectURL = request.getContextPath() + "/admin?action=editSkill&id=" + skillSetId;
            }
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid format for Skill ID, Status, or Expert ID.");
            // redirectURL = request.getContextPath() + "/admin?action=editSkill&id=" + skillSetIdStr;
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Error updating skill: " + e.getMessage());
            // redirectURL = request.getContextPath() + "/admin?action=editSkill&id=" + skillSetIdStr;
        }
        response.sendRedirect(redirectURL);
    }

    private void deleteSkill(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String skillIdStr = request.getParameter("id");

        if (skillIdStr != null) {
            try {
                int skillId = Integer.parseInt(skillIdStr);
                // Consider fetching skill name before delete for a more informative message
                // SkillSet skillToDelete = skillDAO.getSkillById(skillId);
                // String skillName = (skillToDelete != null) ? skillToDelete.getSkillSetName() : "ID " + skillId;
                
                boolean success = skillDAO.deleteSkill(skillId);
                if (success) {
                    session.setAttribute("message", "Skill (ID: " + skillId + ") deleted successfully!");
                } else {
                    session.setAttribute("error", "Failed to delete skill. It might not exist.");
                }
            } catch (NumberFormatException e) {
                session.setAttribute("error", "Invalid skill ID format for deletion.");
            } catch (Exception e) {
                e.printStackTrace();
                if (e.getMessage() != null && (e.getMessage().toLowerCase().contains("constraint") || e.getMessage().toLowerCase().contains("foreign key"))) {
                     session.setAttribute("error", "Cannot delete skill (ID: " + skillIdStr + "): It is currently in use by other records.");
                } else {
                    session.setAttribute("error", "Error deleting skill (ID: " + skillIdStr + "): " + e.getMessage());
                }
            }
        } else {
            session.setAttribute("error", "No skill ID provided for deletion.");
        }
        response.sendRedirect(request.getContextPath() + "/admin?action=skills");
    }

    // --- End of Skill Management Methods ---

    // --- Jobseeker and Recruiter methods with PRG ---
    private void changeJobseekerStatus(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String id = request.getParameter("id");
        String status = request.getParameter("status");

        if (id != null && status != null) {
            try {
                jobseekerDAO.updateStatus(Integer.parseInt(id), status);
                session.setAttribute("message", "Jobseeker (ID: " + id + ") status updated successfully to " + status);
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("error", "Error updating jobseeker status: " + e.getMessage());
            }
        } else {
             session.setAttribute("error", "Missing ID or status for jobseeker update.");
        }
        response.sendRedirect(request.getContextPath() + "/admin?action=jobseekers");
    }

    private void deleteJobseeker(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String id = request.getParameter("id");

        if (id != null) {
            try {
                boolean success = jobseekerDAO.deleteJobseeker(Integer.parseInt(id));
                if (success) {
                    session.setAttribute("message", "Jobseeker (ID: " + id + ") deleted successfully");
                } else {
                    session.setAttribute("error", "Error deleting jobseeker (not found or constraint issue).");
                }
            } catch (NumberFormatException e) {
                session.setAttribute("error", "Invalid jobseeker ID");
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("error", "Error deleting jobseeker: " + e.getMessage());
            }
        } else {
            session.setAttribute("error", "No jobseeker ID provided");
        }
        response.sendRedirect(request.getContextPath() + "/admin?action=jobseekers");
    }
    private void viewRecruiter(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        if (id == null || id.isEmpty()) {
            response.sendRedirect("AdminController?action=recruiter");
            return;
        }
        
        try {
            int recruiterId = Integer.parseInt(id);
            Recruiter recruiter = recruiterDAO.getRecruiterById(recruiterId);
            if (recruiter != null) {
                RecruiterDAO reDAO = new RecruiterDAO();
                RecruiterTransactionDAO rtDAO = new RecruiterTransactionDAO();
                List<RecruiterTransaction> transactions = rtDAO.getTransactionsByRecruiter(recruiterId);
                Double totalSpent = rtDAO.getTotalSpent(recruiterId);
                
                // Lấy thông tin gói đăng ký
                AccountTierDAO atDAO = new AccountTierDAO();
                AccountTier currentTier = atDAO.getCurrentTier(recruiterId);
                String tierName = reDAO.getTierName(recruiterId);
                String description = reDAO.getTierNameDescription(recruiterId);
                
                // Lấy thông tin công ty
                CompanyDAO companyDAO = new CompanyDAO();
                Company company = companyDAO.getCompanyByRecruiterId(recruiterId);
                
                // Đặt thuộc tính để hiển thị trong JSP
                request.setAttribute("recruiter", recruiter);
                request.setAttribute("transactions", transactions);
                request.setAttribute("totalSpent", totalSpent);
                request.setAttribute("currentTier", currentTier);
                request.setAttribute("tierName", tierName);
                request.setAttribute("description", description);
                request.setAttribute("company", company);
                
                request.getRequestDispatcher("admin_recruiterdetails.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Recruiter not found");
                response.sendRedirect("AdminController?action=recruiter");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid recruiter ID");
            response.sendRedirect("AdminController?action=recruiter");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading recruiter details: " + e.getMessage());
            response.sendRedirect("AdminController?action=recruiter");
        }
    }
    
    private void viewJobseeker(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        if (id == null || id.isEmpty()) {
            response.sendRedirect("admin?action=jobseekers");
            return;
        }
        
        try {
            int freelancerId = Integer.parseInt(id);
            Jobseeker jobseeker = jobseekerDAO.getJobseekerById(freelancerId);
            
            if (jobseeker != null) {
                // Lấy dữ liệu từ các DAO
                List<Education> educations = educationDAO.getEducationByFreelancerID(freelancerId);
                List<Experience> experiences = experienceDAO.getExperienceByFreelancerID(freelancerId);
                List<Skill> skills = jobseekerSkillDAO.getSkillsByFreelancerID(freelancerId);
                
                // Đặt các thuộc tính vào request
                request.setAttribute("jobseeker", jobseeker);
                request.setAttribute("educations", educations);
                request.setAttribute("experiences", experiences);
                request.setAttribute("skills", skills);
                
                // Forward đến trang chi tiết
                request.getRequestDispatcher("admin_jobseekerdetails.jsp").forward(request, response);
            } else {
                request.getSession().setAttribute("error", "Không tìm thấy ứng viên");
                response.sendRedirect("admin?action=jobseekers");
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "ID ứng viên không hợp lệ");
            response.sendRedirect("admin?action=jobseekers");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Lỗi khi tải thông tin ứng viên: " + e.getMessage());
            response.sendRedirect("admin?action=jobseekers");
        }
    }

    private void changeRecruiterStatus(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String id = request.getParameter("id");
        String status = request.getParameter("status");

        if (id != null && status != null) {
            try {
                recruiterDAO.updateStatus(Integer.parseInt(id), status);
                session.setAttribute("message", "Recruiter (ID: " + id + ") status updated successfully to " + status);
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("error", "Error updating recruiter status: " + e.getMessage());
            }
        } else {
            session.setAttribute("error", "Missing ID or status for recruiter update.");
        }
        response.sendRedirect(request.getContextPath() + "/admin?action=recruiters");
    }

    private void deleteRecruiter(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String id = request.getParameter("id");

        if (id != null) {
            try {
                boolean success = recruiterDAO.deleteRecruiter(Integer.parseInt(id));
                if (success) {
                    session.setAttribute("message", "Recruiter (ID: " + id + ") deleted successfully");
                } else {
                    session.setAttribute("error", "Error deleting recruiter (not found or constraint issue).");
                }
            } catch (NumberFormatException e) {
                session.setAttribute("error", "Invalid recruiter ID");
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("error", "Error deleting recruiter: " + e.getMessage());
            }
        } else {
            session.setAttribute("error", "No recruiter ID provided");
        }
        response.sendRedirect(request.getContextPath() + "/admin?action=recruiters");
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Admin Controller Servlet";
    }
}