<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Model.FreelancerFavorite" %>
<%@ page import="Model.Post" %>
<%@ page import="Model.Category" %>
<%@ page import="Model.JobType" %>
<%@ page import="Model.Duration" %>
<%@ page import="Model.UserLoginInfo" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    UserLoginInfo user = (UserLoginInfo) session.getAttribute("user");
    if (user == null || !"freelancer".equals(user.getUserType())) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    List<FreelancerFavorite> favorites = (List<FreelancerFavorite>) request.getAttribute("favorites");
    List<Category> categories = (List<Category>) request.getAttribute("categories");
    List<JobType> jobTypes = (List<JobType>) request.getAttribute("jobTypes");
    List<Duration> durations = (List<Duration>) request.getAttribute("durations");
    Integer favoriteCount = (Integer) request.getAttribute("favoriteCount");
    String error = (String) request.getAttribute("error");
    
    SimpleDateFormat sdf = new SimpleDateFormat("MMM dd, yyyy");
%>
<%!
    // Helper methods để tìm tên theo ID
    public String getCategoryName(int categoryId, List<Category> categories) {
        if (categories != null) {
            for (Category cat : categories) {
                if (cat.getCategoryID() == categoryId) {
                    return cat.getCategoryName();
                }
            }
        }
        return "Unknown";
    }
    
    public String getJobTypeName(int jobTypeId, List<JobType> jobTypes) {
        if (jobTypes != null) {
            for (JobType jt : jobTypes) {
                if (jt.getJobTypeID() == jobTypeId) {
                    return jt.getJobTypeName();
                }
            }
        }
        return "Unknown";
    }
    
    public String getDurationName(int durationId, List<Duration> durations) {
        if (durations != null) {
            for (Duration dur : durations) {
                if (dur.getDurationID() == durationId) {
                    return dur.getDurationName();
                }
            }
        }
        return "Unknown";
    }
%>
<!doctype html>
<html class="no-js" lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>My Favorite Jobs</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSS here -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/themify-icons.css">
    <link rel="stylesheet" href="css/style.css">
    
    <style>
        .favorites-container {
            padding: 50px 0;
            background-color: #f8f9fa;
            min-height: 70vh;
        }
        
        .page-header {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            text-align: center;
        }
        
        .page-title {
            color: #2c3e50;
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 10px;
        }
        
        .page-subtitle {
            color: #7f8c8d;
            font-size: 16px;
            margin: 0;
        }
        
        .favorite-count {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            color: white;
            padding: 8px 16px;
            border-radius: 25px;
            font-size: 14px;
            font-weight: 600;
            display: inline-block;
            margin-left: 15px;
        }
        
        .job-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 25px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        
        .job-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 40px rgba(0,0,0,0.15);
        }
        
        .job-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: linear-gradient(135deg, #3498db, #2980b9);
        }
        
        .job-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 20px;
        }
        
        .job-info {
            flex: 1;
        }
        
        .job-title {
            color: #2c3e50;
            font-size: 22px;
            font-weight: 700;
            margin-bottom: 10px;
            line-height: 1.3;
        }
        
        .job-title a {
            color: inherit;
            text-decoration: none;
            transition: color 0.3s ease;
        }
        
        .job-title a:hover {
            color: #3498db;
            text-decoration: none;
        }
        
        .job-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 15px;
        }
        
        .meta-item {
            display: flex;
            align-items: center;
            color: #7f8c8d;
            font-size: 14px;
        }
        
        .meta-item i {
            margin-right: 6px;
            color: #3498db;
            font-size: 14px;
        }
        
        .job-description {
            color: #34495e;
            line-height: 1.6;
            margin-bottom: 20px;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        
        .job-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #ecf0f1;
        }
        
        .budget-info {
            background: linear-gradient(135deg, #27ae60, #229954);
            color: white;
            padding: 10px 15px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 14px;
        }
        
        .action-buttons {
            display: flex;
            gap: 10px;
        }
        
        .btn-action {
            padding: 8px 16px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
        }
        
        .btn-danger {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            color: white;
        }
        
        .btn-action:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            color: white;
            text-decoration: none;
        }
        
        .favorite-date {
            position: absolute;
            top: 20px;
            right: 20px;
            background: rgba(52, 73, 94, 0.1);
            color: #34495e;
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: 500;
        }
        
        .empty-state {
            text-align: center;
            padding: 80px 20px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.1);
        }
        
        .empty-icon {
            font-size: 64px;
            color: #bdc3c7;
            margin-bottom: 20px;
        }
        
        .empty-title {
            color: #2c3e50;
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 10px;
        }
        
        .empty-text {
            color: #7f8c8d;
            font-size: 16px;
            margin-bottom: 30px;
        }
        
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid transparent;
            border-radius: 8px;
        }
        
        .alert-danger {
            color: #721c24;
            background-color: #f8d7da;
            border-color: #f5c6cb;
        }
        
        @media (max-width: 768px) {
            .job-header {
                flex-direction: column;
                gap: 15px;
            }
            
            .job-meta {
                gap: 15px;
            }
            
            .job-actions {
                flex-direction: column;
                gap: 15px;
                align-items: stretch;
            }
            
            .action-buttons {
                justify-content: center;
            }
        }
    </style>
