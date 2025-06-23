<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, Model.Post, Model.Category, Model.JobType, Model.Duration, Model.UserLoginInfo, java.text.SimpleDateFormat, DAO.RecruiterDAO, Model.Recruiter" %>
<%
    // =================================================================
    // Dữ liệu từ Controller (Giữ nguyên)
    // =================================================================
    UserLoginInfo user = (UserLoginInfo) session.getAttribute("user");
    List<Post> jobs = (List<Post>) request.getAttribute("jobs");
    List<Category> categories = (List<Category>) request.getAttribute("categories");
    List<JobType> jobTypes = (List<JobType>) request.getAttribute("jobTypes");
    List<Duration> durations = (List<Duration>) request.getAttribute("durations");
    List<Integer> favoritePostIds = (List<Integer>) request.getAttribute("favoritePostIds");
    Integer totalJobs = (Integer) request.getAttribute("totalJobs");
    String error = (String) request.getAttribute("error");
    
    // Search parameters (Giữ nguyên)
    String searchKeyword = (String) request.getAttribute("searchKeyword");
    String searchLocation = (String) request.getAttribute("searchLocation");
    String searchCategoryId = (String) request.getAttribute("searchCategoryId");
    String searchJobTypeId = (String) request.getAttribute("searchJobTypeId");
    
    SimpleDateFormat sdf = new SimpleDateFormat("MMM dd, yyyy");

    // =================================================================
    // Dữ liệu cho Header của Recruiter (Phần được thêm vào)
    // =================================================================
    String avatarPath = "img/candiateds/1.png";
    String userName = "User"; // Default name
    if (user != null && "recruiter".equals(user.getUserType())) {
        RecruiterDAO recruiterDAO = new RecruiterDAO();
        Recruiter currentRecruiter = recruiterDAO.getRecruiterById(user.getUserID());
        if (currentRecruiter != null) {
            if (currentRecruiter.getImage() != null && !currentRecruiter.getImage().isEmpty()) {
                avatarPath = currentRecruiter.getImage();
            }
            userName = currentRecruiter.getFirstName();
        }
    } else if (user != null && "freelancer".equals(user.getUserType())) {
        // Có thể thêm logic lấy tên freelancer ở đây nếu cần
        userName = "Freelancer";
    }
%>
<%!
    // Helper methods (Giữ nguyên)
    public String getCategoryName(int categoryId, List<Category> categories) {
        if (categories != null) { for (Category cat : categories) { if (cat.getCategoryID() == categoryId) return cat.getCategoryName(); } }
        return "Unknown";
    }
    public String getJobTypeName(int jobTypeId, List<JobType> jobTypes) {
        if (jobTypes != null) { for (JobType jt : jobTypes) { if (jt.getJobTypeID() == jobTypeId) return jt.getJobTypeName(); } }
        return "Unknown";
    }
    public String getDurationName(int durationId, List<Duration> durations) {
        if (durations != null) { for (Duration dur : durations) { if (dur.getDurationID() == durationId) return dur.getDurationName(); } }
        return "Unknown";
    }
    public boolean isFavorited(int postId, List<Integer> favoritePostIds) {
        return favoritePostIds != null && favoritePostIds.contains(postId);
    }
