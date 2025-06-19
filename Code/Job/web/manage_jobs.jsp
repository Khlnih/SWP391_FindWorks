<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, Model.Post, Model.Category, Model.JobType, Model.Duration, Model.UserLoginInfo, DAO.RecruiterDAO, Model.Recruiter" %>
<%
    UserLoginInfo user = (UserLoginInfo) session.getAttribute("user");
    if (user == null || !"recruiter".equals(user.getUserType())) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Lấy dữ liệu từ request
    List<Post> posts = (List<Post>) request.getAttribute("posts");
    List<Category> categories = (List<Category>) request.getAttribute("categories");
    List<JobType> jobTypes = (List<JobType>) request.getAttribute("jobTypes");
    List<Duration> durations = (List<Duration>) request.getAttribute("durations");
    String message = (String) session.getAttribute("message");
    String error = (String) session.getAttribute("error");

    // Xóa message sau khi hiển thị
    session.removeAttribute("message");
    session.removeAttribute("error");

    // Lấy thông tin cho Header
    RecruiterDAO recruiterDAO = new RecruiterDAO();
    Recruiter currentRecruiter = recruiterDAO.getRecruiterById(user.getUserID());
    String avatarPath = "img/candiateds/1.png"; // Default
    String userName = "Recruiter";
    if (currentRecruiter != null) {
        if (currentRecruiter.getImage() != null && !currentRecruiter.getImage().isEmpty()) {
            avatarPath = currentRecruiter.getImage();
        }
        userName = currentRecruiter.getFirstName();
    }
%>
<%!
    // Các helper methods giữ nguyên
    public String getCategoryName(int categoryId, List<Category> categories) {
        if (categories != null) { for (Category cat : categories) { if (cat.getCategoryID() == categoryId) return cat.getCategoryName(); } }
        return "N/A";
    }
    public String getJobTypeName(int jobTypeId, List<JobType> jobTypes) {
        if (jobTypes != null) { for (JobType jt : jobTypes) { if (jt.getJobTypeID() == jobTypeId) return jt.getJobTypeName(); } }
        return "N/A";
    }
    public String getDurationName(int durationId, List<Duration> durations) {
        if (durations != null) { for (Duration dur : durations) { if (dur.getDurationID() == durationId) return dur.getDurationName(); } }
        return "N/A";
    }
