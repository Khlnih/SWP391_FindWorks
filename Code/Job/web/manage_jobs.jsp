<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Model.Post" %>
<%@ page import="Model.Category" %>
<%@ page import="Model.JobType" %>
<%@ page import="Model.Duration" %>
<%@ page import="Model.UserLoginInfo" %>
<%
    UserLoginInfo user = (UserLoginInfo) session.getAttribute("user");
    if (user == null || !"recruiter".equals(user.getUserType())) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Post> posts = (List<Post>) request.getAttribute("posts");
    List<Category> categories = (List<Category>) request.getAttribute("categories");
    List<JobType> jobTypes = (List<JobType>) request.getAttribute("jobTypes");
    List<Duration> durations = (List<Duration>) request.getAttribute("durations");
    String message = (String) session.getAttribute("message");
    String error = (String) session.getAttribute("error");

    // Clear messages after displaying
    session.removeAttribute("message");
    session.removeAttribute("error");
%>
<%!
    // Helper method để tìm category name theo ID
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

    // Helper method để tìm job type name theo ID
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

    // Helper method để tìm duration name theo ID
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
    <title>Manage Job Posts - Find Work</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSS here -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/themify-icons.css">
    <link rel="stylesheet" href="css/style.css">
    
    <style>
        .manage-jobs-container {
            padding: 50px 0;
            background-color: #f8f9fa;
        }
        
        .jobs-header {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        
        .job-card {
            background: white;
            border-radius: 10px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }
        
        .job-card:hover {
            transform: translateY(-2px);
        }
        
        .job-title {
            color: #2c3e50;
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 10px;
        }
        
        .job-meta {
            color: #7f8c8d;
            font-size: 14px;
            margin-bottom: 15px;
        }
        
        .job-meta span {
            margin-right: 20px;
        }
        
        .job-description {
            color: #34495e;
            margin-bottom: 20px;
            line-height: 1.6;
        }
        
        .job-actions {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }
        
        .btn-action {
            padding: 8px 16px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .btn-view {
            background-color: #3498db;
            color: white;
        }
        
        .btn-edit {
            background-color: #f39c12;
            color: white;
        }
        
        .btn-delete {
            background-color: #e74c3c;
            color: white;
        }
        
        .btn-action:hover {
            transform: translateY(-1px);
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            color: white;
            text-decoration: none;
        }
        
        .status-badge {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
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
        
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid transparent;
            border-radius: 4px;
        }
        
        .alert-success {
            color: #155724;
            background-color: #d4edda;
            border-color: #c3e6cb;
        }
        
        .alert-danger {
            color: #721c24;
            background-color: #f8d7da;
            border-color: #f5c6cb;
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #7f8c8d;
        }
        
        .empty-state i {
            font-size: 64px;
            margin-bottom: 20px;
            color: #bdc3c7;
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
                                    <a href="index_recruiter.jsp">
                                        <img src="img/logo.png" alt="">
                                    </a>
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-7">
                                <div class="main-menu d-none d-lg-block">
                                    <nav>
                                        <ul id="navigation">
                                            <li><a href="index_recruiter.jsp">Home</a></li>
                                            <li><a href="post?action=list" class="active">My Jobs</a></li>
                                            <li><a href="jobs.jsp">Browse Jobs</a></li>
                                            <li><a href="contact.jsp">Contact</a></li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                            <div class="col-xl-3 col-lg-3 d-none d-lg-block">
                                <div class="Appointment">
                                    <div class="phone_num d-none d-xl-block">
                                        <a href="recruiter_profile.jsp">My Profile</a>
                                    </div>
                                    <div class="phone_num d-none d-xl-block">
                                        <a href="${pageContext.request.contextPath}/logout">Log out</a>
                                    </div>
                                    <div class="d-none d-lg-block">
                                        <a class="boxed-btn3" href="post?action=create">Post a Job</a>
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

    <!-- manage-jobs-area-start -->
    <div class="manage-jobs-container">
        <div class="container">
            <!-- Header Section -->
            <div class="jobs-header">
                <div class="row align-items-center">
                    <div class="col-lg-8">
                        <h2>My Job Posts</h2>
                        <p class="mb-0">Manage all your job postings from here</p>
                    </div>
                    <div class="col-lg-4 text-right">
                        <a href="post?action=create" class="boxed-btn3">
                            <i class="fa fa-plus"></i> Create New Job
                        </a>
                    </div>
                </div>
            </div>

            <!-- Messages -->
            <% if (message != null) { %>
                <div class="alert alert-success">
                    <i class="fa fa-check-circle"></i> <%= message %>
                </div>
            <% } %>
            
            <% if (error != null) { %>
                <div class="alert alert-danger">
                    <i class="fa fa-exclamation-circle"></i> <%= error %>
                </div>
            <% } %>

            <!-- Job Posts List -->
            <% if (posts != null && !posts.isEmpty()) { %>
                <% for (Post post : posts) { %>
                    <div class="job-card">
                        <div class="row">
                            <div class="col-lg-8">
                                <h3 class="job-title"><%= post.getTitle() %></h3>
                                <div class="job-meta">
                                    <span><i class="fa fa-calendar"></i> Posted: <%= post.getDatePost() %></span>
                                    <span><i class="fa fa-map-marker"></i> <%= post.getLocation() %></span>
                                    <span><i class="fa fa-briefcase"></i> <%= getJobTypeName(post.getJobTypeId(), jobTypes) %></span>
                                    <span><i class="fa fa-clock-o"></i> <%= getDurationName(post.getDurationId(), durations) %></span>
                                    <span><i class="fa fa-tag"></i> <%= getCategoryName(post.getCategoryId(), categories) %></span>
                                    <span><i class="fa fa-users"></i> <%= post.getQuantity() %> positions</span>
                                    <span class="status-badge status-<%= post.getStatusPost().toLowerCase() %>">
                                        <%= post.getStatusPost() %>
                                    </span>
                                </div>
                                <div class="job-description">
                                    <%= post.getDescription() != null && post.getDescription().length() > 150 
                                        ? post.getDescription().substring(0, 150) + "..." 
                                        : post.getDescription() %>
                                </div>
                                <% if (post.getBudgetMin() != null || post.getBudgetMax() != null) { %>
                                    <div class="job-budget">
                                        <strong>Budget: </strong>
                                        <% if (post.getBudgetMin() != null && post.getBudgetMax() != null) { %>
                                            $<%= post.getBudgetMin() %> - $<%= post.getBudgetMax() %>
                                        <% } else if (post.getBudgetMin() != null) { %>
                                            From $<%= post.getBudgetMin() %>
                                        <% } else { %>
                                            Up to $<%= post.getBudgetMax() %>
                                        <% } %>
                                        <% if (post.getBudgetType() != null) { %>
                                            (<%= post.getBudgetType() %>)
                                        <% } %>
                                    </div>
                                <% } %>
                            </div>
                            <div class="col-lg-4">
                                <div class="job-actions">
                                    <a href="post?action=view&id=<%= post.getPostId() %>" class="btn-action btn-view">
                                        <i class="fa fa-eye"></i> View
                                    </a>
                                    <a href="post?action=edit&id=<%= post.getPostId() %>" class="btn-action btn-edit">
                                        <i class="fa fa-edit"></i> Edit
                                    </a>
                                    <a href="post?action=delete&id=<%= post.getPostId() %>" 
                                       class="btn-action btn-delete"
                                       onclick="return confirm('Are you sure you want to delete this job post?')">
                                        <i class="fa fa-trash"></i> Delete
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                <% } %>
            <% } else { %>
                <div class="empty-state">
                    <i class="fa fa-briefcase"></i>
                    <h3>No Job Posts Yet</h3>
                    <p>You haven't created any job posts yet. Start by creating your first job posting!</p>
                    <a href="post?action=create" class="boxed-btn3">Create Your First Job</a>
                </div>
            <% } %>
        </div>
    </div>
    <!-- manage-jobs-area-end -->

    <!-- JS here -->
    <script src="js/vendor/jquery-1.12.4.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>
