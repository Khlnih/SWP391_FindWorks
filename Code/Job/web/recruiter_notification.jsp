<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông báo - FindWorks</title>
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
        
        .notification-container {
            max-width: 900px;
            margin: 2rem auto;
            padding: 0 15px;
        }
        
        .notification-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }
        
        .notification-card {
            background: white;
            border-radius: 0.5rem;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
            margin-bottom: 1rem;
            border-left: 4px solid transparent;
            transition: all 0.3s ease;
        }
        
        .notification-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 0.5rem 2rem 0 rgba(58, 59, 69, 0.2);
        }
        
        .notification-unread {
            border-left-color: var(--primary-color);
            background-color: rgba(78, 115, 223, 0.05);
        }
        
        .notification-content {
            padding: 1.25rem;
        }
        
        .notification-title {
            font-weight: 600;
            margin-bottom: 0.25rem;
            color: #5a5c69;
        }
        
        .notification-text {
            color: #858796;
            margin-bottom: 0.5rem;
        }
        
        .notification-time {
            font-size: 0.8rem;
            color: #b7b9cc;
        }
        
        .notification-actions {
            display: flex;
            gap: 0.5rem;
            margin-top: 0.75rem;
        }
        
        .btn-mark-read {
            font-size: 0.8rem;
            padding: 0.25rem 0.5rem;
        }
        
        .badge-notification {
            font-size: 0.8rem;
            padding: 0.35em 0.65em;
        }
        
        .empty-state {
            text-align: center;
            padding: 3rem 1rem;
            color: #858796;
        }
        
        .empty-state i {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: #dddfeb;
        }
    </style>
