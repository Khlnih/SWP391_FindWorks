<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html class="no-js" lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>FindWorks - Danh sách công việc</title>
    <meta name="description" content="Tìm kiếm việc làm phù hợp với kỹ năng và sỡ thích của bạn trên FindWorks">
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
        /* Header styling */
        .header-area {
            background: linear-gradient(135deg, #0062cc, #0b5ed7);
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
        }
        
        .main-header-area {
            background: transparent;
        }
        
        .main-menu ul li a {
            color: #fff !important;
            font-weight: 500;
        }
        
        .main-menu ul li a:hover {
            color: #f8f9fa !important;
        }
        
        .logo a {
            color: white !important;
            font-weight: 700;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.2);
        }
        
        .navbar-brand span {
            color: #0d6efd;
            font-weight: bold;
        }
        
        /* CSS cho job card */
        .job-card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            margin-bottom: 30px;
            padding: 20px;
            height: 100%;
            display: flex;
            flex-direction: column;
            transition: all 0.3s ease;
            border-top: 4px solid #0d6efd;
            position: relative;
            overflow: hidden;
        }
        
        .job-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }
        
        .job-header {
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }
        
        .job-title {
            font-size: 1.2rem;
            margin-bottom: 5px;
            color: #333;
            font-weight: 600;
        }
        
        .company-name {
            font-size: 0.95rem;
            color: #666;
            margin-bottom: 0;
        }
        
        .job-logo {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
            background-color: #f0f4ff;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            font-size: 1.5rem;
            color: #0d6efd;
        }
        
        .job-body {
            flex-grow: 1;
            margin-bottom: 15px;
        }
        
        .job-meta {
            display: flex;
            flex-wrap: wrap;
            margin-bottom: 15px;
            gap: 10px;
        }
        
        .job-meta-item {
            font-size: 0.85rem;
            color: #555;
            background-color: #f8f9fa;
            padding: 5px 10px;
            border-radius: 20px;
            margin-right: 10px;
            display: inline-flex;
            align-items: center;
        }
        
        .job-meta-item i {
            margin-right: 5px;
            color: #0d6efd;
        }
        
        .job-description {
            font-size: 0.9rem;
            color: #666;
            line-height: 1.5;
            margin-bottom: 0;
        }
        
        .job-footer {
            margin-top: auto;
            padding-top: 15px;
            border-top: 1px solid #eee;
        }
        
        .badge-open {
            background-color: #d1e7dd;
            color: #0f5132;
        }
        
        .badge-closed {
            background-color: #f8d7da;
            color: #842029;
        }
        
        .skill-tags {
            margin: 10px 0;
            display: flex;
            flex-wrap: wrap;
            gap: 5px;
        }
        
        .skill-tag {
            font-size: 0.75rem;
            background-color: #e9ecef;
            color: #495057;
            padding: 2px 8px;
            border-radius: 4px;
            white-space: nowrap;
        }
        
        .budget-tag {
            position: absolute;
            top: 0;
            right: 0;
            background-color: #0d6efd;
            color: white;
            padding: 5px 15px;
            font-size: 0.85rem;
            font-weight: 600;
            clip-path: polygon(0 0, 100% 0, 100% 100%, 10% 100%);
            width: 120px;
            text-align: right;
        }
        
        .no-jobs {
            text-align: center;
            padding: 50px 0;
            color: #6c757d;
        }
        
        .no-jobs i {
            color: #dee2e6;
        }
        
        /* Search section */
        .card {
            border: none;
            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
        }
        
        .section-title {
            position: relative;
            padding-bottom: 10px;
            margin-bottom: 20px;
            font-weight: 600;
        }
        
        .section-title:after {
            content: '';
            position: absolute;
            left: 0;
            bottom: 0;
            width: 50px;
            height: 3px;
            background-color: #0d6efd;
        }
    </style>
