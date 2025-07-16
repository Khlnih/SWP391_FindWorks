<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - FindWorks</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- AOS Animation -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/responsive.css">
    <style>
        :root {
            --primary-color: #2196F3;
            --primary-dark: #0D47A1;
            --primary-light: rgba(33, 150, 243, 0.1);
            --text-color: #2d3436;
            --white: #ffffff;
        }

        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            overflow-x: hidden;
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
            min-height: 100vh;
        }

        /* Sidebar Styles */
        .sidebar {
            width: 250px;
            height: 100vh;
            position: fixed;
            left: -250px;
            background: var(--white);
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            transition: 0.3s ease;
            z-index: 1000;
            overflow-y: auto;
        }

        .sidebar.active {
            left: 0;
        }

        .sidebar-header {
            padding: 20px;
            background: var(--primary-color);
            color: var(--white);
            text-align: center;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        }

        .sidebar-header h3 {
            font-size: 1.5rem;
            font-weight: 600;
            margin: 0;
        }

        .sidebar-content {
            padding: 20px;
        }

        .menu-item {
            padding: 12px 20px;
            color: var(--text-color);
            text-decoration: none;
            display: flex;
            align-items: center;
            transition: 0.3s ease;
            border-radius: 8px;
            margin-bottom: 8px;
        }

        .menu-item:hover {
            background: var(--primary-light);
            color: var(--primary-color);
        }

        .menu-item.active {
            background: var(--primary-color);
            color: var(--white);
            position: relative;
        }

        .menu-item.active::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            height: 100%;
            width: 3px;
            background: var(--white);
            border-radius: 4px 0 0 4px;
        }

        .menu-item i {
            margin-right: 12px;
            width: 20px;
            text-align: center;
        }

        /* Main Content Styles */
        .main-content {
            margin-left: 0;
            padding: 30px;
            background: rgba(255, 255, 255, 0.95);
            transition: 0.3s ease;
            min-height: 100vh;
        }

        .sidebar.active ~ .main-content {
            margin-left: 250px;
        }

        .toggle-btn {
            padding: 12px 20px;
            background: var(--primary-color);
            color: var(--white);
            border: none;
            border-radius: 8px;
            cursor: pointer;
            position: fixed;
            top: 20px;
            left: 20px;
            z-index: 1002;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            transition: 0.3s ease;
            transform: translateX(0);
        }
        .sidebar.active ~ .toggle-btn {
            transform: translateX(250px);
        }

        .toggle-btn:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
        }

        .admin-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .admin-header h2 {
            color: var(--primary-color);
            font-weight: 700;
            font-size: 2.5rem;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
        }

        /* Stats Cards Styles */
        .admin-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 24px;
            padding: 20px;
        }

        .stat-card {
            padding: 24px;
            background: var(--white);
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            text-align: center;
            transition: 0.3s ease;
            border: 1px solid rgba(0, 0, 0, 0.05);
        }

        .stat-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            border-color: var(--primary-color);
        }

        .stat-icon {
            font-size: 28px;
            color: var(--primary-color);
            margin-bottom: 15px;
            position: relative;
        }

        .stat-icon i {
            width: 50px;
            height: 50px;
            line-height: 50px;
            text-align: center;
            border-radius: 50%;
            background: var(--primary-light);
            position: relative;
            z-index: 1;
        }

        .stat-icon::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 60px;
            height: 60px;
            background: var(--primary-color);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            opacity: 0.1;
            z-index: 0;
        }

        .stat-card h3 {
            color: var(--text-color);
            margin: 0 0 12px 0;
            font-size: 1.2rem;
            font-weight: 500;
        }

        .stat-card p {
            color: var(--primary-color);
            font-size: 2.2rem;
            font-weight: 700;
            margin: 0;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .main-content {
                padding: 20px;
            }

            .admin-header h2 {
                font-size: 2rem;
            }

            .stat-card {
                padding: 20px;
            }
        }
    </style>