</head>
<body>
    <jsp:include page="/includes/recruiter_slidebar.jsp" />
    
    <div class="notification-container">
        <div class="notification-header">
            <h2><i class="fas fa-bell me-2"></i>Thông báo</h2>
            <div>
                <button class="btn btn-sm btn-outline-primary me-2">
                    <i class="fas fa-check-double me-1"></i> Đánh dấu tất cả đã đọc
                </button>
                <button class="btn btn-sm btn-outline-secondary">
                    <i class="fas fa-cog"></i>
                </button>
            </div>
        </div>
        
        <!-- Filter Tabs -->
        <ul class="nav nav-tabs mb-4" id="notificationTabs" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active" id="all-tab" data-bs-toggle="tab" data-bs-target="#all" type="button" role="tab">
                    Tất cả 
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="unread-tab" data-bs-toggle="tab" data-bs-target="#unread" type="button" role="tab">
                    Chưa đọc <span class="badge bg-danger rounded-pill">${sessionScope.number}</span>
                </button>
            </li>
            
        </ul>
        
        <!-- Tab Content -->
        <div class="tab-content" id="notificationTabContent">
            <div class="tab-pane fade show active" id="all" role="tabpanel" aria-labelledby="all-tab">
                <c:choose>
                    <c:when test="${not empty sessionScope.allNoti}">
                        <c:forEach var="notification" items="${sessionScope.allNoti}">
                            <div class="notification-card ${notification.isRead == 0 ? 'notification-unread' : ''} mb-3">
                                <div class="notification-content">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <h5 class="notification-title mb-1">
                                                <c:choose>
                                                    <c:when test="${notification.notificationType == 'PostStatus'}">
                                                        <i class="fas fa-file-alt text-info me-2"></i> Thông tin duyệt bài đăng
                                                    </c:when>
                                                   
                                                    <c:otherwise>
                                                        <i class="fas fa-bell text-warning me-2"></i> Thông báo
                                                    </c:otherwise>
                                                </c:choose>
                                            </h5>
                                            <small class="text-muted">
                                                <c:if test="${notification.createdByAdminID != null}">
                                                    <i class="fas fa-user-shield"></i> Quản trị viên
                                                </c:if>
                                            </small>
                                        </div>
                                        <c:if test="${notification.isRead == 0}">
                                            <span class="badge bg-primary badge-notification">Mới</span>
                                        </c:if>
                                    </div>
                                    <p class="notification-text mt-2">${notification.message}</p>
                                    <div class="d-flex justify-content-between align-items-center">
                                        
                                        <div class="notification-actions">
                                            <c:if test="${notification.isRead == 0}">
                                                    
                                                <form action="ffavoriteController" method="POST" class="d-inline">
                                                    <input type="hidden" name="action" value="readNoti">
                                                    <input type="hidden" name="recruiterID" value="${recruiter.getRecruiterID()}">
                                                    <input type="hidden" name="notiID" value="${notification.notificationID}">
                                                    <button type="submit" class="btn btn-sm btn-outline-secondary btn-mark-read">
                                                        Đánh dấu đã đọc
                                                    </button>
                                                </form>
                                            </c:if>
                                            
                                            <form action="ffavoriteController" method="POST" class="d-inline">
                                                    <input type="hidden" name="action" value="deleteNoti">
                                                    <input type="hidden" name="recruiterID" value="${recruiter.getRecruiterID()}">
                                                    <input type="hidden" name="notiID" value="${notification.notificationID}">
                                                    <button type="submit" class="btn btn-sm btn-outline-danger btn-delete-notification">
                                                        <i class="far fa-trash-alt"></i>
                                                    </button>
                                                </form>
                                            
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="far fa-bell-slash"></i>
                            <h4>Không có thông báo nào</h4>
                            <p>Bạn chưa có thông báo nào trong thời gian gần đây.</p>
                        </div>
                    </c:otherwise>
                </c:choose> 
            </div>
            
            <div class="tab-pane fade" id="unread" role="tabpanel" aria-labelledby="unread-tab">
                <c:choose>
                    <c:when test="${not empty sessionScope.listNoti}">
                        <c:forEach var="notification" items="${sessionScope.listNoti}">
                            <div class="notification-card ${notification.isRead == 0 ? 'notification-unread' : ''} mb-3">
                                <div class="notification-content">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <h5 class="notification-title mb-1">
                                                <c:choose>
                                                    <c:when test="${notification.notificationType == 'PostStatus'}">
                                                        <i class="fas fa-file-alt text-info me-2"></i> Thông tin duyệt bài đăng
                                                    </c:when>
                                                   
                                                    <c:otherwise>
                                                        <i class="fas fa-bell text-warning me-2"></i> Thông báo
                                                    </c:otherwise>
                                                </c:choose>
                                            </h5>
                                            <small class="text-muted">
                                                <c:if test="${notification.createdByAdminID != null}">
                                                    <i class="fas fa-user-shield"></i> Quản trị viên
                                                </c:if>
                                            </small>
                                        </div>
                                        <c:if test="${notification.isRead == 0}">
                                            <span class="badge bg-primary badge-notification">Mới</span>
                                        </c:if>
                                    </div>
                                    <p class="notification-text mt-2">${notification.message}</p>
                                    <div class="d-flex justify-content-between align-items-center">
                                        
                                        <div class="notification-actions">
                                           <c:if test="${notification.isRead == 0}">
                                                    
                                                <form action="ffavoriteController" method="POST" class="d-inline">
                                                    <input type="hidden" name="action" value="readNoti">
                                                    <input type="hidden" name="recruiterID" value="${recruiter.getRecruiterID()}">
                                                    <input type="hidden" name="notiID" value="${notification.notificationID}">
                                                    <button type="submit" class="btn btn-sm btn-outline-secondary btn-mark-read">
                                                        Đánh dấu đã đọc
                                                    </button>
                                                </form>
                                            </c:if>
                                            
                                            <form action="ffavoriteController" method="POST" class="d-inline">
                                                    <input type="hidden" name="action" value="deleteNoti">
                                                    <input type="hidden" name="recruiterID" value="${recruiter.getRecruiterID()}">
                                                    <input type="hidden" name="notiID" value="${notification.notificationID}">
                                                    <button type="submit" class="btn btn-sm btn-outline-danger btn-delete-notification">
                                                        <i class="far fa-trash-alt"></i>
                                                    </button>
                                                </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="far fa-bell-slash"></i>
                            <h4>Không có thông báo nào</h4>
                            <p>Bạn chưa có thông báo nào trong thời gian gần đây.</p>
                        </div>
                    </c:otherwise>
                </c:choose>   
            </div>
            
        </div>
    </div>
    
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Custom JS for notification interactions -->
    <script>
        // Mark as read functionality
        document.addEventListener('click', function(e) {
            // Handle mark as read
            if (e.target.closest('.btn-mark-read')) {
                const button = e.target.closest('.btn-mark-read');
                const notificationId = button.dataset.notificationId;
                const card = button.closest('.notification-card');
                
                // Make AJAX call to mark as read
                fetch('NotificationController?action=markAsRead&id=' + notificationId, {
                    method: 'POST'
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        card.classList.remove('notification-unread');
                        const badge = card.querySelector('.badge');
                        if (badge) badge.classList.add('d-none');
                        // Update unread count in the UI
                        updateUnreadCount();
                    }
                })
                .catch(error => console.error('Error:', error));
            }
            
            // Handle delete
            if (e.target.closest('.btn-delete-notification')) {
                const button = e.target.closest('.btn-delete-notification');
                const notificationId = button.dataset.notificationId;
                const card = button.closest('.notification-card');
                
                if (confirm('Bạn có chắc chắn muốn xóa thông báo này?')) {
                    // Make AJAX call to delete
                    fetch('NotificationController?action=delete&id=' + notificationId, {
                        method: 'POST'
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            card.style.opacity = '0';
                            setTimeout(() => card.remove(), 300);
                            // Update unread count in the UI
                            updateUnreadCount();
                        }
                    })
                    .catch(error => console.error('Error:', error));
                }
            }
        });
        
        // Function to update unread count in the UI
        function updateUnreadCount() {
            // Update the unread count badge
            const unreadCount = document.querySelectorAll('.notification-unread').length;
            const unreadBadge = document.querySelector('#unread-tab .badge');
            const allBadge = document.querySelector('#all-tab .badge');
            
            if (unreadBadge) {
                unreadBadge.textContent = unreadCount;
                if (unreadCount === 0) {
                    unreadBadge.classList.remove('bg-danger');
                    unreadBadge.classList.add('bg-secondary');
                } else {
                    unreadBadge.classList.remove('bg-secondary');
                    unreadBadge.classList.add('bg-danger');
                }
            }
            
            // Update the "All" tab count if needed
            if (allBadge) {
                const totalCount = document.querySelectorAll('.notification-card').length;
                allBadge.textContent = totalCount;
            }
        }
    </script>
</body>
</html>
