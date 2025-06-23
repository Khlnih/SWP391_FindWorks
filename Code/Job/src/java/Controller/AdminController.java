package Controller;

import DAO.SkillDAO;
import DAO.JobseekerDAO;
import DAO.RecruiterDAO;
import DAO.EducationDAO;
import DAO.ExperienceDAO;
import DAO.JobseekerSkillDAO;
import DAO.RecruiterTransactionDAO;
import DAO.AccountTierDAO;
import DAO.CompanyDAO;
import DAO.NotificationDAO;
import DAO.FreelancerSubscriptionDAO;
import DAO.RecruiterSubscriptionDAO;
import Model.Jobseeker;
import Model.Recruiter;
import Model.SkillSet;
import Model.Education;
import Model.Experience;
import Model.Skill;
import Model.RecruiterTransaction;
import Model.AccountTier;
import Model.Company;
import Model.FreelancerSubscription;
import Model.RecruiterSubscription;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import DAO.CategoryDAO;
import Model.Category;
import DAO.NotificationDAO;
import Model.Notification;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Servlet implementation class AdminController
 */
@WebServlet("/admin")
public class AdminController extends HttpServlet {

    private JobseekerDAO jobseekerDAO = new JobseekerDAO();
    private RecruiterDAO recruiterDAO = new RecruiterDAO();
    private SkillDAO skillDAO = new SkillDAO();
    private EducationDAO educationDAO = new EducationDAO();
    private ExperienceDAO experienceDAO = new ExperienceDAO();
    private JobseekerSkillDAO jobseekerSkillDAO = new JobseekerSkillDAO();
    private RecruiterTransactionDAO recruiterTransactionDAO = new RecruiterTransactionDAO();
    private AccountTierDAO accountTierDAO = new AccountTierDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();
    private CompanyDAO companyDAO = new CompanyDAO();
    private FreelancerSubscriptionDAO freelancerSubscriptionDAO = new FreelancerSubscriptionDAO();
    private RecruiterSubscriptionDAO recruiterSubscriptionDAO = new RecruiterSubscriptionDAO();
    private NotificationDAO notificationDAO = new NotificationDAO();
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        if (action == null) {
            action = "dashboard";
        }

        clearSessionMessages(session, action);

