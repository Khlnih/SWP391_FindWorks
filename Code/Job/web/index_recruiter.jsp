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
        :root {
            --primary: #007bff;
            --primary-hover: #0056b3;
            --light: #f8f9fa;
        }
        
        /* Smooth scroll behavior */
        html {
            scroll-behavior: smooth;
        }
        
        /* Custom scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
            height: 8px;
        }
        
        ::-webkit-scrollbar-track {
            background: #f1f1f1;
        }
        
        ::-webkit-scrollbar-thumb {
            background: #4e54c8;
            border-radius: 4px;
        }
        
        ::-webkit-scrollbar-thumb:hover {
            background: #3a3f9e;
        }
        
        /* Header buttons container */
        .header-buttons {
            display: flex;
            align-items: center;
            gap: 12px;
            height: 50px;
            padding: 5px 0;
        }
        
        .boxed-btn3 {
            background: var(--gradient-success);
            color: white !important;
            box-shadow: 0 4px 12px rgba(28, 200, 138, 0.25);
        }
        
        .header-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            height: 40px;
            border-radius: 20px;
            padding: 0 18px;
            font-weight: 500;
            font-size: 14px;
            text-decoration: none !important;
            transition: all 0.25s ease;
            white-space: nowrap;
            border: none;
            cursor: pointer;
        }
        
        .profile-btn {
            background: var(--gradient-primary) !important;
            color: white !important;
            box-shadow: 0 4px 12px rgba(78, 115, 223, 0.25);
            padding-left: 15px;
            padding-right: 20px;
        }
        
        .profile-btn:hover {
            background: linear-gradient(135deg, #28a745 0%, #00D363 100%) !important;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 211, 99, 0.4);
            color: white !important;
            text-decoration: none !important;
        }
        
        .profile-avatar {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            border: 2px solid rgba(255,255,255,0.9);
            margin-right: 10px;
            object-fit: cover;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            transition: all 0.2s ease;
        }
        
        .profile-text {
            font-weight: 600;
            letter-spacing: 0.3px;
        }
        
        .logout-btn {
            background: linear-gradient(135deg, #ff6b6b 0%, #ff4757 100%);
            color: white !important;
            box-shadow: 0 4px 12px rgba(255, 107, 107, 0.25);
        }
        
        .logout-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(255,255,255,0.2) 0%, rgba(255,255,255,0.05) 100%);
            opacity: 0;
            transition: all 0.3s ease;
        }
        
        .logout-btn:hover {
            background: linear-gradient(135deg, #ff4757 0%, #ff6b6b 100%);
            color: white !important;
            text-decoration: none !important;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(255, 71, 87, 0.4);
        }
        
        .logout-btn:hover::before {
            opacity: 1;
        }
        
        .logout-btn i {
            transition: transform 0.3s ease;
        }
        
        .logout-btn:hover i {
            transform: rotate(180deg);
        }
        
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
            background: white;
            border-radius: 12px;
            padding: 25px 20px;
            text-align: left;
            margin-bottom: 20px;
            transition: all 0.3s ease;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
            border-left: 4px solid var(--primary-color);
            position: relative;
            overflow: hidden;
        }
        
        .dashboard-stats.primary { border-left-color: var(--primary-color); }
        .dashboard-stats.success { border-left-color: var(--secondary-color); }
        .dashboard-stats.warning { border-left-color: var(--accent-color); }
        .dashboard-stats.danger { border-left-color: #e74a3b; }
        
        .dashboard-stats:hover {
            transform: translateY(-5px);
            box-shadow: 0 0.5rem 1.5rem 0.5rem rgba(58, 59, 69, 0.15);
        }
        
        .stat-icon {
            position: absolute;
            right: 20px;
            top: 20px;
            font-size: 2.5rem;
            opacity: 0.3;
            color: var(--dark-color);
        }
        
        .stat-number {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--dark-color);
            display: block;
            margin-bottom: 5px;
        }
        
        .stat-label {
            font-size: 0.9rem;
            color: #858796;
            text-transform: uppercase;
            font-weight: 600;
            letter-spacing: 0.5px;
        }
        
        .stat-change {
            display: inline-block;
            font-size: 0.8rem;
            padding: 2px 8px;
            border-radius: 10px;
            margin-top: 5px;
            font-weight: 600;
        }
        
        .stat-change.positive {
            color: #1cc88a;
            background-color: rgba(28, 200, 138, 0.1);
        }
        
        .stat-change.negative {
            color: #e74a3b;
            background-color: rgba(231, 74, 59, 0.1);
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
                                    <div class="header-buttons">
                                        <!-- Profile Button with Avatar -->
                                        <a href="recruiter_details.jsp" class="header-btn profile-btn">
                                            <img src="<%= avatarPath %>" alt="Avatar" class="profile-avatar">
                                            <span class="profile-text"><%= userName %></span>
                                        </a>
                                        
                                        <!-- Post Job Button -->
                                        <a href="post?action=create" class="header-btn boxed-btn3">
                                            <i class="fas fa-plus mr-2"></i> Post Job
                                        </a>
                                        
                                        <!-- Logout Button -->
                                        <a href="${pageContext.request.contextPath}/logout" class="header-btn logout-btn">
                                            <i class="fas fa-sign-out-alt mr-2"></i>
                                            <span>Logout</span>
                                        </a>
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

    <!-- Hero Section -->
    <div class="hero-section" style="background: linear-gradient(135deg, #007bff 0%, #0056b3 100%); padding: 100px 0 150px; position: relative; overflow: hidden;">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <div class="hero-content" style="position: relative; z-index: 10;">
                        <h1 class="wow fadeInUp" data-wow-duration="1s" data-wow-delay=".3s" style="font-size: 3rem; font-weight: 800; color: white; line-height: 1.2; margin-bottom: 20px;">
                            Tìm Ứng Viên <span style="color: #00ff9d;">Tài Năng</span> Cho Doanh Nghiệp Của Bạn
                        </h1>
                        <p class="wow fadeInUp" data-wow-duration="1s" data-wow-delay=".4s" style="font-size: 1.1rem; color: rgba(255,255,255,0.9); margin-bottom: 30px; max-width: 600px;">
                            Kết nối với hàng ngàn ứng viên tiềm năng, đăng tin tuyển dụng dễ dàng và tìm kiếm nhân sự phù hợp nhất cho doanh nghiệp của bạn.
                        </p>
                        <div class="hero-search wow fadeInUp" data-wow-duration="1s" data-wow-delay=".5s" style="background: white; padding: 20px; border-radius: 10px; box-shadow: 0 10px 30px rgba(0,0,0,0.1);">
                            <form action="freelancer_list" method="GET">
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <div class="input-group">
                                            <span class="input-group-text bg-white border-end-0"><i class="fas fa-search text-muted"></i></span>
                                            <input type="text" name="q" class="form-control border-start-0 ps-0" placeholder="Tên công việc, kỹ năng hoặc từ khóa">
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="input-group">
                                            <span class="input-group-text bg-white border-end-0"><i class="fas fa-map-marker-alt text-muted"></i></span>
                                            <select name="location" class="form-select border-start-0 ps-0">
                                                <option value="">Tất cả địa điểm</option>
                                                <option>Hồ Chí Minh</option>
                                                <option>Hà Nội</option>
                                                <option>Đà Nẵng</option>
                                                <option>Làm việc từ xa</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-2">
                                        <button type="submit" class="btn btn-primary w-100" style="height: 45px;">
                                            <i class="fas fa-search me-1"></i> Tìm kiếm
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="mt-4 wow fadeInUp" data-wow-duration="1s" data-wow-delay=".6s">
                            <a href="post?action=create" class="btn btn-light me-3" style="padding: 12px 30px; border-radius: 50px; font-weight: 600; box-shadow: 0 10px 20px rgba(0,0,0,0.1); background: var(--primary); border: none; color: white; transition: all 0.3s ease;">
                            <i class="fas fa-plus me-2"></i> Đăng tin tuyển dụng
                        </a>    
                            <a href="#how-it-works" class="btn btn-outline-light" style="padding: 10px 25px; border-radius: 50px; font-weight: 500; border: 2px solid rgba(255,255,255,0.3);">
                                <i class="fas fa-play-circle me-2"></i> Xem hướng dẫn
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 d-none d-lg-block">
                    <img src="img/banner/recruiter-hero.svg" alt="Tuyển dụng hiệu quả" class="img-fluid wow fadeIn" data-wow-duration="1.5s">
                </div>
            </div>
        </div>
        
    </div>
    <!-- Các tính năng nổi bật -->
    <section class="py-5" id="features" style="background-color: #f8fafd;">
        <div class="container py-5">
            <div class="text-center mb-5">
                <h2 class="fw-bold mb-3">Giải Pháp Tuyển Dụng Toàn Diện</h2>
                <p class="text-muted">Công cụ mạnh mẽ giúp doanh nghiệp của bạn tìm kiếm và thu hút nhân tài</p>
            </div>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="feature-card p-4 h-100 text-center border-0 shadow-sm rounded-3" 
                         style="background: white; transition: all 0.3s ease; border-top: 4px solid var(--primary) !important;"
                         onmouseover="this.style.transform='translateY(-5px)'; this.style.boxShadow='0 10px 20px rgba(0, 123, 255, 0.15) !important';"
                         onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 0.5rem 1rem rgba(0, 0, 0, 0.05) !important';">
                        <div class="icon-box mx-auto mb-4" style="width: 80px; height: 80px; background: rgba(0, 123, 255, 0.1); border-radius: 20px; display: flex; align-items: center; justify-content: center;">
                            <i class="fas fa-bullhorn fa-2x" style="color: var(--primary); transition: all 0.3s ease;"></i>
                        </div>
                        <h4 class="mb-3" style="color: #2d3748;">Đăng Tin Tuyển Dụng</h4>
                        <p class="text-muted" style="color: #718096 !important;">Tạo và đăng tin tuyển dụng chuyên nghiệp, tiếp cận hàng ngàn ứng viên tiềm năng chỉ trong vài phút.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card p-4 h-100 text-center">
                        <div class="icon-box mx-auto mb-4" style="width: 80px; height: 80px; background: rgba(28, 200, 138, 0.1); border-radius: 20px; display: flex; align-items: center; justify-content: center;">
                            <i class="fas fa-search fa-2x" style="color: #1cc88a;"></i>
                        </div>
                        <h4 class="mb-3">Tìm Kiếm Ứng Viên</h4>
                        <p class="text-muted">Kho dữ liệu ứng viên đa dạng với đầy đủ thông tin, giúp bạn dễ dàng tìm thấy ứng viên phù hợp.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card p-4 h-100 text-center">
                        <div class="icon-box mx-auto mb-4" style="width: 80px; height: 80px; background: rgba(246, 194, 62, 0.1); border-radius: 20px; display: flex; align-items: center; justify-content: center;">
                            <i class="fas fa-tasks fa-2x" style="color: #f6c23e;"></i>
                        </div>
                        <h4 class="mb-3">Quản Lý Ứng Tuyển</h4>
                        <p class="text-muted">Theo dõi và quản lý tất cả đơn ứng tuyển một cách hiệu quả với công cụ quản lý thông minh.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Cách hoạt động -->
    <section class="py-5" id="how-it-works" style="background: linear-gradient(135deg, #f8fafd 0%, #eef4ff 100%);">
        <div class="container py-5">
            <div class="row align-items-center">
                <div class="col-lg-6 mb-4 mb-lg-0">
                    <img src="img/banner/recruiter-process.svg" alt="Quy trình tuyển dụng" class="img-fluid" style="filter: drop-shadow(0 10px 15px rgba(0, 0, 0, 0.1));">
                </div>
                <div class="col-lg-6">
                    <h2 class="fw-bold mb-4">Bắt Đầu Tuyển Dụng Dễ Dàng</h2>
                    <div class="d-flex mb-4">
                        <div class="me-4">
                            <div class="rounded-circle d-flex align-items-center justify-content-center" style="width: 50px; height: 50px; background: var(--primary); color: white; font-weight: 600; font-size: 1.25rem; box-shadow: 0 5px 15px rgba(0, 123, 255, 0.3);">1</div>
                        </div>
                        <div>
                            <h5 class="mb-2">Tạo tài khoản doanh nghiệp</h5>
                            <p class="text-muted mb-0">Đăng ký và xác minh tài khoản doanh nghiệp của bạn trong vài bước đơn giản.</p>
                        </div>
                    </div>
                    <div class="d-flex mb-4">
                        <div class="me-4">
                            <div class="rounded-circle bg-primary text-white d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">2</div>
                        </div>
                        <div>
                            <h5 class="mb-2">Đăng tin tuyển dụng</h5>
                            <p class="text-muted mb-0">Tạo tin tuyển dụng hấp dẫn với đầy đủ thông tin về vị trí và yêu cầu công việc.</p>
                        </div>
                    </div>
                    <div class="d-flex">
                        <div class="me-4">
                            <div class="rounded-circle bg-primary text-white d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">3</div>
                        </div>
                        <div>
                            <h5 class="mb-2">Tiếp cận ứng viên</h5>
                            <p class="text-muted mb-0">Tiếp cận hàng ngàn ứng viên tiềm năng và bắt đầu quá trình tuyển dụng.</p>
                        </div>
                    </div>
                    <div class="mt-5">
                        <a href="post?action=create" class="btn btn-primary px-4 py-2">Bắt đầu ngay</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Lý do lựa chọn -->
    <section class="py-5" style="background-color: #ffffff;">
        <div class="container py-5">
            <div class="text-center mb-5">
                <h2 class="fw-bold mb-3">Tại Sao Chọn Chúng Tôi?</h2>
                <p class="text-muted">Những lý do hàng đầu khiến hơn 10,000+ doanh nghiệp tin tưởng sử dụng dịch vụ của chúng tôi</p>
            </div>
            <div class="row g-4">
                <div class="col-md-6 col-lg-4">
                    <div class="p-4 h-100 rounded-3" style="background: white; border: 1px solid #e2e8f0; transition: all 0.3s ease; height: 100%;">
                        <div class="d-flex align-items-center mb-3">
                            <div class="me-3" style="width: 50px; height: 50px; background: rgba(0, 123, 255, 0.1); border-radius: 12px; display: flex; align-items: center; justify-content: center;">
                                <i class="fas fa-users" style="color: var(--primary); font-size: 1.25rem;"></i>
                            </div>
                            <h4 class="mb-0" style="color: #2d3748;">Đa Dạng Ứng Viên</h4>
                        </div>
                        <p class="mb-0" style="color: #718096 !important;">Tiếp cận hàng trăm ngàn hồ sơ ứng viên chất lượng cao từ nhiều ngành nghề khác nhau.</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4">
                    <div class="p-4 h-100 border rounded-3">
                        <div class="d-flex align-items-center mb-3">
                            <div class="me-3 text-success">
                                <i class="fas fa-bolt fa-2x"></i>
                            </div>
                            <h4 class="mb-0">Tốc Độ Nhanh</h4>
                        </div>
                        <p class="text-muted mb-0">Tìm kiếm và kết nối với ứng viên phù hợp chỉ trong thơi gian ngắn.</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4">
                    <div class="p-4 h-100 border rounded-3">
                        <div class="d-flex align-items-center mb-3">
                            <div class="me-3 text-warning">
                                <i class="fas fa-shield-alt fa-2x"></i>
                            </div>
                            <h4 class="mb-0">Bảo Mật Tuyệt Đối</h4>
                        </div>
                        <p class="text-muted mb-0">Đảm bảo an toàn và bảo mật thông tin doanh nghiệp của bạn.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="py-5" style="background: linear-gradient(135deg, #007bff 0%, #0056b3 100%); color: white;">
        <div class="container py-5">
            <div class="row justify-content-center">
                <div class="col-lg-8 text-center">
                    <h2 class="fw-bold mb-4">Sẵn Sàng Tìm Ứng Viên Tài Năng?</h2>
                    <p class="lead mb-5">Đăng ký ngay hôm nay để bắt đầu hành trình tìm kiếm nhân tài cho doanh nghiệp của bạn.</p>
                    <div class="d-flex justify-content-center gap-3">
                        <a href="post?action=create" class="btn btn-light btn-lg px-4 me-3" style="background: white; color: var(--primary); font-weight: 600; border: none; box-shadow: 0 4px 15px rgba(0,0,0,0.1); transition: all 0.3s ease;"
                       onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 8px 25px rgba(0,0,0,0.15)';"
                       onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 4px 15px rgba(0,0,0,0.1)';">
                        <i class="fas fa-plus me-2"></i>Đăng tin tuyển dụng
                    </a>
                    <a href="freelancer_list" class="btn btn-outline-light btn-lg px-4" style="border: 2px solid rgba(255,255,255,0.5); transition: all 0.3s ease;"
                       onmouseover="this.style.backgroundColor='rgba(255,255,255,0.1)'; this.style.transform='translateY(-2px)';"
                       onmouseout="this.style.backgroundColor='transparent'; this.style.transform='translateY(0)';">
                        <i class="fas fa-search me-2"></i>Tìm ứng viên ngay
                    </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Quick Action Cards -->
    <div class="quick-actions py-5 bg-light">
        <div class="container">
            <div class="row">
                <div class="col-12 mb-4">
                    <h4 class="font-weight-bold">Quick Actions</h4>
                    <p class="text-muted">Manage your recruitment process efficiently</p>
                </div>
                <div class="col-md-6 col-lg-3 mb-4">
                    <a href="post?action=create" class="card h-100 border-0 shadow-sm text-decoration-none">
                        <div class="card-body text-center p-4">
                            <div class="icon-box bg-primary bg-gradient text-white rounded-circle mx-auto mb-3" style="width: 60px; height: 60px; display: flex; align-items: center; justify-content: center;">
                                <i class="fas fa-plus fa-2x"></i>
                            </div>
                            <h5 class="mb-2">Post New Job</h5>
                            <p class="text-muted small mb-0">Create and publish a new job listing</p>
                        </div>
                    </a>
                </div>
                <div class="col-md-6 col-lg-3 mb-4">
                    <a href="post?action=list" class="card h-100 border-0 shadow-sm text-decoration-none">
                        <div class="card-body text-center p-4">
                            <div class="icon-box bg-success bg-gradient text-white rounded-circle mx-auto mb-3" style="width: 60px; height: 60px; display: flex; align-items: center; justify-content: center;">
                                <i class="fas fa-briefcase fa-2x"></i>
                            </div>
                            <h5 class="mb-2">Manage Jobs</h5>
                            <p class="text-muted small mb-0">View and edit your job postings</p>
                        </div>
                    </a>
                </div>
                <div class="col-md-6 col-lg-3 mb-4">
                    <a href="freelancer_list" class="card h-100 border-0 shadow-sm text-decoration-none">
                        <div class="card-body text-center p-4">
                            <div class="icon-box bg-warning bg-gradient text-white rounded-circle mx-auto mb-3" style="width: 60px; height: 60px; display: flex; align-items: center; justify-content: center;">
                                <i class="fas fa-search fa-2x"></i>
                            </div>
                            <h5 class="mb-2">Find Candidates</h5>
                            <p class="text-muted small mb-0">Browse potential candidates</p>
                        </div>
                    </a>
                </div>
                <div class="col-md-6 col-lg-3 mb-4">
                    <a href="#" class="card h-100 border-0 shadow-sm text-decoration-none">
                        <div class="card-body text-center p-4">
                            <div class="icon-box bg-info bg-gradient text-white rounded-circle mx-auto mb-3" style="width: 60px; height: 60px; display: flex; align-items: center; justify-content: center;">
                                <i class="fas fa-chart-line fa-2x"></i>
                            </div>
                            <h5 class="mb-2">View Reports</h5>
                            <p class="text-muted small mb-0">Track your hiring analytics</p>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Advanced Search Section -->
    <div class="search-section py-5 bg-white">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <div class="card border-0 shadow">
                        <div class="card-body p-4">
                            <h5 class="mb-4">Find Perfect Candidates</h5>
                            <form>
                                <div class="row g-3">
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <div class="input-group">
                                                <span class="input-group-text bg-white border-end-0"><i class="fas fa-search text-muted"></i></span>
                                                <input type="text" class="form-control border-start-0 ps-0" placeholder="Job title, skills, or keywords">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <div class="input-group">
                                                <span class="input-group-text bg-white border-end-0"><i class="fas fa-map-marker-alt text-muted"></i></span>
                                                <select class="form-select border-start-0 ps-0">
                                                    <option selected>Location</option>
                                                    <option>Ho Chi Minh</option>
                                                    <option>Hanoi</option>
                                                    <option>Da Nang</option>
                                                    <option>Remote</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <div class="input-group">
                                                <span class="input-group-text bg-white border-end-0"><i class="fas fa-tools text-muted"></i></span>
                                                <select class="form-select border-start-0 ps-0">
                                                    <option selected>Skills</option>
                                                    <option>Java</option>
                                                    <option>JavaScript</option>
                                                    <option>Python</option>
                                                    <option>React</option>
                                                    <option>Node.js</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-2">
                                        <button type="submit" class="btn btn-primary w-100">
                                            <i class="fas fa-search me-2"></i> Search
                                        </button>
                                    </div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col-12">
                                        <div class="d-flex flex-wrap gap-2">
                                            <span class="text-muted small me-2">Popular Searches:</span>
                                            <a href="#" class="badge bg-light text-dark text-decoration-none me-2 mb-2">
                                                <i class="fas fa-code me-1"></i> Full Stack Developer
                                            </a>
                                            <a href="#" class="badge bg-light text-dark text-decoration-none me-2 mb-2">
                                                <i class="fas fa-paint-brush me-1"></i> UI/UX Designer
                                            </a>
                                            <a href="#" class="badge bg-light text-dark text-decoration-none me-2 mb-2">
                                                <i class="fas fa-server me-1"></i> DevOps Engineer
                                            </a>
                                            <a href="#" class="badge bg-light text-dark text-decoration-none me-2 mb-2">
                                                <i class="fas fa-mobile-alt me-1"></i> Mobile Developer
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
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
    <footer style="background: #343a40; color: white; padding-top: 4rem; padding-bottom: 2rem;">
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-4 col-md-6">
                    <h5 class="text-white mb-4">Về FindWorks</h5>
                    <p class="text-muted">Nền tảng kết nối nhà tuyển dụng và ứng viên tiềm năng, giúp quá trình tuyển dụng trở nên đơn giản và hiệu quả hơn bao giờ hết.</p>
                    <div class="social-links mt-4">
                        <a href="#" class="text-white me-3"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="text-white me-3"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#" class="text-white me-3"><i class="fab fa-instagram"></i></a>
                        <a href="#" class="text-white"><i class="fab fa-youtube"></i></a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-6">
                    <h5 class="text-white mb-4">Dành cho NTD</h5>
                    <ul class="list-unstyled">
                        <li class="mb-2"><a href="#" class="text-muted text-decoration-none">Đăng tin tuyển dụng</a></li>
                        <li class="mb-2"><a href="#" class="text-muted text-decoration-none">Tìm kiếm ứng viên</a></li>
                        <li class="mb-2"><a href="#" class="text-muted text-decoration-none">Bảng giá dịch vụ</a></li>
                        <li class="mb-2"><a href="#" class="text-muted text-decoration-none">Hướng dẫn sử dụng</a></li>
                    </ul>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h5 class="text-white mb-4">Tài nguyên</h5>
                    <ul class="list-unstyled">
                        <li class="mb-2"><a href="#" class="text-muted text-decoration-none">Mẫu tin tuyển dụng</a></li>
                        <li class="mb-2"><a href="#" class="text-muted text-decoration-none">Kinh nghiệm tuyển dụng</a></li>
                        <li class="mb-2"><a href="#" class="text-muted text-decoration-none">Xu hướng tuyển dụng</a></li>
                        <li class="mb-2"><a href="#" class="text-muted text-decoration-none">Hỏi đáp</a></li>
                    </ul>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h5 class="text-white mb-4">Liên hệ</h5>
                    <ul class="list-unstyled text-muted">
                        <li class="mb-2"><i class="fas fa-map-marker-alt me-2"></i> 123 Đ. ABC, Quận 1, TP.HCM</li>
                        <li class="mb-2"><i class="fas fa-phone-alt me-2"></i> 1900 1234</li>
                        <li class="mb-2"><i class="fas fa-envelope me-2"></i> ntd@findworks.vn</li>
                        <li class="mb-2"><i class="fas fa-clock me-2"></i> Thứ 2 - Thứ 7: 8:00 - 17:30</li>
                    </ul>
                </div>
            </div>
            <hr class="my-4" style="border-color: rgba(255,255,255,0.1);">
            <div class="row align-items-center">
                <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                    <p class="mb-0 text-muted"> 2023 FindWorks. Bảo lưu mọi quyền.</p>
                </div>
                <div class="col-md-6 text-center text-md-end">
                    <ul class="list-inline mb-0">
                        <li class="list-inline-item"><a href="#" class="text-muted text-decoration-none">Điều khoản sử dụng</a></li>
                        <li class="list-inline-item mx-3">|</li>
                        <li class="list-inline-item"><a href="#" class="text-muted text-decoration-none">Chính sách bảo mật</a></li>
                    </ul>
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
