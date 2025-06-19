<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="DAO.RecruiterDAO, Model.Recruiter"%>
<%@page session="true" %>

<%
    // Kiểm tra session
    Recruiter recruiter = (Recruiter) session.getAttribute("recruiter");
    if (recruiter == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    
    String avatarPath = "img/candiateds/1.png"; // Default avatar
    String userName = recruiter.getFirstName() != null ? recruiter.getFirstName() : "User";
    
    if (recruiter.getImage() != null && !recruiter.getImage().isEmpty()) {
        avatarPath = recruiter.getImage();
    }
    
    // Add context path to avatar path if it's a relative path
    if (!avatarPath.startsWith("http") && !avatarPath.startsWith("/")) {
        avatarPath = request.getContextPath() + "/" + avatarPath;
    } else if (!avatarPath.startsWith("http")) {
        avatarPath = request.getContextPath() + avatarPath;
    }
%>

<!doctype html>
<html class="no-js" lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Find Work - Recruiter Dashboard</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/favicon.png">

    <!-- CSS here - Using CDN for better performance -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    <!-- Local CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/owl.carousel.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/magnific-popup.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/themify-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/nice-select.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/flaticon.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/gijgo.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/animate.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/slicknav.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

    <style>
        /* Custom styles for recruiter dashboard */
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
        
        .profile-avatar {
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

        /* Header appointment section updates */
        .Appointment {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .phone_num {
            margin: 0 !important;
        }
        
        /* Dashboard stats in hero section */
        .dashboard-stats {
            background: rgba(255,255,255,0.15);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 20px;
            text-align: center;
            border: 1px solid rgba(255,255,255,0.2);
            margin-bottom: 15px;
            transition: all 0.3s ease;
        }
        
        .dashboard-stats:hover {
            background: rgba(255,255,255,0.25);
            transform: translateY(-5px);
        }
        
        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            color: white;
            display: block;
        }
        
        .stat-label {
            font-size: 0.9rem;
            opacity: 0.8;
            color: white;
            margin-top: 5px;
        }

        /* Customize hero section for recruiter */
        .slider_text h5 {
            color: white !important;
        }
        
        .slider_text h3 {
            color: white !important;
        }
        
        .slider_text p {
            color: white !important;
        }

        /* Quick actions customization */
        .recruiter-actions .single_catagory {
            transition: all 0.3s ease;
        }
        
        .recruiter-actions .single_catagory:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        /* Recent activity styling */
        .activity-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            border-left: 4px solid #00D363;
            transition: all 0.3s ease;
        }
        
        .activity-card:hover {
            transform: translateX(5px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        
        .activity-time {
            color: #7f8c8d;
            font-size: 0.9rem;
        }

        /* Custom section titles */
        .section_title h3 {
            color: #2c3e50;
            font-weight: 600;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .profile-btn {
                padding: 6px 12px;
                font-size: 13px;
            }
            
            .profile-avatar {
                width: 28px;
                height: 28px;
                margin-right: 8px;
            }
            
            .dashboard-stats {
                margin-bottom: 10px;
            }
        }
    </style>
</head>

<body>
    <!--[if lte IE 9]>
        <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="https://browsehappy.com/">upgrade your browser</a> to improve your experience and security.</p>
    <![endif]-->

    <!-- header-start -->
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
                                            <li><a href="index_recruiter.jsp">home</a></li>
                                            <li><a href="jobs">Browse Jobs</a></li>
                                            <li><a href="post?action=list">My Jobs</a></li>
                                            <li><a href="#">pages <i class="ti-angle-down"></i></a>
                                                <ul class="submenu">
                                                    <li><a href="freelancer_list">Jobseekers</a></li>
                                                    <li><a href="job_details.jsp">job details</a></li>
                                                    <li><a href="elements.jsp">elements</a></li>
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
                                        <a href="${pageContext.request.contextPath}/recruiter_profile.jsp" class="profile-btn">
                                            <img src="<%= avatarPath %>" alt="Avatar" class="profile-avatar">
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

    <!-- slider_area_start -->
    <div class="slider_area">
        <div class="single_slider d-flex align-items-center slider_bg_1">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-7 col-md-6">
                        <div class="slider_text" style="position: relative; z-index: 10;">
                            <h5 class="wow fadeInLeft" data-wow-duration="1s" data-wow-delay=".2s">
                                Welcome back, <%= userName %>!
                            </h5>
                            <h3 class="wow fadeInLeft" data-wow-duration="1s" data-wow-delay=".3s">
                                Manage Your Recruitment
                            </h3>
                            <p class="wow fadeInLeft" data-wow-duration="1s" data-wow-delay=".4s">
                                Post jobs, find candidates, and manage your hiring process all in one place
                            </p>
                            <div class="sldier_btn wow fadeInLeft" data-wow-duration="1s" data-wow-delay=".5s">
                                <a href="post?action=create" class="boxed-btn3">Post New Job</a>
                                <a href="post?action=list" class="boxed-btn3" style="margin-left: 15px;">Manage Jobs</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-5 col-md-6">
                        <div class="row" style="position: relative; z-index: 10;">
                            <div class="col-6">
                                <div class="dashboard-stats wow fadeInRight" data-wow-duration="1s" data-wow-delay=".2s">
                                    <span class="stat-number">12</span>
                                    <div class="stat-label">Active Jobs</div>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="dashboard-stats wow fadeInRight" data-wow-duration="1s" data-wow-delay=".3s">
                                    <span class="stat-number">45</span>
                                    <div class="stat-label">Applications</div>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="dashboard-stats wow fadeInRight" data-wow-duration="1s" data-wow-delay=".4s">
                                    <span class="stat-number">8</span>
                                    <div class="stat-label">Interviews</div>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="dashboard-stats wow fadeInRight" data-wow-duration="1s" data-wow-delay=".5s">
                                    <span class="stat-number">3</span>
                                    <div class="stat-label">Hired</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="ilstration_img wow fadeInRight d-none d-lg-block" 
             data-wow-duration="1s" data-wow-delay=".2s"
             style="position: absolute; right: 0; top: 50%; transform: translateY(-50%); z-index: 1; max-width: 35%;">
            <img src="img/banner/illustration.png" alt="" style="width: 100%; height: auto;">
        </div>
    </div>
    <!-- slider_area_end -->

    <!-- catagory_area - Search for candidates -->
    <div class="catagory_area">
        <div class="container">
            <div class="row cat_search">
                <div class="col-lg-3 col-md-4">
                    <div class="single_input">
                        <input type="text" placeholder="Search candidates">
                    </div>
                </div>
                <div class="col-lg-3 col-md-4">
                    <div class="single_input">
                        <select class="wide">
                            <option data-display="Location">Location</option>
                            <option value="1">New York</option>
                            <option value="2">Los Angeles</option>
                            <option value="4">Chicago</option>
                        </select>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4">
                    <div class="single_input">
                        <select class="wide">
                            <option data-display="Skills">Skills</option>
                            <option value="1">Web Development</option>
                            <option value="2">Design</option>
                            <option value="4">Marketing</option>
                        </select>
                    </div>
                </div>
                <div class="col-lg-3 col-md-12">
                    <div class="job_btn">
                        <a href="freelancer_list" class="boxed-btn3">Find Candidates</a>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="popular_search d-flex align-items-center">
                        <span>Popular Skills:</span>
                        <ul>
                            <li><a href="#">JavaScript</a></li>
                            <li><a href="#">React</a></li>
                            <li><a href="#">Python</a></li>
                            <li><a href="#">UI/UX Design</a></li>
                            <li><a href="#">Digital Marketing</a></li>
                            <li><a href="#">Project Management</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--/ catagory_area -->

    <!-- popular_catagory_area_start - Quick Actions for Recruiters -->
    <div class="popular_catagory_area recruiter-actions">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section_title mb-40">
                        <h3>Quick Actions</h3>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4 col-xl-3 col-md-6">
                    <div class="single_catagory">
                        <a href="post?action=create"><h4>Post New Job</h4></a>
                        <p>Create and publish job postings</p>
                    </div>
                </div>
                <div class="col-lg-4 col-xl-3 col-md-6">
                    <div class="single_catagory">
                        <a href="freelancer_list"><h4>Find Candidates</h4></a>
                        <p>Browse qualified professionals</p>
                    </div>
                </div>
                <div class="col-lg-4 col-xl-3 col-md-6">
                    <div class="single_catagory">
                        <a href="post?action=list"><h4>Manage Jobs</h4></a>
                        <p>View and edit your job posts</p>
                    </div>
                </div>
                <div class="col-lg-4 col-xl-3 col-md-6">
                    <div class="single_catagory">
                        <a href="recruiter_profile.jsp"><h4>My Profile</h4></a>
                        <p>Update your company profile</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- popular_catagory_area_end -->

    <!-- Recent Activity Section -->
    <div class="job_listing_area">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <div class="section_title">
                        <h3>Recent Activity</h3>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="brows_job text-right">
                        <a href="post?action=list" class="boxed-btn3">View All</a>
                    </div>
                </div>
            </div>
            <div class="job_lists">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="activity-card">
                            <h5>New Application Received</h5>
                            <p>John Doe applied for Senior Web Developer position</p>
                            <span class="activity-time">2 hours ago</span>
                        </div>
                        <div class="activity-card">
                            <h5>Job Posted Successfully</h5>
                            <p>Frontend Developer position has been published</p>
                            <span class="activity-time">1 day ago</span>
                        </div>
                        <div class="activity-card">
                            <h5>Interview Scheduled</h5>
                            <p>Interview with Sarah Johnson for Marketing Manager</p>
                            <span class="activity-time">2 days ago</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- featured_candidates_area_start -->
    <div class="featured_candidates_area">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section_title text-center mb-40">
                        <h3>Top Candidates</h3>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="candidate_active owl-carousel">
                        <div class="single_candidates text-center">
                            <div class="thumb">
                                <img src="img/candiateds/1.png" alt="">
                            </div>
                            <a href="#">
                                <h4>Al Roney</h4>
                            </a>
                            <p>Web Developer</p>
                            <div class="social_links">
                                <ul>
                                    <li><a href="#"><i class="ti-facebook"></i></a></li>
                                    <li><a href="#"><i class="ti-twitter-alt"></i></a></li>
                                    <li><a href="#"><i class="ti-linkedin"></i></a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="single_candidates text-center">
                            <div class="thumb">
                                <img src="img/candiateds/2.png" alt="">
                            </div>
                            <a href="#">
                                <h4>Jane Smith</h4>
                            </a>
                            <p>UI/UX Designer</p>
                            <div class="social_links">
                                <ul>
                                    <li><a href="#"><i class="ti-facebook"></i></a></li>
                                    <li><a href="#"><i class="ti-twitter-alt"></i></a></li>
                                    <li><a href="#"><i class="ti-linkedin"></i></a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="single_candidates text-center">
                            <div class="thumb">
                                <img src="img/candiateds/3.png" alt="">
                            </div>
                            <a href="#">
                                <h4>Mike Johnson</h4>
                            </a>
                            <p>Marketing Specialist</p>
                            <div class="social_links">
                                <ul>
                                    <li><a href="#"><i class="ti-facebook"></i></a></li>
                                    <li><a href="#"><i class="ti-twitter-alt"></i></a></li>
                                    <li><a href="#"><i class="ti-linkedin"></i></a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="single_candidates text-center">
                            <div class="thumb">
                                <img src="img/candiateds/4.png" alt="">
                            </div>
                            <a href="#">
                                <h4>Sarah Wilson</h4>
                            </a>
                            <p>Data Analyst</p>
                            <div class="social_links">
                                <ul>
                                    <li><a href="#"><i class="ti-facebook"></i></a></li>
                                    <li><a href="#"><i class="ti-twitter-alt"></i></a></li>
                                    <li><a href="#"><i class="ti-linkedin"></i></a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- featured_candidates_area_end -->

    <!-- Top Companies section -->
    <div class="top_companies_area">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section_title text-center mb-40">
                        <h3>Top Companies</h3>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4 col-md-6">
                    <div class="single_company">
                        <div class="company_thumb">
                            <img src="img/top_companies/1.png" alt="">
                        </div>
                        <a href="#">
                            <h3>Google</h3>
                        </a>
                        <div class="company_info">
                            <p>12 Open Position</p>
                            <a href="#" class="company_btn">View Jobs</a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="single_company">
                        <div class="company_thumb">
                            <img src="img/top_companies/2.png" alt="">
                        </div>
                        <a href="#">
                            <h3>Microsoft</h3>
                        </a>
                        <div class="company_info">
                            <p>8 Open Position</p>
                            <a href="#" class="company_btn">View Jobs</a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="single_company">
                        <div class="company_thumb">
                            <img src="img/top_companies/3.png" alt="">
                        </div>
                        <a href="#">
                            <h3>Apple</h3>
                        </a>
                        <div class="company_info">
                            <p>15 Open Position</p>
                            <a href="#" class="company_btn">View Jobs</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Testimonial section -->
    <div class="testimonial_area">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section_title text-center mb-40">
                        <h3>Success Stories</h3>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="testmonial_active owl-carousel">
                        <div class="single_carusel">
                            <div class="single_testmonial text-center">
                                <div class="testmonial_author">
                                    <div class="thumb">
                                        <img src="img/testmonial/author.png" alt="">
                                    </div>
                                    <h3>Tech Startup CEO</h3>
                                    <span>Company Founder</span>
                                </div>
                                <p>"We found amazing developers through this platform. The quality of candidates exceeded our expectations, and the hiring process was smooth and efficient."</p>
                            </div>
                        </div>
                        <div class="single_carusel">
                            <div class="single_testmonial text-center">
                                <div class="testmonial_author">
                                    <div class="thumb">
                                        <img src="img/testmonial/author.png" alt="">
                                    </div>
                                    <h3>HR Manager</h3>
                                    <span>Fortune 500 Company</span>
                                </div>
                                <p>"The platform's search and filtering capabilities helped us find the perfect candidates quickly. Highly recommend for any company looking to hire top talent."</p>
                            </div>
                        </div>
                        <div class="single_carusel">
                            <div class="single_testmonial text-center">
                                <div class="testmonial_author">
                                    <div class="thumb">
                                        <img src="img/testmonial/author.png" alt="">
                                    </div>
                                    <h3>Recruitment Lead</h3>
                                    <span>Digital Agency</span>
                                </div>
                                <p>"Best recruitment platform we've used. The candidate quality is outstanding and the application management system is user-friendly."</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="footer_top">
            <div class="container">
                <div class="row">
                    <div class="col-xl-3 col-md-6 col-lg-3">
                        <div class="footer_widget">
                            <div class="footer_logo">
                                <a href="#">
                                    <img src="img/footer_logo.png" alt="">
                                </a>
                            </div>
                            <p>
                                5th flora, 700/D kings road, green <br>
                                lane New York - 10010 <br>
                                <a href="#">+10 365 265 (8080)</a>
                            </p>
                            <div class="socail_links">
                                <ul>
                                    <li>
                                        <a href="#">
                                            <i class="ti-facebook"></i>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <i class="ti-twitter-alt"></i>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <i class="ti-instagram"></i>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-2 col-md-6 col-lg-4">
                        <div class="footer_widget">
                            <h3 class="footer_title">
                                For Recruiters
                            </h3>
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
                            <h3 class="footer_title">
                                Popular Categories
                            </h3>
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
                            <h3 class="footer_title">
                                Subscribe
                            </h3>
                            <form action="#" class="newsletter_form">
                                <input type="text" placeholder="Enter your mail">
                                <button type="submit">Subscribe</button>
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
                    <div class="col-xl-12">
                        <p class="copy_right text-center">
                            Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </footer>

    <!-- JS here -->
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

    <script>
        $(document).ready(function() {
            // Counter animation for stats
            $('.stat-number').each(function() {
                var $this = $(this);
                var countTo = parseInt($this.text());
                $({ countNum: 0 }).animate({
                    countNum: countTo
                }, {
                    duration: 2000,
                    easing: 'swing',
                    step: function() {
                        $this.text(Math.floor(this.countNum));
                    },
                    complete: function() {
                        $this.text(countTo);
                    }
                });
            });

            // Profile button click effect
            $('.profile-btn').on('click', function() {
                $(this).css('transform', 'scale(0.95)');
                setTimeout(() => {
                    $(this).css('transform', 'scale(1)');
                }, 100);
            });
        });
    </script>

</body>
</html>
