<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account Tier Registrations - Admin Panel</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <style>
        :root {
            --primary-color: #4e73df;
            --primary-hover: #2e59d9;
            --secondary-color: #858796;
            --success-color: #1cc88a;
            --info-color: #36b9cc;
            --warning-color: #f6c23e;
            --danger-color: #e74a3b;
            --light-color: #f8f9fc;
            --dark-color: #5a5c69;
            --border-color: #e3e6f0;
            --card-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
        }
        
        body {
            background-color: var(--light-color);
            color: var(--dark-color);
            font-family: 'Nunito', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            line-height: 1.5;
        }
        
        h1, h2, h3, h4, h5, h6 {
            font-weight: 700;
            color: var(--dark-color);
        }
        
        .main-content {
            padding: 1.5rem;
            transition: all 0.3s;
            background-color: var(--light-color);
        }
        
        .card {
            border: none;
            border-radius: 0.5rem;
            box-shadow: var(--card-shadow);
            margin-bottom: 1.5rem;
            background: #fff;
        }
        
        .card-header {
            background-color: #fff;
            border-bottom: 1px solid var(--border-color);
            font-weight: 700;
            padding: 1.25rem 1.5rem;
            color: var(--dark-color);
            border-radius: 0.5rem 0.5rem 0 0 !important;
        }
        
        .card-header h5 {
            margin: 0;
            font-size: 1.1rem;
            color: var(--dark-color);
        }
        
        .badge {
            font-weight: 600;
            padding: 0.35em 0.65em;
            font-size: 0.75em;
            letter-spacing: 0.5px;
        }
        
        .badge-pending {
            background-color: var(--warning-color);
            color: #000;
        }
        
        .badge-approved {
            background-color: var(--success-color);
            color: #fff;
        }
        
        .badge-rejected {
            background-color: var(--danger-color);
            color: #fff;
        }
        
        .table {
            color: var(--dark-color);
            margin-bottom: 0;
        }
        
        .table thead th {
            background-color: #f8f9fc;
            color: var(--dark-color);
            font-weight: 700;
            text-transform: uppercase;
            font-size: 0.7rem;
            letter-spacing: 0.5px;
            border-bottom: 1px solid var(--border-color);
            padding: 1rem;
        }
        
        .table tbody td {
            padding: 1rem;
            vertical-align: middle;
            border-color: var(--border-color);
        }
        
        .table-hover tbody tr:hover {
            background-color: rgba(0, 0, 0, 0.02);
        }
        
        .btn {
            font-weight: 600;
            padding: 0.375rem 0.75rem;
            font-size: 0.8rem;
            line-height: 1.5;
            border-radius: 0.35rem;
            transition: all 0.2s;
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        .btn-primary:hover {
            background-color: var(--primary-hover);
            border-color: var(--primary-hover);
        }
        
        .btn-success {
            background-color: var(--success-color);
            border-color: var(--success-color);
        }
        
        .btn-danger {
            background-color: var(--danger-color);
            border-color: var(--danger-color);
        }
        
        .form-control, .form-select {
            border: 1px solid #d1d3e2;
            border-radius: 0.35rem;
            padding: 0.5rem 0.75rem;
            font-size: 0.85rem;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: #bac8f3;
            box-shadow: 0 0 0 0.2rem rgba(78, 115, 223, 0.25);
        }
        
        .nav-tabs .nav-link {
            color: var(--secondary-color);
            font-weight: 600;
            border: none;
            padding: 1rem 1.5rem;
        }
        
        .nav-tabs .nav-link.active {
            color: var(--primary-color);
            background: transparent;
            border-bottom: 2px solid var(--primary-color);
        }
        
        .nav-tabs {
            border-bottom: 1px solid var(--border-color);
        }
        
        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #fff;
            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
        }
        
        .action-buttons .btn {
            margin-right: 0.5rem;
            min-width: 80px;
        }
    </style>
