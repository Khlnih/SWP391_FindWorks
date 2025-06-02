package Controller;

import Model.Recruiter;
import DAO.RecruiterDAO; // Assuming RecruiterDAO is in DAO package
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.sql.SQLException;


public class RecruitRegisterServlet extends HttpServlet {

    // Helper method to hash password (SHA-256)
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] messageDigest = md.digest(password.getBytes("UTF-8"));
            
            // Convert byte array into signum representation
            BigInteger no = new BigInteger(1, messageDigest);
            
            // Convert message digest into hex value
            String hashtext = no.toString(16);
            
            // Add preceding 0s to make it 64 characters long (SHA-256 produces 32 bytes -> 64 hex chars)
            while (hashtext.length() < 64) { // Corrected length for SHA-256 hex string
                hashtext = "0" + hashtext;
            }
            return hashtext;
        } catch (NoSuchAlgorithmException | UnsupportedEncodingException e) {
            // In a real app, log this error and handle it more gracefully
            throw new RuntimeException("Password hashing failed", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String password = request.getParameter("password");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String genderStr = request.getParameter("gender"); // e.g., "male", "female", "nam", "nữ"
        String dobStr = request.getParameter("dob"); // Expected format: "yyyy-MM-dd"
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        // --- Basic Validation (optional, but recommended) ---
        if (password == null || password.isEmpty() ||
            firstName == null || firstName.isEmpty() ||
            lastName == null || lastName.isEmpty() ||
            genderStr == null || genderStr.isEmpty() ||
            dobStr == null || dobStr.isEmpty() ||
            email == null || email.isEmpty() ||
            phone == null || phone.isEmpty()) {
            
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        Recruiter recruiter = new Recruiter();

        // 1. Hash Password
        String hashedPassword = hashPassword(password);
        recruiter.setPassword_hash(hashedPassword); // Use the correct setter from your model

        // 2. Set Name fields
        recruiter.setFirst_name(firstName); // Or setFirstName(firstName) if that's preferred
        recruiter.setLast_name(lastName);   // Or setLastName(lastName)

        // 3. Convert and Set Gender
        // Assuming "male" or "nam" corresponds to true (1), "female" or "nữ" to false (0)
        boolean genderValue;
        if ("male".equalsIgnoreCase(genderStr) || "nam".equalsIgnoreCase(genderStr)) {
            genderValue = true;
        } else if ("female".equalsIgnoreCase(genderStr) || "nữ".equalsIgnoreCase(genderStr)) {
            genderValue = false;
        } else {
            request.setAttribute("error", "Invalid gender value. Use 'male', 'female', 'nam', or 'nữ'.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        recruiter.setGender(genderValue);

        // 4. Convert and Set Date of Birth
        java.sql.Date sqlDob;
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            sdf.setLenient(false); // Make sure the date format is strictly followed
            java.util.Date utilDate = sdf.parse(dobStr);
            sqlDob = new java.sql.Date(utilDate.getTime());
        } catch (ParseException e) {
            request.setAttribute("error", "Invalid date format for Date of Birth. Please use YYYY-MM-DD.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        recruiter.setDob(sqlDob);

        // 5. Set other fields
        recruiter.setImage(null); // Default image
        recruiter.setMoney(BigDecimal.valueOf(0.0)); // Default money
        recruiter.setEmail_contact(email); // Or setEmailContact(email)
        recruiter.setPhone_contact(phone); // Or setPhoneContact(phone)
        recruiter.setStatus("inactive");  // Default status as per your original comment, or "pending"
        recruiter.setStatusChangedByAdminID(null); // No admin has changed status yet

        RecruiterDAO dao = new RecruiterDAO();
        try {
            boolean success = dao.registerRecruiter(recruiter);
            if (success) {
                // Optionally, set a success message in session/request for register_success.jsp
                HttpSession session = request.getSession();
                session.setAttribute("successMessage", "Registration successful! Your account is pending activation or review.");
                response.sendRedirect("register_success.jsp");
            } else {
                // This 'else' might not be reached if registerRecruiter throws SQLException on failure
                request.setAttribute("error", "Registration failed. Please try again. The email or phone might already be in use.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the full stack trace for debugging
            String errorMessage = "Registration failed due to a database error: " + e.getMessage();
             // Check for unique constraint violation (more robustly than string matching if DB error codes are available)
            if (e.getMessage().toLowerCase().contains("unique constraint") || 
                e.getMessage().toLowerCase().contains("duplicate key") ||
                (e.getSQLState() != null && (e.getSQLState().equals("23000") || e.getSQLState().equals("23505")))) { // Common SQL states for unique violations
                errorMessage = "Registration failed: The email or phone number is already registered.";
            }
            request.setAttribute("error", errorMessage);
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } catch (Exception e) { // Catch other potential runtime exceptions (e.g., from hashPassword)
            e.printStackTrace();
            request.setAttribute("error", "An unexpected error occurred: " + e.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}