package Controller;

import DAO.EducationDAO;
import DAO.ExperienceDAO;
import DAO.JobseekerDAO;
import DAO.SkillDAO;
import DAO.loginDAO;
import Model.UserLoginInfo;

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
            ArrayList<Education> education = educationDAO.getEducationByFreelancerID(jobseeker.getFreelancerID());
            ArrayList<Experience> experience = experienceDAO.getExperienceByFreelancerID(jobseeker.getFreelancerID());
            FreelancerLocation location = jobseekerDAO.getFreelancerLocationById(jobseeker.getFreelancerID());
            ArrayList<Skill> listSkill = skillDAO.getSkillByFreelancerID(jobseeker.getFreelancerID());
            ArrayList<SkillSet> skillSet = skillDAO.getAllSkillSets();
            session.setAttribute("education", education);
            session.setAttribute("experience", experience);
            session.setAttribute("location", location);
             session.setAttribute("listSkill", listSkill);
             session.setAttribute("skillSet", skillSet);
            PrintWriter out = response.getWriter(); out.print(skillSet);
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } else if (recruiter != null) {
            session.setAttribute("recruiter", recruiter);
            response.sendRedirect(request.getContextPath() + "/index_recruiter.jsp");
        } else if (admin != null) {
            session.setAttribute("admin", admin);
            response.sendRedirect(request.getContextPath() + "/admin.jsp");
        }
//        response.sendRedirect(request.getContextPath() + "/index.jsp");
//          String userIdentifier = request.getParameter("usernameOrEmail");
//        String passwordInput = request.getParameter("password");
//
//        if (userIdentifier == null || userIdentifier.trim().isEmpty() ||
//            passwordInput == null || passwordInput.trim().isEmpty()) { // SỬA Ở ĐÂY
//            request.setAttribute("error", "Tên đăng nhập/Email và mật khẩu không được để trống!"); // SỬA Ở ĐÂY
//            request.getRequestDispatcher("login.jsp").forward(request, response);
//            return;
//        }
//
//        loginDAO dao = new loginDAO();
//        UserLoginInfo user = dao.getUserLoginInfo(userIdentifier);
//        PrintWriter out = response.getWriter();
//        out.print(user);
//        // So sánh mật khẩu dạng thuần
//        if (user != null && user.getPassword().equals(passwordInput)) {
//            HttpSession session = request.getSession();
//            session.setAttribute("user", user); // lưu thông tin user vào session
//
//            String userType = user.getUserType();
//            if ("recruiter".equals(userType)) {
//                response.sendRedirect(request.getContextPath() + "/index_recruiter.jsp");
//            } else if ("freelancer".equals(userType)) {
//                response.sendRedirect(request.getContextPath() + "/index.jsp");
//            } else if ("admin".equals(userType)) {
//                response.sendRedirect(request.getContextPath() + "/admin_dashboard.jsp");
//            } else {
//                response.sendRedirect(request.getContextPath() + "/index.jsp");
//            }
//        } else {
//            System.out.println("Login failed for identifier: " + userIdentifier); // Thêm log để debug
//            request.setAttribute("error", "Tên đăng nhập/Email hoặc mật khẩu không chính xác!"); // SỬA Ở ĐÂY
//            request.getRequestDispatcher("login.jsp").forward(request, response);
//        }
//    
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}