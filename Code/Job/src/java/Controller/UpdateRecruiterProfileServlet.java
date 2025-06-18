package Controller;

import DAO.RecruiterDAO;
import Model.Recruiter;
import Model.UserLoginInfo;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.time.Period;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

@WebServlet(name = "UpdateRecruiterProfileServlet", urlPatterns = {"/updateRecruiterProfile"})
public class UpdateRecruiterProfileServlet extends HttpServlet {

    private static final Pattern PHONE_VN_PATTERN = Pattern.compile("^0\\d{9}$");
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$");

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        UserLoginInfo userLogin = (UserLoginInfo) session.getAttribute("user");
        if (!"recruiter".equals(userLogin.getUserType())) {
            response.sendRedirect("login.jsp"); // Không đúng vai trò
            return;
        }

        List<String> errors = new ArrayList<>();
        
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String emailContact = request.getParameter("emailContact");
        String phoneContact = request.getParameter("phoneContact");
        String dobStr = request.getParameter("dob");
        boolean gender = "male".equals(request.getParameter("gender"));

        // ===== BẮT ĐẦU VALIDATION SERVER-SIDE =====

        // 1. Kiểm tra Họ (First Name)
        if (firstName == null || firstName.trim().isEmpty()) {
            errors.add("Họ không được để trống.");
        } else if (firstName.trim().length() < 2) {
            errors.add("Họ phải có ít nhất 2 ký tự.");
        } 
        
        // 2. Kiểm tra Tên (Last Name)
        if (lastName == null || lastName.trim().isEmpty()) {
            errors.add("Tên không được để trống.");
        } else if (lastName.trim().length() < 2) {
            errors.add("Tên phải có ít nhất 2 ký tự.");
        } 

        // 3. Kiểm tra Email
        RecruiterDAO recruiterDAO = new RecruiterDAO();
        if (emailContact == null || emailContact.trim().isEmpty()) {
            errors.add("Email không được để trống.");
        } else if (!EMAIL_PATTERN.matcher(emailContact).matches()) {
            errors.add("Định dạng email không hợp lệ.");
        } else if (recruiterDAO.isEmailInUseByAnotherRecruiter(emailContact, userLogin.getUserID())) {
            errors.add("Email này đã được sử dụng bởi một tài khoản khác.");
        }
        
        // 4. Kiểm tra Số điện thoại (nếu có nhập)
        if (phoneContact != null && !phoneContact.trim().isEmpty()) {
            if (!PHONE_VN_PATTERN.matcher(phoneContact).matches()) {
                errors.add("Số điện thoại không hợp lệ (phải có 10 chữ số, bắt đầu bằng 0).");
            }
        }
        
        // 5. Kiểm tra Ngày sinh
        if (dobStr == null || dobStr.trim().isEmpty()) {
            errors.add("Ngày sinh không được để trống.");
        } else {
            try {
                LocalDate dob = LocalDate.parse(dobStr);
                LocalDate today = LocalDate.now();
                if (dob.isAfter(today)) {
                    errors.add("Ngày sinh không thể là một ngày trong tương lai.");
                } else if (Period.between(dob, today).getYears() < 18) {
                    errors.add("Bạn phải đủ 18 tuổi để đăng ký.");
                }
            } catch (Exception e) {
                errors.add("Định dạng ngày sinh không hợp lệ.");
            }
        }
        
        // ===== KẾT THÚC VALIDATION =====
        
        if (!errors.isEmpty()) {
            // Nếu có lỗi, gửi danh sách lỗi về lại trang JSP và không cập nhật DB
            session.setAttribute("errorMessages", errors);
            response.sendRedirect("recruiter_profile.jsp");
            return;
        }

        // Nếu không có lỗi, tiến hành cập nhật
        try {
            Recruiter updatedRecruiter = new Recruiter();
            updatedRecruiter.setRecruiterID(userLogin.getUserID());
            updatedRecruiter.setFirstName(firstName.trim());
            updatedRecruiter.setLastName(lastName.trim());
            updatedRecruiter.setEmailContact(emailContact.trim());
            updatedRecruiter.setPhoneContact(phoneContact.trim());
            updatedRecruiter.setDob(dobStr);
            updatedRecruiter.setGender(gender);

            boolean success = recruiterDAO.updateRecruiterProfile(updatedRecruiter);

            if (success) {
                session.setAttribute("successMessage", "Hồ sơ đã được cập nhật thành công!");
            } else {
                errors.add("Cập nhật hồ sơ thất bại do lỗi hệ thống. Vui lòng thử lại.");
                session.setAttribute("errorMessages", errors);
            }
            response.sendRedirect("recruiter_profile.jsp");
            
        } catch (Exception e) {
            e.printStackTrace();
            errors.add("Đã xảy ra lỗi không mong muốn: " + e.getMessage());
            session.setAttribute("errorMessages", errors);
            response.sendRedirect("recruiter_profile.jsp");
        }
    }
}