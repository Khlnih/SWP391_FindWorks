<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="DAO.RecruiterDAO"%>
<%@page import="Model.Recruiter"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<% 
    RecruiterDAO recruiterDAO = new RecruiterDAO();
    
    // Lấy tham số tìm kiếm
    String keyword = request.getParameter("keyword");
    String searchBy = request.getParameter("searchBy");
    if (searchBy == null || searchBy.isEmpty()) {
        searchBy = "all";
    }
    
    // Phân trang
    int defaultPageSize = 5; // Mặc định 5 bản ghi mỗi trang
    int pageSize = defaultPageSize;
    
    // Lấy tham số pageSize từ request nếu có
    String pageSizeParam = request.getParameter("pageSize");
    if (pageSizeParam != null && !pageSizeParam.isEmpty()) {
        try {
            int customPageSize = Integer.parseInt(pageSizeParam);
            if (customPageSize > 0) {
                pageSize = customPageSize;
            }
        } catch (NumberFormatException e) {
            // Giữ nguyên giá trị mặc định nếu có lỗi
        }
    }
    
    // Lấy tham số trang hiện tại
    int currentPage = 1;
    String pageParam = request.getParameter("page");
    if (pageParam != null && !pageParam.isEmpty()) {
        try {
            currentPage = Integer.parseInt(pageParam);
        } catch (NumberFormatException e) {
            currentPage = 1;
        }
    }
    
    // Lấy tổng số bản ghi
    int totalRecruiters;
    if (keyword != null && !keyword.trim().isEmpty()) {
        totalRecruiters = recruiterDAO.countSearchResults(keyword, searchBy);
    } else {
        totalRecruiters = recruiterDAO.countTotalRecruiters();
    }
    int totalPages = (int) Math.ceil((double) totalRecruiters / pageSize);
    
    // Đảm bảo currentPage không vượt quá totalPages
    if (currentPage > totalPages) {
        currentPage = totalPages;
    }
    if (currentPage < 1) {
        currentPage = 1;
    }
    
    // Lấy dữ liệu phân trang
    List<Recruiter> recruiters;
    if (keyword != null && !keyword.trim().isEmpty()) {
        recruiters = recruiterDAO.searchRecruiters(keyword, searchBy, currentPage, pageSize);
    } else {
        recruiters = recruiterDAO.getRecruitersByPage(currentPage, pageSize);
    }
    request.setAttribute("recruiters", recruiters);
    request.setAttribute("currentPage", currentPage);
    request.setAttribute("totalPages", totalPages);
    request.setAttribute("totalRecruiters", totalRecruiters);
