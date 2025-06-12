<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Model.UserLoginInfo" %>
<%
    UserLoginInfo user = (UserLoginInfo) session.getAttribute("user");
%>
<!doctype html>
<html class="no-js" lang="zxx">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Find Work</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- <link rel="manifest" href="site.webmanifest"> -->
        <link rel="shortcut icon" type="image/x-icon" href="img/favicon.png">
        <!-- Place favicon.ico in the root directory -->

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
        <!-- <link rel="stylesheet" href="css/responsive.css"> -->
        <style>
            /* Nền mờ khi popup mở */
            .overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                z-index: 999;
            }

            /* Nội dung popup */
            .popup {
                background: white;
                padding: 20px;
                width: 555px;
                margin: 100px auto;
                border-radius: 10px;
                text-align: center;
                box-shadow: 0 0 10px rgba(0,0,0,0.25);
            }

            .popup button {
                margin: 10px;
                padding: 10px 20px;
                border: none;
                background-color: #007bff;
                color: white;
                border-radius: 5px;
                cursor: pointer;
            }

            .popup button:hover {
                background-color: #0056b3;
            }

            .close-btn {
                background-color: #dc3545;
            }

            .close-btn:hover {
                background-color: #c82333;
            }
        </style>
        <style>
            /* Overlay nền mờ */
            .overlaylog {
                display: none;
                position: fixed;
                z-index: 99;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: rgba(0,0,0,0.5);
            }

            /* Hộp popup */
            .popuplog {
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background: #fff;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 0 15px rgba(0,0,0,0.3);
                z-index: 100;
                min-width: 300px;
                text-align: center;
            }

            .popuplog h3 {
                margin-bottom: 20px;
            }

            .popuplog a {
                display: inline-block;
                margin: 10px;
                padding: 10px 20px;
                background-color: #4285F4;
                color: white;
                border-radius: 5px;
                text-decoration: none;
            }

            .popuplog a:hover {
                background-color: #2a63c5;
            }

            .close-btnlog {
                position: absolute;
                top: 8px;
                right: 12px;
                cursor: pointer;
                font-size: 20px;
                color: #666;
            }
        </style>
    </head>

    <body>
        <!--[if lte IE 9]>
                <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="https://browsehappy.com/">upgrade your browser</a> to improve your experience and security.</p>
            <![endif]-->

        <!-- header-start -->
        <header>
            <div class="header-area ">
                <div id="sticky-header" class="main-header-area">
                    <div class="container-fluid ">
                        <div class="header_bottom_border">
                            <div class="row align-items-center">
                                <div class="col-xl-3 col-lg-2">
                                    <div class="logo">
                                        <a href="index.jsp">
                                            <img src="img/logo.png" alt="">
                                        </a>
                                    </div>
                                </div>
                                <div class="col-xl-6 col-lg-7">
                                    <div class="main-menu  d-none d-lg-block">
                                        <nav>
                                            <ul id="navigation">
                                                <li><a href="index.jsp">home</a></li>
                                                <li><a href="jobs">Browse Jobs</a></li>
                                                    <% if (user != null && "freelancer".equals(user.getUserType())) { %>
                                                <li><a href="favorite?action=list">My Favorites</a></li>
                                                    <% } %>
                                                    <% if (user != null && "recruiter".equals(user.getUserType())) { %>
                                                <li><a href="post?action=list">My Jobs</a></li>
                                                    <% } %>
                                                <li><a href="#">pages <i class="ti-angle-down"></i></a>
                                                    <ul class="submenu">

                                                        <li><a href="job_details.jsp">job details </a></li>
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
                                        <div class="phone_num d-none d-xl-block">
                                            <!--                                            <a href="register.jsp">Register</a>-->
                                            <!-- Nút mở popup -->
                                            <a href="#" onclick="openPopup()">Register</a>

                                            <!-- Popup overlay -->
                                            <div id="popupOverlay" class="overlay">
                                                <div class="popup">
                                                    <h2>Register an Account</h2>
                                                    <button onclick="location.href = 'register.jsp'">I am an employer</button>
                                                    <button onclick="location.href = 'registerjobseeker.jsp'">I am a job seeker</button>
                                                    <br><br>
                                                    <button class="close-btn" onclick="closePopup()">Close</button>
                                                </div>
                                            </div>

                                        </div>
                                        <div class="phone_num d-none d-xl-block">
                                            <!--                                            <a href="#">Log in</a>-->
                                            <a href="#" id="loginLink">Log in</a>

                                            <!-- Popup -->
                                            <div class="overlaylog" id="loginPopup">
                                                <div class="popuplog">
                                                    <span class="close-btnlog" onclick="closePopuplog()">&times;</span>
                                                    <h3>Login</h3>
                                                    <a href="login.jsp">I am Recruiter</a>
                                                    <a href="loginjobseeker.jsp">I am  Jobseekers</a>

                                                </div>
                                            </div>
                                        </div>
                                        <div class="d-none d-lg-block">
                                            <a class="boxed-btn3" href="#">Post a Job</a>
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
        <script>
            function openPopup() {
                document.getElementById("popupOverlay").style.display = "block";
            }

            function closePopup() {
                document.getElementById("popupOverlay").style.display = "none";
            }
        </script>
        <script>
            const loginLink = document.getElementById('loginLink');
            const popuplog = document.getElementById('loginPopup');

            loginLink.addEventListener('click', function (e) {
                e.preventDefault();
                popuplog.style.display = 'block';
            });

            function closePopuplog() {
                popuplog.style.display = 'none';
            }

            // Đóng popup khi click bên ngoài
            window.addEventListener('click', function (e) {
                if (e.target === popuplog) {
                    popuplog.style.display = 'none';
                }
            });
        </script>
        <!-- slider_area_start -->
        <div class="slider_area">
            <div class="single_slider  d-flex align-items-center slider_bg_1">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-lg-7 col-md-6">
                            <div class="slider_text">
                                <h5 class="wow fadeInLeft" data-wow-duration="1s" data-wow-delay=".2s">4536+ Jobs listed</h5>
                                <h3 class="wow fadeInLeft" data-wow-duration="1s" data-wow-delay=".3s">Find your Dream Job</h3>
                                <p class="wow fadeInLeft" data-wow-duration="1s" data-wow-delay=".4s">We provide online instant cash loans with quick approval that suit your term length</p>
                                <div class="sldier_btn wow fadeInLeft" data-wow-duration="1s" data-wow-delay=".5s">
                                    <a href="#" class="boxed-btn3">Upload your Resume</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="ilstration_img wow fadeInRight d-none d-lg-block text-right" data-wow-duration="1s" data-wow-delay=".2s">
                <img src="img/banner/illustration.png" alt="">
            </div>
        </div>
        <!-- slider_area_end -->

        <!-- catagory_area -->
        <div class="catagory_area">
            <div class="container">
                <div class="row cat_search">
                    <div class="col-lg-3 col-md-4">
                        <div class="single_input">
                            <input type="text" placeholder="Search keyword">
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-4">
                        <div class="single_input">
                            <select class="wide" >
                                <option data-display="Location">Location</option>
                                <option value="1">Dhaka</option>
                                <option value="2">Rangpur</option>
                                <option value="4">Sylet</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-4">
                        <div class="single_input">
                            <select class="wide">
                                <option data-display="Category">Category</option>
                                <option value="1">Category 1</option>
                                <option value="2">Category 2</option>
                                <option value="4">Category 3</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-12">
                        <div class="job_btn">
                            <a href="#" class="boxed-btn3">Find Job</a>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="popular_search d-flex align-items-center">
                            <span>Popular Search:</span>
                            <ul>
                                <li><a href="#">Design & Creative</a></li>
                                <li><a href="#">Marketing</a></li>
                                <li><a href="#">Administration</a></li>
                                <li><a href="#">Teaching & Education</a></li>
                                <li><a href="#">Engineering</a></li>
                                <li><a href="#">Software & Web</a></li>
                                <li><a href="#">Telemarketing</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--/ catagory_area -->

        <!-- popular_catagory_area_start  -->
        <div class="popular_catagory_area">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="section_title mb-40">
                            <h3>Popolar Categories</h3>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-4 col-xl-3 col-md-6">
                        <div class="single_catagory">
                            <a href="jobs.jsp"><h4>Design & Creative</h4></a>
                            <p> <span>50</span> Available position</p>
                        </div>
                    </div>
                    <div class="col-lg-4 col-xl-3 col-md-6">
                        <div class="single_catagory">
                            <a href="jobs.jsp"><h4>Marketing</h4></a>
                            <p> <span>50</span> Available position</p>
                        </div>
                    </div>
                    <div class="col-lg-4 col-xl-3 col-md-6">
                        <div class="single_catagory">
                            <a href="jobs.jsp"><h4>Telemarketing</h4></a>
                            <p> <span>50</span> Available position</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- popular_catagory_area_end  -->

        <!-- job_listing_area -->
        <div class="job_listing_area">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-6">
                        <div class="section_title">
                            <h3>Job Listing</h3>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="brows_job text-right">
                            <div class="form-group">
                                <select class="wide">
                                    <option data-display="Filter by">Filter by</option>
                                    <option value="1">Full time</option>
                                    <option value="2">Part time</option>
                                    <option value="3">Internship</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="job_lists">
                    <div class="row">
                        <div class="col-lg-12 col-md-12">
                            <div class="single_jobs white-bg d-flex justify-content-between">
                                <div class="jobs_left d-flex align-items-center">
                                    <div class="thumb">
                                        <img src="img/svg_icon/1.svg" alt="">
                                    </div>
                                    <div class="jobs_conetent">
                                        <a href="job_details.jsp"><h4>Senior Product Designer</h4></a>
                                        <div class="links_locat d-flex align-items-center">
                                            <div class="location">
                                                <p> <i class="ti-location-pin"></i> Los Angeles</p>
                                            </div>
                                            <div class="location">
                                                <p> <i class="ti-money"></i> $3500-$4000</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="jobs_right">
                                    <div class="apply_now">
                                        <a href="job_details.jsp" class="boxed-btn3">Apply Now</a>
                                    </div>
                                    <div class="favourite">
                                        <span class="ti-heart"></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-12 col-md-12">
                            <div class="single_jobs white-bg d-flex justify-content-between">
                                <div class="jobs_left d-flex align-items-center">
                                    <div class="thumb">
                                        <img src="img/svg_icon/2.svg" alt="">
                                    </div>
                                    <div class="jobs_conetent">
                                        <a href="job_details.jsp"><h4>UI/UX Designer</h4></a>
                                        <div class="links_locat d-flex align-items-center">
                                            <div class="location">
                                                <p> <i class="ti-location-pin"></i> Los Angeles</p>
                                            </div>
                                            <div class="location">
                                                <p> <i class="ti-money"></i> $3500-$4000</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="jobs_right">
                                    <div class="apply_now">
                                        <a href="job_details.jsp" class="boxed-btn3">Apply Now</a>
                                    </div>
                                    <div class="favourite">
                                        <span class="ti-heart"></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-12 col-md-12">
                            <div class="single_jobs white-bg d-flex justify-content-between">
                                <div class="jobs_left d-flex align-items-center">
                                    <div class="thumb">
                                        <img src="img/svg_icon/3.svg" alt="">
                                    </div>
                                    <div class="jobs_conetent">
                                        <a href="job_details.jsp"><h4>Senior Product Designer</h4></a>
                                        <div class="links_locat d-flex align-items-center">
                                            <div class="location">
                                                <p> <i class="ti-location-pin"></i> Los Angeles</p>
                                            </div>
                                            <div class="location">
                                                <p> <i class="ti-money"></i> $3500-$4000</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="jobs_right">
                                    <div class="apply_now">
                                        <a href="job_details.jsp" class="boxed-btn3">Apply Now</a>
                                    </div>
                                    <div class="favourite">
                                        <span class="ti-heart"></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-12 col-md-12">
                            <div class="single_jobs white-bg d-flex justify-content-between">
                                <div class="jobs_left d-flex align-items-center">
                                    <div class="thumb">
                                        <img src="img/svg_icon/4.svg" alt="">
                                    </div>
                                    <div class="jobs_conetent">
                                        <a href="job_details.jsp"><h4>UI/UX Designer</h4></a>
                                        <div class="links_locat d-flex align-items-center">
                                            <div class="location">
                                                <p> <i class="ti-location-pin"></i> Los Angeles</p>
                                            </div>
                                            <div class="location">
                                                <p> <i class="ti-money"></i> $3500-$4000</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="jobs_right">
                                    <div class="apply_now">
                                        <a href="job_details.jsp" class="boxed-btn3">Apply Now</a>
                                    </div>
                                    <div class="favourite">
                                        <span class="ti-heart"></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-12 col-md-12">
                            <div class="single_jobs white-bg d-flex justify-content-between">
                                <div class="jobs_left d-flex align-items-center">
                                    <div class="thumb">
                                        <img src="img/svg_icon/5.svg" alt="">
                                    </div>
                                    <div class="jobs_conetent">
                                        <a href="job_details.jsp"><h4>Senior Product Designer</h4></a>
                                        <div class="links_locat d-flex align-items-center">
                                            <div class="location">
                                                <p> <i class="ti-location-pin"></i> Los Angeles</p>
                                            </div>
                                            <div class="location">
                                                <p> <i class="ti-money"></i> $3500-$4000</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="jobs_right">
                                    <div class="apply_now">
                                        <a href="job_details.jsp" class="boxed-btn3">Apply Now</a>
                                    </div>
                                    <div class="favourite">
                                        <span class="ti-heart"></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- job_listing_area_end  -->

        <!-- featured_candidates_area_start  -->
        <div class="featured_candidates_area">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="section_title text-center mb-40">
                            <h3>Featured Candidates</h3>
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
                                    <img src="img/candiateds/3.png" alt="">
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
                                    <img src="img/candiateds/4.png" alt="">
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
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- featured_candidates_area_end  -->

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
                                <a href="#" class="company_btn">Apply Now</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="single_company">
                            <div class="company_thumb">
                                <img src="img/top_companies/2.png" alt="">
                            </div>
                            <a href="#">
                                <h3>Google</h3>
                            </a>
                            <div class="company_info">
                                <p>12 Open Position</p>
                                <a href="#" class="company_btn">Apply Now</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="single_company">
                            <div class="company_thumb">
                                <img src="img/top_companies/3.png" alt="">
                            </div>
                            <a href="#">
                                <h3>Google</h3>
                            </a>
                            <div class="company_info">
                                <p>12 Open Position</p>
                                <a href="#" class="company_btn">Apply Now</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="testimonial_area  ">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="section_title text-center mb-40">
                            <h3>Client Feedback</h3>
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
                                        <h3>Al Roney</h3>
                                        <span>Web Developer</span>
                                    </div>
                                    <p>“It is a long established fact that reader will be distracted by the readable content
                                        of a page when looking at its layout. The point of using Lorem Ipsum is that it has a
                                        more-or-less normal distribution of letters, as opposed to using ‘Content here, content
                                        here’, making it look like readable English.”</p>
                                </div>
                            </div>
                            <div class="single_carusel">
                                <div class="single_testmonial text-center">
                                    <div class="testmonial_author">
                                        <div class="thumb">
                                            <img src="img/testmonial/author.png" alt="">
                                        </div>
                                        <h3>Al Roney</h3>
                                        <span>Web Developer</span>
                                    </div>
                                    <p>“It is a long established fact that reader will be distracted by the readable content
                                        of a page when looking at its layout. The point of using Lorem Ipsum is that it has a
                                        more-or-less normal distribution of letters, as opposed to using ‘Content here, content
                                        here’, making it look like readable English.”</p>
                                </div>
                            </div>
                            <div class="single_carusel">
                                <div class="single_testmonial text-center">
                                    <div class="testmonial_author">
                                        <div class="thumb">
                                            <img src="img/testmonial/author.png" alt="">
                                        </div>
                                        <h3>Al Roney</h3>
                                        <span>Web Developer</span>
                                    </div>
                                    <p>“It is a long established fact that reader will be distracted by the readable content
                                        of a page when looking at its layout. The point of using Lorem Ipsum is that it has a
                                        more-or-less normal distribution of letters, as opposed to using ‘Content here, content
                                        here’, making it look like readable English.”</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

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
                                    Company
                                </h3>
                                <ul class="links">
                                    <li><a href="#">About</a></li>
                                    <li><a href="#">Blog</a></li>
                                    <li><a href="#">Contact</a></li>
                                    <li><a href="#">News</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-xl-3 col-md-6 col-lg-4">
                            <div class="footer_widget">
                                <h3 class="footer_title">
                                    Popular Jobs
                                </h3>
                                <ul class="links">
                                    <li><a href="#">Web Developer</a></li>
                                    <li><a href="#">UI/UX Designer</a></li>
                                    <li><a href="#">Project Manager</a></li>
                                    <li><a href="#">SEO Expert</a></li>
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
    </body>
</html>

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
<script src="js/jquery.slicknav.min.js">

  