<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý - Admin</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');
        
        :root {
            /* Modern Ocean Blue Color Palette */
            --primary: #3b82f6;
            --primary-light: #dbeafe;
            --primary-lighter: #eff6ff;
            --primary-dark: #2563eb;
            --primary-darker: #1d4ed8;
            
            --success: #10b981;
            --success-light: #d1fae5;
            --success-dark: #059669;
            
            --info: #06b6d4;
            --info-light: #cffafe;
            --info-dark: #0891b2;
            
            --warning: #f59e0b;
            --warning-light: #fef3c7;
            --warning-dark: #d97706;
            
            --danger: #ef4444;
            --danger-light: #fee2e2;
            --danger-dark: #dc2626;
            
            /* Modern Grayscale */
            --dark: #1e293b;
            --light: #f1f5f9;
            --lighter: #f8fafc;
            --white: #ffffff;
            
            --gray-50: #f8fafc;
            --gray-100: #f1f5f9;
            --gray-200: #e2e8f0;
            --gray-300: #cbd5e1;
            --gray-400: #94a3b8;
            --gray-500: #64748b;
            --gray-600: #475569;
            --gray-700: #334155;
            --gray-800: #1e293b;
            --gray-900: #0f172a;
            
            /* Glassmorphism Effect */
            --glass-bg: rgba(255, 255, 255, 0.7);
            --glass-border: rgba(255, 255, 255, 0.18);
            --glass-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.05);
            
            /* Effects */
            --shadow-sm: 0 0.15rem 0.5rem 0 rgba(58, 59, 69, 0.08);
            --shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
            --transition: all 0.2s ease-in-out;
            --border-radius: 0.5rem;
            --border-radius-lg: 0.75rem;
        }
        
        body {
            background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 50%, #bae6fd 100%);
            background-attachment: fixed;
            font-family: 'Poppins', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            color: var(--gray-700);
            line-height: 1.7;
            min-height: 100vh;
        }
        
        /* Typography */
        h1, h2, h3, h4, h5, h6 {
            color: var(--gray-900);
            font-weight: 700;
            margin-bottom: 1rem;
        }
        
        /* Navigation Tabs */
        .nav-tabs {
            border: none;
            margin-bottom: 1.5rem;
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            padding: 0.5rem;
            border-radius: var(--border-radius);
            box-shadow: var(--glass-shadow);
            border: 1px solid var(--glass-border);
        }
        
        .nav-tabs .nav-link {
            color: var(--gray-600);
            border: none;
            border-radius: 0.35rem;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            transition: var(--transition);
            margin-right: 0.5rem;
            display: flex;
            align-items: center;
        }
        
        .nav-tabs .nav-link i {
            margin-right: 0.5rem;
            font-size: 1.1em;
        }
        
        .nav-tabs .nav-link:hover {
            color: var(--primary);
            background-color: var(--primary-light);
        }
        
        .nav-tabs .nav-link.active {
            color: var(--white);
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            box-shadow: 0 4px 15px rgba(59, 130, 246, 0.3);
            border: none;
            position: relative;
            overflow: hidden;
        }
        
        .nav-tabs .nav-link.active::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 3px;
            background: var(--white);
            border-radius: 0 0 4px 4px;
        }
        
        /* Tab Content */
        .tab-content {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            padding: 2rem;
            border-radius: var(--border-radius);
            box-shadow: var(--glass-shadow);
            border: 1px solid var(--glass-border);
            margin-bottom: 2rem;
            transition: all 0.3s ease;
        }
        
        .tab-content:hover {
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.1);
            transform: translateY(-2px);
        }
        
        /* Stat Cards */
        .stat-card {
            border: none;
            border-radius: var(--border-radius);
            padding: 1.75rem 1.5rem;
            margin-bottom: 1.5rem;
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            box-shadow: var(--glass-shadow);
            border: 1px solid var(--glass-border);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow);
        }
        
        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
        }
        
        .stat-card.primary::before { background: var(--primary); }
        .stat-card.success::before { background: var(--success); }
        .stat-card.info::before { background: var(--info); }
        .stat-card.warning::before { background: var(--warning); }
        .stat-card.danger::before { background: var(--danger); }
        
        .stat-card .stat-title {
            color: var(--gray-600);
            font-size: 0.9rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            margin-bottom: 0.5rem;
        }
        
        .stat-card .stat-value {
            color: var(--gray-900);
            font-size: 1.75rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }
        
        .stat-card .stat-desc {
            color: var(--gray-500);
            font-size: 0.85rem;
        }
        
        .stat-card .stat-icon {
            position: absolute;
            right: 1.5rem;
            top: 50%;
            transform: translateY(-50%);
            font-size: 3rem;
            opacity: 0.2;
            color: inherit;
        }
        
        /* Tables */
        .table {
            width: 100%;
            margin-bottom: 1rem;
            color: var(--gray-800);
            border-collapse: separate;
            border-spacing: 0;
        }
        
        .table thead th {
            background-color: var(--gray-100);
            color: var(--gray-700);
            font-weight: 700;
            text-transform: uppercase;
            font-size: 0.75rem;
            letter-spacing: 0.05em;
            padding: 1rem;
            border: none;
            white-space: nowrap;
        }
        
        .table tbody td {
            padding: 1rem;
            vertical-align: middle;
            border-top: 1px solid var(--gray-200);
            transition: var(--transition);
        }
        
        .table tbody tr:hover td {
            background-color: var(--gray-100);
        }
        
        /* Buttons */
        .btn {
            padding: 0.5rem 1.25rem;
            border-radius: 0.35rem;
            font-weight: 600;
            font-size: 0.85rem;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }
        
        .btn i {
            margin-right: 0.5rem;
        }
        
        .btn-sm {
            padding: 0.4rem 0.8rem;
            font-size: 0.8rem;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            border: none;
            box-shadow: 0 4px 15px rgba(59, 130, 246, 0.3);
            position: relative;
            overflow: hidden;
            z-index: 1;
        }
        
        .btn-primary::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 0;
            height: 100%;
            background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary-darker) 100%);
            transition: all 0.4s ease;
            z-index: -1;
        }
        
        .btn-primary:hover::before {
            width: 100%;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(78, 115, 223, 0.4);
        }
        
        .btn-outline-primary {
            color: var(--primary);
            border: 1px solid var(--primary);
            background: transparent;
        }
        
        .btn-outline-primary:hover {
            background: var(--primary-light);
            color: var(--primary-dark);
        }
        
        /* Badges */
        .badge {
            padding: 0.5em 0.8em;
            font-weight: 600;
            font-size: 0.75rem;
            border-radius: 0.25rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        
        .bg-success {
            background-color: var(--success) !important;
        }
        
        .bg-warning {
            background-color: var(--warning) !important;
            color: #000 !important;
        }
        
        .bg-danger {
            background-color: var(--danger) !important;
        }
        
        .bg-info {
            background-color: var(--info) !important;
        }
        
        /* Action Buttons */
        .btn-action {
            width: 32px;
            height: 32px;
            padding: 0;
            border-radius: 0.35rem;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin: 0 2px;
            transition: var(--transition);
            border: none;
            background: var(--gray-100);
            color: var(--gray-600);
        }
        
        .btn-action:hover {
            transform: translateY(-2px);
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        
        .btn-view {
            color: var(--primary);
            background: var(--primary-light);
        }
        
        .btn-edit {
            color: var(--warning);
            background: var(--warning-light);
        }
        
        .btn-delete {
            color: var(--danger);
            background: var(--danger-light);
        }
    </style>
</head>
<body>
    <jsp:include page="/includes/admin_sidebar.jsp" />
    <div class="container-fluid py-4">
        <!-- Page Heading -->
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Bảng điều khiển</h1>
        </div>

        <!-- Tab Navigation -->
        <ul class="nav nav-tabs" id="adminTabs" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active" id="overview-tab" data-bs-toggle="tab" 
                        data-bs-target="#overview" type="button" role="tab" aria-controls="overview" 
                        aria-selected="true">
                    <i class="fas fa-fw fa-tachometer-alt me-1"></i>Tổng quan
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="recruiter-tab" data-bs-toggle="tab" 
                        data-bs-target="#recruiter" type="button" role="tab" 
                        aria-controls="recruiter" aria-selected="false">
                    <i class="fas fa-fw fa-building me-1"></i>Nhà tuyển dụng
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="candidate-tab" data-bs-toggle="tab" 
                        data-bs-target="#candidate" type="button" role="tab" 
                        aria-controls="candidate" aria-selected="false">
                    <i class="fas fa-fw fa-users me-1"></i>Ứng viên
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="posts-tab" data-bs-toggle="tab" 
                        data-bs-target="#posts" type="button" role="tab" 
                        aria-controls="posts" aria-selected="false">
                    <i class="fas fa-fw fa-briefcase me-1"></i>Bài đăng
                </button>
            </li>
        </ul>

        <!-- Tab Content -->
        <div class="tab-content bg-white p-4" id="adminTabsContent">
            <!-- Overview Tab -->
            <div class="tab-pane fade show active" id="overview" role="tabpanel" aria-labelledby="overview-tab">
                <div class="row">
                    <!-- Total Posts Card -->
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card stat-card primary h-100">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                            Tổng bài đăng</div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">128</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-briefcase fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Recruiters Card -->
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card stat-card success h-100">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                            Nhà tuyển dụng</div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">45</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-building fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Candidates Card -->
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card stat-card info h-100">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                                            Ứng viên</div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">256</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-users fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Pending Requests Card -->
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card stat-card warning h-100">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                            Đang chờ duyệt</div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">12</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-comments fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Content Row -->
                <div class="row">
                    <div class="col-12">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                <h6 class="m-0 font-weight-bold text-primary">Tổng quan hoạt động</h6>
                            </div>
                            <div class="card-body">
                                <div class="text-center">
                                    <p>Biểu đồ thống kê sẽ được hiển thị tại đây</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Recruiter Tab -->
            <div class="tab-pane fade" id="recruiter" role="tabpanel" aria-labelledby="recruiter-tab">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h4>Quản lý nhà tuyển dụng</h4>
                    
                </div>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                        <thead class="table-light">
                            <tr>
                                <th>Name</th>                                
                                <th>Transaction Type</th>
                                <th>Transaction Date</th>
                                <th>Price</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${not empty sessionScope.listTransactionRecruiter}">
                                <c:forEach items="${sessionScope.listTransactionRecruiter}" var="transaction">
                                    <tr>
                                    <c:forEach items="${sessionScope.listRecruiter}" var="recruiter">
                                        <c:if test="${transaction.recruiterID == recruiter.recruiterID}">
                                            <td>${recruiter.firstName} ${recruiter.lastName}</td>
                                            
                                        </c:if>
                                    </c:forEach>
                                        <td>${transaction.type}</td>
                                        <td><fmt:formatDate value="${transaction.transactionDate}" pattern="dd/MM/yyyy HH:mm" /></td>
                                        <td class="text-end">
                                            <fmt:formatNumber value="${transaction.amount}" pattern="#,##0" /> đ
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                            <c:if test="${empty sessionScope.listTransactionRecruiter}">
                                <tr>
                                    <td colspan="6" class="text-center">Không có dữ liệu giao dịch</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Candidate Tab -->
            <div class="tab-pane fade" id="candidate" role="tabpanel" aria-labelledby="candidate-tab">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h4>Quản lý ứng viên</h4>
                    
                </div>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                        <thead class="table-light">
                            <tr>
                                <th>Name</th>                                
                                <th>Transaction Type</th>
                                <th>Transaction Date</th>
                                <th>Price</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${not empty sessionScope.listTransactionFreelancer}">
                                <c:forEach items="${sessionScope.listTransactionFreelancer}" var="transaction">
                                    <tr>
                                    <c:forEach items="${sessionScope.listJobseeker}" var="jobseeker">
                                        <c:if test="${transaction.recruiterID == jobseeker.freelancerID}">
                                            <td>${jobseeker.first_Name} ${jobseeker.last_Name}</td>
                                            
                                        </c:if>
                                    </c:forEach>
                                        <td>${transaction.type}</td>
                                        <td><fmt:formatDate value="${transaction.transactionDate}" pattern="dd/MM/yyyy HH:mm" /></td>
                                        <td class="text-end">
                                            <fmt:formatNumber value="${transaction.amount}" pattern="#,##0" /> đ
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                            <c:if test="${empty sessionScope.listTransactionFreelancer}">
                                <tr>
                                    <td colspan="6" class="text-center">Không có dữ liệu giao dịch</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Posts Tab -->
            <div class="tab-pane fade" id="posts" role="tabpanel" aria-labelledby="posts-tab">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h4>Quản lý bài đăng</h4>
                    
                </div>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                        <thead class="table-light">
                            <tr>
                                <th>Tiêu đề</th>
                                <th>Ngày đăng</th>
                                <th>Hạn nộp</th>
                                <th>Account Tier</th>
                                <th>PurchaseDate</th>
                                <th>ExpirationDate</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty sessionScope.listPost}">
                                    <c:forEach items="${listPost}" var="post">
                                        <tr>
                                            <td>${post.title}</td>
                                            <td><fmt:formatDate value="${post.datePost}" pattern="dd/MM/yyyy" /></td>
                                            <td><fmt:formatDate value="${post.expiredDate}" pattern="dd/MM/yyyy" /></td>
                                            <td>
                                                <c:set var="tierName" value="Null" />
                                                <c:forEach items="${sessionScope.listPostAccountTier}" var="tier">
                                                    <c:if test="${tier.postID == post.postId}">
                                                        <c:forEach items="${sessionScope.listAccountTier}" var="accounttier">
                                                            <c:if test="${accounttier.tierID == tier.tierID}">
                                                                <c:set var="tierName" value="${accounttier.tierName}" />
                                                            </c:if>
                                                        </c:forEach>
                                                    </c:if>
                                                </c:forEach>
                                                ${tierName}
                                            </td>
                                            <td>
                                                <c:set var="foundPurchase" value="false" />
                                                <c:forEach items="${sessionScope.listPostAccountTier}" var="tier">
                                                    <c:if test="${tier.postID == post.postId}">
                                                        <fmt:formatDate value="${tier.purchaseDate}" pattern="dd/MM/yyyy" />
                                                        <c:set var="foundPurchase" value="true" />
                                                    </c:if>
                                                </c:forEach>
                                                <c:if test="${not foundPurchase}">
                                                    Null
                                                </c:if>
                                            </td>
                                            
                                            <td>
                                                <c:set var="foundPurchase" value="false" />
                                                <c:forEach items="${sessionScope.listPostAccountTier}" var="tier">
                                                    <c:if test="${tier.postID == post.postId}">
                                                       <fmt:formatDate value="${tier.expirationDate}" pattern="dd/MM/yyyy " />
                                                       <c:set var="foundPurchase" value="true" />
                                                    </c:if>
                                                </c:forEach>
                                                <c:if test="${not foundPurchase}">
                                                    Null
                                                </c:if>
                                             
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="7" class="text-center">Không có bài đăng nào</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Initialize tooltips
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });

        // Tab persistence
        document.addEventListener('DOMContentLoaded', function() {
            // Get saved tab from localStorage
            var savedTab = localStorage.getItem('adminActiveTab');
            if (savedTab) {
                var tab = new bootstrap.Tab(document.querySelector(savedTab));
                tab.show();
            }

            // Save tab to localStorage when changed
            var tabEls = document.querySelectorAll('button[data-bs-toggle="tab"]');
            tabEls.forEach(function(tabEl) {
                tabEl.addEventListener('click', function (event) {
                    localStorage.setItem('adminActiveTab', event.target.getAttribute('data-bs-target'));
                });
            });
        });
    </script>
</body>
</html>