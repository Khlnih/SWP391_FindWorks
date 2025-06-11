/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.loginjobseekerDAO;
import Model.UserLoginInfo;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author DELL
 */
@WebServlet(name = "LoginJobseekerServlet", urlPatterns = {"/loginjobseeker"})
public class LoginJobseekerServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userIdentifier = request.getParameter("usernameOrEmail");
        String passwordInput = request.getParameter("password");

        // SỬA Ở ĐÂY: Kiểm tra đầu vào mạnh mẽ hơn, kiểm tra cả chuỗi rỗng
        if (userIdentifier == null || userIdentifier.trim().isEmpty() ||
            passwordInput == null || passwordInput.trim().isEmpty()) {
            // SỬA Ở ĐÂY: Thông báo lỗi bằng tiếng Việt và rõ ràng hơn
            request.setAttribute("error", "Tên đăng nhập/Email và mật khẩu không được để trống!");
            request.getRequestDispatcher("loginjobseeker.jsp").forward(request, response);
            return;
        }

        loginjobseekerDAO dao = new loginjobseekerDAO();
        UserLoginInfo user = dao.getUserLoginInfo(userIdentifier);
        
        // Dòng này dùng để debug, có thể giữ lại hoặc xóa đi
        PrintWriter out = response.getWriter();
        out.print(user);

        if (user != null && user.getPassword().equals(passwordInput)) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user); 

            // Jobseeker sau khi đăng nhập thành công sẽ được chuyển đến trang index.jsp
            response.sendRedirect("index.jsp"); 
        } else {
            // SỬA Ở ĐÂY: Thêm log ở server để dễ dàng debug
            System.out.println("Login failed for identifier: " + userIdentifier); 
            // SỬA Ở ĐÂY: Thông báo lỗi bằng tiếng Việt và rõ ràng hơn
            request.setAttribute("error", "Tên đăng nhập/Email hoặc mật khẩu không chính xác!");
            request.getRequestDispatcher("loginjobseeker.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("loginjobseeker.jsp").forward(request, response);
    }
}