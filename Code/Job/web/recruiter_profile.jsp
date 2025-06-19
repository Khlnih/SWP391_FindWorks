<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.UserLoginInfo, DAO.RecruiterDAO, Model.Recruiter, java.text.NumberFormat, java.util.Locale, java.util.List, java.util.ArrayList"%>

<%
    // Kiểm tra session và phân quyền
    UserLoginInfo user = (UserLoginInfo) session.getAttribute("user");
    if (user == null || !"recruiter".equals(user.getUserType())) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Lấy thông tin recruiter
    RecruiterDAO recruiterDAO = new RecruiterDAO();
    Recruiter recruiter = recruiterDAO.getRecruiterById(user.getUserID());
    if (recruiter == null) {
        // Xử lý trường hợp không tìm thấy recruiter
        response.sendRedirect("login.jsp?error=User+not+found");
        return;
    }

    // Lấy và xóa thông báo từ session
    String successMessage = (String) session.getAttribute("successMessage");
    if (successMessage != null) session.removeAttribute("successMessage");

    List<String> errorMessages = (List<String>) session.getAttribute("errorMessages");
    if (errorMessages == null) {
        errorMessages = new ArrayList<>();
    } else {
        session.removeAttribute("errorMessages");
    }

    // Định dạng tiền tệ
    NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
    
    // Chuẩn bị thông tin cho header
    String avatarPath = "img/candiateds/1.png"; // Default avatar
    String userName = "User";
    
    if (recruiter.getImage() != null && !recruiter.getImage().isEmpty()) {
        avatarPath = recruiter.getImage();
    }
    userName = recruiter.getFirstName();
%>