        switch (action) {
            case "dashboard":
                request.getRequestDispatcher("admin.jsp").forward(request, response);
                break;
            case "jobseekers":
                showJobseekers(request, response);
                break;
            case "recruiters":
                showRecruiters(request, response);
                break;

            case "accounttier":
                showAccountTier(request, response);
                break;
            case "registration":
                showAccountRegistration(request, response);
                break;
            case "skills":
                showSkillSets(request, response);
                break;
            case "addSkill":
                addSkillSet(request, response);
                break;
            case "updateSkill":
                updateSkillSet(request, response);
                break;
            case "editSkill":
                showEditSkillSetForm(request, response);
                break;
            case "deleteSkill":
                deleteSkillSet(request, response);
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
            case "addTier":
                addTier(request, response);
                break;
            case "editTier":
                showEditTierForm(request, response);
                break;
            case "updateTier":
                updateTier(request, response);
                break;
            case "deleteTier":
                deleteTier(request, response);
                break;
            case "changeRecruiterStatus":
                changeRecruiterStatus(request, response);
                break;
            case "deleteRecruiter":
                deleteRecruiter(request, response);
                break;
            case "viewRecruiter":
                viewRecruiter(request, response);
                break;
            case "viewJobseeker":
                viewJobseeker(request, response);
                break;
            case "categories":
                showCategories(request, response);
                break;
            case "addCategory":
                showAddCategoryForm(request, response);
                break;
            case "createCategory":
                createCategory(request, response);
                break;
            case "editCategory":
                showEditCategoryForm(request, response);
                break;
            case "updateCategory":
                updateCategory(request, response);
                break;
            case "deleteCategory":
                deleteCategory(request, response);
                break;

            case "updateStatus":
                updateStatus(request, response);
                break;
            default:
                request.getRequestDispatcher("admin.jsp").forward(request, response);
                break;
        }
    }

    private void clearSessionMessages(HttpSession session, String currentAction) {
       
    }
    private void updateStatus(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            int subscriptionID = Integer.parseInt(request.getParameter("subscriptionID"));
            int status = Integer.parseInt(request.getParameter("statusInt"));
            String user = request.getParameter("user");
            boolean success = freelancerSubscriptionDAO.updateStatus(subscriptionID, status);
            
            String userID = request.getParameter("userID");
            int id = Integer.parseInt(userID);
            String mess = request.getParameter("mess");
            String type = "ApplicationUpdate";
            if(user.equals("freelancer")){
                notificationDAO.addFreelancerNotification(id, mess, type);
            }
            if(user.equals("recruiter")){
                notificationDAO.addRecruiterNotification(id, mess, type);
            }
            NotificationDAO notiDAO = new NotificationDAO();
            int number = notiDAO.countNotificationsByFreelancerId(Integer.parseInt(userID));
            ArrayList<Notification> listNoti = notiDAO.getUnreadNotificationsForFreelancer(Integer.parseInt(userID));
            ArrayList<Notification> allNoti = notiDAO.getNotificationsForFreelancer(Integer.parseInt(userID));
            session.setAttribute("listNoti", listNoti);
            session.setAttribute("allNoti", allNoti);
            session.setAttribute("number", number);
            PrintWriter out= response.getWriter(); out.print(id);
            response.sendRedirect("admin?action=registration");
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "ID đăng ký không hợp lệ");
            response.sendRedirect("admin?action=registration");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
            response.sendRedirect("admin?action=registration");
        }
    }
    private void transferSessionMessagesToRequest(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            if (session.getAttribute("message") != null) {
                request.setAttribute("message", session.getAttribute("message"));
                session.removeAttribute("message");
            }
            if (session.getAttribute("error") != null) {
                request.setAttribute("error", session.getAttribute("error"));
                session.removeAttribute("error");
            }
        }
    }

    private void showJobseekers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String keyword = request.getParameter("keyword");
            String searchBy = request.getParameter("searchBy");
            if (searchBy == null || searchBy.isEmpty()) {
                searchBy = "all";
            }
            
            // Validate search input
            if (keyword != null && !keyword.trim().isEmpty()) {
                String validationError = validateSearchInput(keyword, searchBy);
                if (validationError != null) {
                    // Set error message as JavaScript to show alert and reset page
                    String script = String.format(
                        "<script>alert('%s'); window.location.href='%s';</script>",
                        validationError.replace("'", "\\'"), // Escape single quotes
                        request.getContextPath() + "/AdminController?action=jobseekers"
                    );
                    response.setContentType("text/html;charset=UTF-8");
                    response.getWriter().write(script);
                    return;
                }
            }

            int defaultPageSize = 5;
            int pageSize = defaultPageSize;
            String pageSizeParam = request.getParameter("pageSize");
            if (pageSizeParam != null && !pageSizeParam.isEmpty()) {
                try {
                    int customPageSize = Integer.parseInt(pageSizeParam);
                    if (customPageSize > 0) {
                        pageSize = customPageSize;
                    }
                } catch (NumberFormatException e) {
                    /* use default */ }
            }

            int currentPage = 1;
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    currentPage = Integer.parseInt(pageParam);
                    if (currentPage < 1) {
                        currentPage = 1;
                    }
                } catch (NumberFormatException e) {
                    /* use default */ }
            }

            int totalJobseekers;
            if (keyword != null && !keyword.trim().isEmpty()) {
                totalJobseekers = jobseekerDAO.countSearchResults(keyword, searchBy);
            } else {
                totalJobseekers = jobseekerDAO.countTotalJobseekers();
            }
            int totalPages = (int) Math.ceil((double) totalJobseekers / pageSize);
            if (currentPage > totalPages && totalPages > 0) {
                currentPage = totalPages;
            }
            if (currentPage < 1) {
                currentPage = 1;
            }

            List<Jobseeker> jobseekers;
            if (keyword != null && !keyword.trim().isEmpty()) {
                jobseekers = jobseekerDAO.searchJobseekers(keyword, searchBy, currentPage, pageSize);
            } else {
                jobseekers = jobseekerDAO.getJobseekersByPage(currentPage, pageSize);
            }

            request.setAttribute("jobseekers", jobseekers);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalJobseekers", totalJobseekers);
            request.setAttribute("keyword", keyword);
            request.setAttribute("searchBy", searchBy);
            request.setAttribute("pageSize", pageSize);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading jobseekers: " + e.getMessage());
            request.setAttribute("jobseekers", new ArrayList<Jobseeker>());
            request.setAttribute("currentPage", 1);
            request.setAttribute("totalPages", 0);
            request.setAttribute("totalJobseekers", 0);
            request.setAttribute("pageSize", 5);
        }
        request.getRequestDispatcher("admin_jobseeker.jsp").forward(request, response);
    }

    /**
     * Validates search input based on the search type
     * @param input The input string to validate
     * @param searchType The type of search (email, phone, name, all)
     * @return Error message if validation fails, null if validation passes
     */
    private String validateSearchInput(String input, String searchType) {
        if (input == null || input.trim().isEmpty()) {
            return null;
        }

        switch (searchType.toLowerCase()) {
            case "email":
                // Email validation: no spaces, must contain @ and valid domain
                if (input.contains(" ")) {
                    return "Email không được chứa khoảng trắng.";
                }
                if (!input.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
                    return "Email không đúng định dạng. Vui lòng nhập email hợp lệ (ví dụ: example@domain.com).";
                }
                break;
                
            case "phone":
                // Phone validation: digits only, no spaces
                if (input.contains(" ")) {
                    return "Số điện thoại không được chứa khoảng trắng.";
                }
                if (!input.matches("^\\d+$")) {
                    return "Số điện thoại chỉ được chứa chữ số.";
                }
                break;
                
            case "name":
                // Name validation: allow only letters and single spaces between words
                // Trim and replace multiple spaces with single space
                String normalizedInput = input.trim().replaceAll("\\s+", " ");
                
                // Check if input contains only letters and spaces
                if (!normalizedInput.matches("^[\\p{L}\\s]+$")) {
                    return "Tên chỉ được chứa chữ cái và khoảng trắng.";
                }
                
                // Check each keyword length (at least 1 character)
                String[] keywords = normalizedInput.split("\\s+");
                for (String keyword : keywords) {
                    if (keyword.length() < 1) {
                        return "Mỗi từ khóa tìm kiếm phải có ít nhất 1 ký tự.";
                    }
                }
                break;
                
            case "all":
                // No specific validation for 'all' search type
                break;
                
            default:
                return "Loại tìm kiếm không hợp lệ.";
        }
        
        return null; // No validation errors
    }

    private void showRecruiters(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        transferSessionMessagesToRequest(request);
        try {
            String keyword = request.getParameter("keyword");
            String searchBy = request.getParameter("searchBy");
            if (searchBy == null || searchBy.isEmpty()) {
                searchBy = "all";
            }
            
            // Validate search input
            if (keyword != null && !keyword.trim().isEmpty()) {
                String validationError = validateSearchInput(keyword, searchBy);
                if (validationError != null) {
                    // Set error message as JavaScript to show alert and reset page
                    String script = String.format(
                        "<script>alert('%s'); window.location.href='%s';</script>",
                        validationError.replace("'", "\\'"), // Escape single quotes
                        request.getContextPath() + "/admin?action=recruiters"
                    );
                    response.setContentType("text/html;charset=UTF-8");
                    response.getWriter().write(script);
                    return;
                }
            }

            int defaultPageSize = 5;
            int pageSize = defaultPageSize;
            String pageSizeParam = request.getParameter("pageSize");
            if (pageSizeParam != null && !pageSizeParam.isEmpty()) {
                try {
                    int customPageSize = Integer.parseInt(pageSizeParam);
                    if (customPageSize > 0) pageSize = customPageSize;
                } catch (NumberFormatException e) { /* use default */ }
            }

            int currentPage = 1;
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    currentPage = Integer.parseInt(pageParam);
                    if (currentPage < 1) currentPage = 1;
                } catch (NumberFormatException e) { /* use default */ }
            }

            ArrayList<Recruiter> recruiters;
            int totalRecruiters;
            
            if (keyword != null && !keyword.trim().isEmpty()) {
                recruiters = recruiterDAO.searchRecruiters(keyword, searchBy, currentPage, pageSize);
                totalRecruiters = recruiterDAO.countSearchResults(keyword, searchBy);
            } else {
                recruiters = recruiterDAO.getRecruitersByPage(currentPage, pageSize);
                totalRecruiters = recruiterDAO.countTotalRecruiters();
            }

            int totalPages = (int) Math.ceil((double) totalRecruiters / pageSize);
            if (totalPages == 0) totalPages = 1; // At least one page
            if (currentPage > totalPages) currentPage = totalPages; // Adjust if current page exceeds total pages

            request.setAttribute("recruiters", recruiters);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalRecruiters", totalRecruiters);
            request.setAttribute("keyword", keyword);
            request.setAttribute("searchBy", searchBy);
            request.setAttribute("pageSize", pageSize);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading recruiters: " + e.getMessage());
            request.setAttribute("recruiters", new ArrayList<Recruiter>());
            request.setAttribute("currentPage", 1);
            request.setAttribute("totalPages", 0);
            request.setAttribute("totalRecruiters", 0);
            request.setAttribute("pageSize", 5);
        }
        request.getRequestDispatcher("admin_recruiter.jsp").forward(request, response);
    }

    private void showAccountTier(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");
        String isActiveStr = request.getParameter("isActive");
        String minDurationStr = request.getParameter("minDuration");
        String maxDurationStr = request.getParameter("maxDuration");
        String userTypeScope = request.getParameter("userTypeScope");

        // Parse parameters

        
        BigDecimal minPrice = null;
        BigDecimal maxPrice = null;
        Boolean isActive = null;
        Integer minDuration = null;
        Integer maxDuration = null;

        try {
            if (minPriceStr != null && !minPriceStr.isEmpty()) {
                minPrice = new BigDecimal(minPriceStr);
            }
            if (maxPriceStr != null && !maxPriceStr.isEmpty()) {
                maxPrice = new BigDecimal(maxPriceStr);
            }
            if (isActiveStr != null && !isActiveStr.isEmpty()) {
                isActive = Boolean.parseBoolean(isActiveStr);
            }
            if (minDurationStr != null && !minDurationStr.isEmpty()) {
                minDuration = Integer.parseInt(minDurationStr);
            }
            if (maxDurationStr != null && !maxDurationStr.isEmpty()) {
                maxDuration = Integer.parseInt(maxDurationStr);
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "❌ Định dạng dữ liệu tìm kiếm không hợp lệ");
        }

        // Get search results
        List<AccountTier> accountTiers = accountTierDAO.searchTiers(
                minPrice, maxPrice, isActive, minDuration, maxDuration, userTypeScope);

        // Get all user types for dropdown
        List<String> userTypes = Arrays.asList("RECRUITER", "JOBSEEKER", "BOTH");

        
        request.setAttribute("accountTiers", accountTiers);
        request.setAttribute("userTypes", userTypes);

        // Keep search parameters for form
        request.setAttribute("minPrice", minPriceStr);
        request.setAttribute("maxPrice", maxPriceStr);
        request.setAttribute("isActive", isActiveStr);
        request.setAttribute("minDuration", minDurationStr);
        request.setAttribute("maxDuration", maxDurationStr);
        request.setAttribute("selectedUserType", userTypeScope);

        request.getRequestDispatcher("admin_account_tiers.jsp").forward(request, response);
    }

    private void showAccountRegistration(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Lấy dữ liệu Freelancer
            List<FreelancerSubscription> freelancerSubscriptions = freelancerSubscriptionDAO.getActiveFreelancerSubscriptions();
            request.setAttribute("freelancerSubscriptions", freelancerSubscriptions);

//             Lấy ữ liệu Recruiter
            List<RecruiterSubscription> recruiterSubscriptions = recruiterSubscriptionDAO.getAllRecruiterSubscriptions();
            request.setAttribute("recruiterSubscriptions", recruiterSubscriptions);
            PrintWriter out = response.getWriter();
            out.print(freelancerSubscriptions);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tải dữ liệu đăng ký: " + e.getMessage());
        }
        
        // Forward đến JSP
        request.getRequestDispatcher("admin_tier_registrations.jsp").forward(request, response);
    }

    private void showEditTierForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int tierId = Integer.parseInt(request.getParameter("id"));
            AccountTier tier = accountTierDAO.getTierById(tierId);

            if (tier != null) {
                request.setAttribute("tier", tier);
                request.getRequestDispatcher("edit_tier.jsp").forward(request, response);
            } else {
                request.getSession().setAttribute("errorMessage", "Không tìm thấy gói tài khoản");
                response.sendRedirect("admin?action=accounttier");
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "ID không hợp lệ");
            response.sendRedirect("admin?action=accounttier");
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            response.sendRedirect("admin?action=accounttier");
        }
    }

    private void updateTier(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int tierId = Integer.parseInt(request.getParameter("tierId"));

            // Get form parameters
            String tierName = request.getParameter("tierName");
            String priceStr = request.getParameter("price").replaceAll("[^0-9]", "");
            BigDecimal price = new BigDecimal(priceStr);
            int durationDays = Integer.parseInt(request.getParameter("durationDays"));
            String description = request.getParameter("description");
            String typeScope = request.getParameter("typeScope");
            int jobPostLimit = Integer.parseInt(request.getParameter("jobPostLimit"));
            boolean status = request.getParameter("status").equals("1");

            // Create updated AccountTier object
            AccountTier tier = new AccountTier();
            tier.setTierID(tierId);
            tier.setTierName(tierName);
            tier.setPrice(price);
            tier.setDurationDays(durationDays);
            tier.setDescription(description);
            tier.setStatus(status);
            tier.setJobPostLimit(jobPostLimit);
            tier.setUserTypeScope(typeScope);

            // Update in database
            boolean success = accountTierDAO.updateTier(tier);

            if (success) {
                request.getSession().setAttribute("successMessage", "✅ Đã cập nhật gói tài khoản thành công!");
            } else {
                request.getSession().setAttribute("errorMessage", "❌ Có lỗi xảy ra khi cập nhật gói tài khoản. Vui lòng thử lại sau.");
            }

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "Dữ liệu không hợp lệ. Vui lòng kiểm tra lại.");
            e.printStackTrace();
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            e.printStackTrace();
        }

        response.sendRedirect("admin?action=accounttier");
    }

    private void deleteTier(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int tierId = Integer.parseInt(request.getParameter("id"));
            boolean success = accountTierDAO.deleteTier(tierId);

            if (success) {
                request.getSession().setAttribute("successMessage", "✅ Đã xóa gói tài khoản thành công!");
            } else {
                request.getSession().setAttribute("errorMessage", "❌ Không thể xóa gói tài khoản. Vui lòng thử lại sau.");
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "❌ Lỗi: ID gói tài khoản không hợp lệ");
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "❌ Lỗi hệ thống: " + e.getMessage());
            e.printStackTrace();
        }

        response.sendRedirect("admin?action=accounttier");
    }

    private void addTier(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get all parameters for debugging
            String tierName = request.getParameter("tierName");
            String priceStr = request.getParameter("price").replaceAll("[^0-9]", "");
            BigDecimal price = new BigDecimal(priceStr);
            int durationDays = Integer.parseInt(request.getParameter("durationDays"));
            String description = request.getParameter("description");
            String typeScope = request.getParameter("typeScope");
            int jobPostLimit = Integer.parseInt(request.getParameter("jobPostLimit"));
//            boolean status = request.getParameter("status").equals("1");


            boolean status = request.getParameter("status") != null && request.getParameter("status").equals("1");
            
            // Debug log the received parameters
            System.out.println("Adding new tier with parameters:");
            System.out.println("tierName: " + tierName);
            System.out.println("price: " + price);
            System.out.println("durationDays: " + durationDays);
            System.out.println("description: " + description);
            System.out.println("typeScope: " + typeScope);
            System.out.println("jobPostLimit: " + jobPostLimit);
            System.out.println("status: " + status);
            
            // Validate typeScope
            if (typeScope == null || (!typeScope.equalsIgnoreCase("Recruiter") && !typeScope.equalsIgnoreCase("Jobseeker"))) {
                request.getSession().setAttribute("errorMessage", "Loại tài khoản không hợp lệ. Vui lòng chọn Recruiter hoặc Jobseeker.");
                response.sendRedirect("admin?action=accounttier");
                return;
            }
            
            // Create new AccountTier object
            AccountTier tier = new AccountTier();
            tier.setTierName(tierName);
            tier.setPrice(price);
            tier.setDurationDays(durationDays);
            tier.setDescription(description);
            tier.setStatus(status);
            tier.setJobPostLimit(jobPostLimit);
            tier.setUserTypeScope(typeScope);

            // Add to database
            boolean success = accountTierDAO.addAccountTier(tier);

            if (success) {
                request.getSession().setAttribute("successMessage", "Thêm gói tài khoản " + tierName + " cho " + typeScope + " thành công!");
            } else {
                request.getSession().setAttribute("errorMessage", "Có lỗi xảy ra khi thêm gói tài khoản. Vui lòng kiểm tra lại thông tin.");
            }

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "Dữ liệu không hợp lệ. Vui lòng kiểm tra lại.");
            e.printStackTrace();
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            e.printStackTrace();
        }

        // Redirect back to the account tiers page
        response.sendRedirect("admin?action=accounttier");
    }

    // --- Category Management Methods ---
    /**
     * Hiển thị danh sách tất cả các danh mục.
     */
    /**
     * Hiển thị danh sách tất cả các danh mục với tìm kiếm và phân trang. (PHIÊN
     * BẢN ĐÃ SỬA LẠI)
     */
    private void showCategories(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        transferSessionMessagesToRequest(request); // Lấy message từ session sau khi redirect

        try {
            // 1. Lấy các tham số cho phân trang và tìm kiếm (Phần này bạn đã làm đúng)
            String keyword = request.getParameter("keyword");
            if (keyword == null) {
                keyword = ""; // Mặc định là chuỗi rỗng để không bị lỗi null
            }

            String pageStr = request.getParameter("page");
            int currentPage = (pageStr == null || pageStr.isEmpty()) ? 1 : Integer.parseInt(pageStr);

            String pageSizeStr = request.getParameter("pageSize");
            int pageSize = (pageSizeStr == null || pageSizeStr.isEmpty()) ? 5 : Integer.parseInt(pageSizeStr);

            // 2. Lấy tổng số danh mục khớp với từ khóa từ DAO (Đã đúng)
            int totalCategories = categoryDAO.countCategories(keyword);

            // 3. Tính toán các giá trị phân trang (Đã đúng)
            int totalPages = (int) Math.ceil((double) totalCategories / pageSize);
            int offset = (currentPage - 1) * pageSize;

            // 4. GỌI ĐÚNG PHƯƠNG THỨC DAO để lấy danh sách đã phân trang và tìm kiếm
            List<Category> categories = categoryDAO.searchAndPaginateCategories(keyword, offset, pageSize);

            // 5. GỬI TẤT CẢ DỮ LIỆU CẦN THIẾT SANG JSP
            request.setAttribute("categories", categories); // Danh sách danh mục cho trang hiện tại
            request.setAttribute("currentPage", currentPage);   // Trang hiện tại
            request.setAttribute("totalPages", totalPages);     // Tổng số trang
            request.setAttribute("pageSize", pageSize);         // Kích thước trang
            request.setAttribute("currentKeyword", keyword);    // Từ khóa tìm kiếm hiện tại
            request.setAttribute("totalCategories", totalCategories); // Tổng số danh mục tìm thấy

        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("error", "Tham số trang hoặc kích thước trang không hợp lệ.");
            request.setAttribute("categories", new ArrayList<Category>());
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tải danh sách danh mục: " + e.getMessage());
            request.setAttribute("categories", new ArrayList<Category>());
        }

        request.getRequestDispatcher("admin_categories.jsp").forward(request, response);
    }

    // --- Các phương thức còn lại của bạn giữ nguyên ---
    // showAddCategoryForm, createCategory, updateCategory,...
    /**
     * Hiển thị form để tạo một danh mục mới.
     */
    private void showAddCategoryForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chỉ cần chuyển hướng đến trang JSP chứa form
        request.getRequestDispatcher("admin_category_add.jsp").forward(request, response);
    }

    /**
     * Xử lý dữ liệu từ form và tạo danh mục mới trong CSDL.
     */
    private void createCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            String categoryName = request.getParameter("categoryName");
            String description = request.getParameter("description");
            String categoryImg = request.getParameter("categoryImg"); // Giả sử bạn có trường nhập URL ảnh
            boolean isActive = "1".equals(request.getParameter("status"));

            // Validate đầu vào
            if (categoryName == null || categoryName.trim().isEmpty()) {
                session.setAttribute("error", "Tên danh mục không được để trống.");
                response.sendRedirect("admin?action=addCategory"); // Gửi lại form
                return;
            }
            if (description == null || description.trim().isEmpty()) {
                session.setAttribute("error", "Tên danh mục không được để trống.");
                response.sendRedirect("admin?action=addCategory");
                return;
            }

            Category newCategory = new Category();
            newCategory.setCategoryName(categoryName.trim());
            newCategory.setDescription(description);
            newCategory.setCategoryImg(categoryImg);
            newCategory.setStatus(isActive);

            boolean success = categoryDAO.createCategory(newCategory);

            if (success) {
                session.setAttribute("message", "Thêm danh mục '" + newCategory.getCategoryName() + "' thành công!");
            } else {
                session.setAttribute("error", "Có lỗi xảy ra khi thêm danh mục. Vui lòng thử lại.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
        }
        // Sử dụng PRG pattern
        response.sendRedirect("admin?action=categories");
    }

    private void showEditCategoryForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            int categoryId = Integer.parseInt(request.getParameter("id"));
            Category category = categoryDAO.getCategoryById(categoryId);

            if (category != null) {
                request.setAttribute("category", category);
                request.getRequestDispatcher("admin_category_edit.jsp").forward(request, response);
            } else {
                session.setAttribute("error", "Không tìm thấy danh mục với ID: " + categoryId);
                response.sendRedirect("admin?action=categories");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("error", "ID danh mục không hợp lệ.");
            response.sendRedirect("admin?action=categories");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            response.sendRedirect("admin?action=categories");
        }
    }

    /**
     * Xử lý dữ liệu từ form và cập nhật thông tin danh mục.
     */
    private void updateCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            String categoryName = request.getParameter("categoryName");
            String description = request.getParameter("description");
            String categoryImg = request.getParameter("categoryImg");
            boolean isActive = "1".equals(request.getParameter("status"));

            // Validate
            if (categoryName == null || categoryName.trim().isEmpty()) {
                session.setAttribute("error", "Tên danh mục không được để trống.");
                response.sendRedirect("admin?action=editCategory&id=" + categoryId);
                return;
            }
            if (description == null || description.trim().isEmpty()) {
                session.setAttribute("error", "Tên danh mục không được để trống.");
                response.sendRedirect("admin?action=editCategory&id=" + categoryId);
                return;
            }

            Category categoryToUpdate = new Category();
            categoryToUpdate.setCategoryID(categoryId);
            categoryToUpdate.setCategoryName(categoryName.trim());
            categoryToUpdate.setDescription(description);
            categoryToUpdate.setCategoryImg(categoryImg);
            categoryToUpdate.setStatus(isActive);

            boolean success = categoryDAO.updateCategory(categoryToUpdate);

            if (success) {
                session.setAttribute("message", "Cập nhật danh mục '" + categoryToUpdate.getCategoryName() + "' thành công!");
            } else {
                session.setAttribute("error", "Có lỗi xảy ra khi cập nhật danh mục.");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("error", "ID danh mục không hợp lệ.");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
        }
        response.sendRedirect("admin?action=categories");
    }

    private void deleteCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String categoryIdStr = request.getParameter("id");

        if (categoryIdStr == null || categoryIdStr.trim().isEmpty()) {
            session.setAttribute("error", "ID danh mục không được cung cấp.");
            response.sendRedirect("admin?action=categories");
            return;
        }

        try {
            int categoryId = Integer.parseInt(categoryIdStr);

            // Gọi phương thức xóa vĩnh viễn mới trong DAO
            boolean success = categoryDAO.hardDeleteCategory(categoryId);

            if (success) {
                session.setAttribute("message", "Đã xóa vĩnh viễn danh mục (ID: " + categoryId + ") thành công.");
            } else {
                // Trường hợp này ít xảy ra nếu không có lỗi, vì nếu ID không tồn tại, 
                // hardDeleteCategory sẽ trả về false.
                session.setAttribute("error", "Không thể xóa danh mục. Nó có thể không tồn tại.");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("error", "ID danh mục không hợp lệ: " + categoryIdStr);
        } catch (RuntimeException e) {
            // Bắt lỗi được ném từ DAO (thường là do ràng buộc khóa ngoại)
            e.printStackTrace(); // In stack trace ra console để debug
            if (e.getCause() instanceof java.sql.SQLException) {
                // Kiểm tra thông điệp lỗi để cung cấp thông tin hữu ích hơn
                String dbErrorMessage = e.getCause().getMessage().toLowerCase();
                if (dbErrorMessage.contains("foreign key") || dbErrorMessage.contains("constraint")) {
                    session.setAttribute("error", "Không thể xóa danh mục này vì nó đang được sử dụng bởi các công việc hoặc bản ghi khác.");
                } else {
                    session.setAttribute("error", "Lỗi cơ sở dữ liệu khi xóa danh mục: " + e.getCause().getMessage());
                }
            } else {
                session.setAttribute("error", "Lỗi hệ thống khi xóa danh mục: " + e.getMessage());
            }
        }

        response.sendRedirect("admin?action=categories");
    }

    // --- End of Category Management Methods ---
    private void showSkillSets(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        transferSessionMessagesToRequest(request);

        try {
            String keyword = request.getParameter("keyword");
            if (keyword != null) {
                keyword = keyword.trim().replaceAll("\\s+", " ");
            }
            int defaultPageSize = 10;
            int pageSize = defaultPageSize;
            String pageSizeParam = request.getParameter("pageSize");
            if (pageSizeParam != null && !pageSizeParam.isEmpty()) {
                try {
                    int customPageSize = Integer.parseInt(pageSizeParam);
                    if (customPageSize > 0) {
                        pageSize = customPageSize;
                    }
                } catch (NumberFormatException e) {
                    /* use default */ }
            }

            int currentPage = 1;
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    currentPage = Integer.parseInt(pageParam);
                    if (currentPage < 1) {
                        currentPage = 1;
                    }
                } catch (NumberFormatException e) {
                    /* use default */ }
            }

            int totalSkills;
            List<SkillSet> skillList;

            if (keyword != null && !keyword.trim().isEmpty()) {
                totalSkills = skillDAO.countSearchedSkillSets(keyword);
                skillList = skillDAO.searchSkillSets(keyword, currentPage, pageSize);
            } else {
                totalSkills = skillDAO.countTotalSkillSets();
                skillList = skillDAO.getSkillSetsByPage(currentPage, pageSize);
            }

            int totalPages = (int) Math.ceil((double) totalSkills / pageSize);
            if (totalPages == 0 && totalSkills > 0) {
                totalPages = 1;
            }

            if (currentPage > totalPages && totalPages > 0) {
                currentPage = totalPages;
            }
            if (currentPage < 1) {
                currentPage = 1;
            }

            request.setAttribute("skillList", skillList != null ? skillList : new ArrayList<SkillSet>());
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalSkills", totalSkills);
            request.setAttribute("currentKeyword", keyword);
            request.setAttribute("pageSize", pageSize);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading skills: " + e.getMessage());
            request.setAttribute("skillList", new ArrayList<SkillSet>());
            request.setAttribute("currentPage", 1);
            request.setAttribute("totalPages", 0);
            request.setAttribute("totalSkills", 0);
            request.setAttribute("pageSize", 10);
        }

        request.getRequestDispatcher("admin_skill.jsp").forward(request, response);
    }

    /**
     * Xử lý việc thêm một bộ kỹ năng mới. Được gọi từ doPost với
     * action="addSkill".
     */
    private void addSkillSet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String skillName = request.getParameter("skillName");
        String skillDescription = request.getParameter("skillDescription");
        String isActiveStr = request.getParameter("isActive");
        String expertiseIdStr = request.getParameter("expertiseId");

        if (skillName == null || skillName.trim().isEmpty()
                || skillDescription == null || skillDescription.trim().isEmpty()) {
            session.setAttribute("error", "Skill name and description cannot be empty.");
            response.sendRedirect(request.getContextPath() + "/admin?action=skills");
            return;
        }

        try {
            boolean isActive = "1".equals(isActiveStr) || "true".equalsIgnoreCase(isActiveStr);
            int expertiseId = 0; // Giá trị mặc định
            if (expertiseIdStr != null && !expertiseIdStr.trim().isEmpty()) {
                expertiseId = Integer.parseInt(expertiseIdStr);
            }

            SkillSet newSkillSet = new SkillSet();
            newSkillSet.setSkillSetName(skillName.trim());
            newSkillSet.setDescription(skillDescription.trim());
            newSkillSet.setActive(isActive);
            newSkillSet.setExpertiseId(expertiseId);

            boolean success = skillDAO.addSkillSet(newSkillSet);
            if (success) {
                session.setAttribute("message", "Skill '" + newSkillSet.getSkillSetName() + "' added successfully!");
            } else {
                session.setAttribute("error", "Failed to add skill. It might already exist or there was a database error.");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid format for Expert ID.");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Error adding skill: " + e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/admin?action=skills");
    }

    /**
     * Hiển thị form để chỉnh sửa thông tin một bộ kỹ năng. Được gọi từ doGet
     * với action="editSkill".
     */
    private void showEditSkillSetForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        transferSessionMessagesToRequest(request);
        String skillIdStr = request.getParameter("id");
        if (skillIdStr != null) {
            try {
                int skillId = Integer.parseInt(skillIdStr);
                SkillSet skill = skillDAO.getSkillSetById(skillId);
                if (skill != null) {
                    request.setAttribute("skillToEdit", skill);
                    request.getRequestDispatcher("admin_skill_edit.jsp").forward(request, response);
                } else {
                    // Dùng session để lưu lỗi vì sẽ redirect
                    request.getSession().setAttribute("error", "Skill not found for editing (ID: " + skillId + ").");
                    response.sendRedirect(request.getContextPath() + "/admin?action=skills");
                }
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("error", "Invalid skill ID format for editing.");
                response.sendRedirect(request.getContextPath() + "/admin?action=skills");
            } catch (Exception e) {
                e.printStackTrace();
                request.getSession().setAttribute("error", "Error retrieving skill for editing: " + e.getMessage());
                response.sendRedirect(request.getContextPath() + "/admin?action=skills");
            }
        } else {
            request.getSession().setAttribute("error", "No skill ID provided for editing.");
            response.sendRedirect(request.getContextPath() + "/admin?action=skills");
        }
    }

    /**
     * Xử lý việc cập nhật thông tin một bộ kỹ năng. Được gọi từ doPost với
     * action="updateSkill".
     */
    private void updateSkillSet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String skillSetIdStr = request.getParameter("skillSetId");
        String skillName = request.getParameter("skillName");
        String skillDescription = request.getParameter("skillDescription");
        String isActiveStr = request.getParameter("isActive");
        String expertiseIdStr = request.getParameter("expertiseId");
        String redirectURL = request.getContextPath() + "/admin?action=skills";

        if (skillSetIdStr == null || skillName == null || skillName.trim().isEmpty()) {
            session.setAttribute("error", "Skill ID and Skill Name are required for update.");
            response.sendRedirect(redirectURL);
            return;
        }

        try {
            int skillSetId = Integer.parseInt(skillSetIdStr);
            boolean isActive = "1".equals(isActiveStr) || "true".equalsIgnoreCase(isActiveStr);
            int expertiseId = 0; // Giá trị mặc định
            if (expertiseIdStr != null && !expertiseIdStr.trim().isEmpty()) {
                expertiseId = Integer.parseInt(expertiseIdStr);
            }

            SkillSet skillToUpdate = new SkillSet();
            skillToUpdate.setSkillSetId(skillSetId);
            skillToUpdate.setSkillSetName(skillName.trim());
            skillToUpdate.setDescription(skillDescription != null ? skillDescription.trim() : "");
            skillToUpdate.setActive(isActive);
            skillToUpdate.setExpertiseId(expertiseId);

            boolean success = skillDAO.updateSkillSet(skillToUpdate);
            if (success) {
                session.setAttribute("message", "Skill '" + skillToUpdate.getSkillSetName() + "' updated successfully!");
            } else {
                session.setAttribute("error", "Failed to update skill. Skill not found or database error.");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid format for Skill ID or Expert ID.");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Error updating skill: " + e.getMessage());
        }
        response.sendRedirect(redirectURL);
    }

    /**
     * Xử lý việc xóa một bộ kỹ năng. Được gọi từ doGet với
     * action="deleteSkill".
     */
    private void deleteSkillSet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String skillIdStr = request.getParameter("id");

        if (skillIdStr != null) {
            try {
                int skillId = Integer.parseInt(skillIdStr);
                boolean success = skillDAO.deleteSkillSet(skillId);
                if (success) {
                    session.setAttribute("message", "Skill (ID: " + skillId + ") deleted successfully!");
                } else {
                    session.setAttribute("error", "Failed to delete skill. It might not exist.");
                }
            } catch (NumberFormatException e) {
                session.setAttribute("error", "Invalid skill ID format for deletion.");
            } catch (Exception e) {
                e.printStackTrace();
                if (e.getMessage() != null && (e.getMessage().toLowerCase().contains("constraint") || e.getMessage().toLowerCase().contains("foreign key"))) {
                    session.setAttribute("error", "Cannot delete skill (ID: " + skillIdStr + "): It is currently in use by other records.");
                } else {
                    session.setAttribute("error", "Error deleting skill (ID: " + skillIdStr + "): " + e.getMessage());
                }
            }
        } else {
            session.setAttribute("error", "No skill ID provided for deletion.");
        }
        response.sendRedirect(request.getContextPath() + "/admin?action=skills");
    }

    // --- End of Skill Management Methods ---
    // --- Jobseeker and Recruiter methods with PRG ---
    private void changeJobseekerStatus(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String id = request.getParameter("id");
        String status = request.getParameter("status");

        if (id != null && status != null) {
            try {
                jobseekerDAO.updateStatus(Integer.parseInt(id), status);
                session.setAttribute("message", "Jobseeker (ID: " + id + ") status updated successfully to " + status);
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("error", "Error updating jobseeker status: " + e.getMessage());
            }
        } else {
            session.setAttribute("error", "Missing ID or status for jobseeker update.");
        }
        response.sendRedirect(request.getContextPath() + "/admin?action=jobseekers");
    }

    private void deleteJobseeker(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String id = request.getParameter("id");

        if (id != null) {
            try {
                boolean success = jobseekerDAO.deleteJobseeker(Integer.parseInt(id));
                if (success) {
                    session.setAttribute("message", "Jobseeker (ID: " + id + ") deleted successfully");
                } else {
                    session.setAttribute("error", "Error deleting jobseeker (not found or constraint issue).");
                }
            } catch (NumberFormatException e) {
                session.setAttribute("error", "Invalid jobseeker ID");
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("error", "Error deleting jobseeker: " + e.getMessage());
            }
        } else {
            session.setAttribute("error", "No jobseeker ID provided");
        }
        response.sendRedirect(request.getContextPath() + "/admin?action=jobseekers");
    }

    private void viewRecruiter(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        if (id == null || id.isEmpty()) {
            response.sendRedirect("AdminController?action=recruiter");
            return;
        }

        try {
            int recruiterId = Integer.parseInt(id);
            Recruiter recruiter = recruiterDAO.getRecruiterById(recruiterId);
            if (recruiter != null) {
                RecruiterDAO reDAO = new RecruiterDAO();
                RecruiterTransactionDAO rtDAO = new RecruiterTransactionDAO();

                List<RecruiterTransaction> transactions = rtDAO.getTransactionsByRecruiter(recruiterId);
                Double totalSpent = rtDAO.getTotalSpent(recruiterId);

                // Lấy thông tin gói đăng ký
                AccountTierDAO atDAO = new AccountTierDAO();
                String tierName = reDAO.getTierName(recruiterId);
                String description = reDAO.getTierNameDescription(recruiterId);

                // Lấy thông tin công ty
                CompanyDAO companyDAO = new CompanyDAO();
                Company company = companyDAO.getCompanyByRecruiterId(recruiterId);

                // Đặt thuộc tính để hiển thị trong JSP
                request.setAttribute("recruiter", recruiter);
                request.setAttribute("transactions", transactions);
                request.setAttribute("totalSpent", totalSpent);
                request.setAttribute("tierName", tierName);
                request.setAttribute("description", description);
                request.setAttribute("company", company);

                request.getRequestDispatcher("admin_recruiterdetails.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Recruiter not found");
                response.sendRedirect("AdminController?action=recruiter");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid recruiter ID");
            response.sendRedirect("AdminController?action=recruiter");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading recruiter details: " + e.getMessage());
            response.sendRedirect("AdminController?action=recruiter");
        }
    }

    private void viewJobseeker(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        if (id == null || id.isEmpty()) {
            response.sendRedirect("admin?action=jobseekers");
            return;
        }

        try {
            int freelancerId = Integer.parseInt(id);
            Jobseeker jobseeker = jobseekerDAO.getJobseekerById(freelancerId);

            if (jobseeker != null) {
                // Lấy dữ liệu từ các DAO
                List<Education> educations = educationDAO.getEducationByFreelancerID(freelancerId);
                List<Experience> experiences = experienceDAO.getExperienceByFreelancerID(freelancerId);
                List<Skill> skills = jobseekerSkillDAO.getSkillsByFreelancerID(freelancerId);

                // Đặt các thuộc tính vào request
                request.setAttribute("jobseeker", jobseeker);
                request.setAttribute("educations", educations);
                request.setAttribute("experiences", experiences);
                request.setAttribute("skills", skills);

                // Forward đến trang chi tiết
                request.getRequestDispatcher("admin_jobseekerdetails.jsp").forward(request, response);
            } else {
                request.getSession().setAttribute("error", "Không tìm thấy ứng viên");
                response.sendRedirect("admin?action=jobseekers");
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "ID ứng viên không hợp lệ");
            response.sendRedirect("admin?action=jobseekers");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Lỗi khi tải thông tin ứng viên: " + e.getMessage());
            response.sendRedirect("admin?action=jobseekers");
        }
    }

    private void changeRecruiterStatus(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String id = request.getParameter("id");
        String status = request.getParameter("status");

        if (id != null && status != null) {
            try {
                recruiterDAO.updateStatus(Integer.parseInt(id), status);
                session.setAttribute("message", "Recruiter (ID: " + id + ") status updated successfully to " + status);
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("error", "Error updating recruiter status: " + e.getMessage());
            }
        } else {
            session.setAttribute("error", "Missing ID or status for recruiter update.");
        }
        response.sendRedirect(request.getContextPath() + "/admin?action=recruiters");
    }

    private void deleteRecruiter(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String id = request.getParameter("id");

        if (id != null) {
            try {
                boolean success = recruiterDAO.deleteRecruiter(Integer.parseInt(id));
                if (success) {
                    session.setAttribute("message", "Recruiter (ID: " + id + ") deleted successfully");
                } else {
                    session.setAttribute("error", "Error deleting recruiter (not found or constraint issue).");
                }
            } catch (NumberFormatException e) {
                session.setAttribute("error", "Invalid recruiter ID");
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("error", "Error deleting recruiter: " + e.getMessage());
            }
        } else {
            session.setAttribute("error", "No recruiter ID provided");
        }
        response.sendRedirect(request.getContextPath() + "/admin?action=recruiters");
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

    @Override
    public String getServletInfo() {
        return "Admin Controller Servlet";
    }
}