</head>
<body>
    <!-- Include the sidebar -->
    <jsp:include page="/includes/admin_sidebar.jsp" />

    <!-- Main content -->
    <div class="main-content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Account Tier Registrations</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <button type="button" class="btn btn-sm btn-outline-secondary">
                                <i class="fas fa-download me-1"></i> Export
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Pending Registrations Card -->
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <span>
                            <i class="fas fa-clock text-warning me-2"></i> Pending Approvals
                            <span class="badge bg-warning text-dark ms-2">3</span>
                        </span>
                        <button class="btn btn-sm btn-outline-secondary">
                            <i class="fas fa-sync-alt"></i> Refresh
                        </button>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>User</th>
                                        <th>Account Type</th>
                                        <th>Tier</th>
                                        <th>Requested On</th>
                                        <th>Payment Proof</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Sample Row 1 -->
                                    <tr>
                                        <td>1</td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <img src="https://via.placeholder.com/40" alt="User" class="user-avatar me-2">
                                                <div>
                                                    <div class="fw-semibold">John Doe</div>
                                                    <small class="text-muted">john@example.com</small>
                                                </div>
                                            </div>
                                        </td>
                                        <td>Freelancer</td>
                                        <td>Premium</td>
                                        <td>2025-06-09 14:30</td>
                                        <td>
                                            <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#paymentProofModal">
                                                <i class="fas fa-receipt me-1"></i> View
                                            </button>
                                        </td>
                                        <td class="action-buttons">
                                            <button class="btn btn-sm btn-success">
                                                <i class="fas fa-check"></i> Approve
                                            </button>
                                            <button class="btn btn-sm btn-danger" data-bs-toggle="modal" data-bs-target="#rejectModal">
                                                <i class="fas fa-times"></i> Reject
                                            </button>
                                        </td>
                                    </tr>
                                    
                                    <!-- Sample Row 2 -->
                                    <tr>
                                        <td>2</td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <img src="https://via.placeholder.com/40" alt="User" class="user-avatar me-2">
                                                <div>
                                                    <div class="fw-semibold">Acme Corp</div>
                                                    <small class="text-muted">info@acme.com</small>
                                                </div>
                                            </div>
                                        </td>
                                        <td>Recruiter</td>
                                        <td>Enterprise</td>
                                        <td>2025-06-08 09:15</td>
                                        <td>
                                            <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#paymentProofModal">
                                                <i class="fas fa-receipt me-1"></i> View
                                            </button>
                                        </td>
                                        <td class="action-buttons">
                                            <button class="btn btn-sm btn-success">
                                                <i class="fas fa-check"></i> Approve
                                            </button>
                                            <button class="btn btn-sm btn-danger" data-bs-toggle="modal" data-bs-target="#rejectModal">
                                                <i class="fas fa-times"></i> Reject
                                            </button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Approved/Rejected Tabs -->
                <ul class="nav nav-tabs mt-4" id="registrationTabs" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="approved-tab" data-bs-toggle="tab" data-bs-target="#approved" type="button" role="tab">
                            <i class="fas fa-check-circle text-success me-1"></i> Approved
                            <span class="badge bg-success ms-1">5</span>
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="rejected-tab" data-bs-toggle="tab" data-bs-target="#rejected" type="button" role="tab">
                            <i class="fas fa-times-circle text-danger me-1"></i> Rejected
                            <span class="badge bg-danger ms-1">2</span>
                        </button>
                    </li>
                </ul>
                <div class="tab-content p-3 border border-top-0 rounded-bottom" id="registrationTabsContent">
                    <div class="tab-pane fade show active" id="approved" role="tabpanel" aria-labelledby="approved-tab">
                        <p class="text-muted mb-0">No approved registrations to display.</p>
                    </div>
                    <div class="tab-pane fade" id="rejected" role="tabpanel" aria-labelledby="rejected-tab">
                        <p class="text-muted mb-0">No rejected registrations to display.</p>
                    </div>
                </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Payment Proof Modal -->
    <div class="modal fade" id="paymentProofModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Payment Proof</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body text-center">
                    <img src="https://via.placeholder.com/800x500" alt="Payment Proof" class="img-fluid">
                    <div class="mt-3">
                        <p class="mb-1"><strong>Transaction ID:</strong> TXN123456789</p>
                        <p class="mb-1"><strong>Amount:</strong> $99.00</p>
                        <p class="mb-0"><strong>Date:</strong> June 9, 2025 14:30</p>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <a href="#" class="btn btn-primary" download>
                        <i class="fas fa-download me-1"></i> Download
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Reject Modal -->
    <div class="modal fade" id="rejectModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title">Reject Registration</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form>
                    <div class="modal-body">
                        <p>Are you sure you want to reject this registration?</p>
                        <div class="mb-3">
                            <label for="rejectReason" class="form-label">Reason for rejection:</label>
                            <textarea class="form-control" id="rejectReason" rows="3" required></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-danger">
                            <i class="fas fa-times me-1"></i> Reject
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Initialize tooltips
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });

        // Sample function for approve/reject actions
        function approveRegistration(registrationId) {
            if (confirm('Are you sure you want to approve this registration?')) {
                // Add your AJAX call here
                console.log('Approving registration:', registrationId);
                // Example: fetch(`/approve-registration/${registrationId}`, { method: 'POST' })
            }
        }
        
        function rejectRegistration(registrationId) {
            const reason = document.getElementById('rejectReason').value;
            if (!reason.trim()) {
                alert('Please provide a reason for rejection.');
                return;
            }
            // Add your AJAX call here
            console.log('Rejecting registration:', registrationId, 'Reason:', reason);
            // Example: fetch(`/reject-registration/${registrationId}`, { 
            //     method: 'POST',
            //     body: JSON.stringify({ reason: reason }),
            //     headers: { 'Content-Type': 'application/json' }
            // })
        }
        
        // Handle sidebar toggle
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            const mainContent = document.querySelector('.main-content');
            const toggleBtn = document.querySelector('.sidebar-toggle');
            
            sidebar.classList.toggle('active');
            mainContent.classList.toggle('sidebar-collapsed');
            
            // Toggle chevron icon
            const icon = toggleBtn.querySelector('i');
            if (sidebar.classList.contains('active')) {
                icon.classList.remove('fa-chevron-right');
                icon.classList.add('fa-chevron-left');
            } else {
                icon.classList.remove('fa-chevron-left');
                icon.classList.add('fa-chevron-right');
            }
        }
        
        // Close sidebar when clicking outside
        document.addEventListener('click', function(event) {
            const sidebar = document.getElementById('sidebar');
            const toggleBtn = document.querySelector('.sidebar-toggle');
            const isClickInside = sidebar.contains(event.target) || toggleBtn.contains(event.target);
            
            if (!isClickInside && window.innerWidth <= 992) {
                sidebar.classList.remove('active');
                document.querySelector('.main-content').classList.remove('sidebar-collapsed');
                const icon = toggleBtn.querySelector('i');
                icon.classList.remove('fa-chevron-left');
                icon.classList.add('fa-chevron-right');
            }
        });
        
        // Handle window resize
        window.addEventListener('resize', function() {
            const sidebar = document.getElementById('sidebar');
            const mainContent = document.querySelector('.main-content');
            const toggleBtn = document.querySelector('.sidebar-toggle');
            
            if (window.innerWidth > 992) {
                sidebar.classList.add('active');
                mainContent.classList.add('sidebar-collapsed');
                const icon = toggleBtn.querySelector('i');
                icon.classList.remove('fa-chevron-right');
                icon.classList.add('fa-chevron-left');
            } else {
                sidebar.classList.remove('active');
                mainContent.classList.remove('sidebar-collapsed');
                const icon = toggleBtn.querySelector('i');
                icon.classList.remove('fa-chevron-left');
                icon.classList.add('fa-chevron-right');
            }
        });
        
        // Initialize on page load
        document.addEventListener('DOMContentLoaded', function() {
            if (window.innerWidth > 992) {
                document.getElementById('sidebar').classList.add('active');
                document.querySelector('.main-content').classList.add('sidebar-collapsed');
                const icon = document.querySelector('.sidebar-toggle i');
                icon.classList.remove('fa-chevron-right');
                icon.classList.add('fa-chevron-left');
            }
        });
    </script>
</body>
</html>
