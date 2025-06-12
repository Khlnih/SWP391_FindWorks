<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html class="no-js" lang="zxx">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Job Board | Freelancers</title>
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
    </head>
    <body>
        <!-- header-start -->
        <header>
            <div class="header-area ">
                <div id="sticky-header" class="main-header-area">
                    <div class="container-fluid ">
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
                                    <div class="main-menu  d-none d-lg-block">
                                        <nav>
                                            <ul id="navigation">
                                                <li><a href="index_recruiter.jsp">home</a></li>
                                                <li><a href="post?action=list">My Jobs</a></li>
                                                <li><a href="jobs.jsp">Browse Job</a></li>
                                                <li><a href="#">pages <i class="ti-angle-down"></i></a>
                                                    <ul class="submenu">
                                                        <li><a href="freelancer_list">Jobseekers</a></li>
                                                        <li><a href="job_details.jsp">Job details </a></li>
                                                        <li><a href="elements.jsp">Elements</a></li>
                                                    </ul>
                                                </li>
                                                <li><a href="#">blog <i class="ti-angle-down"></i></a>
                                                    <ul class="submenu">
                                                        <li><a href="blog.jsp">blog</a></li>
                                                        <li><a href="single-blog.jsp">single-blog</a></li>
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
                                            <a href="recruiter_profile.jsp">My Profile</a>
                                        </div>
                                        <div class="phone_num d-none d-xl-block">
                                             <a href="${pageContext.request.contextPath}/logout">Log out</a>
                                        </div>
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
        <!-- bradcam_area  -->
        <div class="bradcam_area bradcam_bg_1">
            <div class="container">
                <div class="row">
                    <div class="col-xl-12">
                        <div class="bradcam_text">
                            <h3>Freelancer</h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--/ bradcam_area  -->
        <!-- Search Bar Section -->
        <div class="job_listing_area">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-12">
                        <div class="job_filter white-bg">
                            <form action="freelancer_list" method="GET">
                                <div class="form-row align-items-center">
                                    <div class="col-md-10">
                                        <input type="text" class="form-control" name="search"
                                               placeholder="Search by name, skill, or title (e.g., 'Developer')"
                                               value="${searchQuery}">
                                    </div>
                                    <div class="col-md-2">
                                        <button type="submit" class="boxed-btn3 w-100">Search</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Freelancer Cards -->
        <div class="featured_candidates_area candidate_page_padding">
            <div class="container">
                <div class="row">
                    <c:forEach var="f" items="${freelancer_list}">
                        <div class="col-md-6 col-lg-3 mb-4">
                            <div class="single_candidates text-center">
                                <div class="thumb">
                                    <img src="${not empty f.image ? f.image : 'img/candiateds/default.png'}"
                                         alt="${f.firstName} ${f.lastName}">
                                </div>
                                <!-- BEST PRACTICE: Sử dụng context path để đảm bảo đường dẫn luôn đúng -->
                                <a href="${pageContext.request.contextPath}/freelancer-details?id=${f.freelanceID}">
                                    <h4>${f.firstName} ${f.lastName}</h4>
                                </a>
                                <p>${f.describe}</p>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty freelancer_list}">
                        <div class="col-lg-12">
                            <div class="alert alert-warning text-center mt-4" role="alert">
                                <c:choose>
                                    <c:when test="${not empty searchQuery}">
                                        No freelancers found for: "<strong>${searchQuery}</strong>". Please try a different keyword.
                                    </c:when>
                                    <c:otherwise>
                                        No freelancers available at the moment.
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </c:if>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="pagination_wrap">
                            <ul>
                                <li><a href="#"><i class="ti-angle-left"></i></a></li>
                                <li><a href="#">1</a></li>
                                <li><a href="#">2</a></li>
                                <li><a href="#">3</a></li>
                                <li><a href="#"><i class="ti-angle-right"></i></a></li>
                            </ul>
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
                        <div class="col-xl-4 col-md-6 col-lg-4">
                            <div class="footer_widget">
                                <div class="footer_logo">
                                    <a href="#"><img src="img/footer_logo.png" alt=""></a>
                                </div>
                                <p>5th flora, 700/D kings road, green <br> lane New York - 10010 <br> <a href="#">+10 365 265 (8080)</a></p>
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
                                <h3 class="footer_title">Company</h3>
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
                                <h3 class="footer_title">Popular Jobs</h3>
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
                                <h3 class="footer_title">Subscribe</h3>
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
                            <p class="copy_right text-center">Copyright ©<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a></p>
                        </div>
                    </div>
                </div>
            </div>
        </footer>
        <!-- JS here -->
        <script src="js/vendor/modernizr-3.5.0.min.js"></script>
        <script src="js/vendor/jquery-1.12.4.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/main.js"></script>
    </body>
</html>