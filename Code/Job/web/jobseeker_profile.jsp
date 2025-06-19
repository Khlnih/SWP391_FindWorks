<%@page import="Model.Jobseeker"%>
<%@page import="Model.UserLoginInfo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ sơ của tôi - FindWorks</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #4e73df;
            --secondary-color: #f8f9fc;
            --success-color: #1cc88a;
            --warning-color: #f6c23e;
            --danger-color: #e74a3b;
            --text-color: #5a5c69;
        }
        
        body {
            background-color: var(--secondary-color);
            color: var(--text-color);
            font-family: 'Nunito', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
        }
        
        .profile-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, #224abe 100%);
            color: white;
            border-radius: 15px;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
        }
        
        .profile-avatar {
            width: 120px;
            height: 120px;
            border: 5px solid white;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.3);
        }
        
        .progress {
            height: 10px;
            border-radius: 5px;
        }
        
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            margin-bottom: 20px;
        }
        
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 0.5rem 1.5rem 0 rgba(58, 59, 69, 0.2);
        }
        
        .stat-card {
            border-left: 4px solid var(--primary-color);
        }
        
        .stat-card.applications {
            border-left-color: var(--success-color);
        }
        
        .stat-card.saved {
            border-left-color: var(--warning-color);
        }
        
        .stat-card.views {
            border-left-color: var(--danger-color);
        }
        
        .nav-pills .nav-link {
            color: var(--text-color);
            border-radius: 10px;
            margin: 5px 0;
        }
        
        .nav-pills .nav-link.active {
            background-color: var(--primary-color);
            color: white;
        }
        
        .badge-custom {
            padding: 0.5em 0.8em;
            font-weight: 500;
            border-radius: 50px;
        }
    </style>
