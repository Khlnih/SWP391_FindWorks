package Controller;

import DAO.loginDAO;
import Model.UserLoginInfo;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userIdentifier = request.getParameter("usernameOrEmail");
        String passwordInput = request.getParameter("password");

        if (userIdentifier == null || userIdentifier.trim().isEmpty() ||
            passwordInput == null || passwordInput.trim().isEmpty()) { // SỬA Ở ĐÂY
            request.setAttribute("error", "Tên đăng nhập/Email và mật khẩu không được để trống!"); // SỬA Ở ĐÂY
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        loginDAO dao = new loginDAO();
        UserLoginInfo user = dao.getUserLoginInfo(userIdentifier);
        PrintWriter out = response.getWriter();
        out.print(user);
        // So sánh mật khẩu dạng thuần
        if (user != null && user.getPassword().equals(passwordInput)) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user); // lưu thông tin user vào session

             
            
            response.sendRedirect(request.getContextPath() + "/index_recruiter.jsp"); 
        } else {
            System.out.println("Login failed for identifier: " + userIdentifier); // Thêm log để debug
            request.setAttribute("error", "Tên đăng nhập/Email hoặc mật khẩu không chính xác!"); // SỬA Ở ĐÂY
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}