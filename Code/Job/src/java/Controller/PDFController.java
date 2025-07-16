package Controller;

import DAO.JobApplyDAO;
import DAO.PostDAO;
import Model.JobApply;
import Model.Post;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "PDFController", urlPatterns = {"/PDFController"})
public class PDFController extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads" + File.separator + "cvs";
    private static final int BUFFER_SIZE = 4096;
    private static final Logger LOGGER = Logger.getLogger(PDFController.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy tham số từ request
        String resumePath = request.getParameter("resumePath");
        String postID = request.getParameter("postID");
        
        // Kiểm tra tham số bắt buộc
        if (resumePath == null || resumePath.trim().isEmpty()) {
            handleError(request, response, postID, "Thiếu đường dẫn CV");
            return;
        }

        // Lấy đường dẫn gốc của ứng dụng
        String appPath = getServletContext().getRealPath("");
        if (appPath == null) {
            handleError(request, response, postID, "Lỗi hệ thống: Không thể lấy đường dẫn ứng dụng");
            return;
        }
        
        // Log thông tin gỡ lỗi
        LOGGER.log(Level.INFO, "Application path: {0}", appPath);
        LOGGER.log(Level.INFO, "Resume path from request: {0}", resumePath);

        try {
            // Lấy tên file từ đường dẫn (trong trường hợp nhận được đường dẫn đầy đủ)
            String fileName = new File(resumePath.replace('\\', '/')).getName();
            LOGGER.log(Level.INFO, "Extracted file name: {0}", fileName);
            
            // Xây dựng đường dẫn đầy đủ đến thư mục CV
            String uploadPath = appPath + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            
            // Kiểm tra thư mục upload có tồn tại không
            if (!uploadDir.exists() || !uploadDir.isDirectory()) {
                handleError(request, response, postID, "Thư mục lưu trữ CV không tồn tại: " + uploadPath);
                return;
            }
            
            // Tìm file trong thư mục
            File cvFile = new File(uploadDir, fileName);
            LOGGER.log(Level.INFO, "Looking for CV file at: {0}", cvFile.getAbsolutePath());
            
            // Nếu không tìm thấy file, thử tìm file tương tự (không phân biệt hoa thường)
            if (!cvFile.exists() || !cvFile.isFile()) {
                cvFile = findSimilarFile(uploadDir, fileName);
                if (cvFile == null) {
                    handleError(request, response, postID, "Không tìm thấy file CV: " + fileName);
                    return;
                }
                LOGGER.log(Level.INFO, "Found similar file: {0}", cvFile.getName());
            }

            // Kiểm tra lại lần nữa để chắc chắn file tồn tại
            if (!cvFile.exists() || !cvFile.isFile()) {
                handleError(request, response, postID, "File CV không tồn tại: " + cvFile.getAbsolutePath());
                return;
            }

            // Thiết lập header cho response
            response.setContentType("application/pdf");
            response.setContentLength((int) cvFile.length());
            response.setHeader("Content-Disposition", "attachment; filename=\"" + cvFile.getName() + "\"");
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);

            // Gửi file về client
            try (InputStream in = new FileInputStream(cvFile);
                 OutputStream out = response.getOutputStream()) {
                
                byte[] buffer = new byte[BUFFER_SIZE];
                int bytesRead;
                while ((bytesRead = in.read(buffer)) != -1) {
                    out.write(buffer, 0, bytesRead);
                }
                out.flush();
                LOGGER.log(Level.INFO, "Successfully sent file: {0}", cvFile.getName());
            }

        } catch (Exception e) {
            String errorMsg = "Lỗi khi xử lý yêu cầu tải CV: " + e.getMessage();
            LOGGER.log(Level.SEVERE, errorMsg, e);
            handleError(request, response, request.getParameter("postID"), errorMsg);
        }
    }

    // Find exact file match in directory (case-insensitive)
    private File findFileInDirectory(File directory, String fileName) {
        if (!directory.exists() || !directory.isDirectory()) {
            return null;
        }
        
        File[] files = directory.listFiles((dir, name) -> 
            name.equalsIgnoreCase(fileName)
        );
        
        return (files != null && files.length > 0) ? files[0] : null;
    }

    // Find similar file (starts with same name, case-insensitive, with common extensions)
    private File findSimilarFile(File directory, String fileName) {
        if (!directory.exists() || !directory.isDirectory()) {
            return null;
        }
        
        // Remove extension for matching
        String baseName = fileName.replaceFirst("[.][^.]+$", "").toLowerCase();
        
        File[] files = directory.listFiles((dir, name) -> 
            name.toLowerCase().startsWith(baseName) && 
            (name.toLowerCase().endsWith(".pdf") || 
             name.toLowerCase().endsWith(".doc") || 
             name.toLowerCase().endsWith(".docx"))
        );
        
        // Return first match if found
        return (files != null && files.length > 0) ? files[0] : null;
    }

    // Phương thức xử lý lỗi tập trung
    private void handleError(HttpServletRequest request, HttpServletResponse response, 
            String postID, String errorMessage) throws ServletException, IOException {
        
        LOGGER.log(Level.SEVERE, "Handling error: {0}", errorMessage);
        
        // Lưu thông báo lỗi vào session
        request.getSession().setAttribute("errorMessage", errorMessage);
        
        try {
            // Nếu có postID, lấy lại danh sách ứng tuyển để hiển thị lại trang
            if (postID != null && !postID.trim().isEmpty()) {
                PostDAO postDAO = new PostDAO();
                JobApplyDAO jobApplyDAO = new JobApplyDAO();
                List<JobApply> listApply = jobApplyDAO.getJobAppliesByPostID(Integer.parseInt(postID));
                Post post = postDAO.getPostById(Integer.parseInt(postID));
                request.setAttribute("post", post);
                request.setAttribute("listApply", listApply);
                request.setAttribute("postID", postID);
            }
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid postID: {0}", postID);
        }
        
        // Chuyển hướng về trang recruiter_applyJob.jsp
        request.getRequestDispatcher("recruiter_applyJob.jsp").forward(request, response);
    }
    
    // Phương thức gửi lỗi HTTP đơn giản
    private void sendError(HttpServletResponse response, String message, int status) 
            throws IOException {
        LOGGER.log(Level.SEVERE, "Sending error {0}: {1}", new Object[]{status, message});
        response.sendError(status, message);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Handles CV file downloads from uploads/cvs directory";
    }

}
