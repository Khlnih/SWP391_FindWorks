<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="Model.AccountTier" %>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Gói Tài Khoản</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3a0ca3;
            --success-color: #4bb543;
            --danger-color: #ff3333;
            --light-bg: #f8f9fa;
            --dark-text: #2b2d42;
            --light-text: #6c757d;
            --border-radius: 8px;
            --box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            --transition: all 0.3s ease;
        }
        
        body {
            background-color: #f5f7fb;
            color: var(--dark-text);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
        }
        
        .container {
            padding: 2rem;
            max-width: 1400px;
            margin: 0 auto;
        }
        
        .page-title {
            color: var(--dark-text);
            margin-bottom: 2rem;
            font-weight: 700;
            position: relative;
            padding-bottom: 0.5rem;
        }
        
        .page-title:after {
            content: '';
            position: absolute;
            left: 0;
            bottom: 0;
            width: 60px;
            height: 4px;
            background: var(--primary-color);
            border-radius: 2px;
        }
        
        .card {
            background: #fff;
            border: none;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            margin-bottom: 2rem;
            overflow: hidden;
            transition: var(--transition);
        }
        
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.12);
        }
        
        .card-header {
            background: var(--primary-color);
            color: white;
            padding: 1.25rem 1.5rem;
            border-bottom: none;
        }
        
        .card-body {
            padding: 1.5rem;
        }
        
        .form-control, .form-select {
            border: 1px solid #e1e5ee;
            border-radius: var(--border-radius);
            padding: 0.6rem 1rem;
            transition: var(--transition);
        }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(67, 97, 238, 0.15);
        }
        
        .btn {
            padding: 0.6rem 1.5rem;
            border-radius: var(--border-radius);
            font-weight: 500;
            transition: all 0.3s ease, transform 0.2s ease, box-shadow 0.2s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.85rem;
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            border: none;
        }
        
        .btn-primary:hover {
            background-color: var(--secondary-color);
            transform: translateY(-2px);
        }
        
        .btn-edit {
            background: var(--success-color);
            color: white;
            border: none;
            padding: 0.4rem 0.8rem;
            border-radius: 4px;
            margin-right: 0.5rem;
            transition: var(--transition);
        }
        
        .btn-edit:hover {
            background: #3a9a33;
            transform: translateY(-2px);
        }
        
        .btn-delete {
            background: var(--danger-color);
            color: white;
            border: none;
            padding: 0.4rem 0.8rem;
            border-radius: 4px;
            transition: var(--transition);
        }
        
        .btn-delete:hover {
            background: #cc0000;
            transform: translateY(-2px);
        }
        
        .table {
            margin-bottom: 0;
        }
        
        .table th {
            background-color: #f8f9fa;
            border-bottom: 2px solid #e9ecef;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.8rem;
            letter-spacing: 0.5px;
            color: var(--light-text);
        }
        
        .table td {
            vertical-align: middle;
            padding: 1rem 0.75rem;
            border-color: #edf2f7;
        }
        
        .table tbody tr {
            transition: var(--transition);
        }
        
        .table tbody tr:hover {
            background-color: #f8f9fa;
        }
        
        .status-badge {
            padding: 0.35rem 0.65rem;
            border-radius: 50rem;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .status-active {
            background-color: #e6f7ee;
            color: #10b981;
        }
        
        .status-inactive {
            background-color: #fef3f2;
            color: #f04438;
        }
        
        .modal-content {
            border: none;
            border-radius: var(--border-radius);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
        }
        
        .modal-header {
            border-bottom: none;
            padding: 1.5rem 1.5rem 0.5rem;
        }
        
        .modal-body {
            padding: 0 1.5rem 1.5rem;
        }
        
        .modal-footer {
            border-top: none;
            padding: 1rem 1.5rem;
            background-color: #f8f9fa;
            border-bottom-left-radius: var(--border-radius);
            border-bottom-right-radius: var(--border-radius);
        }
        
        .alert {
            border: none;
            border-radius: var(--border-radius);
            padding: 1rem 1.5rem;
            margin-bottom: 1.5rem;
            font-weight: 500;
        }
        
        .alert-success {
            background-color: #e6f7ee;
            color: #10b981;
        }
        
        .alert-danger {
            background-color: #fef3f2;
            color: #f04438;
        }
        
        .pagination {
            margin-top: 2rem;
            justify-content: center;
        }
        
        .page-link {
            color: var(--primary-color);
            border: 1px solid #e1e5ee;
            margin: 0 0.25rem;
            border-radius: 4px !important;
            padding: 0.5rem 1rem;
            transition: var(--transition);
        }
        
        .page-item.active .page-link {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        .page-link:hover {
            background-color: #f0f2f5;
            color: var(--secondary-color);
        }
        
        /* Responsive adjustments */
        @media (max-width: 992px) {
            .container {
                padding: 1rem;
            }
            
            .card-body {
                padding: 1rem;
            }
            
            .table-responsive {
                overflow-x: auto;
            }
        }
        
        @media (max-width: 768px) {
            .btn {
                padding: 0.5rem 1rem;
                font-size: 0.8rem;
            }
            
            .page-title {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Alerts -->
        <c:if test="${not empty success}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle me-2"></i>${success}
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle me-2"></i>${error}
            </div>
        </c:if>
        
        <!-- Sidebar -->
        <jsp:include page="/includes/admin_sidebar.jsp" />

        <!-- Main Content -->
        <div class="main-content">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="page-title">
                    <i class="fas fa-crown me-2"></i>Account Tiers Management
                </h2>
                <a href="add_accountTier.jsp" class="btn btn-primary">
                    <i class="fas fa-plus me-2"></i>Add New Tier
                </a>
            </div>
            
            <!-- Account Tiers List Card -->
            <div class="card">
                <div class="card-header">
                    <i class="fas fa-list me-2"></i>Account Tiers List
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <c:choose>
                            <c:when test="${empty accountTiers}">
                                <div class="alert alert-warning">
                                    <i class="fas fa-exclamation-triangle me-2"></i>
                                    Không có dữ liệu gói tài khoản nào được tìm thấy!
                                </div>
                            </c:when>
                            <c:otherwise>
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>Name</th>
                                            <th>Price</th>
                                            <th>Duration</th>
                                            <th>Scope</th>
                                            <th>Status</th>
                                            <th class="text-end">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="tier" items="${accountTiers}">
                                            <tr>
                                                <td><strong>${tier.tierName}</strong></td>
                                                <td>${tier.price} ₫</td>
                                                <td>${tier.durationDays} days</td>
                                                <td>${tier.userTypeScope == 'CANDIDATE' ? 'Candidate' : tier.userTypeScope == 'EMPLOYER' ? 'Employer' : 'All'}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${tier.status == 1}">
                                                            <span class="badge bg-success">Active</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-danger">Inactive</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="text-end">
                                                    <button class="btn btn-sm btn-edit edit-btn" data-bs-toggle="modal" data-bs-target="#editModal" data-id="${tier.tierID}" data-name="${fn:escapeXml(tier.tierName)}" data-price="${tier.price}" data-duration="${tier.durationDays}" data-description="${fn:escapeXml(tier.description)}" data-scope="${tier.userTypeScope}" data-status="${tier.status}">
                                                        <i class="fas fa-edit"></i> Edit
                                                    </button>
                                                    <button class="btn btn-sm btn-danger delete-btn" data-bs-toggle="modal" data-bs-target="#deleteModal" data-id="${tier.tierID}" data-name="${fn:escapeXml(tier.tierName)}">
                                                        <i class="fas fa-trash"></i> Delete
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:otherwise>
                        </c:choose>
                        
                        <c:if test="${totalPages > 1}">
                            <nav class="mt-4">
                                <ul class="pagination justify-content-center">
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="?page=${currentPage - 1}" aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                    
                                    <c:set var="startPage" value="${currentPage > 2 ? currentPage - 2 : 1}" />
                                    <c:set var="endPage" value="${startPage + 4 > totalPages ? totalPages : startPage + 4}" />
                                    
                                    <c:if test="${startPage > 1}">
                                        <li class="page-item">
                                            <a class="page-link" href="?page=1">1</a>
                                        </li>
                                        <c:if test="${startPage > 2}">
                                            <li class="page-item disabled">
                                                <span class="page-link">...</span>
                                            </li>
                                        </c:if>
                                    </c:if>
                                    
                                    <c:forEach begin="${startPage}" end="${endPage}" var="i">
                                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                                            <a class="page-link" href="?page=${i}">${i}</a>
                                        </li>
                                    </c:forEach>
                                    
                                    <c:if test="${endPage < totalPages}">
                                        <c:if test="${endPage < totalPages - 1}">
                                            <li class="page-item disabled">
                                                <span class="page-link">...</span>
                                            </li>
                                        </c:if>
                                        <li class="page-item">
                                            <a class="page-link" href="?page=${totalPages}">${totalPages}</a>
                                        </li>
                                    </c:if>
                                    
                                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                        <a class="page-link" href="?page=${currentPage + 1}" aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                        </c:if>
                    </div>
                </div>
            </div>


        
        <!-- JavaScript -->
        <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Initialize Bootstrap tooltips
            var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
            var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                return new bootstrap.Tooltip(tooltipTriggerEl);
            });
            
            document.querySelectorAll('.delete-tier').forEach(function(button) {
                button.addEventListener('click', function() {
                    var tierId = this.getAttribute('data-tier-id');
                    var tierName = this.getAttribute('data-tier-name');
                    showDeleteModal(tierId, tierName);
                });
            });
            
            // Initialize form validation
            initFormValidation();
        });
        
        // Form validation
        function initFormValidation() {
            'use strict';
            
            // Fetch all the forms we want to apply custom Bootstrap validation styles to
            var forms = document.querySelectorAll('.needs-validation');
            
            // Loop over them and prevent submission
            Array.prototype.slice.call(forms).forEach(function (form) {
                form.addEventListener('submit', function (event) {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    
                    form.classList.add('was-validated');
                }, false);
            });
        }
        
        // Edit Tier
        function editTier(tierId) {
            // Show loading state
            const editModal = new bootstrap.Modal(document.getElementById('editModal'));
            const form = document.getElementById('editForm');
            
            // Reset form and validation
            form.reset();
            form.classList.remove('was-validated');
            
            // Fetch tier data via AJAX - using string concatenation for JSP compatibility
            fetch('admin/accountTier?action=get&id=' + tierId)
                .then(function(response) {
                    if (!response.ok) throw new Error('Network response was not ok');
                    return response.json();
                })
                .then(function(data) {
                    // Populate form fields
                    document.getElementById('editTierId').value = data.tierID || '';
                    document.getElementById('editName').value = data.tierName || '';
                    document.getElementById('editPrice').value = data.price || '';
                    document.getElementById('editDuration').value = data.durationDays || '';
                    document.getElementById('editDescription').value = data.description || '';
                    document.getElementById('editScope').value = data.userTypeScope || 'both';
                    document.getElementById('editStatus').value = data.status || '1';
                    
                    // Show the modal
                    editModal.show();
                })
                .catch(function(error) {
                    console.error('Error fetching tier data:', error);
                    showAlert('An error occurred while loading tier data', 'danger');
                });
        }
        
        // Show delete confirmation modal
        function showDeleteModal(tierId, tierName) {
            var deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
            document.getElementById('deleteTierId').value = tierId;
            document.getElementById('deleteTierName').textContent = tierName || '';
            deleteModal.show();
        }
        
        // Show alert message
        function showAlert(message, type) {
            // Default type to 'success' if not provided
            type = type || 'success';
            
            // Create alert HTML using string concatenation
            var iconClass = type === 'success' ? 'fas fa-check-circle' : 'fas fa-exclamation-circle';
            var alertHtml = '' +
                '<div class="alert alert-' + type + ' alert-dismissible fade show" role="alert">' +
                '    <i class="' + iconClass + ' me-2"></i>' +
                '    ' + message +
                '    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>' +
                '</div>';
            
            // Insert alert before the main content
            var mainContent = document.querySelector('.main-content');
            if (mainContent) {
                mainContent.insertAdjacentHTML('afterbegin', alertHtml);
                
                // Auto-dismiss after 5 seconds
                setTimeout(function() {
                    var alert = document.querySelector('.alert');
                    if (alert) {
                        var bsAlert = new bootstrap.Alert(alert);
                        bsAlert.close();
                    }
                }, 5000);
            }
        }
        
        // Handle form submission with fetch API
        document.addEventListener('DOMContentLoaded', function() {
            var editForm = document.getElementById('editForm');
            if (editForm) {
                editForm.addEventListener('submit', function(e) {
                    e.preventDefault();
                    
                    var formData = new FormData(editForm);
                    
                    fetch(editForm.action, {
                        method: 'POST',
                        body: formData
                    })
                    .then(function(response) {
                        if (!response.ok) throw new Error('Network response was not ok');
                        return response.json();
                    })
                    .then(function(data) {
                        if (data.success) {
                            showAlert('Account tier updated successfully!', 'success');
                            // Close modal and reload page after a short delay
                            var modal = bootstrap.Modal.getInstance(document.getElementById('editModal'));
                            if (modal) modal.hide();
                            setTimeout(function() { window.location.reload(); }, 1000);
                        } else {
                            showAlert(data.message || 'An error occurred while updating', 'danger');
                        }
                    })
                    .catch(function(error) {
                        console.error('Error:', error);
                        showAlert('An error occurred while sending update request', 'danger');
                    });
                });
            }
            
            // Handle delete form submission
            var deleteForm = document.getElementById('deleteForm');
            if (deleteForm) {
                deleteForm.addEventListener('submit', function(e) {
                    e.preventDefault();
                    
                    fetch(deleteForm.action, {
                        method: 'POST',
                        body: new FormData(deleteForm)
                    })
                    .then(function(response) { return response.json(); })
                    .then(function(data) {
                        if (data.success) {
                            showAlert('Account tier deleted successfully!', 'success');
                            // Close modal and reload page after a short delay
                            var modal = bootstrap.Modal.getInstance(document.getElementById('deleteModal'));
                            if (modal) modal.hide();
                            setTimeout(function() { window.location.reload(); }, 1000);
                        } else {
                            showAlert(data.message || 'An error occurred while deleting', 'danger');
                        }
                    })
                    .catch(function(error) {
                        console.error('Error:', error);
                        showAlert('An error occurred while sending delete request', 'danger');
                    });
                });
            }
        });
        
        // Format currency input
        document.addEventListener('input', function(e) {
            if (e.target.id === 'price' || e.target.id === 'editPrice') {
                // Cache the input element
                var input = e.target;
                // Get the current cursor position
                var cursorPos = input.selectionStart;
                // Get the current value and remove all non-digit characters
                var value = input.value.replace(/\D/g, '');
                // Format as currency if there's a value
                if (value) {
                    var formattedValue = new Intl.NumberFormat('vi-VN').format(parseInt(value));
                    // Only update if the value has changed to avoid cursor jumping
                    if (input.value !== formattedValue) {
                        input.value = formattedValue;
                        // Restore cursor position
                        input.setSelectionRange(cursorPos, cursorPos);
                    }
                } else {
                    input.value = '';
                }
            }
        });
        </script>

        <!-- Delete Confirmation Modal -->
        <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-danger text-white">
                        <h5 class="modal-title" id="deleteModalLabel">
                            <i class="fas fa-exclamation-triangle me-2"></i>Confirm Deletion
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the account tier <strong id="deleteTierName"></strong>? This action cannot be undone.</p>
                        <p class="text-muted mb-0">ID: <span id="deleteTierId"></span></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-1"></i> Cancel
                        </button>
                        <form id="deleteForm" method="post" action="admin/accountTier?action=delete" class="d-inline">
                            <input type="hidden" name="tierID" id="deleteTierIdInput">
                            <button type="submit" class="btn btn-danger">
                                <i class="fas fa-trash me-1"></i> Delete
                            </button>
                        </form>
                    </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Handle edit modal
        function editTier(id) {
            fetch("getAccountTierById.jsp?id=" + id)
                .then(response => response.json())
                .then(data => {
                    document.getElementById("editId").value = data.tierID;
                    document.getElementById("editName").value = data.tierName;
                    document.getElementById("editPrice").value = data.price;
                    document.getElementById("editDurationDays").value = data.durationDays;
                    document.getElementById("editDescription").value = data.description;
                    document.getElementById("editUserTypeScope").value = data.userTypeScope;
                    document.getElementById("editStatus").value = data.status;
                    
                    var modal = document.getElementById("editModal");
                    modal.style.display = "block";
                });
        }
        
        // Xử lý xóa gói tài khoản
        function deleteTier(id) {
            if (confirm("Bạn có chắc chắn muốn xóa gói tài khoản này không?")) {
                window.location.href = "admin/accountTier?action=delete&id=" + id;
            }
        }
        
        // Đóng modal khi click vào nút close
        var span = document.getElementsByClassName("close")[0];
        span.onclick = function() {
            var modal = document.getElementById("editModal");
            modal.style.display = "none";
        }
        
        // Đóng modal khi click ra ngoài
        window.onclick = function(event) {
            var modal = document.getElementById("editModal");
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>
</body>
</html>
