<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="Model.Recruiter" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<% 
    Recruiter recruiter = (Recruiter) request.getAttribute("recruiter");
    if (recruiter == null) {
        response.sendRedirect("admin_recruiter.jsp");
        return;
    }
    
    // Format date of birth
    String formattedDob = "";
    if (recruiter.getDob() != null) {
        try {
            SimpleDateFormat outputFormat = new SimpleDateFormat("dd/MM/yyyy");
            formattedDob = outputFormat.format(recruiter.getDob());
        } catch (Exception e) {
            formattedDob = recruiter.getDob().toString();
        }
    }
    
    // Format money
    String formattedMoney = String.format("%,d VND", recruiter.getMoney());
%>

<!DOCTYPE html>
<html class="no-js" lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Recruiter Details - Admin Panel</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSS here -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/themify-icons.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/responsive.css">
    <style>
        :root {
            --primary-color: #4CAF50;
            --primary-dark: #388E3C;
            --primary-light: rgba(76, 175, 80, 0.1);
            --text-color: #2d3436;
            --white: #ffffff;
            --success: #28a745;
            --danger: #dc3545;
            --warning: #ffc107;
            --info: #17a2b8;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: #f5f7fa;
            color: var(--text-color);
        }

        .profile-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
            color: white;
            padding: 30px 0;
            margin-bottom: 30px;
            border-radius: 0 0 10px 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        .profile-avatar {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            border: 5px solid white;
            object-fit: cover;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .profile-name {
            font-size: 2rem;
            font-weight: 700;
            margin: 15px 0 5px;
        }

        .profile-username {
            font-size: 1.1rem;
            opacity: 0.9;
            margin-bottom: 15px;
        }

        .profile-status {
            display: inline-block;
            padding: 5px 15px;
            border-radius: 20px;
            font-weight: 500;
            font-size: 0.9rem;
            text-transform: capitalize;
        }

        .status-active {
            background-color: rgba(40, 167, 69, 0.2);
            color: #28a745;
        }

        .status-inactive {
            background-color: rgba(220, 53, 69, 0.2);
            color: #dc3545;
        }

        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            margin-bottom: 30px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }

        .card-header {
            background-color: white;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            font-weight: 600;
            font-size: 1.1rem;
            padding: 15px 20px;
            border-radius: 10px 10px 0 0 !important;
        }

        .card-body {
            padding: 20px;
        }

        .info-item {
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px dashed #eee;
        }

        .info-item:last-child {
            margin-bottom: 0;
            padding-bottom: 0;
            border-bottom: none;
        }

        .info-label {
            font-weight: 600;
            color: #6c757d;
            margin-bottom: 5px;
            font-size: 0.9rem;
        }

        .info-value {
            font-size: 1rem;
            color: var(--text-color);
            word-break: break-word;
        }

        .info-value.empty {
            color: #adb5bd;
            font-style: italic;
        }

        .btn-back {
            background-color: #f8f9fa;
            color: var(--text-color);
            border: 1px solid #dee2e6;
            padding: 8px 20px;
            border-radius: 5px;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
        }

        .btn-back:hover {
            background-color: #e9ecef;
            color: var(--primary-color);
            text-decoration: none;
        }

        .btn-back i {
            margin-right: 8px;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }

        .btn-edit {
            background-color: var(--warning);
            color: #212529;
            border: none;
            padding: 8px 20px;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        .btn-edit:hover {
            background-color: #e0a800;
            color: #212529;
        }

        .btn-delete {
            background-color: var(--danger);
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        .btn-delete:hover {
            background-color: #c82333;
            color: white;
        }

        .status-toggle {
            cursor: pointer;
            padding: 5px 15px;
            border-radius: 20px;
            font-weight: 500;
            font-size: 0.9rem;
            display: inline-block;
            transition: all 0.3s ease;
            border: 1px solid transparent;
        }

        .status-toggle:hover {
            opacity: 0.9;
        }

        .status-active {
            background-color: rgba(40, 167, 69, 0.2);
            color: #28a745;
            border-color: rgba(40, 167, 69, 0.3);
        }

        .status-inactive {
            background-color: rgba(220, 53, 69, 0.2);
            color: #dc3545;
            border-color: rgba(220, 53, 69, 0.3);
        }

        .empty-state {
            color: #adb5bd;
            font-style: italic;
            padding: 20px 0;
            text-align: center;
        }
        
        .money-amount {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-color);
        }
    </style>
</head>
<body>
    <div class="main-content">
        <div class="profile-header text-center">
            <div class="container">
                <div class="d-flex justify-content-start mb-4">
                    <a href="admin_recruiter.jsp" class="btn-back">
                        <i class="fa fa-arrow-left"></i> Back to Recruiters
                    </a>
                </div>
                <div class="text-center">
                    <img src="<%= recruiter.getImage() != null && !recruiter.getImage().isEmpty() ? recruiter.getImage() : "images/default-avatar.png" %>" 
                         alt="Profile Image" class="profile-avatar">
                    <h1 class="profile-name"><%= recruiter.getFirstName() %> <%= recruiter.getLastName() %></h1>
                    <div class="profile-username">@<%= recruiter.getUsername() %></div>
                    <span class="profile-status <%= "active".equalsIgnoreCase(recruiter.getStatus()) ? "status-active" : "status-inactive" %>">
                        <%= recruiter.getStatus() != null ? recruiter.getStatus().toUpperCase() : "UNKNOWN" %>
                    </span>
                </div>
            </div>
        </div>

        <div class="container">
            <div class="row">
                <!-- Left Column -->
                <div class="col-lg-8">
                    <!-- Personal Information Card -->
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fa fa-user-circle mr-2"></i> Personal Information
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="info-item">
                                        <div class="info-label">First Name</div>
                                        <div class="info-value"><%= recruiter.getFirstName() != null ? recruiter.getFirstName() : "<span class='empty'>Not provided</span>" %></div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-label">Last Name</div>
                                        <div class="info-value"><%= recruiter.getLastName() != null ? recruiter.getLastName() : "<span class='empty'>Not provided</span>" %></div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-label">Username</div>
                                        <div class="info-value"><%= recruiter.getUsername() %></div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="info-item">
                                        <div class="info-label">Date of Birth</div>
                                        <div class="info-value"><%= !formattedDob.isEmpty() ? formattedDob : "<span class='empty'>Not provided</span>" %></div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-label">Gender</div>
                                        <div class="info-value">
                                            <%= recruiter.isGender() ? "Male" : "Female" %>
                                        </div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-label">Account Status</div>
                                        <div class="info-value">
                                            <span class="status-toggle <%= "active".equalsIgnoreCase(recruiter.getStatus()) ? "status-active" : "status-inactive" %>" 
                                                  onclick="toggleStatus(<%= recruiter.getRecruiterID() %>, '<%= recruiter.getStatus() %>')">
                                                <%= recruiter.getStatus() != null ? recruiter.getStatus().toUpperCase() : "UNKNOWN" %>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Contact Information Card -->
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fa fa-address-card mr-2"></i> Contact Information
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="info-item">
                                        <div class="info-label">Email</div>
                                        <div class="info-value">
                                            <%= recruiter.getEmailContact() != null && !recruiter.getEmailContact().isEmpty() ? 
                                                "<a href='mailto:" + recruiter.getEmailContact() + "'>" + recruiter.getEmailContact() + "</a>" : 
                                                "<span class='empty'>Not provided</span>" %>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="info-item">
                                        <div class="info-label">Phone Number</div>
                                        <div class="info-value">
                                            <%= recruiter.getPhoneContact() != null && !recruiter.getPhoneContact().isEmpty() ? 
                                                "<a href='tel:" + recruiter.getPhoneContact() + "'>" + recruiter.getPhoneContact() + "</a>" : 
                                                "<span class='empty'>Not provided</span>" %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Right Column -->
                <div class="col-lg-4">
                    <!-- Account Balance -->
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fa fa-wallet mr-2"></i> Account Balance
                        </div>
                        <div class="card-body text-center">
                            <div class="money-amount mb-3"><%= formattedMoney %></div>
                            <button class="btn btn-primary btn-sm">
                                <i class="fa fa-plus mr-1"></i> Add Funds
                            </button>
                        </div>
                    </div>

                    <!-- Account Actions Card -->
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fa fa-cog mr-2"></i> Account Actions
                        </div>
                        <div class="card-body">
                            <div class="d-grid gap-2">
                                <a href="#" class="btn btn-edit btn-block">
                                    <i class="fa fa-edit mr-2"></i> Edit Profile
                                </a>
                                <button type="button" class="btn btn-delete btn-block" onclick="confirmDelete(<%= recruiter.getRecruiterID() %>)">
                                    <i class="fa fa-trash mr-2"></i> Delete Account
                                </button>
                                <a href="#" class="btn btn-primary btn-block">
                                    <i class="fa fa-envelope mr-2"></i> Send Message
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- Account Information -->
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fa fa-info-circle mr-2"></i> Account Information
                        </div>
                        <div class="card-body">
                            <div class="info-item">
                                <div class="info-label">Member Since</div>
                                <div class="info-value">
                                    <!-- You would typically have a registration date field in your model -->
                                    <span class="empty">Not available</span>
                                </div>
                            </div>
                            <div class="info-item">
                                <div class="info-label">Last Login</div>
                                <div class="info-value">
                                    <!-- You would typically have a last login field in your model -->
                                    <span class="empty">Not available</span>
                                </div>
                            </div>
                            <div class="info-item">
                                <div class="info-label">Account ID</div>
                                <div class="info-value">#<%= recruiter.getRecruiterID() %></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteModalLabel">Confirm Deletion</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    Are you sure you want to delete this recruiter? This action cannot be undone.
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-danger" id="confirmDeleteBtn">Delete</button>
                </div>
            </div>
        </div>
    </div>

    <!-- JavaScript Libraries -->
    <script src="js/vendor/jquery-3.5.1.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script>
        // Toggle account status
        function toggleStatus(id, currentStatus) {
            if (confirm('Are you sure you want to ' + (currentStatus === 'active' ? 'deactivate' : 'activate') + ' this account?')) {
                // Here you would typically make an AJAX call to update the status
                // For now, we'll just show an alert
                alert('Status update request sent for recruiter ID: ' + id);
                // You can implement the actual status update logic here
            }
        }
        
        // Delete confirmation
        let recruiterToDelete = null;
        
        function confirmDelete(id) {
            recruiterToDelete = id;
            $('#deleteModal').modal('show');
        }
        
        document.getElementById('confirmDeleteBtn').addEventListener('click', function() {
            if (recruiterToDelete) {
                // Here you would typically make an AJAX call to delete the recruiter
                // For now, we'll just show an alert and redirect
                alert('Delete request sent for recruiter ID: ' + recruiterToDelete);
                window.location.href = 'AdminController?action=deleteRecruiter&id=' + recruiterToDelete;
            }
        });
        
        // Initialize tooltips
        $(function () {
            $('[data-toggle="tooltip"]').tooltip();
        });
    </script>
</body>
</html>
