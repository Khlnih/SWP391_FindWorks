/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.RecruiterDAO;
import Model.Recruiter;
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
@WebServlet(name = "RecruitRegister", urlPatterns = {"/recruitregister"})
public class RecruitRegister extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        boolean gender = Boolean.parseBoolean(request.getParameter("gender")); // "true"/"false"
        String dob = request.getParameter("dob");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        String image = "images/default.png"; // hoặc cho upload ảnh sau

        RecruiterDAO dao = new RecruiterDAO();

        if (dao.isUsernameOrEmailExists(username, email)) {
            request.setAttribute("error", "Username hoặc Email đã tồn tại.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else {
            Recruiter r = new Recruiter(username, password, firstName, lastName, gender, dob, image, email, phone);
            if (dao.registerRecruiter(r)) {
                response.sendRedirect("login.jsp"); // hoặc trang welcome
            } else {
                request.setAttribute("error", "Đăng ký thất bại.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        }
    }
}

