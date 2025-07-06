/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import DAO.CompanyDAO;
import DAO.RecruiterDAO;
import Model.Company;
import Model.Recruiter;
import Model.Post;
import DAO.PostDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "RecruiterDetailController", urlPatterns = {"/RecruiterDetailController"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class RecruiterDetailController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String action = request.getParameter("action");
        if (action == null) {
            viewProfile(request, response);
        } else {
            switch (action) {
                case "update":
                    updateProfile(request, response);
                    break;
                case "updateCompany":
                    updateCompany(request, response);
                    break;
                case "createJob":
                    createJobPost(request, response);
                    break;
                default:
                    viewProfile(request, response);
            }
        }
    }
    
    private void updateCompany(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            // Get company from session
            Model.Company company = (Model.Company) session.getAttribute("company");
            if (company == null) {
                throw new Exception("Không tìm thấy thông tin công ty");
            }
            
            // Get parameters from request
            String companyName = request.getParameter("companyName");
            String website = request.getParameter("website");
            String description = request.getParameter("description");
            String location = request.getParameter("location");
            String establishedDate = request.getParameter("establishedDate");
            
            // Validate required fields
            if (companyName == null || companyName.trim().isEmpty()) {
                throw new Exception("Tên công ty không được để trống");
            }
            
            // Update company object
            company.setCompany_name(companyName);
            company.setWebsite(website != null ? website : "");
            company.setDescribe(description != null ? description : "");
            company.setLocation(location != null ? location : "");
            company.setEstablished_on(establishedDate != null ? establishedDate : "");
            
            // Update in database
            DAO.CompanyDAO companyDAO = new DAO.CompanyDAO();
            boolean success = companyDAO.updateCompanyBasic(company);
            
            if (success) {
                // Update company in session
                session.setAttribute("company", company);
                session.setAttribute("successMessage", "Cập nhật thông tin công ty thành công!");
            } else {
                throw new Exception("Có lỗi xảy ra khi cập nhật thông tin công ty");
            }
            
        } catch (Exception e) {
            session.setAttribute("errorMessage", e.getMessage());
        }
        
        // Redirect back to profile page
        response.sendRedirect("recruiter_details.jsp");
    }

    private void viewProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("recruiter") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        request.getRequestDispatcher("recruiter_details.jsp").forward(request, response);
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Recruiter recruiter = (Recruiter) session.getAttribute("recruiter");
        
        if (recruiter == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Get form data
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String emailContact = request.getParameter("emailContact");
            String phoneContact = request.getParameter("phoneContact");
            boolean gender = Boolean.parseBoolean(request.getParameter("gender"));

            // Handle file upload
            Part filePart = request.getPart("profileImage");
            String fileName = null;
            
            if (filePart != null && filePart.getSize() > 0) {
                // Get the application's real path
                String appPath = request.getServletContext().getRealPath("");
                String uploadPath = appPath + "uploads" + File.separator + "Recruiter";
                
                // Create uploads/Recruiter directory if it doesn't exist
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                
                // Generate unique file name
                String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String fileExtension = "";
                int dotIndex = originalFileName.lastIndexOf('.');
                if (dotIndex > 0) {
                    fileExtension = originalFileName.substring(dotIndex);
                }
                fileName = "profile_" + UUID.randomUUID().toString() + fileExtension;
                
                // Save the file
                try (InputStream fileContent = filePart.getInputStream()) {
                    Files.copy(fileContent, Paths.get(uploadPath + File.separator + fileName),
                            StandardCopyOption.REPLACE_EXISTING);
                }
                
                // Update recruiter's image path (relative to webapp)
                recruiter.setImage("uploads/Recruiter/" + fileName);
            }

            // Update recruiter object
            recruiter.setFirstName(firstName);
            recruiter.setLastName(lastName);
            recruiter.setEmailContact(emailContact);
            recruiter.setPhoneContact(phoneContact);
            recruiter.setGender(gender);

            // Update in database
            RecruiterDAO recruiterDAO = new RecruiterDAO();
            boolean success = recruiterDAO.updateRecruiterProfile(recruiter);

            if (success) {
                // Update session
                session.setAttribute("recruiter", recruiter);
                request.setAttribute("successMessage", "Cập nhật thông tin thành công!");
            } else {
                request.setAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật thông tin");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
        }

        request.getRequestDispatcher("recruiter_details.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void createJobPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Recruiter recruiter = (Recruiter) session.getAttribute("recruiter");
        
        if (recruiter == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Get form data
            String title = request.getParameter("title");
            int recruiterID = Integer.parseInt(request.getParameter("recruiterID"));
            int jobTypeId = Integer.parseInt(request.getParameter("jobTypeId"));
            int durationId = Integer.parseInt(request.getParameter("durationId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            BigDecimal budgetMin = new BigDecimal(request.getParameter("budgetMin"));
            BigDecimal budgetMax = new BigDecimal(request.getParameter("budgetMax"));
            String location = request.getParameter("location");
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            String budgetType = request.getParameter("budgetType");
            String description = request.getParameter("description");
            
            // Parse expired date
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date expiredDate = dateFormat.parse(request.getParameter("expiredDate"));
            Date datePost = dateFormat.parse(request.getParameter("datePost"));
            // Create new Post object
            Post post = new Post();
            post.setTitle(title);
            post.setJobTypeId(jobTypeId);
            post.setDurationId(durationId);
            post.setQuantity(quantity);
            post.setBudgetMin(budgetMin);
            post.setBudgetMax(budgetMax);
            post.setLocation(location);
            post.setCategoryId(categoryId);
            post.setBudgetType(budgetType);
            post.setDescription(description);
            post.setDatePost(datePost);
            post.setExpiredDate(expiredDate);
            post.setRecruiterId(recruiterID);
            
            // Save to database
            PostDAO postDAO = new PostDAO();
            boolean success = postDAO.createPost(post);
//            PrintWriter out = response.getWriter();
//            out.print(title);
//            out.print(recruiterID);
//            out.print(jobTypeId);
//            out.print(durationId);
//            out.print(quantity);
//            out.print(budgetMin);
//            out.print(budgetMax);
//            out.print(location);
//            out.print(categoryId);
//            out.print(budgetType);
//            out.print(description);
//            out.print(expiredDate);
//            out.print(datePost);
            if (success) {
                session.setAttribute("successMessage", "Đăng bài tuyển dụng thành công!");
                response.sendRedirect("recruiter_postJob.jsp");
            } else {
                throw new Exception("Có lỗi xảy ra khi đăng bài tuyển dụng");
            }
            
        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Vui lòng nhập đúng định dạng số");
            response.sendRedirect("recruiter_postJob.jsp");
        } catch (ParseException e) {
            session.setAttribute("errorMessage", "Vui lòng chọn ngày hết hạn hợp lệ");
            response.sendRedirect("recruiter_postJob.jsp");
        } catch (Exception e) {
            session.setAttribute("errorMessage", e.getMessage());
            response.sendRedirect("recruiter_postJob.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Handles recruiter profile management";
    }
}