</head>
<body class="d-flex">
    <jsp:include page="/includes/admin_sidebar.jsp" />

    <!-- Content Wrapper -->
    <div class="content" id="content">
        <!-- Topbar -->
        <nav class="topbar">
            <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                <i class="fa fa-bars"></i>
            </button>
            <div class="d-flex align-items-center">
                <div class="dropdown">
                    <a class="dropdown-toggle d-flex align-items-center" href="#" role="button" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                        <img class="rounded-circle me-2" src="https://via.placeholder.com/40" alt="User Avatar" width="32" height="32">
                        <span class="d-none d-lg-inline me-2 text-gray-600 small">Quản trị viên</span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="userDropdown">
                        <li><a class="dropdown-item" href="#"><i class="fas fa-user fa-sm fa-fw me-2 text-gray-400"></i> Hồ sơ</a></li>
                        <li><a class="dropdown-item" href="#"><i class="fas fa-cogs fa-sm fa-fw me-2 text-gray-400"></i> Cài đặt</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#logoutModal">
                            <i class="fas fa-sign-out-alt fa-sm fa-fw me-2 text-gray-400"></i> Đăng xuất
                        </a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <!--[if lte IE 9]>
            <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="https://browsehappy.com/">upgrade your browser</a> to improve your experience and security.</p>
        <![endif]-->

        <jsp:include page="/includes/admin_sidebar.jsp" />


    <div class="main-content">
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Tổng quan</h1>
            <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm">
                <i class="fas fa-download fa-sm text-white-50"></i> Xuất báo cáo
            </a>
        </div>

        <!-- Content Row -->
        <div class="row">
            <!-- Total Users Card -->
            <div class="col-xl-2 col-md-6 mb-4">
                <div class="card stat-card primary h-100" data-aos="fade-up" data-aos-delay="100">
                    <div class="card-body">
                        <div class="stat-text">Tổng người dùng</div>
                        <div class="stat-value">${totalUsers}</div>
                        <i class="fas fa-users stat-icon"></i>
                    </div>
                    <div class="card-footer d-flex align-items-center justify-content-between">
                        <a class="small text-primary stretched-link" href="#">Xem chi tiết</a>
                        <div class="small text-primary"><i class="fas fa-angle-right"></i></div>
                    </div>
                </div>
            </div>

            <!-- Total Recruiters Card -->
            <div class="col-xl-2 col-md-6 mb-4">
                <div class="card stat-card success h-100" data-aos="fade-up" data-aos-delay="150">
                    <div class="card-body">
                        <div class="stat-text">Nhà tuyển dụng</div>
                        <div class="stat-value">${totalRecruiters}</div>
                        <i class="fas fa-user-tie stat-icon"></i>
                    </div>
                    <div class="card-footer d-flex align-items-center justify-content-between">
                        <a class="small text-success stretched-link" href="#">Xem chi tiết</a>
                        <div class="small text-success"><i class="fas fa-angle-right"></i></div>
                    </div>
                </div>
            </div>

            <!-- Total Job Seekers Card -->
            <div class="col-xl-2 col-md-6 mb-4">
                <div class="card stat-card info h-100" data-aos="fade-up" data-aos-delay="200">
                    <div class="card-body">
                        <div class="stat-text">Ứng viên</div>
                        <div class="stat-value">${totalJobSeekers}</div>
                        <i class="fas fa-user-graduate stat-icon"></i>
                    </div>
                    <div class="card-footer d-flex align-items-center justify-content-between">
                        <a class="small text-info stretched-link" href="#">Xem chi tiết</a>
                        <div class="small text-info"><i class="fas fa-angle-right"></i></div>
                    </div>
                </div>
            </div>

            <!-- Total Jobs Card -->
            <div class="col-xl-2 col-md-6 mb-4">
                <div class="card stat-card warning h-100" data-aos="fade-up" data-aos-delay="250">
                    <div class="card-body">
                        <div class="stat-text">Công việc</div>
                        <div class="stat-value">${totalJobs}</div>
                        <i class="fas fa-briefcase stat-icon"></i>
                    </div>
                    <div class="card-footer d-flex align-items-center justify-content-between">
                        <a class="small text-warning stretched-link" href="#">Xem chi tiết</a>
                        <div class="small text-warning"><i class="fas fa-angle-right"></i></div>
                    </div>
                </div>
            </div>

            <!-- Total Applications Card -->
            <div class="col-xl-2 col-md-6 mb-4">
                <div class="card stat-card danger h-100" data-aos="fade-up" data-aos-delay="300">
                    <div class="card-body">
                        <div class="stat-text">Đơn ứng tuyển</div>
                        <div class="stat-value">${totalApplications}</div>
                        <i class="fas fa-file-alt stat-icon"></i>
                    </div>
                    <div class="card-footer d-flex align-items-center justify-content-between">
                        <a class="small text-danger stretched-link" href="#">Xem chi tiết</a>
                        <div class="small text-danger"><i class="fas fa-angle-right"></i></div>
                    </div>
                </div>
            </div>

            <!-- Total Revenue Card -->
            <div class="col-xl-2 col-md-6 mb-4">
                <div class="card stat-card primary h-100" data-aos="fade-up" data-aos-delay="350">
                    <div class="card-body">
                        <div class="stat-text">Doanh thu</div>
                        <div class="stat-value"><fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></div>
                        <i class="fas fa-money-bill-wave stat-icon"></i>
                    </div>
                    <div class="card-footer d-flex align-items-center justify-content-between">
                        <a class="small text-primary stretched-link" href="#">Xem báo cáo</a>
                        <div class="small text-primary"><i class="fas fa-angle-right"></i></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Content Row -->
        <div class="row">
            <!-- Area Chart -->
            <div class="col-xl-8 col-lg-7">
                <div class="card shadow mb-4" data-aos="fade-up">
                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                        <h6 class="m-0 font-weight-bold text-primary">Tổng quan hoạt động</h6>
                        <div class="dropdown no-arrow">
                            <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="dropdownMenuLink">
                                <li><a class="dropdown-item" href="#">Hôm nay</a></li>
                                <li><a class="dropdown-item" href="#">Tuần này</a></li>
                                <li><a class="dropdown-item" href="#">Tháng này</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="#">Tùy chỉnh</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="chart-area">
                            <canvas id="myAreaChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Pie Chart -->
            <div class="col-xl-4 col-lg-5">
                <div class="card shadow mb-4" data-aos="fade-up" data-aos-delay="100">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">Phân bổ người dùng</h6>
                    </div>
                    <div class="card-body">
                        <div class="chart-pie pt-4 pb-2">
                            <canvas id="myPieChart" 
                                    data-job-seekers="${not empty totalJobSeekers ? totalJobSeekers : 0}"
                                    data-recruiters="${not empty totalRecruiters ? totalRecruiters : 0}">
                            </canvas>
                        </div>
                        <div class="mt-4 text-center small">
                            <span class="me-2">
                                <i class="fas fa-circle text-primary"></i> Ứng viên
                            </span>
                            <span class="me-2">
                                <i class="fas fa-circle text-success"></i> Nhà tuyển dụng
                            </span>
                            <span class="me-2">
                                <i class="fas fa-circle text-info"></i> Khách hàng
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Recent Transactions -->
        <div class="card shadow mb-4" data-aos="fade-up">
            <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                <h6 class="m-0 font-weight-bold text-primary">Giao dịch gần đây</h6>
                <div class="dropdown no-arrow">
                    <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="dropdownMenuLink">
                        <li><a class="dropdown-item" href="#">Xuất Excel</a></li>
                        <li><a class="dropdown-item" href="#">In báo cáo</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="#">Xem tất cả</a></li>
                    </ul>
                </div>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered table-hover" width="100%" cellspacing="0">
                        <thead class="table-light">
                            <tr>
                                <th>Mã GD</th>
                                <th>Người dùng</th>
                                <th>Loại giao dịch</th>
                                <th>Thời gian</th>
                                <th>Trạng thái</th>
                                <th>Mô tả</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty recentTransactions}">
                                    <c:forEach items="${recentTransactions}" var="transaction">
                                        <c:if test="${transaction != null}">
                                            <c:set var="statusClass" value="" />
                                            <c:choose>
                                                <c:when test="${transaction.status eq 'Completed'}">
                                                    <c:set var="statusClass" value="success" />
                                                </c:when>
                                                <c:when test="${transaction.status eq 'Pending'}">
                                                    <c:set var="statusClass" value="warning" />
                                                </c:when>
                                                <c:when test="${transaction.status eq 'Failed'}">
                                                    <c:set var="statusClass" value="danger" />
                                                </c:when>
                                            </c:choose>
                                            <tr>
                                                <td>#${transaction.id}</td>
                                                <td>${transaction.user.fullName}</td>
                                                <td>${transaction.type}</td>
                                                <td><fmt:formatDate value="${transaction.date}" pattern="dd/MM/yyyy HH:mm" /></td>
                                                <td><span class="badge bg-${statusClass}">${transaction.status}</span></td>
                                                <td class="text-truncate" style="max-width: 200px;" title="${transaction.description != null ? transaction.description : "N/A"}">
                                                    ${transaction.description != null ? transaction.description : "N/A"}
                                                </td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="6" class="text-center text-muted py-4">
                                            <i class="fas fa-inbox fa-3x mb-3 text-gray-400"></i>
                                            <p class="mb-0">Không có giao dịch nào gần đây</p>
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <!-- End of Content Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Bạn có chắc muốn đăng xuất?</h5>
                    <button class="close" type="button" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">Chọn "Đăng xuất" bên dưới nếu bạn đã sẵn sàng kết thúc phiên hiện tại.</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-bs-dismiss="modal">Hủy</button>
                    <a class="btn btn-primary" href="login.html">Đăng xuất</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Core plugin JavaScript-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
    <!-- AOS Animation -->
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <!-- Custom scripts for all pages-->
    <script>
        // Initialize AOS animation
        AOS.init({
            duration: 800,
            easing: 'ease-in-out',
            once: true
        });

        // Toggle the side navigation
        const sidebarToggle = document.body.querySelector('#sidebarToggle');
        if (sidebarToggle) {
            sidebarToggle.addEventListener('click', event => {
                event.preventDefault();
                document.body.classList.toggle('sb-sidenav-toggled');
                localStorage.setItem('sb|sidebar-toggle', document.body.classList.contains('sb-sidenav-toggled'));
            });
        }

        // Chart.js scripts
        document.addEventListener('DOMContentLoaded', function() {
            // Initialize charts after the page is fully loaded
            initializeCharts();
        });
        
        function initializeCharts() {
            // Area Chart
            const ctxArea = document.getElementById('myAreaChart');
            if (ctxArea) {
                const areaChartData = {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                    datasets: [{
                        label: 'Số lượng đăng ký',
                        data: [0, 10000, 5000, 15000, 10000, 20000, 15000, 25000, 20000, 30000, 25000, 40000],
                        backgroundColor: 'rgba(78, 115, 223, 0.05)',
                        borderColor: 'rgba(78, 115, 223, 1)',
                        pointRadius: 3,
                        pointBackgroundColor: 'rgba(78, 115, 223, 1)',
                        pointBorderColor: 'rgba(78, 115, 223, 1)',
                        pointHoverRadius: 3,
                        pointHoverBackgroundColor: 'rgba(78, 115, 223, 1)',
                        pointHoverBorderColor: 'rgba(78, 115, 223, 1)',
                        pointHitRadius: 10,
                        pointBorderWidth: 2,
                        tension: 0.3
                    }]
                };
                
                const areaChartOptions = {
                    maintainAspectRatio: false,
                    layout: {
                        padding: {
                            left: 10,
                            right: 25,
                            top: 25,
                            bottom: 0
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: {
                                color: 'rgb(234, 236, 244)',
                                borderDash: [2],
                                drawBorder: false,
                                drawTicks: false
                            },
                            ticks: {
                                maxTicksLimit: 5,
                                padding: 10,
                                callback: function(value) {
                                    return value.toLocaleString('vi-VN');
                                }
                            }
                        },
                        x: {
                            grid: {
                                display: false,
                                drawBorder: false
                            },
                            ticks: {
                                maxTicksLimit: 7
                            }
                        }
                    },
                    plugins: {
                        legend: {
                            display: false
                        },
                        tooltip: {
                            backgroundColor: 'rgb(255,255,255)',
                            bodyColor: '#858796',
                            titleMarginBottom: 10,
                            titleColor: '#6e707e',
                            titleFontSize: 14,
                            borderColor: '#dddfeb',
                            borderWidth: 1,
                            xPadding: 15,
                            yPadding: 15,
                            displayColors: false,
                            intersect: false,
                            mode: 'index',
                            caretPadding: 10,
                            callbacks: {
                                label: function(context) {
                                    return context.parsed.y.toLocaleString('vi-VN');
                                }
                            }
                        }
                    }
                };
                
                new Chart(ctxArea, {
                    type: 'line',
                    data: areaChartData,
                    options: areaChartOptions
                });
            }

            // Pie Chart
            const ctxPie = document.getElementById('myPieChart');
            if (ctxPie) {
                // Get the data from data attributes
                const jobSeekers = parseInt(ctxPie.getAttribute('data-job-seekers') || '0');
                const recruiters = parseInt(ctxPie.getAttribute('data-recruiters') || '0');
                
                const pieChartData = {
                    labels: ['Ứng viên', 'Nhà tuyển dụng', 'Khách hàng'],
                    datasets: [{
                        data: [jobSeekers, recruiters, 0],
                        backgroundColor: ['#4e73df', '#1cc88a', '#36b9cc'],
                        hoverBackgroundColor: ['#2e59d9', '#17a673', '#2c9faf'],
                        hoverBorderColor: 'rgba(234, 236, 244, 1)'
                    }]
                };
                
                const pieChartOptions = {
                    maintainAspectRatio: false,
                    plugins: {
                        tooltip: {
                            backgroundColor: 'rgb(255,255,255)',
                            bodyColor: '#858796',
                            borderColor: '#dddfeb',
                            borderWidth: 1,
                            xPadding: 15,
                            yPadding: 15,
                            displayColors: false,
                            caretPadding: 10
                        },
                        legend: {
                            display: false
                        }
                    },
                    cutout: '80%'
                };
                
                new Chart(ctxPie, {
                    type: 'doughnut',
                    data: pieChartData,
                    options: pieChartOptions
                });
            }
        }

        // Scroll to top button appear
        document.addEventListener('scroll', function() {
            const scrollToTop = document.querySelector('.scroll-to-top');
            if (document.documentElement.scrollTop > 100) {
                scrollToTop.style.display = 'block';
            } else {
                scrollToTop.style.display = 'none';
            }
        });

        // Smooth scrolling using jQuery easing
        document.querySelectorAll('a.js-scroll-trigger[href*="#"]:not([href="#"])').forEach(anchor => {
            anchor.addEventListener('click', function(e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    window.scrollTo({
                        top: target.offsetTop - 70,
                        behavior: 'smooth'
                    });
                }
            });
        });

        // Close any open menu accordions when window is resized below 768px
        window.addEventListener('resize', function() {
            if (window.innerWidth < 768) {
                const openDropdown = document.querySelector('.dropdown-menu.show');
                if (openDropdown) {
                    const dropdown = new bootstrap.Dropdown(openDropdown.closest('.dropdown'));
                    dropdown.hide();
                }
            }
        });
    </script>
</body>
</html>
