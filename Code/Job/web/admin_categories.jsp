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

    <!-- CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/themify-icons.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/responsive.css">
    
    <style>
        /* ... (Toàn bộ CSS của bạn giữ nguyên ở đây) ... */
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
        .main-content {
            margin-left: 0;
            padding: 30px;
            background: rgba(255, 255, 255, 0.95);
            transition: 0.3s ease;
            min-height: 100vh;
        }
        .admin-header h2 {
            color: var(--primary-color);
            font-weight: 700;
        }
        .data-table-container {
            background: var(--white);
            border-radius: 12px;
            padding: 24px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        }
        .table th {
            background: var(--primary-light);
            color: var(--text-color);
        }
        .category-image {
            width: 60px;
            height: 60px;
            border-radius: 8px;
            object-fit: cover;
        }
        .status-badge {
            padding: 5px 12px;
            border-radius: 15px;
            font-size: 12px;
        }
        .status-badge.active { background-color: #e4f8f0; color: #28a745; }
        .status-badge.inactive { background-color: #fbe9e7; color: #dc3545; }
        .action-menu-btn { background: none; border: none; cursor: pointer; }
        .action-menu { position: absolute; right: 10px; top: 100%; background: white; border-radius: 8px; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15); padding: 8px 0; z-index: 1000; min-width: 160px; display: none; }
        .action-menu.show { display: block; }
        .action-menu-item { padding: 8px 16px; color: #495057; text-decoration: none; display: block; }
        .action-menu-item:hover { background-color: #f8f9fa; }
        .btn-delete-item { color: #dc3545; }
        .pagination .page-item.active .page-link { background-color: var(--primary-color); border-color: var(--primary-color); }
        .pagination .page-link { color: var(--primary-color); }
        .pagination .page-item.disabled .page-link { color: #6c757d; }
    </style>
</head>
<body>
    <jsp:include page="/includes/admin_sidebar.jsp" />

    <div class="main-content">
        <div class="admin-header">
            <div class="d-flex justify-content-between align-items-center" style="margin-left: 20px; margin-bottom: 20px;">
                <h2>Manage Categories</h2>
                <div>
                    <a href="admin?action=addCategory" class="btn btn-primary"><i class="fa fa-plus me-2"></i> Add New Category</a>
                    <a href="admin.jsp" class="btn btn-secondary">Back to Dashboard</a>
                </div>
            </div>
        </div>

        <div class="data-table-container">
            
            <!-- Hiển thị thông báo -->
            <c:if test="${not empty message}"><div class="alert alert-success alert-dismissible fade show" role="alert">${message}<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div></c:if>
            <c:if test="${not empty error}"><div class="alert alert-danger alert-dismissible fade show" role="alert">${error}<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div></c:if>

            <!-- Form tìm kiếm -->
            <div class="row mb-3">
                <div class="col-md-6">
                    <form action="admin" method="get" class="d-flex">
                        <input type="hidden" name="action" value="categories">
                        <input type="text" name="keyword" class="form-control me-2" placeholder="Search by name or description..." value="${currentKeyword}">
                        <button type="submit" class="btn btn-info">Search</button>
                    </form>
                </div>
                <div class="col-md-6 text-md-end">
                    <c:if test="${totalCategories > 0}">
                        <span class="text-muted">Showing ${fn:length(categories)} of ${totalCategories} categories.</span>
                    </c:if>
                </div>
            </div>
            
            <c:if test="${empty categories}">
                <div class="alert alert-info">
                    <c:choose>
                        <c:when test="${not empty currentKeyword}">
                            No categories found matching your search for "<strong>${currentKeyword}</strong>".
                        </c:when>
                        <c:otherwise>
                            No categories found. <a href="admin?action=addCategory">Add the first one!</a>
                        </c:otherwise>
                    </c:choose>
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
                                    <td><img src="${not empty category.categoryImg ? category.categoryImg : 'images/default-category.png'}" alt="${category.categoryName}" class="category-image" onerror="this.onerror=null;this.src='images/default-category.png';"></td>
                                    <td class="fw-bold">${category.categoryName}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${fn:length(category.description) > 100}"><span title="${category.description}">${fn:substring(category.description, 0, 100)}...</span></c:when>
                                            <c:otherwise>${category.description}</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><span class="status-badge ${category.status ? 'active' : 'inactive'}">${category.status ? 'Active' : 'Inactive'}</span></td>
                                    <td class="text-center">
                                        <div style="position: relative; display: inline-block;">
                                            <button class="action-menu-btn" onclick="toggleActionMenu(this, event)"><i class="fa fa-ellipsis-v"></i></button>
                                            <div class="action-menu">
                                                <a href="admin?action=editCategory&id=${category.categoryID}" class="action-menu-item"><i class="fa fa-pencil"></i> Edit</a>
                                                <div class="dropdown-divider"></div>
                                                <button class="action-menu-item btn-delete-item" onclick="confirmDelete('${category.categoryID}', '${fn:escapeXml(category.categoryName)}')"><i class="fa fa-trash"></i> Delete</button>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- Khối phân trang -->
                <c:if test="${totalPages > 1}">
                    <nav aria-label="Page navigation" class="mt-4 d-flex justify-content-center">
                        <ul class="pagination">
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="admin?action=categories&page=1&keyword=${currentKeyword}&pageSize=${pageSize}">First</a>
                            </li>
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="admin?action=categories&page=${currentPage - 1}&keyword=${currentKeyword}&pageSize=${pageSize}">Previous</a>
                            </li>
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <c:if test="${i >= currentPage - 2 && i <= currentPage + 2}">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="admin?action=categories&page=${i}&keyword=${currentKeyword}&pageSize=${pageSize}">${i}</a>
                                    </li>
                                </c:if>
                            </c:forEach>
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="admin?action=categories&page=${currentPage + 1}&keyword=${currentKeyword}&pageSize=${pageSize}">Next</a>
                            </li>
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="admin?action=categories&page=${totalPages}&keyword=${currentKeyword}&pageSize=${pageSize}">Last</a>
                            </li>
                        </ul>
                    </nav>
                </c:if>
            </c:if>
        </div>
    </div>

    <script>
        // Cập nhật hàm confirmDelete để phản ánh đúng hành động
        function confirmDelete(id, name) {
            if (confirm(`Are you sure you want to PERMANENTLY delete the category "${name}"?\nThis action cannot be undone.`)) {
                window.location.href = 'admin?action=deleteCategory&id=' + id;
            }
        }
        
        // --- Các hàm JS khác của bạn (giữ nguyên) ---
        function toggleActionMenu(button, event) {
            event.stopPropagation();
            document.querySelectorAll('.action-menu').forEach(menu => {
                if (menu !== button.nextElementSibling) menu.classList.remove('show');
            });
            button.nextElementSibling.classList.toggle('show');
        }
        document.addEventListener('click', function(event) {
            if (!event.target.closest('.action-menu-btn')) {
                document.querySelectorAll('.action-menu').forEach(menu => menu.classList.remove('show'));
            }
        });
    </script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>