package Controller;

import DAO.EducationDAO;
import DAO.ExperienceDAO;
import DAO.JobseekerDAO;
import DAO.JobseekerSkillDAO; // Sửa lại tên này nếu DAO kỹ năng của bạn có tên khác
import Model.Education;
import Model.Experience;
import Model.Jobseeker;
import Model.Skill;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "FreelancerDetailsServlet", urlPatterns = {"/freelancer-details"})
public class FreelancerDetailsServlet extends HttpServlet {

    private JobseekerDAO jobseekerDAO;
    private EducationDAO educationDAO;
    private ExperienceDAO experienceDAO;
    private JobseekerSkillDAO jobseekerSkillDAO;

    @Override
    public void init() throws ServletException {
        jobseekerDAO = new JobseekerDAO();
        educationDAO = new EducationDAO();
        experienceDAO = new ExperienceDAO();
        jobseekerSkillDAO = new JobseekerSkillDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idStr = request.getParameter("id");
        // Khi có lỗi, sẽ chuyển về trang danh sách freelancer chính
        String listPageURL = "freelancer_list"; 

        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect(listPageURL);
            return;
        }

        try {
            int freelancerId = Integer.parseInt(idStr);
            Jobseeker jobseeker = jobseekerDAO.getJobseekerById(freelancerId);

            if (jobseeker == null) {
                response.sendRedirect(listPageURL);
                return;
            }
            
            List<Education> educations = educationDAO.getEducationByFreelancerID(freelancerId);
            List<Experience> experiences = experienceDAO.getExperienceByFreelancerID(freelancerId);
            List<Skill> skills = jobseekerSkillDAO.getSkillsByFreelancerID(freelancerId);

            request.setAttribute("jobseeker", jobseeker);
            request.setAttribute("educations", educations);
            request.setAttribute("experiences", experiences);
            request.setAttribute("skills", skills);

            // Chuyển tiếp đến file freelancer_details.jsp
            request.getRequestDispatcher("freelancer_details.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(listPageURL);
        }
    }
}