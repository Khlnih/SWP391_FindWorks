package Controller;

import Model.Jobseeker;
import DAO.JobseekerDAO;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "JobseekerController", urlPatterns = {"/jobseeker"})
public class JobseekerController extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        
        JobseekerDAO dao = new JobseekerDAO();
        
        switch (action) {
            case "list":
                List<Jobseeker> list = dao.getAllJobseekers();
                request.setAttribute("jobseekers", list);
                request.getRequestDispatcher("/WEB-INF/admin_jobseeker.jsp").forward(request, response);
                break;
            
            case "view":
                int id = Integer.parseInt(request.getParameter("id"));
                Jobseeker jobseeker = dao.getJobseekerByID(id);
                request.setAttribute("jobseeker", jobseeker);
                request.getRequestDispatcher("/admin_jobseeker_detail.jsp").forward(request, response);
                break;
                
            case "search":
                String keyword = request.getParameter("keyword");
                list = dao.searchJobseekers(keyword);
                request.setAttribute("jobseekers", list);
                request.setAttribute("keyword", keyword);
                request.getRequestDispatcher("/WEB-INF/admin_jobseeker.jsp").forward(request, response);
                break;
                
            default:
                list = dao.getAllJobseekers();
                request.setAttribute("jobseekers", list);
                request.getRequestDispatcher("/WEB-INF/admin_jobseeker.jsp").forward(request, response);
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

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
