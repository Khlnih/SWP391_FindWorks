<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html class="no-js" lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Manage Jobseekers - Admin Panel</title>
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

        /* Jobseeker Table Styles */
        .jobseeker-table {
            background: var(--white);
            border-radius: 12px;
            padding: 24px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            border: 1px solid rgba(0, 0, 0, 0.05);
            transition: 0.3s ease;
        }

        .jobseeker-table:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            border-color: var(--primary-color);
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
            padding: 0.5rem 1.25rem;
            font-size: 0.95rem;
            border-radius: 8px;
        }
        
        .search-container .btn i {
            margin-right: 8px;
            font-size: 1rem;
        }
        
        .search-container .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        .search-container .btn-primary:hover {
            background-color: var(--primary-dark);
            border-color: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(33, 150, 243, 0.3);
        }
        
        .search-container .btn-outline-secondary {
            border: 1px solid #dee2e6;
            color: #6c757d;
        }
        
        .search-container .btn-outline-secondary:hover {
            background-color: #f8f9fa;
            border-color: #adb5bd;
            color: #495057;
            transform: translateY(-2px);
        }
        
        /* Responsive adjustments */
        @media (max-width: 768px) {
            .search-container .col-md-4,
            .search-container .col-md-3,
            .search-container .col-md-2 {
                margin-bottom: 15px;
            }
            
            .search-container .btn {
                width: 100%;
            }
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 0;
        }

        .table th,
        .table td {
            padding: 15px;
            vertical-align: middle;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        }

        .table th {
            background: var(--primary-light);
            color: var(--text-color);
            font-weight: 500;
            text-transform: uppercase;
            font-size: 0.875rem;
        }

        .table td {
            color: var(--text-color);
        }

        .user-avatar {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 15px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .status-badge {
            padding: 5px 12px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: 500;
            display: inline-block;
        }

        .status-badge.active {
            background-color: #28a745;
            color: var(--white);
        }

        .status-badge.inactive {
            background-color: #dc3545;
            color: var(--white);
        }

        .action-buttons {
            display: flex;
            gap: 10px;
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

        .btn-delete {
            background: #dc3545;
        }

        .btn-view:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
        }

        .btn-edit:hover {
            background: #e0a800;
            transform: translateY(-2px);
        }

        .btn-delete:hover {
            background: #c82333;
            transform: translateY(-2px);
        }

        .status-buttons {
            display: flex;
            gap: 8px;
            margin-top: 8px;
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
            right: 10px;
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
        
        .btn-delete i {
            width: 18px;
            text-align: center;
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 200px;
            }

            .main-content {
                margin-left: 0;
            }

            .toggle-btn {
                left: 10px;
            }

            .jobseeker-table {
                padding: 20px;
            }

            .search-box {
                margin-bottom: 20px;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/includes/admin_sidebar.jsp" />

    <div class="main-content">
        <div class="admin-header">
            <div class="d-flex justify-content-between align-items-center" style="margin-left: 20px;">
                <h2>Manage Jobseekers <span class="badge bg-secondary">${totalJobseekers} total</span></h2>
                <a href="admin.jsp" class="btn btn-primary">Back to Dashboard</a>
            </div>
        </div>

        <div class="jobseeker-table">
            <div class="search-container mb-4">
                <div class="row g-3 align-items-end">
                    <div class="col-md-4">
                        <label for="searchKeyword" class="form-label">Search Keyword</label>
                        <input type="text" id="searchKeyword" placeholder="Enter keyword..." class="form-control" value="${param.keyword}">
                    </div>
                    <div class="col-md-3">
                        <label for="searchBy" class="form-label">Search By</label>
                        <select id="searchBy" class="form-select">
                            <option value="all" ${param.searchBy == 'all' || empty param.searchBy ? 'selected' : ''}>All Fields</option>
                            <option value="name" ${param.searchBy == 'name' ? 'selected' : ''}>Name</option>
                            <option value="email" ${param.searchBy == 'email' ? 'selected' : ''}>Email</option>
                            <option value="phone" ${param.searchBy == 'phone' ? 'selected' : ''}>Phone</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <button type="button" class="btn btn-primary w-100" onclick="searchJobseekers()">
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
                <div class="alert alert-danger">
                    ${error}
                </div>
            </c:if>
            
            <c:if test="${empty jobseekers}">
                <div class="alert alert-info">
                    No jobseekers found
                </div>
            </c:if>
            
            <c:if test="${not empty jobseekers}">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Avatar</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Gender</th>
                            <th>DOB</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="jobseeker" items="${jobseekers}">
                            <tr>
                                <td>
                                    <img src="${jobseeker.image}" alt="Avatar" class="user-avatar">
                                </td>
                                <td>${jobseeker.first_Name} ${jobseeker.last_Name}</td>
                                <td>${jobseeker.email_contact}</td>
                                <td>${jobseeker.phone_contact}</td>
                                <td>
                                    <span class="badge ${jobseeker.gender ? 'badge-info' : 'badge-warning'}">
                                        ${jobseeker.gender ? 'Male' : 'Female'}
                                    </span>
                                </td>
                                <td>${jobseeker.dob}</td>
                                <td>
                                    <span class="badge ${jobseeker.status == 'active' ? 'badge-success' : jobseeker.status == 'pending' ? 'badge-warning' : 'badge-danger'}">
                                        ${jobseeker.status}
                                    </span>
                                </td>
                                <td>
                                    <div class="action-buttons" style="position: relative;">
                                        <!-- Three-dot menu button -->
                                        <button class="action-menu-btn" onclick="toggleStatusMenu(this, event)" aria-label="More actions">
                                            <i class="fa fa-ellipsis-v"></i>
                                        </button>
                                        
                                        <!-- Status buttons dropdown -->
                                        <div class="status-buttons">
                                            <a href="AdminController?action=viewJobseeker&id=${jobseeker.freelancerID}" class="btn-status">
                                                <i class="fa fa-eye"></i> View Details
                                            </a>
                                            <div class="dropdown-divider"></div>
                                            <button class="btn-status ${jobseeker.status == 'active' ? 'active' : ''}" 
                                                    onclick="changeStatus('${jobseeker.freelancerID}', 'active')">
                                                <i class="fa fa-check-circle"></i> Active
                                            </button>
                                            <button class="btn-status ${jobseeker.status == 'suspended' ? 'suspended' : ''}" 
                                                    onclick="changeStatus('${jobseeker.freelancerID}', 'suspended')">
                                                <i class="fa fa-pause-circle"></i> Suspend
                                            </button>
                                            <button class="btn-status ${jobseeker.status == 'pending' ? 'pending' : ''}" 
                                                    onclick="changeStatus('${jobseeker.freelancerID}', 'pending')">
                                                <i class="fa fa-clock-o"></i> Pending
                                            </button>
                                            <div class="dropdown-divider"></div>
                                            <button class="btn-delete" onclick="confirmDelete('${jobseeker.freelancerID}')">
                                                <i class="fa fa-trash"></i> Delete
                                            </button>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                
                <!-- Phân trang -->
                <div class="pagination-container mt-4">
                    <div class="row mb-3">
                        <div class="col-md-4">
                            <div class="input-group">
                                <span class="input-group-text">Items per page:</span>
                                <input type="number" id="itemsPerPage" class="form-control" min="1" max="${totalJobseekers}" 
                                       value="${param.pageSize != null ? param.pageSize : '5'}" 
                                       onchange="updateItemsPerPage(this.value)" 
                                       title="Enter a value between 1 and ${totalJobseekers}"
                                       style="max-width: 80px;">
                                <div class="invalid-feedback" id="pageSizeFeedback">
                                    Please enter a value between 1 and ${totalJobseekers}
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
            </c:if>
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
        // Confirm before deleting a jobseeker
        function confirmDelete(id) {
            if (confirm('Are you sure you want to delete this jobseeker? This action cannot be undone.')) {
                window.location.href = 'AdminController?action=deleteJobseeker&id=' + id;
            }
        }

        // Search function
        function searchJobseekers() {
            const keyword = document.getElementById('searchKeyword').value.trim();
            const searchBy = document.getElementById('searchBy').value;
            
            // Lấy các tham số hiện tại từ URL
            const urlParams = new URLSearchParams(window.location.search);
            
            // Cập nhật các tham số tìm kiếm
            if (keyword) {
                urlParams.set('keyword', keyword);
                urlParams.set('searchBy', searchBy);
            } else {
                urlParams.delete('keyword');
                urlParams.delete('searchBy');
            }
            
            // Reset về trang đầu tiên khi tìm kiếm
            urlParams.set('page', '1');
            
            // Chuyển hướng với các tham số mới
            window.location.href = window.location.pathname + '?' + urlParams.toString();
        }
        
        // Reset search function
        function resetSearch() {
            // Xóa các tham số tìm kiếm
            const urlParams = new URLSearchParams(window.location.search);
            urlParams.delete('keyword');
            urlParams.delete('searchBy');
            urlParams.set('page', '1');
            
            // Reset form
            document.getElementById('searchKeyword').value = '';
            document.getElementById('searchBy').value = 'all';
            
            // Chuyển hướng
            window.location.href = window.location.pathname + '?' + urlParams.toString();
        }
        
        // Xử lý sự kiện nhấn Enter trong ô tìm kiếm
        document.getElementById('searchKeyword').addEventListener('keyup', function(event) {
            if (event.key === 'Enter') {
                searchJobseekers();
            }
        });

        // Toggle sidebar
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            const content = document.querySelector('.main-content');
            sidebar.classList.toggle('active');
            content.classList.toggle('active');
        }

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
            
            // Close sidebar when clicking outside
            const sidebar = document.getElementById('sidebar');
            const toggleBtn = document.querySelector('.toggle-btn');
            
            if (sidebar && toggleBtn && !sidebar.contains(event.target) && !toggleBtn.contains(event.target)) {
                sidebar.classList.remove('active');
                document.querySelector('.main-content').classList.remove('active');
            }
        });

        // Change jobseeker status
        let currentJobseekerId = null;
        let currentNewStatus = null;
        
        function changeStatus(jobseekerId, newStatus) {
            currentJobseekerId = jobseekerId;
            currentNewStatus = newStatus;
            
            // Update modal message
            document.getElementById('statusChangeMessage').textContent = 
                'Are you sure you want to change the status to ' + newStatus + '?';
                
            // Show the modal
            document.getElementById('statusChangeModal').style.display = 'block';
        }
        
        // Handle confirm button click
        document.getElementById('confirmStatusChange').addEventListener('click', function() {
            if (currentJobseekerId && currentNewStatus) {
                window.location.href = 'AdminController?action=changeStatus&id=' + currentJobseekerId + '&status=' + currentNewStatus;
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

        // Close all dropdowns when pressing Escape key
        document.addEventListener('keydown', function(event) {
            if (event.key === 'Escape') {
                document.querySelectorAll('.status-buttons').forEach(menu => {
                    menu.classList.remove('show');
                });
            }
        });
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
