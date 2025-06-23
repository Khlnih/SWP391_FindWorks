<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Model.Post" %>
<%@ page import="Model.Category" %>
<%@ page import="Model.JobType" %>
<%@ page import="Model.Duration" %>
<%@ page import="Model.UserLoginInfo" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    Post post = (Post) request.getAttribute("post");
    if (post == null) {
        response.sendRedirect("post?action=list");
        return;
    }

    Category category = (Category) request.getAttribute("category");
    JobType jobType = (JobType) request.getAttribute("jobType");
    Duration duration = (Duration) request.getAttribute("duration");
    UserLoginInfo user = (UserLoginInfo) session.getAttribute("user");
    SimpleDateFormat sdf = new SimpleDateFormat("MMM dd, yyyy");
    SimpleDateFormat sdfTime = new SimpleDateFormat("MMM dd, yyyy 'at' HH:mm");
%>
<!doctype html>
<html class="no-js" lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title><%= post.getTitle() %> - Job Details</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSS here -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/themify-icons.css">
    <link rel="stylesheet" href="css/style.css">
    
    <style>
        .job-details-container {
            padding: 50px 0;
            background-color: #f8f9fa;
        }
        
        .job-header {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        
        .job-content {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
        }
        
        .job-title {
            color: #2c3e50;
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 20px;
        }
        
        .job-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
            margin-bottom: 30px;
        }
        
        .meta-item {
            display: flex;
            align-items: center;
            color: #7f8c8d;
            font-size: 14px;
        }
        
        .meta-item i {
            margin-right: 8px;
            color: #3498db;
            font-size: 16px;
        }
        
        .status-badge {
            padding: 8px 16px;
            border-radius: 25px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            display: inline-block;
        }
        
        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }
        
        .status-approved {
            background-color: #d4edda;
            color: #155724;
        }
        
        .status-rejected {
            background-color: #f8d7da;
            color: #721c24;
        }
        
        .status-closed {
            background-color: #d1ecf1;
            color: #0c5460;
        }
        
        .job-description {
            color: #34495e;
            line-height: 1.8;
            font-size: 16px;
            margin-bottom: 30px;
        }
        
        .job-info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
            margin-bottom: 30px;
        }
        
        .info-card {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            border-left: 4px solid #3498db;
        }
        
        .info-card h5 {
            color: #2c3e50;
            margin-bottom: 10px;
            font-weight: 600;
        }
        
        .info-card p {
            color: #7f8c8d;
            margin: 0;
            font-size: 14px;
        }
        
        .action-buttons {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            margin-top: 30px;
        }
        
        .btn-action {
            padding: 12px 24px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
        }
        
        .btn-warning {
            background: linear-gradient(135deg, #f39c12, #e67e22);
            color: white;
        }
        
        .btn-danger {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            color: white;
        }
        
        .btn-secondary {
            background: #95a5a6;
            color: white;
        }
        
        .btn-action:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            color: white;
            text-decoration: none;
        }
        
        .company-logo {
            width: 80px;
            height: 80px;
            border-radius: 10px;
            object-fit: cover;
            margin-right: 20px;
        }
        
        .budget-info {
            background: linear-gradient(135deg, #27ae60, #229954);
            color: white;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
        }
        
        .budget-amount {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 5px;
        }
        
        .budget-type {
            font-size: 14px;
            opacity: 0.9;
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
                                    <a href="<%= user != null && "recruiter".equals(user.getUserType()) ? "index_recruiter.jsp" : "index.jsp" %>">
                                        <img src="img/logo.png" alt="">
                                    </a>
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-7">
                                <div class="main-menu d-none d-lg-block">
                                    <nav>
                                        <ul id="navigation">
                                            <li><a href="<%= user != null && "recruiter".equals(user.getUserType()) ? "index_recruiter.jsp" : "index.jsp" %>">Home</a></li>
                                            <% if (user != null && "recruiter".equals(user.getUserType())) { %>
                                                <li><a href="post?action=list">My Jobs</a></li>
                                            <% } %>
                                            <li><a href="jobs">Browse Jobs</a></li>
                                            <li><a href="contact.jsp">Contact</a></li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                            <div class="col-xl-3 col-lg-3 d-none d-lg-block">
                                <div class="Appointment">
                                    <% if (user != null) { %>
                                        <div class="phone_num d-none d-xl-block">
                                            <a href="<%= "recruiter".equals(user.getUserType()) ? "recruiter_profile.jsp" : "freelancer_profile.jsp" %>">My Profile</a>
                                        </div>
                                        <div class="phone_num d-none d-xl-block">
                                            <a href="${pageContext.request.contextPath}/logout">Log out</a>
                                        </div>
                                        <% if ("recruiter".equals(user.getUserType())) { %>
                                            <div class="d-none d-lg-block">
                                                <a class="boxed-btn3" href="post?action=create">Post a Job</a>
                                            </div>
                                        <% } %>
                                    <% } else { %>
                                        <div class="d-none d-lg-block">
                                            <a class="boxed-btn3" href="login.jsp">Login</a>
                                        </div>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <!-- header-end -->

    <!-- job-details-area-start -->
    <div class="job-details-container">
        <div class="container">
            <!-- Job Header -->
            <div class="job-header">
                <div class="row align-items-center">
                    <div class="col-lg-8">
                        <div class="d-flex align-items-center">
                            <% if (post.getImage() != null && !post.getImage().trim().isEmpty()) { %>
                                <img src="<%= post.getImage() %>" alt="Company Logo" class="company-logo">
                            <% } %>
                            <div>
                                <h1 class="job-title"><%= post.getTitle() %></h1>
                                <div class="job-meta">
                                    <div class="meta-item">
                                        <i class="fa fa-map-marker"></i>
                                        <span><%= post.getLocation() %></span>
                                    </div>
                                    <div class="meta-item">
                                        <i class="fa fa-calendar"></i>
                                        <span>Posted: <%= sdf.format(post.getDatePost()) %></span>
                                    </div>
                                    <div class="meta-item">
                                        <i class="fa fa-users"></i>
                                        <span><%= post.getQuantity() %> position<%= post.getQuantity() > 1 ? "s" : "" %></span>
                                    </div>
                                    <div class="meta-item">
                                        <span class="status-badge status-<%= post.getStatusPost().toLowerCase() %>">
                                            <%= post.getStatusPost() %>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <% if (post.getBudgetMin() != null || post.getBudgetMax() != null) { %>
                            <div class="budget-info">
                                <div class="budget-amount">
                                    <% if (post.getBudgetMin() != null && post.getBudgetMax() != null) { %>
                                        $<%= post.getBudgetMin() %> - $<%= post.getBudgetMax() %>
                                    <% } else if (post.getBudgetMin() != null) { %>
                                        From $<%= post.getBudgetMin() %>
                                    <% } else { %>
                                        Up to $<%= post.getBudgetMax() %>
                                    <% } %>
                                </div>
                                <div class="budget-type">
                                    <%= post.getBudgetType() != null ? post.getBudgetType() : "Budget" %>
                                </div>
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>

            <!-- Job Content -->
            <div class="job-content">
                <!-- Job Description -->
                <div class="section">
                    <h3>Job Description</h3>
                    <div class="job-description">
                        <%= post.getDescription().replace("\n", "<br>") %>
                    </div>
                </div>

                <!-- Job Information Grid -->
                <div class="job-info-grid">
                    <div class="info-card">
                        <h5><i class="fa fa-briefcase"></i> Job Type</h5>
                        <p><%= jobType != null ? jobType.getJobTypeName() : "Unknown" %></p>
                    </div>
                    
                    <div class="info-card">
                        <h5><i class="fa fa-clock-o"></i> Duration</h5>
                        <p><%= duration != null ? duration.getDurationName() : "Unknown" %></p>
                    </div>
                    
                    <div class="info-card">
                        <h5><i class="fa fa-tag"></i> Category</h5>
                        <p><%= category != null ? category.getCategoryName() : "Unknown" %></p>
                    </div>
                    
                    <% if (post.getExpiredDate() != null) { %>
                        <div class="info-card">
                            <h5><i class="fa fa-calendar-times-o"></i> Application Deadline</h5>
                            <p><%= sdf.format(post.getExpiredDate()) %></p>
                        </div>
                    <% } %>
                </div>

                <!-- Action Buttons -->
                <div class="action-buttons">
                    <c:if test="${sessionScope.recruiter != null}">
                        <a href="post?action=edit&id=${post.postId}" class="btn-action btn-warning">
                            <i class="fa fa-edit"></i> Edit Job
                        </a>
                        <a href="post?action=delete&id=${post.postId}" 
                           class="btn-action btn-danger"
                           onclick="return confirm('Are you sure you want to delete this job post?')">
                            <i class="fa fa-trash"></i> Delete Job
                        </a>
                        <a href="post?action=list" class="btn-action btn-secondary">
                            <i class="fa fa-arrow-left"></i> Back to My Jobs
                        </a>
                    </c:if>
                           
                    <c:if test="${sessionScope.jobseeker != null}">
                        <form action="jobs" method="GET">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="jobseekerID" value="${jobseeker.getFreelancerID()}">
                            <input type="hidden" name="postID" value="${postIdStr}">
                            <button type="submit" id="favoriteBtn" class="btn-action btn-warning"">
                                <i class="fa fa-heart-o" id="favoriteIcon"></i><span id="favoriteText">Add to Favorites</span>
                            </button>
                        </form>
                        
                        <form action="applyJob" method="GET">
                            <input type="hidden" name="action" value="apply">
                            <input type="hidden" name="jobseekerID" value="${jobseeker.getFreelancerID()}">
                            <input type="hidden" name="postID" value="${postIdStr}">
                            <button type="submit" id="favoriteBtn" class="btn-action btn-primary">
                                 <i class="fa fa-paper-plane"></i> Apply Now
                            </button>
                        </form>

                        <a href="jobs" class="btn-action btn-secondary">
                            <i class="fa fa-arrow-left"></i> Back to Jobs
                        </a>
                    </c:if>

                   <c:if test="${sessionScope.jobseeker == null and sessionScope.recruiter == null}">
                        <a href="login.jsp" class="btn-action btn-primary">
                            <i class="fa fa-sign-in"></i> Login to Apply
                        </a>
                        <a href="jobs.jsp" class="btn-action btn-secondary">
                            <i class="fa fa-arrow-left"></i> Back to Jobs
                        </a>
                    </c:if>
                </div>

            </div>
        </div>
    </div>
    <!-- job-details-area-end -->

    <!-- JS here -->
    <script src="js/vendor/jquery-1.12.4.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/main.js"></script>

    <% if (user != null && "freelancer".equals(user.getUserType())) { %>
    <script>
        // Check favorite status when page loads
        $(document).ready(function() {
            checkFavoriteStatus(<%= post.getPostId() %>);
        });

        // Function to check if job is already favorited
        function checkFavoriteStatus(postId) {
            fetch('favorite?action=check&postId=' + postId)
                .then(response => response.json())
                .then(data => {
                    updateFavoriteButton(data.isFavorite);
                })
                .catch(error => {
                    console.error('Error checking favorite status:', error);
                });
        }

       

        // Function to update favorite button appearance
        function updateFavoriteButton(isFavorite) {
            const btn = document.getElementById('favoriteBtn');
            const icon = document.getElementById('favoriteIcon');
            const text = document.getElementById('favoriteText');

            btn.disabled = false;

            if (isFavorite) {
                btn.className = 'btn-action btn-danger';
                icon.className = 'fa fa-heart';
                text.textContent = 'Remove from Favorites';
            } else {
                btn.className = 'btn-action btn-warning';
                icon.className = 'fa fa-heart-o';
                text.textContent = 'Add to Favorites';
            }
        }

        // Function to show messages
        function showMessage(message, type) {
            const alertClass = type === 'success' ? 'alert-success' : 'alert-danger';
            const icon = type === 'success' ? 'fa-check-circle' : 'fa-exclamation-triangle';

            const alertHtml = `
                <div class="alert ${alertClass}" style="position: fixed; top: 20px; right: 20px; z-index: 9999; min-width: 300px;">
                    <i class="fa ${icon}"></i> ${message}
                </div>
            `;

            document.body.insertAdjacentHTML('beforeend', alertHtml);

            // Auto remove after 3 seconds
            setTimeout(() => {
                const alert = document.querySelector('.alert');
                if (alert) {
                    alert.style.transition = 'opacity 0.3s ease';
                    alert.style.opacity = '0';
                    setTimeout(() => alert.remove(), 300);
                }
            }, 3000);
        }
    </script>
    <% } %>
</body>
</html>
