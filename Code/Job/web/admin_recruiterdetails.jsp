<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
            formattedDob = "Not provided";
        }
    }
    
    // Format money
    String formattedMoney = "0";
    if (recruiter.getMoney() != null) {
        formattedMoney = String.format("%,.0f VND", recruiter.getMoney().doubleValue());
    }
    
    // Format gender
    String genderText = recruiter.isGender() ? "Male" : "Female";
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
            --primary-color: #2196F3;
            --primary-dark: #0D47A1;
            --primary-light: rgba(33, 150, 243, 0.1);
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
            color: #2d3436;
        }
        
        .card {
            border: none;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.05);
            margin-bottom: 24px;
            transition: all 0.3s ease;
        }
        
        .card:hover {
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }
        
        .card-header {
            background-color: #fff;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            padding: 15px 20px;
            border-radius: 8px 8px 0 0 !important;
            display: flex;
            align-items: center;
            font-weight: 600;
            color: #2c3e50;
        }
        
        .card-header i {
            margin-right: 10px;
            color: var(--primary-color);
            font-size: 18px;
        }
        
        .card-body {
            padding: 20px;
            background-color: #fff;
            border-radius: 0 0 8px 8px;
        }
        
        .profile-header {
            background: linear-gradient(135deg, #2196F3 0%, #1976D2 100%);
            padding: 40px 0;
            margin-bottom: 30px;
            color: white;
            border-radius: 0 0 20px 20px;
            position: relative;
            overflow: hidden;
        }
        
        .profile-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320"><path fill="rgba(255,255,255,0.1)" d="M0,192L48,197.3C96,203,192,213,288,229.3C384,245,480,267,576,250.7C672,235,768,181,864,181.3C960,181,1056,235,1152,234.7C1248,235,1344,181,1392,154.7L1440,128L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>') bottom/cover no-repeat;
            opacity: 0.1;
        }
        
        .profile-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            border: 4px solid rgba(255, 255, 255, 0.3);
            object-fit: cover;
            margin-bottom: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }
        
        .profile-avatar:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }
        
        .profile-name {
            font-size: 28px;
            font-weight: 700;
            margin: 10px 0 5px;
            letter-spacing: 0.5px;
        }
        
        .profile-title {
            font-size: 16px;
            opacity: 0.9;
            margin-bottom: 15px;
        }
        
        .btn-back {
            display: inline-flex;
            align-items: center;
            color: #000000; /* Màu chữ đen */
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            padding: 8px 20px;
            border-radius: 5px;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s ease;
            text-decoration: none;
            margin-bottom: 20px;
        }
        
        .btn-back i {
            margin-right: 8px;
        }
        
        .btn-back:hover {
            background-color: #e9ecef;
            color: #2196F3; /* Màu xanh dương khi hover */
            text-decoration: none;
            transform: translateY(-2px);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
        
        .info-item {
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .info-item:last-child {
            margin-bottom: 0;
            padding-bottom: 0;
            border-bottom: none;
        }
        
        .info-label {
            display: block;
            font-size: 13px;
            font-weight: 500;
            color: #7f8c8d;
            margin-bottom: 5px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .info-value {
            font-size: 15px;
            color: #2c3e50;
            font-weight: 500;
            word-break: break-word;
        }
        
        .badge {
            padding: 5px 12px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: 500;
            text-transform: capitalize;
            display: inline-block;
        }
        
        .badge-success {
            background-color: #28a745;
            color: white;
        }
        
        .badge-danger {
            background-color: #dc3545;
            color: white;
        }
        
        .badge-warning {
            background-color: #ffc107;
            color: #000;
        }
        
        .btn-action {
            padding: 8px 16px;
            border-radius: 4px;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-right: 8px;
            margin-bottom: 8px;
        }
        
        .btn-action i {
            margin-right: 5px;
        }
        
        .btn-edit {
            background-color: #007bff;
            color: white;
            border: 1px solid #007bff;
        }
        
        .btn-edit:hover {
            background-color: #0056b3;
            border-color: #0056b3;
            color: white;
            transform: translateY(-2px);
        }
        
        .btn-delete {
            background-color: #dc3545;
            color: white;
            border: 1px solid #dc3545;
        }
        
        .btn-delete:hover {
            background-color: #c82333;
            border-color: #bd2130;
            color: white;
            transform: translateY(-2px);
        }
        
        .btn-suspend {
            background-color: #ffc107;
            color: #212529;
            border: 1px solid #ffc107;
        }
        
        .btn-suspend:hover {
            background-color: #e0a800;
            border-color: #d39e00;
            color: #212529;
            transform: translateY(-2px);
        }
        
        .btn-activate {
            background-color: #28a745;
            color: white;
            border: 1px solid #28a745;
        }
        
        .btn-activate:hover {
            background-color: #218838;
            border-color: #1e7e34;
            color: white;
            transform: translateY(-2px);
        }
        
        .action-buttons {
            display: flex;
            flex-wrap: wrap;
            margin-top: 15px;
        }
        
        .empty-state {
            text-align: center;
            padding: 30px 20px;
            color: #7f8c8d;
        }
        
        .empty-state i {
            font-size: 50px;
            margin-bottom: 15px;
            display: block;
            color: #bdc3c7;
        }
        
        .empty-state p {
            margin-bottom: 0;
            font-size: 15px;
        }
        
        @media (max-width: 768px) {
            .profile-header {
                padding: 30px 0;
            }
            
            .profile-name {
                font-size: 24px;
            }
            
            .profile-avatar {
                width: 100px;
                height: 100px;
            }
            
            .card-header {
                padding: 12px 15px;
            }
            
            .card-body {
                padding: 15px;
            }
            
            .btn-action {
                padding: 6px 12px;
                font-size: 13px;
            }
            
            /* Style cho nút Back to Recruiters */
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
        }
    </style>
</head>
<body>
    <div class="main-content">
        <div class="profile-header text-center">
            <div class="container">
                
                <div class="position-relative">
                    <img src="<%= recruiter.getImage() != null && !recruiter.getImage().isEmpty() ? recruiter.getImage() : "img/avatar/default-avatar.png" %>" 
                         alt="Recruiter Avatar" class="profile-avatar">
                    <h1 class="profile-name"><%= recruiter.getFirst_name() + " " + recruiter.getLast_name() %></h1>
                    <div class="profile-title">
                        <span class="badge <%= "active".equalsIgnoreCase(recruiter.getStatus()) ? "badge-success" : 
                                               ("suspended".equalsIgnoreCase(recruiter.getStatus()) ? "badge-danger" : "badge-warning") %>">
                            <%= recruiter.getStatus() != null ? recruiter.getStatus().toUpperCase() : "UNKNOWN" %>
                        </span>
                    </div>
                </div>
            </div>
        </div>

        <div class="container">
            <div class="btn-back-container">
                    <a href="admin_recruiter.jsp" class="btn-back" style="position: relative; z-index: 1001;">
                        <i class="fa fa-arrow-left"></i> Back to Recruiters
                    </a>
                </div>
            <div class="row">
                <div class="col-lg-8">
                    
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fa fa-user-circle mr-2"></i> Personal Information
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="info-item">
                                        <span class="info-label">First Name</span>
                                        <p class="info-value"><%= recruiter.getFirst_name() %></p>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="info-item">
                                        <span class="info-label">Last Name</span>
                                        <p class="info-value"><%= recruiter.getLast_name() %></p>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="info-item">
                                        <span class="info-label">Gender</span>
                                        <p class="info-value"><%= genderText %></p>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="info-item">
                                        <span class="info-label">Date of Birth</span>
                                        <p class="info-value"><%= !formattedDob.isEmpty() ? formattedDob : "Not provided" %></p>
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
                                        <span class="info-label">Email</span>
                                        <p class="info-value">
                                            <a href="mailto:<%= recruiter.getEmail_contact() %>" class="text-primary">
                                                <%= recruiter.getEmail_contact() != null ? recruiter.getEmail_contact() : "Not provided" %>
                                            </a>
                                        </p>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="info-item">
                                        <span class="info-label">Phone</span>
                                        <p class="info-value">
                                            <%= recruiter.getPhone_contact() != null ? recruiter.getPhone_contact() : "Not provided" %>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Company Information Card -->
                    <c:if test="${not empty company}">
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fa fa-building mr-2"></i> Company Information
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="info-item">
                                            <span class="info-label">Company Name</span>
                                            <p class="info-value">${company.company_name}</p>
                                        </div>
                                        <div class="info-item mt-3">
                                            <span class="info-label">Location</span>
                                            <p class="info-value">${company.location}</p>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="info-item">
                                            <span class="info-label">Established</span>
                                            <p class="info-value">${company.established_on}</p>
                                        </div>
                                        
                                    </div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col-12">
                                        <div class="info-item">
                                            <span class="info-label">Website</span>
                                            <p class="info-value">
                                                <c:choose>
                                                    <c:when test="${not empty company.website}">
                                                        <a href="${company.website.startsWith('http') ? '' : '//'}${company.website}" target="_blank" class="text-primary">
                                                            ${company.website}
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>Not provided</c:otherwise>
                                                </c:choose>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <c:if test="${not empty company.describe}">
                                    <div class="row mt-3">
                                        <div class="col-12">
                                            <div class="info-item">
                                                <span class="info-label">About</span>
                                                <p class="info-value">${company.describe}</p>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                                <c:if test="${not empty company.logo}">
                                    <div class="row mt-3">
                                        <div class="col-12 text-center">
                                            <img src="${company.logo}" alt="Company Logo" class="img-fluid rounded" style="max-height: 150px;">
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </c:if>
                </div>

                <!-- Right Column -->
                <div class="col-lg-4">
                    <!-- Account Tier Card -->
                    <div class="card mb-4 border-0 shadow-sm" style="background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);">
                        <div class="card-header bg-transparent border-0 pb-0">
                            <div class="d-flex align-items-center justify-content-center">
                                <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center" style="width: 40px; height: 40px; margin-right: 10px;">
                                    <i class="fa fa-crown"></i>
                                </div>
                                <h5 class="mb-0" style="color: #2c3e50; font-weight: 600;">Account Tier</h5>
                            </div>
                        </div>
                        <div class="card-body text-center pt-4">
                            <div class="mb-3">
                                <span class="badge" style="
                                    font-size: 16px; 
                                    padding: 10px 24px; 
                                    background: linear-gradient(45deg, #4e73df, #224abe);
                                    color: white;
                                    border-radius: 50px;
                                    box-shadow: 0 4px 15px rgba(78, 115, 223, 0.3);
                                    font-weight: 500;
                                    letter-spacing: 0.5px;
                                    position: relative;
                                    overflow: hidden;
                                    z-index: 1;">
                                    <c:choose>
                                        <c:when test="${not empty tierName}">
                                            ${tierName}
                                        </c:when>
                                        <c:otherwise>No Tier Assigned</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                            <div class="tier-description" style="
                                background: white;
                                padding: 15px;
                                border-radius: 8px;
                                box-shadow: 0 2px 10px rgba(0,0,0,0.05);
                                position: relative;
                                border-left: 4px solid #4e73df;">
                                <i class="fa fa-quote-left text-muted mr-2" style="opacity: 0.3;"></i>
                                <span style="color: #4a5568; font-size: 0.95rem; line-height: 1.6;">
                                    <c:choose>
                                        <c:when test="${not empty description}">
                                            ${description}
                                        </c:when>
                                        <c:otherwise>No description available</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                        </div>
                    </div>

                    <!-- Account Actions Card -->
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fa fa-cog mr-2"></i> Account Actions
                        </div>
                        <div class="card-body">
                            <div class="action-buttons">
                                <a href="#" class="btn btn-action btn-edit">
                                    <i class="fa fa-edit"></i> Edit Profile
                                </a>
                                <% if ("active".equalsIgnoreCase(recruiter.getStatus())) { %>
                                    <a href="#" class="btn btn-action btn-suspend" data-toggle="modal" data-target="#suspendModal">
                                        <i class="fa fa-pause"></i> Suspend
                                    </a>
                                <% } else { %>
                                    <a href="#" class="btn btn-action btn-activate" data-toggle="modal" data-target="#activateModal">
                                        <i class="fa fa-check"></i> Activate
                                    </a>
                                <% } %>
                                <a href="#" class="btn btn-action btn-delete" data-toggle="modal" data-target="#deleteModal">
                                    <i class="fa fa-trash"></i> Delete
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- Financial Information Card -->
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fa fa-money-bill-wave mr-2"></i> Financial Information
                        </div>
                        <div class="card-body">
                            <div class="info-item">
                                <span class="info-label">Current Balance</span>
                                <p class="info-value" style="font-size: 16px; font-weight: 500; color: #28a745;">
                                    <c:choose>
                                        <c:when test="${not empty recruiter.money}">
                                            <fmt:formatNumber value="${recruiter.money}" type="currency" pattern="#,##0 VND" maxFractionDigits="0"/>
                                        </c:when>
                                        <c:otherwise>0 VND</c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Total Spent</span>
                                <p class="info-value" style="font-size: 16px; font-weight: 500; color: #dc3545;">
                                    <c:choose>
                                        <c:when test="${totalSpent != null}">
                                            <fmt:formatNumber value="${totalSpent}" type="number" pattern="#,##0 VND" maxFractionDigits="0"/>
                                        </c:when>
                                        <c:otherwise>0 VND</c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                        </div>
                    </div>

                    <!-- Account Status Card -->
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fa fa-info-circle mr-2"></i> Account Status
                        </div>
                        <div class="card-body">
                            <div class="info-item">
                                <span class="info-label">Status</span>
                                <p class="info-value">
                                    <span class="badge <%= "active".equalsIgnoreCase(recruiter.getStatus()) ? "badge-success" : 
                                                           ("suspended".equalsIgnoreCase(recruiter.getStatus()) ? "badge-danger" : "badge-warning") %>">
                                        <%= recruiter.getStatus() != null ? recruiter.getStatus().toUpperCase() : "UNKNOWN" %>
                                    </span>
                                </p>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Member Since</span>
                                <p class="info-value">
                                    <% if (recruiter.getDob() != null) { %>
                                        <%= new SimpleDateFormat("MMMM d, yyyy").format(recruiter.getDob()) %>
                                    <% } else { %>
                                        N/A
                                    <% } %>
                                </p>
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
                    <p>Are you sure you want to delete this recruiter's account? This action cannot be undone.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <a href="admin?action=deleteRecruiter&id=<%= recruiter.getRecruiterID() %>" class="btn btn-danger">Delete Account</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Suspend Confirmation Modal -->
    <div class="modal fade" id="suspendModal" tabindex="-1" role="dialog" aria-labelledby="suspendModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="suspendModalLabel">Suspend Account</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to suspend this recruiter's account? They will not be able to log in until their account is reactivated.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <a href="admin?action=updateRecruiterStatus&id=<%= recruiter.getRecruiterID() %>&status=inactive" class="btn btn-warning">Suspend Account</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Activate Confirmation Modal -->
    <div class="modal fade" id="activateModal" tabindex="-1" role="dialog" aria-labelledby="activateModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="activateModalLabel">Activate Account</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to activate this recruiter's account? They will be able to log in and use the platform.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <a href="admin?action=updateRecruiterStatus&id=<%= recruiter.getRecruiterID() %>&status=active" class="btn btn-success">Activate Account</a>
                </div>
            </div>
        </div>
    </div>

    <!-- JS here -->
    <script src="js/vendor/jquery-1.12.4.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/main.js"></script>
    <script>
        $(document).ready(function() {
            // Initialize tooltips
            $('[data-toggle="tooltip"]').tooltip();
            
            // Handle delete button click
            $('.btn-delete').on('click', function(e) {
                e.preventDefault();
                $('#deleteModal').modal('show');
            });
            
            // Handle suspend button click
            $('.btn-suspend').on('click', function(e) {
                e.preventDefault();
                $('#suspendModal').modal('show');
            });
            
            // Handle activate button click
            $('.btn-activate').on('click', function(e) {
                e.preventDefault();
                $('#activateModal').modal('show');
            });
        });
    </script>
</body>
</html>