%>
<!doctype html>
<html class="no-js" lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Manage Job Posts - Find Work</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="shortcut icon" type="image/x-icon" href="img/favicon.png">
    
    <!-- CSS here -->
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
    
    <style>
        /* CSS cho header của recruiter (đã đồng bộ) */
        .profile-btn {
            display: flex !important; align-items: center;
            background: linear-gradient(135deg, #00D363 0%, #28a745 100%) !important;
            color: white !important; padding: 8px 16px; border-radius: 25px; text-decoration: none !important;
            transition: all 0.3s ease; box-shadow: 0 2px 10px rgba(0, 211, 99, 0.3); margin-right: 10px; font-weight: 500;
        }
        .profile-btn:hover { background: linear-gradient(135deg, #28a745 0%, #00D363 100%) !important; transform: translateY(-2px); }
        .profile-avatar { width: 32px; height: 32px; border-radius: 50%; border: 2px solid white; margin-right: 10px; object-fit: cover; }
        .logout-btn { color: #dc3545 !important; font-weight: 500; padding: 8px 12px; border-radius: 20px; transition: all 0.3s ease; text-decoration: none !important; }
        .logout-btn:hover { background-color: #dc3545 !important; color: white !important; }
        .Appointment { display: flex; align-items: center; gap: 15px; }

        /* CSS cho trang quản lý công việc */
        .job-management-area { padding: 50px 0; background-color: #f8f9fa; }
        .jobs-header { background: white; padding: 30px; border-radius: 8px; box-shadow: 0 5px 15px rgba(0,0,0,0.05); margin-bottom: 30px; }
        .job-card { background: white; border-radius: 8px; padding: 25px; margin-bottom: 20px; box-shadow: 0 5px 15px rgba(0,0,0,0.05); transition: all 0.3s ease; border-left: 4px solid #e0e0e0; }
        .job-card:hover { transform: translateY(-3px); box-shadow: 0 8px 25px rgba(0,0,0,0.08); }
        .job-card.status-approved { border-left-color: #28a745; }
        .job-card.status-pending { border-left-color: #ffc107; }
        .job-card.status-rejected, .job-card.status-closed { border-left-color: #dc3545; }

        .job-title { color: #2c3e50; font-size: 20px; font-weight: 600; margin-bottom: 10px; }
        .job-meta { color: #7f8c8d; font-size: 14px; margin-bottom: 15px; }
        .job-meta span { margin-right: 15px; display: inline-block; margin-bottom: 5px; }
        .job-description { color: #34495e; margin-bottom: 20px; line-height: 1.6; }
        .job-actions { display: flex; gap: 10px; flex-wrap: wrap; align-items: center; justify-content: flex-start; }
        
        .status-badge { padding: 4px 12px; border-radius: 20px; font-size: 12px; font-weight: 600; text-transform: uppercase; }
        .status-pending { background-color: #fff3cd; color: #856404; }
        .status-approved { background-color: #d4edda; color: #155724; }
        .status-rejected { background-color: #f8d7da; color: #721c24; }
        .status-closed { background-color: #e2e3e5; color: #343a40; }
        
        .empty-state { text-align: center; padding: 60px 20px; color: #7f8c8d; background: #fff; border-radius: 8px; }
        .empty-state i { font-size: 64px; margin-bottom: 20px; color: #bdc3c7; }
    </style>
</head>

<body>
    <!-- header-start (Đồng bộ) -->
    <header>
        <div class="header-area ">
            <div id="sticky-header" class="main-header-area">
                <div class="container-fluid">
                    <div class="header_bottom_border">
                        <div class="row align-items-center">
                            <div class="col-xl-3 col-lg-2">
                                <div class="logo"><a href="index_recruiter.jsp"><img src="img/logo.png" alt=""></a></div>
                            </div>
                            <div class="col-xl-6 col-lg-7">
                                <div class="main-menu d-none d-lg-block">
                                    <nav>
                                        <ul id="navigation">
                                            <li><a href="index_recruiter.jsp">Home</a></li>
                                            <li><a href="jobs.jsp">Browse Jobs</a></li>
                                            <li><a href="post?action=list" class="active">My Jobs</a></li>
                                            <li><a href="#">Pages <i class="ti-angle-down"></i></a>
                                                <ul class="submenu">
                                                    <li><a href="freelancer_list">Jobseekers</a></li>
                                                    <li><a href="job_details.jsp">Job Details</a></li>
                                                </ul>
                                            </li>
                                            <li><a href="contact.jsp">Contact</a></li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                            <div class="col-xl-3 col-lg-3 d-none d-lg-block">
                                <div class="Appointment">
                                    <div class="phone_num d-none d-xl-block">
                                        <a href="recruiter_profile.jsp" class="profile-btn">
                                            <img src="<%= avatarPath %>" alt="Avatar" class="profile-avatar">
                                            <span><%= userName %></span>
                                        </a>
                                    </div>
                                    <div class="phone_num d-none d-xl-block">
                                        <a href="${pageContext.request.contextPath}/logout" class="logout-btn"><i class="ti-power-off"></i> Logout</a>
                                    </div>
                                    <div class="d-none d-lg-block">
                                        <a class="boxed-btn3" href="post?action=create">Post a Job</a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12"><div class="mobile_menu d-block d-lg-none"></div></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <!-- header-end -->

    <!-- bradcam_area -->
    <div class="bradcam_area bradcam_bg_1">
        <div class="container">
            <div class="row"><div class="col-xl-12"><div class="bradcam_text"><h3>My Job Posts</h3></div></div></div>
        </div>
    </div>
    <!--/ bradcam_area -->

    <!-- job-management-area-start -->
    <div class="job-management-area">
        <div class="container">
            <!-- Header Section -->
            <div class="jobs-header">
                <div class="row align-items-center">
                    <div class="col-lg-8">
                        <h2>Manage Your Postings</h2>
                        <p class="mb-0 text-muted">View, edit, or delete your job postings from one place.</p>
                    </div>
                    <div class="col-lg-4 text-lg-right mt-3 mt-lg-0">
                        <a href="post?action=create" class="boxed-btn3"><i class="fa fa-plus-circle"></i> Create New Job</a>
                    </div>
                </div>
            </div>

            <!-- Messages -->
            <% if (message != null) { %><div class="alert alert-success"><%= message %></div><% } %>
            <% if (error != null) { %><div class="alert alert-danger"><%= error %></div><% } %>

            <!-- Job Posts List -->
            <% if (posts != null && !posts.isEmpty()) { %>
                <% for (Post post : posts) { %>
                    <div class="job-card status-<%= post.getStatusPost().toLowerCase() %>">
                        <div class="d-flex justify-content-between align-items-start">
                             <h3 class="job-title"><%= post.getTitle() %></h3>
                             <span class="status-badge status-<%= post.getStatusPost().toLowerCase() %>"><%= post.getStatusPost() %></span>
                        </div>
                        <div class="job-meta">
                            <span><i class="fa fa-calendar"></i> Posted: <%= post.getDatePost() %></span>
                            <span><i class="fa fa-map-marker"></i> <%= post.getLocation() %></span>
                            <span><i class="fa fa-users"></i> <%= post.getQuantity() %> positions</span>
                        </div>
                        <p class="job-description">
                            <%= post.getDescription() != null && post.getDescription().length() > 150 
                                ? post.getDescription().substring(0, 150) + "..." 
                                : post.getDescription() %>
                        </p>
                        <div class="job-actions">
                            <a href="post?action=view&id=<%= post.getPostId() %>" class="btn btn-sm btn-info text-white"><i class="fa fa-eye"></i> View</a>
                            <a href="post?action=edit&id=<%= post.getPostId() %>" class="btn btn-sm btn-warning text-white"><i class="fa fa-edit"></i> Edit</a>
                            <a href="post?action=delete&id=<%= post.getPostId() %>" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to delete this job post?')"><i class="fa fa-trash"></i> Delete</a>
                        </div>
                    </div>
                <% } %>
            <% } else { %>
                <div class="empty-state">
                    <i class="fa fa-briefcase"></i>
                    <h3>No Job Posts Yet</h3>
                    <p>You haven't created any job posts yet. Start by creating your first job posting!</p>
                    <a href="post?action=create" class="boxed-btn3 mt-3">Create Your First Job</a>
                </div>
            <% } %>
        </div>
    </div>
    <!-- job-management-area-end -->

    <!-- footer start (Đồng bộ) -->
    <footer class="footer">
        <div class="footer_top">
            <div class="container">
                <div class="row">
                    <div class="col-xl-3 col-md-6 col-lg-3">
                        <div class="footer_widget">
                            <div class="footer_logo"><a href="#"><img src="img/footer_logo.png" alt=""></a></div>
                            <p>5th flora, 700/D kings road, green <br> lane New York - 10010 <br><a href="#">+10 365 265 (8080)</a></p>
                            <div class="socail_links"><ul><li><a href="#"><i class="ti-facebook"></i></a></li><li><a href="#"><i class="ti-twitter-alt"></i></a></li><li><a href="#"><i class="ti-instagram"></i></a></li></ul></div>
                        </div>
                    </div>
                    <div class="col-xl-2 col-md-6 col-lg-4">
                        <div class="footer_widget">
                            <h3 class="footer_title">For Recruiters</h3>
                            <ul class="links">
                                <li><a href="post?action=create">Post Jobs</a></li>
                                <li><a href="freelancer_list.jsp">Find Candidates</a></li>
                                <li><a href="post?action=list">Manage Jobs</a></li>
                                <li><a href="recruiter_profile.jsp">Profile</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6 col-lg-4">
                        <div class="footer_widget">
                            <h3 class="footer_title">Popular Categories</h3>
                            <ul class="links"><li><a href="#">Web Developer</a></li><li><a href="#">UI/UX Designer</a></li><li><a href="#">Project Manager</a></li><li><a href="#">Digital Marketing</a></li></ul>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6 col-lg-4">
                        <div class="footer_widget">
                            <h3 class="footer_title">Subscribe</h3>
                            <form action="#" class="newsletter_form"><input type="text" placeholder="Enter your mail"><button type="submit">Subscribe</button></form>
                            <p class="newsletter_text">Subscribe newsletter to get updates</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="copy-right_text">
            <div class="container">
                <div class="footer_border"></div>
                <div class="row"><div class="col-xl-12"><p class="copy_right text-center">Copyright ©<script>document.write(new Date().getFullYear());</script> All rights reserved</p></div></div>
            </div>
        </div>
    </footer>
    <!--/ footer end  -->

    <!-- JS here -->
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
    <script src="js/main.js"></script>
</body>
</html>