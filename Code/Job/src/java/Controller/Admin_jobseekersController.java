package Controller;

import DAO.JobseekerDAO;
import Model.Jobseeker;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class Admin_jobseekersController extends HttpServlet {
    private JobseekerDAO jobseekerDAO = new JobseekerDAO();
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            // Mặc định hiển thị danh sách jobseekers
            showJobseekers(request, response);
            return;
        }
        
        switch (action) {
            case "dashboard":
                request.getRequestDispatcher("admin.jsp").forward(request, response);
                break;
            case "jobseekers":
                showJobseekers(request, response);
                break;
            case "jobs":
                request.getRequestDispatcher("admin_jobs.jsp").forward(request, response);
                break;
            case "companies":
                request.getRequestDispatcher("admin_companies.jsp").forward(request, response);
                break;
            case "settings":
                request.getRequestDispatcher("admin_settings.jsp").forward(request, response);
                break;
            default:
                showJobseekers(request, response);
                break;
        }
    }
    
    private void showJobseekers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            ArrayList<Jobseeker> jobseekers = jobseekerDAO.getAllJobSeeker();
            if (jobseekers == null || jobseekers.isEmpty()) {
                request.setAttribute("error", "No jobseekers found");
            } else {
                request.setAttribute("jobseekers", jobseekers);
            }
            
            // Forward đến trang admin_jobseeker.jsp
            request.getRequestDispatcher("admin_jobseeker.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading jobseekers: " + e.getMessage());
            request.getRequestDispatcher("admin_jobseeker.jsp").forward(request, response);
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
        return "Admin Jobseekers Controller";
    }
}
