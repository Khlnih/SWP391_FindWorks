<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng tin tuyển dụng - FindWorks</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            margin-left: 280px;
            transition: margin 0.3s ease;
        }
        .form-container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            padding: 30px;
            margin: 30px;
        }
        @media (max-width: 992px) {
            body { margin-left: 0; }
            .form-container { margin: 15px; }
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <jsp:include page="/includes/recruiter_slidebar.jsp" />
    
    <!-- Main Content -->
    <div class="main-content">
        <div class="container-fluid py-4">
            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <div class="form-container">
                        <h3><i class="fas fa-briefcase me-2 text-primary"></i>Đăng tin tuyển dụng mới</h3>
                        <p class="text-muted">Điền đầy đủ thông tin bên dưới để đăng tin tuyển dụng</p>
                        
                        <form action="RecruiterDetailController" method="POST" enctype="multipart/form-data" id="postJobForm">
                            <input type="hidden" name="recruiterID" value="${sessionScope.recruiter.recruiterID}">
                            <div class="mb-4">
                                <label for="title" class="form-label fw-bold">Tiêu đề công việc <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="title" name="title" required>
                            </div>
                            

                            <!-- Job Type -->
                            <div class="mb-4">
                                <label for="jobTypeId" class="form-label fw-bold">Loại công việc <span class="text-danger">*</span></label>
                                <select class="form-select" id="jobTypeId" name="jobTypeId" required>
                                    <option value="">-- Chọn loại công việc --</option>
                                    <c:forEach items="${sessionScope.jobType}" var="cat">
                                        <option value="${cat.jobTypeID}">${cat.jobTypeName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <!-- Duration -->
                            <div class="mb-4">
                                <label for="durationId" class="form-label fw-bold">Thời hạn công việc <span class="text-danger">*</span></label>
                                <select class="form-select" id="durationId" name="durationId" required>
                                    <option value="">-- Chọn thời hạn --</option>
                                    <c:forEach items="${sessionScope.durations}" var="cat">
                                        <option value="${cat.durationID}">${cat.durationName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <!-- Posting Date & Expiry Date -->
                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <label for="datePost" class="form-label fw-bold">Ngày bắt đầu đăng tuyển <span class="text-danger">*</span></label>
                                    <input type="date" class="form-control" id="datePost" name="datePost" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="expiredDate" class="form-label fw-bold">Ngày kết thúc <span class="text-danger">*</span></label>
                                    <input type="date" class="form-control" id="expiredDate" name="expiredDate" required>
                                </div>
                            </div>
                            
                            <!-- Quantity -->
                            <div class="mb-4">
                                <label for="quantity" class="form-label fw-bold">Số lượng tuyển dụng <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" id="quantity" name="quantity" min="1" required>
                            </div>
                            
                            <!-- Budget Range -->
                            <div class="mb-4">
                                <label class="form-label fw-bold">Mức lương</label>
                                <div class="row g-2">
                                    <div class="col-md-5">
                                        <div class="input-group">
                                            <input type="number" step="0.01" class="form-control" id="budgetMin" name="budgetMin" placeholder="Tối thiểu">
                                            <span class="input-group-text">-</span>
                                            <input type="number" step="0.01" class="form-control" id="budgetMax" name="budgetMax" placeholder="Tối đa">
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <select class="form-select" id="budgetType" name="budgetType">
                                            <option value="Fixed">Fixed</option>
                                            <option value="Hourly">Hourly</option>
                                            <option value="Per Article">Per Article</option>
                                            <option value="Range">Range</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-text">Để trống nếu thỏa thuận lương</div>
                            </div>
                            
                            <!-- Location -->
                            <div class="mb-4">
                                <label for="location" class="form-label fw-bold">Địa điểm làm việc <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="location" name="location" required>
                                <div class="form-text">Ví dụ: Hà Nội, TP.HCM, hoặc 'Làm việc từ xa'</div>
                            </div>
                            
                            <!-- Job Category -->
                            <div class="mb-4">
                                <label for="categoryId" class="form-label fw-bold">Danh mục công việc <span class="text-danger">*</span></label>
                                <select class="form-select" id="categoryId" name="categoryId" required>
                                    <option value="">-- Chọn danh mục --</option>
                                    <c:forEach items="${sessionScope.category}" var="cat">
                                        <option value="${cat.categoryID}">${cat.categoryName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <!-- Job Description -->
                            <div class="mb-4">
                                <label for="description" class="form-label fw-bold">Mô tả công việc <span class="text-danger">*</span></label>
                                <textarea class="form-control" id="description" name="description" rows="10" required placeholder="Nhập mô tả công việc..."></textarea>
                            </div>
                            
                            <!-- Submit Button -->
                            <div class="d-flex justify-content-between mt-5">
                                <button type="button" class="btn btn-outline-secondary" onclick="history.back()">
                                    <i class="fas fa-arrow-left me-2"></i>Quay lại
                                </button>
                                <div>
                                    
                                    <button type="submit" name="action" value="createJob" class="btn btn-primary">
                                        <i class="fas fa-paper-plane me-2"></i>Đăng tin ngay
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Simple textarea for job description -->
    <style>
        /* Style for the textarea */
        #description {
            width: 100%;
            min-height: 200px;
            padding: 10px;
            border: 1px solid #ced4da;
            border-radius: 4px;
        }
    </style>
    
    <script>
        // Simple textarea initialization
        document.addEventListener('DOMContentLoaded', function() {
            
            // Set default dates
            const today = new Date();
            const tomorrow = new Date(today);
            tomorrow.setDate(tomorrow.getDate() + 1);
            
            // Format dates as YYYY-MM-DD
            const formatDate = (date) => date.toISOString().split('T')[0];
            
            // Set default start date to today and end date to tomorrow
            document.getElementById('datePost').value = formatDate(today);
            document.getElementById('datePost').min = formatDate(today);
            
            document.getElementById('expiredDate').min = formatDate(tomorrow);
            
            // Update min end date when start date changes
            document.getElementById('datePost').addEventListener('change', function() {
                const startDate = new Date(this.value);
                startDate.setDate(startDate.getDate() + 1); // Min end date is start date + 1 day
                document.getElementById('expiredDate').min = formatDate(startDate);
                
                // Adjust end date if it's before the new min date
                const endDateInput = document.getElementById('expiredDate');
                if (new Date(endDateInput.value) < startDate) {
                    endDateInput.value = formatDate(startDate);
                }
            });
            
            // Form validation
            document.getElementById('postJobForm').addEventListener('submit', function(e) {
                // Check if CKEditor instances have content
                for (instance in CKEDITOR.instances) {
                    CKEDITOR.instances[instance].updateElement();
                }
                
                // Check if description and requirements are not empty after removing HTML tags
                const description = document.getElementById('description').value.replace(/<[^>]*>/g, '').trim();
                const requirements = document.getElementById('requirements').value.replace(/<[^>]*>/g, '').trim();
                
                if (!description) {
                    e.preventDefault();
                    alert('Vui lòng nhập mô tả công việc');
                    return false;
                }
                
                if (!requirements) {
                    e.preventDefault();
                    alert('Vui lòng nhập yêu cầu công việc');
                    return false;
                }
                
                // Validate dates
                const datePost = new Date(document.getElementById('datePost').value);
                const expiredDate = new Date(document.getElementById('expiredDate').value);
                const today = new Date();
                today.setHours(0, 0, 0, 0);
                
                if (datePost < today) {
                    e.preventDefault();
                    alert('Ngày bắt đầu không được trước ngày hiện tại');
                    return false;
                }
                
                if (expiredDate <= datePost) {
                    e.preventDefault();
                    alert('Ngày kết thúc phải sau ngày bắt đầu');
                    return false;
                }
                
                // Validate budget range if provided
                const budgetMin = document.getElementById('budgetMin').value;
                const budgetMax = document.getElementById('budgetMax').value;
                
                if (budgetMin || budgetMax) {
                    const minVal = parseFloat(budgetMin);
                    const maxVal = budgetMax ? parseFloat(budgetMax) : null;
                    
                    if (isNaN(minVal) || minVal < 0) {
                        e.preventDefault();
                        alert('Mức lương tối thiểu không hợp lệ');
                        return false;
                    }
                    
                    if (maxVal !== null && (isNaN(maxVal) || maxVal < 0 || maxVal <= minVal)) {
                        e.preventDefault();
                        alert('Mức lương tối đa phải lớn hơn mức lương tối thiểu');
                        return false;
                    }
                }
                
                // If validation passes, show loading state
                const submitButtons = document.querySelectorAll('button[type="submit"]');
                submitButtons.forEach(button => {
                    button.disabled = true;
                    button.innerHTML = '<span class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>Đang xử lý...';
                });
                
                return true;
            });
        });
        
        // Toggle sidebar on mobile
        document.addEventListener('DOMContentLoaded', function() {
            const sidebarToggle = document.querySelector('.sidebar-toggle');
            const body = document.body;
            
            if (sidebarToggle) {
                sidebarToggle.addEventListener('click', function() {
                    body.classList.toggle('sidebar-collapsed');
                });
            }
            
            // Close sidebar when clicking outside on mobile
            document.addEventListener('click', function(e) {
                if (window.innerWidth <= 991 && !e.target.closest('.sidebar') && !e.target.closest('.sidebar-toggle')) {
                    body.classList.remove('sidebar-collapsed');
                }
            });
        });
    </script>
</body>
</html>
