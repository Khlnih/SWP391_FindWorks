<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html class="no-js" lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Edit Category - Admin Panel</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/themify-icons.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/responsive.css">
    
    <!-- CSS nội tuyến để đảm bảo tính nhất quán của giao diện -->
    <style>
        :root {
            --primary-color: #ffc107; /* Màu vàng cho edit */
            --primary-dark: #e0a800;
            --primary-light: rgba(255, 193, 7, 0.1);
            --text-color: #2d3436;
            --white: #ffffff;
        }

        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            overflow-x: hidden;
            background: linear-gradient(135deg, #6c757d 0%, #343a40 100%);
            min-height: 100vh;
        }

        /* Sidebar Styles (Copy từ file trước) */
        .sidebar { width: 250px; height: 100vh; position: fixed; left: -250px; background: var(--white); box-shadow: 0 0 20px rgba(0, 0, 0, 0.1); transition: 0.3s ease; z-index: 1000; overflow-y: auto; }
        .sidebar.active { left: 0; }
        .menu-item.active { background: #0d6efd; color: var(--white); }

        /* Main Content Styles */
        .main-content {
            margin-left: 0;
            padding: 30px;
            background: rgba(255, 255, 255, 0.95);
            transition: 0.3s ease;
            min-height: 100vh;
        }
        .sidebar.active ~ .main-content { margin-left: 250px; }

        /* Toggle Button */
        .toggle-btn { position: fixed; top: 20px; left: 10px; background: #0d6efd; color: var(--white); border: none; padding: 10px; border-radius: 50%; cursor: pointer; z-index: 1001; box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2); width: 32px; height: 32px; display: flex; align-items: center; justify-content: center; }
        .toggle-btn i { font-size: 1rem; }

        .admin-header h2 {
            color: var(--text-color);
            font-weight: 700;
            font-size: 2.5rem;
        }

        /* Form Container Styles */
        .form-container {
            background: var(--white);
            border-radius: 12px;
            padding: 30px 40px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            border-top: 5px solid var(--primary-color);
        }
        
        .form-label {
            font-weight: 500;
            color: var(--text-color);
            margin-bottom: 8px;
            font-size: 0.9rem;
        }

        .form-control, .form-select {
            border-radius: 8px;
            border: 1px solid #e0e0e0;
            transition: all 0.3s ease;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem var(--primary-light);
        }
        
        .form-check-label {
            cursor: pointer;
        }
    </style>
</head>
<body>
    <jsp:include page="/includes/admin_sidebar.jsp" />

    <div class="main-content">
        <div class="admin-header mb-4">
            <div class="d-flex justify-content-between align-items-center" style="margin-left: 20px;">
                <h2>Edit Category: <span style="color: var(--primary-color);">${category.categoryName}</span></h2>
                <a href="admin?action=categories" class="btn btn-outline-secondary">
                    <i class="fa fa-arrow-left me-2"></i>Back to Category List
                </a>
            </div>
        </div>

        <!-- Chỉ hiển thị form nếu category tồn tại -->
        <c:if test="${not empty category}">
            <div class="form-container">
                
                <!-- Hiển thị lỗi nếu có -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                        ${error}
                    </div>
                </c:if>
                
                <form action="admin" method="post" id="editCategoryForm" class="needs-validation" novalidate>
                    <!-- Trường ẩn để chỉ định hành động và ID -->
                    <input type="hidden" name="action" value="updateCategory">
                    <input type="hidden" name="categoryId" value="${category.categoryID}">

                    <!-- Category Name -->
                    <div class="mb-3">
                        <label for="categoryName" class="form-label">Category Name <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="categoryName" name="categoryName" 
                               value="${category.categoryName}" required>
                        <div class="invalid-feedback">
                            Please provide a category name.
                        </div>
                    </div>

                    <!-- Description -->
                    <div class="mb-3">
                        <label for="description" class="form-label">Description</label>
                        <textarea class="form-control" id="description" name="description" rows="4">${category.description}</textarea>
                    </div>

                    <!-- Image URL -->
                    <div class="mb-4">
                        <label for="categoryImg" class="form-label">Image URL</label>
                        <input type="text" class="form-control" id="categoryImg" name="categoryImg" 
                               value="${category.categoryImg}" placeholder="e.g., https://example.com/image.png">
                        <div class="form-text">
                            Enter the full URL of the category image. Leave blank for default image.
                        </div>
                    </div>

                    <!-- Status -->
                    <div class="mb-4">
                        <label class="form-label d-block">Status</label>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="status" id="statusActive" value="1" 
                                   ${category.status ? 'checked' : ''}>
                            <label class="form-check-label" for="statusActive">
                                Active
                            </label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="status" id="statusInactive" value="0"
                                   ${!category.status ? 'checked' : ''}>
                            <label class="form-check-label" for="statusInactive">
                                Inactive
                            </label>
                        </div>
                    </div>
                    
                    <hr>

                    <!-- Action Buttons -->
                    <div class="d-flex justify-content-end gap-2 mt-4">
                        <a href="admin?action=categories" class="btn btn-secondary">Cancel</a>
                        <button type="submit" class="btn btn-warning"><i class="fa fa-save me-2"></i>Save Changes</button>
                    </div>
                </form>
            </div>
        </c:if>

        <!-- Hiển thị thông báo nếu không tìm thấy category -->
        <c:if test="${empty category}">
            <div class="alert alert-danger">
                Category not found. It might have been deleted. 
                <a href="admin?action=categories" class="alert-link">Return to list</a>.
            </div>
        </c:if>

    </div>

    <script>
        // JavaScript để toggle sidebar
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            const content = document.querySelector('.main-content');
            sidebar.classList.toggle('active');
            if (content) {
                content.classList.toggle('active');
            }
        }

        // Đóng sidebar khi click ra ngoài
        document.addEventListener('click', function(event) {
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
        
        // Kích hoạt validation của Bootstrap
        (function () {
          'use strict'
          var forms = document.querySelectorAll('.needs-validation')
          Array.prototype.slice.call(forms)
            .forEach(function (form) {
              form.addEventListener('submit', function (event) {
                if (!form.checkValidity()) {
                  event.preventDefault()
                  event.stopPropagation()
                }
                form.classList.add('was-validated')
              }, false)
            })
        })()
    </script>
</body>
</html>