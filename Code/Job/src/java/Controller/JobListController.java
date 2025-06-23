package Controller;

import DAO.PostDAO;
import Model.Post;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "JobListController", urlPatterns = { "/jobss" })
public class JobListController extends HttpServlet {
    
    private PostDAO postDAO;
    
    @Override
    public void init() {
        postDAO = new PostDAO();
        System.out.println("JobListController initialized with PostDAO");
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            System.out.println("JobListController - doGet: " + request.getRequestURI());
            
            // Kiểm tra nếu có tham số tìm kiếm được gửi
            String keyword = request.getParameter("keyword");
            String location = request.getParameter("location");
            String category = request.getParameter("category");
            String skill = request.getParameter("skill");
            
            List<Post> posts;
            
            // Kiểm tra xem nút tìm kiếm đã được nhấn hay không
            boolean isSearching = (keyword != null && !keyword.isEmpty()) || 
                               (location != null && !location.isEmpty()) || 
                               (category != null && !category.isEmpty()) || 
                               (skill != null && !skill.isEmpty());
            
            if (isSearching) {
                System.out.println("Đang thực hiện tìm kiếm với keyword=" + keyword + ", location=" + location + ", category=" + category + ", skill=" + skill);
                // Sử dụng phương thức tìm kiếm mới
                posts = postDAO.searchPosts(keyword, location, category, skill);
                System.out.println("Tìm thấy " + posts.size() + " kết quả phù hợp");
            } else {
                // Không có tham số tìm kiếm, lấy tất cả bài đăng
                System.out.println("Hiển thị tất cả bài đăng không có tham số tìm kiếm");
                posts = postDAO.getAllPosts();
            }
            
            System.out.println("Controller: fetched " + posts.size() + " posts");
            
            // Thiết lập thuộc tính request
            request.setAttribute("posts", posts);
            request.setAttribute("isSearching", isSearching);
            
            // Luôn đặt các tham số tìm kiếm vào request attributes để hiển thị lại trong form
            request.setAttribute("searchKeyword", keyword != null ? keyword : "");
            request.setAttribute("searchLocation", location != null ? location : "");
            request.setAttribute("searchCategory", category != null ? category : "");
            request.setAttribute("searchSkill", skill != null ? skill : "");
            
            // Nếu đang tìm kiếm, hiển thị thông báo kết quả tìm kiếm
            if (isSearching) {
                request.setAttribute("searchResultCount", posts.size());
            }
            
            // Chuyển hướng đến trang JSP
            request.getRequestDispatcher("/jobs_list.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("JobListController - Error: " + e.getMessage());
            e.printStackTrace();
            
            request.setAttribute("error", "An error occurred while retrieving jobs. Details: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
