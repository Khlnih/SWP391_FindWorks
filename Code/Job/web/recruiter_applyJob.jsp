<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Candidate List - FindWorks (Static Example)</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #4e73df;
            --secondary-color: #f8f9fc;
            --success-color: #1cc88a;
            --warning-color: #f6c23e;
            --danger-color: #e74a3b;
            --text-color: #5a5c69;
            --border-color: #e3e6f0;
        }
        
        body {
            background-color: #f8f9fc;
            color: var(--text-color);
            font-family: 'Nunito', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
        }
        
        .candidate-card {
            border: 1px solid var(--border-color);
            border-radius: 10px;
            transition: all 0.3s ease;
            margin-bottom: 1.25rem;
            background: white;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
        }
        
        .candidate-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 0.5rem 1.5rem rgba(0, 0, 0, 0.15);
        }
        
        .status-badge {
            font-size: 0.75rem;
            font-weight: 600;
            padding: 0.4em 0.8em;
            border-radius: 50rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .candidate-avatar {
            width: 70px;
            height: 70px;
            object-fit: cover;
            border-radius: 50%;
            border: 3px solid white;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
        }
        
        .main-content {
            padding: 2rem 2.5rem;
        }
        
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
            margin-bottom: 1.5rem;
            border-left: 4px solid var(--primary-color);
        }
        
        .card-header {
            background-color: #f8f9fc;
            border-bottom: 1px solid var(--border-color);
            font-weight: 700;
            color: var(--primary-color);
            padding: 1rem 1.5rem;
        }
        
        .card-body {
            padding: 1.5rem;
        }
        
        .btn {
            border-radius: 5px;
            font-weight: 600;
            padding: 0.5rem 1rem;
            font-size: 0.85rem;
            transition: all 0.2s;
            position: relative;
            overflow: hidden;
        }
        
        /* Cover letter specific styles */
        .btn[data-bs-toggle="collapse"] {
            transition: all 0.3s ease;
        }
        
        .btn[data-bs-toggle="collapse"]:not(.collapsed) .toggle-text::after {
            content: '\f078';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            margin-left: 8px;
            transition: transform 0.3s ease;
        }
        
        .btn[data-bs-toggle="collapse"] .toggle-text::after {
            content: '\f077';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            margin-left: 8px;
            transition: transform 0.3s ease;
        }
        
        .cover-letter-content {
            white-space: pre-wrap;
            line-height: 1.6;
            font-size: 0.95rem;
        }
        
        .cover-letter-content p:last-child {
            margin-bottom: 0;
        }
        
        .card.border-primary {
            box-shadow: 0 0.25rem 0.75rem rgba(13, 110, 253, 0.1);
        }
        
        /* CV Button Styles */
        .btn[disabled] {
            cursor: not-allowed;
            opacity: 0.65;
        }
        
        .btn-outline-secondary:disabled {
            color: #6c757d;
            background-color: transparent;
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        .btn-primary:hover {
            background-color: #2e59d9;
            border-color: #2653d4;
        }
        
        .btn-sm {
            padding: 0.35rem 0.75rem;
            font-size: 0.75rem;
        }
        
        .badge {
            font-weight: 600;
            padding: 0.4em 0.8em;
        }
        
        .bg-warning {
            background-color: var(--warning-color) !important;
        }
        
        .bg-success {
            background-color: var(--success-color) !important;
        }
        
        .bg-danger {
            background-color: var(--danger-color) !important;
        }
        
        .text-muted {
            color: #858796 !important;
        }
        
        .list-group-item {
            border-left: none;
            border-right: none;
            padding: 1.25rem 1.5rem;
            border-color: var(--border-color);
        }
        
        .list-group-item:first-child {
            border-top: none;
        }
        
        .list-group-item:last-child {
            border-bottom: none;
        }
        
        .collapse .card-body {
            background-color: #f8f9fc;
            border-radius: 5px;
            font-size: 0.9rem;
            line-height: 1.6;
        }
        
        .btn-outline-primary {
            color: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        .btn-outline-primary:hover {
            background-color: var(--primary-color);
            color: white;
        }
        
        .nav-link {
            color: #6e707e;
            border-radius: 5px;
            margin: 2px 0;
            font-weight: 600;
            padding: 0.75rem 1rem;
        }
        
        .nav-link:hover, .nav-link.active {
            background-color: rgba(78, 115, 223, 0.1);
            color: var(--primary-color);
        }
        
        .nav-link i {
            width: 20px;
            text-align: center;
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <jsp:include page="includes/recruiter_slidebar.jsp" />
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            

            <!-- Main Content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4 main-content">
                <%-- Display success/error messages if any --%>
                <c:if test="${not empty sessionScope.successMessage}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i> ${sessionScope.successMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <c:remove var="successMessage" scope="session"/>
                </c:if>
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i> ${errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <c:remove var="errorMessage" scope="session" />
                </c:if>
                
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Candidate List</h1>
                    
                </div>

                <!-- Job Info -->
                <div class="card mb-4">
                    <div class="card-body py-4">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h4 class="card-title mb-0 text-primary">${post.title}</h4>
                            <span class="badge bg-primary bg-opacity-10 text-primary">
                                <i class="fas fa-briefcase me-1"></i> ${fn:length(listApply)} Ứng viên
                            </span>
                        </div>
                        <div class="d-flex flex-wrap align-items-center text-muted">
                            <span class="me-3">
                                <i class="fas fa-map-marker-alt text-primary me-2"></i> ${post.location}
                            </span>
                            <span class="me-3">
                                <i class="fas fa-clock text-primary me-2"></i> Toàn thời gian
                            </span>
                            <span>
                                <i class="fas fa-calendar-alt text-primary me-2"></i>
                                <fmt:formatDate value="${post.datePost}" pattern="dd/MM/yyyy" /> - 
                                <fmt:formatDate value="${post.expiredDate}" pattern="dd/MM/yyyy" />
                            </span>
                        </div>
                    </div>
                </div>

                <!-- Candidates List -->
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Candidates (${not empty listApply ? listApply.size() : 0})</h5>
                        <div class="dropdown">
                            <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                <i class="fas fa-sort me-1"></i> Sort by
                            </button>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="#">Newest</a></li>
                                <li><a class="dropdown-item" href="#">Oldest</a></li>
                                <li><a class="dropdown-item" href="#">Name A-Z</a></li>
                                <li><a class="dropdown-item" href="#">Name Z-A</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty listApply}">
                                <div class="list-group list-group-flush">
                                    <c:forEach items="${listApply}" var="apply">
                                        <div class="list-group-item mb-3 candidate-card">
                                            <div class="row align-items-center">
                                                
                                                <div class="col">
                                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                                        <span class="badge ${apply.statusApply == 'Pending' ? 'bg-warning' : 
                                                                 apply.statusApply == 'Viewed' ? 'bg-info' : 'bg-danger'}">
                                                            <i class="fas ${apply.statusApply == 'Pending' ? 'fa-clock' : 
                                                                          apply.statusApply == 'Viewed' ? 'fa-eye' : 'fa-times'} me-1"></i>
                                                            ${apply.statusApply}
                                                        </span>
                                                    </div>
                                                    <div class="text-muted small mb-2">
                                                        <i class="far fa-id-card me-1"></i> Ứng tuyển #${apply.applyID}
                                                    </div>

                                                    <div class="d-flex align-items-center text-muted small mb-3">
                                                        <i class="far fa-clock me-1"></i>
                                                        Ứng tuyển vào <span class="ms-1 fw-bold">
                                                            <fmt:formatDate value="${apply.dateApply}" pattern="dd/MM/yyyy HH:mm"/>
                                                        </span>
                                                    </div>
                                                    <c:if test="${not empty apply.coverLetter}">
                                                        <div class="mb-3">
                                                            <button class="btn btn-sm btn-outline-primary d-flex align-items-center" 
                                                                    type="button" 
                                                                    data-bs-toggle="collapse" 
                                                                    data-bs-target="#coverLetter${apply.applyID}"
                                                                    aria-expanded="false"
                                                                    aria-controls="coverLetter${apply.applyID}">
                                                                <i class="fas fa-envelope-open-text me-2"></i>
                                                                <span class="toggle-text">Xem thư xin việc</span>
                                                            </button>
                                                            <div class="collapse mt-2" id="coverLetter${apply.applyID}">
                                                                <div class="card border-primary">
                                                                    <div class="card-header bg-light d-flex justify-content-between align-items-center">
                                                                        <h6 class="mb-0 text-primary">
                                                                            <i class="fas fa-file-alt me-2"></i>Thư xin việc
                                                                        </h6>
                                                                        <small class="text-muted">
                                                                            <i class="far fa-calendar-alt me-1"></i>
                                                                            <fmt:formatDate value="${apply.dateApply}" pattern="dd/MM/yyyy HH:mm"/>
                                                                        </small>
                                                                    </div>
                                                                    <div class="card-body">
                                                                        <div class="cover-letter-content">
                                                                            ${apply.coverLetter}
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:if>
                                                    <div class="d-flex gap-2">
                                                        <c:choose>
                                                            <c:when test="${not empty apply.resumePath}">
                                                                <form method="get" action="PDFController" class="d-inline" >
                                                                    <input type="hidden" name="resumePath" value="${fn:escapeXml(apply.resumePath)}" />
                                                                    <input type="hidden" name="postID" value="${apply.postID}" />
                                                                    <button type="submit" class="btn btn-primary btn-sm" 
                                                                            data-bs-toggle="tooltip" data-bs-placement="top" 
                                                                            title="Tải xuống CV của ứng viên">
                                                                        <i class="fas fa-file-pdf me-1"></i> Tải CV
                                                                    </button>
                                                                </form>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <button type="button" class="btn btn-outline-secondary btn-sm" 
                                                                        data-bs-toggle="tooltip" data-bs-placement="top" 
                                                                        title="Ứng viên chưa tải lên CV">
                                                                    <i class="far fa-file-pdf me-1"></i> Không có CV
                                                                </button>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <button class="btn btn-outline-primary btn-sm contact-btn" 
                                                                data-apply-id="${apply.applyID}"
                                                                data-post-id="${apply.postID}"
                                                                data-freelancer-id="${apply.freelancerID}">
                                                            <i class="fas fa-envelope me-1"></i> Liên hệ
                                                        </button>
                                                    </div>
                                                </div>
                                                <div class="col-auto">
                                                    <div class="btn-group">
                                                        <form action="RecruiterListPostController" method="POST" >
                                                            <input type="hidden" name="action" value="changeStatusApply">
                                                            <input type="hidden" name="applyID" value="${apply.applyID}">
                                                            <input type="hidden" name="postID" value="${apply.postID}">
                                                            <input type="hidden" name="freelancerID" value="${apply.freelancerID}">
                                                            <c:if test="${apply.statusApply != 'Pending'}">
                                                                <input type="hidden" name="mess" value="Pending">
                                                                <button type="submit" 
                                                                        class="btn btn-sm btn-outline-warning update-status-btn"
                                                                        data-apply-id="${apply.applyID}"
                                                                        data-status="Pending">
                                                                    <i class="fas fa-clock me-1"></i> Pending
                                                                </button>
                                                            </c:if>
                                                        </form>        
                                                        <form action="RecruiterListPostController" method="POST" >
                                                            <input type="hidden" name="action" value="changeStatusApply">
                                                            <input type="hidden" name="applyID" value="${apply.applyID}">
                                                            <input type="hidden" name="postID" value="${apply.postID}">
                                                            <input type="hidden" name="freelancerID" value="${apply.freelancerID}">
                                                            <c:if test="${apply.statusApply != 'Rejected'}">
                                                                <input type="hidden" name="mess" value="Reject">
                                                                <button type="submit"
                                                                        class="btn btn-sm btn-outline-danger update-status-btn"
                                                                        data-apply-id="${apply.applyID}"
                                                                        data-status="Rejected">
                                                                    <i class="fas fa-times me-1"></i> Reject
                                                                </button>
                                                            </c:if>
                                                        </form>
                                                        <form action="RecruiterListPostController" method="POST" >
                                                            <input type="hidden" name="action" value="changeStatusApply">
                                                            <input type="hidden" name="applyID" value="${apply.applyID}">
                                                            <input type="hidden" name="postID" value="${apply.postID}">
                                                            <input type="hidden" name="freelancerID" value="${apply.freelancerID}">
                                                            <c:if test="${apply.statusApply != 'Completed'}">
                                                                <input type="hidden" name="mess" value="Complete">
                                                                <button type="submit"
                                                                        class="btn btn-sm btn-outline-success update-status-btn"
                                                                        data-apply-id="${apply.applyID}"
                                                                        data-status="Completed">
                                                                    <i class="fas fa-check-circle me-1"></i> Complete
                                                                </button>
                                                            </c:if>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-info mb-0">
                                    <i class="fas fa-info-circle me-2"></i> No candidates have applied for this position yet.
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

               
            </main>
        </div>
    </div>

    <!-- Resume Preview Modal -->
    <div class="modal fade" id="resumePreviewModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Resume Preview</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="ratio ratio-16x9">
                        <iframe id="resumeFrame" class="w-100" style="height: 70vh;"></iframe>
                    </div>
                </div>
                <div class="modal-footer">
                    <a id="downloadResumeBtn" href="#" class="btn btn-primary" download>
                        <i class="fas fa-download me-1"></i> Download
                    </a>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Single Contact Modal -->
    <div class="modal fade" id="contactModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Gửi tin nhắn cho ứng viên (Đơn #<span id="applyIdDisplay"></span>)</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="contactForm" action="RecruiterListPostController" method="POST">
                        <input type="hidden" name="action" value="messageNoti">
                        <input type="hidden" id="applyId" name="applyID" value="">
                        <input type="hidden" id="postId" name="postID" value="">
                        <input type="hidden" id="freelancerId" name="freelancerID" value="">
                        <div class="mb-3">
                            <label class="form-label">Nội dung</label>
                            <textarea class="form-control" name="message" rows="4" required></textarea>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-paper-plane me-1"></i> Gửi tin nhắn
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Success Toast -->
    <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 9999">
        <div id="successToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true" data-bs-autohide="true" data-bs-delay="5000">
            <div class="toast-header bg-success text-white">
                <strong class="me-auto">Thành công</strong>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
            <div class="toast-body">
                <i class="fas fa-check-circle me-2"></i> Đã gửi tin nhắn thành công!
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        // Initialize tooltips and contact modal
        document.addEventListener('DOMContentLoaded', function() {
            // Initialize contact modal
            const contactModal = new bootstrap.Modal(document.getElementById('contactModal'));
            
            // Handle contact button clicks
            document.addEventListener('click', function(e) {
                if (e.target.closest('.contact-btn')) {
                    const btn = e.target.closest('.contact-btn');
                    const applyId = btn.dataset.applyId;
                    const postId = btn.dataset.postId;
                    const freelancerId = btn.dataset.freelancerId;
                    
                    // Update modal content with the selected application's data
                    document.getElementById('applyIdDisplay').textContent = applyId;
                    document.getElementById('applyId').value = applyId;
                    document.getElementById('postId').value = postId;
                    document.getElementById('freelancerId').value = freelancerId;
                    
                    // Clear previous messages
                    document.getElementById('contactForm').reset();
                    
                    // Show the modal
                    contactModal.show();
                }
            });
            
            // Initialize toast
            const toastEl = document.getElementById('successToast');
            const toast = new bootstrap.Toast(toastEl);
            
            // Handle form submission
            document.getElementById('contactForm').addEventListener('submit', function(e) {
                // Let the form submit normally - the server will handle the redirect
                // Just hide the modal first
                const modal = bootstrap.Modal.getInstance(document.getElementById('contactModal'));
                modal.hide();
            });
            var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
            var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                return new bootstrap.Tooltip(tooltipTriggerEl);
            });
        });
        
        // Function to open schedule interview modal
        function scheduleInterview(applyId, candidateName) {
            document.getElementById('applyId').value = applyId;
            document.querySelector('#scheduleInterviewModal .modal-title').textContent = 
                'Schedule Interview for ' + candidateName;
            
            // Reset form
            document.getElementById('interviewForm').reset();
            
            // Show modal
            const modal = new bootstrap.Modal(document.getElementById('scheduleInterviewModal'));
            modal.show();
        }

        // Function to send message
        function sendMessage(candidateId, candidateName) {
            alert(`Send message to ${candidateName} (ID: ${candidateId})`);
            // Implement message sending functionality
        }

        function confirmDelete(applicationId) {
            if (confirm('Are you sure you want to remove this candidate from the list?')) {
                console.log(`Delete application ${applicationId}`);
                // Call API or submit form to delete
            }
        }

        // Initialize tooltips and event listeners when DOM is loaded
        document.addEventListener('DOMContentLoaded', function() {
            // Initialize Bootstrap tooltips
            const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
            tooltipTriggerList.map(function (tooltipTriggerEl) {
                return new bootstrap.Tooltip(tooltipTriggerEl);
            });

            // Add click event listeners to schedule buttons
            document.querySelectorAll('.schedule-interview-btn').forEach(button => {
                button.addEventListener('click', function() {
                    const applyId = this.getAttribute('data-apply-id');
                    const candidateName = this.getAttribute('data-candidate-name');
                    scheduleInterview(applyId, candidateName);
                });
            });

            // Add click event listeners to update status buttons
            document.querySelectorAll('.update-status-btn').forEach(button => {
                button.addEventListener('click', function() {
                    const applyId = this.getAttribute('data-apply-id');
                    const status = this.getAttribute('data-status');
                    updateStatus(applyId, status);
                });
            });

           
        });

        // Handle interview type change
        document.getElementById('interviewType').addEventListener('change', function() {
            const type = this.value;
            const locationLabel = document.getElementById('locationLabel');
            const locationDetails = document.getElementById('locationDetails');
            
            if (type === 'onsite') {
                locationLabel.textContent = 'Location';
                locationDetails.placeholder = 'Enter the interview address';
            } else if (type === 'google_meet' || type === 'zoom') {
                locationLabel.textContent = 'Meeting Link';
                locationDetails.placeholder = 'Enter the meeting link';
            } else if (type === 'phone') {
                locationLabel.textContent = 'Phone Number';
                locationDetails.placeholder = 'Enter the phone number';
            }
        });

        // Handle save schedule button click
        document.getElementById('saveScheduleBtn').addEventListener('click', function() {
            const form = document.getElementById('interviewForm');
            if (form.checkValidity()) {
                const interviewData = {
                    applyId: document.getElementById('applyId').value,
                    date: document.getElementById('interviewDate').value,
                    time: document.getElementById('interviewTime').value,
                    type: document.getElementById('interviewType').value,
                    details: document.getElementById('locationDetails').value,
                    sendEmail: document.getElementById('sendEmail').checked
                };
                
                // Here you would typically make an AJAX call to save the interview
                console.log('Saving interview:', interviewData);
                
                // Show success message and close modal
                alert('Interview scheduled successfully!');
                const modal = bootstrap.Modal.getInstance(document.getElementById('scheduleInterviewModal'));
                modal.hide();
            } else {
                form.reportValidity();
            }
        });
    </script>
</body>
</html>
