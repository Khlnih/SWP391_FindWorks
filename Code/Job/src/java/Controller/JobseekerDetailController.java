package Controller;

import DAO.EducationDAO;
import DAO.ExperienceDAO;
import DAO.JobseekerDAO;
import DAO.SkillDAO;
import Model.Education;
import Model.Experience;
import Model.FreelancerLocation;
import Model.Jobseeker;
import Model.Skill;
import Model.UserLoginInfo;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletOutputStream;
import Model.*;
import DAO.*;

@WebServlet(name = "JobseekerDetailController", urlPatterns = {"/JobseekerDetailController"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
    maxFileSize = 1024 * 1024 * 10,      // 10 MB
    maxRequestSize = 1024 * 1024 * 100   // 100 MB
)
public class JobseekerDetailController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");

        try {
            if (action == null || action.isEmpty()) {
                viewProfile(request, response);
            } else {
                switch (action) {
                    case "update-about":
                        updateAbout(request, response);
                        break;
                    case "update-contact":
                        updateContact(request, response);
                        break;
                    case "add-experience":
                        addExperience(request, response);
                        break;
                    case "update-experience":
                        updateExperience(request, response);
                        break;
                    case "delete-experience":
                        deleteExperience(request, response);
                        break;
                    case "add-education":
                        addEducation(request, response);
                        break;
                    case "update-education":
                        updateEducation(request, response);
                        break;
                    case "delete-education":
                        deleteEducation(request, response);
                        break;
                    case "add-skill":
                        addSkill(request, response);
                        break;
                    case "delete-skill":
                        deleteSkill(request, response);
                        break;
                    case "update-skill":
                        updateSkill(request, response);
                        break;
                    case "change-avatar":
                        changeAvatar(request, response);
                        break;
                    default:
                        viewProfile(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    private void viewProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Jobseeker jobseeker = (Jobseeker) session.getAttribute("jobseeker");
        
        if (jobseeker == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            // Load experiences
            ExperienceDAO experienceDAO = new ExperienceDAO();
            List<Experience> experiences = experienceDAO.getExperienceByFreelancerID(jobseeker.getFreelancerID());
            session.setAttribute("experience", experiences);
            
            // Load other profile data as needed
            // For example:
            // EducationDAO educationDAO = new EducationDAO();
            // List<Education> educations = educationDAO.getEducationByFreelancerID(jobseeker.getFreelancerID());
            // session.setAttribute("education", educations);
            
            // Forward to the profile page
            request.getRequestDispatcher("jobseeker_detail.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "An error occurred while loading profile: " + e.getMessage());
            response.sendRedirect("jobseeker_detail.jsp");
        }
    }

    private void updateAbout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get parameters
            int id = Integer.parseInt(request.getParameter("id"));
            String aboutText = request.getParameter("aboutText");
            
            // Get jobseeker from session
            HttpSession session = request.getSession();
            Jobseeker jobseeker = (Jobseeker) session.getAttribute("jobseeker");
            
            if (jobseeker != null && jobseeker.getFreelancerID() == id) {
                // Update in database
                JobseekerDAO dao = new JobseekerDAO();
                boolean isUpdated = dao.updateDes(String.valueOf(id), aboutText);
                
                if (isUpdated) {
                    // Update the jobseeker object in session
                    jobseeker.setDescribe(aboutText);
                    session.setAttribute("jobseeker", jobseeker);
                    
                    // Set success message
                    session.setAttribute("successMessage", "About section updated successfully!");
                } else {
                    // Set error message
                    session.setAttribute("errorMessage", "Failed to update about section.");
                }
            } else {
                session.setAttribute("errorMessage", "Unauthorized access.");
            }
            
            // Redirect back to the same page
            response.sendRedirect("jobseeker_detail.jsp");
            
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            response.sendRedirect("jobseeker_detail.jsp");
        }
    }

    private void updateContact(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String city = request.getParameter("city");
            String country = request.getParameter("country");
            String workPreference = request.getParameter("workPreference");
            String locationNotes = request.getParameter("locationNotes");
            
            // Get jobseeker from session
            HttpSession session = request.getSession();
            Jobseeker jobseeker = (Jobseeker) session.getAttribute("jobseeker");
            
            if (jobseeker != null && jobseeker.getFreelancerID() == id) {
                // Update in database
                JobseekerDAO dao = new JobseekerDAO();
                boolean contactUpdated = dao.updateContact(String.valueOf(id), email, phone);   
                boolean locationUpdated = dao.updateLocation(String.valueOf(id), city, country, workPreference, locationNotes);
                PrintWriter out = response.getWriter();out.print(contactUpdated);
                if (contactUpdated && locationUpdated) {
                    // Update the jobseeker object in session
                    jobseeker.setEmail_contact(email);
                    jobseeker.setPhone_contact(phone);
                    session.setAttribute("jobseeker", jobseeker);
                    
                    // Update location in session if it exists
                    FreelancerLocation location = (FreelancerLocation) session.getAttribute("location");
                    if (location != null) {
                        location.setCity(city);
                        location.setCountry(country);
                        location.setWorkPreference(workPreference);
                        location.setLocationNotes(locationNotes);
                        session.setAttribute("location", location);
                    }
                    
                    // Set success message
                    session.setAttribute("successMessage", "Contact information updated successfully!");
                } else {
                    // Set error message
                    session.setAttribute("errorMessage", "Failed to update contact information. Please try again.");
                }
            } else {
                session.setAttribute("errorMessage", "Unauthorized access.");
            }
            
            // Redirect back to the same page
            response.sendRedirect("jobseeker_detail.jsp");
            
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            response.sendRedirect("jobseeker_detail.jsp");
        }
    }

    private void addExperience(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Jobseeker jobseeker = (Jobseeker) session.getAttribute("jobseeker");
        int id = Integer.parseInt(request.getParameter("id"));
        if (jobseeker == null) {
            session.setAttribute("errorMessage", "Please log in to add work experience");
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            // Get form parameters
            String company = request.getParameter("company");
            String position = request.getParameter("position");
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            String description = request.getParameter("description");
            boolean isCurrent = "true".equals(request.getParameter("current"));
            
            // Validate required fields
            if (company == null || company.trim().isEmpty() || position == null || position.trim().isEmpty() 
                    || startDateStr == null || startDateStr.trim().isEmpty()) {
                session.setAttribute("errorMessage", "Company, position, and start date are required fields.");
                response.sendRedirect("jobseeker_detail.jsp");
                return;
            }
            
            // Parse dates
            Date startDate = Date.valueOf(startDateStr + "-01"); // Convert YYYY-MM to YYYY-MM-01
            Date endDate = null;
            
            if (!isCurrent && endDateStr != null && !endDateStr.trim().isEmpty()) {
                endDate = Date.valueOf(endDateStr + "-01");
            }
            
            // Create and populate Experience object
            Experience experience = new Experience();
            experience.setExperienceWorkName(company);
            experience.setPosition(position);
            experience.setStartDate(startDate);
            experience.setEndDate(endDate);
            experience.setYourProject(description);
            experience.setFreelancerID(id);
            
            // Save to database
            ExperienceDAO experienceDAO = new ExperienceDAO();
            boolean success = experienceDAO.addExperience(experience);
            
            if (success) {
                // Update session with new experience list
                List<Experience> experiences = experienceDAO.getExperienceByFreelancerID(id);
                session.setAttribute("experience", experiences);
                session.setAttribute("successMessage", "Work experience added successfully!");
            } else {
                session.setAttribute("errorMessage", "Failed to add work experience. Please try again.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
        }
        
        response.sendRedirect("jobseeker_detail.jsp");
    }

    private void updateExperience(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Jobseeker jobseeker = (Jobseeker) session.getAttribute("jobseeker");
        
        if (jobseeker == null) {
            session.setAttribute("errorMessage", "Please log in to update work experience");
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            // Get form parameters
            int experienceId = Integer.parseInt(request.getParameter("experienceId"));
            String company = request.getParameter("company");
            String position = request.getParameter("position");
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            String description = request.getParameter("description");
            boolean isCurrent = "true".equals(request.getParameter("current"));
            
            // Validate required fields
            if (company == null || company.trim().isEmpty() || position == null || position.trim().isEmpty() 
                    || startDateStr == null || startDateStr.trim().isEmpty()) {
                session.setAttribute("errorMessage", "Company, position, and start date are required fields.");
                response.sendRedirect("jobseeker_detail.jsp");
                return;
            }
            
            // Parse dates
            Date startDate = Date.valueOf(startDateStr + "-01"); // Convert YYYY-MM to YYYY-MM-01
            Date endDate = null;
            
            if (!isCurrent && endDateStr != null && !endDateStr.trim().isEmpty()) {
                endDate = Date.valueOf(endDateStr + "-01");
            }
            
            // Get the existing experience to verify ownership
            ExperienceDAO experienceDAO = new ExperienceDAO();
            Experience existingExp = experienceDAO.getExperienceByID(experienceId);
            
            if (existingExp == null || existingExp.getFreelancerID() != jobseeker.getFreelancerID()) {
                session.setAttribute("errorMessage", "Experience not found or you don't have permission to edit it.");
                response.sendRedirect("jobseeker_detail.jsp");
                return;
            }
            
            // Update the experience
            existingExp.setExperienceWorkName(company);
            existingExp.setPosition(position);
            existingExp.setStartDate(startDate);
            existingExp.setEndDate(endDate);
            existingExp.setYourProject(description);
            
            // Save to database
            boolean success = experienceDAO.updateExperience(existingExp);
            
            if (success) {
                // Update session with updated experience list
                List<Experience> experiences = experienceDAO.getExperienceByFreelancerID(jobseeker.getFreelancerID());
                session.setAttribute("experience", experiences);
                session.setAttribute("successMessage", "Work experience updated successfully!");
            } else {
                session.setAttribute("errorMessage", "Failed to update work experience. Please try again.");
            }
            
        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Invalid experience ID format.");
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
        }
        
        response.sendRedirect("jobseeker_detail.jsp");
    }

    private void deleteExperience(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        HttpSession session = request.getSession();
        Jobseeker jobseeker = (Jobseeker) session.getAttribute("jobseeker");
        
        if (jobseeker == null) {
            session.setAttribute("errorMessage", "Please log in to delete work experience");
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            // Get experience ID from request
            int experienceId = Integer.parseInt(request.getParameter("experienceId"));
            
            // Verify ownership before deleting
            ExperienceDAO experienceDAO = new ExperienceDAO();
            Experience experience = experienceDAO.getExperienceByID(experienceId);
            
            if (experience == null || experience.getFreelancerID() != jobseeker.getFreelancerID()) {
                session.setAttribute("errorMessage", "Experience not found or you don't have permission to delete it.");
                response.sendRedirect("jobseeker_detail.jsp");
                return;
            }
            
            // Delete the experience
            boolean success = experienceDAO.deleteExperience(experienceId, jobseeker.getFreelancerID());
            
            if (success) {
                // Update session with updated experience list
                List<Experience> experiences = experienceDAO.getExperienceByFreelancerID(jobseeker.getFreelancerID());
                session.setAttribute("experience", experiences);
                session.setAttribute("successMessage", "Work experience deleted successfully!");
            } else {
                session.setAttribute("errorMessage", "Failed to delete work experience. Please try again.");
            }
            
        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Invalid experience ID format.");
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
        }
        
        response.sendRedirect("jobseeker_detail.jsp");
    }

    private void addEducation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Jobseeker jobseeker = (Jobseeker) session.getAttribute("jobseeker");
        
        if (jobseeker == null) {
            session.setAttribute("errorMessage", "Please log in to add education");
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            // Get form parameters
            String universityName = request.getParameter("school").trim();
            String degreeName = request.getParameter("degree").trim();
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            boolean isCurrent = "on".equals(request.getParameter("current"));
            
            // Debug log form parameters
            System.out.println("Form parameters - universityName: " + universityName);
            System.out.println("Form parameters - degreeName: " + degreeName);
            System.out.println("Form parameters - startDate: " + startDateStr);
            System.out.println("Form parameters - endDate: " + endDateStr);
            System.out.println("Form parameters - isCurrent: " + isCurrent);
            
            // Validate required fields
            if (universityName.isEmpty() || degreeName.isEmpty() || startDateStr == null || startDateStr.trim().isEmpty()) {
                session.setAttribute("errorMessage", "University, degree, and start date are required fields.");
                response.sendRedirect("jobseeker_detail.jsp");
                return;
            }
            
            // Parse dates
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM");
            java.util.Date parsedStartDate = dateFormat.parse(startDateStr);
            Date startDate = new Date(parsedStartDate.getTime());
            
            // Handle end date (can be null if current education)
            Date endDate = null;
            if (!isCurrent && endDateStr != null && !endDateStr.trim().isEmpty()) {
                try {
                    java.util.Date parsedEndDate = dateFormat.parse(endDateStr);
                    endDate = new Date(parsedEndDate.getTime());
                    
                    // Validate that end date is after start date
                    if (endDate.before(startDate)) {
                        session.setAttribute("errorMessage", "End date must be after start date");
                        response.sendRedirect("jobseeker_detail.jsp");
                        return;
                    }
                } catch (ParseException e) {
                    session.setAttribute("errorMessage", "Invalid end date format. Please use YYYY-MM format.");
                    response.sendRedirect("jobseeker_detail.jsp");
                    return;
                }
            }
            
            // Get degree ID (simplified - in a real app, use DegreeDAO)
            int degreeId = getDegreeId(degreeName);
            
            // Create and save education
            Education education = new Education();
            education.setUniversityName(universityName);
            education.setStartDate(startDate);
            education.setEndDate(endDate); // Can be null for current education
            education.setFreelancerID(jobseeker.getFreelancerID());
            education.setDegreeID(degreeId);
            
            System.out.println("Creating education entry with: " + education);
            
            EducationDAO educationDAO = new EducationDAO();
            boolean success = educationDAO.addEducation(education);
            
            if (success) {
                // Refresh education list in session
                List<Education> educations = educationDAO.getEducationByFreelancerID(jobseeker.getFreelancerID());
                session.setAttribute("education", educations);
                session.setAttribute("successMessage", "Education added successfully!");
                System.out.println("Education added successfully");
            } else {
                session.setAttribute("errorMessage", "Failed to add education. Please try again.");
                System.err.println("Failed to add education to database");
            }
            
        } catch (ParseException e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Invalid date format. Please use YYYY-MM format.");
            System.err.println("Date parsing error: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "An error occurred while adding education: " + e.getMessage());
            System.err.println("Unexpected error: " + e.getMessage());
        }
        
        response.sendRedirect("jobseeker_detail.jsp");
    }

    /**
     * Helper method to get degree ID by name
     */
    private int getDegreeId(String degreeName) {
        // Simple mapping of Vietnamese degree names to IDs
        // In a real application, this should be handled by a DAO
        Map<String, Integer> degreeMap = new HashMap<>();
        degreeMap.put("Không yêu cầu", 1);
        degreeMap.put("Trung cấp", 2);
        degreeMap.put("Cao đẳng", 3);
        degreeMap.put("Đại học", 4);
        degreeMap.put("Thạc sĩ", 5);
        degreeMap.put("Tiến sĩ", 6);
        degreeMap.put("Chứng chỉ nghề", 7);
        
        // Return the ID or default to "Chứng chỉ nghề" if not found
        return degreeMap.getOrDefault(degreeName, 7);
    }
    
    private void updateEducation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String idParam = request.getParameter("id");
        String educationIdParam = request.getParameter("educationId");
        
        if (idParam == null || educationIdParam == null) {
            session.setAttribute("errorMessage", "Missing required parameters");
            response.sendRedirect("jobseeker_detail.jsp");
            return;
        }
        
        try {
            int id = Integer.parseInt(idParam);
            int educationId = Integer.parseInt(educationIdParam);
            
            // Get form parameters
            String school = request.getParameter("school");
            String degree = request.getParameter("degree");
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            String description = request.getParameter("description");
            boolean isCurrent = request.getParameter("current") != null;
            int degreeId = getDegreeId(degree);
            // Validate required fields
            if (school == null || school.trim().isEmpty() || 
                degree == null || startDateStr == null || startDateStr.trim().isEmpty()) {
                session.setAttribute("errorMessage", "Please fill in all required fields");
                response.sendRedirect("jobseeker_detail.jsp");
                return;
            }

            // Convert dates
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
            java.util.Date startDate = sdf.parse(startDateStr);
            java.util.Date endDate = null;
            
            if (!isCurrent && endDateStr != null && !endDateStr.isEmpty()) {
                endDate = sdf.parse(endDateStr);
            }
            
            // Get the existing education
            EducationDAO educationDAO = new EducationDAO();
            Education existingEdu = educationDAO.getEducationByID(educationId);
            
            if (existingEdu == null) {
                session.setAttribute("errorMessage", "Education record not found");
                response.sendRedirect("jobseeker_detail.jsp");
                return;
            }
            
            // Update the education
            existingEdu.setUniversityName(school);
            existingEdu.setDegreeID(degreeId);
            existingEdu.setStartDate(new java.sql.Date(startDate.getTime()));
            
            if (endDate != null) {
                existingEdu.setEndDate(new java.sql.Date(endDate.getTime()));
            } else {
                existingEdu.setEndDate(null);
            }
            
            // Update in database
            boolean success = educationDAO.updateEducation(existingEdu);
            
            if (success) {
                // Update session with updated education list
                List<Education> educationList = educationDAO.getEducationByFreelancerID(id);
                session.setAttribute("education", educationList);
                session.setAttribute("successMessage", "Cập nhật học vấn thành công!");
            } else {
                session.setAttribute("errorMessage", "Cập nhật học vấn thất bại. Vui lòng thử lại.");
            }
            
        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Invalid education ID format.");
            e.printStackTrace();
        } catch (ParseException e) {
            session.setAttribute("errorMessage", "Invalid date format. Please use YYYY-MM format.");
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
        }
        
        response.sendRedirect("jobseeker_detail.jsp");
    }

    private void deleteEducation(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    HttpSession session = request.getSession();
    int id = Integer.parseInt(request.getParameter("id"));
    
    
    try {
        int educationId = Integer.parseInt(request.getParameter("educationId"));
        int freelancerId = id;
        
        EducationDAO educationDAO = new EducationDAO();
        PrintWriter out = response.getWriter();
        out.print(freelancerId);
        
        
        boolean isDeleted = educationDAO.deleteEducation(educationId, freelancerId);
        
        if (isDeleted) {
            // Update the education list in session
            List<Education> educationList = educationDAO.getEducationByFreelancerID(freelancerId);
            session.setAttribute("education", educationList);
            session.setAttribute("successMessage", "Education deleted successfully!");
        } else {
            session.setAttribute("errorMessage", "Failed to delete education. Please try again.");
        }
        
    } catch (NumberFormatException e) {
        session.setAttribute("errorMessage", "Invalid education ID format");
        e.printStackTrace();
    } catch (Exception e) {
        e.printStackTrace();
        session.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
    }
    
    response.sendRedirect("jobseeker_detail.jsp");
}

    private void addSkill(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Jobseeker jobseeker = (Jobseeker) session.getAttribute("jobseeker");
        
        if (jobseeker == null) {
            session.setAttribute("errorMessage", "Please log in to add skills");
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            int skillSetId = Integer.parseInt(request.getParameter("skillSetId"));
            String proficiency = request.getParameter("proficiency");
            int level = 1; // Default level
            
            // Convert proficiency to level
            if (proficiency != null) {
                switch (proficiency.toLowerCase()) {
                    case "beginner":
                        level = 1;
                        break;
                    case "intermediate":
                        level = 2;
                        break;
                    case "advanced":
                        level = 3;
                        break;
                    case "expert":
                        level = 4;
                        break;
                }
            }
            
            // Check if skill already exists for this user
            SkillDAO skillDAO = new SkillDAO();
            if (skillDAO.doesSkillExistForFreelancer(jobseeker.getFreelancerID(), skillSetId)) {
                session.setAttribute("errorMessage", "You have already added this skill.");
                response.sendRedirect("jobseeker_detail.jsp");
                return;
            }
            
            // Create new skill
            Skill skill = new Skill();
            skill.setSkillSetID(skillSetId);
            skill.setFreelancerID(jobseeker.getFreelancerID());
            skill.setLevel(level);
            
            // Add skill to database
            boolean success = skillDAO.addSkillForFreelancer(skill);
            
            if (success) {
                // Update session with new skill list
                List<Skill> updatedSkills = skillDAO.getSkillsByFreelancerID(jobseeker.getFreelancerID());
                session.setAttribute("listSkill", updatedSkills);
                session.setAttribute("successMessage", "Skill added successfully!");
            } else {
                session.setAttribute("errorMessage", "Failed to add skill. Please try again.");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Invalid skill data provided.");
            e.printStackTrace();
        } catch (SQLException e) {
            session.setAttribute("errorMessage", "Database error: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            session.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            e.printStackTrace();
        }
        
        response.sendRedirect("jobseeker_detail.jsp");
    }

    private void updateSkill(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Jobseeker jobseeker = (Jobseeker) session.getAttribute("jobseeker");
        
        if (jobseeker == null) {
            session.setAttribute("errorMessage", "Please log in to update skills");
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            int skillId = Integer.parseInt(request.getParameter("skillId"));
            int level = Integer.parseInt(request.getParameter("level"));
            
            // Verify the skill belongs to the current user
            SkillDAO skillDAO = new SkillDAO();
            Skill skill = skillDAO.getSkillById(skillId);
            
            if (skill == null) {
                session.setAttribute("errorMessage", "Skill not found.");
            } else if (skill.getFreelancerID() != jobseeker.getFreelancerID()) {
                session.setAttribute("errorMessage", "You are not authorized to update this skill.");
            } else {
                // Update skill level
                skill.setLevel(level);
                boolean success = skillDAO.updateSkillLevelForFreelancer(skill);
                
                if (success) {
                    // Update session with updated skill list
                    List<Skill> updatedSkills = skillDAO.getSkillsByFreelancerID(jobseeker.getFreelancerID());
                    session.setAttribute("listSkill", updatedSkills);
                    session.setAttribute("successMessage", "Skill updated successfully!");
                } else {
                    session.setAttribute("errorMessage", "Failed to update skill. Please try again.");
                }
            }
        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Invalid skill data provided.");
            e.printStackTrace();
        } catch (SQLException e) {
            session.setAttribute("errorMessage", "Database error: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            session.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            e.printStackTrace();
        }
        
        response.sendRedirect("jobseeker_detail.jsp");
    }
    
    private void deleteSkill(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Jobseeker jobseeker = (Jobseeker) session.getAttribute("jobseeker");
        
        if (jobseeker == null) {
            session.setAttribute("errorMessage", "Please log in to delete skills");
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            int skillId = Integer.parseInt(request.getParameter("skillId"));
            
            // Verify the skill belongs to the current user
            SkillDAO skillDAO = new SkillDAO();
            Skill skill = skillDAO.getSkillById(skillId);
            
            if (skill == null) {
                session.setAttribute("errorMessage", "Skill not found.");
            } else if (skill.getFreelancerID() != jobseeker.getFreelancerID()) {
                session.setAttribute("errorMessage", "You are not authorized to delete this skill.");
            } else {
                // Delete the skill
                boolean success = skillDAO.deleteSkillForFreelancer(skillId);
                
                if (success) {
                    // Update session with updated skill list
                    List<Skill> updatedSkills = skillDAO.getSkillsByFreelancerID(jobseeker.getFreelancerID());
                    session.setAttribute("listSkill", updatedSkills);
                    session.setAttribute("successMessage", "Skill deleted successfully!");
                } else {
                    session.setAttribute("errorMessage", "Failed to delete skill. Please try again.");
                }
            }
        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Invalid skill ID");
            e.printStackTrace();
        } catch (SQLException e) {
            session.setAttribute("errorMessage", "Database error: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            session.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            e.printStackTrace();
        }
        
        response.sendRedirect("jobseeker_detail.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("get-experience".equals(action)) {
            getExperience(request, response);
        } else {
            processRequest(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    private void getExperience(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Jobseeker jobseeker = (Jobseeker) session.getAttribute("jobseeker");
        
        if (jobseeker == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"error\":\"Not logged in\"}");
            return;
        }
        
        try {
            int experienceId = Integer.parseInt(request.getParameter("id"));
            ExperienceDAO experienceDAO = new ExperienceDAO();
            Experience experience = experienceDAO.getExperienceByID(experienceId);
            
            // Verify ownership
            if (experience == null || experience.getFreelancerID() != jobseeker.getFreelancerID()) {
                response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                response.getWriter().write("{\"error\":\"Experience not found or access denied\"}");
                return;
            }
            
            // Convert to JSON
            String json = String.format(
                "{\"experienceID\":%d,\"experienceWorkName\":\"%s\"," +
                "\"position\":\"%s\",\"startDate\":\"%s\"," +
                "\"endDate\":%s,\"yourProject\":%s,\"freelancerID\":%d}",
                experience.getExperienceID(),
                escapeJson(experience.getExperienceWorkName()),
                escapeJson(experience.getPosition()),
                experience.getStartDate().toString(),
                experience.getEndDate() != null ? "\"" + experience.getEndDate().toString() + "\"" : "null",
                experience.getYourProject() != null ? "\"" + escapeJson(experience.getYourProject()) + "\"" : "null",
                experience.getFreelancerID()
            );
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json);
            
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\":\"Invalid experience ID\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"Internal server error\"}");
        }
    }
    
    private String escapeJson(String input) {
        if (input == null) {
            return "";
        }
        return input.replace("\\", "\\\\")
                   .replace("\"", "\\\"")
                   .replace("\n", "\\n")
                   .replace("\r", "\\r")
                   .replace("\t", "\\t");
    }

    @Override
    public String getServletInfo() {
        return "Handles all jobseeker profile operations";
    }
    
    private void changeAvatar(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Jobseeker jobseeker = (Jobseeker) session.getAttribute("jobseeker");
        
        if (jobseeker == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            // Get the base path of the web application
            String appPath = request.getServletContext().getRealPath("");
            
            // Create the img/Jobseeker directory if it doesn't exist
            String uploadsDir = appPath + "img" + File.separator + "Jobseeker";
            File uploadDir = new File(uploadsDir);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            
            // Process file upload
            Part filePart = request.getPart("avatar");
            if (filePart != null && filePart.getSize() > 0) {
                // Get the file extension
                String fileName = filePart.getSubmittedFileName();
                String fileExtension = "";
                if (fileName != null && fileName.contains(".")) {
                    fileExtension = fileName.substring(fileName.lastIndexOf("."));
                }
                
                // Generate a unique filename
                String newFileName = "avatar_" + jobseeker.getFreelancerID() + "_" + System.currentTimeMillis() + fileExtension;
                String filePath = uploadsDir + File.separator + newFileName;
                
                // Delete old avatar if exists
                if (jobseeker.getImage() != null && !jobseeker.getImage().isEmpty()) {
                    String oldImagePath = appPath + jobseeker.getImage().replace("/", File.separator);
                    File oldFile = new File(oldImagePath);
                    if (oldFile.exists()) {
                        oldFile.delete();
                    }
                }
                
                // Save the new avatar
                try (InputStream fileContent = filePart.getInputStream()) {
                    Files.copy(fileContent, new File(filePath).toPath(), StandardCopyOption.REPLACE_EXISTING);
                    
                    // Update the avatar path in the database (relative path)
                    String avatarPath = "img/Jobseeker/" + newFileName;
                    JobseekerDAO jobseekerDAO = new JobseekerDAO();
                    boolean success = jobseekerDAO.updateAvatar(jobseeker.getFreelancerID(), avatarPath);
                    
                    if (success) {
                        // Update the session
                        jobseeker.setImage(avatarPath);
                        session.setAttribute("jobseeker", jobseeker);
                        session.setAttribute("successMessage", "Cập nhật ảnh đại diện thành công!");
                    } else {
                        session.setAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật ảnh đại diện");
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                    session.setAttribute("errorMessage", "Lỗi khi lưu ảnh: " + e.getMessage());
                }
            } else {
                session.setAttribute("errorMessage", "Vui lòng chọn ảnh đại diện");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
        }
        
        response.sendRedirect("JobseekerDetailController");
    }
}
