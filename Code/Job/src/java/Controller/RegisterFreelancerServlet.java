/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.FreelancerDAO;
import Model.Freelancer;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Date;

/**
 *
 * @author DELL
 */
@WebServlet(name = "RegisterFreelancerServlet", urlPatterns = {"/RegisterFreelancerServlet"})
public class RegisterFreelancerServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        FreelancerDAO dao = new FreelancerDAO();

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        

        if (dao.isUsernameExist(username)) {
            request.setAttribute("error", "Username đã tồn tại.");
            request.getRequestDispatcher("registerjobseeker.jsp").forward(request, response);
            return;
        }

        if (dao.isEmailExist(email)) {
            request.setAttribute("error", "Email đã tồn tại.");
            request.getRequestDispatcher("registerjobseeker.jsp").forward(request, response);
            return;
        }

        // Nếu không trùng → tạo đối tượng Freelancer
        Freelancer f = new Freelancer();
        f.setUsername(username);
        f.setPassword(request.getParameter("password")); // Lưu ý: nên mã hóa!
        f.setFirstName(request.getParameter("first_name"));
        f.setLastName(request.getParameter("last_name"));
        f.setImage(request.getParameter("image"));
        f.setGender(Boolean.parseBoolean(request.getParameter("gender")));
        f.setDob(request.getParameter("dob"));
        f.setDescribe(request.getParameter("describe"));
        f.setEmailContact(email);
        f.setPhoneContact(request.getParameter("phone"));
        f.setStatus("Pending");
        f.setStatusChangedByAdminID(null); // chưa có admin can thiệp

        if (dao.registerFreelancer(f)) {
            response.sendRedirect("loginjobseeker.jsp");
        } else {
            request.setAttribute("error", "Đăng ký thất bại.");
            request.getRequestDispatcher("registerjobseeker.jsp").forward(request, response);
        }
    }
}
