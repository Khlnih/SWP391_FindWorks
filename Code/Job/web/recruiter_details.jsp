<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Thông tin nhà tuyển dụng - FindWorks</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #3b82f6;
            --primary-light: #dbeafe;
            --primary-dark: #1d4ed8;
            --text-color: #1e293b;
            --light-bg: #f0f9ff;
        }
        
        body {
            background-color: var(--light-bg);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 20px;
            color: var(--text-color);
        }
        
        .header-container {
            position: relative;
            border-radius: 15px;
            overflow: hidden;
            margin-bottom: 40px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            background: linear-gradient(135deg, #1e3a8a, #3b82f6);
            color: white;
            padding: 0;
            text-align: center;
        }
        
        .logo-container {
            background: rgba(255, 255, 255, 0.1);
            padding: 25px 0;
            backdrop-filter: blur(5px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .logo {
            height: 60px;
            width: auto;
            margin: 0 auto;
            filter: drop-shadow(0 2px 10px rgba(0, 0, 0, 0.3));
            transition: transform 0.3s ease;
        }
        
        .logo:hover {
            transform: scale(1.05);
        }
        
        .time-content {
            padding: 40px 20px;
            position: relative;
            z-index: 1;
        }
        
        .time-display {
            font-size: 4rem;
            font-weight: 700;
            margin: 0;
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
            text-shadow: 0 2px 4px rgba(0,0,0,0.3);
            letter-spacing: 1px;
        }
        
        .date-display {
            font-size: 1.5rem;
            opacity: 0.9;
            margin: 15px 0 25px;
            text-shadow: 0 1px 3px rgba(0,0,0,0.3);
            font-weight: 400;
        }
        
        .greeting {
            font-size: 1.8rem;
            font-weight: 500;
            text-shadow: 0 1px 3px rgba(0,0,0,0.3);
            margin: 0;
            padding: 15px 30px;
            display: inline-block;
            background: rgba(255, 255, 255, 0.15);
            border-radius: 50px;
            backdrop-filter: blur(5px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .decoration {
            position: absolute;
            width: 300px;
            height: 300px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0) 70%);
        }
        
        .decoration-1 {
            top: -150px;
            right: -100px;
            width: 400px;
            height: 400px;
        }
        
        .decoration-2 {
            bottom: -100px;
            left: -50px;
            width: 300px;
            height: 300px;
        }
        
        .info-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(59, 130, 246, 0.1);
            padding: 25px;
            margin-bottom: 25px;
            border-top: 3px solid var(--primary-color);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .info-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(59, 130, 246, 0.15);
        }
        
        .info-label {
            font-weight: 600;
            color: var(--primary-dark);
        }
        
        h2, h4 {
            color: var(--primary-dark);
            font-weight: 700;
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        .btn-primary:hover {
            background-color: var(--primary-dark);
            border-color: var(--primary-dark);
        }
        
        .text-primary {
            color: var(--primary-color) !important;
        }
        
        .list-group-item:hover {
            background-color: var(--primary-light);
        }
        
        hr {
            border-top: 2px solid var(--primary-light);
            opacity: 0.7;
        }
    </style>
</head>
<body>
    <jsp:include page="/includes/recruiter_slidebar.jsp" />
    <div class="container py-4">
        <!-- Logo and Time Header -->
        <div class="header-container">
            <!-- Decorative Elements -->
            <div class="decoration decoration-1"></div>
            <div class="decoration decoration-2"></div>
            
            <!-- Logo Section -->
            <div class="logo-container">
                <img src="https://www.freepnglogos.com/uploads/company-logo-png/company-logo-transparent-png-19.png" 
                     alt="Company Logo" 
                     class="logo"
                     onerror="this.onerror=null; this.src='assets/img/logo.png';">
            </div>
            
            <!-- Time and Greeting Section -->
            <div class="time-content">
                <div class="time-display" id="current-time">
                    <fmt:formatDate value="<%= new java.util.Date() %>" pattern="HH:mm:ss" />
                </div>
                <div class="date-display">
                    <fmt:formatDate value="<%= new java.util.Date() %>" pattern="EEEE, d MMMM yyyy" />
                </div>
                <div class="greeting" id="greeting">
                    Chào mừng bạn đã quay trở lại!
                </div>
            </div>
        </div>
        
        <script>
            // Update time every second
            function updateTime() {
                const now = new Date();
                const timeElement = document.getElementById('current-time');
                
                // Format time as HH:MM:SS
                const hours = String(now.getHours()).padStart(2, '0');
                const minutes = String(now.getMinutes()).padStart(2, '0');
                const seconds = String(now.getSeconds()).padStart(2, '0');
                timeElement.textContent = `${hours}:${minutes}:${seconds}`;
                
                // Update greeting based on time of day
                const greetingElement = document.getElementById('greeting');
                const hour = now.getHours();
                let greeting = '';
                
                if (hour < 12) {
                    greeting = 'Chào buổi sáng tốt lành!';
                } else if (hour < 18) {
                    greeting = 'Chào buổi chiều vui vẻ!';
                } else {
                    greeting = 'Chào buổi tối an lành!';
                }
                
                greetingElement.textContent = greeting;
            }
            
            // Update time immediately and then every second
            updateTime();
            setInterval(updateTime, 1000);
        </script>

        <div class="row">
            <!-- Left Column -->
            <div class="col-md-8">
                <!-- Company Information -->
                <div class="info-card">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h4 class="mb-0"><i class="fas fa-building me-2 text-primary"></i>Thông tin công ty</h4>
                        <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#editCompanyModal">
                            <i class="fas fa-edit me-1"></i> Chỉnh sửa
                        </button>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-md-6">
                            <p><strong>Tên công ty: </strong>${sessionScope.company.company_name} </p>
                            <p><strong>Địa chỉ:</strong> ${not empty sessionScope.company.location ? sessionScope.company.location : 'Chưa cập nhật'}</p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>Ngày thành lập:</strong> ${not empty sessionScope.company.established_on ? sessionScope.company.established_on : 'Chưa cập nhật'}</p>
                            
                            <p><strong>Website: ${sessionScope.company.website}</strong> 
                                
                            </p>
                        </div>
                    </div>
                    <div class="mt-3">
                        <h5>Mô tả công ty</h5>
                        <p class="text-justify">${not empty sessionScope.company.describe ? sessionScope.company.describe : 'Chưa có mô tả công ty.'}</p>
                    </div>
                </div>

                <!-- Current Job Postings -->
                <div class="info-card">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h4 class="mb-0"><i class="fas fa-briefcase me-2 text-primary"></i>Tin tuyển dụng đang được đăng</h4>
                        <a href="recruiter_postJob.jsp" class="btn btn-sm btn-outline-primary"><i class="fas fa-plus me-1"></i> Đăng tin mới</a>
                    </div>
                    <hr>
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Vị trí</th>
                                    <th>Ngày đăng</th>
                                    <th>Hạn nộp</th>
                                    <th>Trạng thái</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${not empty sessionScope.post}">
                                        <c:forEach items="${sessionScope.post}" var="post">
                                            <tr>
                                                <td>${post.title}</td>
                                                <td><fmt:formatDate value="${post.datePost}" pattern="dd/MM/yyyy"/></td>
                                                <td><fmt:formatDate value="${post.expiredDate}" pattern="dd/MM/yyyy"/></td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${post.statusPost eq 'Approved'}">
                                                            <span class="badge bg-success">Đang hiển thị</span>
                                                        </c:when>
                                                        <c:when test="${post.statusPost eq 'Pending'}">
                                                            <span class="badge bg-warning">Chờ duyệt</span>
                                                        </c:when>
                                                        <c:when test="${post.statusPost eq 'Rejected'}">
                                                            <span class="badge bg-danger">Từ chối</span>
                                                        </c:when>
                                                        <c:when test="${post.statusPost eq 'Expired'}">
                                                            <span class="badge bg-secondary">Hết hạn</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-secondary">${post.statusPost}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="6" class="text-center py-4">
                                                <i class="fas fa-inbox fa-3x text-muted mb-3"></i>
                                                <p class="text-muted">Chưa có tin tuyển dụng nào được đăng</p>
                                                <a href="create_post.jsp" class="btn btn-primary mt-2">
                                                    <i class="fas fa-plus me-1"></i> Đăng tin mới
                                                </a>
                                            </td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>

                    <!-- Add this script for edit functionality -->
                    <script>
                    function editPost(postId) {
                        // Implement edit functionality here
                        window.location.href = 'EditPost?postId=' + postId;
                    }
                    </script>
                </div>
            </div>

            <!-- Right Column -->
            <div class="col-md-4">
                <!-- Recruiter Information -->
                <div class="info-card">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h4 class="mb-0"><i class="fas fa-user-tie me-2 text-primary"></i>Thông tin cá nhân</h4>
                        <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#editRecruiterModal">
                            <i class="fas fa-edit me-1"></i> Sửa
                        </button>
                    </div>
                    <hr>
                    <div class="text-center mb-3">
                        <img src="${not empty sessionScope.recruiter.image ? sessionScope.recruiter.image : 'https://via.placeholder.com/120'}" class="rounded-circle border" alt="Avatar" width="120">
                        <h5 class="mt-2 mb-1">${not empty sessionScope.recruiter.firstName ? sessionScope.recruiter.firstName : 'Nhà tuyển dụng'} ${not empty sessionScope.recruiter.lastName ? sessionScope.recruiter.lastName : ''}</h5>
                    </div>
                    <div class="mb-3">
                        <p class="mb-1"><i class="fas fa-envelope me-2 text-muted"></i> ${not empty sessionScope.recruiter.emailContact ? sessionScope.recruiter.emailContact : 'Chưa cập nhật'}</p>
                        <p class="mb-1"><i class="fas fa-phone me-2 text-muted"></i> ${not empty sessionScope.recruiter.phoneContact ? sessionScope.recruiter.phoneContact : 'Chưa cập nhật'}</p>
                        <p class="mb-1"><i class="fas fa-venus-mars me-2 text-muted"></i> Giới tính: ${sessionScope.recruiter.gender == true ? 'Nam' : (sessionScope.recruiter.gender == false ? 'Nữ' : 'Chưa cập nhật')}</p>
                    </div>
                </div>

                <!-- Edit Recruiter Modal -->
                <div class="modal fade" id="editRecruiterModal" tabindex="-1" aria-labelledby="editRecruiterModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header bg-primary text-white">
                                <h5 class="modal-title" id="editRecruiterModalLabel">Chỉnh sửa thông tin cá nhân</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <form action="RecruiterDetailController" method="POST" enctype="multipart/form-data">
                                <input type="hidden" name="action" value="update">
                                <div class="modal-body">
                                    <!-- Avatar Preview -->
                                    <div class="text-center mb-3">
                                        <img id="avatarPreview" 
                                             src="${not empty sessionScope.recruiter.image ? sessionScope.recruiter.image : 'https://via.placeholder.com/150'}" 
                                             class="rounded-circle border" 
                                             alt="Avatar Preview" 
                                             width="150" 
                                             height="150"
                                             style="object-fit: cover;">
                                        <div class="mt-2">
                                            <label for="profileImage" class="btn btn-sm btn-outline-primary mb-0">
                                                <i class="fas fa-camera me-1"></i> Chọn ảnh
                                                <input type="file" 
                                                       id="profileImage" 
                                                       name="profileImage" 
                                                       accept="image/*" 
                                                       class="d-none" 
                                                       onchange="previewImage(this)">
                                            </label>
                                            <div class="form-text">Ảnh đại diện (tối đa 10MB)</div>
                                        </div>
                                    </div>
                                    <!-- Success/Error Messages -->
                                    <c:if test="${not empty requestScope.successMessage}">
                                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                                            ${requestScope.successMessage}
                                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                        </div>
                                    </c:if>
                                    <c:if test="${not empty requestScope.errorMessage}">
                                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                            ${requestScope.errorMessage}
                                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                        </div>
                                    </c:if>
                                    
                                    <div class="mb-3">
                                        <label for="firstName" class="form-label">Họ</label>
                                        <input type="text" class="form-control" id="firstName" name="firstName" 
                                               value="${sessionScope.recruiter.firstName}" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="lastName" class="form-label">Tên</label>
                                        <input type="text" class="form-control" id="lastName" name="lastName"
                                               value="${sessionScope.recruiter.lastName}" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="emailContact" class="form-label">Email liên hệ</label>
                                        <input type="email" class="form-control" id="emailContact" name="emailContact"
                                               value="${sessionScope.recruiter.emailContact}" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="phoneContact" class="form-label">Số điện thoại</label>
                                        <input type="tel" class="form-control" id="phoneContact" name="phoneContact"
                                               value="${sessionScope.recruiter.phoneContact}">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Giới tính</label>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="gender" id="genderMale" value="true" 
                                                ${sessionScope.recruiter.gender ? 'checked' : ''}>
                                            <label class="form-check-label" for="genderMale">Nam</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="gender" id="genderFemale" value="false"
                                                ${!sessionScope.recruiter.gender ? 'checked' : ''}>
                                            <label class="form-check-label" for="genderFemale">Nữ</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                    <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Account Balance -->
                <div class="info-card">
                    <h4><i class="fas fa-wallet me-2 text-primary"></i>Số dư tài khoản</h4>
                    <hr>
                    <div class="text-center py-3">
                        <h2 class="text-primary mb-2">
                            <fmt:formatNumber value="${not empty sessionScope.recruiter.money ? sessionScope.recruiter.money : 0}" 
                                          type="currency" 
                                          currencyCode="VND"
                                          pattern="#,##0.00 ¤"
                                          maxFractionDigits="0"/>
                        </h2>
                        <div class="d-grid gap-2">
                            <button class="btn btn-primary"><i class="fas fa-plus-circle me-1"></i> Nạp tiền</button>
                            <button class="btn btn-outline-primary"><i class="fas fa-exchange-alt me-1"></i> Lịch sử giao dịch</button>
                        </div>
                    </div>
                </div>

                <!-- Subscribed Services -->
                <div class="info-card">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h4 class="mb-0"><i class="fas fa-cubes me-2 text-primary"></i>Dịch vụ đang sử dụng</h4>
                        <button class="btn btn-sm btn-outline-primary"><i class="fas fa-plus me-1"></i> Thay đổi</button>
                    </div>
                    <hr>
                    <div class="list-group list-group-flush">
                        <c:choose>
                            <c:when test="${not empty sessionScope.account}">
                                <div class="list-group-item d-flex justify-content-between align-items-center">
                                    <span><i class="fas fa-check-circle text-success me-2"></i> ${sessionScope.account.tierName}</span>
                                    <span class="badge bg-primary rounded-pill">Active</span>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center text-muted py-2">
                                    <p class="mb-0">Chưa có dịch vụ nào</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

<!--                <div class="info-card">
                    <h4><i class="fas fa-bolt me-2 text-primary"></i>Thao tác nhanh</h4>
                    <hr>
                    <div class="d-grid gap-2">
                        <button class="btn btn-outline-primary text-start"><i class="fas fa-file-alt me-2"></i> Tạo tin tuyển dụng mới</button>
                        <button class="btn btn-outline-primary text-start"><i class="fas fa-search me-2"></i> Tìm kiếm ứng viên</button>
                        <button class="btn btn-outline-primary text-start"><i class="fas fa-chart-line me-2"></i> Báo cáo thống kê</button>
                        <button class="btn btn-outline-primary text-start"><i class="fas fa-cog me-2"></i> Cài đặt tài khoản</button>
                    </div>
                </div>-->
            </div>
        </div>
    </div>

    <!-- Edit Company Modal -->
    <div class="modal fade" id="editCompanyModal" tabindex="-1" aria-labelledby="editCompanyModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title" id="editCompanyModalLabel">Chỉnh sửa thông tin công ty</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="RecruiterDetailController" method="POST" id="companyForm" class="needs-validation" novalidate>
                    <input type="hidden" name="action" value="updateCompany">
                    <input type="hidden" name="companyID" value="${sessionScope.company.companyID}">
                    
                    <div class="modal-body">
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="companyName" class="form-label">Tên công ty <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="companyName" name="companyName" 
                                           value="${sessionScope.company.company_name}" required>
                                    <div class="invalid-feedback">
                                        Vui lòng nhập tên công ty.
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="website" class="form-label">Website</label>
                                    <input type="url" class="form-control" id="website" name="website" 
                                           value="${sessionScope.company.website}" placeholder="https://example.com">
                                    <div class="invalid-feedback">
                                        Vui lòng nhập địa chỉ website hợp lệ.
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="establishedDate" class="form-label">Ngày thành lập</label>
                                    <input type="date" class="form-control" id="establishedDate" name="establishedDate" 
                                           value="${sessionScope.company.established_on}">
                                </div>
                                
                                <div class="mb-3">
                                    <label for="location" class="form-label">Địa chỉ</label>
                                    <input type="text" class="form-control" id="location" name="location" 
                                           value="${sessionScope.company.location}">
                                </div>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="description" class="form-label">Mô tả công ty</label>
                            <textarea class="form-control" id="description" name="description" 
                                      rows="5">${sessionScope.company.describe}</textarea>
                        </div>
                    </div>
                    
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Preview selected image
        function previewImage(input) {
            const preview = document.getElementById('avatarPreview');
            const file = input.files[0];
            const reader = new FileReader();
            
            reader.onload = function(e) {
                preview.src = e.target.result;
            }
            
            if (file) {
                reader.readAsDataURL(file);
            }
        }
        
        // Auto-dismiss alerts after 5 seconds
        document.addEventListener('DOMContentLoaded', function() {
            // Auto-dismiss alerts
            var alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                setTimeout(function() {
                    var bsAlert = new bootstrap.Alert(alert);
                    bsAlert.close();
                }, 5000);
            });
            
            // Handle form validation on submit
            const forms = document.querySelectorAll('.needs-validation');
            
            // Loop over them and prevent submission
            Array.from(forms).forEach(form => {
                form.addEventListener('submit', event => {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    
                    form.classList.add('was-validated');
                }, false);
            });
            
            // Initialize date picker for established date
            const establishedDate = document.getElementById('establishedDate');
            if (establishedDate && !establishedDate.value) {
                // Set default date to today if empty
                const today = new Date().toISOString().split('T')[0];
                establishedDate.value = today;
            }
            
            // Handle modal show event to clear form validation
            const modals = ['editRecruiterModal', 'editCompanyModal'];
            modals.forEach(modalId => {
                const modal = document.getElementById(modalId);
                if (modal) {
                    modal.addEventListener('show.bs.modal', function() {
                        const form = this.querySelector('.needs-validation');
                        if (form) {
                            form.classList.remove('was-validated');
                        }
                    });
                }
            });
            
            // Add custom validation for website URL format
            const websiteInput = document.getElementById('website');
            if (websiteInput) {
                websiteInput.addEventListener('input', function() {
                    if (this.value === '') {
                        this.setCustomValidity('');
                        return;
                    }
                    
                    try {
                        new URL(this.value);
                        this.setCustomValidity('');
                    } catch (_) {
                        this.setCustomValidity('Vui lòng nhập địa chỉ website hợp lệ (bắt đầu bằng http:// hoặc https://)');
                    }
                });
            }
        });
    </script>
</body>
</html>
