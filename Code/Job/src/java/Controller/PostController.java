package Controller;

import DAO.PostDAO;
import DAO.CategoryDAO;
import DAO.JobTypeDAO;
import DAO.DurationDAO;
import Model.Post;
import Model.Category;
import Model.JobType;
import Model.Duration;
import Model.UserLoginInfo;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "PostController", urlPatterns = {"/post"})
public class PostController extends HttpServlet {
    
    private PostDAO postDAO;
    private CategoryDAO categoryDAO;
    private JobTypeDAO jobTypeDAO;
    private DurationDAO durationDAO;

    @Override
    public void init() {
        postDAO = new PostDAO();
        categoryDAO = new CategoryDAO();
        jobTypeDAO = new JobTypeDAO();
        durationDAO = new DurationDAO();
        System.out.println("PostController initialized with all DAOs");
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        
        try {
            switch (action) {
                case "list":
                    showMyPosts(request, response);
                    break;
                case "create":
                    showCreateForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deletePost(request, response);
                    break;
                case "view":
                    viewPost(request, response);
                    break;
                default:
                    showMyPosts(request, response);
            }
        } catch (Exception e) {
            System.err.println("PostController - Error: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect("post?action=list");
            return;
        }
        
        try {
            switch (action) {
                case "create":
                    createPost(request, response);
                    break;
                case "update":
                    updatePost(request, response);
                    break;
                default:
                    response.sendRedirect("post?action=list");
            }
        } catch (Exception e) {
            System.err.println("PostController - Error: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
    
    private void showMyPosts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        UserLoginInfo user = (UserLoginInfo) session.getAttribute("user");
        
        if (user == null || !"recruiter".equals(user.getUserType())) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        List<Post> posts = postDAO.getPostsByRecruiterId(user.getUserID());

        List<Category> categories = categoryDAO.getAllCategories();
        List<JobType> jobTypes = jobTypeDAO.getAllJobTypes();
        List<Duration> durations = durationDAO.getAllDurations();

        request.setAttribute("posts", posts);
        request.setAttribute("categories", categories);
        request.setAttribute("jobTypes", jobTypes);
        request.setAttribute("durations", durations);
        request.getRequestDispatcher("/manage_jobs.jsp").forward(request, response);
    }
    
    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserLoginInfo user = (UserLoginInfo) session.getAttribute("user");

        if (user == null || !"recruiter".equals(user.getUserType())) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Category> categories = categoryDAO.getAllActiveCategories();
        List<JobType> jobTypes = jobTypeDAO.getAllJobTypes();
        List<Duration> durations = durationDAO.getAllDurations();

        request.setAttribute("categories", categories);
        request.setAttribute("jobTypes", jobTypes);
        request.setAttribute("durations", durations);

        request.getRequestDispatcher("/post_job.jsp").forward(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        UserLoginInfo user = (UserLoginInfo) session.getAttribute("user");
        
        if (user == null || !"recruiter".equals(user.getUserType())) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String postIdStr = request.getParameter("id");
        if (postIdStr == null || postIdStr.trim().isEmpty()) {
            response.sendRedirect("post?action=list");
            return;
        }
        
        try {
            int postId = Integer.parseInt(postIdStr);
            Post post = postDAO.getPostById(postId);
            
            if (post == null || post.getRecruiterId() != user.getUserID()) {
                request.setAttribute("error", "Post not found or you don't have permission to edit it.");
                response.sendRedirect("post?action=list");
                return;
            }

            List<Category> categories = categoryDAO.getAllActiveCategories();
            List<JobType> jobTypes = jobTypeDAO.getAllJobTypes();
            List<Duration> durations = durationDAO.getAllDurations();

            request.setAttribute("post", post);
            request.setAttribute("categories", categories);
            request.setAttribute("jobTypes", jobTypes);
            request.setAttribute("durations", durations);

            request.getRequestDispatcher("/edit_job.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect("post?action=list");
        }
    }
    
    private void viewPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String postIdStr = request.getParameter("id");
        if (postIdStr == null || postIdStr.trim().isEmpty()) {
            response.sendRedirect("post?action=list");
            return;
        }
        
        try {
            int postId = Integer.parseInt(postIdStr);
            Post post = postDAO.getPostById(postId);
            
            if (post == null) {
                request.setAttribute("error", "Post not found.");
                response.sendRedirect("post?action=list");
                return;
            }
            
            Category category = categoryDAO.getCategoryById(post.getCategoryId());
            JobType jobType = jobTypeDAO.getJobTypeById(post.getJobTypeId());
            Duration duration = durationDAO.getDurationById(post.getDurationId());

            request.setAttribute("post", post);
            request.setAttribute("category", category);
            request.setAttribute("postIdStr", postIdStr);
            request.setAttribute("jobType", jobType);
            request.setAttribute("duration", duration);
            request.getRequestDispatcher("/view_job.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect("post?action=list");
        }
    }
    
    private void createPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        UserLoginInfo user = (UserLoginInfo) session.getAttribute("user");
        
        if (user == null || !"recruiter".equals(user.getUserType())) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            String title = request.getParameter("title");
            String image = request.getParameter("image");
            int jobTypeId = Integer.parseInt(request.getParameter("jobTypeId"));
            int durationId = Integer.parseInt(request.getParameter("durationId"));
            String expiredDateStr = request.getParameter("expiredDate");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String description = request.getParameter("description");
            String budgetMinStr = request.getParameter("budgetMin");
            String budgetMaxStr = request.getParameter("budgetMax");
            String budgetType = request.getParameter("budgetType");
            String location = request.getParameter("location");
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            
            if (title == null || title.trim().isEmpty()) {
                request.setAttribute("error", "Title is required.");
                request.getRequestDispatcher("/post_job.jsp").forward(request, response);
                return;
            }
            
            Date expiredDate = null;
            if (expiredDateStr != null && !expiredDateStr.trim().isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                expiredDate = sdf.parse(expiredDateStr);
            }
            
            BigDecimal budgetMin = null;
            BigDecimal budgetMax = null;
            if (budgetMinStr != null && !budgetMinStr.trim().isEmpty()) {
                budgetMin = new BigDecimal(budgetMinStr);
            }
            if (budgetMaxStr != null && !budgetMaxStr.trim().isEmpty()) {
                budgetMax = new BigDecimal(budgetMaxStr);
            }
            
            Post post = new Post(title, image, jobTypeId, durationId, expiredDate, quantity,
                               description, budgetMin, budgetMax, budgetType, location,
                               user.getUserID(), "Pending", categoryId);
            
            boolean success = postDAO.createPost(post);
            
            if (success) {
                session.setAttribute("message", "Job post created successfully!");
                response.sendRedirect("post?action=list");
            } else {
                request.setAttribute("error", "Failed to create job post. Please try again.");
                request.getRequestDispatcher("/post_job.jsp").forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid number format in form data.");
            request.getRequestDispatcher("/post_job.jsp").forward(request, response);
        } catch (ParseException e) {
            request.setAttribute("error", "Invalid date format. Please use YYYY-MM-DD format.");
            request.getRequestDispatcher("/post_job.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Error creating post: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while creating the post.");
            request.getRequestDispatcher("/post_job.jsp").forward(request, response);
        }
    }
    
    private void updatePost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        UserLoginInfo user = (UserLoginInfo) session.getAttribute("user");
        
        if (user == null || !"recruiter".equals(user.getUserType())) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            int postId = Integer.parseInt(request.getParameter("postId"));
            
            Post existingPost = postDAO.getPostById(postId);
            if (existingPost == null || existingPost.getRecruiterId() != user.getUserID()) {
                request.setAttribute("error", "Post not found or you don't have permission to edit it.");
                response.sendRedirect("post?action=list");
                return;
            }
            
            String title = request.getParameter("title");
            String image = request.getParameter("image");
            int jobTypeId = Integer.parseInt(request.getParameter("jobTypeId"));
            int durationId = Integer.parseInt(request.getParameter("durationId"));
            String expiredDateStr = request.getParameter("expiredDate");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String description = request.getParameter("description");
            String budgetMinStr = request.getParameter("budgetMin");
            String budgetMaxStr = request.getParameter("budgetMax");
            String budgetType = request.getParameter("budgetType");
            String location = request.getParameter("location");
            String statusPost = request.getParameter("statusPost");
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            
            if (title == null || title.trim().isEmpty()) {
                request.setAttribute("error", "Title is required.");
                request.setAttribute("post", existingPost);
                request.getRequestDispatcher("/edit_job.jsp").forward(request, response);
                return;
            }
            
            Date expiredDate = null;
            if (expiredDateStr != null && !expiredDateStr.trim().isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                expiredDate = sdf.parse(expiredDateStr);
            }
            
            BigDecimal budgetMin = null;
            BigDecimal budgetMax = null;
            if (budgetMinStr != null && !budgetMinStr.trim().isEmpty()) {
                budgetMin = new BigDecimal(budgetMinStr);
            }
            if (budgetMaxStr != null && !budgetMaxStr.trim().isEmpty()) {
                budgetMax = new BigDecimal(budgetMaxStr);
            }
            
            existingPost.setTitle(title);
            existingPost.setImage(image);
            existingPost.setJobTypeId(jobTypeId);
            existingPost.setDurationId(durationId);
            existingPost.setExpiredDate(expiredDate);
            existingPost.setQuantity(quantity);
            existingPost.setDescription(description);
            existingPost.setBudgetMin(budgetMin);
            existingPost.setBudgetMax(budgetMax);
            existingPost.setBudgetType(budgetType);
            existingPost.setLocation(location);
            existingPost.setStatusPost(statusPost);
            existingPost.setCategoryId(categoryId);
            
            boolean success = postDAO.updatePost(existingPost);
            
            if (success) {
                session.setAttribute("message", "Job post updated successfully!");
                response.sendRedirect("post?action=list");
            } else {
                request.setAttribute("error", "Failed to update job post. Please try again.");
                request.setAttribute("post", existingPost);
                request.getRequestDispatcher("/edit_job.jsp").forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid number format in form data.");
            response.sendRedirect("post?action=list");
        } catch (ParseException e) {
            request.setAttribute("error", "Invalid date format. Please use YYYY-MM-DD format.");
            response.sendRedirect("post?action=list");
        } catch (Exception e) {
            System.err.println("Error updating post: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while updating the post.");
            response.sendRedirect("post?action=list");
        }
    }
    
    private void deletePost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        UserLoginInfo user = (UserLoginInfo) session.getAttribute("user");
        
        if (user == null || !"recruiter".equals(user.getUserType())) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String postIdStr = request.getParameter("id");
        if (postIdStr == null || postIdStr.trim().isEmpty()) {
            response.sendRedirect("post?action=list");
            return;
        }
        
        try {
            int postId = Integer.parseInt(postIdStr);
            
            Post post = postDAO.getPostById(postId);
            if (post == null || post.getRecruiterId() != user.getUserID()) {
                session.setAttribute("error", "Post not found or you don't have permission to delete it.");
                response.sendRedirect("post?action=list");
                return;
            }
            
            boolean success = postDAO.deletePost(postId, user.getUserID());
            
            if (success) {
                session.setAttribute("message", "Job post deleted successfully!");
            } else {
                session.setAttribute("error", "Failed to delete job post. Please try again.");
            }
            
            response.sendRedirect("post?action=list");
            
        } catch (NumberFormatException e) {
            response.sendRedirect("post?action=list");
        } catch (Exception e) {
            System.err.println("Error deleting post: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("error", "An error occurred while deleting the post.");
            response.sendRedirect("post?action=list");
        }
    }
}
