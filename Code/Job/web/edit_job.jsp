<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Model.UserLoginInfo" %>
<%@ page import="Model.Post" %>
<%@ page import="Model.Category" %>
<%@ page import="Model.JobType" %>
<%@ page import="Model.Duration" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    UserLoginInfo user = (UserLoginInfo) session.getAttribute("user");
    if (user == null || !"recruiter".equals(user.getUserType())) {
        response.sendRedirect("login.jsp");
        return;
    }

    Post post = (Post) request.getAttribute("post");
    if (post == null) {
        response.sendRedirect("post?action=list");
        return;
    }

    String error = (String) request.getAttribute("error");
    List<Category> categories = (List<Category>) request.getAttribute("categories");
    List<JobType> jobTypes = (List<JobType>) request.getAttribute("jobTypes");
    List<Duration> durations = (List<Duration>) request.getAttribute("durations");
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>
<!doctype html>
<html class="no-js" lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Edit Job - Find Work</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSS here -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/themify-icons.css">
    <link rel="stylesheet" href="css/style.css">
    
    <style>
        .edit-job-container {
            padding: 50px 0;
            background-color: #f8f9fa;
        }
        
        .form-container {
            background: white;
            border-radius: 10px;
            padding: 40px;
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
        }
        
        .form-header {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .form-header h2 {
            color: #2c3e50;
            margin-bottom: 10px;
        }
        
        .form-header p {
            color: #7f8c8d;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-group label {
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 8px;
            display: block;
        }
        
        .form-control {
            border: 2px solid #e9ecef;
            border-radius: 8px;
            padding: 12px 15px;
            font-size: 14px;
            transition: border-color 0.3s ease;
        }
        
        .form-control:focus {
            border-color: #3498db;
            box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25);
        }
        
        .form-row {
            display: flex;
            gap: 20px;
        }
        
        .form-row .form-group {
            flex: 1;
        }
        
        .btn-submit {
            background: linear-gradient(135deg, #27ae60, #229954);
            color: white;
            padding: 15px 40px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 100%;
        }
        
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(39, 174, 96, 0.4);
        }
        
        .btn-cancel {
            background: #95a5a6;
            color: white;
            padding: 15px 40px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 100%;
            text-decoration: none;
            display: inline-block;
            text-align: center;
            margin-top: 10px;
        }
        
        .btn-cancel:hover {
            background: #7f8c8d;
            color: white;
            text-decoration: none;
        }
        
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid transparent;
            border-radius: 4px;
        }
        
        .alert-danger {
            color: #721c24;
            background-color: #f8d7da;
            border-color: #f5c6cb;
        }
        
        .required {
            color: #e74c3c;
        }
        
        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }
        
        .budget-group {
            display: flex;
            gap: 15px;
            align-items: end;
        }
        
        .budget-input {
            flex: 1;
        }
        
        .budget-type {
            flex: 0 0 120px;
        }
        
        .status-info {
            background: #e8f4f8;
            border: 1px solid #bee5eb;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 25px;
        }
        
        .status-info h5 {
            color: #0c5460;
            margin-bottom: 10px;
        }
        
        .status-info p {
            color: #0c5460;
            margin: 0;
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
                                            <li><a href="post?action=list">My Jobs</a></li>
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
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <!-- header-end -->

    <!-- edit-job-area-start -->
    <div class="edit-job-container">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="form-container">
                        <div class="form-header">
                            <h2>Edit Job Post</h2>
                            <p>Update your job posting details</p>
                        </div>

                        <!-- Status Info -->
                        <div class="status-info">
                            <h5><i class="fa fa-info-circle"></i> Current Status: <%= post.getStatusPost() %></h5>
                            <p>Posted on: <%= post.getDatePost() %></p>
                        </div>

                        <!-- Error Message -->
                        <% if (error != null) { %>
                            <div class="alert alert-danger">
                                <i class="fa fa-exclamation-circle"></i> <%= error %>
                            </div>
                        <% } %>

                        <form action="post" method="post" onsubmit="return validateForm()">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="postId" value="<%= post.getPostId() %>">
                            
                            <!-- Job Title -->
                            <div class="form-group">
                                <label for="title">Job Title <span class="required">*</span></label>
                                <input type="text" class="form-control" id="title" name="title" 
                                       value="<%= post.getTitle() %>" required>
                            </div>

                            <!-- Job Type and Duration -->
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="jobTypeId">Job Type <span class="required">*</span></label>
                                    <select class="form-control" id="jobTypeId" name="jobTypeId" required>
                                        <option value="">Select Job Type</option>
                                        <% if (jobTypes != null) {
                                            for (JobType jobType : jobTypes) { %>
                                                <option value="<%= jobType.getJobTypeID() %>"
                                                        <%= post.getJobTypeId() == jobType.getJobTypeID() ? "selected" : "" %>>
                                                    <%= jobType.getJobTypeName() %>
                                                </option>
                                        <%  }
                                           } %>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="durationId">Duration <span class="required">*</span></label>
                                    <select class="form-control" id="durationId" name="durationId" required>
                                        <option value="">Select Duration</option>
                                        <% if (durations != null) {
                                            for (Duration duration : durations) { %>
                                                <option value="<%= duration.getDurationID() %>"
                                                        <%= post.getDurationId() == duration.getDurationID() ? "selected" : "" %>>
                                                    <%= duration.getDurationName() %>
                                                </option>
                                        <%  }
                                           } %>
                                    </select>
                                </div>
                            </div>

                            <!-- Category and Quantity -->
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="categoryId">Category <span class="required">*</span></label>
                                    <select class="form-control" id="categoryId" name="categoryId" required>
                                        <option value="">Select Category</option>
                                        <% if (categories != null) {
                                            for (Category category : categories) { %>
                                                <option value="<%= category.getCategoryID() %>"
                                                        <%= post.getCategoryId() == category.getCategoryID() ? "selected" : "" %>>
                                                    <%= category.getCategoryName() %>
                                                </option>
                                        <%  }
                                           } %>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="quantity">Number of Positions <span class="required">*</span></label>
                                    <input type="number" class="form-control" id="quantity" name="quantity" 
                                           min="1" max="100" value="<%= post.getQuantity() %>" required>
                                </div>
                            </div>

                            <!-- Location -->
                            <div class="form-group">
                                <label for="location">Location <span class="required">*</span></label>
                                <input type="text" class="form-control" id="location" name="location" 
                                       value="<%= post.getLocation() %>" required>
                            </div>

                            <!-- Budget -->
                            <div class="form-group">
                                <label>Budget</label>
                                <div class="budget-group">
                                    <div class="budget-input">
                                        <input type="number" class="form-control" id="budgetMin" name="budgetMin" 
                                               placeholder="Min Budget" step="0.01" 
                                               value="<%= post.getBudgetMin() != null ? post.getBudgetMin() : "" %>">
                                    </div>
                                    <div class="budget-input">
                                        <input type="number" class="form-control" id="budgetMax" name="budgetMax" 
                                               placeholder="Max Budget" step="0.01"
                                               value="<%= post.getBudgetMax() != null ? post.getBudgetMax() : "" %>">
                                    </div>
                                    <div class="budget-type">
                                        <select class="form-control" id="budgetType" name="budgetType">
                                            <option value="Fixed" <%= "Fixed".equals(post.getBudgetType()) ? "selected" : "" %>>Fixed</option>
                                            <option value="Hourly" <%= "Hourly".equals(post.getBudgetType()) ? "selected" : "" %>>Hourly</option>
                                            <option value="Range" <%= "Range".equals(post.getBudgetType()) ? "selected" : "" %>>Range</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <!-- Status and Expired Date -->
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="statusPost">Status <span class="required">*</span></label>
                                    <select class="form-control" id="statusPost" name="statusPost" required>
                                        <option value="Draft" <%= "Draft".equals(post.getStatusPost()) ? "selected" : "" %>>Draft</option>
                                        <option value="Pending" <%= "Pending".equals(post.getStatusPost()) ? "selected" : "" %>>Pending</option>
                                        <option value="Approved" <%= "Approved".equals(post.getStatusPost()) ? "selected" : "" %>>Approved</option>
                                        <option value="Paused" <%= "Paused".equals(post.getStatusPost()) ? "selected" : "" %>>Paused</option>
                                        <option value="Closed" <%= "Closed".equals(post.getStatusPost()) ? "selected" : "" %>>Closed</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="expiredDate">Application Deadline</label>
                                    <input type="date" class="form-control" id="expiredDate" name="expiredDate"
                                           value="<%= post.getExpiredDate() != null ? sdf.format(post.getExpiredDate()) : "" %>">
                                </div>
                            </div>

                            <!-- Job Description -->
                            <div class="form-group">
                                <label for="description">Job Description <span class="required">*</span></label>
                                <textarea class="form-control" id="description" name="description" required><%= post.getDescription() %></textarea>
                            </div>

                            <!-- Image URL -->
                            <div class="form-group">
                                <label for="image">Company Logo URL (Optional)</label>
                                <input type="url" class="form-control" id="image" name="image" 
                                       value="<%= post.getImage() != null ? post.getImage() : "" %>">
                            </div>

                            <!-- Submit Buttons -->
                            <div class="form-group">
                                <button type="submit" class="btn-submit">
                                    <i class="fa fa-save"></i> Update Job
                                </button>
                                <a href="post?action=list" class="btn-cancel">
                                    <i class="fa fa-times"></i> Cancel
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- edit-job-area-end -->

    <!-- JS here -->
    <script src="js/vendor/jquery-1.12.4.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/main.js"></script>
    
    <script>
        function validateForm() {
            const title = document.getElementById('title').value.trim();
            const description = document.getElementById('description').value.trim();
            const location = document.getElementById('location').value.trim();
            const jobTypeId = document.getElementById('jobTypeId').value;
            const durationId = document.getElementById('durationId').value;
            const categoryId = document.getElementById('categoryId').value;
            const quantity = document.getElementById('quantity').value;
            
            if (!title) {
                alert('Please enter a job title.');
                return false;
            }
            
            if (!description) {
                alert('Please enter a job description.');
                return false;
            }
            
            if (!location) {
                alert('Please enter a location.');
                return false;
            }
            
            if (!jobTypeId) {
                alert('Please select a job type.');
                return false;
            }
            
            if (!durationId) {
                alert('Please select a duration.');
                return false;
            }
            
            if (!categoryId) {
                alert('Please select a category.');
                return false;
            }
            
            if (!quantity || quantity < 1) {
                alert('Please enter a valid number of positions.');
                return false;
            }
            
            const budgetMin = parseFloat(document.getElementById('budgetMin').value);
            const budgetMax = parseFloat(document.getElementById('budgetMax').value);
            
            if (budgetMin && budgetMax && budgetMin > budgetMax) {
                alert('Minimum budget cannot be greater than maximum budget.');
                return false;
            }
            
            return true;
        }
        
        // Set minimum date to today
        document.addEventListener('DOMContentLoaded', function() {
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('expiredDate').setAttribute('min', today);
        });
    </script>
</body>
</html>
