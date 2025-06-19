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
    private static final Pattern PASSWORD_PATTERN = Pattern.compile("^(?=.*[A-Z])(?=.*\\d).+$");

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
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        List<String> errors = new ArrayList<>();
        RecruiterDAO recruiterDAO = new RecruiterDAO();

        if ("changePassword".equals(action)) {
            // Xử lý đổi mật khẩu
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            if (currentPassword == null || currentPassword.trim().isEmpty()) {
                errors.add("Mật khẩu hiện tại không được để trống.");
            }
            if (newPassword == null || newPassword.trim().isEmpty()) {
                errors.add("Mật khẩu mới không được để trống.");
            }
            if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
                errors.add("Xác nhận mật khẩu mới không được để trống.");
            }
            if (!errors.isEmpty()) {
                session.setAttribute("errorMessages", errors);
                response.sendRedirect("recruiter_profile.jsp");
                return;
            }

            if (!recruiterDAO.checkPassword(userLogin.getUserID(), currentPassword)) {
                errors.add("Mật khẩu hiện tại không đúng.");
            } else if (!newPassword.equals(confirmPassword)) {
                errors.add("Mật khẩu mới và xác nhận không khớp.");
            } else if (newPassword.length() < 6) {
                errors.add("Mật khẩu mới phải có ít nhất 6 ký tự.");
            } else if (!PASSWORD_PATTERN.matcher(newPassword).matches()) {
                errors.add("Mật khẩu mới phải có ít nhất 1 chữ hoa và 1 chữ số.");
            } else {
                boolean success = recruiterDAO.updatePassword(userLogin.getUserID(), newPassword);
                if (success) {
                    session.setAttribute("successMessage", "Đổi mật khẩu thành công!");
                } else {
                    errors.add("Đổi mật khẩu thất bại. Vui lòng thử lại.");
                }
            }
        } else {
            // Xử lý cập nhật thông tin cá nhân
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String emailContact = request.getParameter("emailContact");
            String phoneContact = request.getParameter("phoneContact");
            String dobStr = request.getParameter("dob");
            boolean gender = "male".equals(request.getParameter("gender"));

            // Validation
            if (firstName == null || firstName.trim().isEmpty()) {
                errors.add("Họ không được để trống.");
            } else if (firstName.trim().length() < 2) {
                errors.add("Họ phải có ít nhất 2 ký tự.");
            } 
            
            if (lastName == null || lastName.trim().isEmpty()) {
                errors.add("Tên không được để trống.");
            } else if (lastName.trim().length() < 2) {
                errors.add("Tên phải có ít nhất 2 ký tự.");
            } 

            if (emailContact == null || emailContact.trim().isEmpty()) {
                errors.add("Email không được để trống.");
            } else if (!EMAIL_PATTERN.matcher(emailContact).matches()) {
                errors.add("Định dạng email không hợp lệ.");
            } else if (recruiterDAO.isEmailInUseByAnotherRecruiter(emailContact, userLogin.getUserID())) {
                errors.add("Email này đã được sử dụng bởi một tài khoản khác.");
            }
            
            if (phoneContact != null && !phoneContact.trim().isEmpty()) {
                if (!PHONE_VN_PATTERN.matcher(phoneContact).matches()) {
                    errors.add("Số điện thoại không hợp lệ (phải có 10 chữ số, bắt đầu bằng 0).");
                }
            }
            
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
            
            if (!errors.isEmpty()) {
                session.setAttribute("errorMessages", errors);
                response.sendRedirect("recruiter_profile.jsp");
                return;
            }

            // Cập nhật thông tin
            try {
                Recruiter updatedRecruiter = new Recruiter();
                updatedRecruiter.setRecruiterID(userLogin.getUserID());
                updatedRecruiter.setFirstName(firstName.trim());
                updatedRecruiter.setLastName(lastName.trim());
                updatedRecruiter.setEmailContact(emailContact.trim());
                updatedRecruiter.setPhoneContact(phoneContact != null ? phoneContact.trim() : "");
                updatedRecruiter.setDob(dobStr);
                updatedRecruiter.setGender(gender);

                boolean success = recruiterDAO.updateRecruiterProfile(updatedRecruiter);

                if (success) {
                    session.setAttribute("successMessage", "Hồ sơ đã được cập nhật thành công!");
                } else {
                    errors.add("Cập nhật hồ sơ thất bại do lỗi hệ thống. Vui lòng thử lại.");
                    session.setAttribute("errorMessages", errors);
                }
            } catch (Exception e) {
                errors.add("Đã xảy ra lỗi không mong muốn: " + e.getMessage());
                session.setAttribute("errorMessages", errors);
            }
        }
        response.sendRedirect("recruiter_profile.jsp");
    }
}
