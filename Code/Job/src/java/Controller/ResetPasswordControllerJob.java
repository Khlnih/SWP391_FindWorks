package Controller;

import DAO.loginjobseekerDAO;
import java.io.IOException;
import java.util.Properties;
import java.util.Random;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ResetPasswordControllerJob", urlPatterns = {"/resetpasswordjob"})
public class ResetPasswordControllerJob extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private loginjobseekerDAO loginjobseekerDAO;

    @Override
    public void init() throws ServletException {
        loginjobseekerDAO = new loginjobseekerDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("forgotpasswordjob.jsp");
            return;
        }

        switch (action) {
            case "sendOTP":
                handleSendOTP(request, response, session);
                break;
            case "verifyOTP":
                handleVerifyOTP(request, response, session);
                break;
            case "resetPassword":
                handleResetPassword(request, response, session);
                break;
            default:
                response.sendRedirect("forgotpasswordjob.jsp");
        }
    }

    private void handleSendOTP(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        String email = request.getParameter("email");

        if (email == null || email.trim().isEmpty() || !isValidEmail(email)) {
            request.setAttribute("errorMessage", "Invalid email format!");
            request.getRequestDispatcher("forgotpasswordjob.jsp").forward(request, response);
            return;
        }

        boolean emailExists = loginjobseekerDAO.checkEmailExists(email);
        if (!emailExists) {
            request.setAttribute("errorMessage", "Email does not exist!");
            request.getRequestDispatcher("forgotpasswordjob.jsp").forward(request, response);
            return;
        }

        String otp = generateOTP();
        session.setAttribute("otp", otp);
        session.setAttribute("userEmail", email);
        session.setMaxInactiveInterval(5 * 60); // 5 phút

        if (sendEmail(email, otp)) {
            response.sendRedirect("verifyotpjob.jsp");
        } else {
            request.setAttribute("errorMessage", "Failed to send email. Please try again.");
            request.getRequestDispatcher("forgotpasswordjob.jsp").forward(request, response);
        }
    }

    private void handleVerifyOTP(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        String enteredOTP = request.getParameter("otp");
        String sessionOTP = (String) session.getAttribute("otp");

        if (sessionOTP != null && sessionOTP.equals(enteredOTP)) {
            response.sendRedirect("resetpasswordjob.jsp");
        } else {
            request.setAttribute("errorMessage", "Invalid or expired OTP!");
            request.getRequestDispatcher("verifyotpjob.jsp").forward(request, response);
        }
    }

    private void handleResetPassword(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        String email = (String) session.getAttribute("userEmail");

        if (email == null) {
            response.sendRedirect("forgotpasswordjob.jsp");
            return;
        }

        if (newPassword == null || confirmPassword == null 
            || !newPassword.equals(confirmPassword) 
            || newPassword.length() < 6) {
            request.setAttribute("errorMessage", "Invalid password or passwords do not match!");
            request.getRequestDispatcher("resetpasswordjob.jsp").forward(request, response);
            return;
        }

        boolean success = loginjobseekerDAO.updatePasswordByEmail(email, newPassword);
        if (success) {
            session.invalidate();
            response.sendRedirect("loginjobseeker.jsp");
        } else {
            request.setAttribute("errorMessage", "Failed to reset password. Please try again.");
            request.getRequestDispatcher("resetpasswordjob.jsp").forward(request, response);
        }
    }

    private boolean isValidEmail(String email) {
        return email.matches("^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$");
    }

    private String generateOTP() {
        return String.format("%06d", new Random().nextInt(1000000));
    }

    private boolean sendEmail(String toEmail, String otp) {
        final String senderEmail = "jobaboard22@gmail.com";
        final String senderPassword = "hzxe ulsa atwk hgsz";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session mailSession = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        });

        try {
            Message message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(senderEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Password Reset OTP");
            message.setContent(
                    "<h3>Your OTP code is:</h3>" + 
                    "<h2 style='color:blue;'>" + otp + "</h2>", 
                    "text/html; charset=utf-8");

            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
}
