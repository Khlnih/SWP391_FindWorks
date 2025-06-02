package Controller;

import DAO.loginDAO;
import Model.UserLoginInfo;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String emailInput = request.getParameter("Email");
        String passwordInput = request.getParameter("password");

        if (emailInput == null || emailInput.trim().isEmpty() ||
            passwordInput == null || passwordInput.isEmpty()) {
            request.setAttribute("error", "Email and password are required!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        loginDAO dao = new loginDAO();
        UserLoginInfo user = dao.getUserLoginInfo(emailInput);

        if (user != null && user.getPassword().equals(passwordInput)) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user); // lưu thông tin user vào session
            // Có thể lưu thêm email vào session nếu cần truy cập nhanh
            // session.setAttribute("email", user.getEmail()); 

            response.sendRedirect("index.jsp"); // điều hướng đến trang chính sau khi login
        } else {
            // 3. Cập nhật thông báo lỗi
            request.setAttribute("error", "Invalid email or password!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}