</head>

<body>
    <!-- header-start -->
    <header>
        <div class="header-area">
            <div id="sticky-header" class="main-header-area">
                <div class="container-fluid">
                    <div class="header_bottom_border">
                        <div class="row align-items-center">
                            <div class="col-xl-3 col-lg-2">
                                <div class="logo">
                                    <a href="index.jsp">
                                        <img src="img/logo.png" alt="">
                                    </a>
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-7">
                                <div class="main-menu d-none d-lg-block">
                                    <nav>
                                        <ul id="navigation">
                                            <li><a href="index.jsp">Home</a></li>
                                            <li><a href="jobs">Browse Jobs</a></li>
                                            <li><a href="favorite?action=list" class="active">My Favorites</a></li>
                                            <li><a href="contact.jsp">Contact</a></li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                            <div class="col-xl-3 col-lg-3 d-none d-lg-block">
                                <div class="Appointment">
                                    <div class="phone_num d-none d-xl-block">
                                        <a href="freelancer_profile.jsp">My Profile</a>
                                    </div>
                                    <div class="phone_num d-none d-xl-block">
                                        <a href="${pageContext.request.contextPath}/logout">Log out</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <!-- header-end -->

    <!-- favorites-area-start -->
    <div class="favorites-container">
        <div class="container">
            <!-- Page Header -->
            <div class="page-header">
                <h1 class="page-title">
                    <i class="fa fa-heart"></i> My Favorite Jobs
                    <% if (favoriteCount != null && favoriteCount > 0) { %>
                        <span class="favorite-count"><%= favoriteCount %> job<%= favoriteCount > 1 ? "s" : "" %></span>
                    <% } %>
                </h1>
                <p class="page-subtitle">Jobs you've saved for later review and application</p>
            </div>

            <!-- Error Message -->
            <% if (error != null) { %>
                <div class="alert alert-danger">
                    <i class="fa fa-exclamation-triangle"></i> <%= error %>
                </div>
            <% } %>

            <!-- Favorites List -->
            <% if (favorites != null && !favorites.isEmpty()) { %>
                <div class="favorites-list">
                    <% for (FreelancerFavorite favorite : favorites) { 
                        Post post = favorite.getPost();
                        if (post != null) { %>
                        <div class="job-card">
                            <div class="favorite-date">
                                <i class="fa fa-heart"></i> <%= sdf.format(favorite.getFavoritedDate()) %>
                            </div>
                            
                            <div class="job-header">
                                <div class="job-info">
                                    <h3 class="job-title">
                                        <a href="post?action=view&id=<%= post.getPostId() %>">
                                            <%= post.getTitle() %>
                                        </a>
                                    </h3>
                                    
                                    <div class="job-meta">
                                        <div class="meta-item">
                                            <i class="fa fa-map-marker"></i>
                                            <span><%= post.getLocation() %></span>
                                        </div>
                                        <div class="meta-item">
                                            <i class="fa fa-briefcase"></i>
                                            <span><%= getJobTypeName(post.getJobTypeId(), jobTypes) %></span>
                                        </div>
                                        <div class="meta-item">
                                            <i class="fa fa-clock-o"></i>
                                            <span><%= getDurationName(post.getDurationId(), durations) %></span>
                                        </div>
                                        <div class="meta-item">
                                            <i class="fa fa-tag"></i>
                                            <span><%= getCategoryName(post.getCategoryId(), categories) %></span>
                                        </div>
                                        <div class="meta-item">
                                            <i class="fa fa-calendar"></i>
                                            <span>Posted: <%= sdf.format(post.getDatePost()) %></span>
                                        </div>
                                    </div>
                                </div>
                                
                                <% if (post.getBudgetMin() != null || post.getBudgetMax() != null) { %>
                                    <div class="budget-info">
                                        <% if (post.getBudgetMin() != null && post.getBudgetMax() != null) { %>
                                            $<%= post.getBudgetMin() %> - $<%= post.getBudgetMax() %>
                                        <% } else if (post.getBudgetMin() != null) { %>
                                            From $<%= post.getBudgetMin() %>
                                        <% } else { %>
                                            Up to $<%= post.getBudgetMax() %>
                                        <% } %>
                                        <% if (post.getBudgetType() != null) { %>
                                            <br><small><%= post.getBudgetType() %></small>
                                        <% } %>
                                    </div>
                                <% } %>
                            </div>
                            
                            <div class="job-description">
                                <%= post.getDescription().length() > 200 ? 
                                    post.getDescription().substring(0, 200) + "..." : 
                                    post.getDescription() %>
                            </div>
                            
                            <div class="job-actions">
                                <div class="meta-item">
                                    <i class="fa fa-users"></i>
                                    <span><%= post.getQuantity() %> position<%= post.getQuantity() > 1 ? "s" : "" %> available</span>
                                </div>
                                
                                <div class="action-buttons">
                                    <a href="post?action=view&id=<%= post.getPostId() %>" class="btn-action btn-primary">
                                        <i class="fa fa-eye"></i> View Details
                                    </a>
                                    <button type="button" class="btn-action btn-danger" 
                                            onclick="removeFavorite(<%= post.getPostId() %>, this)">
                                        <i class="fa fa-heart-o"></i> Remove
                                    </button>
                                </div>
                            </div>
                        </div>
                    <% } 
                    } %>
                </div>
            <% } else { %>
                <!-- Empty State -->
                <div class="empty-state">
                    <div class="empty-icon">
                        <i class="fa fa-heart-o"></i>
                    </div>
                    <h2 class="empty-title">No Favorite Jobs Yet</h2>
                    <p class="empty-text">
                        Start browsing jobs and click the heart icon to save jobs you're interested in.
                    </p>
                    <a href="jobs" class="btn-action btn-primary" style="padding: 12px 24px; font-size: 16px;">
                        <i class="fa fa-search"></i> Browse Jobs
                    </a>
                </div>
            <% } %>
        </div>
    </div>
    <!-- favorites-area-end -->

    <!-- JS here -->
    <script src="js/vendor/jquery-1.12.4.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/main.js"></script>
    
    <script>
        // Function để remove favorite
        function removeFavorite(postId, button) {
            if (!confirm('Are you sure you want to remove this job from your favorites?')) {
                return;
            }
            
            // Disable button
            button.disabled = true;
            button.innerHTML = '<i class="fa fa-spinner fa-spin"></i> Removing...';
            
            fetch('favorite', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'action=remove&postId=' + postId
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // Remove the job card with animation
                    const jobCard = button.closest('.job-card');
                    jobCard.style.transition = 'all 0.3s ease';
                    jobCard.style.transform = 'translateX(-100%)';
                    jobCard.style.opacity = '0';
                    
                    setTimeout(() => {
                        jobCard.remove();
                        
                        // Check if no more favorites
                        const remainingCards = document.querySelectorAll('.job-card');
                        if (remainingCards.length === 0) {
                            location.reload(); // Reload to show empty state
                        } else {
                            // Update count in header
                            const countElement = document.querySelector('.favorite-count');
                            if (countElement) {
                                const currentCount = remainingCards.length;
                                countElement.textContent = currentCount + ' job' + (currentCount > 1 ? 's' : '');
                            }
                        }
                    }, 300);
                    
                    // Show success message
                    showMessage('Job removed from favorites', 'success');
                } else {
                    // Re-enable button
                    button.disabled = false;
                    button.innerHTML = '<i class="fa fa-heart-o"></i> Remove';
                    showMessage(data.message || 'Failed to remove from favorites', 'error');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                button.disabled = false;
                button.innerHTML = '<i class="fa fa-heart-o"></i> Remove';
                showMessage('An error occurred. Please try again.', 'error');
            });
        }
        
        // Function để show message
        function showMessage(message, type) {
            const alertClass = type === 'success' ? 'alert-success' : 'alert-danger';
            const icon = type === 'success' ? 'fa-check-circle' : 'fa-exclamation-triangle';
            
            const alertHtml = `
                <div class="alert ${alertClass}" style="margin-bottom: 20px;">
                    <i class="fa ${icon}"></i> ${message}
                </div>
            `;
            
            const container = document.querySelector('.container');
            const pageHeader = document.querySelector('.page-header');
            pageHeader.insertAdjacentHTML('afterend', alertHtml);
            
            // Auto remove after 3 seconds
            setTimeout(() => {
                const alert = document.querySelector('.alert');
                if (alert) {
                    alert.remove();
                }
            }, 3000);
        }
    </script>
</body>
</html>
