<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kết quả giao dịch - FindWorks</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --success: #22c55e;
            --danger: #ef4444;
            --warning: #f59e0b;
            --dark: #1e293b;
            --light: #f8fafc;
            --border-radius: 12px;
            --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }
        
        body {
            background-color: #f1f5f9;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 1rem;
        }
        
        .result-card {
            max-width: 500px;
            width: 100%;
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            overflow: hidden;
            border: none;
            text-align: center;
            padding: 2.5rem;
        }
        
        .status-icon {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            font-size: 3rem;
        }
        
        .success-icon {
            background-color: #dcfce7;
            color: var(--success);
        }
        
        .error-icon {
            background-color: #fee2e2;
            color: var(--danger);
        }
        
        .processing-icon {
            background-color: #fef3c7;
            color: var(--warning);
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        
        .result-title {
            font-size: 1.75rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }
        
        .result-message {
            color: #64748b;
            font-size: 1.1rem;
            margin-bottom: 1.5rem;
            line-height: 1.6;
        }
        
        .contact-info {
            background-color: #f8fafc;
            border-radius: var(--border-radius);
            padding: 1rem;
            margin: 1.5rem 0;
        }
        
        .phone-number {
            color: #ef4444;
            font-size: 1.5rem;
            font-weight: 700;
            margin: 0.5rem 0;
            display: inline-block;
        }
        
        .btn-back {
            background: #3b82f6;
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            font-weight: 600;
            margin-top: 1.5rem;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }
        
        .btn-back:hover {
            background: #2563eb;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
            color: white;
        }
        
        .btn-back i {
            margin-right: 8px;
        }
        
        .details {
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 1px solid #e2e8f0;
            text-align: left;
        }
        
        .detail-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
            color: #64748b;
        }
        
        .detail-label {
            font-weight: 500;
        }
        
        .detail-value {
            font-weight: 600;
            color: #1e293b;
        }
        
        /* Căn giữa thời gian */
        .detail-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 0.5rem;
            color: #64748b;
            max-width: 100%;
            width: 100%;
        }
        
        .detail-label {
            font-weight: 500;
            min-width: 100px;
            text-align: left;
        }
        
        .current-time-display {
            flex: 1;
            text-align: right;
            padding-left: 10px;
        }
    </style>
</head>
<body>
    <div class="container" style="padding: 100px 100px 100px 450px  ">
        <div class="result-card">
            <!-- Giao dịch thành công -->
            <c:if test="${transResult}">
                <div class="status-icon success-icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <h1 class="result-title text-success">Giao dịch thành công!</h1>
                <p class="result-message">Cảm ơn bạn đã sử dụng dịch vụ của chúng tôi. Đơn hàng của bạn đã được xử lý thành công.</p>
                
                <div class="contact-info">
                    <p class="mb-2">Vui lòng để ý số điện thoại của nhân viên tư vấn:</p>
                    <div class="phone-number">
                        <i class="fas fa-phone-alt me-2"></i>0383459560
                    </div>
                </div>
                
                <div class="details">
                    
                    <div class="detail-item">
                        <span class="detail-label">Số tiền:</span>
                        <span class="detail-value">${amount} VNĐ</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Thời gian:</span>
                        <span class="detail-value current-time-display"></span>
                    </div>
                </div>
                <c:if test="${sessionScope.jobseeker != null}">
                    <a href="index.jsp" class="btn-back">
                        <i class="fas fa-home"></i> Về trang chủ
                    </a>
                </c:if>
                <c:if test="${sessionScope.recruiter != null}">
                    <a href="index_recruiter.jsp" class="btn-back">
                        <i class="fas fa-home"></i> Về trang chủ
                    </a>
                </c:if>
                
            </c:if>

            <!-- Giao dịch thất bại -->
            <c:if test="${transResult == false}">
                <div class="status-icon error-icon">
                    <i class="fas fa-times-circle"></i>
                </div>
                <h1 class="result-title text-danger">Giao dịch thất bại</h1>
                <p class="result-message">Rất tiếc, đã xảy ra lỗi trong quá trình xử lý giao dịch của bạn.</p>
                
                <div class="contact-info">
                    <p class="mb-2">Vui lòng liên hệ tổng đài để được hỗ trợ:</p>
                    <div class="phone-number">
                        <i class="fas fa-phone-alt me-2"></i>0383456xxx
                    </div>
                </div>
                
                <div class="details">
                    
                    <div class="detail-item">
                        <span class="detail-label">Thời gian:</span>
                        <span class="detail-value current-time-display"></span>
                    </div>
                </div>
                
                <c:if test="${sessionScope.jobseeker != null}">
                    <a href="index.jsp" class="btn-back">
                        <i class="fas fa-home"></i> Về trang chủ
                    </a>
                </c:if>
                <c:if test="${sessionScope.recruiter != null}">
                    <a href="index_recruiter.jsp" class="btn-back">
                        <i class="fas fa-home"></i> Về trang chủ
                    </a>
                </c:if>
            </c:if>

            <!-- Đang xử lý giao dịch -->
            <c:if test="${transResult == null}">
                <div class="status-icon processing-icon">
                    <i class="fas fa-sync-alt fa-spin"></i>
                </div>
                <h1 class="result-title text-warning">Đang xử lý giao dịch</h1>
                <p class="result-message">Chúng tôi đã nhận được yêu cầu của bạn và đang xử lý. Vui lòng chờ trong giây lát.</p>
                
                <div class="contact-info">
                    <p class="mb-2">Nếu cần hỗ trợ, vui lòng liên hệ:</p>
                    <div class="phone-number">
                        <i class="fas fa-phone-alt me-2"></i>0383456xxx
                    </div>
                </div>
                
                <div class="details">
                    <div class="detail-item">
                        <span class="detail-label">Mã giao dịch:</span>
                        <span class="detail-value">#${transactionId}</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Số tiền:</span>
                        <span class="detail-value">${amount} VNĐ</span>
                    </div>
                </div>
                
                <div class="d-flex justify-content-center gap-3 mt-4">
                    <a href="home" class="btn-back">
                        <i class="fas fa-home"></i> Về trang chủ
                    </a>
                    <a href="#" class="btn-back" style="background-color: #e2e8f0; color: #1e293b;">
                        <i class="fas fa-redo"></i> Tải lại
                    </a>
                </div>
                
                <script>
                    // Tự động tải lại trang sau 5 giây
                    setTimeout(function() {
                        window.location.reload();
                    }, 5000);
                </script>
            </c:if>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Hiển thị thời gian hiện tại khi trang tải
        function updateTimeDisplays() {
            const now = new Date();
            const options = { 
                year: 'numeric', 
                month: '2-digit', 
                day: '2-digit',
                hour: '2-digit',
                minute: '2-digit',
                second: '2-digit',
                hour12: false
            };
            
            // Cập nhật tất cả các phần tử hiển thị thời gian
            document.querySelectorAll('.current-time-display').forEach(element => {
                element.textContent = now.toLocaleString('vi-VN', options);
            });
        }
        
        // Gọi hàm khi trang tải xong
        document.addEventListener('DOMContentLoaded', updateTimeDisplays);
    </script>
</body>
</html>
