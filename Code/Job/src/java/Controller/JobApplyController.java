package Controller;

import DAO.JobApplyDAO;
import Model.JobApply;
import Model.Jobseeker;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@MultipartConfig
@WebServlet(name = "JobApplyController", urlPatterns = {"/applyJob"})
public class JobApplyController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String jobIdStr = request.getParameter("jobId");

        try {
            HttpSession session = request.getSession();
            Jobseeker jobSeeker = (Jobseeker) session.getAttribute("user");

            if (jobSeeker == null) {
                response.sendRedirect("loginjobseeker.jsp?error=Please login to apply");
                return;
            }

            String coverLetter = request.getParameter("coverLetter");
            Part filePart = request.getPart("cv");

            if (jobIdStr == null || jobIdStr.trim().isEmpty() || filePart == null || filePart.getSize() == 0) {
                 request.setAttribute("error", "Invalid data. Please fill out the form correctly.");
                 request.getRequestDispatcher("jobseeker_applyJob.jsp?jobId=" + jobIdStr).forward(request, response);
                 return;
            }
            
            int jobId = Integer.parseInt(jobIdStr);
            int freelancerId = jobSeeker.getFreelancerID();

            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String fileExtension = fileName.substring(fileName.lastIndexOf("."));
            
            if(!fileExtension.equalsIgnoreCase(".pdf")) {
                request.setAttribute("error", "Invalid file type. Please upload a PDF file.");
                request.getRequestDispatcher("jobseeker_applyJob.jsp?jobId=" + jobId).forward(request, response);
                return;
            }

            String uniqueFileName = "cv_" + freelancerId + "_" + jobId + "_" + System.currentTimeMillis() + fileExtension;

            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads" + File.separator + "cvs";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            String filePath = uploadPath + File.separator + uniqueFileName;
            filePart.write(filePath);
            
            String dbFilePath = "uploads/cvs/" + uniqueFileName;

            JobApplyDAO applyDAO = new JobApplyDAO();
            JobApply application = new JobApply();
            application.setPostID(jobId);
            application.setFreelancerID(freelancerId);
            application.setCoverLetter(coverLetter);
            application.setResumePath(dbFilePath);
            application.setDateApply(new Date());
            application.setStatusApply("Pending");

            boolean success = applyDAO.addJobApply(application);

            if (success) {
                response.sendRedirect("jobs_list.jsp?apply_success=true");
            } else {
                request.setAttribute("error", "Failed to submit application. Please try again.");
                request.getRequestDispatcher("jobseeker_applyJob.jsp?jobId=" + jobId).forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An unexpected error occurred: " + e.getMessage());
            request.getRequestDispatcher("jobseeker_applyJob.jsp?jobId=" + jobIdStr).forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Handles job application submissions, including CV uploads.";
    }
}