<!doctype html>
<html class="no-js" lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Recruiter Profile - Find Work</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="shortcut icon" type="image/x-icon" href="img/favicon.png">

    <!-- CSS Files - Giữ nguyên như theme gốc -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <link rel="stylesheet" href="css/magnific-popup.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/themify-icons.css">
    <link rel="stylesheet" href="css/nice-select.css">
    <link rel="stylesheet" href="css/flaticon.css">
    <link rel="stylesheet" href="css/gijgo.css">
    <link rel="stylesheet" href="css/animate.min.css">
    <link rel="stylesheet" href="css/slicknav.css">
    <link rel="stylesheet" href="css/style.css">
    
    <!-- CSS từ CDN để có các icon mới (FontAwesome 5) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    <style>
        /* CSS cho header được đồng bộ từ index_recruiter.jsp */
        .profile-btn {
            display: flex !important;
            align-items: center;
            background: linear-gradient(135deg, #00D363 0%, #28a745 100%) !important;
            color: white !important;
            padding: 8px 16px;
            border-radius: 25px;
            text-decoration: none !important;
            transition: all 0.3s ease;
            box-shadow: 0 2px 10px rgba(0, 211, 99, 0.3);
            margin-right: 10px;
            font-weight: 500;
        }
        
        .profile-btn:hover {
            background: linear-gradient(135deg, #28a745 0%, #00D363 100%) !important;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 211, 99, 0.4);
            color: white !important;
            text-decoration: none !important;
        }
        
        .profile-avatar-header { /* Đổi tên từ profile-avatar để tránh xung đột */
            width: 32px;
            height: 32px;
            border-radius: 50%;
            border: 2px solid white;
            margin-right: 10px;
            object-fit: cover;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .profile-text {
            font-weight: 600;
            letter-spacing: 0.3px;
        }
        
        .logout-btn {
            color: #dc3545 !important;
            font-weight: 500;
            padding: 8px 12px;
            border-radius: 20px;
            transition: all 0.3s ease;
            text-decoration: none !important;
            margin-right: 10px;
        }
        
        .logout-btn:hover {
            background-color: #dc3545 !important;
            color: white !important;
            text-decoration: none !important;
        }

        .Appointment {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        /* CSS tùy chỉnh cho trang profile, đồng bộ với màu xanh lá của theme */
        body {
            background-color: #f8f9fa;
        }
        
        .profile-container {
            max-width: 1200px;
            margin: 50px auto;
            padding: 20px;
        }
        
        .profile-card {
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            overflow: hidden;
            margin-bottom: 30px;
        }
        
        .profile-header {
            /* Đồng bộ màu xanh lá của theme */
            background: linear-gradient(135deg, #00D363 0%, #28a745 100%) !important;
            color: white;
            padding: 40px;
            text-align: center;
        }
        
        .profile-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            border: 5px solid white;
            margin: 0 auto 20px;
            object-fit: cover;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        
        .profile-name { font-size: 28px; font-weight: 600; margin-bottom: 5px; color: white; }
        .profile-username { opacity: 0.9; font-size: 16px; color: white; }
        .profile-actions { margin-top: 25px; }
        
        .btn-profile {
            background: rgba(255,255,255,0.2);
            border: 2px solid white;
            color: white;
            padding: 12px 24px;
            border-radius: 25px;
            margin: 5px;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-profile:hover {
            background: white;
            color: #00D363; /* Màu xanh lá khi hover */
            text-decoration: none;
            transform: translateY(-2px);
        }
        
        .profile-body { padding: 40px; }
        .info-section { margin-bottom: 40px; }
        
        .section-title {
            font-size: 22px;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 25px;
            padding-bottom: 10px;
            /* Đồng bộ màu xanh lá của theme */
            border-bottom: 3px solid #00D363 !important;
            display: inline-block;
        }
        
        .info-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid #ecf0f1;
        }
        .info-item:last-child { border-bottom: none; }
        .info-label { font-weight: 600; color: #34495e; }
        .info-value { color: #7f8c8d; text-align: right; }
        
        .info-icon {
            /* Đồng bộ màu xanh lá của theme */
            color: #00D363 !important;
            margin-right: 10px;
            width: 20px;
        }
        
        .status-badge { padding: 6px 15px; border-radius: 20px; font-size: 12px; font-weight: 600; }
        .status-active { background: #d4edda; color: #155724; }
        .status-pending { background: #fff3cd; color: #856404; }
        .status-banned { background: #f8d7da; color: #721c24; }
        
        .balance-amount { font-size: 24px; font-weight: 700; color: #27ae60; }
        
        .modal-header {
            /* Đồng bộ màu xanh lá của theme */
            background: linear-gradient(135deg, #00D363 0%, #28a745 100%) !important;
            color: white;
            border-bottom: none;
        }
        .modal-content { border: none; border-radius: 8px; }
        
        .form-control:focus {
            border-color: #00D363;
            box-shadow: 0 0 0 0.2rem rgba(0, 211, 99, 0.25);
        }
        
        .alert { border-radius: 10px; }

        @media (max-width: 768px) {
            .info-item { flex-direction: column; align-items: flex-start; text-align: left; }
            .info-value { text-align: left; margin-top: 5px; }
        }
    </style>
</head>

<body>
    <!--[if lte IE 9]>
        <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="https://browsehappy.com/">upgrade your browser</a> to improve your experience and security.</p>
    <![endif]-->

    <!-- header-start (Đã được đồng bộ hoàn toàn với index_recruiter.jsp) -->
    <header>
        <div class="header-area">
            <div id="sticky-header" class="main-header-area">
                <div class="container-fluid">
                    <div class="header_bottom_border">
                        <div class="row align-items-center">
                            <div class="col-xl-3 col-lg-2">
                                <div class="logo">
                                    <a href="index_recruiter.jsp">
                                        <img src="img/logo.png" alt="">
                                    </a>
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-7">
                                <div class="main-menu d-none d-lg-block">
                                    <nav>
                                        <ul id="navigation">
                                            <li><a href="index_recruiter.jsp">Home</a></li>
                                            <li><a href="jobs">Browse Jobs</a></li>
                                            <li><a href="post?action=list">My Jobs</a></li>
                                            <li><a href="#">Pages <i class="ti-angle-down"></i></a>
                                                <ul class="submenu">
                                                    <li><a href="freelancer_list">Jobseekers</a></li>
                                                    <li><a href="job_details.jsp">Job Details</a></li>
                                                    <li><a href="elements.jsp">Elements</a></li>
                                                </ul>
                                            </li>
                                            <li><a href="contact.jsp">Contact</a></li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                            <div class="col-xl-3 col-lg-3 d-none d-lg-block">
                                <div class="Appointment">
                                    <!-- Profile Button with Avatar -->
                                    <div class="phone_num d-none d-xl-block">
                                        <a href="recruiter_profile.jsp" class="profile-btn">
                                            <img src="<%= avatarPath %>" alt="Avatar" class="profile-avatar-header">
                                            <span class="profile-text"><%= userName %></span>
                                        </a>
                                    </div>
                                    
                                    <!-- Logout Button -->
                                    <div class="phone_num d-none d-xl-block">
                                         <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
                                             <i class="ti-power-off"></i> Logout
                                         </a>
                                    </div>
                                    
                                    <!-- Post Job Button -->
                                    <div class="d-none d-lg-block">
                                        <a class="boxed-btn3" href="post?action=create">Post a Job</a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="mobile_menu d-block d-lg-none"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <!-- header-end -->

    <!-- Breadcrumb -->
    <div class="bradcam_area bradcam_bg_1">
        <div class="container">
            <div class="row">
                <div class="col-xl-12">
                    <div class="bradcam_text">
                        <h3>My Profile</h3>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Profile Content -->
    <div class="profile-container">
        <!-- Success/Error Messages -->
        <% if (successMessage != null) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i> <%= successMessage %>
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
        <% } %>
        
        <% if (!errorMessages.isEmpty()) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-triangle me-2"></i> <strong>Please fix the following errors:</strong>
                <ul class="mb-0 mt-2">
                    <% for (String error : errorMessages) { %>
                        <li><%= error %></li>
                    <% } %>
                </ul>
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
        <% } %>

        <div class="row">
            <!-- Profile Card -->
            <div class="col-lg-4">
                <div class="profile-card">
                    <div class="profile-header">
                        <img src="${pageContext.request.contextPath}/<%= recruiter.getImage() != null && !recruiter.getImage().isEmpty() ? recruiter.getImage() : "img/candiateds/1.png" %>" 
                             alt="Profile Image" class="profile-avatar">
                        <div class="profile-name"><%= recruiter.getFirstName() %> <%= recruiter.getLastName() %></div>
                        <div class="profile-username">@<%= recruiter.getUsername() %></div>
                        
                        <div class="profile-actions">
                            <a href="#" class="btn-profile" data-toggle="modal" data-target="#editProfileModal"><i class="fas fa-edit"></i> Edit Profile</a>
                            <a href="#" class="btn-profile" data-toggle="modal" data-target="#changePasswordModal"><i class="fas fa-lock"></i> Change Password</a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Profile Details -->
            <div class="col-lg-8">
                <div class="profile-card">
                    <div class="profile-body">
                        <!-- Personal Information -->
                        <div class="info-section">
                            <h3 class="section-title">Personal Information</h3>
                            <div class="info-item">
                                <span class="info-label"><i class="fas fa-envelope info-icon"></i>Email</span>
                                <span class="info-value"><%= recruiter.getEmailContact() %></span>
                            </div>
                            <div class="info-item">
                                <span class="info-label"><i class="fas fa-phone info-icon"></i>Phone</span>
                                <span class="info-value"><%= recruiter.getPhoneContact() != null && !recruiter.getPhoneContact().isEmpty() ? recruiter.getPhoneContact() : "Not provided" %></span>
                            </div>
                            <div class="info-item">
                                <span class="info-label"><i class="fas fa-venus-mars info-icon"></i>Gender</span>
                                <span class="info-value"><%= recruiter.isGender() ? "Male" : "Female" %></span>
                            </div>
                            <div class="info-item">
                                <span class="info-label"><i class="fas fa-calendar info-icon"></i>Date of Birth</span>
                                <span class="info-value"><%= recruiter.getDob() != null && !recruiter.getDob().isEmpty() ? recruiter.getDob() : "Not provided" %></span>
                            </div>
                        </div>

                        <!-- Account Information -->
                        <div class="info-section">
                            <h3 class="section-title">Account Information</h3>
                            <div class="info-item">
                                <span class="info-label"><i class="fas fa-wallet info-icon"></i>Balance</span>
                                <span class="info-value balance-amount"><%= currencyFormatter.format(recruiter.getMoney()) %></span>
                            </div>
                            <div class="info-item">
                                <span class="info-label"><i class="fas fa-info-circle info-icon"></i>Status</span>
                                <span class="info-value">
                                    <% 
                                        String statusClass = "status-pending"; // Default
                                        switch (recruiter.getStatus().toLowerCase()) {
                                            case "active": statusClass = "status-active"; break;
                                            case "banned": statusClass = "status-banned"; break;
                                        }
                                    %>
                                    <span class="status-badge <%= statusClass %>"><%= recruiter.getStatus() %></span>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Edit Profile Modal -->
    <div class="modal fade" id="editProfileModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <form action="updateRecruiterProfile" method="POST">
                    <div class="modal-header">
                        <h5 class="modal-title"><i class="fas fa-edit"></i> Edit Profile</h5>
                        <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6 form-group"><label>First Name</label><input type="text" class="form-control" name="firstName" value="<%= recruiter.getFirstName() %>" required></div>
                            <div class="col-md-6 form-group"><label>Last Name</label><input type="text" class="form-control" name="lastName" value="<%= recruiter.getLastName() %>" required></div>
                        </div>
                        <div class="form-group"><label>Email Contact</label><input type="email" class="form-control" name="emailContact" value="<%= recruiter.getEmailContact() %>" required></div>
                        <div class="form-group"><label>Phone Contact</label><input type="tel" class="form-control" name="phoneContact" value="<%= recruiter.getPhoneContact() != null ? recruiter.getPhoneContact() : "" %>"></div>
                        <div class="row">
                            <div class="col-md-6 form-group">
                                <label>Gender</label>
                                <div class="form-check"><input class="form-check-input" type="radio" name="gender" value="male" <%= recruiter.isGender() ? "checked" : "" %>><label class="form-check-label">Male</label></div>
                                <div class="form-check"><input class="form-check-input" type="radio" name="gender" value="female" <%= !recruiter.isGender() ? "checked" : "" %>><label class="form-check-label">Female</label></div>
                            </div>
                            <div class="col-md-6 form-group"><label>Date of Birth</label><input type="date" class="form-control" name="dob" value="<%= recruiter.getDob() != null ? recruiter.getDob() : "" %>" required></div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        <!-- Sử dụng button của theme -->
                        <button type="submit" class="boxed-btn3">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Change Password Modal -->
    <div class="modal fade" id="changePasswordModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="updateRecruiterProfile" method="POST" id="passwordForm">
                    <input type="hidden" name="action" value="changePassword">
                    <div class="modal-header">
                        <h5 class="modal-title"><i class="fas fa-lock"></i> Change Password</h5>
                        <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group"><label>Current Password</label><input type="password" class="form-control" name="currentPassword" required></div>
                        <div class="form-group">
                            <label>New Password</label><input type="password" class="form-control" name="newPassword" id="newPassword" required>
                            <small class="form-text text-muted">Must be at least 6 characters, with 1 uppercase letter and 1 number.</small>
                        </div>
                        <div class="form-group"><label>Confirm New Password</label><input type="password" class="form-control" name="confirmPassword" id="confirmPassword" required></div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        <!-- Sử dụng button nguy hiểm của Bootstrap -->
                        <button type="submit" class="btn btn-danger">Change Password</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Footer - Giữ nguyên như theme gốc -->
    <footer class="footer">
        <div class="footer_top">
            <div class="container">
                <div class="row">
                    <div class="col-xl-3 col-md-6 col-lg-3">
                        <div class="footer_widget">
                            <div class="footer_logo"><a href="#"><img src="img/footer_logo.png" alt=""></a></div>
                            <p>5th flora, 700/D kings road, green <br> lane New York - 10010 <br><a href="#">+10 365 265 (8080)</a></p>
                            <div class="socail_links">
                                <ul>
                                    <li><a href="#"><i class="ti-facebook"></i></a></li>
                                    <li><a href="#"><i class="ti-twitter-alt"></i></a></li>
                                    <li><a href="#"><i class="ti-instagram"></i></a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-2 col-md-6 col-lg-4">
                        <div class="footer_widget">
                            <h3 class="footer_title">For Recruiters</h3>
                            <ul class="links">
                                <li><a href="post?action=create">Post Jobs</a></li>
                                <li><a href="freelancer_list">Find Candidates</a></li>
                                <li><a href="post?action=list">Manage Jobs</a></li>
                                <li><a href="recruiter_profile.jsp">Profile</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6 col-lg-4">
                        <div class="footer_widget">
                            <h3 class="footer_title">Popular Categories</h3>
                            <ul class="links">
                                <li><a href="#">Web Developer</a></li>
                                <li><a href="#">UI/UX Designer</a></li>
                                <li><a href="#">Project Manager</a></li>
                                <li><a href="#">Digital Marketing</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6 col-lg-4">
                        <div class="footer_widget">
                            <h3 class="footer_title">Subscribe</h3>
                            <form action="#" class="newsletter_form">
                                <input type="text" placeholder="Enter your mail"><button type="submit">Subscribe</button>
                            </form>
                            <p class="newsletter_text">Subscribe newsletter to get updates</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="copy-right_text">
            <div class="container">
                <div class="footer_border"></div>
                <div class="row">
                    <div class="col-xl-12"><p class="copy_right text-center">Copyright ©<script>document.write(new Date().getFullYear());</script> All rights reserved</p></div>
                </div>
            </div>
        </div>
    </footer>

    <!-- JS Files - Giữ nguyên như theme gốc -->
    <script src="js/vendor/modernizr-3.5.0.min.js"></script>
    <script src="js/vendor/jquery-1.12.4.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/isotope.pkgd.min.js"></script>
    <script src="js/ajax-form.js"></script>
    <script src="js/waypoints.min.js"></script>
    <script src="js/jquery.counterup.min.js"></script>
    <script src="js/imagesloaded.pkgd.min.js"></script>
    <script src="js/scrollIt.js"></script>
    <script src="js/jquery.scrollUp.min.js"></script>
    <script src="js/wow.min.js"></script>
    <script src="js/nice-select.min.js"></script>
    <script src="js/jquery.slicknav.min.js"></script>
    <script src="js/main.js"></script> <!-- Thêm file main.js nếu cần -->
    
    <script>
        $(document).ready(function() {
            // Password validation
            $('#passwordForm').on('submit', function(e) {
                var newPassword = $('#newPassword').val();
                var confirmPassword = $('#confirmPassword').val();
                
                if (newPassword.length < 6) {
                    alert('Password must be at least 6 characters long!');
                    e.preventDefault(); return false;
                }
                if (!/(?=.*[A-Z])/.test(newPassword)) {
                    alert('Password must contain at least one uppercase letter!');
                    e.preventDefault(); return false;
                }
                if (!/(?=.*\d)/.test(newPassword)) {
                    alert('Password must contain at least one number!');
                    e.preventDefault(); return false;
                }
                if (newPassword !== confirmPassword) {
                    alert('New password and confirm password do not match!');
                    e.preventDefault(); return false;
                }
            });
            
            // Auto dismiss alerts after 5 seconds
            setTimeout(function() {
                $('.alert').fadeOut('slow');
            }, 5000);
        });
    </script>
</body>
</html>