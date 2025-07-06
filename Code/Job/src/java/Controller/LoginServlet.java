package Controller;

import DAO.EducationDAO;
import DAO.ExperienceDAO;
import DAO.FreelancerFavoriteDAO;
import DAO.JobseekerDAO;
import DAO.SkillDAO;
import DAO.loginDAO;
import DAO.CompanyDAO;
import DAO.RecruiterTransactionDAO;
import Model.Company;
import Model.UserLoginInfo;
import Model.Category;
import Model.Duration;
import DAO.DurationDAO;
import DAO.CategoryDAO;
import DAO.JobTypeDAO;
import Model.JobType;
import Model.RecruiterTransaction;
import Model.Notification;
import DAO.NotificationDAO;
import DAO.AccountTierDAO;
import Model.AccountTier;
import DAO.PostDAO;
import Model.Post;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import Model.Jobseeker;
import Model.Recruiter;
import Model.Admin;
import Model.SkillSet;
import Model.FreelancerLocation;
import Model.Education;
import Model.Experience;
import Model.Skill;
import java.util.ArrayList;
import java.util.List;
import Model.UserTierSubscriptions;
import DAO.UserTierSubscriptionDAO;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userIdentifier = request.getParameter("usernameOrEmail");
        String passwordInput = request.getParameter("password");

        if (userIdentifier == null || userIdentifier.trim().isEmpty() ||
            passwordInput == null || passwordInput.trim().isEmpty()) { 
            request.setAttribute("error", "Tên đăng nhập/Email và mật khẩu không được để trống!"); 
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        loginDAO dao = new loginDAO();
        Jobseeker jobseeker = dao.loginUserByJobseeker(userIdentifier, passwordInput);
        Recruiter recruiter = dao.loginUserByRecruiter(userIdentifier, passwordInput);
        Admin admin = dao.loginUserByAdmin(userIdentifier, passwordInput);
        
        HttpSession session = request.getSession();
        
        
        if (jobseeker != null) {
            session.setAttribute("jobseeker", jobseeker);
            JobseekerDAO jobseekerDAO = new JobseekerDAO();
            EducationDAO educationDAO = new EducationDAO();
            ExperienceDAO experienceDAO = new ExperienceDAO();
            SkillDAO skillDAO = new SkillDAO();
            NotificationDAO notiDAO = new NotificationDAO();
            FreelancerFavoriteDAO favoriteDAO = new FreelancerFavoriteDAO();
            
            ArrayList<Education> education = educationDAO.getEducationByFreelancerID(jobseeker.getFreelancerID());
            ArrayList<Experience> experience = experienceDAO.getExperienceByFreelancerID(jobseeker.getFreelancerID());
            FreelancerLocation location = jobseekerDAO.getFreelancerLocationById(jobseeker.getFreelancerID());
            ArrayList<Skill> listSkill = skillDAO.getSkillByFreelancerID(jobseeker.getFreelancerID());
            ArrayList<SkillSet> skillSet = skillDAO.getAllSkillSets();
            int number = notiDAO.countNotificationsByFreelancerId(jobseeker.getFreelancerID());
            int count = favoriteDAO.getFavoriteCount(jobseeker.getFreelancerID());
            ArrayList<Notification> listNoti = notiDAO.getUnreadNotificationsForFreelancer(jobseeker.getFreelancerID());
            ArrayList<Notification> allNoti = notiDAO.getNotificationsForFreelancer(jobseeker.getFreelancerID());
                    PrintWriter out = response.getWriter();out.print(listNoti);
           
            session.setAttribute("count", count);
            session.setAttribute("listNoti", listNoti);
            session.setAttribute("allNoti", allNoti);
            session.setAttribute("number", number);
            session.setAttribute("education", education);
            session.setAttribute("experience", experience);
            session.setAttribute("location", location);
             session.setAttribute("listSkill", listSkill);
             session.setAttribute("skillSet", skillSet);
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } else if (recruiter != null) {
            CompanyDAO companyDAO = new CompanyDAO(); 
            UserTierSubscriptionDAO userTierDAO = new UserTierSubscriptionDAO();
            RecruiterTransactionDAO recruiterTransactionDAO  = new RecruiterTransactionDAO();
            PostDAO postDAO = new PostDAO();
            AccountTierDAO accountDAO = new AccountTierDAO();
            CategoryDAO categoryDAO = new CategoryDAO();
            JobTypeDAO jobTypeDAO = new JobTypeDAO();
            DurationDAO durationDAO = new DurationDAO();
            NotificationDAO notiDAO = new NotificationDAO();
            
            ArrayList<UserTierSubscriptions> userTier = userTierDAO.getActiveSubscriptionsByRecruiter(recruiter.getRecruiterID());
            Company company = companyDAO.getCompanyByRecruiterId(recruiter.getRecruiterID());
            List<RecruiterTransaction> recruiterTransaction = recruiterTransactionDAO.getTransactionsByRecruiter(recruiter.getRecruiterID());
            List<Post> post = postDAO.getPostsActiveByRecruiterId(recruiter.getRecruiterID());
            
            List<Category> category = categoryDAO.getAllActiveCategories();
            session.setAttribute("category", category);
            
            
            List<JobType> jobType = jobTypeDAO.getAllJobTypes();
            session.setAttribute("jobType", jobType);
            
            List<Duration> durations = durationDAO.getAllDurations();
            session.setAttribute("durations", durations);
            //Notification
            int number = notiDAO.countNotificationsByRecruiterId(recruiter.getRecruiterID());
            session.setAttribute("number", number);
            
            ArrayList<Notification> listNoti = notiDAO.getUnreadNotificationsForRecruiter(recruiter.getRecruiterID());
            session.setAttribute("listNoti", listNoti);
            
            ArrayList<Notification> allNoti = notiDAO.getNotificationsForRecruiter(recruiter.getRecruiterID());
            session.setAttribute("allNoti", allNoti);
            
            // Post 
            List<Post> allPost = postDAO.getPostsByRecruiterId(recruiter.getRecruiterID());
            List<Post> apporvePost = postDAO.getApprovedPosts(recruiter.getRecruiterID());
            List<Post> numberApply = postDAO.getPostWithApplicationCountsByRecruiter(recruiter.getRecruiterID());
            List<Post> pendingPost = postDAO.getPendingPosts(recruiter.getRecruiterID());
            List<Post> draftPost = postDAO.getDraftPosts(recruiter.getRecruiterID());
            List<Post> rejectPost = postDAO.getRejectedPosts(recruiter.getRecruiterID());
            session.setAttribute("apporvePost", apporvePost);
            session.setAttribute("numberApply", numberApply);
            session.setAttribute("allPost", allPost);
            session.setAttribute("pendingPost", pendingPost);
            session.setAttribute("draftPost", draftPost);
            session.setAttribute("rejectPost", rejectPost);
            if (userTier != null && !userTier.isEmpty()) {
                AccountTier account = accountDAO.getTierById(userTier.get(0).getTierID());
                session.setAttribute("account", account);
                PrintWriter out = response.getWriter();out.print(account.getTierName());
            }
            
            
            
            session.setAttribute("recruiter", recruiter);
            session.setAttribute("company", company);
            
            session.setAttribute("userTier", userTier);
            session.setAttribute("recruiterTransaction", recruiterTransaction);
            session.setAttribute("post", post);
            
            response.sendRedirect(request.getContextPath() + "/index_recruiter.jsp");
        } else if (admin != null) {
            PostDAO postDAO = new PostDAO();
            List<Post> post = postDAO.getAllPostsExceptApproved();
            session.setAttribute("post", post);
            session.setAttribute("admin", admin);
            response.sendRedirect(request.getContextPath() + "/admin.jsp");
        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}