package Controller;

import DAO.AccountTierDAO;
import DAO.DBContext;
import Model.AccountTier;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

@WebServlet("/admin/accountTier")
public class AccountTierController extends HttpServlet {
    private AccountTierDAO accountTierDAO = new AccountTierDAO();
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        // Kiểm tra kết nối CSDL
        try {
            if (DBContext.getConnection() == null) {
                request.setAttribute("error", "Lỗi kết nối CSDL. Vui lòng kiểm tra lại server!");
                request.getRequestDispatcher("/admin_accountTier.jsp").forward(request, response);
                return;
            }
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi kết nối CSDL: " + e.getMessage());
            request.getRequestDispatcher("/admin_accountTier.jsp").forward(request, response);
            return;
        }
        
        System.out.println("AccountTierController: Processing request");
        String action = request.getParameter("action");
        System.out.println("Action parameter: " + action);
        HttpSession session = request.getSession();
        
        try {
            // Handle CRUD actions
            if (action != null) {
                switch (action) {
                    case "add":
                        handleAdd(request, response);
                        break;
                    case "update":
                        handleUpdate(request, response);
                        break;
                    case "delete":
                        handleDelete(request, response);
                        break;
                }
            }
            
            // Handle pagination
            int pageSize = 5;
            int currentPage = 1;
            
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                currentPage = Integer.parseInt(pageParam);
            }
            
            int offset = (currentPage - 1) * pageSize;
            
            // Get account tiers with pagination
            List<AccountTier> accountTiers = accountTierDAO.getAccountTiersWithPagination(offset, pageSize);
            int totalTiers = accountTierDAO.countTotalTiers();
            int totalPages = (int) Math.ceil((double) totalTiers / pageSize);
            
            // Set request attributes
            request.setAttribute("accountTiers", accountTiers);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalTiers", totalTiers);
            
            // Forward to JSP
            request.getRequestDispatcher("/admin_accountTier.jsp").forward(request, response);
            return;
            
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi: " + e.getMessage());
            request.getRequestDispatcher("/admin_accountTier.jsp").forward(request, response);
        }
    }
    
    private void handleAdd(HttpServletRequest request, HttpServletResponse response) {
        try {
            String name = request.getParameter("name");
            BigDecimal price = new BigDecimal(request.getParameter("price"));
            int durationDays = Integer.parseInt(request.getParameter("durationDays"));
            String description = request.getParameter("description");
            String userTypeScope = request.getParameter("userTypeScope");
            int status = Integer.parseInt(request.getParameter("status"));
            
            AccountTier newTier = new AccountTier(0, name, price, durationDays, description, userTypeScope, status);
            
            if (accountTierDAO.addAccountTier(newTier)) {
                request.setAttribute("success", "Thêm gói tài khoản thành công");
            } else {
                request.setAttribute("error", "Không thể thêm gói tài khoản");
            }
            
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi khi thêm gói tài khoản: " + e.getMessage());
        }
    }
    
    private void handleUpdate(HttpServletRequest request, HttpServletResponse response) {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            BigDecimal price = new BigDecimal(request.getParameter("price"));
            int durationDays = Integer.parseInt(request.getParameter("durationDays"));
            String description = request.getParameter("description");
            String userTypeScope = request.getParameter("userTypeScope");
            int status = Integer.parseInt(request.getParameter("status"));
            
            AccountTier tier = new AccountTier(id, name, price, durationDays, description, userTypeScope, status);
            
            if (accountTierDAO.updateAccountTier(tier)) {
                request.setAttribute("success", "Cập nhật gói tài khoản thành công");
            } else {
                request.setAttribute("error", "Không thể cập nhật gói tài khoản");
            }
            
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi khi cập nhật gói tài khoản: " + e.getMessage());
        }
    }
    
    private void handleDelete(HttpServletRequest request, HttpServletResponse response) {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            
            if (accountTierDAO.deleteAccountTier(id)) {
                request.setAttribute("success", "Xóa gói tài khoản thành công");
            } else {
                request.setAttribute("error", "Không thể xóa gói tài khoản");
            }
            
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi khi xóa gói tài khoản: " + e.getMessage());
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
