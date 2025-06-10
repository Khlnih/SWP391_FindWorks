<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html class="no-js" lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Edit Skill - Admin Panel</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- CSS Links (giống hệt trang list) -->
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/font-awesome.min.css">
        <link rel="stylesheet" href="css/themify-icons.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/responsive.css">

        <style>
            /* Sử dụng lại style của trang list nhưng đổi màu chủ đạo thành màu vàng cho hành động "edit" */
            :root {
                --primary-color: #ffc107; /* Yellow for edit actions */
                --primary-dark: #e0a800;
                --primary-light: rgba(255, 193, 7, 0.1);
                --text-color: #2d3436;
                --white: #ffffff;
                --success-color: #28a745;
                --danger-color: #dc3545;
            }
            body {
                font-family: 'Poppins', sans-serif;
                margin: 0;
                padding: 0;
                overflow-x: hidden;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
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
            .admin-header h2 {
                color: var(--text-color);
                font-weight: 700;
                font-size: 2.5rem;
            }
            .edit-form-container {
                background: var(--white);
                border-radius: 12px;
                padding: 30px;
                box-shadow: 0 6px 20px rgba(0,0,0,0.08);
                border: 1px solid rgba(0,0,0,0.05);
                max-width: 800px;
                margin: 0 auto;
            }
            .edit-form-container .form-label {
                font-weight: 500;
                color: var(--text-color);
                margin-bottom: 8px;
            }
            .edit-form-container .form-control, .edit-form-container .form-select {
                border-radius: 8px;
                border: 1px solid #e0e0e0;
                transition: all 0.3s ease;
            }
            .edit-form-container .form-control:focus, .edit-form-container .form-select:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.2rem var(--primary-light);
            }
            .form-actions {
                margin-top: 25px;
                display: flex;
                justify-content: flex-end;
                gap: 12px;
            }
            .btn-update {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
                color: #212529;
            }
            .btn-update:hover {
                background-color: var(--primary-dark);
                border-color: var(--primary-dark);
            }
        </style>
    </head>
    <body>
        <!-- Sử dụng sidebar từ một file chung để dễ bảo trì -->
        <jsp:include page="/includes/admin_sidebar.jsp" />

        <div class="main-content">
            <div class="admin-header mb-4">
                <div class="d-flex justify-content-between align-items-center" style="margin-left: 20px;">
                    <h2><i class="fa fa-pencil-square-o me-3" style="color: var(--primary-color);"></i>Edit Skill</h2>
                    <a href="admin?action=skills" class="btn btn-outline-secondary">
                        <i class="fa fa-arrow-left me-2"></i>Back to Skills List
                    </a>
                </div>
            </div>

            <!-- Vùng hiển thị thông báo (giống hệt trang list) -->
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

            <!-- Khối logic chính: Hiển thị form nếu có skillToEdit, ngược lại báo lỗi -->
            <c:choose>
                <c:when test="${not empty skillToEdit}">
                    <div class="edit-form-container">
                        <form id="editSkillForm" action="admin" method="post">
                            <!-- Các trường ẩn quan trọng -->
                            <input type="hidden" name="action" value="updateSkill">
                            <input type="hidden" name="skillSetId" value="${skillToEdit.skillSetId}">

                            <!-- Skill Name -->
                            <div class="mb-3">
                                <label for="skillName" class="form-label">Skill Name <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="skillName" name="skillName" value="<c:out value='${skillToEdit.skillSetName}'/>" required>
                            </div>

                            <!-- Description -->
                            <div class="mb-3">
                                <label for="skillDescription" class="form-label">Description <span class="text-danger">*</span></label>
                                <textarea class="form-control" id="skillDescription" name="skillDescription" rows="4" required><c:out value='${skillToEdit.description}'/></textarea>
                            </div>

                            <!-- Status & Expertise ID trên cùng một hàng -->
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="isActive" class="form-label">Status</label>
                                    <select class="form-select" id="isActive" name="isActive">
                                        <%-- Logic này đúng với Servlet của bạn vì nó check 'true' --%>
                                        <option value="true" ${skillToEdit.active ? 'selected' : ''}>Active</option>
                                        <option value="false" ${not skillToEdit.active ? 'selected' : ''}>Inactive</option>
                                    </select>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="expertiseId" class="form-label">Expertise ID <span class="text-danger">*</span></label>
                                    <input type="number" class="form-control" id="expertiseId" name="expertiseId" value="${skillToEdit.expertiseId}" min="1" required>
                                </div>
                            </div>

                            <!-- Các nút hành động -->
                            <div class="form-actions">
                                 <a href="admin?action=skills" class="btn btn-secondary">
                                    <i class="fa fa-times me-2"></i>Cancel
                                </a>
                                <button type="submit" class="btn btn-update fw-bold">
                                    <i class="fa fa-save me-2"></i>Update Skill
                                </button>
                            </div>
                        </form>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Thông báo khi không tìm thấy skill -->
                     <c:if test="${empty error}"> <%-- Chỉ hiển thị nếu chưa có thông báo lỗi nào khác --%>
                        <div class="alert alert-warning text-center" role="alert">
                           <h4>Skill Not Found</h4>
                           <p>The skill you are trying to edit does not exist. Please return to the list and select a valid skill.</p>
                           <a href="admin?action=skills" class="btn btn-secondary">
                                <i class="fa fa-arrow-left me-2"></i>Back to Skills List
                           </a>
                        </div>
                    </c:if>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- JS (giống hệt trang list, chỉ thêm validation cho form edit) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Các hàm JS chung (có thể đưa vào file js riêng sau này)
            function toggleSidebar() {
                const sidebar = document.querySelector('.sidebar');
                if (sidebar) sidebar.classList.toggle('active');
                
                const mainContent = document.querySelector('.main-content');
                if (mainContent) mainContent.classList.toggle('sidebar-active'); // Có thể dùng class này để điều chỉnh main content
            }
            
            // Đóng sidebar khi click ra ngoài
            document.addEventListener('click', function (event) {
                const sidebar = document.querySelector('.sidebar');
                const toggleBtn = document.querySelector('.toggle-btn');
                if (sidebar && toggleBtn && sidebar.classList.contains('active') && !sidebar.contains(event.target) && !toggleBtn.contains(event.target)) {
                    sidebar.classList.remove('active');
                }
            });

            // THÊM: Client-side validation cho form edit
            document.getElementById('editSkillForm').addEventListener('submit', function(event) {
                const skillNameInput = document.getElementById('skillName');
                const skillDescriptionInput = document.getElementById('skillDescription');
                const expertiseIdInput = document.getElementById('expertiseId');
                
                let isValid = true;
                
                // Reset visual feedback
                skillNameInput.classList.remove('is-invalid');
                skillDescriptionInput.classList.remove('is-invalid');
                expertiseIdInput.classList.remove('is-invalid');

                // Check for empty or whitespace-only strings
                if (skillNameInput.value.trim() === '') {
                    skillNameInput.classList.add('is-invalid');
                    isValid = false;
                }
                if (skillDescriptionInput.value.trim() === '') {
                    skillDescriptionInput.classList.add('is-invalid');
                    isValid = false;
                }
                if (expertiseIdInput.value.trim() === '') {
                    expertiseIdInput.classList.add('is-invalid');
                    isValid = false;
                }

                if (!isValid) {
                    event.preventDefault(); // Ngăn form gửi đi
                    alert('Please fill out all required fields. Fields cannot contain only spaces.');
                    const firstInvalidField = document.querySelector('.is-invalid');
                    if (firstInvalidField) {
                        firstInvalidField.focus();
                    }
                }
            });
        </script>
    </body>
</html>