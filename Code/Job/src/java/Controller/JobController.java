package Controller;

import DAO.PostDAO;
import DAO.CategoryDAO;
import DAO.JobTypeDAO;
import DAO.DurationDAO;
import DAO.FreelancerFavoriteDAO;
import Model.Post;
import Model.Category;
import Model.JobType;
import Model.Duration;
import Model.UserLoginInfo;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "JobController", urlPatterns = {"/jobs"})
public class JobController extends HttpServlet {
    
    private PostDAO postDAO;
    private CategoryDAO categoryDAO;
    private JobTypeDAO jobTypeDAO;
    private DurationDAO durationDAO;
    private FreelancerFavoriteDAO favoriteDAO;
    
    @Override
    public void init() {
        postDAO = new PostDAO();
        categoryDAO = new CategoryDAO();
        jobTypeDAO = new JobTypeDAO();
        durationDAO = new DurationDAO();
        favoriteDAO = new FreelancerFavoriteDAO();
        System.out.println("JobController initialized");
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "add":
                addFavorite(request, response);
                break;
            case "list":
                showJobList(request, response);
                break;
            case "search":
                searchJobs(request, response);
                break;
            default:
                showJobList(request, response);
                break;
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
    
    private void addFavorite(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String redirectUrl = request.getHeader("referer");
        if (redirectUrl == null || redirectUrl.isEmpty()) {
            redirectUrl = "jobs";
        }
        
        try {
            int jobseekerID = Integer.parseInt(request.getParameter("jobseekerID"));
            int postID = Integer.parseInt(request.getParameter("postID"));
            
            // Kiểm tra xem đã favorite chưa
            if (favoriteDAO.isFavorite(jobseekerID, postID)) {
                session.setAttribute("message", "Bài viết đã có trong danh sách yêu thích");
                session.setAttribute("messageType", "warning");
                response.sendRedirect("jobs?action=list");
                return;
            }
            
            boolean success = favoriteDAO.addFavorite(jobseekerID, postID);
            
            if (success) {
                session.setAttribute("message", "Đã thêm vào danh sách yêu thích thành công");
                session.setAttribute("messageType", "success");
            } else {
                session.setAttribute("message", "Không thể thêm vào danh sách yêu thích");
                session.setAttribute("messageType", "danger");
            }
            
            response.sendRedirect("jobs?action=list");
            
        } catch (NumberFormatException e) {
            session.setAttribute("message", "ID bài viết không hợp lệ");
            session.setAttribute("messageType", "danger");
            response.sendRedirect("jobs?action=list");
        } catch (Exception e) {
            System.err.println("Error adding favorite: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("message", "Đã xảy ra lỗi khi xử lý yêu cầu");
            session.setAttribute("messageType", "danger");
            response.sendRedirect("jobs?action=list");
        }
    }
    private void showJobList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            List<Post> jobs = postDAO.getAllApprovedPosts();
            
            List<Category> categories = categoryDAO.getAllActiveCategories();
            List<JobType> jobTypes = jobTypeDAO.getAllJobTypes();
            List<Duration> durations = durationDAO.getAllDurations();
            
            HttpSession session = request.getSession();
            UserLoginInfo user = (UserLoginInfo) session.getAttribute("user");
            List<Integer> favoritePostIds = null;
            
            if (user != null && "freelancer".equals(user.getUserType())) {
                favoritePostIds = favoriteDAO.getFavoritePostIds(user.getUserID());
            }
            
            request.setAttribute("jobs", jobs);
            request.setAttribute("categories", categories);
            request.setAttribute("jobTypes", jobTypes);
            request.setAttribute("durations", durations);
            request.setAttribute("favoritePostIds", favoritePostIds);
            request.setAttribute("totalJobs", jobs.size());
            
            request.getRequestDispatcher("/jobs_list.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Error showing job list: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Unable to load jobs. Please try again.");
            request.getRequestDispatcher("/jobs_list.jsp").forward(request, response);
        }
    }
    
    private void searchJobs(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String keyword = request.getParameter("keyword");
            String location = request.getParameter("location");
            String categoryId = request.getParameter("categoryId");
            String jobTypeId = request.getParameter("jobTypeId");
            String minBudget = request.getParameter("minBudget");
            String maxBudget = request.getParameter("maxBudget");
            
            List<Post> jobs = postDAO.getAllApprovedPosts();
            
            if (keyword != null && !keyword.trim().isEmpty()) {
                jobs = jobs.stream()
                    .filter(job -> job.getTitle().toLowerCase().contains(keyword.toLowerCase()) ||
                                  job.getDescription().toLowerCase().contains(keyword.toLowerCase()))
                    .collect(java.util.stream.Collectors.toList());
            }
            
            if (location != null && !location.trim().isEmpty()) {
                jobs = jobs.stream()
                    .filter(job -> job.getLocation().toLowerCase().contains(location.toLowerCase()))
                    .collect(java.util.stream.Collectors.toList());
            }
            
            if (categoryId != null && !categoryId.trim().isEmpty()) {
                try {
                    int catId = Integer.parseInt(categoryId);
                    jobs = jobs.stream()
                        .filter(job -> job.getCategoryId() == catId)
                        .collect(java.util.stream.Collectors.toList());
                } catch (NumberFormatException e) {
                    
                }
            }
            
            if (jobTypeId != null && !jobTypeId.trim().isEmpty()) {
                try {
                    int typeId = Integer.parseInt(jobTypeId);
                    jobs = jobs.stream()
                        .filter(job -> job.getJobTypeId() == typeId)
                        .collect(java.util.stream.Collectors.toList());
                } catch (NumberFormatException e) {
                   
                }
            }
            
            List<Category> categories = categoryDAO.getAllActiveCategories();
            List<JobType> jobTypes = jobTypeDAO.getAllJobTypes();
            List<Duration> durations = durationDAO.getAllDurations();
            
            HttpSession session = request.getSession();
            UserLoginInfo user = (UserLoginInfo) session.getAttribute("user");
            List<Integer> favoritePostIds = null;
            
            if (user != null && "freelancer".equals(user.getUserType())) {
                favoritePostIds = favoriteDAO.getFavoritePostIds(user.getUserID());
            }
            
            request.setAttribute("jobs", jobs);
            request.setAttribute("categories", categories);
            request.setAttribute("jobTypes", jobTypes);
            request.setAttribute("durations", durations);
            request.setAttribute("favoritePostIds", favoritePostIds);
            request.setAttribute("totalJobs", jobs.size());
            request.setAttribute("searchKeyword", keyword);
            request.setAttribute("searchLocation", location);
            request.setAttribute("searchCategoryId", categoryId);
            request.setAttribute("searchJobTypeId", jobTypeId);
            
            request.getRequestDispatcher("/jobs_list.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Error searching jobs: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Unable to search jobs. Please try again.");
            request.getRequestDispatcher("/jobs_list.jsp").forward(request, response);
        }
    }
}
