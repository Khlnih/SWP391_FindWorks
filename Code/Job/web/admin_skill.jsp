<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html class="no-js" lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Manage Skills - Admin Panel</title>
        <meta name="description" content="Admin page for managing skills">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- CSS -->
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/font-awesome.min.css">
        <link rel="stylesheet" href="css/themify-icons.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/responsive.css">

        <style>
            :root {
                --primary-color: #28a745; /* Green color for skill management */
                --primary-dark: #218838;
                --primary-light: rgba(40, 167, 69, 0.1);
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
            .menu-item.active {
                background: #0d6efd;
                color: var(--white);
            }
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
                position: fixed;
                top: 20px;
                left: 10px;
                background: #0d6efd;
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
            .admin-header h2 {
                color: var(--text-color);
                font-weight: 700;
                font-size: 2.5rem;
            }
            .data-container, .form-container {
                background: var(--white);
                border-radius: 12px;
                padding: 24px;
                box-shadow: 0 4px 15px rgba(0,0,0,0.05);
                border: 1px solid #e9ecef;
                margin-bottom: 30px;
            }
            .form-container h4 {
                color: var(--primary-color);
                margin-bottom: 20px;
                font-weight: 600;
            }
            .form-control, .form-select {
                border-radius: 8px;
            }
            .form-control:focus, .form-select:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.2rem var(--primary-light);
            }
            .table th {
                background: var(--primary-light);
                color: var(--text-color);
                font-weight: 500;
                text-transform: uppercase;
                font-size: 0.875rem;
            }
            .table td {
                vertical-align: middle;
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
                box-shadow: 0 4px 15px rgba(0,0,0,0.15);
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
                from {
                    opacity: 0;
                    transform: translateY(-5px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
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
            .pagination .page-item.active .page-link {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
            }
            .pagination .page-link {
                color: var(--primary-color);
            }
            .pagination .page-link:hover {
                background-color: var(--primary-light);
            }
        </style>
    </head>
    <body>
        <jsp:include page="/includes/admin_sidebar.jsp" />

        <div class="main-content">
            <div class="admin-header mb-4">
                <div class="d-flex justify-content-between align-items-center" style="margin-left: 20px;">
                    <h2>Manage Skills <span class="badge bg-secondary">${totalSkills} total</span></h2>
                    <a href="admin?action=dashboard" class="btn btn-outline-secondary">
                        <i class="fa fa-arrow-left me-2"></i>Back to Dashboard
                    </a>
                </div>
            </div>

            <!-- Display success or error messages -->
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

            <!-- Add New Skill Form -->
            <div class="form-container">
                <h4><i class="fa fa-plus-circle me-2"></i>Add New Skill</h4>
                <form action="admin?action=addSkill" method="post" id="addSkillForm">
                    <div class="row g-3 align-items-end">
                        <div class="col-md-4">
                            <label for="skillName" class="form-label">Skill Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="skillName" name="skillName" required>
                        </div>
                        <div class="col-md-5">
                            <label for="skillDescription" class="form-label">Description</label>
                            <input type="text" class="form-control" id="skillDescription" name="skillDescription" required>

                        </div>
                        <div class="col-md-1">
                            <label for="expertiseId" class="form-label">Expertise ID</label>
                            <input type="number" class="form-control" id="expertiseId" name="expertiseId" min="1" required>
                        </div>
                        <div class="col-md-1">
                            <label for="isActive" class="form-label">Status</label>
                            <select class="form-select" id="isActive" name="isActive">
                                <option value="1" selected>Active</option>
                                <option value="0">Inactive</option>
                            </select>
                        </div>
                        <div class="col-md-1">
                            <button type="submit" class="btn btn-success w-100">
                                <i class="fa fa-plus me-2"></i>Add Skill
                            </button>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Data table and search container -->
            <div class="data-container">
                <!-- Search Box -->
                <form action="admin" method="get" class="mb-4">
                    <input type="hidden" name="action" value="skills">
                    <div class="row g-3 align-items-end">
                        <div class="col-md-9">
                            <label for="searchKeyword" class="form-label">Search Skill Name</label>
                            <input type="text" id="searchKeyword" name="keyword" placeholder="Enter skill name..." class="form-control" value="${currentKeyword}">
                        </div>
                        <div class="col-md-3">
                            <div class="d-flex gap-2">
                                <button type="submit" class="btn btn-primary w-100"><i class="fa fa-search me-2"></i>Search</button>
                                <a href="admin?action=skills" class="btn btn-outline-secondary w-100"><i class="fa fa-refresh"></i></a>
                            </div>
                        </div>
                    </div>
                </form>

                <c:if test="${empty skillList && empty error}">
                    <div class="alert alert-info">No skills found. Try adding a new skill or adjusting your search.</div>
                </c:if>

                <c:if test="${not empty skillList}">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Skill Name</th>
                                    <th>Description</th>
                                    <th>Expertise ID</th>
                                    <th>Status</th>
                                    <th class="text-center">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="skill" items="${skillList}">
                                    <tr>
                                        <td>${skill.skillSetId}</td>
                                        <td class="fw-bold"><c:out value="${skill.skillSetName}"/></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${fn:length(skill.description) > 80}">
                                                    <span title="${skill.description}">${fn:substring(skill.description, 0, 80)}...</span>
                                                </c:when>
                                                <c:otherwise><c:out value="${skill.description}"/></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${skill.expertiseId}</td>
                                        <td>
                                            <span class="status-badge ${skill.active ? 'active' : 'inactive'}">
                                                ${skill.active ? 'Active' : 'Inactive'}
                                            </span>
                                        </td>
                                        <td class="text-center">
                                            <div style="position: relative; display: inline-block;">
                                                <button class="action-menu-btn" onclick="toggleActionMenu(this, event)" aria-label="More actions">
                                                    <i class="fa fa-ellipsis-v"></i>
                                                </button>
                                                <div class="action-menu">
                                                    <a href="admin?action=editSkill&id=${skill.skillSetId}" class="action-menu-item">
                                                        <i class="fa fa-pencil"></i> Edit
                                                    </a>
                                                    <div class="dropdown-divider"></div>
                                                    <button class="action-menu-item btn-delete-item" onclick="confirmDelete('${skill.skillSetId}', '${fn:escapeXml(skill.skillSetName)}')">
                                                        <i class="fa fa-trash"></i> Delete
                                                    </button>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <!-- Pagination Section -->
                    <c:if test="${totalPages > 1}">
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
                </c:if>
            </div>
        </div>

        <!-- JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                                        function confirmDelete(id, name) {
                                                            if (confirm(`Are you sure you want to delete the skill "${name}"? This action cannot be undone.`)) {
                                                                window.location.href = 'admin?action=deleteSkill&id=' + id;
                                                            }
                                                        }
                                                        function toggleSidebar() {
                                                            const sidebar = document.querySelector('.sidebar');
                                                            const content = document.querySelector('.main-content');
                                                            if (sidebar)
                                                                sidebar.classList.toggle('active');
                                                            if (content)
                                                                content.classList.toggle('active');
                                                        }
                                                        function toggleActionMenu(button, event) {
                                                            event.stopPropagation();
                                                            document.querySelectorAll('.action-menu').forEach(menu => {
                                                                if (menu !== button.nextElementSibling)
                                                                    menu.classList.remove('show');
                                                            });
                                                            const menu = button.nextElementSibling;
                                                            if (menu)
                                                                menu.classList.toggle('show');
                                                        }
                                                        document.addEventListener('click', function (event) {
                                                            if (!event.target.closest('.action-menu-btn')) {
                                                                document.querySelectorAll('.action-menu').forEach(menu => menu.classList.remove('show'));
                                                            }
                                                            const sidebar = document.querySelector('.sidebar');
                                                            const toggleBtn = document.querySelector('.toggle-btn');
                                                            if (sidebar && toggleBtn && !sidebar.contains(event.target) && !toggleBtn.contains(event.target)) {
                                                                sidebar.classList.remove('active');
                                                                const mainContent = document.querySelector('.main-content');
                                                                if (mainContent)
                                                                    mainContent.classList.remove('active');
                                                            }
                                                        });
                                                        document.addEventListener('keydown', function (event) {
                                                            if (event.key === 'Escape') {
                                                                document.querySelectorAll('.action-menu').forEach(menu => menu.classList.remove('show'));
                                                            }
                                                        });
        </script>
        <script>
            // Lắng nghe sự kiện submit trên form có id="addSkillForm"
            document.getElementById('addSkillForm').addEventListener('submit', function (event) {

                // Lấy các trường input cần kiểm tra
                const skillNameInput = document.getElementById('skillName');
                const skillDescriptionInput = document.getElementById('skillDescription');

                let isValid = true;

                // Xóa các thông báo lỗi cũ (nếu có)
                // Đây là ví dụ nếu bạn dùng class của Bootstrap để hiển thị lỗi
                skillNameInput.classList.remove('is-invalid');
                skillDescriptionInput.classList.remove('is-invalid');

                // --- Kiểm tra Skill Name ---
                if (skillNameInput.value.trim() === '') {
                    // Ngăn chặn form được gửi đi
                    event.preventDefault();

                    // Hiển thị cảnh báo cho người dùng
                    alert('Skill Name cannot be empty or just spaces.');

                    // (Tùy chọn nâng cao) Thêm class lỗi để input có viền đỏ (nếu dùng Bootstrap)
                    skillNameInput.classList.add('is-invalid');

                    isValid = false;
                }

                // --- Kiểm tra Description ---
                if (skillDescriptionInput.value.trim() === '') {
                    event.preventDefault();
                    alert('Description cannot be empty or just spaces.');
                    skillDescriptionInput.classList.add('is-invalid');
                    isValid = false;
                }

                // Đặt focus vào trường lỗi đầu tiên để người dùng dễ sửa
                if (!isValid) {
                    const firstInvalidField = document.querySelector('.is-invalid');
                    if (firstInvalidField) {
                        firstInvalidField.focus();
                    }
                }
            });
        </script>
    </body>
</html>
