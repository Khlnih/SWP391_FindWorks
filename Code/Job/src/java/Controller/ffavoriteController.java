/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import DAO.CategoryDAO;
import DAO.DurationDAO;
import DAO.FreelancerFavoriteDAO;
import DAO.JobTypeDAO;
import Model.UserTierSubscriptions;
import DAO.UserTierSubscriptionDAO;
import Model.Category;
import Model.Duration;
import Model.FreelancerFavorite;
import Model.Notification;
import DAO.NotificationDAO;
import Model.JobType;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ADMIN
 */
@WebServlet(name="ffavoriteController", urlPatterns={"/ffavoriteController"})
public class ffavoriteController extends HttpServlet {
   private FreelancerFavoriteDAO favoriteDAO = new FreelancerFavoriteDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();
    private JobTypeDAO jobTypeDAO = new JobTypeDAO();
    private DurationDAO durationDAO = new DurationDAO();
    private UserTierSubscriptionDAO userDAO = new UserTierSubscriptionDAO();
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "list":
                showFavoriteList(request, response);
                break;   
            case "delete":
                deleteFavorite(request, response);
                break;
            case "readFavo":
                readNotification(request, response);
                break;
            case "deleteFavo":
                deleteNotification(request, response);
                break;
            case "register":
                registerAccountTier(request, response);
                break;
            default:
                showFavoriteList(request, response);
                break;
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }
    
    private void readNotification(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            int jobseekerID = Integer.parseInt(request.getParameter("jobseekerID"));
            int notiID = Integer.parseInt(request.getParameter("notiID"));
            NotificationDAO notiDAO = new NotificationDAO();
            boolean success = notiDAO.markAllNotificationsAsRead(jobseekerID,notiID);
            int number = notiDAO.countNotificationsByFreelancerId(jobseekerID);
            ArrayList<Notification> listNoti = notiDAO.getUnreadNotificationsForFreelancer(jobseekerID);
            ArrayList<Notification> allNoti = notiDAO.getNotificationsForFreelancer(jobseekerID);
                    PrintWriter out = response.getWriter();out.print(listNoti);
            session.setAttribute("listNoti", listNoti);
            session.setAttribute("allNoti", allNoti);
            session.setAttribute("number", number);
            if (success) {
                
                response.sendRedirect("jobseeker_notification.jsp"); // chuyển lại trang danh sách yêu thích
            } else {
                request.setAttribute("error", "Xóa thất bại!");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi xử lý yêu cầu xóa!");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
    private void deleteNotification(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            int jobseekerID = Integer.parseInt(request.getParameter("jobseekerID"));
            int notiID = Integer.parseInt(request.getParameter("notiID"));
            NotificationDAO notiDAO = new NotificationDAO();
            boolean success = notiDAO.markAllNotificationsAsDeleted(jobseekerID,notiID);
            int number = notiDAO.countNotificationsByFreelancerId(jobseekerID);
            ArrayList<Notification> listNoti = notiDAO.getUnreadNotificationsForFreelancer(jobseekerID);
            ArrayList<Notification> allNoti = notiDAO.getNotificationsForFreelancer(jobseekerID);
            session.setAttribute("listNoti", listNoti);
            session.setAttribute("allNoti", allNoti);
            session.setAttribute("number", number);
            if (success) {
                
                response.sendRedirect("jobseeker_notification.jsp"); // chuyển lại trang danh sách yêu thích
            } else {
                request.setAttribute("error", "Xóa thất bại!");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi xử lý yêu cầu xóa!");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
    
    private void registerAccountTier(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int jobseekerID = Integer.parseInt(request.getParameter("jobseekerID"));
            int tierID = Integer.parseInt(request.getParameter("tierID"));
            int duration = Integer.parseInt(request.getParameter("duration"));
            boolean success = userDAO.insertUserTierSubscriptionWithOptionalDuration(jobseekerID, tierID, duration);

            if (success) {
                
                response.sendRedirect("jobseeker_accountTier.jsp"); // chuyển lại trang danh sách yêu thích
            } else {
                request.setAttribute("error", "Xóa thất bại!");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi xử lý yêu cầu xóa!");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
    private void deleteFavorite(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int freelancerID = Integer.parseInt(request.getParameter("userID"));
            int postID = Integer.parseInt(request.getParameter("postID"));

            boolean success = favoriteDAO.deleteFavorite(freelancerID, postID);

            if (success) {
                
                response.sendRedirect("ffavoriteController?action=list&userID=" + freelancerID); // chuyển lại trang danh sách yêu thích
            } else {
                request.setAttribute("error", "Xóa thất bại!");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi xử lý yêu cầu xóa!");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    private void showFavoriteList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Lấy userID từ request parameter
            int id = Integer.parseInt(request.getParameter("userID"));
            
            // Lấy danh sách yêu thích
            List<FreelancerFavorite> favorites = favoriteDAO.getFavoritesByFreelancer(id);
            
            // Lấy các dữ liệu cần thiết cho trang
            List<Category> categories = categoryDAO.getAllCategories();
            List<JobType> jobTypes = jobTypeDAO.getAllJobTypes();
            List<Duration> durations = durationDAO.getAllDurations();
            
            // Đặt các thuộc tính vào request
            request.setAttribute("favorites", favorites);
            request.setAttribute("categories", categories);
            request.setAttribute("jobTypes", jobTypes);
            request.setAttribute("durations", durations);
            request.setAttribute("favoriteCount", favorites.size());
            
            // Chuyển tiếp đến trang hiển thị
            request.getRequestDispatcher("/favorite_jobs.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            // Xử lý lỗi khi userID không hợp lệ
            request.setAttribute("error", "Invalid user ID");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } catch (Exception e) {
            // Xử lý các lỗi khác
            System.err.println("Error showing favorite list: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Unable to load favorite jobs. Please try again.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
