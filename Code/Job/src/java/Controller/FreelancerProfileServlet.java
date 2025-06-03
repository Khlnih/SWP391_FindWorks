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
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author DELL
 */
@WebServlet(name = "FreelancerProfileServlet", urlPatterns = {"/freelancer-profile"})
public class FreelancerProfileServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Freelancer freelancer = (Freelancer) session.getAttribute("loggedFreelancer");
        if (freelancer == null) {
            response.sendRedirect("loginjobseeker.jsp");
            return;
        }

        // Lấy dữ liệu từ form
        String password = request.getParameter("password");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String image = request.getParameter("image");
        boolean gender = Boolean.parseBoolean(request.getParameter("gender"));
        String dob = request.getParameter("dob");
        String describe = request.getParameter("describe");
        String emailContact = request.getParameter("emailContact");
        String phoneContact = request.getParameter("phoneContact");

        // Cập nhật thông tin
        freelancer.setPassword(password);
        freelancer.setFirstName(firstName);
        freelancer.setLastName(lastName);
        freelancer.setImage(image);
        freelancer.setGender(gender);
        freelancer.setDob(dob);
        freelancer.setDescribe(describe);
        freelancer.setEmailContact(emailContact);
        freelancer.setPhoneContact(phoneContact);

        // Lưu vào DB
        FreelancerDAO dao = new FreelancerDAO();
        dao.updateFreelancer(freelancer);  // bạn cần cài đặt hàm này

        session.setAttribute("loggedFreelancer", freelancer);
        request.setAttribute("message", "Cập nhật thành công!");
        request.getRequestDispatcher("freelancer_profile.jsp").forward(request, response);
    }
}
