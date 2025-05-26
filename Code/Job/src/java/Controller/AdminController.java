package Controller;

import DAO.JobseekerDAO;
import DAO.RecruiterDAO;
import Model.Jobseeker;
import Model.Recruiter;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class AdminController extends HttpServlet {
    private JobseekerDAO jobseekerDAO = new JobseekerDAO();
    private RecruiterDAO recruiterDAO = new RecruiterDAO();
    
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
            case "recruiter":
                showRecruiters(request, response);
                break;
            case "companies":
                request.getRequestDispatcher("admin_companies.jsp").forward(request, response);
                break;
            case "settings":
                request.getRequestDispatcher("admin_settings.jsp").forward(request, response);
                break;
            case "changeStatus":
                changeJobseekerStatus(request, response);
                break;
            case "deleteJobseeker":
                deleteJobseeker(request, response);
                break;
            case "changeRecruiterStatus":
                changeRecruiterStatus(request, response);
                break;
            case "deleteRecruiter":
                deleteRecruiter(request, response);
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
    private void showRecruiters(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            ArrayList<Recruiter> recruiters = recruiterDAO.getAllRecruiters();
            if (recruiters == null || recruiters.isEmpty()) {
                request.setAttribute("error", "No recruiters found");
            } else {
                request.setAttribute("recruiters", recruiters);
            }
            
            request.getRequestDispatcher("admin_recruiter.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading recruiters: " + e.getMessage());
            request.getRequestDispatcher("admin_recruiter.jsp").forward(request, response);
        }
    }

    private void changeJobseekerStatus(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String status = request.getParameter("status");
        
        if (id != null && status != null) {
            try {
                jobseekerDAO.updateStatus(Integer.parseInt(id), status);
                request.setAttribute("message", "Status updated successfully");
            } catch (Exception e) {
                request.setAttribute("error", "Error updating status: " + e.getMessage());
            }
        }
        
        showJobseekers(request, response);
    }
    
    private void changeRecruiterStatus(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String status = request.getParameter("status");
        
        if (id != null && status != null) {
            try {
                recruiterDAO.updateStatus(Integer.parseInt(id), status);
                request.setAttribute("message", "Status updated successfully");
            } catch (Exception e) {
                request.setAttribute("error", "Error updating status: " + e.getMessage());
            }
        }
        
        showRecruiters(request, response);
    }
    
    private void deleteRecruiter(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        
        if (id != null) {
            try {
                boolean success = recruiterDAO.deleteRecruiter(Integer.parseInt(id));
                if (success) {
                    request.setAttribute("message", "Recruiter deleted successfully");
                } else {
                    request.setAttribute("error", "Error deleting recruiter");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid recruiter ID");
            } catch (Exception e) {
                request.setAttribute("error", "Error deleting recruiter: " + e.getMessage());
            }
        } else {
            request.setAttribute("error", "No recruiter ID provided");
        }
        
        showRecruiters(request, response);
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
    
    private void deleteJobseeker(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        
        if (id != null) {
            try {
                boolean success = jobseekerDAO.deleteJobseeker(Integer.parseInt(id));
                if (success) {
                    request.setAttribute("message", "Jobseeker deleted successfully");
                } else {
                    request.setAttribute("error", "Error deleting jobseeker");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid jobseeker ID");
            } catch (Exception e) {
                request.setAttribute("error", "Error deleting jobseeker: " + e.getMessage());
            }
        } else {
            request.setAttribute("error", "No jobseeker ID provided");
        }
        
        showJobseekers(request, response);
    }

    @Override
    public String getServletInfo() {
        return super.getServletInfo();
    }
}
