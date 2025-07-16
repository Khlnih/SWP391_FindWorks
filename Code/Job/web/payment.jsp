<%-- 
    Document   : payment.jsp
    Created on : 6 Mar 2025, 4:28:59 pm
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh Toán - FindWorks</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4361ee;
            --primary-light: #eef2ff;
            --success: #22c55e;
            --danger: #ef4444;
            --dark: #1e293b;
            --gray: #64748b;
            --light: #f8fafc;
            --border-radius: 12px;
            --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }
        
        body {
            background-color: #f1f5f9;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            padding: 2rem 0;
        }
        
        .payment-card {
            max-width: 500px;
            margin: 0 auto;
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            overflow: hidden;
            border: 1px solid #e2e8f0;
        }
        
        .payment-header {
            background: linear-gradient(135deg, var(--primary), #3f37c9);
            color: white;
            padding: 1.5rem;
            text-align: center;
        }
        
        .payment-body {
            padding: 2rem;
        }
        
        .amount-input {
            position: relative;
            margin-bottom: 1.5rem;
        }
        
        .amount-input .input-group-text {
            background-color: var(--primary-light);
            color: var(--primary);
            font-weight: 600;
            border: 2px solid #e2e8f0;
            border-right: none;
        }
        
        .amount-input .form-control {
            border-left: none;
            border: 2px solid #e2e8f0;
            padding: 0.75rem 1rem;
            font-size: 1.1rem;
            font-weight: 500;
        }
        
        .amount-input .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 0.25rem rgba(67, 97, 238, 0.15);
        }
        
        .btn-payment {
            background: linear-gradient(135deg, var(--primary), #3f37c9);
            border: none;
            padding: 0.875rem 1.5rem;
            font-weight: 600;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
            width: 100%;
            margin-top: 1rem;
        }
        
        .btn-payment:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(67, 97, 238, 0.3);
        }
        
        .btn-payment:active {
            transform: translateY(0);
        }
        
        .form-text {
            color: var(--gray);
            font-size: 0.875rem;
            margin-top: 0.5rem;
        }
        
        .payment-methods {
            margin: 1.5rem 0;
            border: 1px solid #e2e8f0;
            border-radius: var(--border-radius);
            overflow: hidden;
        }
        
        .payment-method {
            padding: 1rem;
            border-bottom: 1px solid #e2e8f0;
            cursor: pointer;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
        }
        
        .payment-method:last-child {
            border-bottom: none;
        }
        
        .payment-method:hover {
            background-color: var(--primary-light);
        }
        
        .payment-method.active {
            background-color: var(--primary-light);
            border-left: 3px solid var(--primary);
        }
        
        .payment-method-icon {
            width: 40px;
            height: 40px;
            border-radius: 8px;
            background-color: #e2e8f0;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
            color: var(--primary);
            font-size: 1.25rem;
        }
        
        .payment-method-info {
            flex: 1;
        }
        
        .payment-method-title {
            font-weight: 600;
            margin-bottom: 0.25rem;
            color: var(--dark);
        }
        
        .payment-method-desc {
            font-size: 0.875rem;
            color: var(--gray);
        }
        
        .payment-amount {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary);
            text-align: center;
            margin: 1.5rem 0;
        }
        
        .alert {
            border-radius: var(--border-radius);
            border: none;
            box-shadow: var(--shadow);
        }
        
        @media (max-width: 576px) {
            .payment-card {
                margin: 0 1rem;
            }
            
            .payment-body {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="payment-card">
            <div class="payment-header">
                <h3 class="mb-0"><i class="fas fa-credit-card me-2"></i>Thanh Toán</h3>
            </div>
            
            <div class="payment-body">
                <form id="paymentForm" action="payment" method="post">
                    <!-- Hidden inputs -->
                    <c:if test="${sessionScope.jobseeker != null}">
                        <input type="hidden" name="jobseekerID" value="${sessionScope.jobseeker.freelancerID}">
                    </c:if>
                    <c:if test="${sessionScope.recruiter != null}">
                        <input type="hidden" name="recruiterID" value="${sessionScope.recruiter.recruiterID}">
                    </c:if>
                    
                    <!-- Amount Input -->
                    <div class="mb-4">
                        <label for="amount" class="form-label">Số tiền thanh toán (VNĐ)</label>
                        <div class="input-group">
                            <span class="input-group-text">₫</span>
                            <input type="number" 
                                   class="form-control form-control-lg" 
                                   id="amount" 
                                   name="totalBill" 
                                   min="10000" 
                                   step="1000" 
                                   placeholder="Nhập số tiền" 
                                   required>
                        </div>
                        <div class="form-text">Số tiền tối thiểu: 10,000 VNĐ</div>
                    </div>
                    
                    
                    </div>
                    
                    <!-- Display Amount -->
                    <div class="payment-amount d-none">
                        <div class="text-muted small">Tổng thanh toán</div>
                        <div id="displayAmount">0 VNĐ</div>
                    </div>
                    
                    <!-- Submit Button -->
                    <button type="submit" class="btn btn-primary btn-payment" id="submitBtn">
                        <i class="fas fa-credit-card me-2"></i>Thanh toán
                    </button>
                </form>
            </div>
        </div>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            // Format amount input
            $('#amount').on('input', function() {
                let value = $(this).val().replace(/\D/g, '');
                $(this).val(value);
                
                // Update display amount
                if (value >= 10000) {
                    $('.payment-amount').removeClass('d-none');
                    $('#displayAmount').text(formatCurrency(value) + ' VNĐ');
                } else {
                    $('.payment-amount').addClass('d-none');
                }
            });
            
            // Handle payment method selection
            $('.payment-method').click(function() {
                $('.payment-method').removeClass('active')
                    .find('.fa-circle')
                    .removeClass('fa-check-circle text-success')
                    .addClass('far fa-circle text-muted');
                
                $(this).addClass('active')
                    .find('.fa-circle')
                    .removeClass('far fa-circle text-muted')
                    .addClass('fas fa-check-circle text-success');
                
                $('#paymentMethod').val($(this).data('payment'));
            });
            
            // Form submission
            $('#paymentForm').on('submit', function(e) {
                const amount = parseInt($('#amount').val()) || 0;
                
                if (amount < 10000) {
                    e.preventDefault();
                    showAlert('Vui lòng nhập số tiền tối thiểu 10,000 VNĐ', 'warning');
                    return false;
                }
                
                // Show loading state
                const submitBtn = $('#submitBtn');
                const originalBtnText = submitBtn.html();
                submitBtn.prop('disabled', true);
                submitBtn.html('<span class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>Đang xử lý...');
                
                return true;
            });
            
            // Format currency
            function formatCurrency(amount) {
                return new Intl.NumberFormat('vi-VN').format(amount);
            }
            
            // Show alert message
            function showAlert(message, type = 'danger') {
                const alert = $(`
                    <div class="alert alert-${type} alert-dismissible fade show" role="alert">
                        ${message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                `);
                
                $('.payment-body').prepend(alert);
                
                // Auto dismiss after 5 seconds
                setTimeout(() => {
                    alert.alert('close');
                }, 5000);
            }
        });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