</head>
<body>
    <!-- header-start -->
    <header>
        <div class="header-area">
            <div id="sticky-header" class="main-header-area">
                <div class="container-fluid">
                    <div class="header_bottom_border">
                        <div class="row align-items-center">
                            <div class="col-xl-3 col-lg-2">
                                <div class="logo">
                                    <a href="index.jsp">
                                        <img src="img/logo.png" alt="FindWorks Logo">
                                    </a>
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-7">
                                <div class="main-menu d-none d-lg-block">
                                    <nav>
                                        <ul id="navigation">
                                            <li><a href="index.jsp">Home</a></li>
                                            <li><a class="active" href="jobs">Browse Job</a></li>
                                            <li><a href="#">Pages <i class="ti-angle-down"></i></a>
                                                <ul class="submenu">
                                                    <li><a href="candidate.jsp">Candidates</a></li>
                                                    <li><a href="job_details.jsp">Job Details</a></li>
                                                    <li><a href="elements.jsp">Elements</a></li>
                                                </ul>
                                            </li>
                                            <li><a href="#">Blog <i class="ti-angle-down"></i></a>
                                                <ul class="submenu">
                                                    <li><a href="blog.jsp">Blog</a></li>
                                                    <li><a href="single-blog.jsp">Single Blog</a></li>
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
                                        <a href="login.jsp">Log in</a>
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

    <!-- bradcam_area  -->
    <div class="bradcam_area bradcam_bg_1">
        <div class="container">
            <div class="row">
                <div class="col-xl-12">
                    <div class="bradcam_text">
                        <h3>Danh sách công việc</h3>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /bradcam_area  -->
    
    <!-- Khu vực tìm kiếm -->
    <div class="job_search_area py-4 bg-light">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="card border-0 shadow-sm">
                        <div class="card-body">
                            <h4 class="section-title mb-3">Tìm kiếm công việc</h4>
                            <form action="jobs" method="GET" class="job-search-form">
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="keyword" class="form-label">Từ khóa</label>
                                            <div class="input-group">
                                                <span class="input-group-text"><i class="fas fa-search"></i></span>
                                                <input type="text" class="form-control" id="keyword" name="keyword" placeholder="Nhập từ khóa..." value="${searchKeyword}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="category" class="form-label">Danh mục</label>
                                            <div class="input-group">
                                                <span class="input-group-text"><i class="fas fa-briefcase"></i></span>
                                                <select class="form-select" id="category" name="category">
                                                    <option value="">Tất cả danh mục</option>
                                                    <option value="1" ${searchCategory == '1' ? 'selected' : ''}>Thiết kế & Đồ họa</option>
                                                    <option value="2" ${searchCategory == '2' ? 'selected' : ''}>Phát triển Web</option>
                                                    <option value="3" ${searchCategory == '3' ? 'selected' : ''}>Phát triển Mobile</option>
                                                    <option value="4" ${searchCategory == '4' ? 'selected' : ''}>Marketing</option>
                                                    <option value="5" ${searchCategory == '5' ? 'selected' : ''}>Viết lách & Dịch thuật</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12 text-end mt-2">
                                        <button type="submit" class="btn btn-primary px-4">
                                            <i class="fas fa-search me-2"></i>Tìm kiếm
                                        </button>
                                        <a href="jobs" class="btn btn-outline-secondary ms-2">
                                            <i class="fas fa-redo me-2"></i>Đặt lại
                                        </a>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Kết thúc khu vực tìm kiếm -->

    <!-- spacing section -->
    <div style="margin-top: 120px;"></div>
    
    <!-- Main Content -->
    <div class="container py-4">
        <div class="row mb-4">
            <div class="col-md-8"><h2 class="section-title">Danh sách công việc</h2></div>
            <div class="col-md-4 text-end">
                <a href="#" class="btn btn-primary"><i class="fas fa-plus-circle me-2"></i>Đăng tin tuyển dụng</a>
            </div>
        </div>

        <!-- Search Form -->
        <div class="card mb-4 shadow-sm">
            <div class="card-body">
                <form class="row g-3" action="jobs" method="get">
                    <div class="col-md-5">
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-search"></i></span>
                            <input type="text" name="keyword" class="form-control" placeholder="Nhập từ khóa tìm kiếm...">
                        </div>
                    </div>
                    <div class="col-md-3">
                        <select name="location" class="form-select">
                            <option value="">Địa điểm</option>
                            <option value="Hà Nội">Hà Nội</option>
                            <option value="Hồ Chí Minh">Hồ Chí Minh</option>
                            <option value="Đà Nẵng">Đà Nẵng</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <select name="jobType" class="form-select">
                            <option value="">Loại việc làm</option>
                            <option value="1">Toàn thời gian</option>
                            <option value="2">Bán thời gian</option>
                            <option value="3">Thực tập</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-primary w-100">Tìm kiếm</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Job Listings -->
        <div class="row">
            <c:choose>
                <c:when test="${not empty posts}">
                    <c:forEach var="post" items="${posts}">
                        <c:set var="statusClass" value="${post.status == 1 ? 'badge-open' : 'badge-closed'}" />
                        <c:set var="statusText" value="${post.status == 1 ? 'Đang tuyển' : 'Đã đóng'}" />
                        <div class="col-md-6 col-lg-4 mb-4">
                            <div class="job-card">
                                <c:if test="${post.budget > 0}">
                                    <div class="budget-tag">
                                        ${post.budget} đ
                                    </div>
                                </c:if>
                                
                                <div class="job-header d-flex">
                                    <div class="job-logo">
                                        <i class="fas fa-briefcase"></i>
                                    </div>
                                    <div>
                                        <h3 class="job-title">${post.title}</h3>
                                        <p class="company-name">Nhà tuyển dụng #${post.recruiterId}</p>
                                    </div>
                                </div>
                                
                                <div class="job-body">
                                    <div class="job-meta">
                                        <div class="job-meta-item">
                                            <i class="fas fa-map-marker-alt"></i>
                                            ${empty post.location ? 'Không xác định' : post.location}
                                        </div>
                                        <div class="job-meta-item">
                                            <i class="fas fa-briefcase"></i>
                                            <c:choose>
                                                <c:when test="${post.jobTypeId == 1}">Toàn thời gian</c:when>
                                                <c:when test="${post.jobTypeId == 2}">Bán thời gian</c:when>
                                                <c:when test="${post.jobTypeId == 3}">Thực tập</c:when>
                                                <c:when test="${post.jobTypeId == 4}">Freelance</c:when>
                                                <c:otherwise>Loại khác</c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="job-meta-item">
                                            <i class="far fa-calendar-alt"></i>
                                            <fmt:formatDate value="${post.datePost}" pattern="dd/MM/yyyy" />
                                        </div>
                                    </div>
                                    
                                    <c:if test="${not empty post.skill}">
                                        <div class="skill-tags">
                                            <c:forTokens items="${post.skill}" delims="," var="skill">
                                                <span class="skill-tag">${skill}</span>
                                            </c:forTokens>
                                        </div>
                                    </c:if>
                                    
                                    <p class="job-description mt-3">
                                        <c:choose>
                                            <c:when test="${fn:length(post.description) > 100}">
                                                ${fn:substring(post.description, 0, 100)}...
                                            </c:when>
                                            <c:otherwise>
                                                ${post.description}
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                </div>
                                
                                <div class="job-footer d-flex justify-content-between align-items-center">
                                    <span class="badge rounded-pill ${statusClass}">
                                        <i class="fas ${post.status == 1 ? 'fa-check-circle' : 'fa-times-circle'} me-1"></i>
                                        ${statusText}
                                    </span>
                                    <div class="d-flex gap-2">
                                        <c:if test="${post.status == 1}">
                                            <button class="btn btn-sm btn-outline-secondary btn-favorite" data-post-id="${post.postId}">
                                                <i class="far fa-heart me-1"></i>Yêu thích
                                            </button>
                                        </c:if>
                                        <a href="job-details?id=${post.postId}" class="btn btn-sm btn-outline-primary">Xem chi tiết</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12">
                        <div class="no-jobs">
                            <i class="fas fa-briefcase fa-4x mb-3"></i>
                            <h3>Không tìm thấy công việc</h3>
                            <p>Hiện tại chưa có công việc nào được đăng tuyển hoặc phù hợp với tìm kiếm của bạn.</p>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Pagination -->
        <c:if test="${fn:length(posts) > 9}">
            <div class="row mt-4">
                <div class="col-12">
                    <nav aria-label="Page navigation">
                        <ul class="pagination justify-content-center">
                            <li class="page-item disabled"><a class="page-link" href="#" tabindex="-1" aria-disabled="true">Trước</a></li>
                            <li class="page-item active"><a class="page-link" href="#">1</a></li>
                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                            <li class="page-item"><a class="page-link" href="#">Sau</a></li>
                        </ul>
                    </nav>
                </div>
            </div>
        </c:if>

    </div>

    <!-- footer start -->
    <footer class="footer">
        <div class="footer_top">
            <div class="container">
                <div class="row">
                    <div class="col-xl-3 col-md-6 col-lg-3">
                        <div class="footer_widget wow fadeInUp" data-wow-duration="1s" data-wow-delay=".3s">
                            <div class="footer_logo">
                                <a href="#">
                                    <img src="img/logo.png" alt="">
                                </a>
                            </div>
                            <p>
                                finloan@support.com <br>
                                +10 873 672 6782 <br>
                                600/D, Green road, NewYork
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
                                            <i class="fa fa-google-plus"></i>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <i class="fa fa-twitter"></i>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <i class="fa fa-instagram"></i>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-2 col-md-6 col-lg-2">
                        <div class="footer_widget wow fadeInUp" data-wow-duration="1.1s" data-wow-delay=".4s">
                            <h3 class="footer_title">
                                Company
                            </h3>
                            <ul>
                                <li><a href="#">About </a></li>
                                <li><a href="#"> Pricing</a></li>
                                <li><a href="#">Carrier Tips</a></li>
                                <li><a href="#">FAQ</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6 col-lg-3">
                        <div class="footer_widget wow fadeInUp" data-wow-duration="1.2s" data-wow-delay=".5s">
                            <h3 class="footer_title">
                                Category
                            </h3>
                            <ul>
                                <li><a href="#">Design & Art</a></li>
                                <li><a href="#">Engineering</a></li>
                                <li><a href="#">Sales & Marketing</a></li>
                                <li><a href="#">Finance</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-xl-4 col-md-6 col-lg-4">
                        <div class="footer_widget wow fadeInUp" data-wow-duration="1.3s" data-wow-delay=".6s">
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
    <!-- footer end  -->

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
    <script src="js/jquery.magnific-popup.min.js"></script>
    <script src="js/plugins.js"></script>
    <script src="js/gijgo.min.js"></script>

    <script>
    $(document).ready(function() {
        // Xử lý sự kiện click nút yêu thích
        $('.btn-favorite').click(function(e) {
            e.preventDefault();
            const button = $(this);
            const postId = button.data('post-id');
            
            // Đảo trạng thái yêu thích
            button.toggleClass('active');
            
            // Thay đổi icon
            const icon = button.find('i');
            if (button.hasClass('active')) {
                icon.removeClass('far').addClass('fas');
                // Gọi API thêm vào yêu thích
                console.log('Đã thêm công việc ' + postId + ' vào danh sách yêu thích');
            } else {
                icon.removeClass('fas').addClass('far');
                // Gọi API xóa khỏi yêu thích
                console.log('Đã xóa công việc ' + postId + ' khỏi danh sách yêu thích');
            }
            
            // Hiển thị thông báo
            const toast = $('<div class="toast-container position-fixed bottom-0 end-0 p-3">' +
                '<div class="toast show" role="alert" aria-live="assertive" aria-atomic="true">' +
                '<div class="toast-header bg-primary text-white">' +
                '<strong class="me-auto">Thông báo</strong>' +
                '<button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast" aria-label="Close"></button>' +
                '</div>' +
                '<div class="toast-body">' +
                (button.hasClass('active') ? 'Đã thêm vào danh sách yêu thích' : 'Đã xóa khỏi danh sách yêu thích') +
                '</div></div></div>');
                
            $('body').append(toast);
            
            // Tự động ẩn thông báo sau 3 giây
            setTimeout(function() {
                toast.fadeOut(400, function() {
                    $(this).remove();
                });
            }, 3000);
        });
    });
    </script>

    <!--contact js-->
    <script src="js/contact.js"></script>
    <script src="js/jquery.ajaxchimp.min.js"></script>
    <script src="js/jquery.form.js"></script>
    <script src="js/jquery.validate.min.js"></script>
    <script src="js/mail-script.js"></script>

    <script src="js/main.js"></script>
</body>
</html>
