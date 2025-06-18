<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.UserLoginInfo, DAO.RecruiterDAO, Model.Recruiter, java.text.NumberFormat, java.util.Locale, java.util.List, java.util.ArrayList"%>

<%
    // Logic JSP giữ nguyên
    UserLoginInfo user = (UserLoginInfo) session.getAttribute("user");
    if (user == null || !"recruiter".equals(user.getUserType())) {
        response.sendRedirect("login.jsp");
        return;
    }
    RecruiterDAO recruiterDAO = new RecruiterDAO();
    Recruiter recruiter = recruiterDAO.getRecruiterById(user.getUserID());
    if (recruiter == null) {
        response.sendRedirect("login.jsp?error=User+not+found");
        return;
    }
    String successMessage = (String) session.getAttribute("successMessage");
    if (successMessage != null) session.removeAttribute("successMessage");
    List<String> errorMessages = (List<String>) session.getAttribute("errorMessages");
    if (errorMessages == null) errorMessages = new ArrayList<>();
    else session.removeAttribute("errorMessages");
    NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
%>

<!doctype html>
<html class="no-js" lang="zxx">
<head>
    <!-- Head content và CSS giữ nguyên như cũ -->
    <meta charset="utf-8"><meta http-equiv="x-ua-compatible" content="ie=edge"><title>Recruiter Profile - Find Work</title><meta name="description" content=""><meta name="viewport" content="width=device-width, initial-scale=1"><link rel="shortcut icon" type="image/x-icon" href="img/favicon.png"><link rel="stylesheet" href="css/bootstrap.min.css"><link rel="stylesheet" href="css/owl.carousel.min.css"><link rel="stylesheet" href="css/magnific-popup.css"><link rel="stylesheet" href="css/font-awesome.min.css"><link rel="stylesheet" href="css/themify-icons.css"><link rel="stylesheet" href="css/nice-select.css"><link rel="stylesheet" href="css/flaticon.css"><link rel="stylesheet" href="css/gijgo.css"><link rel="stylesheet" href="css/animate.min.css"><link rel="stylesheet" href="css/slicknav.css"><link rel="stylesheet" href="css/style.css">
    
    <!-- Custom Styles -->
    <style>
        /* Các style cũ giữ nguyên */
        .recruiter-profile-area { padding: 80px 0; background: #f5f7fa; }
        .profile-card { background: #fff; border-radius: 8px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); margin-bottom: 30px; }
        .profile-card-header { text-align: center; padding: 30px; border-bottom: 1px solid #e8e8e8; }
        .profile-card-header .thumb { margin-bottom: 15px; }
        .profile-card-header .thumb img { width: 150px; height: 150px; border-radius: 50%; object-fit: cover; border: 5px solid #fff; box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
        .profile-card-header h4 { font-size: 24px; font-weight: 600; margin-bottom: 5px; }
        .profile-card-header p { color: #7a838b; margin-bottom: 20px; }
        .profile-card-body { padding: 30px; }
        .info-card-title { font-size: 22px; margin-bottom: 25px; padding-bottom: 15px; border-bottom: 1px solid #e8e8e8; }
        .list-group-item { border: none; padding: .75rem 0; display: flex; justify-content: space-between; align-items: center; }
        .list-group-item .icon { margin-right: 15px; color: #00D363; width: 20px; text-align: center; }
        .status-badge { padding: 5px 12px; border-radius: 20px; font-size: 14px; color: #fff; text-transform: capitalize; }
        .status-active { background-color: #28a745; }
        .status-pending { background-color: #ffc107; color: #212529 !important; }
        .status-banned { background-color: #dc3545; }
        .modal-header { background-color: #00D363; color: white; }
        .modal-header .close { color: white !important; opacity: 1 !important; text-shadow: none !important; }
        .form-control.is-invalid { border-color: #dc3545; }
        .invalid-feedback { display: none; width: 100%; margin-top: .25rem; font-size: 80%; color: #dc3545; }
        .form-control.is-invalid ~ .invalid-feedback { display: block; }
        
        /* CSS CHO GIẢI PHÁP JAVASCRIPT */
        .modal-backdrop-custom {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1040; /* Phải thấp hơn z-index của modal */
            display: none;
        }
        #editProfileModal {
             z-index: 1050; /* Phải cao hơn z-index của backdrop */
        }
    </style>
</head>

<body>
    <!-- Header: Nhúng trực tiếp -->
    <header>
        <div class="header-area"><div id="sticky-header" class="main-header-area"><div class="container-fluid"><div class="header_bottom_border"><div class="row align-items-center"><div class="col-xl-3 col-lg-2"><div class="logo"><a href="index_recruiter.jsp"><img src="img/logo.png" alt=""></a></div></div><div class="col-xl-6 col-lg-7"><div class="main-menu d-none d-lg-block"><nav><ul id="navigation"><li><a href="index_recruiter.jsp">home</a></li><li><a href="post?action=list">My Jobs</a></li><li><a href="jobs.jsp">Browse Job</a></li><li><a href="#">pages <i class="ti-angle-down"></i></a><ul class="submenu"><li><a href="freelancer_list">Jobseekers</a></li></ul></li><li><a href="contact.jsp">Contact</a></li></ul></nav></div></div><div class="col-xl-3 col-lg-3 d-none d-lg-block"><div class="Appointment"><div class="phone_num d-none d-xl-block"><a href="recruiter_profile.jsp">My Profile</a></div><div class="phone_num d-none d-xl-block"><a href="${pageContext.request.contextPath}/logout">Log out</a></div><div class="d-none d-lg-block"><a class="boxed-btn3" href="post?action=create">Post a Job</a></div></div></div><div class="col-12"><div class="mobile_menu d-block d-lg-none"></div></div></div></div></div></div></div>
    </header>

    <!-- Breadcrumb -->
    <div class="bradcam_area bradcam_bg_1"><div class="container"><div class="row"><div class="col-xl-12"><div class="bradcam_text"><h3>My Profile</h3></div></div></div></div></div>

    <!-- Profile Section -->
    <div class="recruiter-profile-area">
        <div class="container">
            <!-- Display Messages -->
            <% if (successMessage != null) { %><div class="alert alert-success alert-dismissible fade show" role="alert"><%= successMessage %><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button></div><% } %>
            <% if (!errorMessages.isEmpty()) { %><div class="alert alert-danger alert-dismissible fade show" role="alert"><strong>Vui lòng sửa các lỗi sau:</strong><ul><% for (String error : errorMessages) { %><li><%= error %></li><% } %></ul><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button></div><% } %>

            <div class="row">
                <!-- Left Column: Profile Card -->
                <div class="col-lg-4">
                    <div class="profile-card">
                        <div class="profile-card-header">
                            <div class="thumb"><img src="${pageContext.request.contextPath}/<%= recruiter.getImage() != null && !recruiter.getImage().isEmpty() ? recruiter.getImage() : "img/candiateds/1.png" %>" alt="Profile Image"></div>
                            <h4><%= recruiter.getFirstName() %> <%= recruiter.getLastName() %></h4>
                            <p>@<%= recruiter.getUsername() %></p>
                            <!-- SỬA LỖI Ở ĐÂY: Dùng onclick để gọi hàm JS -->
                            <button type="button" class="boxed-btn3 w-100 mb-2" onclick="openEditModal()">
                                <i class="fa fa-pencil"></i> Edit Profile
                            </button>
                            <a href="index_recruiter.jsp" class="boxed-btn3-white w-100"><i class="fa fa-home"></i> Back to Home</a>
                        </div>
                    </div>
                </div>

                <!-- Right Column: Detailed Info -->
                <div class="col-lg-8"><div class="profile-card"><div class="profile-card-body"><h3 class="info-card-title">Personal Details</h3><ul class="list-group list-group-flush"><li class="list-group-item"><span><i class="fa fa-envelope icon"></i><strong>Email</strong></span><span><%= recruiter.getEmailContact() %></span></li><li class="list-group-item"><span><i class="fa fa-phone icon"></i><strong>Phone</strong></span><span><%= recruiter.getPhoneContact() != null && !recruiter.getPhoneContact().isEmpty() ? recruiter.getPhoneContact() : "N/A" %></span></li><li class="list-group-item"><span><i class="fa fa-venus-mars icon"></i><strong>Gender</strong></span><span><%= recruiter.isGender() ? "Male" : "Female" %></span></li><li class="list-group-item"><span><i class="fa fa-calendar icon"></i><strong>Date of Birth</strong></span><span><%= recruiter.getDob() != null && !recruiter.getDob().isEmpty() ? recruiter.getDob() : "N/A" %></span></li></ul><h3 class="info-card-title mt-5">Account Information</h3><ul class="list-group list-group-flush"><li class="list-group-item"><span><i class="fa fa-money icon"></i><strong>Balance</strong></span><span class="text-success font-weight-bold"><%= currencyFormatter.format(recruiter.getMoney()) %></span></li><li class="list-group-item"><span><i class="fa fa-info-circle icon"></i><strong>Status</strong></span><span><% String statusClass = ""; switch (recruiter.getStatus().toLowerCase()) { case "active": statusClass = "status-active"; break; case "pending": statusClass = "status-pending"; break; case "banned": statusClass = "status-banned"; break; } %><span class="status-badge <%= statusClass %>"><%= recruiter.getStatus() %></span></span></li></ul></div></div></div>
            </div>
        </div>
    </div>
    
    <!-- SỬA LỖI Ở ĐÂY: Thêm lớp nền mờ thủ công -->
    <div class="modal-backdrop-custom" id="modalBackdrop"></div>

    <!-- Edit Profile Modal -->
    <div class="modal" id="editProfileModal" tabindex="-1" role="dialog" aria-labelledby="editProfileModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <form action="updateRecruiterProfile" method="POST" id="editProfileForm" novalidate>
                    <div class="modal-header"><h5 class="modal-title" id="editProfileModalLabel">Edit Your Profile</h5>
                        <!-- SỬA LỖI Ở ĐÂY: Dùng onclick để gọi hàm JS -->
                        <button type="button" class="close" onclick="closeEditModal()" aria-label="Close"><span aria-hidden="true">×</span></button>
                    </div>
                    <div class="modal-body"><!-- Form content giữ nguyên --> <div class="row"><div class="col-md-6 form-group"><label for="firstName">First Name</label><input type="text" class="form-control" id="firstName" name="firstName" value="<%= recruiter.getFirstName() %>" required><div class="invalid-feedback"></div></div><div class="col-md-6 form-group"><label for="lastName">Last Name</label><input type="text" class="form-control" id="lastName" name="lastName" value="<%= recruiter.getLastName() %>" required><div class="invalid-feedback"></div></div></div><div class="form-group"><label for="emailContact">Email Contact</label><input type="email" class="form-control" id="emailContact" name="emailContact" value="<%= recruiter.getEmailContact() %>" required><div class="invalid-feedback"></div></div><div class="form-group"><label for="phoneContact">Phone Contact</label><input type="tel" class="form-control" id="phoneContact" name="phoneContact" value="<%= recruiter.getPhoneContact() != null ? recruiter.getPhoneContact() : "" %>"><div class="invalid-feedback"></div></div><div class="row"><div class="col-md-6 form-group"><label>Gender</label><div><div class="form-check form-check-inline"><input class="form-check-input" type="radio" name="gender" id="male" value="male" <%= recruiter.isGender() ? "checked" : "" %>><label class="form-check-label" for="male">Male</label></div><div class="form-check form-check-inline"><input class="form-check-input" type="radio" name="gender" id="female" value="female" <%= !recruiter.isGender() ? "checked" : "" %>><label class="form-check-label" for="female">Female</label></div></div></div><div class="col-md-6 form-group"><label for="dob">Date of Birth</label><input type="date" class="form-control" id="dob" name="dob" value="<%= recruiter.getDob() != null ? recruiter.getDob() : "" %>" required><div class="invalid-feedback"></div></div></div></div>
                    <div class="modal-footer">
                        <!-- SỬA LỖI Ở ĐÂY: Dùng onclick để gọi hàm JS -->
                        <button type="button" class="btn btn-secondary" onclick="closeEditModal()">Close</button>
                        <button type="submit" class="btn btn-primary" style="background-color: #00D363; border-color: #00D363;">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <!-- Footer: Nhúng trực tiếp -->
    <footer class="footer">
        <div class="footer_top"><div class="container"><div class="row"><div class="col-xl-3 col-md-6 col-lg-3"><div class="footer_widget"><div class="footer_logo"><a href="#"><img src="img/footer_logo.png" alt=""></a></div><p>5th flora, 700/D kings road, green <br> lane New York - 10010 <br><a href="#">+10 365 265 (8080)</a></p></div></div><div class="col-xl-2 col-md-6 col-lg-4"><div class="footer_widget"><h3 class="footer_title">Company</h3><ul class="links"><li><a href="#">About</a></li><li><a href="#">Blog</a></li><li><a href="#">Contact</a></li></ul></div></div><div class="col-xl-3 col-md-6 col-lg-4"><div class="footer_widget"><h3 class="footer_title">Popular Jobs</h3><ul class="links"><li><a href="#">Web Developer</a></li><li><a href="#">UI/UX Designer</a></li><li><a href="#">Project Manager</a></li></ul></div></div><div class="col-xl-3 col-md-6 col-lg-4"><div class="footer_widget"><h3 class="footer_title">Subscribe</h3><form action="#" class="newsletter_form"><input type="text" placeholder="Enter your mail"><button type="submit">Subscribe</button></form><p class="newsletter_text">Subscribe newsletter to get updates</p></div></div></div></div></div>
        <div class="copy-right_text"><div class="container"><div class="footer_border"></div><div class="row"><div class="col-xl-12"><p class="copy_right text-center">Copyright ©<script>document.write(new Date().getFullYear());</script> All rights reserved</p></div></div></div></div>
    </footer>

    <!-- JavaScript files -->
    <script src="js/vendor/jquery-1.12.4.min.js"></script><script src="js/popper.min.js"></script><script src="js/bootstrap.min.js"></script><script src="js/owl.carousel.min.js"></script><script src="js/isotope.pkgd.min.js"></script><script src="js/ajax-form.js"></script><script src="js/waypoints.min.js"></script><script src="js/jquery.counterup.min.js"></script><script src="js/imagesloaded.pkgd.min.js"></script><script src="js/scrollIt.js"></script><script src="js/jquery.scrollUp.min.js"></script><script src="js/wow.min.js"></script><script src="js/nice-select.min.js"></script><script src="js/jquery.slicknav.min.js"></script><script src="js/jquery.magnific-popup.min.js"></script><script src="js/plugins.js"></script><script src="js/gijgo.min.js"></script><script src="js/contact.js"></script><script src="js/jquery.ajaxchimp.min.js"></script><script src="js/jquery.form.js"></script><script src="js/jquery.validate.min.js"></script><script src="js/mail-script.js"></script><script src="js/main.js"></script>

    <!-- SỬA LỖI Ở ĐÂY: Script điều khiển Modal và Validation -->
    <script>
        (function() {
            'use strict';
            const modal = document.getElementById('editProfileModal');
            const backdrop = document.getElementById('modalBackdrop');
            const form = document.getElementById('editProfileForm');
            let validatedAfterSubmit = false;

            // ---- HÀM ĐIỀU KHIỂN MODAL ----
            window.openEditModal = function() {
                backdrop.style.display = 'block';
                modal.style.display = 'block';
                // Thêm class 'show' để có hiệu ứng fade-in (nếu CSS của Bootstrap hỗ trợ)
                setTimeout(() => {
                    backdrop.classList.add('show');
                    modal.classList.add('show');
                }, 10);
                document.body.classList.add('modal-open');
            };

            window.closeEditModal = function() {
                modal.classList.remove('show');
                backdrop.classList.remove('show');
                // Chờ hiệu ứng fade-out kết thúc rồi mới ẩn hoàn toàn
                setTimeout(() => {
                    modal.style.display = 'none';
                    backdrop.style.display = 'none';
                    document.body.classList.remove('modal-open');
                }, 300); // 300ms khớp với transition của Bootstrap
            };
            
            // Đóng modal khi nhấn phím Escape
            document.addEventListener('keydown', function(event) {
                if (event.key === 'Escape' && modal.style.display === 'block') {
                    closeEditModal();
                }
            });

            // ---- LOGIC VALIDATION (Giữ nguyên) ----
            const showError = (input, message) => {
                input.classList.add('is-invalid');
                const errorDiv = input.closest('.form-group').querySelector('.invalid-feedback');
                if (errorDiv) errorDiv.textContent = message;
            };
            const clearError = (input) => {
                input.classList.remove('is-invalid');
            };
            const validateInput = (input) => {
                clearError(input);
                const value = input.value.trim();
                if (input.required && value === '') { showError(input, 'Trường này là bắt buộc.'); return false; }
                switch(input.name) {
                    case 'firstName': case 'lastName': if (value.length > 0 && value.length < 2) { showError(input, 'Phải có ít nhất 2 ký tự.'); return false; } break;
                    case 'emailContact': if (value.length > 0 && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value)) { showError(input, 'Định dạng email không hợp lệ.'); return false; } break;
                    case 'phoneContact': if (value !== '' && !/^0\d{9}$/.test(value)) { showError(input, 'Số điện thoại không hợp lệ (10 số, bắt đầu bằng 0).'); return false; } break;
                    case 'dob':
                        if (value !== '') {
                            const birthDate = new Date(value); const today = new Date(); today.setHours(0, 0, 0, 0);
                            if (birthDate > today) { showError(input, 'Ngày sinh không thể ở tương lai.'); return false; }
                            let age = today.getFullYear() - birthDate.getFullYear(); const m = today.getMonth() - birthDate.getMonth();
                            if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) age--;
                            if (age < 18) { showError(input, 'Bạn phải đủ 18 tuổi.'); return false; }
                        } break;
                }
                return true;
            };
            form.addEventListener('submit', function(event) {
                let isFormValid = true;
                Array.from(form.elements).forEach(input => { if (input.willValidate && !validateInput(input)) { isFormValid = false; } });
                if (!isFormValid) { event.preventDefault(); event.stopPropagation(); }
                validatedAfterSubmit = true;
            }, false);
            Array.from(form.elements).forEach(input => { if(input.willValidate){ input.addEventListener('input', () => { if (validatedAfterSubmit) { validateInput(input); } }); } });

            // Tự động mở lại modal nếu có lỗi từ server
            <% if (!errorMessages.isEmpty()) { %>
                document.addEventListener('DOMContentLoaded', function() {
                    openEditModal();
                });
            <% } %>
        })();
    </script>
</body>
</html>