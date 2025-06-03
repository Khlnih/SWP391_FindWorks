<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Gói Tài Khoản Mới</title>
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
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        
        .container {
            padding: 2rem;
            max-width: 900px;
            margin: 0 auto;
            flex: 1;
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
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            border-radius: 2px;
        }
        
        .card {
            border: none;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            margin-bottom: 2rem;
            overflow: hidden;
            background: white;
        }
        
        .card-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            font-weight: 600;
            padding: 1.25rem 1.5rem;
            border-bottom: none;
        }
        
        .card-body {
            padding: 2rem;
        }
        
        .form-label {
            font-weight: 600;
            color: var(--dark-text);
            margin-bottom: 0.5rem;
        }
        
        .form-control, .form-select {
            border: 1px solid #e1e5ee;
            border-radius: var(--border-radius);
            padding: 0.6rem 1rem;
            transition: var(--transition);
            height: auto;
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
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            border: none;
        }
        
        .btn-primary:hover {
            background-color: var(--secondary-color);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        
        .btn-outline-secondary {
            border: 1px solid #dee2e6;
            color: var(--dark-text);
        }
        
        .btn-outline-secondary:hover {
            background-color: #f8f9fa;
            border-color: #dee2e6;
            color: var(--dark-text);
        }
        
        .form-text {
            color: var(--light-text);
            font-size: 0.8rem;
        }
        
        .back-link {
            display: inline-flex;
            align-items: center;
            color: var(--primary-color);
            text-decoration: none;
            margin-bottom: 1.5rem;
            font-weight: 500;
            transition: var(--transition);
        }
        
        .back-link:hover {
            color: var(--secondary-color);
            text-decoration: none;
        }
        
        .back-link i {
            margin-right: 0.5rem;
            transition: var(--transition);
        }
        
        .form-section {
            background: white;
            border-radius: var(--border-radius);
            padding: 2rem;
            box-shadow: var(--box-shadow);
        }
        
        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
            margin-top: 2rem;
            padding-top: 1.5rem;
            border-top: 1px solid #eee;
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="admin_accountTier" class="back-link">
            <i class="fas fa-arrow-left"></i> Quay lại danh sách gói tài khoản
        </a>
        
        <h2 class="page-title">
            <i class="fas fa-plus-circle me-2"></i>Thêm Gói Tài Khoản Mới
        </h2>
        
        <div class="form-section">
            <form id="addTierForm" action="admin/accountTier" method="POST">
                <input type="hidden" name="action" value="add">
                
                <div class="row mb-4">
                    <div class="col-md-6 mb-3">
                        <label for="tierName" class="form-label">Tên gói <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="tierName" name="tierName" required>
                        <div class="form-text">Ví dụ: Gói Cơ Bản, Gói Cao Cấp, v.v.</div>
                    </div>
                    
                    <div class="col-md-6 mb-3">
                        <label for="price" class="form-label">Giá (VNĐ) <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="price" name="price" required>
                        <div class="form-text">Nhập số tiền (sẽ được định dạng tự động)</div>
                    </div>
                    
                    <div class="col-md-6 mb-3">
                        <label for="durationDays" class="form-label">Thời hạn (ngày) <span class="text-danger">*</span></label>
                        <input type="number" class="form-control" id="durationDays" name="durationDays" min="1" required>
                        <div class="form-text">Số ngày áp dụng gói tài khoản</div>
                    </div>
                    
                    <div class="col-md-6 mb-3">
                        <label for="userTypeScope" class="form-label">Đối tượng áp dụng <span class="text-danger">*</span></label>
                        <select class="form-select" id="userTypeScope" name="userTypeScope" required>
                            <option value="">Chọn đối tượng</option>
                            <option value="CANDIDATE">Ứng viên</option>
                            <option value="EMPLOYER">Nhà tuyển dụng</option>
                            <option value="ALL">Tất cả</option>
                        </select>
                    </div>
                    
                    <div class="col-12 mb-3">
                        <label for="description" class="form-label">Mô tả chi tiết</label>
                        <textarea class="form-control" id="description" name="description" rows="4"></textarea>
                        <div class="form-text">Mô tả các tính năng và quyền lợi của gói tài khoản</div>
                    </div>
                    
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Trạng thái</label>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="status" name="status" value="1" checked>
                            <label class="form-check-label" for="status">Kích hoạt</label>
                        </div>
                        <div class="form-text">Tắt nếu bạn muốn ẩn gói tài khoản này</div>
                    </div>
                </div>
                
                <div class="form-actions">
                    <a href="admin_accountTier" class="btn btn-outline-secondary me-2">
                        <i class="fas fa-times me-1"></i> Hủy
                    </a>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save me-1"></i> Lưu gói tài khoản
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Format currency input
        document.getElementById('price').addEventListener('input', function(e) {
            let value = this.value.replace(/\D/g, '');
            if (value) {
                this.value = new Intl.NumberFormat('vi-VN').format(parseInt(value));
            }
        });
        
        // Form validation
        document.getElementById('addTierForm').addEventListener('submit', function(e) {
            let isValid = true;
            const requiredFields = this.querySelectorAll('[required]');
            
            requiredFields.forEach(function(field) {
                if (!field.value.trim()) {
                    field.classList.add('is-invalid');
                    isValid = false;
                } else {
                    field.classList.remove('is-invalid');
                }
            });
            
            if (!isValid) {
                e.preventDefault();
                alert('Vui lòng điền đầy đủ thông tin bắt buộc.');
            }
        });
    </script>
</body>
</html>
