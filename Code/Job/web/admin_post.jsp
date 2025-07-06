<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý bài đăng</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .status-badge {
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 0.85rem;
        }
        .status-pending { background-color: #fff3cd; color: #856404; }
        .status-approved { background-color: #d4edda; color: #155724; }
        .status-rejected { background-color: #f8d7da; color: #721c24; }
    </style>
</head>
<body>
    <!-- Include sidebar -->
    <jsp:include page="includes/admin_sidebar.jsp" />
    
    <div class="container-fluid">
        <div class="row">
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Quản lý bài đăng</h1>
                </div>

                

                <!-- Posts Table -->
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">Danh sách bài đăng</h5>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty sessionScope.post}">
                                <div class="alert alert-warning mb-0">Không có bài đăng nào để hiển thị</div>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle">
                                        <thead class="table-light">
                                            <tr>
                                                <th>#</th>                                                                       
                                                <th>Tiêu đề</th>
                                                <th>Hành động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${sessionScope.post}" var="post" varStatus="loop">
                                                <tr>
                                                    <td>${loop.index + 1}</td>                                                  
                                                    <td>${post.title}</td>
                                                    <td class="text-nowrap">
                                                        <div class="d-flex gap-2">
                                                            <form action="${pageContext.request.contextPath}/AdminPostController" method="POST">
                                                                <input type="hidden" name="action" value="request">
                                                                <input type="hidden" name="recruiterID" value="${post.recruiterId}">
                                                                <input type="hidden" name="postID" value="${post.postId}">
                                                                <input type="hidden" name="status" value="Approved">
                                                                <button type="submit" class="btn btn-sm btn-outline-success" 
                                                                        data-bs-toggle="tooltip" data-bs-placement="top" 
                                                                        title="Duyệt bài" 
                                                                        onclick="return confirm('Bạn có chắc chắn muốn duyệt bài đăng này?')">
                                                                    <i class="fas fa-check"></i>
                                                                </button>
                                                            </form>
                                                            <form action="${pageContext.request.contextPath}/AdminPostController" method="POST">
                                                                <input type="hidden" name="action" value="request">
                                                                <input type="hidden" name="recruiterID" value="${post.recruiterId}">
                                                                <input type="hidden" name="postID" value="${post.postId}">
                                                                <input type="hidden" name="status" value="Rejected">
                                                                <button type="submit" class="btn btn-sm btn-outline-danger" 
                                                                        data-bs-toggle="tooltip" data-bs-placement="top" 
                                                                        title="Từ chối" 
                                                                        onclick="return confirm('Bạn có chắc chắn muốn từ chối bài đăng này?')">
                                                                    <i class="fas fa-times"></i>
                                                                </button>
                                                            </form>
                                                           
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Initialize tooltips
        document.addEventListener('DOMContentLoaded', function() {
            var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
            var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                return new bootstrap.Tooltip(tooltipTriggerEl);
            });
        });

        

        function showToast(title, message, type = 'info') {
            // You can implement a toast notification here or use an existing library
            // This is a simple implementation using Bootstrap's toast
            const toastContainer = document.getElementById('toastContainer') || createToastContainer();
            
            const toastEl = document.createElement('div');
            toastEl.className = `toast align-items-center text-white bg-${type == 'error' ? 'danger' : type} border-0`;
            toastEl.setAttribute('role', 'alert');
            toastEl.setAttribute('aria-live', 'assertive');
            toastEl.setAttribute('aria-atomic', 'true');
            
            toastEl.innerHTML = `
                <div class="d-flex">
                    <div class="toast-body">
                        <strong>${title}</strong><br>${message}
                    </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
            `;
            
            toastContainer.appendChild(toastEl);
            const toast = new bootstrap.Toast(toastEl);
            toast.show();
            
            // Auto remove toast after 5 seconds
            setTimeout(() => {
                toastEl.remove();
            }, 5000);
        }
        
        function createToastContainer() {
            const container = document.createElement('div');
            container.id = 'toastContainer';
            container.className = 'toast-container position-fixed bottom-0 end-0 p-3';
            container.style.zIndex = '1100';
            document.body.appendChild(container);
            return container;
        }
    </script>
</body>
</html>
