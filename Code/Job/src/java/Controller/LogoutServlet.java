package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "LogoutServlet", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Lấy session nếu đã tồn tại
        if (session != null) {
            session.invalidate(); // Hủy session
        }
        response.sendRedirect("login.jsp"); // Chuyển hướng về trang login
    }
}