%>
<!doctype html>
<html class="no-js" lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Browse Jobs - Job Board</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSS here -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/themify-icons.css">
    <link rel="stylesheet" href="css/nice-select.css">
    <link rel="stylesheet" href="css/jquery-ui.css">
    <link rel="stylesheet" href="css/style.css">
    
    <style>
        /* CSS cho header của recruiter (được thêm vào) */
        .profile-btn {
            display: flex !important; align-items: center;
            background: linear-gradient(135deg, #00D363 0%, #28a745 100%) !important;
            color: white !important; padding: 8px 16px; border-radius: 25px; text-decoration: none !important;
            transition: all 0.3s ease; box-shadow: 0 2px 10px rgba(0, 211, 99, 0.3); margin-right: 10px; font-weight: 500;
        }
        .profile-btn:hover { background: linear-gradient(135deg, #28a745 0%, #00D363 100%) !important; transform: translateY(-2px); }
        .profile-avatar { width: 32px; height: 32px; border-radius: 50%; border: 2px solid white; margin-right: 10px; object-fit: cover; }
        .logout-btn { color: #dc3545 !important; font-weight: 500; padding: 8px 12px; border-radius: 20px; transition: all 0.3s ease; text-decoration: none !important; }
        .logout-btn:hover { background-color: #dc3545 !important; color: white !important; }
        .Appointment { display: flex; align-items: center; gap: 15px; }

        /* CSS của bạn cho phần thân trang (GIỮ NGUYÊN) */
        .job-card {
            background: white; border-radius: 10px; padding: 25px; margin-bottom: 20px;
            box-shadow: 0 3px 15px rgba(0,0,0,0.1); transition: all 0.3s ease; border-left: 4px solid #3498db;
        }
        .job-card:hover { transform: translateY(-3px); box-shadow: 0 8px 25px rgba(0,0,0,0.15); }
        .job-header { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 15px; }
        .job-info { flex: 1; }
        .job-title { color: #2c3e50; font-size: 20px; font-weight: 700; margin-bottom: 8px; line-height: 1.3; }
        .job-title a { color: inherit; text-decoration: none; transition: color 0.3s ease; }
        .job-title a:hover { color: #3498db; text-decoration: none; }
        .job-meta { display: flex; flex-wrap: wrap; gap: 15px; margin-bottom: 12px; }
        .meta-item { display: flex; align-items: center; color: #7f8c8d; font-size: 13px; }
        .meta-item i { margin-right: 5px; color: #3498db; font-size: 12px; }
        .job-description {
            color: #34495e; line-height: 1.6; margin-bottom: 15px; display: -webkit-box;
            -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;
        }
        .job-actions { display: flex; justify-content: space-between; align-items: center; }
        .budget-info {
            background: linear-gradient(135deg, #27ae60, #229954); color: white; padding: 8px 12px;
            border-radius: 6px; font-weight: 600; font-size: 13px;
        }
        .action-buttons { display: flex; gap: 8px; }
        .btn-action {
            padding: 6px 12px; border-radius: 5px; text-decoration: none; font-size: 12px;
            font-weight: 600; transition: all 0.3s ease; border: none; cursor: pointer;
        }
        .btn-primary { background: linear-gradient(135deg, #3498db, #2980b9); color: white; }
        .btn-warning { background: linear-gradient(135deg, #f39c12, #e67e22); color: white; }
        .btn-danger { background: linear-gradient(135deg, #e74c3c, #c0392b); color: white; }
        .btn-action:hover { transform: translateY(-1px); box-shadow: 0 3px 10px rgba(0,0,0,0.2); color: white; text-decoration: none; }
        .favorite-btn { background: none; border: 2px solid #e74c3c; color: #e74c3c; padding: 6px 10px; border-radius: 50%; transition: all 0.3s ease; }
        .favorite-btn.favorited { background: #e74c3c; color: white; }
        .favorite-btn:hover { background: #e74c3c; color: white; transform: scale(1.1); }
        .search-results-header { background: white; padding: 20px; border-radius: 10px; margin-bottom: 20px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .filter-section { background: white; padding: 25px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); margin-bottom: 30px; }
        .empty-state { text-align: center; padding: 60px 20px; background: white; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .empty-icon { font-size: 48px; color: #bdc3c7; margin-bottom: 15px; }
        .alert { padding: 15px; margin-bottom: 20px; border: 1px solid transparent; border-radius: 8px; }
        .alert-danger { color: #721c24; background-color: #f8d7da; border-color: #f5c6cb; }
        @media (max-width: 768px) {
            .job-header { flex-direction: column; gap: 10px; }
            .job-meta { gap: 10px; }
            .job-actions { flex-direction: column; gap: 10px; align-items: stretch; }
            .action-buttons { justify-content: center; }
        }
    </style>
</head>

<body>
    <!-- header-start (ĐÃ ĐƯỢC THAY THẾ) -->
    <header>
        <div class="header-area ">
            <div id="sticky-header" class="main-header-area">
                <div class="container-fluid">
                    <div class="header_bottom_border">
                        <div class="row align-items-center">
                            <div class="col-xl-3 col-lg-2">
                                <div class="logo"><a href="index_recruiter.jsp"><img src="img/logo.png" alt=""></a></div>
                            </div>
                            <div class="col-xl-6 col-lg-7">
                                <div class="main-menu d-none d-lg-block">
                                    <nav>
                                        <ul id="navigation">
                                            <c:if test="${sessionScope.recruiter != null}">
                                                <li><a href="index_recruiter.jsp">Home</a></li>
                                            </c:if>
                                            <c:if test="${sessionScope.jobseeker != null}">
                                                <li><a href="index.jsp">Home</a></li>
                                            </c:if>
                                            <li><a href="jobs" class="active">Browse Jobs</a></li>
                                            <c:if test="${sessionScope.recruiter != null}">
                                                  <li><a href="post?action=list">My Jobs</a></li>
                                            </c:if>
                                            
                                            <li><a href="#">Pages <i class="ti-angle-down"></i></a>
                                                <ul class="submenu">
                                                    <li><a href="freelancer_list.jsp">Candidates</a></li>
                                                    <li><a href="job_details.jsp">Job Details</a></li>
                                                </ul>
                                            </li>
                                            <li><a href="contact.jsp">Contact</a></li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                            <div class="col-xl-3 col-lg-3 d-none d-lg-block">
                                <div class="Appointment">
                                    <c:if test="${sessionScope.recruiter != null}">
                                        <div class="phone_num d-none d-xl-block">
                                            <a href="recruiter_profile.jsp" class="profile-btn">
                                                <img src="${avatarPath}" alt="Avatar" class="profile-avatar">
                                                <span>${userName}</span>
                                            </a>
                                        </div>
                                        <div class="phone_num d-none d-xl-block">
                                            <a href="${pageContext.request.contextPath}/logout" class="logout-btn"><i class="ti-power-off"></i> Logout</a>
                                        </div>
                                        <div class="d-none d-lg-block">
                                            <a class="boxed-btn3" href="post?action=create">Post a Job</a>
                                        </div>
                                    </c:if>

                                    <c:if test="${sessionScope.jobseeker != null}">
                                        <div class="col-xl-3 col-lg-3 d-none d-lg-block">
                                        <div class="d-none d-lg-block">
                                            <a href="jobseeker_profile.jsp">
                                                <img src="${sessionScope.jobseeker.image}" alt="Avatar" style="width: 40px; height: 40px; border-radius: 50%;">
                                            </a>
                                        </div>
                                    </div>
                                    </c:if>

                                </div>
                            </div>
                            <div class="col-12"><div class="mobile_menu d-block d-lg-none"></div></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>
    
    <div class="bradcam_area bradcam_bg_1">
        <div class="container">
            <div class="row">
                <div class="col-xl-12">
                    <div class="bradcam_text">
                        <h3><%= totalJobs != null ? totalJobs : 0 %>+ Jobs Available</h3>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Message Display Section -->
    <div class="container mt-3">
        <% String message = (String) session.getAttribute("message"); 
           String messageType = (String) session.getAttribute("messageType");
           if (message != null && !message.isEmpty()) { 
        %>
            <div class="alert alert-<%= messageType != null ? messageType : "info" %> alert-dismissible fade show" role="alert">
                <%= message %>
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        <% 
            // Remove the message from session after displaying
            session.removeAttribute("message");
            session.removeAttribute("messageType");
           } 
        %>
    </div>
    
    <div class="job_listing_area plus_padding">
        <div class="container">
            <div class="row">
                <div class="col-lg-3">
                    <!-- Filter Section -->
                    <div class="filter-section">
                        <h3>Filter Jobs</h3>
                        <form action="jobs" method="get">
                            <input type="hidden" name="action" value="search">
                            
                            <div class="form-group mb-3">
                                <input type="text" name="keyword" class="form-control" 
                                       placeholder="Search keyword" 
                                       value="<%= searchKeyword != null ? searchKeyword : "" %>">
                            </div>
                            
                            <div class="form-group mb-3">
                                <input type="text" name="location" class="form-control" 
                                       placeholder="Location" 
                                       value="<%= searchLocation != null ? searchLocation : "" %>">
                            </div>
                            
                            <div class="form-group mb-3">
                                <select name="categoryId" class="form-control">
                                    <option value="">All Categories</option>
                                    <% if (categories != null) {
                                        for (Category category : categories) { %>
                                            <option value="<%= category.getCategoryID() %>" 
                                                    <%= String.valueOf(category.getCategoryID()).equals(searchCategoryId) ? "selected" : "" %>>
                                                <%= category.getCategoryName() %>
                                            </option>
                                    <%  }
                                       } %>
                                </select>
                            </div>
                            
                            <div class="form-group mb-3">
                                <select name="jobTypeId" class="form-control">
                                    <option value="">All Job Types</option>
                                    <% if (jobTypes != null) {
                                        for (JobType jobType : jobTypes) { %>
                                            <option value="<%= jobType.getJobTypeID() %>" 
                                                    <%= String.valueOf(jobType.getJobTypeID()).equals(searchJobTypeId) ? "selected" : "" %>>
                                                <%= jobType.getJobTypeName() %>
                                            </option>
                                    <%  }
                                       } %>
                                </select>
                            </div>
                            
                            <button type="submit" class="btn btn-primary w-100 mb-2">Search Jobs</button>
                            <a href="jobs" class="btn btn-secondary w-100">Clear Filters</a>
                        </form>
                    </div>
                </div>
                
                <div class="col-lg-9">
                    <!-- Search Results Header -->
                    <div class="search-results-header">
                        <div class="d-flex justify-content-between align-items-center">
                            <h4>
                                <% if (searchKeyword != null || searchLocation != null || searchCategoryId != null || searchJobTypeId != null) { %>
                                    Search Results
                                <% } else { %>
                                    All Jobs
                                <% } %>
                                <span class="text-muted">(<%= totalJobs != null ? totalJobs : 0 %> jobs found)</span>
                            </h4>
                            
                            
                          
                        </div>
                    </div>

                    <!-- Error Message -->
                    <% if (error != null) { %>
                        <div class="alert alert-danger">
                            <i class="fa fa-exclamation-triangle"></i> <%= error %>
                        </div>
                    <% } %>

                    <!-- Jobs List -->
                    <% if (jobs != null && !jobs.isEmpty()) { %>
                        <div class="jobs-list">
                            <% for (Post job : jobs) { %>
                                <div class="job-card">
                                    <div class="job-header">
                                        <div class="job-info">
                                            <h3 class="job-title">
                                                <a href="post?action=view&id=<%= job.getPostId() %>">
                                                    <%= job.getTitle() %>
                                                </a>
                                            </h3>
                                            
                                            <div class="job-meta">
                                                <div class="meta-item"><i class="fa fa-map-marker"></i><span><%= job.getLocation() %></span></div>
                                                <div class="meta-item"><i class="fa fa-briefcase"></i><span><%= getJobTypeName(job.getJobTypeId(), jobTypes) %></span></div>
                                                <div class="meta-item"><i class="fa fa-clock-o"></i><span><%= getDurationName(job.getDurationId(), durations) %></span></div>
                                                <div class="meta-item"><i class="fa fa-tag"></i><span><%= getCategoryName(job.getCategoryId(), categories) %></span></div>
                                                <div class="meta-item"><i class="fa fa-calendar"></i><span><%= sdf.format(job.getDatePost()) %></span></div>
                                            </div>
                                        </div>
                                        
                                        <% if (user != null && "freelancer".equals(user.getUserType())) { %>
                                            <button type="button" 
                                                    class="favorite-btn <%= isFavorited(job.getPostId(), favoritePostIds) ? "favorited" : "" %>" 
                                                    onclick="toggleFavorite(<%= job.getPostId() %>, this)"
                                                    title="<%= isFavorited(job.getPostId(), favoritePostIds) ? "Remove from favorites" : "Add to favorites" %>">
                                                <i class="fa fa-heart<%= isFavorited(job.getPostId(), favoritePostIds) ? "" : "-o" %>"></i>
                                            </button>
                                        <% } %>
                                    </div>
                                    
                                    <div class="job-description">
                                        <%= job.getDescription().length() > 150 ? 
                                            job.getDescription().substring(0, 150) + "..." : 
                                            job.getDescription() %>
                                    </div>
                                    
                                    <div class="job-actions">
                                        <% if (job.getBudgetMin() != null || job.getBudgetMax() != null) { %>
                                            <div class="budget-info">
                                                <% if (job.getBudgetMin() != null && job.getBudgetMax() != null) { %>
                                                    $<%= job.getBudgetMin() %> - $<%= job.getBudgetMax() %>
                                                <% } else if (job.getBudgetMin() != null) { %>
                                                    From $<%= job.getBudgetMin() %>
                                                <% } else { %>
                                                    Up to $<%= job.getBudgetMax() %>
                                                <% } %>
                                                <% if (job.getBudgetType() != null) { %><br><small><%= job.getBudgetType() %></small><% } %>
                                            </div>
                                        <% } else { %>
                                            <div class="meta-item"><i class="fa fa-users"></i><span><%= job.getQuantity() %> position<%= job.getQuantity() > 1 ? "s" : "" %></span></div>
                                        <% } %>
                                        
                                                <div class="action-buttons">
                                            <a href="post?action=view&id=<%= job.getPostId() %>" class="btn-action btn-primary"><i class="fa fa-eye"></i> View Details</a>
                                            <c:if test="${sessionScope.recruiter == null}">
                                                

                                                <c:if test="${sessionScope.jobseeker == null}">
                                                    <a href="login.jsp" class="btn-action btn-warning">
                                                        <i class="fa fa-sign-in"></i> Login to Apply
                                                    </a>
                                                </c:if>
                                            </c:if> 
                                        </div>
                                        
                                        
                                    </div>
                                </div>
                            <% } %>
                        </div>
                    <% } else { %>
                        <div class="empty-state">
                            <div class="empty-icon"><i class="fa fa-search"></i></div>
                            <h3>No Jobs Found</h3>
                            <p>
                                <% if (searchKeyword != null || searchLocation != null || searchCategoryId != null || searchJobTypeId != null) { %>
                                    Try adjusting your search criteria or browse all available jobs.
                                <% } else { %>
                                    There are no job postings available at the moment. Please check back later.
                                <% } %>
                            </p>
                            <% if (searchKeyword != null || searchLocation != null || searchCategoryId != null || searchJobTypeId != null) { %>
                                <a href="jobs" class="btn-action btn-primary"><i class="fa fa-list"></i> View All Jobs</a>
                            <% } %>
                        </div>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
    <script src="js/vendor/jquery-1.12.4.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/nice-select.min.js"></script>
    <script src="js/main.js"></script>
    
    <script>
    // Function to handle favorite button click
    function toggleFavorite(postId, button) {
        // Show loading state
        const icon = button.querySelector('i');
        const originalIcon = icon.className;
        icon.className = 'fa fa-spinner fa-spin';
        
        // Get jobseeker ID from JSP variable
        const jobseekerId = '<%= user != null && "freelancer".equals(user.getUserType()) ? user.getUserID() : "" %>';
        
        if (!jobseekerId) {
            // If user is not logged in, redirect to login page
            window.location.href = 'login.jsp?redirect=' + encodeURIComponent(window.location.pathname + window.location.search);
            return;
        }
        
        // Send AJAX request to add/remove favorite
        fetch('favorite?action=add&jobseekerID=' + jobseekerId + '&postID=' + postId, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                // Toggle favorite state
                button.classList.toggle('favorited');
                icon.className = button.classList.contains('favorited') ? 'fa fa-heart' : 'fa fa-heart-o';
                
                // Show success toast
                showToast(data.message, 'success');
            } else {
                // Show error message
                showToast(data.message, 'danger');
                icon.className = originalIcon;
            }
        })
        .catch(error => {
            console.error('Error:', error);
            showToast('An error occurred. Please try again.', 'danger');
            icon.className = originalIcon;
        });
    }
    
    // Function to show toast notification
    function showToast(message, type) {
        // Create toast element
        const toast = document.createElement('div');
        toast.className = `toast align-items-center text-white bg-${type} border-0 position-fixed bottom-0 end-0 m-3`;
        toast.setAttribute('role', 'alert');
        toast.setAttribute('aria-live', 'assertive');
        toast.setAttribute('aria-atomic', 'true');
        toast.style.zIndex = '1100';
        
        // Add toast content
        toast.innerHTML = `
            <div class="d-flex">
                <div class="toast-body">
                    ${message}
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
        `;
        
        // Add to body
        document.body.appendChild(toast);
        
        // Initialize and show toast
        const bsToast = new bootstrap.Toast(toast);
        bsToast.show();
        
        // Remove toast after it's hidden
        toast.addEventListener('hidden.bs.toast', function() {
            document.body.removeChild(toast);
        });
    }
    
    // Initialize tooltips
    document.addEventListener('DOMContentLoaded', function() {
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });
    });
    </script>
</body>
</html>