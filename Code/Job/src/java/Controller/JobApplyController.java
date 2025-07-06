package Controller;

import DAO.JobApplyDAO;
import Model.JobApply;
import Model.Jobseeker;
import Model.Recruiter;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
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
import java.util.ArrayList;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,      // 1MB
    maxFileSize = 1024 * 1024 * 5,        // 5MB mỗi file
    maxRequestSize = 1024 * 1024 * 10     // 10MB tổng request
)
@WebServlet(name = "JobApplyController", urlPatterns = {"/applyJob"})
public class JobApplyController extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        if (action == null) {
            action = "dashboard";
        }


        switch (action) {
            case "dashboard":
                request.getRequestDispatcher("admin.jsp").forward(request, response);
                break;
            case "apply":
                showApply(request, response);
                break;
            case "apply_Job":
                applyJob(request, response);
                break;   
            default:
                request.getRequestDispatcher("admin.jsp").forward(request, response);
                break;
        }
    }
    private void showApply(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int jobseekerID = Integer.parseInt(request.getParameter("jobseekerID"));
        int postID = Integer.parseInt(request.getParameter("postID"));
        JobApplyDAO jobApply = new JobApplyDAO();
        if (jobApply.isFavorite(jobseekerID, postID)) {
            session.setAttribute("message", "Bài viết đã có trong danh sách apply");
            session.setAttribute("messageType", "warning");
            response.sendRedirect("jobs?action=list");
            return;
        }
//        boolean success = jobApply.applyJob(jobseekerID, postID);
        request.setAttribute("jobseekerID", jobseekerID);
        request.setAttribute("postID", postID);

        request.getRequestDispatcher("/jobseeker_applyJob.jsp").forward(request, response);
    }
    
    private void applyJob(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();
        

        try {
            // Lấy thông tin từ form
            int jobseekerID = Integer.parseInt(request.getParameter("jobId"));
            int postID = Integer.parseInt(request.getParameter("postID"));
            String coverLetter = request.getParameter("coverLetter");
            
            // Kiểm tra xem có file được tải lên không
            Part filePart = request.getPart("cv");
            if (filePart == null || filePart.getSize() == 0) {
                session.setAttribute("error", "Vui lòng tải lên file CV");
                response.sendRedirect("jobseeker_applyJob.jsp?jobId=" + postID);
                return;
            }

            // Lấy tên file
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            
            // Kiểm tra định dạng file
            if (fileName == null || !fileName.toLowerCase().endsWith(".pdf")) {
                session.setAttribute("error", "Chỉ chấp nhận file PDF");
                response.sendRedirect("jobseeker_applyJob.jsp?jobId=" + postID);
                return;
            }

            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads" + File.separator + "cvs";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            String uniqueFileName = "cv_" + jobseekerID + "_" + postID + "_" + System.currentTimeMillis() + ".pdf";
            String filePath = uploadPath + File.separator + uniqueFileName;
            
            filePart.write(filePath);
            
            String relativePath = "uploads/cvs/" + uniqueFileName;
            JobApplyDAO jobApplyDAO = new JobApplyDAO();
            boolean success = jobApplyDAO.applyJob(
                jobseekerID, 
                postID, 
                coverLetter, 
                relativePath
            );

            if (success) {
                session.setAttribute("message", "Nộp đơn thành công!");
                session.setAttribute("messageType", "success");
                response.sendRedirect("jobs?action=list");
            } else {
                new File(filePath).delete();
                session.setAttribute("message", "Có lỗi xảy ra khi lưu thông tin. Vui lòng thử lại.");
                response.sendRedirect("jobs?action=list");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            response.sendRedirect("job-list");
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

  
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
