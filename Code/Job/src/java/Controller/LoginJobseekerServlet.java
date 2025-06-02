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

        String userIdentifier = request.getParameter("Email");
        String passwordInput = request.getParameter("password");

        if (userIdentifier == null || passwordInput == null) {
            request.setAttribute("error", "Username/email and password are required!");
            request.getRequestDispatcher("loginjobseeker.jsp").forward(request, response);
            return;
        }

        loginjobseekerDAO dao = new loginjobseekerDAO();
        UserLoginInfo user = dao.getUserLoginInfo(userIdentifier);

        if (user != null && user.getPassword().equals(passwordInput)) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user); // lưu thông tin user vào session

            response.sendRedirect("index.jsp"); // điều hướng đến trang chính sau khi login
        } else {
            request.setAttribute("error", "Invalid username/email or password!");
            request.getRequestDispatcher("loginjobseeker.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("loginjobseeker.jsp").forward(request, response);
    }
}


