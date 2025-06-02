package Controller;

import DAO.RecruiterDAO;
import Model.Recruiter;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "RecruitRegister", urlPatterns = {"/recruitregister"})
public class RecruitRegister extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // Lấy dữ liệu từ form
        String password = request.getParameter("password");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        boolean gender = Boolean.parseBoolean(request.getParameter("gender"));
        String dobStr = request.getParameter("dob");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String image = "images/default.png";

        RecruiterDAO dao = new RecruiterDAO();

        // Kiểm tra email hoặc số điện thoại đã tồn tại
        if (dao.isEmailOrPhoneExists(email, phone)) {
            request.setAttribute("error", "Email hoặc số điện thoại đã tồn tại.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else {
            try {
                Date dob = Date.valueOf(dobStr); // Convert từ String sang java.sql.Date

                // Tạo đối tượng Recruiter đầy đủ
                Recruiter recruiter = new Recruiter(
                    0, // recruiterID - sẽ auto tăng trong DB
                    password,
                    firstName,
                    lastName,
                    gender,
                    dob,
                    image,
                    BigDecimal.ZERO, // money
                    email,
                    phone,
                    "Active", // hoặc "Pending", tuỳ logic hệ thống
                    null // statusChangedByAdminID
                );

                if (dao.addRecruiter(recruiter)) {
                    response.sendRedirect("login.jsp");
                } else {
                    request.setAttribute("error", "Đăng ký thất bại.");
                    request.getRequestDispatcher("register.jsp").forward(request, response);
                }
            } catch (IllegalArgumentException e) {
                request.setAttribute("error", "Ngày sinh không hợp lệ.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        }
    }
}
