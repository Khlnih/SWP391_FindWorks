<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý bài đăng tuyển dụng</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .status-badge {
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 0.85rem;
            display: inline-block;
            min-width: 80px;
            text-align: center;
        }
        .status-pending { background-color: #fff3cd; color: #856404; }
        .status-approved { background-color: #d4edda; color: #155724; }
        .status-rejected { background-color: #f8d7da; color: #721c24; }
        .status-draft { background-color: #e2e3e5; color: #383d41; }
        .nav-tabs .nav-link {
            color: #495057;
            font-weight: 500;
        }
        .nav-tabs .nav-link.active {
            font-weight: 600;
            border-bottom: 3px solid #0d6efd;
        }
        .tab-content {
            padding: 1.5rem 0;
        }
        .post-title {
            color: #0d6efd;
            text-decoration: none;
            font-weight: 500;
        }
        .post-title:hover {
            text-decoration: underline;
        }
        .action-buttons .btn {
            margin: 0 2px;
        }
    </style>
</head>
<body>
    <!-- Include sidebar -->
    <jsp:include page="includes/recruiter_slidebar.jsp" />
    
    <div class="container-fluid">
        <div class="row">
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Quản lý bài đăng tuyển dụng</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="RecruiterPostController?action=create" class="btn btn-primary">
                            <i class="fas fa-plus me-1"></i> Đăng tin mới
                        </a>
                    </div>
                </div>

                <!-- Tabs Navigation -->
                <ul class="nav nav-tabs" id="postTabs" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="all-tab" data-bs-toggle="tab" 
                                data-bs-target="#all" type="button" role="tab">
                            Tất cả
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="pending-tab" data-bs-toggle="tab" 
                                data-bs-target="#pending" type="button" role="tab">
                            Chờ duyệt <span class="badge bg-warning text-dark">0</span>
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="published-tab" data-bs-toggle="tab" 
                                data-bs-target="#published" type="button" role="tab">
                            Đang hiển thị <span class="badge bg-success">0</span>
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="rejected-tab" data-bs-toggle="tab" 
                                data-bs-target="#rejected" type="button" role="tab">
                            Từ chối <span class="badge bg-danger">0</span>
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="draft-tab" data-bs-toggle="tab" 
                                data-bs-target="#draft" type="button" role="tab">
                            Bản nháp <span class="badge bg-secondary">0</span>
                        </button>
                    </li>
                </ul>

                <!-- Tab Content -->
                <div class="tab-content" id="postTabsContent">
                    <!-- All Posts Tab -->
                    <div class="tab-pane fade show active" id="all" role="tabpanel">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead class="table-light">
                                    <tr>
                                        <th>Vị trí tuyển dụng</th>
                                        <th>Ngân sách</th>
                                        <th>Địa điểm</th>
                                        <th>Trạng thái</th>
                                        <th>Ngày đăng</th>
                                        <th>Hạn nộp</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${empty allPost}">
                                            <tr>
                                                <td colspan="7" class="text-center">Chưa có bài đăng nào</td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach items="${allPost}" var="post">
                                                <tr>
                                                    <td>
                                                        <a href="PostDetailController?id=${post.postId}" class="post-title">${post.title}</a>
                                                        <div class="text-muted small">${post.categoryId} • ${post.jobTypeId}</div>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${post.budgetType == 'Fixed'}">
                                                                <fmt:formatNumber value="${post.budgetMin}" type="currency" pattern="#,##0" /> đ
                                                            </c:when>
                                                            <c:when test="${post.budgetType == 'Range'}">
                                                                <fmt:formatNumber value="${post.budgetMin}" type="currency" pattern="#,##0" /> - 
                                                                <fmt:formatNumber value="${post.budgetMax}" type="currency" pattern="#,##0" /> đ
                                                            </c:when>
                                                            <c:otherwise>
                                                                Thương lượng
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>${post.location}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${post.statusPost == 'Approved'}">
                                                                <span class="status-badge status-approved">Đã duyệt</span>
                                                            </c:when>
                                                            <c:when test="${post.statusPost == 'Pending'}">
                                                                <span class="status-badge status-pending">Chờ duyệt</span>
                                                            </c:when>
                                                            <c:when test="${post.statusPost == 'Rejected'}">
                                                                <span class="status-badge status-rejected">Từ chối</span>
                                                            </c:when>
                                                            <c:when test="${post.statusPost == 'Draft'}">
                                                                <span class="status-badge status-draft">Bản nháp</span>
                                                            </c:when>
                                                        </c:choose>
                                                    </td>
                                                    <td><fmt:formatDate value="${post.datePost}" pattern="dd/MM/yyyy"/></td>
                                                    <td><fmt:formatDate value="${post.expiredDate}" pattern="dd/MM/yyyy"/></td>
                                                    
                                                </tr>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Pending Tab -->
                    <div class="tab-pane fade" id="pending" role="tabpanel">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead class="table-light">
                                    <tr>
                                        <th>Vị trí tuyển dụng</th>
                                        <th>Ngày đăng</th>
                                        <th>Hạn nộp</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${empty pendingPost}">
                                            <tr>
                                                <td colspan="4" class="text-center">Không có bài đăng nào đang chờ duyệt</td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach items="${pendingPost}" var="post">
                                                <tr>
                                                    <td>
                                                        <a href="#" class="post-title">${post.title}</a>
                                                        <div class="text-muted small">${post.categoryId}</div>
                                                    </td>
                                                    <td><fmt:formatDate value="${post.datePost}" pattern="dd/MM/yyyy"/></td>
                                                    <td><fmt:formatDate value="${post.expiredDate}" pattern="dd/MM/yyyy"/></td>
                                                   
                                                </tr>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Published Tab -->
                    <div class="tab-pane fade" id="published" role="tabpanel">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead class="table-light">
                                    <tr>
                                        <th>Vị trí tuyển dụng</th>
                                        <th>Ngày đăng</th>
                                        <th>Hạn nộp</th>
                                        <th>Hồ sơ</th>
                                        <th>Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${empty apporvePost}">
                                            <tr>
                                                <td colspan="6" class="text-center">Chưa có bài đăng nào đang hiển thị</td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach items="${apporvePost}" var="post" varStatus="loop">
                                                <tr>
                                                    <td>
                                                        <a href="PostDetailController?id=${post.postId}" class="post-title">${post.title}</a>
                                                        <div class="text-muted small">${post.postId}</div>
                                                    </td>
                                                    <td><fmt:formatDate value="${post.datePost}" pattern="dd/MM/yyyy"/></td>
                                                    <td><fmt:formatDate value="${post.expiredDate}" pattern="dd/MM/yyyy"/></td>
                                                    <td>
                                                        <c:set var="found" value="false" />
                                                        <c:forEach items="${numberApply}" var="number">
                                                            <c:if test="${number.postId == post.postId}">
                                                                ${number.jobTypeId} ứng viên
                                                                <c:set var="found" value="true" />
                                                            </c:if>
                                                        </c:forEach>
                                                        <c:if test="${!found}">
                                                            0 ứng viên
                                                        </c:if>
                                                    </td>
                                                    <td>
                                                        <a href="recruiter_applyJob.jsp" class="btn btn-sm btn-outline-primary">
                                                            <i class="fas fa-users"></i> Xem
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Rejected Tab -->
                    <div class="tab-pane fade" id="rejected" role="tabpanel">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead class="table-light">
                                    <tr>
                                        <th>Vị trí tuyển dụng</th>
                                        <th>Ngày đăng</th>
                                        <th>Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${empty rejectPost}">
                                            <tr>
                                                <td colspan="4" class="text-center">Không có bài đăng nào bị từ chối</td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach items="${rejectPost}" var="post">
                                                <tr>
                                                    <td>
                                                        <a href="#" class="post-title">${post.title}</a>
                                                    </td>
                                                    <td><fmt:formatDate value="${post.datePost}" pattern="dd/MM/yyyy"/></td>
                                                    <td>
                                                        <a href="RecruiterPostController?action=edit&id=${post.postId}" class="btn btn-sm btn-outline-primary">
                                                            <i class="fas fa-edit"></i> Sửa lại
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Draft Tab -->
                    <div class="tab-pane fade" id="draft" role="tabpanel">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead class="table-light">
                                    <tr>
                                        <th>Tiêu đề</th>
                                        <th>Ngày tạo</th>
                                        <th>Ngày sửa</th>
                                        <th>Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${empty draftPost}">
                                            <tr>
                                                <td colspan="4" class="text-center">Chưa có bản nháp nào được lưu</td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach items="${draftPost}" var="post">
                                                <tr>
                                                    <td>
                                                        <a href="#" class="post-title">${post.title}</a>
                                                        <div class="text-muted small">${post.categoryId}</div>
                                                    </td>
                                                    <td><fmt:formatDate value="${post.datePost}" pattern="dd/MM/yyyy"/></td>
                                                    <td><fmt:formatDate value="${post.updatedAt}" pattern="dd/MM/yyyy"/></td>
                                                    <td class="action-buttons">
                                                        <a href="RecruiterPostController?action=edit&id=${post.postId}" class="btn btn-sm btn-outline-primary">
                                                            <i class="fas fa-edit"></i> Tiếp tục
                                                        </a>
                                                        <button onclick="handlePostAction(${post.postId}, 'delete')" class="btn btn-sm btn-outline-danger">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                        <button onclick="handlePostAction(${post.postId}, 'submit')" class="btn btn-sm btn-outline-success">
                                                            <i class="fas fa-paper-plane"></i>
                                                        </button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- Format Number for Currency -->
    <fmt:setLocale value="vi_VN" scope="session"/>
    
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Khởi tạo tooltips
        document.addEventListener('DOMContentLoaded', function() {
            var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
            var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                return new bootstrap.Tooltip(tooltipTriggerEl);
            });

            // Update badge counts
            updateBadgeCounts();
        });

        // Xử lý sự kiện khi chuyển tab
        document.querySelectorAll('button[data-bs-toggle="tab"]').forEach(tab => {
            tab.addEventListener('shown.bs.tab', function (event) {
                const target = event.target.getAttribute('data-bs-target').replace('#', '');
                loadTabData(target);
            });
        });

        // Hàm cập nhật số lượng bài đăng trên các tab
        function updateBadgeCounts() {
            // Cập nhật số lượng bài đăng trên các tab
            document.querySelector('#pending-tab .badge').textContent = '${empty pendingPost ? 0 : pendingPost.size()}';
            document.querySelector('#published-tab .badge').textContent = '${empty apporvePost ? 0 : apporvePost.size()}';
            document.querySelector('#rejected-tab .badge').textContent = '${empty rejectPost ? 0 : rejectPost.size()}';
            document.querySelector('#draft-tab .badge').textContent = '${empty draftPost ? 0 : draftPost.size()}';
        }

        // Hàm xử lý thao tác với bài đăng
        function handlePostAction(postId, action) {
            if (action === 'delete') {
                if (!confirm('Bạn có chắc chắn muốn xóa bài đăng này?')) {
                    return;
                }
            } else if (action === 'submit') {
                if (!confirm('Bạn có chắc chắn muốn gửi bài đăng này để duyệt?')) {
                    return;
                }
            }

            // Tạo form ẩn để gửi dữ liệu
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = 'RecruiterPostController';
            
            // Thêm các tham số
            const actionInput = document.createElement('input');
            actionInput.type = 'hidden';
            actionInput.name = 'action';
            actionInput.value = action;
            
            const postIdInput = document.createElement('input');
            postIdInput.type = 'hidden';
            postIdInput.name = 'id';
            postIdInput.value = postId;
            
            form.appendChild(actionInput);
            form.appendChild(postIdInput);
            
            // Thêm form vào body và submit
            document.body.appendChild(form);
            form.submit();
        }
    </script>
</body>
</html>
