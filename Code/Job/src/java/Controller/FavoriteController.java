package Controller;

import DAO.FreelancerFavoriteDAO;
import DAO.CategoryDAO;
import DAO.JobTypeDAO;
import DAO.DurationDAO;
import Model.FreelancerFavorite;
import Model.Category;
import Model.JobType;
import Model.Duration;
import Model.UserLoginInfo;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "FavoriteController", urlPatterns = {"/favorite"})
public class FavoriteController extends HttpServlet {
    
    private FreelancerFavoriteDAO favoriteDAO;
    private CategoryDAO categoryDAO;
    private JobTypeDAO jobTypeDAO;
    private DurationDAO durationDAO;
    
    @Override
    public void init() {
        favoriteDAO = new FreelancerFavoriteDAO();
        categoryDAO = new CategoryDAO();
        jobTypeDAO = new JobTypeDAO();
        durationDAO = new DurationDAO();
        System.out.println("FavoriteController initialized");
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "list":
                showFavoriteList(request, response);
                break;
            case "check":
                checkFavoriteStatus(request, response);
                break;
            default:
                showFavoriteList(request, response);
                break;
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action parameter is required");
            return;
        }
        
        switch (action) {
            case "remove":
                removeFavorite(request, response);
                break;
            case "toggle":
                toggleFavorite(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
                break;
        }
    }
    
    private void showFavoriteList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        int id = Integer.parseInt(request.getParameter("id"));
        
        try {
            List<FreelancerFavorite> favorites = favoriteDAO.getFavoritesByFreelancer(id);
            
            List<Category> categories = categoryDAO.getAllCategories();
            List<JobType> jobTypes = jobTypeDAO.getAllJobTypes();
            List<Duration> durations = durationDAO.getAllDurations();
            
            request.setAttribute("favorites", favorites);
            request.setAttribute("categories", categories);
            request.setAttribute("jobTypes", jobTypes);
            request.setAttribute("durations", durations);
            request.setAttribute("favoriteCount", favorites.size());
            
            request.getRequestDispatcher("/favorite_jobs.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Error showing favorite list: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Unable to load favorite jobs. Please try again.");
            request.getRequestDispatcher("/favorite_jobs.jsp").forward(request, response);
        }
    }
    
    
    
    
    
    private void removeFavorite(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        UserLoginInfo user = (UserLoginInfo) session.getAttribute("user");
        
        if (user == null || !"freelancer".equals(user.getUserType())) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"success\": false, \"message\": \"Please login as freelancer\"}");
            return;
        }
        
        try {
            int postID = Integer.parseInt(request.getParameter("postId"));
            
            boolean success = favoriteDAO.removeFavorite(user.getUserID(), postID);
            
            response.setContentType("application/json");
            if (success) {
                response.getWriter().write("{\"success\": true, \"message\": \"Removed from favorites\"}");
            } else {
                response.getWriter().write("{\"success\": false, \"message\": \"Failed to remove from favorites\"}");
            }
            
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\": false, \"message\": \"Invalid post ID\"}");
        } catch (Exception e) {
            System.err.println("Error removing favorite: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false, \"message\": \"Server error\"}");
        }
    }
    
   
    private void toggleFavorite(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        UserLoginInfo user = (UserLoginInfo) session.getAttribute("user");
        
        if (user == null || !"freelancer".equals(user.getUserType())) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"success\": false, \"message\": \"Please login as freelancer\"}");
            return;
        }
        
        try {
            int postID = Integer.parseInt(request.getParameter("postId"));
            
            boolean isFavorite = favoriteDAO.isFavorite(user.getUserID(), postID);
            boolean success;
            String message;
            
            if (isFavorite) {
                success = favoriteDAO.removeFavorite(user.getUserID(), postID);
                message = success ? "Removed from favorites" : "Failed to remove from favorites";
            } else {
                success = favoriteDAO.addFavorite(user.getUserID(), postID);
                message = success ? "Added to favorites" : "Failed to add to favorites";
            }
            
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": " + success + 
                                     ", \"message\": \"" + message + 
                                     "\", \"isFavorite\": " + !isFavorite + "}");
            
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\": false, \"message\": \"Invalid post ID\"}");
        } catch (Exception e) {
            System.err.println("Error toggling favorite: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false, \"message\": \"Server error\"}");
        }
    }
    
    
    private void checkFavoriteStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        UserLoginInfo user = (UserLoginInfo) session.getAttribute("user");
        
        if (user == null || !"freelancer".equals(user.getUserType())) {
            response.setContentType("application/json");
            response.getWriter().write("{\"isFavorite\": false}");
            return;
        }
        
        try {
            int postID = Integer.parseInt(request.getParameter("postId"));
            boolean isFavorite = favoriteDAO.isFavorite(user.getUserID(), postID);
            
            response.setContentType("application/json");
            response.getWriter().write("{\"isFavorite\": " + isFavorite + "}");
            
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Invalid post ID\"}");
        } catch (Exception e) {
            System.err.println("Error checking favorite status: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Server error\"}");
        }
    }
}
