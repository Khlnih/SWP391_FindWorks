/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import DAO.PostDAO;
import Model.Post;
import Model.Notification;
import DAO.NotificationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminPostController", urlPatterns = {"/AdminPostController"})
public class AdminPostController extends HttpServlet {
    
    private final PostDAO postDAO = new PostDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        if (action == null || action.isEmpty()) {
            // Lấy danh sách bài đăng chưa được duyệt
            List<Post> post = postDAO.getAllPostsExceptApproved();
            request.setAttribute("post", post);
            request.getRequestDispatcher("admin_post.jsp").forward(request, response);
            return;
        }

        switch (action) {
            case "request":
                handlePostAction(request, response);
                break;
            default:
                // Mặc định chuyển về trang admin_post.jsp nếu action không hợp lệ
                List<Post> posts = postDAO.getAllPostsExceptApproved();
                request.setAttribute("posts", posts);
                request.getRequestDispatcher("admin_post.jsp").forward(request, response);
                break;
        }
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
    
    private void handlePostAction(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            NotificationDAO notiDAO = new NotificationDAO();
            int postID = Integer.parseInt(request.getParameter("postID"));
            String status = request.getParameter("status");
            int recruiterID = Integer.parseInt(request.getParameter("recruiterID"));
            String mess = "";
            if(status.equals("Approved")){
                mess = "Bài đăng của bạn đã được cập nhập";
            }else{
                 mess = "Bài đăng của bạn đã bị từ chối. Mong bạn kiểm tra.";
            }
            String notiType = "PostStatus";
            notiDAO.addRecruiterNotification(recruiterID, mess, notiType);
            boolean success = postDAO.updateStatus(postID, status);
            
            List<Post> updatedPosts = postDAO.getAllPostsExceptApproved();
            
            session.setAttribute("post", updatedPosts);
            
            // Đặt thông báo tương ứng
            if (success) {
                session.setAttribute("message", "Cập nhật trạng thái thành công!");
            } else {
                session.setAttribute("error", "Có lỗi xảy ra khi cập nhật trạng thái");
            }
            
            response.sendRedirect(request.getContextPath() + "/admin_post.jsp");
            return;
            
                      
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi: " + e.getMessage());
            try {
                List<Post> posts = postDAO.getAllPostsExceptApproved();
                request.setAttribute("posts", posts);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            request.getRequestDispatcher("admin_post.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Admin Post Controller";
    }
}
