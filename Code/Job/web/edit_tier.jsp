<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Tier - Admin</title>
    
    <!-- Favicon -->
    <link rel="shortcut icon" href="img/icon/logo_ico.ico" type="image/x-icon">
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #3b82f6;
            --primary-light: #eff6ff;
            --primary-hover: #2563eb;
            --secondary-color: #64748b;
            --success-color: #10b981;
            --danger-color: #ef4444;
            --light-bg: #f8fafc;
            --border-color: #e2e8f0;
            --card-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.05), 0 4px 6px -2px rgba(0, 0, 0, 0.025);
            --text-primary: #1e293b;
            --text-secondary: #64748b;
            --transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
        }
        
        body {
            background-color: #f8fafc;
            font-family: 'Plus Jakarta Sans', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            color: var(--text-primary);
            line-height: 1.6;
        }
        
        .form-container {
            max-width: 900px;
            margin: 2rem auto;
            padding: 2.5rem;
            background: #fff;
            border-radius: 16px;
            box-shadow: var(--card-shadow);
            border: 1px solid rgba(0, 0, 0, 0.04);
        }
        
        .form-section {
            margin-bottom: 2.5rem;
        }
        
        .form-section:last-child {
            margin-bottom: 0;
        }
        
        .form-section-title {
            display: flex;
            align-items: center;
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 1.5rem;
            padding-bottom: 0.75rem;
            border-bottom: 2px solid var(--border-color);
        }
        
        .form-section-title i {
            margin-right: 0.75rem;
            color: var(--primary-color);
            font-size: 1.5rem;
        }
        
        .form-label {
            font-weight: 500;
            margin-bottom: 0.5rem;
            color: var(--text-primary);
        }
        
        .form-label.required:after {
            content: " *";
            color: var(--danger-color);
        }
        
        .form-control, .form-select {
            padding: 0.75rem 1rem;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            transition: var(--transition);
            font-size: 0.95rem;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }
        
        .form-text {
            font-size: 0.85rem;
            color: var(--text-secondary);
        }
        
        .btn {
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            font-weight: 500;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        .btn-primary:hover {
            background-color: var(--primary-hover);
            border-color: var(--primary-hover);
        }
        
        .btn-outline-secondary {
            color: var(--secondary-color);
            border-color: var(--border-color);
        }
        
        .btn-outline-secondary:hover {
            background-color: #f1f5f9;
            border-color: #cbd5e1;
        }
        
        .btn i {
            margin-right: 0.5rem;
            font-size: 0.9em;
        }
        
        .form-switch .form-check-input {
            width: 2.5em;
            margin-left: -2.5em;
            background-color: #e2e8f0;
            border-color: #cbd5e1;
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='-4 -4 8 8' fill='%236b7280'%3e%3ccircle r='3' fill='%23fff'/%3e%3c/svg%3e");
            cursor: pointer;
        }
        
        .form-switch .form-check-input:checked {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        .page-header {
            background: linear-gradient(135deg, #fff 0%, #f8fafc 100%);
            padding: 2rem 2.5rem;
            border-radius: 16px;
            margin-bottom: 2.5rem;
            box-shadow: var(--card-shadow);
            border: 1px solid rgba(0, 0, 0, 0.04);
        }
        
        .page-header h2 {
            font-weight: 700;
            color: var(--text-primary);
            margin: 0;
        }
        
        .page-header .breadcrumb {
            margin-bottom: 0;
            font-size: 0.9rem;
            background: transparent;
            padding: 0.5rem 0;
        }
        
        .page-header .breadcrumb-item a {
            color: var(--primary-color);
            text-decoration: none;
            transition: var(--transition);
        }
        
        .page-header .breadcrumb-item a:hover {
            text-decoration: underline;
        }
        
        .page-header .breadcrumb-item.active {
            color: var(--secondary-color);
        }
        
        .alert {
            border-radius: 8px;
            padding: 1rem 1.25rem;
            margin-bottom: 1.5rem;
            border: 1px solid transparent;
        }
        
        .alert-success {
            background-color: #f0fdf4;
            border-color: #bbf7d0;
            color: #166534;
        }
        
        .alert-danger {
            background-color: #fef2f2;
            border-color: #fecaca;
            color: #991b1b;
        }
        
        .input-group-text {
            background-color: #f8fafc;
            border: 1px solid var(--border-color);
            color: var(--text-secondary);
        }
        
        /* Responsive adjustments */
        @media (max-width: 768px) {
            .form-container {
                padding: 1.5rem;
            }
            
            .page-header {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="container py-6">
        <div class="page-header">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h2 class="mb-2">
                        <i class="fas fa-crown me-2"></i>Edit Account Tier
                    </h2>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="admin">Dashboard</a></li>
                            <li class="breadcrumb-item"><a href="admin?action=accounttier">Account Tiers</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Edit Tier</li>
                        </ol>
                    </nav>
                </div>
                <div>
                    <a href="admin?action=accounttier" class="btn btn-outline-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Back to List
                    </a>
                </div>
            </div>
        </div>
        
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>${successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        
        <div class="form-container">
            <div class="form-section">
                <div class="form-section-title">
                    <i class="fas fa-info-circle"></i>
                    <span>Basic Information</span>
                </div>
                
                <form id="tierForm" action="admin" method="POST" onsubmit="return validateForm()">
                    <input type="hidden" name="action" value="updateTier">
                    <input type="hidden" name="tierId" value="${tier.tierID}">
                    
                    <div class="row g-4 mb-4">
                        <!-- Tier Name -->
                        <div class="col-md-8">
                            <div class="form-group">
                                <label for="tierName" class="form-label required">Tier Name</label>
                                <input type="text" class="form-control" id="tierName" name="tierName" 
                                       value="${tier.tierName}" required>
                                <div class="form-text">Enter a unique name for this tier</div>
                            </div>
                        </div>
                        
                        <!-- Status -->
                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="form-label d-block">Status</label>
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" role="switch" id="statusToggle" 
                                           ${tier.status ? 'checked' : ''}>
                                    <input type="hidden" name="status" id="status" value="${tier.status ? '1' : '0'}">
                                    <label class="form-check-label" for="statusToggle">
                                        ${tier.status ? 'Active' : 'Inactive'}
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row g-4 mb-4">
                        <!-- Price -->
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="price" class="form-label required">Price (VND)</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="fas fa-tag"></i>
                                    </span>
                                    <input type="text" class="form-control" id="price" name="price" 
                                           value="<fmt:formatNumber value='${tier.price}' type='number' pattern='#,##0'/>" 
                                           required>
                                </div>
                                <div class="form-text">Enter amount in VND (e.g., 1,000,000)</div>
                            </div>
                        </div>
                        
                        <!-- Duration -->
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="durationDays" class="form-label required">Duration (Days)</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="far fa-calendar-alt"></i>
                                    </span>
                                    <input type="number" class="form-control" id="durationDays" name="durationDays" 
                                           value="${tier.durationDays}" min="1" required>
                                </div>
                                <div class="form-text">Number of days this tier is valid</div>
                            </div>
                        </div>
                        
                        <!-- Job Post Limit -->
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="jobPostLimit" class="form-label required">Job Post Limit</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="fas fa-briefcase"></i>
                                    </span>
                                    <input type="number" class="form-control" id="jobPostLimit" name="jobPostLimit" 
                                           value="${tier.jobPostLimit}" min="0" required>
                                </div>
                                <div class="form-text">Maximum number of job posts allowed (0 for unlimited)</div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- User Type Scope -->
                    <div class="row g-4 mb-4">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="typeScope" class="form-label required">User Type</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="fas fa-users"></i>
                                    </span>
                                    <select class="form-select" id="typeScope" name="typeScope" required>
                                        <option value="Recruiter" ${tier.userTypeScope == 'Recruiter' ? 'selected' : ''}>Recruiter</option>
                                        <option value="Jobseeker" ${tier.userTypeScope == 'Jobseeker' ? 'selected' : ''}>Jobseeker</option>
                                    </select>
                                </div>
                                <div class="form-text">
                                    Select the user type this tier applies to
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Description -->
                    <div class="mb-4">
                        <div class="form-group">
                            <label for="description" class="form-label">Description</label>
                            <textarea class="form-control" id="description" name="description" rows="4" 
                                     placeholder="Enter a detailed description of this tier">${tier.description}</textarea>
                        </div>
                    </div>
                    
                    <!-- Form Actions -->
                    <div class="d-flex justify-content-end gap-3 pt-3 border-top">
                        <a href="admin?action=accounttier" class="btn btn-outline-secondary">
                            <i class="fas fa-times me-2"></i>Cancel
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save me-2"></i>Save Changes
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Format price input with commas
        document.getElementById('price').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            if (value) {
                value = parseInt(value, 10).toLocaleString('en-US');
            }
            e.target.value = value;
        });
        
        // Toggle status switch
        const statusToggle = document.getElementById('statusToggle');
        const statusInput = document.getElementById('status');
        const statusLabel = statusToggle.nextElementSibling;
        
        statusToggle.addEventListener('change', function() {
            statusInput.value = this.checked ? '1' : '0';
            statusLabel.textContent = this.checked ? 'Active' : 'Inactive';
        });
        
        // Form validation
        function validateForm() {
            const price = document.getElementById('price').value.replace(/\D/g, '');
            const durationDays = document.getElementById('durationDays').value;
            const jobPostLimit = document.getElementById('jobPostLimit').value;
            
            if (!price || parseInt(price) < 1000) {
                alert('Price must be at least 1,000 VND');
                return false;
            }
            
            if (parseInt(durationDays) < 1) {
                alert('Duration must be at least 1 day');
                return false;
            }
            
            if (parseInt(jobPostLimit) < 0) {
                alert('Job post limit cannot be negative');
                return false;
            }
            
            return true;
        }
    </script>
</body>
</html>
