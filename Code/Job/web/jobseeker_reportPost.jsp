<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Báo cáo bài đăng - FindWorks</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #4e73df;
            --secondary-color: #f8f9fc;
            --success-color: #1cc88a;
            --info-color: #36b9cc;
            --warning-color: #f6c23e;
            --danger-color: #e74a3b;
        }
        
        body {
            background-color: #f8f9fc;
            font-family: 'Nunito', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
        }
        
        .report-container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 0 15px;
        }
        
        .report-card {
            background: white;
            border-radius: 0.5rem;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
            margin-bottom: 1.5rem;
            padding: 1.5rem;
        }
        
        .report-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid #e3e6f0;
        }
        
        .report-header h2 {
            color: var(--primary-color);
            font-weight: 600;
            margin: 0;
            font-size: 1.5rem;
        }
        
        .job-info {
            margin-bottom: 1.5rem;
        }
        
        .job-info h4 {
            color: #5a5c69;
            margin-bottom: 1rem;
        }
        
        .job-detail {
            background-color: #f8f9fc;
            border-radius: 0.35rem;
            padding: 1rem;
            margin-bottom: 1rem;
        }
        
        .job-detail p {
            margin-bottom: 0.5rem;
            color: #5a5c69;
        }
        
        .form-label {
            font-weight: 600;
            color: #5a5c69;
            margin-bottom: 0.5rem;
        }
        
        .form-control, .form-select {
            border-radius: 0.35rem;
            padding: 0.5rem 0.75rem;
            border: 1px solid #d1d3e2;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: #bac8f3;
            box-shadow: 0 0 0 0.2rem rgba(78, 115, 223, 0.25);
        }
        
        .form-check-input {
            margin-top: 0.2rem;
        }
        
        .form-check-label {
            margin-left: 0.5rem;
            color: #5a5c69;
        }
        
        .btn-submit {
            background-color: var(--danger-color);
            border: none;
            padding: 0.5rem 1.5rem;
            font-weight: 600;
            border-radius: 0.35rem;
            color: white;
            transition: all 0.3s;
        }
        
        .btn-submit:hover {
            background-color: #c0392b;
            transform: translateY(-1px);
        }
        
        .btn-cancel {
            background-color: #858796;
            color: white;
            border: none;
            padding: 0.5rem 1.5rem;
            font-weight: 600;
            border-radius: 0.35rem;
            margin-right: 0.5rem;
            transition: all 0.3s;
        }
        
        .btn-cancel:hover {
            background-color: #6c757d;
            color: white;
        }
        
        .alert {
            border-radius: 0.35rem;
            margin-bottom: 1.5rem;
        }
        
        .required-field::after {
            content: " *";
            color: var(--danger-color);
        }
        
        @media (max-width: 768px) {
            .report-container {
                margin: 1rem auto;
                padding: 0 10px;
            }
            
            .report-header {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .report-header h2 {
                margin-bottom: 1rem;
            }
            
            .btn-container {
                display: flex;
                flex-direction: column;
                gap: 0.5rem;
            }
            
            .btn-cancel, .btn-submit {
                width: 100%;
                margin: 0;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/includes/jobseeker_sidebar.jsp" />
    
    <div class="report-container">
        <div class="report-card">
            <div class="report-header">
                <h2><i class="fas fa-flag me-2"></i>Báo cáo bài đăng</h2>
            </div>
            
            
            <div class="job-info">
                <h4>Thông tin bài đăng</h4>
                <div class="job-detail">
                    <p><strong>Tiêu đề:</strong> ${post.title}</p>
                    <p class="mb-2">
                        <strong class="text-muted">Số lượng:</strong> 
                        <span class="badge bg-primary bg-opacity-10 text-primary fw-medium">
                            <i class="fas fa-users me-1"></i>
                            ${post.quantity} người
                        </span>
                    </p>
                    <p class="mb-2">
                        <strong class="text-muted">Ngân sách:</strong> 
                        <span class="badge bg-success bg-opacity-10 text-success fw-medium">
                            <i class="fas fa-coins me-1"></i>
                            <fmt:formatNumber value="${post.budgetMin}" type="number" maxFractionDigits="0" /> 
                            - 
                            <fmt:formatNumber value="${post.budgetMax}" type="number" maxFractionDigits="0" /> VNĐ
                        </span>
                    </p>
                    <p class="mb-0">
                        <strong class="text-muted">Ngày đăng:</strong> 
                        <span class="badge bg-secondary bg-opacity-10 text-secondary fw-medium">
                            <i class="far fa-calendar-alt me-1"></i>
                            <fmt:formatDate value="${post.datePost}" pattern="dd/MM/yyyy" />
                        </span>
                    </p>
                </div>
            </div>
            
            <form action="ffavoriteController" method="POST">
                <input type="hidden" name="action" value="submitReport">
                <input type="hidden" name="jobseekerID" value="${jobseeker.getFreelancerID()}">
                <input type="hidden" name="postId" value="${post.postId}">
                
                <div class="mb-4">
                    <label class="form-label required-field">Lý do báo cáo</label>
                    <p class="text-muted mb-3">Vui lòng chọn lý do báo cáo bài đăng này</p>
                    
                    <div class="form-check mb-2">
                        <input class="form-check-input" type="radio" name="reason" id="reason1" value="Thông tin không chính xác" required>
                        <label class="form-check-label" for="reason1">
                            Thông tin không chính xác
                        </label>
                    </div>
                    
                    <div class="form-check mb-2">
                        <input class="form-check-input" type="radio" name="reason" id="reason2" value="Nội dung lừa đảo">
                        <label class="form-check-label" for="reason2">
                            Nội dung lừa đảo
                        </label>
                    </div>
                    
                    <div class="form-check mb-2">
                        <input class="form-check-input" type="radio" name="reason" id="reason3" value="Nội dung không phù hợp">
                        <label class="form-check-label" for="reason3">
                            Nội dung không phù hợp
                        </label>
                    </div>
                    
                    <div class="form-check mb-2">
                        <input class="form-check-input" type="radio" name="reason" id="reason4" value="Đã hết hạn">
                        <label class="form-check-label" for="reason4">
                            Đã hết hạn
                        </label>
                    </div>
                    
                    <div class="form-check mb-2">
                        <input class="form-check-input" type="radio" name="reason" id="reason5" value="Lý do khác">
                        <label class="form-check-label" for="reason5">
                            Lý do khác
                        </label>
                    </div>
                </div>
                
                <div class="mb-4" id="otherReasonDiv" style="display: none;">
                    <label for="otherReason" class="form-label">Mô tả chi tiết</label>
                    <textarea class="form-control" id="otherReason" name="otherReason" rows="4" 
                              placeholder="Vui lòng mô tả lý do báo cáo chi tiết..."></textarea>
                </div>
                
                <div class="d-flex justify-content-end mt-4">
                    <a href="javascript:history.back()" class="btn btn-cancel">
                        <i class="fas fa-times me-1"></i> Hủy
                    </a>
                    <button type="submit" class="btn btn-submit">
                        <i class="fas fa-paper-plane me-1"></i> Gửi báo cáo
                    </button>
                </div>
            </form>
        </div>
    </div>
    
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Custom Scripts -->
    <script>
        // Show/hide other reason textarea
        document.addEventListener('DOMContentLoaded', function() {
            const reasonInputs = document.querySelectorAll('input[name="reason"]');
            const otherReasonDiv = document.getElementById('otherReasonDiv');
            const otherReasonInput = document.getElementById('otherReason');
            
            reasonInputs.forEach(input => {
                input.addEventListener('change', function() {
                    if (this.value === 'Lý do khác') {
                        otherReasonDiv.style.display = 'block';
                        otherReasonInput.required = true;
                    } else {
                        otherReasonDiv.style.display = 'none';
                        otherReasonInput.required = false;
                    }
                });
            });
            
            // Check if other reason was previously selected (after form validation)
            const selectedReason = document.querySelector('input[name="reason"]:checked');
            if (selectedReason && selectedReason.value === 'Lý do khác') {
                otherReasonDiv.style.display = 'block';
                otherReasonInput.required = true;
            }
            
            // Auto-dismiss alerts after 5 seconds
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                setTimeout(() => {
                    const bsAlert = new bootstrap.Alert(alert);
                    bsAlert.close();
                }, 5000);
            });
        });
    </script>
</body>
</html>