%>
<!DOCTYPE html>
<html class="no-js" lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Manage Recruiters - Admin Panel</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSS here -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/themify-icons.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/responsive.css">
    <style>
        /* Pagination Styles */
        .pagination .page-item.active .page-link {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        .pagination .page-link {
            color: var(--primary-color);
        }
        
        .pagination .page-link:hover {
            background-color: var(--primary-light);
            color: var(--primary-color);
        }
        
        .pagination .page-item.disabled .page-link {
            color: #6c757d;
            pointer-events: none;
            background-color: #fff;
            border-color: #dee2e6;
        }
        
        .pagination-container {
            margin-top: 20px;
        }
        
        .page-size-control {
            max-width: 150px;
        }
        
        .page-info {
            line-height: 38px;
            margin-left: 15px;
        }
        /* End Pagination Styles */
        
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
            padding: 20px 50px;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
            position: relative;
            z-index: 1002;
        }

        .sidebar-header h3 {
            margin: 0;
            color: var(--text-color);
            font-size: 1.5rem;
            position: relative;
            z-index: 1002;
        }

        .sidebar-content {
            padding: 20px;
        }

        .menu-item {
            display: flex;
            align-items: center;
            padding: 10px 15px;
            margin: 5px 0;
            color: var(--text-color);
            text-decoration: none;
            border-radius: 5px;
            transition: 0.3s ease;
        }

        .menu-item i {
            margin-right: 10px;
            font-size: 1.2rem;
        }

        .menu-item:hover {
            background: var(--primary-light);
            color: var(--primary-color);
        }

        .menu-item.active {
            background: var(--primary-color);
            color: var(--white);
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

        /* Toggle Button */
        .toggle-btn {
            position: fixed;
            top: 20px;
            left: 10px;
            background: var(--primary-color);
            color: var(--white);
            border: none;
            padding: 10px;
            border-radius: 50%;
            cursor: pointer;
            z-index: 1001;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .toggle-btn i {
            font-size: 1rem;
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

        /* Recruiter Table Styles */
        .recruiter-table {
            background: var(--white);
            border-radius: 12px;
            padding: 24px;
        }
        
        /* Search Container Styles */
        .search-container {
            background: var(--white);
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            margin-bottom: 30px;
            border: 1px solid rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
        }
        
        .search-container:hover {
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            border-color: rgba(33, 150, 243, 0.2);
        }
        
        .search-container .form-label {
            font-weight: 500;
            color: var(--text-color);
            margin-bottom: 8px;
            display: block;
            font-size: 0.9rem;
        }
        
        .search-container .form-control,
        .search-container .form-select {
            height: 45px;
            border-radius: 8px;
            border: 1px solid #e0e0e0;
            transition: all 0.3s ease;
            font-size: 0.95rem;
            padding: 0.5rem 1rem;
        }
        
        .search-container .form-control:focus,
        .search-container .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(33, 150, 243, 0.25);
        }
        
        .search-container .btn {
            height: 45px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .search-container .btn i {
            margin-right: 8px;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .table th,
        .table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
        }

        .table th {
            background: var(--primary-light);
            color: var(--text-color);
            font-weight: 500;
            text-transform: uppercase;
        }

        .table td {
            color: var(--text-color);
        }

        .table tr:hover {
            background-color: var(--primary-light);
        }

        /* Button Styles */
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: 0.3s ease;
        }

        .action-buttons {
            position: relative;
            display: flex;
            gap: 10px;
        }

        /* Three dot menu button */
        .action-menu-btn {
            background: none;
            border: none;
            cursor: pointer;
            padding: 5px 10px;
            border-radius: 4px;
            color: #6c757d;
            transition: all 0.3s ease;
        }

        .action-menu-btn:hover {
            background-color: #f0f0f0;
            color: #495057;
        }

        .action-menu-btn i {
            font-size: 16px;
        }

        /* Status buttons container */
        .status-buttons {
            position: absolute;
            right: 0;
            top: 100%;
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
            padding: 8px 0;
            z-index: 1000;
            min-width: 180px;
            display: none;
            flex-direction: column;
            gap: 2px;
            border: 1px solid #e9ecef;
            animation: fadeIn 0.2s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-5px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .status-buttons.show {
            display: flex;
        }
        
        .dropdown-divider {
            height: 1px;
            background-color: #e9ecef;
            margin: 6px 0;
        }

        .btn-status {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 13px;
            display: flex;
            align-items: center;
            gap: 10px;
            transition: all 0.2s ease;
            background: none;
            text-align: left;
            width: 100%;
            color: #495057;
            margin: 0 4px;
        }

        .btn-status:hover {
            background-color: #f8f9fa;
            transform: translateX(2px);
        }

        .btn-status i {
            font-size: 14px;
            width: 18px;
            text-align: center;
        }

        .btn-status.active, 
        .btn-status.active i {
            color: #28a745;
            font-weight: 500;
        }

        .btn-status.suspended,
        .btn-status.suspended i {
            color: #dc3545;
        }

        .btn-status.pending,
        .btn-status.pending i {
            color: #ffc107;
        }
        
        .btn-delete {
            color: #dc3545;
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            background: none;
            cursor: pointer;
            font-size: 13px;
            display: flex;
            align-items: center;
            gap: 10px;
            width: 100%;
            text-align: left;
            transition: all 0.2s ease;
            margin: 0 4px;
        }
        
        .btn-delete:hover {
            background-color: #fff5f5;
            color: #c82333;
            transform: translateX(2px);
        }
        
        .recruiter-name-link {
            color: #3498db;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.2s ease, transform 0.2s ease;
            display: inline-block;
            padding: 2px 5px;
            border-radius: 4px;
        }
        
        .recruiter-name-link:hover {
            color: #1a73e8;
            text-decoration: underline;
            transform: translateY(-1px);
            background-color: rgba(52, 152, 219, 0.1);
        }
        
        .btn-delete i {
            width: 18px;
            text-align: center;
        }

        .action-btn {
            padding: 8px 15px;
            border-radius: 8px;
            text-decoration: none;
            color: var(--white);
            display: flex;
            align-items: center;
            gap: 5px;
            transition: 0.3s ease;
            font-size: 14px;
        }

        .action-btn i {
            font-size: 14px;
        }

        .btn-view {
            background: var(--primary-color);
        }

        .btn-edit {
            background: #ffc107;
            color: #000;
        }

        .badge {
            padding: 5px 12px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: 500;
            display: inline-block;
        }

        .user-avatar {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 15px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .badge-info {
            background-color: #17a2b8;
            color: var(--white);
        }

        .badge-warning {
            background-color: #ffc107;
            color: #000;
        }

        .badge-success {
            background-color: #28a745;
            color: var(--white);
        }

        .badge-danger {
            background-color: #dc3545;
            color: var(--white);
        }

        .btn-primary {
            background: var(--primary-color);
            color: var(--white);
        }

        .btn-primary:hover {
            background: var(--primary-dark);
        }

        .btn-danger {
            background: #dc3545;
            color: var(--white);
        }

        .btn-danger:hover {
            background: #c82333;
        }

        .btn-sm {
            padding: 6px 12px;
            font-size: 0.875rem;
        }

        /* Search Box */
        .search-box {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }

        .search-box input {
            flex: 1;
            padding: 10px;
            border: 1px solid rgba(0, 0, 0, 0.1);
            border-radius: 4px;
            font-size: 1rem;
        }

        .search-box button {
            padding: 10px 20px;
        }

        /* Alert Styles */
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
            text-align: center;
        }

        .alert-danger {
            background: #f8d7da;
            color: #842029;
            border: 1px solid #f5c2c7;
        }

        .alert-info {
            background: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }

        /* Responsive Styles */
        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: static;
                left: 0;
                box-shadow: none;
            }

            .sidebar.active {
                height: auto;
            }

            .main-content {
                margin-left: 0;
            }

            .search-box {
                flex-direction: column;
            }

            .search-box input,
            .search-box button {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/includes/admin_sidebar.jsp" />

    

    <div class="main-content">
        <div class="admin-header">
            <div class="d-flex justify-content-between align-items-center" style="margin-left: 20px;">
                <h2>Manage Recruiters <span class="badge bg-secondary">${totalRecruiters} total</span></h2>
                <a href="admin.jsp" class="btn btn-primary">Back to Dashboard</a>
            </div>
        </div>

        <div class="recruiter-table">
            <div class="search-container mb-4">
                <div class="row g-3 align-items-end">
                    <div class="col-md-4">
                        <label for="searchKeyword" class="form-label">Search Keyword</label>
                        <input type="text" class="form-control" id="searchKeyword" name="keyword" placeholder="Enter keyword..." value="<%= keyword != null ? keyword : "" %>">
                    </div>
                    <div class="col-md-3">
                        <label for="searchBy" class="form-label">Search By</label>
                        <select class="form-select" id="searchBy" name="searchBy">
                            <option value="all" <%= "all".equals(searchBy) ? "selected" : "" %>>All Fields</option>
                            <option value="name" <%= "name".equals(searchBy) ? "selected" : "" %>>Name</option>
                            <option value="email" <%= "email".equals(searchBy) ? "selected" : "" %>>Email</option>
                            <option value="phone" <%= "phone".equals(searchBy) ? "selected" : "" %>>Phone</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <button type="button" class="btn btn-primary w-100" onclick="performSearch()">
                            <i class="fa fa-search me-2"></i>Search
                        </button>
                    </div>
                    <div class="col-md-2">
                        <button type="button" class="btn btn-outline-secondary w-100" onclick="resetSearch()">
                            <i class="fa fa-refresh me-2"></i>Reset
                        </button>
                    </div>
                </div>
            </div>
            
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            
            <c:if test="${empty recruiters}">
                <div class="alert alert-info">
                    No recruiters found
                </div>
            </c:if>
            
            <c:if test="${not empty recruiters}">
            <table class="table">
                <thead>
                    <tr>
                        <th>Avatar</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Gender</th>
                        <th>Date of Birth</th>
                        <th>Status</th>
                        <th>Money</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="recruiter" items="${recruiters}">
                    <tr>
                        <td>
                            <img src="${recruiter.image}" alt="Recruiter Image" class="user-avatar">
                        </td>
                        <td>${recruiter.firstName} ${recruiter.lastName}</a></td>
                        <td>${recruiter.emailContact}</td>
                        <td>${recruiter.phoneContact}</td>
                        <td>
                            <span class="badge ${recruiter.gender ? 'badge-info' : 'badge-warning'}">
                                ${recruiter.gender ? 'Male' : 'Female'}
                            </span>
                        </td>
                        <td>${recruiter.dob}</td>
                        <td data-recruiter-id="${recruiter.recruiterID}">
                            <span class="badge ${recruiter.status == 'active' ? 'badge-success' : recruiter.status == 'suspended' ? 'badge-danger' : 'badge-warning'}">
                                ${recruiter.status}
                            </span>
                        </td>
                        <td>${recruiter.money}</td>
                        <td>
                            <div class="action-buttons">
                                <!-- Three-dot menu button -->
                                <button class="action-menu-btn" onclick="toggleStatusMenu(this, event)" aria-label="More actions">
                                        <i class="fas fa-ellipsis-v"></i>
                                </button>
                                
                                <!-- Status buttons dropdown -->
                                <div class="status-buttons">
                                    <a href="AdminController?action=viewRecruiter&id=${recruiter.recruiterID}" class="btn-status">
                                        <i class="fa fa-eye"></i> View Details
                                    </a>
                                    <a href="AdminController?action=editRecruiter&id=${recruiter.recruiterID}" class="btn-status">
                                        <i class="fa fa-pencil"></i> Edit Profile
                                    </a>
                                    <div class="dropdown-divider"></div>
                                    <button class="btn-status ${recruiter.status == 'active' ? 'active' : ''}" 
                                            onclick="changeStatus('${recruiter.recruiterID}', 'active')">
                                        <i class="fa fa-check-circle"></i> Set as Active
                                    </button>
                                    <button class="btn-status ${recruiter.status == 'suspended' ? 'suspended' : ''}" 
                                            onclick="changeStatus('${recruiter.recruiterID}', 'suspended')">
                                        <i class="fa fa-pause-circle"></i> Suspend Account
                                    </button>
                                    <button class="btn-status ${recruiter.status == 'pending' ? 'pending' : ''}" 
                                            onclick="changeStatus('${recruiter.recruiterID}', 'pending')">
                                        <i class="fa fa-clock-o"></i> Set as Pending
                                    </button>
                                    <div class="dropdown-divider"></div>
                                    <button class="btn-delete" onclick="if(confirm('Are you sure you want to delete this recruiter?')) { window.location.href='AdminController?action=deleteRecruiter&id=${recruiter.recruiterID}'; }">
                                        <i class="fa fa-trash"></i> Delete Recruiter
                                    </button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>
            </c:if>
            <!-- Phân trang -->
            <div class="pagination-container mt-4">
                <div class="row mb-3">
                    <div class="col-md-4">
                        <div class="input-group">
                            <span class="input-group-text">Items per page:</span>
                            <input type="number" id="itemsPerPage" class="form-control" min="1" max="${totalRecruiters}" 
                                   value="${param.pageSize != null ? param.pageSize : '5'}" 
                                   onchange="updateItemsPerPage(this.value)" 
                                   title="Enter a value between 1 and ${totalRecruiters}"
                                   style="max-width: 80px;">
                            <div class="invalid-feedback" id="pageSizeFeedback">
                                Please enter a value between 1 and ${totalRecruiters}
                            </div>
                        </div>
                    </div>
                    <div class="col-md-8">
                        <!-- Pagination info removed as requested -->
                    </div>
                </div>
                <nav aria-label="Page navigation">
                    <ul class="pagination justify-content-center">
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" href="?page=1&pageSize=${param.pageSize != null ? param.pageSize : '5'}" aria-label="First">
                                <span aria-hidden="true">&laquo;&laquo;</span>
                            </a>
                        </li>
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" href="?page=${currentPage - 1}&pageSize=${param.pageSize != null ? param.pageSize : '5'}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                        
                        <!-- Hiển thị các trang gần đó -->
                        <c:set var="startPage" value="${currentPage - 2}" />
                        <c:set var="endPage" value="${currentPage + 2}" />
                        
                        <c:if test="${startPage < 1}">
                            <c:set var="endPage" value="${endPage + (1 - startPage)}" />
                            <c:set var="startPage" value="1" />
                        </c:if>
                        
                        <c:if test="${endPage > totalPages}">
                            <c:set var="startPage" value="${startPage - (endPage - totalPages) > 0 ? startPage - (endPage - totalPages) : 1}" />
                            <c:set var="endPage" value="${totalPages}" />
                        </c:if>
                        
                        <c:forEach begin="${startPage > 0 ? startPage : 1}" end="${endPage <= totalPages ? endPage : totalPages}" var="i">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="?page=${i}&pageSize=${param.pageSize != null ? param.pageSize : '5'}">${i}</a>
                            </li>
                        </c:forEach>
                        
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="?page=${currentPage + 1}&pageSize=${param.pageSize != null ? param.pageSize : '5'}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="?page=${totalPages}&pageSize=${param.pageSize != null ? param.pageSize : '5'}" aria-label="Last">
                                <span aria-hidden="true">&raquo;&raquo;</span>
                            </a>
                        </li>
                    </ul>
                </nav>
                <div class="text-center text-muted mt-2">
                    Page ${currentPage} of ${totalPages}
                </div>
            </div>
        </div>
    </div>
    
    <!-- Status Change Confirmation Modal -->
    <div id="statusChangeModal" class="modal" style="display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0,0,0,0.5);">
        <div class="modal-content" style="background-color: #fefefe; margin: 15% auto; padding: 20px; border: 1px solid #888; width: 50%; border-radius: 5px; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">
            <h3>Confirm Status Change</h3>
            <p id="statusChangeMessage" style="margin: 20px 0;"></p>
            <div style="text-align: right;">
                <button id="confirmStatusChange" class="btn btn-primary" style="margin-right: 10px;">Confirm</button>
                <button id="cancelStatusChange" class="btn btn-secondary">Cancel</button>
            </div>
        </div>
    </div>

    <script>
        // Toggle sidebar
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            const content = document.querySelector('.main-content');
            const toggleBtn = document.querySelector('.toggle-btn');
            
            sidebar.classList.toggle('active');
            content.classList.toggle('active');
            toggleBtn.classList.toggle('active');
        }

        // Search function
        function performSearch() {
            const keyword = document.getElementById('searchKeyword').value.trim();
            const searchBy = document.getElementById('searchBy').value;
            
            // Get current URL and parameters
            const url = new URL(window.location.href);
            const params = new URLSearchParams(url.search);
            
            // Update or add search parameters
            if (keyword) {
                params.set('keyword', keyword);
                params.set('searchBy', searchBy);
            } else {
                params.delete('keyword');
                params.delete('searchBy');
            }
            
            // Reset to first page when searching
            params.set('page', '1');
            
            // Update URL and reload
            window.location.href = url.pathname + '?' + params.toString();
        }
        
        // Reset search function
        function resetSearch() {
            window.location.href = 'admin_recruiter.jsp';
        }
        
        // Handle Enter key in search input
        document.getElementById('searchKeyword').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                performSearch();
            }
        });

        // Toggle status menu
        function toggleStatusMenu(button, event) {
            event.stopPropagation(); // Prevent event from bubbling up to document
            
            // Close all other open menus
            document.querySelectorAll('.status-buttons').forEach(menu => {
                if (menu !== button.nextElementSibling) {
                    menu.classList.remove('show');
                }
            });
            
            // Toggle current menu
            const menu = button.nextElementSibling;
            if (menu && menu.classList.contains('status-buttons')) {
                menu.classList.toggle('show');
            }
        }

        // Close menu when clicking outside
        document.addEventListener('click', function(event) {
            // Close status menus when clicking outside
            if (!event.target.closest('.action-buttons')) {
                document.querySelectorAll('.status-buttons').forEach(menu => {
                    menu.classList.remove('show');
                });
            }
        });

        // Change recruiter status
        let currentRecruiterId = null;
        let currentNewStatus = null;
        
        function changeStatus(recruiterId, newStatus) {
            currentRecruiterId = recruiterId;
            currentNewStatus = newStatus;
            
            // Update modal message
            document.getElementById('statusChangeMessage').textContent = 
                'Are you sure you want to change the status to ' + newStatus + '?';
                
            // Show the modal
            document.getElementById('statusChangeModal').style.display = 'block';
        }
        
        // Handle confirm button click
        document.getElementById('confirmStatusChange').addEventListener('click', function() {
            if (currentRecruiterId && currentNewStatus) {
                window.location.href = 'AdminController?action=changeRecruiterStatus&id=' + currentRecruiterId + '&status=' + currentNewStatus;
            }
        });
        
        // Handle cancel button click
        document.getElementById('cancelStatusChange').addEventListener('click', function() {
            document.getElementById('statusChangeModal').style.display = 'none';
        });
        
        // Close modal when clicking outside the modal content
        window.addEventListener('click', function(event) {
            const modal = document.getElementById('statusChangeModal');
            if (event.target === modal) {
                modal.style.display = 'none';
            }
        });

        // Confirm before deleting a recruiter
        function confirmDelete(recruiterId) {
            if (confirm('Are you sure you want to delete this recruiter? This action cannot be undone.')) {
                window.location.href = `AdminController?action=deleteRecruiter&id=${recruiterId}`;
            }
        }

        // Close all dropdowns when pressing Escape key
        document.addEventListener('keydown', function(event) {
            if (event.key === 'Escape') {
                document.querySelectorAll('.status-buttons').forEach(menu => {
                    menu.classList.remove('show');
                });
            }
        });

        // Initialize event listeners
        document.getElementById('searchInput')?.addEventListener('keyup', searchRecruiters);
        
        // Show alert message
        function showAlert(message, type = 'info') {
            // Remove any existing alerts
            const existingAlert = document.querySelector('.alert-message');
            if (existingAlert) {
                existingAlert.remove();
            }
            
            // Create alert element
            const alert = document.createElement('div');
            alert.className = `alert-message alert alert-${type} alert-dismissible fade show`;
            alert.role = 'alert';
            alert.style.position = 'fixed';
            alert.style.top = '20px';
            alert.style.right = '20px';
            alert.style.zIndex = '9999';
            alert.style.minWidth = '300px';
            alert.style.boxShadow = '0 4px 12px rgba(0,0,0,0.15)';
            alert.style.border = 'none';
            alert.style.borderRadius = '8px';
            alert.style.animation = 'slideIn 0.3s ease-out';
            
            // Add message and close button
            alert.innerHTML = `
                ${message}
                <button type="button" class="close" data-dismiss="alert" aria-label="Close" style="position: absolute; top: 8px; right: 12px; background: none; border: none; font-size: 1.5rem; cursor: pointer;">
                    <span aria-hidden="true">&times;</span>
                </button>
            `;
            
            // Add to body
            document.body.appendChild(alert);
            
            // Auto-remove after 5 seconds
            setTimeout(() => {
                alert.style.animation = 'fadeOut 0.3s ease-out';
                setTimeout(() => alert.remove(), 300);
            }, 5000);
            
            // Close button functionality
            const closeBtn = alert.querySelector('.close');
            if (closeBtn) {
                closeBtn.addEventListener('click', () => {
                    alert.style.animation = 'fadeOut 0.3s ease-out';
                    setTimeout(() => alert.remove(), 300);
                });
            }
        }
        
        // Add keyframes for animations
        const style = document.createElement('style');
        style.textContent = `
            @keyframes slideIn {
                from { transform: translateX(100%); opacity: 0; }
                to { transform: translateX(0); opacity: 1; }
            }
            @keyframes fadeOut {
                from { opacity: 1; }
                to { opacity: 0; }
            }
        `;
        document.head.appendChild(style);
    </script>
    
    <script>
        // Hàm để cập nhật URL với các tham số mới
        function updateUrlParams(params) {
            const urlParams = new URLSearchParams(window.location.search);
            
            // Cập nhật các tham số mới
            Object.keys(params).forEach(key => {
                if (params[key] !== null && params[key] !== undefined) {
                    urlParams.set(key, params[key]);
                } else {
                    urlParams.delete(key);
                }
            });
            
            // Tạo URL mới và chuyển hướng
            const newUrl = window.location.pathname + '?' + urlParams.toString();
            window.location.href = newUrl;
        }
        
        // Cập nhật số lượng item mỗi trang
        function updateItemsPerPage(pageSize) {
            const input = document.getElementById('itemsPerPage');
            const maxItems = parseInt(input.max) || 1;
            const currentValue = parseInt(input.value) || 1;
            
            // Kiểm tra giá trị hợp lệ
            if (isNaN(pageSize) || pageSize < 1) {
                input.value = 1;
                pageSize = 1;
                input.classList.add('is-invalid');
                return;
            }
            
            // Kiểm tra vượt quá số lượng tối đa
            if (pageSize > maxItems) {
                // Hiển thị hộp thoại xác nhận
                if (confirm(`Bạn đang yêu cầu hiển thị ${pageSize} bản ghi, nhưng chỉ có ${maxItems} bản ghi hiện có.\n\nBạn có muốn hiển thị tất cả ${maxItems} bản ghi?`)) {
                    // Nếu đồng ý, đặt về giá trị tối đa
                    input.value = maxItems;
                    pageSize = maxItems;
                    input.classList.remove('is-invalid');
                    
                    // Cập nhật URL với giá trị mới
                    updateUrlParams({
                        pageSize: pageSize,
                        page: 1
                    });
                } else {
                    // Nếu không đồng ý, giữ nguyên giá trị cũ
                    input.value = currentValue;
                }
                return;
            }
            
            // Nếu giá trị hợp lệ, xóa cảnh báo nếu có
            input.classList.remove('is-invalid');
            
            // Cập nhật pageSize và reset về trang 1
            updateUrlParams({
                pageSize: pageSize,
                page: 1
            });
        }
        
        // Hàm chuyển trang
        function goToPage(page) {
            updateUrlParams({
                page: page,
                // Giữ nguyên pageSize
                pageSize: document.getElementById('itemsPerPage').value || 5
            });
        }
        
        // Thêm sự kiện cho input
        document.getElementById('itemsPerPage').addEventListener('keyup', function(event) {
            if (event.key === 'Enter') {
                updateItemsPerPage(this.value);
            }
        });
        
        // Thêm sự kiện blur để validate khi rời khỏi input
        document.getElementById('itemsPerPage').addEventListener('blur', function() {
            const value = parseInt(this.value);
            const max = parseInt(this.max) || 1;
            
            if (isNaN(value) || value < 1) {
                this.value = 1;
                this.classList.add('is-invalid');
            } else if (value > max) {
                // Không tự động đổi giá trị nữa, để người dùng quyết định
                this.classList.add('is-invalid');
                // Nhưng vẫn giữ nguyên giá trị đã nhập
            } else {
                this.classList.remove('is-invalid');
            }
        });
        
        // Cập nhật tất cả các link phân trang để giữ nguyên pageSize
        document.addEventListener('DOMContentLoaded', function() {
            const pageLinks = document.querySelectorAll('.page-link');
            const currentPageSize = document.getElementById('itemsPerPage').value || 5;
            
            pageLinks.forEach(link => {
                if (link.getAttribute('href') && link.getAttribute('href').startsWith('?')) {
                    const url = new URL(link.href, window.location.origin);
                    url.searchParams.set('pageSize', currentPageSize);
                    link.href = url.pathname + url.search;
                }
            });
            
            // Thêm sự kiện click cho các nút phân trang
            document.querySelectorAll('.page-link').forEach(link => {
                link.addEventListener('click', function(e) {
                    if (this.getAttribute('aria-label') === 'First') {
                        e.preventDefault();
                        goToPage(1);
                    } else if (this.getAttribute('aria-label') === 'Previous') {
                        e.preventDefault();
                        goToPage(parseInt('${currentPage > 1 ? currentPage - 1 : 1}'));
                    } else if (this.getAttribute('aria-label') === 'Next') {
                        e.preventDefault();
                        goToPage(parseInt('${currentPage < totalPages ? currentPage + 1 : totalPages}'));
                    } else if (this.getAttribute('aria-label') === 'Last') {
                        e.preventDefault();
                        goToPage(parseInt('${totalPages}'));
                    } else if (this.closest('.page-item') && 
                              !this.closest('.page-item').classList.contains('disabled') &&
                              !this.getAttribute('aria-label')) {
                        // Xử lý click vào số trang
                        e.preventDefault();
                        const page = this.textContent.trim();
                        goToPage(parseInt(page));
                    }
                });
            });
        });
    </script>
</body>
</html>
