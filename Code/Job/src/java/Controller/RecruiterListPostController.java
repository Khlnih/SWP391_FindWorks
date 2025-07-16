/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;
import Model.JobApply;
import DAO.JobApplyDAO;
import DAO.NotificationDAO;
import Model.Post;
import DAO.PostDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 *
 * @author ADMIN
 */
@WebServlet(name="RecruiterListPostController", urlPatterns={"/RecruiterListPostController"})
public class RecruiterListPostController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        if (action == null) {
            action = "dashboard";
        }
        switch (action) {
            case "dashboard":
                request.getRequestDispatcher("admin.jsp").forward(request, response);
                break;
            case "changeStatusApply":
                changeStatusApply(request, response);
                break;
            case "updatePost":
                updatePost(request, response);
                break;
            case "editPost":
                editPost(request, response);
                break;
            case "messageNoti":
                messageNoti(request, response);
                break;
            case "show_applyPost":
                showApplyPost(request, response);
                break;
            
            default:
                request.getRequestDispatcher("admin.jsp").forward(request, response);
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
    private void updatePost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // 1. Lấy dữ liệu từ form
            int postID = Integer.parseInt(request.getParameter("postID"));
            String title = request.getParameter("title");
            String recruiterID = request.getParameter("recruiterID");
            int jobTypeId = Integer.parseInt(request.getParameter("jobTypeId"));
            int durationId = Integer.parseInt(request.getParameter("durationId"));

            String datePostStr = request.getParameter("datePost");
            String expiredDateStr = request.getParameter("expiredDate");

            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String location = request.getParameter("location");
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            String budgetType = request.getParameter("budgetType");
            String description = request.getParameter("description");

            // Budget
            String budgetMinStr = request.getParameter("budgetMin");
            String budgetMaxStr = request.getParameter("budgetMax");

            BigDecimal budgetMin = (budgetMinStr == null || budgetMinStr.isEmpty())
                    ? null
                    : new BigDecimal(budgetMinStr);
            BigDecimal budgetMax = (budgetMaxStr == null || budgetMaxStr.isEmpty())
                    ? null
                    : new BigDecimal(budgetMaxStr);

            // 2. Parse Date
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date datePost = (datePostStr != null && !datePostStr.isEmpty()) ? sdf.parse(datePostStr) : new Date();
            Date expiredDate = (expiredDateStr != null && !expiredDateStr.isEmpty()) ? sdf.parse(expiredDateStr) : null;

            // 3. Tạo Post object
            Post post = new Post();
            post.setPostId(postID);
            post.setTitle(title);
            post.setJobTypeId(jobTypeId);
            post.setDurationId(durationId);
            post.setDatePost(datePost);
            post.setExpiredDate(expiredDate);
            post.setQuantity(quantity);
            post.setLocation(location);
            post.setCategoryId(categoryId);
            post.setBudgetType(budgetType);
            post.setDescription(description);
            post.setBudgetMin(budgetMin);
            post.setBudgetMax(budgetMax);

            // 4. Gọi DAO
            PostDAO postDAO = new PostDAO();
            boolean success = postDAO.updatePostByID(post);

            // 5. Điều hướng
            if (success) {
                request.setAttribute("message", "Cập nhật bài đăng thành công!");
            } else {
                request.setAttribute("message", "Cập nhật thất bại!");
            }
            HttpSession session = request.getSession();

            session.removeAttribute("apporvePost");
            session.removeAttribute("numberApply");
            session.removeAttribute("allPost");
            session.removeAttribute("pendingPost");
            session.removeAttribute("draftPost");
            session.removeAttribute("rejectPost");
            
            List<Post> allPost = postDAO.getPostsByRecruiterId(Integer.parseInt(recruiterID));
            List<Post> apporvePost = postDAO.getApprovedPosts(Integer.parseInt(recruiterID));
            List<Post> numberApply = postDAO.getPostWithApplicationCountsByRecruiter(Integer.parseInt(recruiterID));
            List<Post> pendingPost = postDAO.getPendingPosts(Integer.parseInt(recruiterID));
            List<Post> draftPost = postDAO.getDraftPosts(Integer.parseInt(recruiterID));
            List<Post> rejectPost = postDAO.getRejectedPosts(Integer.parseInt(recruiterID));
            session.setAttribute("apporvePost", apporvePost);
            session.setAttribute("numberApply", numberApply);
            session.setAttribute("allPost", allPost);
            session.setAttribute("pendingPost", pendingPost);
            session.setAttribute("draftPost", draftPost);
            session.setAttribute("rejectPost", rejectPost);

            
            
            // Có thể forward về trang chi tiết hoặc danh sách
            request.getRequestDispatcher("recruiter_listPost.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Lỗi trong quá trình xử lý: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    
    }
    
    private void editPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            
            String postID = request.getParameter("postID");
            String action = request.getParameter("action");
            
            PostDAO postDAO = new PostDAO();
            Post post = postDAO.getPostById(Integer.parseInt(postID));
            request.setAttribute("post", post);
            request.setAttribute("edit", "editPost");
            request.getRequestDispatcher("recruiter_postJob.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi khi gửi tin nhắn: " + e.getMessage());
            showApplyPost(request, response);
        }
    }
    
    private void messageNoti(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String applyID = request.getParameter("applyID");
            String postID = request.getParameter("postID");
            String freelancerID = request.getParameter("freelancerID");
            String message = request.getParameter("message");
            
            
            
           
             NotificationDAO notiDAO = new NotificationDAO();
             notiDAO.addFreelancerNotification(Integer.parseInt(freelancerID), message, "MESSAGE BY Recruiter");
            
            request.getSession().setAttribute("successMessage", "Đã gửi tin nhắn thành công!");
            response.sendRedirect("RecruiterListPostController?action=show_applyPost&postID=" + postID);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi khi gửi tin nhắn: " + e.getMessage());
            showApplyPost(request, response);
        }
    }
    
    private void changeStatusApply(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String applyID = request.getParameter("applyID");
            String newStatus = request.getParameter("mess");
            String postID = request.getParameter("postID");
            String freelancerID = request.getParameter("freelancerID");
            
            if (applyID == null || applyID.trim().isEmpty() || newStatus == null) {
                request.setAttribute("errorMessage", "Thiếu thông tin cần thiết để cập nhật trạng thái.");
                showApplyPost(request, response);
                return;
            }
            
            String statusToUpdate = "";
            switch(newStatus.toLowerCase()) {
                case "pending":
                    statusToUpdate = "Pending";
                    break;
                case "reject":
                    statusToUpdate = "Rejected";
                    break;
                case "complete":
                    statusToUpdate = "Completed";
                    break;
                default:
                    statusToUpdate = newStatus;
            }
            
            JobApplyDAO jobApplyDAO = new JobApplyDAO();
            boolean isUpdated = jobApplyDAO.updateStatusApply(Integer.parseInt(applyID), statusToUpdate);
            
            if (isUpdated) {
                request.getSession().setAttribute("successMessage", "Đã cập nhật trạng thái đơn ứng tuyển thành công!");
            } else {
                request.getSession().setAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật trạng thái. Vui lòng thử lại.");
            }
            
            // Redirect back to the same page with postID
            response.sendRedirect("RecruiterListPostController?action=show_applyPost&postID=" + postID);
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "ID đơn ứng tuyển không hợp lệ.");
            showApplyPost(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
    private void showApplyPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String postID = request.getParameter("postID");
            JobApplyDAO jobApplyDAO = new JobApplyDAO();
            PostDAO postDAO = new PostDAO();
            
            List<JobApply> listApply = jobApplyDAO.getJobAppliesByPostID(Integer.parseInt(postID));
            Post post = postDAO.getPostById(Integer.parseInt(postID));
            
            request.setAttribute("listApply", listApply);
            request.setAttribute("post", post);
            request.setAttribute("postID", postID);
            
            request.getRequestDispatcher("recruiter_applyJob.jsp").forward(request, response);
            
        }catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while processing your request");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
    
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