</head>
<body>
    <div class="container py-4">
        <!-- Header -->
        <div class="profile-header p-4 mb-4 text-center text-md-start">
            <div class="row align-items-center">
                <div class="col-md-2 text-center">
                    
                </div>
                <div class="col-md-6">
                    <h2 class="mb-1">${sessionScope.jobseeker.first_Name}  ${sessionScope.jobseeker.last_Name}</h2>

                    <div class="d-flex flex-wrap gap-2">
                        <span class="badge bg-light text-dark">
                            <i class="fas fa-star text-warning"></i> 4.8/5.0
                        </span>
                        <span class="badge bg-light text-dark">
                            <i class="fas fa-check-circle text-success"></i> Đã xác minh
                        </span>
                    </div>
                </div>
                <div class="col-md-4 mt-3 mt-md-0">
                    <div class="bg-white p-3 rounded-3 text-dark">
                        <h6 class="text-muted mb-3">Hoàn thiện hồ sơ</h6>
                        <div class="progress mb-2">
                            <div class="progress-bar bg-success" role="progressbar" style="width: 75%" 
                                 aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                        <p class="mb-0 small">75% hoàn thành - <a href="#" class="text-primary">Hoàn thiện ngay</a></p>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <!-- Left Sidebar -->
            <div class="col-lg-3">
                <div class="card mb-4">
                    <div class="card-body">
                        <div class="d-flex align-items-center mb-3">
                            <div class="me-3">
                                <i class="fas fa-user-circle fa-2x text-primary"></i>
                            </div>
                            <div>

                                <small class="text-muted">${sessionScope.jobseeker.email_contact}</small>
                            </div>
                        </div>
                        <hr>
                        <ul class="nav flex-column nav-pills">
                            <li class="nav-item">
                                <a class="nav-link active" href="#" id="overview-tab">
                                    <i class="fas fa-home me-2"></i> Tổng quan
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" id="profile-tab">
                                    <i class="fas fa-user-edit me-2"></i> Chỉnh sửa hồ sơ
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" id="applications-tab">
                                    <i class="fas fa-file-alt me-2"></i> Đơn ứng tuyển
                                    <span class="badge bg-danger rounded-pill ms-2">3</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" id="saved-jobs-tab">
                                    <i class="fas fa-bookmark me-2"></i> Công việc đã lưu
                                    <span class="badge bg-warning rounded-pill ms-2">5</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" id="settings-tab">
                                    <i class="fas fa-cog me-2"></i> Cài đặt
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-danger" href="logout">
                                    <i class="fas fa-sign-out-alt me-2"></i> Đăng xuất
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
                
                <!-- Quick Stats -->
                <div class="card mb-4">
                    <div class="card-body">
                        <h6 class="card-title mb-3">Thống kê nhanh</h6>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Hồ sơ xem</span>
                            <strong>128</strong>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Đơn ứng tuyển</span>
                            <strong>24</strong>
                        </div>
                        <div class="d-flex justify-content-between">
                            <span class="text-muted">Đã lưu</span>
                            <strong>12</strong>
                        </div>
                    </div>
                </div>
                
                <!-- Skills -->
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h6 class="card-title mb-0">Kỹ năng</h6>
                            <button class="btn btn-sm btn-outline-primary"><i class="fas fa-plus"></i></button>
                        </div>
                        <div class="d-flex flex-wrap gap-2">
                            <span class="badge bg-primary bg-opacity-10 text-primary badge-custom">
                                Java <i class="fas fa-times ms-1"></i>
                            </span>
                            <span class="badge bg-primary bg-opacity-10 text-primary badge-custom">
                                Spring Boot <i class="fas fa-times ms-1"></i>
                            </span>
                            <span class="badge bg-primary bg-opacity-10 text-primary badge-custom">
                                MySQL <i class="fas fa-times ms-1"></i>
                            </span>
                            <span class="badge bg-primary bg-opacity-10 text-primary badge-custom">
                                HTML/CSS <i class="fas fa-times ms-1"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Main Content -->
            <div class="col-lg-9">
                <!-- Stats Cards -->
                <div class="row mb-4">
                    <div class="col-md-4 mb-3">
                        <div class="card h-100 stat-card applications">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="text-uppercase text-muted small mb-1">Đơn ứng tuyển</h6>
                                        <h4 class="mb-0">24</h4>
                                    </div>
                                    <div class="bg-success bg-opacity-10 p-3 rounded-circle">
                                        <i class="fas fa-file-alt fa-2x text-success"></i>
                                    </div>
                                </div>
                                <div class="mt-3">
                                    <span class="text-success"><i class="fas fa-arrow-up"></i> 12.5%</span>
                                    <span class="text-muted ms-2">So với tháng trước</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <div class="card h-100 stat-card saved">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="text-uppercase text-muted small mb-1">Đã lưu</h6>
                                        <h4 class="mb-0">12</h4>
                                    </div>
                                    <div class="bg-warning bg-opacity-10 p-3 rounded-circle">
                                        <i class="fas fa-bookmark fa-2x text-warning"></i>
                                    </div>
                                </div>
                                <div class="mt-3">
                                    <span class="text-warning"><i class="fas fa-minus"></i> 2.3%</span>
                                    <span class="text-muted ms-2">So với tháng trước</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <div class="card h-100 stat-card views">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="text-uppercase text-muted small mb-1">Lượt xem hồ sơ</h6>
                                        <h4 class="mb-0">128</h4>
                                    </div>
                                    <div class="bg-danger bg-opacity-10 p-3 rounded-circle">
                                        <i class="fas fa-eye fa-2x text-danger"></i>
                                    </div>
                                </div>
                                <div class="mt-3">
                                    <span class="text-success"><i class="fas fa-arrow-up"></i> 24.1%</span>
                                    <span class="text-muted ms-2">So với tháng trước</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Recent Applications -->
                <div class="card mb-4">
                    <div class="card-header bg-white">
                        <div class="d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Đơn ứng tuyển gần đây</h5>
                            <a href="#" class="btn btn-sm btn-outline-primary">Xem tất cả</a>
                        </div>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th class="border-0">Vị trí</th>
                                        <th class="border-0">Công ty</th>
                                        <th class="border-0">Ngày nộp</th>
                                        <th class="border-0">Trạng thái</th>
                                        <th class="border-0">Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Lập trình viên Java</td>
                                        <td>FPT Software</td>
                                        <td>15/06/2023</td>
                                        <td><span class="badge bg-warning bg-opacity-10 text-warning">Đang xử lý</span></td>
                                        <td>
                                            <button class="btn btn-sm btn-outline-primary">Xem</button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Frontend Developer</td>
                                        <td>Zalo Group</td>
                                        <td>10/06/2023</td>
                                        <td><span class="badge bg-success bg-opacity-10 text-success">Đã xem</span></td>
                                        <td>
                                            <button class="btn btn-sm btn-outline-primary">Xem</button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Backend Developer</td>
                                        <td>Tiki</td>
                                        <td>05/06/2023</td>
                                        <td><span class="badge bg-info bg-opacity-10 text-info">Đã nhận hồ sơ</span></td>
                                        <td>
                                            <button class="btn btn-sm btn-outline-primary">Xem</button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                
                <!-- Recommended Jobs -->
                <div class="card">
                    <div class="card-header bg-white">
                        <div class="d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Gợi ý việc làm</h5>
                            <a href="jobs" class="btn btn-sm btn-outline-primary">Xem tất cả</a>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <!-- Job Card 1 -->
                            <div class="col-md-6 mb-3">
                                <div class="card h-100">
                                    <div class="card-body">
                                        <div class="d-flex mb-3">
                                            <img src="https://via.placeholder.com/60" alt="Company Logo" class="rounded me-3" style="width: 60px; height: 60px; object-fit: cover;">
                                            <div>
                                                <h6 class="mb-1">Senior Java Developer</h6>
                                                <p class="text-muted small mb-0">TECHVISION JSC</p>
                                                <div class="d-flex align-items-center text-warning mb-1">
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="far fa-star"></i>
                                                    <span class="ms-1 text-muted">(24)</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="d-flex flex-wrap gap-2 mb-3">
                                            <span class="badge bg-primary bg-opacity-10 text-primary">Java</span>
                                            <span class="badge bg-primary bg-opacity-10 text-primary">Spring Boot</span>
                                            <span class="badge bg-primary bg-opacity-10 text-primary">MySQL</span>
                                        </div>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <span class="text-success fw-bold">$2000 - $3000</span>
                                                <span class="text-muted d-block small">Hà Nội</span>
                                            </div>
                                            <button class="btn btn-sm btn-outline-primary">Ứng tuyển</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Job Card 2 -->
                            <div class="col-md-6 mb-3">
                                <div class="card h-100">
                                    <div class="card-body">
                                        <div class="d-flex mb-3">
                                            <img src="https://via.placeholder.com/60" alt="Company Logo" class="rounded me-3" style="width: 60px; height: 60px; object-fit: cover;">
                                            <div>
                                                <h6 class="mb-1">Fullstack Developer</h6>
                                                <p class="text-muted small mb-0">VNG Corporation</p>
                                                <div class="d-flex align-items-center text-warning mb-1">
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star"></i>
                                                    <i class="fas fa-star-half-alt"></i>
                                                    <i class="far fa-star"></i>
                                                    <span class="ms-1 text-muted">(156)</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="d-flex flex-wrap gap-2 mb-3">
                                            <span class="badge bg-primary bg-opacity-10 text-primary">JavaScript</span>
                                            <span class="badge bg-primary bg-opacity-10 text-primary">React</span>
                                            <span class="badge bg-primary bg-opacity-10 text-primary">Node.js</span>
                                        </div>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <span class="text-success fw-bold">$2500 - $3500</span>
                                                <span class="text-muted d-block small">Hồ Chí Minh</span>
                                            </div>
                                            <button class="btn btn-sm btn-outline-primary">Ứng tuyển</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white py-4 mt-5">
        <div class="container">
            <div class="row">
                <div class="col-md-4 mb-4 mb-md-0">
                    <h5>Về FindWorks</h5>
                    <p class="text-muted">Kết nối nhà tuyển dụng và ứng viên một cách hiệu quả nhất.</p>
                </div>
                <div class="col-md-2 mb-4 mb-md-0">
                    <h5>Dịch vụ</h5>
                    <ul class="list-unstyled text-muted">
                        <li><a href="#" class="text-decoration-none text-muted">Tìm việc làm</a></li>
                        <li><a href="#" class="text-decoration-none text-muted">Đăng tin tuyển dụng</a></li>
                        <li><a href="#" class="text-decoration-none text-muted">Tạo hồ sơ</a></li>
                    </ul>
                </div>
                <div class="col-md-2 mb-4 mb-md-0">
                    <h5>Công ty</h5>
                    <ul class="list-unstyled text-muted">
                        <li><a href="#" class="text-decoration-none text-muted">Giới thiệu</a></li>
                        <li><a href="#" class="text-decoration-none text-muted">Điều khoản</a></li>
                        <li><a href="#" class="text-decoration-none text-muted">Chính sách bảo mật</a></li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h5>Kết nối với chúng tôi</h5>
                    <div class="d-flex gap-3 mb-3">
                        <a href="#" class="text-white"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="text-white"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="text-white"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#" class="text-white"><i class="fab fa-instagram"></i></a>
                    </div>
                    <p class="text-muted mb-0">© 2023 FindWorks. All rights reserved.</p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Custom JS -->
    <script>
        // Update profile completion progress
        document.addEventListener('DOMContentLoaded', function() {
            // You can fetch actual data from your backend here
            const completionPercentage = 75; // This should come from your backend
            
            // Update progress bar
            const progressBar = document.querySelector('.progress-bar');
            if (progressBar) {
                progressBar.style.width = `${completionPercentage}%`;
                progressBar.setAttribute('aria-valuenow', completionPercentage);
            }
            
            // Tab switching functionality
            const tabLinks = document.querySelectorAll('.nav-link');
            tabLinks.forEach(link => {
                link.addEventListener('click', function(e) {
                    e.preventDefault();
                    // Remove active class from all links
                    tabLinks.forEach(l => l.classList.remove('active'));
                    // Add active class to clicked link
                    this.classList.add('active');
                    // Here you would load the appropriate content
                });
            });
        });
    </script>
</body>
</html>
