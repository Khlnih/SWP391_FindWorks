<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.util.*" %>
<%@ page import="Model.RecruiterSubscription" %>

<!-- Debug Info -->
<% 
    // Log the recruiterSubscriptions attribute
    List<RecruiterSubscription> recruiterSubs = (List<RecruiterSubscription>) request.getAttribute("recruiterSubscriptions");
    if (recruiterSubs != null) {
        System.out.println("JSP - recruiterSubscriptions size: " + recruiterSubs.size());
        for (RecruiterSubscription rs : recruiterSubs) {
            System.out.println("Subscription ID: " + rs.getSubscriptionID() + ", Company: " + rs.getCompanyName());
        }
    } else {
        System.out.println("JSP - recruiterSubscriptions is NULL");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Subscription Management - FindWorks Admin</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- DataTables CSS -->
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.5/css/dataTables.bootstrap5.min.css">
    <!-- AOS Animation -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <!-- Custom styles -->
    <style>
        /* Modern color palette */
        :root {
            --primary: #4361ee;
            --primary-hover: #3a56d4;
            --primary-light: #eef2ff;
            --secondary: #6c757d;
            --success: #10b981;
            --success-hover: #0d9f6e;
            --success-light: #ecfdf5;
            --warning: #f59e0b;
            --warning-light: #fffbeb;
            --danger: #ef4444;
            --danger-hover: #dc2626;
            --danger-light: #fef2f2;
            --info: #3b82f6;
            --info-light: #eff6ff;
            --light: #f8f9fa;
            --dark: #1e293b;
            --gray-100: #f1f5f9;
            --gray-200: #e2e8f0;
            --gray-300: #cbd5e1;
            --gray-400: #94a3b8;
            --gray-500: #64748b;
            --gray-600: #475569;
            --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
            --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            --shadow-hover: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            --border-radius: 0.5rem;
            --card-padding: 1.5rem;
        }
           
        
        /* Custom Scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
            height: 8px;
        }
        
        ::-webkit-scrollbar-track {
            background: var(--gray-100);
            border-radius: 4px;
        }
        
        ::-webkit-scrollbar-thumb {
            background: var(--gray-300);
            border-radius: 4px;
        }
        
        ::-webkit-scrollbar-thumb:hover {
            background: var(--gray-400);
        }
        
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background-color: #f8f9fc;
            color: #5a5c69;
            line-height: 1.6;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }
        
        /* Stats Cards */
        .table {
            background: white;
            border-radius: var(--border-radius);
            overflow: hidden;
            box-shadow: var(--shadow);
            border-collapse: separate;
            border-spacing: 0;
        }
        
        .table thead th {
            background: var(--primary);
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.75rem;
            letter-spacing: 0.5px;
            padding: 1rem 1.5rem;
            border: none;
        }
        
        .table tbody tr {
            transition: var(--transition);
        }
        
        .table tbody tr:hover {
            background: var(--gray-50);
        }
        
        .table tbody td {
            padding: 1rem 1.5rem;
            vertical-align: middle;
            border-top: 1px solid var(--gray-200);
        }
        
        .table tbody tr:first-child td {
            border-top: none;
        }
        
        .stats-card {
            background: white;
            border-radius: var(--border-radius);
            padding: 1.75rem;
            box-shadow: var(--shadow);
            transition: var(--transition);
            height: 100%;
            position: relative;
            overflow: hidden;
            border: none;
            z-index: 1;
            border-top: 4px solid var(--primary);
            display: flex;
            flex-direction: column;
        }
        
        .stats-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-hover);
        }
        
        .stats-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--primary);
            opacity: 0.8;
            transition: var(--transition);
        }
        
        .stats-card:hover::before {
            height: 6px;
            opacity: 1;
        }
        
        .stats-card .icon {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1rem;
            font-size: 1.5rem;
            color: white;
        }
        
        .stats-card .icon.primary { background-color: var(--primary-color); }
        .stats-card .icon.success { background-color: var(--success-color); }
        .stats-card .icon.warning { background-color: var(--warning-color); }
        .stats-card .icon.danger { background-color: var(--danger-color); }
        
        .stats-card h3 {
            font-size: 0.875rem;
            font-weight: 500;
            color: var(--gray-600);
            margin-bottom: 0.5rem;
        }
        
        .stats-card h2 {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--dark-color);
            margin-bottom: 0.5rem;
        }
        
        .stats-card .text-success {
            display: flex;
            align-items: center;
            font-size: 0.75rem;
            font-weight: 500;
        }
        
        /* Main Card */
        .container-fluid {
            max-width: 100%;
            padding: 0;
            max-width: 100%;
            padding: 0;
            max-width: 100%;
            padding: 0;
            max-width: 100%;
            padding-left: 0;
            padding-right: 2rem;
            max-width: 100%;
            padding-left: 0;
            padding-right: 2rem;
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            margin-bottom: 1.5rem;
            overflow: hidden;
            border: none;
            transition: var(--transition);
            border-left: 0.25rem solid transparent;
        }
        
        .main-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-hover);
        }
        
        .card {
            border: none;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            transition: var(--transition);
            margin-bottom: 1.5rem;
            overflow: hidden;
            background: white;
            border-top: 3px solid var(--primary);
        }
        
        .card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-hover);
        }
        
        .card-header {
            background: white;
            border-bottom: 1px solid var(--gray-200);
            padding: 1.25rem 1.5rem;
            font-weight: 600;
            color: var(--dark);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        
        .card-body {
            padding: 1.5rem;
        }
        
        /* Tables */
        .table {
            margin-bottom: 0;
            width: 100%;
            color: var(--dark);
            border-collapse: separate;
            border-spacing: 0;
        }
        
        .table thead th {
            background-color: #f8f9fc;
            color: var(--gray-800);
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.7rem;
            letter-spacing: 0.5px;
            padding: 1rem 1.25rem;
            border: none;
            border-bottom: 1px solid var(--gray-200);
        }
        
        .table tbody td {
            padding: 1rem 1.25rem;
            vertical-align: middle;
            border-top: 1px solid var(--gray-200);
            transition: var(--transition);
        }
        
        .table tbody tr {
            transition: var(--transition);
        }
        
        .table tbody tr:hover td {
            background-color: rgba(78, 115, 223, 0.05);
        }
        
        .badge {
            padding: 0.4em 0.8em;
            font-weight: 600;
            border-radius: 50rem;
            font-size: 0.7rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .table thead th {
            background-color: var(--gray-100);
            color: var(--gray-600);
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.75rem;
            letter-spacing: 0.5px;
            padding: 1rem 1.5rem;
            white-space: nowrap;
            border: none;
        }
        
        .nav-tabs-custom {
            border: none;
            background: white;
            padding: 0.5rem;
            border-radius: 50rem;
            display: inline-flex;
            box-shadow: 0 0 15px rgba(0,0,0,0.05);
            margin-bottom: 2rem;
        }
        
        .nav-tabs-custom .nav-link {
            border: none;
            color: var(--gray-600);
            font-weight: 500;
            padding: 0.75rem 1.5rem;
            border-radius: 50px;
            margin-right: 0.5rem;
            transition: var(--transition);
            position: relative;
            overflow: hidden;
            background: var(--gray-100);
        }
        
        .nav-tabs-custom .nav-link.active {
            background: var(--primary);
            color: white;
            box-shadow: 0 4px 6px -1px rgba(67, 97, 238, 0.3);
            transform: translateY(-2px);
        }
        
        .nav-tabs-custom .nav-link::before {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 3px;
            background: var(--primary);
            transform: scaleX(0);
            transition: transform 0.3s ease;
        }
        
        .nav-tabs-custom .nav-link:hover::before {
            transform: scaleX(1);
        }
        
        .page-header {
            padding: 1.5rem 2rem;
            margin: 0 0 2rem 0;
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            position: relative;
            overflow: hidden;
            border-left: 4px solid var(--primary);
            transition: var(--transition);
        }
        
        .page-header:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-hover);
        }
        
        .page-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: linear-gradient(to bottom, #4e73df, #36b9cc);
        }
        
        .btn {
            font-weight: 500;
            padding: 0.6rem 1.5rem;
            border-radius: 50px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            position: relative;
            overflow: hidden;
            border: none;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        
        .btn:active {
            transform: translateY(0);
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .btn i {
            font-size: 1rem;
        }
        
        .btn-primary {
            background: var(--primary);
            background: linear-gradient(135deg, var(--primary) 0%, #3b82f6 100%);
            position: relative;
            overflow: hidden;
            z-index: 1;
        }
        
        .btn-primary::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, #3b82f6 0%, var(--primary) 100%);
            opacity: 0;
            transition: opacity 0.3s ease;
            z-index: -1;
        }
        
        .btn-primary:hover::before {
            opacity: 1;
        }
        
        .badge {
            font-weight: 500;
            padding: 0.5em 0.9em;
            font-size: 0.75em;
            letter-spacing: 0.5px;
            border-radius: 50px;
            text-transform: uppercase;
            font-weight: 600;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        
        .badge.bg-success {
            background-color: var(--success-light) !important;
            color: var(--success) !important;
        }
        
        .badge.bg-warning {
            background-color: var(--warning-light) !important;
            color: var(--warning) !important;
        }
        
        .badge.bg-danger {
            background-color: var(--danger-light) !important;
            color: var(--danger) !important;
        }
        
        .badge.bg-info {
            background-color: var(--info-light) !important;
            color: var(--info) !important;
        }
        
        /* Responsive */
        @media (max-width: 1199.98px) {
            .main-content {
                margin-left: 0;
            }
            
            .stats-card h2 {
                font-size: 1.25rem;
            }
        }
        
        @media (max-width: 991.98px) {
            .page-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }
            
            .page-actions {
                width: 100%;
            }
            
            .search-box {
                max-width: 100% !important;
            }
        }
        
        @media (max-width: 767.98px) {
            .page-title {
                font-size: 1.5rem;
            }
            
            .card-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }
            
            .card-header-actions {
                width: 100%;
                justify-content: space-between;
            }
            
            .search-box {
                max-width: 100% !important;
            }
            
            .table-responsive {
                border: 0;
            }
            
            .table thead {
                display: none;
            }
            
            .table tbody tr {
                display: block;
                margin-bottom: 1rem;
                border: 1px solid var(--gray-200);
                border-radius: var(--border-radius);
                overflow: hidden;
            }
            
            .table tbody td {
                display: flex;
                justify-content: space-between;
                padding: 0.75rem 1rem;
                border: none;
                text-align: right;
                border-bottom: 1px solid var(--gray-100);
            }
            
            .table tbody td::before {
                content: attr(data-label);
                font-weight: 600;
                color: var(--gray-600);
                margin-right: 1rem;
                text-align: left;
                flex: 1;
            }
            
            .table tbody td:last-child {
                border-bottom: none;
            }
            
            .table tbody td .user-info {
                justify-content: flex-end;
                flex-direction: row-reverse;
                text-align: right;
                width: 100%;
            }
            
            .table tbody td .user-avatar {
                margin-right: 0;
                margin-left: 0.75rem;
            }
            
            .table tbody td .d-flex {
                justify-content: flex-end;
                width: 100%;
            }
            
            .table tbody td .btn {
                padding: 0.25rem 0.5rem;
                font-size: 0.75rem;
            }
        }
        
        @media (max-width: 575.98px) {
            .page-title {
                font-size: 1.25rem;
            }
            
            .stats-card {
                padding: 1.25rem 1rem;
            }
            
            .stats-card h2 {
                font-size: 1.1rem;
            }
            
            .stats-card h3 {
                font-size: 0.8125rem;
            }
            
            .card-header h5 {
                font-size: 1.1rem;
            }
            
            .table tbody td {
                padding: 0.65rem 0.75rem;
                font-size: 0.875rem;
            }
            
            .table tbody td::before {
                font-size: 0.75rem;
            }
        }
    </style>
</head>
<body>
    <!-- Include the sidebar -->
    <jsp:include page="/includes/admin_sidebar.jsp" />
    
    <!-- Toast Container -->
    <div class="toast-container position-fixed top-0 end-0 p-3" style="z-index: 1090">
        <!-- Toast messages will be inserted here by JavaScript -->
    </div>

    <!-- Main content -->
    <div class="main-content">
        <div class="container-fluid">
            <!-- Page Header -->
            <div class="page-header">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1 class="page-title">
                        <i class="fas fa-layer-group me-2 text-primary"></i>
                        Subscription Management
                    </h1>
                    
                </div>
                
                <!-- Navigation Tabs -->
                <ul class="nav nav-tabs nav-tabs-custom mb-4" id="dashboardTabs" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="overview-tab" data-bs-toggle="tab" data-bs-target="#overview" type="button" role="tab">
                            <i class="fas fa-chart-pie me-2"></i>Overview
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="freelancer-tab" data-bs-toggle="tab" data-bs-target="#freelancer" type="button" role="tab">
                            <i class="fas fa-user-tie me-2"></i>Freelancer
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="recruiter-tab" data-bs-toggle="tab" data-bs-target="#recruiter" type="button" role="tab">
                            <i class="fas fa-briefcase me-2"></i>Recruiter
                        </button>
                    </li>
                </ul>
                
                <style>
                    .nav-tabs-custom .nav-link {
                        border: none;
                        color: var(--gray-600);
                        font-weight: 500;
                        padding: 0.6rem 1.5rem;
                        border-radius: 50px;
                        margin: 0 0.2rem;
                        transition: all 0.3s ease;
                        position: relative;
                        z-index: 1;
                        font-size: 0.8rem;
                        text-transform: uppercase;
                        letter-spacing: 0.5px;
                    }
                    
                    .nav-tabs-custom .nav-link.active {
                        color: white;
                        background: linear-gradient(135deg, #4e73df 0%, #224abe 100%);
                        box-shadow: 0 4px 15px rgba(78, 115, 223, 0.4);
                    }
                    
                    .nav-tabs-custom .nav-link:hover:not(.active) {
                        color: #2563eb;
                        background-color: rgba(59, 130, 246, 0.05);
                    }
                    
                    .tab-content {
                        padding: 1.5rem 0;
                    }
                    
                    @media (max-width: 768px) {
                        .nav-tabs-custom .nav-link {
                            padding: 0.5rem 0.75rem;
                            font-size: 0.9rem;
                        }
                        
                        .nav-tabs-custom .nav-link i {
                            margin-right: 0.25rem !important;
                        }
                    }
                </style>

                
                    
                    <!-- Freelancer Tab - Only display Freelancer table -->
                    <div class="tab-pane fade" id="freelancer" role="tabpanel" aria-labelledby="freelancer-tab">
                        <div class="card">
                            <div class="card-header bg-white">
                                <h5 class="mb-0">
                                    <i class="fas fa-user-graduate text-primary me-2"></i>
                                    Freelancer Subscriptions List
                                </h5>
                            </div>
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table id="freelancerTable" class="table table-hover align-middle mb-0">
                                        <thead class="table-light">
                                            <tr>
                                                <th style="width: 30%;">User</th>
                                                <th style="width: 20%;">Tier</th>
                                                <th style="width: 15%;">Start Date</th>
                                                <th style="width: 15%;">End Date</th>
                                                <th style="width: 10%;">Status</th>
                                                <th style="width: 10%;">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="subscription" items="${freelancerSubscriptions}">
                                                <tr>
                                                    <td data-label="User">
                                                        <div class="user-info">
                                                            <div class="user-details">
                                                                <h6>${subscription.first_name} ${subscription.last_name}</h6>
                                                                <small>${subscription.username}</small>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td data-label="Tier">
                                                        <div class="fw-semibold">${subscription.tierName}</div>
                                                        <small class="text-muted">${subscription.price} / month</small>
                                                    </td>
                                                    <td data-label="Start Date">${subscription.startDate}</td>
                                                    <td data-label="End Date">${subscription.endDate}</td>
                                                    <td data-label="Status">
                                                        <span class="badge 
                                                            <c:choose>
                                                                <c:when test="${subscription.isActiveSubscription}">
                                                                    bg-warning bg-opacity-10 text-warning
                                                                </c:when>
                                                                <c:otherwise>
                                                                    bg-danger bg-opacity-10 text-danger
                                                                </c:otherwise>
                                                            </c:choose>">
                                                            <c:choose>
                                                                <c:when test="${subscription.isActiveSubscription}">
                                                                    Pending
                                                                </c:when>
                                                                <c:otherwise>
                                                                    Expired
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                    </td>
                                                    <td data-label="Actions" class="text-center">
                                                        <div class="d-flex flex-wrap justify-content-center gap-2">
                                                            <!-- Approve Button -->
                                                            <form method="post" action="admin" style="display: inline;">
                                                                <input type="hidden" name="action" value="updateStatus">
                                                                <input type="hidden" name="subscriptionID" value="${subscription.subscriptionID}">
                                                                <input type="hidden" name="statusInt" value="0">
                                                                <button type="submit" 
                                                                        class="btn btn-sm btn-success" 
                                                                        data-bs-toggle="tooltip" 
                                                                        data-bs-placement="top" 
                                                                        title="Approve"
                                                                        onclick="return confirm('Bạn có chắc chắn muốn duyệt đăng ký này?')">
                                                                    <i class="fas fa-check me-1"></i> Duyệt
                                                                </button>
                                                            </form>
                                                            
                                                            <form method="post" action="admin" style="display: inline;">
                                                                <input type="hidden" name="action" value="updateStatus">
                                                                <input type="hidden" name="subscriptionID" value="${subscription.subscriptionID}">
                                                                <input type="hidden" name="statusInt" value="2">
                                                                <button type="submit" 
                                                                        class="btn btn-sm btn-danger" 
                                                                        data-bs-toggle="tooltip" 
                                                                        data-bs-placement="top" 
                                                                        title="Từ chối"
                                                                        onclick="return confirm('Bạn có chắc chắn muốn từ chối đăng ký này?')">
                                                                    <i class="fas fa-times me-1"></i> Reject
                                                                </button>
                                                            </form>
                                                           
                                                            <button type="button" 
                                                                    class="btn btn-sm btn-outline-secondary" 
                                                                    data-bs-toggle="tooltip" 
                                                                    data-bs-placement="top" 
                                                                    title="View Details"
                                                                    onclick="showSubscriptionDetails('${subscription.subscriptionID}')">
                                                                <i class="fas fa-eye"></i>
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Recruiter Tab - Only display Recruiter table -->
                    <div class="tab-pane fade" id="recruiter" role="tabpanel" aria-labelledby="recruiter-tab">
                        <div class="card">
                            <div class="card-header bg-white">
                                <h5 class="mb-0">
                                    <i class="fas fa-briefcase text-info me-2"></i>
                                    Recruiter Subscriptions List
                                </h5>
                            </div>
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table id="recruiterTable" class="table table-hover align-middle mb-0">
                                        <thead class="table-light">
                                            <tr>
                                                <th style="width: 25%;">Recruiter</th>
                                                <th style="width: 20%;">Company</th>
                                                <th style="width: 15%;">Tier</th>
                                                <th style="width: 15%;">Price</th>
                                                <th style="width: 10%;">Start Date</th>
                                                <th style="width: 10%;">End Date</th>
                                                <th style="width: 10%;">Status</th>
                                                <th style="width: 15%;">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:choose>
                                                <c:when test="${empty recruiterSubscriptions}">
                                                    <tr>
                                                        <td colspan="8" class="text-center py-5">
                                                            <div class="alert alert-info">
                                                                <i class="fas fa-info-circle me-2"></i>
                                                                No subscription data available to display.
                                                                <c:if test="${not empty error}">
                                                                    <div class="mt-2 text-danger">Error: ${error}</div>
                                                                </c:if>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:forEach var="sub" items="${recruiterSubscriptions}">
                                                        <tr>
                                                            <td data-label="Recruiter">
                                                                <div class="d-flex align-items-center">
                                                                    <div class="user-details">
                                                                        <h6 class="mb-0">${sub.first_name} ${sub.last_name}</h6>
                                                                        <small class="text-muted">${sub.companyEmail}</small>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td data-label="Company">
                                                                ${sub.companyName}
                                                            </td>
                                                            <td data-label="Tier">${sub.tierName}</td>
                                                            <td data-label="Price">
                                                                <fmt:formatNumber value="${sub.price}" type="currency" currencyCode="VND" maxFractionDigits="0"/>
                                                            </td>
                                                            <td data-label="Start Date">
                                                                <fmt:parseDate value="${sub.startDate}" pattern="yyyy-MM-dd" var="parsedStartDate" />
                                                                <fmt:formatDate value="${parsedStartDate}" pattern="dd/MM/yyyy" />
                                                            </td>
                                                            <td data-label="End Date">
                                                                <fmt:parseDate value="${sub.endDate}" pattern="yyyy-MM-dd" var="parsedEndDate" />
                                                                <fmt:formatDate value="${parsedEndDate}" pattern="dd/MM/yyyy" />
                                                            </td>
                                                            <td data-label="Status">
                                                                <c:choose>
                                                                    <c:when test="${sub.isActiveSubscription}">
                                                                        <span class="badge bg-warning bg-opacity-10 text-warning">Pending</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="badge bg-danger">Expired</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td data-label="Actions" class="text-center">
                                                                <div class="d-flex flex-wrap justify-content-center gap-2">
                                                                    <form method="post" action="admin" style="display: inline;">
                                                                        <input type="hidden" name="action" value="updateStatus">
                                                                        <input type="hidden" name="subscriptionID" value="${sub.subscriptionID}">
                                                                        <input type="hidden" name="statusInt" value="0">
                                                                        <button type="submit" 
                                                                                class="btn btn-sm btn-success" 
                                                                                data-bs-toggle="tooltip" 
                                                                                data-bs-placement="top" 
                                                                                title="Approve"
                                                                                onclick="return confirm('Bạn có chắc chắn muốn duyệt đăng ký này?')">
                                                                            <i class="fas fa-check me-1"></i> Duyệt
                                                                        </button>
                                                                    </form>

                                                                    <form method="post" action="admin" style="display: inline;">
                                                                        <input type="hidden" name="action" value="updateStatus">
                                                                        <input type="hidden" name="subscriptionID" value="${sub.subscriptionID}">
                                                                        <input type="hidden" name="statusInt" value="2">
                                                                        <button type="submit" 
                                                                                class="btn btn-sm btn-danger" 
                                                                                data-bs-toggle="tooltip" 
                                                                                data-bs-placement="top" 
                                                                                title="Từ chối"
                                                                                onclick="return confirm('Bạn có chắc chắn muốn từ chối đăng ký này?')">
                                                                            <i class="fas fa-times me-1"></i> Reject
                                                                        </button>
                                                                    </form>
                                                                    <button type="button" 
                                                                            class="btn btn-sm btn-outline-secondary" 
                                                                            data-bs-toggle="tooltip" 
                                                                            data-bs-placement="top" 
                                                                            title="View Details"
                                                                            onclick="showSubscriptionDetails('${sub.subscriptionID}')">
                                                                        <i class="fas fa-eye"></i>
                                                                    </button>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:otherwise>
                                            </c:choose>
                                        </tbody>
                                              
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                                           
                 

    

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.datatables.net/1.13.5/js/dataTables.bootstrap5.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    
    <!-- Toast Notification -->
    <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
        <div id="toast" class="toast hide" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-header">
                <strong class="me-auto">Notification</strong>
                <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
            <div class="toast-body"></div>
        </div>
    </div>

    <script>
        // Show toast notification
        function showToast(message, type = 'success') {
            const toastEl = document.getElementById('toast');
            const toastBody = toastEl.querySelector('.toast-body');
            
            // Set message and style
            toastBody.textContent = message;
            
            // Set background color based on type
            if (type === 'success') {
                toastEl.classList.add('bg-success', 'text-white');
            } else if (type === 'error') {
                toastEl.classList.add('bg-danger', 'text-white');
            }
            
            // Show the toast
            const toast = new bootstrap.Toast(toastEl);
            toast.show();
            
            // Auto-hide after 3 seconds
            setTimeout(() => {
                toast.hide();
            }, 3000);
        }

        function updateSubscriptionStatus(subscriptionId, status) {
            const message = status === 'APPROVED' 
                ? 'Are you sure you want to approve this subscription?'
                : 'Are you sure you want to reject this subscription?';

            if (confirm(message)) {
                // Show loading state
                const button = event.target.closest('button');
                const originalText = button.innerHTML;
                button.disabled = true;
                button.innerHTML = '<span class="spinner-border spinner-border-sm me-1" role="status" aria-hidden="true"></span>Processing...';
                
                // Simulate API call
                setTimeout(() => {
                    // Here you would typically make an AJAX call to update the status
                    const statusText = status === 'APPROVED' ? 'approved' : 'rejected';
                    
                    // Show success message
                    showToast(`Subscription ${statusText} successfully!`, 'success');
                    
                    // Reset button state
                    button.disabled = false;
                    button.innerHTML = originalText;
                    
                    // Optional: Update UI or reload the page
                    // location.reload();
                }, 1000);
            }
        }

        function showSubscriptionDetails(subscriptionId) {
            // Implementation for showing subscription details
            alert('Showing details for subscription: ' + subscriptionId);
        }

        document.addEventListener('DOMContentLoaded', function() {
            const tabLinks = document.querySelectorAll('.nav-tabs-custom .nav-link');
            
            tabLinks.forEach(link => {
                link.addEventListener('click', function() {
                    const tabId = this.getAttribute('data-bs-target');
                    
                    // Update URL to maintain tab state
                    const url = new URL(window.location.href);
                    url.searchParams.set('tab', tabId.substring(1)); // Loại bỏ dấu #
                    history.pushState({}, '', url);
                });
            });
        });
        window.addEventListener('load', function() {
            const urlParams = new URLSearchParams(window.location.search);
            const activeTab = urlParams.get('tab') || 'overview';
            
            if (activeTab) {
                const tabLink = document.querySelector(`.nav-tabs-custom [data-bs-target='#${activeTab}']`);
                if (tabLink) {
                    const tab = new bootstrap.Tab(tabLink);
                    tab.show();
                }
            }
        });
        document.addEventListener('shown.bs.tab', function(e) {
            const tabId = e.target.getAttribute('data-bs-target');
            
            // Update URL with current tab
            const url = new URL(window.location.href);
            url.searchParams.set('tab', tabId.substring(1));
            history.pushState({}, '', url);
        });

        
    </script>
</body>
</html>
