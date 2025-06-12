package Controller;

import DAO.FreelancerListDAO;
import Model.Freelancer;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

@WebServlet(name = "FreelancerListController", urlPatterns = {"/freelancer_list"})
public class FreelancerListController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String searchQuery = request.getParameter("search");
        FreelancerListDAO dao = new FreelancerListDAO();
        List<Freelancer> freelancerList;

        try {
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                freelancerList = dao.searchFreelancers(searchQuery);
                request.setAttribute("searchQuery", searchQuery);
            } else {
                freelancerList = dao.getAllActiveFreelancers();
            }
            request.setAttribute("freelancer_list", freelancerList);
            request.getRequestDispatcher("freelancer_list.jsp").forward(request, response);
        } catch (Exception e) {
            // Có thể chuyển hướng sang trang lỗi nếu cần
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Đã xảy ra lỗi khi xử lý yêu cầu.");
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
}
