<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html class="no-js" lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Manage Categories - Admin Panel</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Lấy CSS từ file jobseeker, bạn có thể tách ra file CSS chung nếu muốn -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/themify-icons.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/responsive.css">
    
    <!-- Dán trực tiếp CSS từ file JSP gốc để đảm bảo hoạt động -->
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

        .data-table-container {
            background: var(--white);
            border-radius: 12px;
            padding: 24px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            border: 1px solid rgba(0, 0, 0, 0.05);
            transition: 0.3s ease;
        }

        .data-table-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            border-color: var(--primary-color);
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
        
        .table th:first-child, .table td:first-child {
            border-top-left-radius: 8px;
            border-bottom-left-radius: 8px;
        }

        .table th:last-child, .table td:last-child {
            border-top-right-radius: 8px;
            border-bottom-right-radius: 8px;
        }

        .table td {
            color: var(--text-color);
        }
        
        .category-image {
            width: 60px;
            height: 60px;
            border-radius: 8px;
            object-fit: cover;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .status-badge {
            padding: 5px 12px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: 500;
            display: inline-block;
            text-transform: capitalize;
        }
        
        .status-badge.active {
            background-color: #e4f8f0;
            color: #28a745;
            border: 1px solid #a3e9d0;
        }

        .status-badge.inactive {
            background-color: #fbe9e7;
            color: #dc3545;
            border: 1px solid #f9bdbb;
        }
        
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

        .action-menu {
            position: absolute;
            right: 10px;
            top: 100%;
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
            padding: 8px 0;
            z-index: 1000;
            min-width: 160px;
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

        .action-menu.show {
            display: flex;
        }
        
        .dropdown-divider {
            height: 1px;
            background-color: #e9ecef;
            margin: 6px 0;
        }

        .action-menu-item {
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
            text-decoration: none;
        }

        .action-menu-item:hover {
            background-color: #f8f9fa;
            transform: translateX(2px);
        }

        .action-menu-item i {
            font-size: 14px;
            width: 18px;
            text-align: center;
        }
        
        .btn-delete-item {
            color: #dc3545;
        }
        
        .btn-delete-item:hover {
            background-color: #fff5f5;
            color: #c82333;
        }

    </style>
</head>
<body>
    <jsp:include page="/includes/admin_sidebar.jsp" />

    <div class="main-content">
        <div class="admin-header">
            <div class="d-flex justify-content-between align-items-center" style="margin-left: 20px;">
                <h2>Manage Categories</h2>
                <div>
                    <a href="admin?action=addCategory" class="btn btn-primary"><i class="fa fa-plus me-2"></i> Add New Category</a>
                    <a href="admin.jsp" class="btn btn-secondary">Back to Dashboard</a>
                </div>
            </div>
        </div>

        <div class="data-table-container">
            
            <!-- Hiển thị thông báo (Message/Error) -->
            <c:if test="${not empty message}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            
            <c:if test="${empty categories}">
                <div class="alert alert-info">
                    No categories found. <a href="admin?action=addCategory">Add the first one!</a>
                </div>
            </c:if>
            
            <c:if test="${not empty categories}">
                <div class="table-responsive">
                    <table class="table align-middle">
                        <thead>
                            <tr>
                                <th>Image</th>
                                <th>Category Name</th>
                                <th>Description</th>
                                <th>Status</th>
                                <th class="text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="category" items="${categories}">
                                <tr>
                                    <td>
                                        <img src="${not empty category.categoryImg ? category.categoryImg : 'images/default-category.png'}" 
                                             alt="${category.categoryName}" class="category-image"
                                             onerror="this.onerror=null;this.src='images/default-category.png';">
                                    </td>
                                    <td class="fw-bold">${category.categoryName}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${fn:length(category.description) > 100}">
                                                <span title="${category.description}">
                                                    ${fn:substring(category.description, 0, 100)}...
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                ${category.description}
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <span class="status-badge ${category.status ? 'active' : 'inactive'}">
                                            ${category.status ? 'Active' : 'Inactive'}
                                        </span>
                                    </td>
                                    <td class="text-center">
                                        <div style="position: relative; display: inline-block;">
                                            <button class="action-menu-btn" onclick="toggleActionMenu(this, event)" aria-label="More actions">
                                                <i class="fa fa-ellipsis-v"></i>
                                            </button>
                                            
                                            <div class="action-menu">
                                                <a href="admin?action=editCategory&id=${category.categoryID}" class="action-menu-item">
                                                    <i class="fa fa-pencil"></i> Edit
                                                </a>
                                                <div class="dropdown-divider"></div>
                                                <button class="action-menu-item btn-delete-item" onclick="confirmDelete('${category.categoryID}', '${category.categoryName}')">
                                                    <i class="fa fa-trash"></i> Delete
                                                </button>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table> <c:if test="${totalPages > 1}">
                    <nav aria-label="Page navigation" class="mt-4 d-flex justify-content-center">
                        <ul class="pagination">
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="admin?action=skills&page=1&keyword=${currentKeyword}&pageSize=${pageSize}">First</a>
                            </li>
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="admin?action=skills&page=${currentPage - 1}&keyword=${currentKeyword}&pageSize=${pageSize}">Previous</a>
                            </li>
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <c:if test="${i >= currentPage - 2 && i <= currentPage + 2}">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="admin?action=skills&page=${i}&keyword=${currentKeyword}&pageSize=${pageSize}">${i}</a>
                                    </li>
                                </c:if>
                            </c:forEach>
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="admin?action=skills&page=${currentPage + 1}&keyword=${currentKeyword}&pageSize=${pageSize}">Next</a>
                            </li>
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="admin?action=skills&page=${totalPages}&keyword=${currentKeyword}&pageSize=${pageSize}">Last</a>
                            </li>
                        </ul>
                    </nav>
                </c:if>
                    
                </div>
            </c:if>
            
            <!-- Khu vực phân trang có thể thêm vào đây sau nếu cần -->
            
        </div>
    </div>

    <script>
        // Xác nhận trước khi xóa
        function confirmDelete(id, name) {
            if (confirm(`Are you sure you want to delete the category "${name}"?\nThis will set its status to inactive.`)) {
                window.location.href = 'admin?action=deleteCategory&id=' + id;
            }
        }

        // Toggle sidebar
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            const content = document.querySelector('.main-content');
            sidebar.classList.toggle('active');
            content.classList.toggle('active');
        }

        // Toggle menu hành động
        function toggleActionMenu(button, event) {
            event.stopPropagation(); // Ngăn sự kiện nổi bọt lên document
            
            // Đóng tất cả các menu khác đang mở
            document.querySelectorAll('.action-menu').forEach(menu => {
                if (menu !== button.nextElementSibling) {
                    menu.classList.remove('show');
                }
            });
            
            // Mở hoặc đóng menu hiện tại
            const menu = button.nextElementSibling;
            if (menu && menu.classList.contains('action-menu')) {
                menu.classList.toggle('show');
            }
        }

        // Đóng menu khi click ra ngoài
        document.addEventListener('click', function(event) {
            // Đóng menu hành động
            if (!event.target.closest('.action-menu-btn')) {
                document.querySelectorAll('.action-menu').forEach(menu => {
                    menu.classList.remove('show');
                });
            }
            
            // Đóng sidebar
            const sidebar = document.getElementById('sidebar');
            const toggleBtn = document.querySelector('.toggle-btn');
            
            if (sidebar && toggleBtn && !sidebar.contains(event.target) && !toggleBtn.contains(event.target)) {
                sidebar.classList.remove('active');
                const mainContent = document.querySelector('.main-content');
                if (mainContent) {
                    mainContent.classList.remove('active');
                }
            }
        });

        // Đóng tất cả menu khi nhấn phím Escape
        document.addEventListener('keydown', function(event) {
            if (event.key === 'Escape') {
                document.querySelectorAll('.action-menu').forEach(menu => {
                    menu.classList.remove('show');
                });
            }
        });
    </script>
    
    <!-- Script của Bootstrap 5 để alert có thể đóng được -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>