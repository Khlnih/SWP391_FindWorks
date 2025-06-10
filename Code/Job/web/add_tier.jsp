<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Tier - Admin</title>
    
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
            position: relative;
            overflow: hidden;
        }
        
        .form-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #3b82f6, #8b5cf6);
        }
        
        .form-title {
            color: var(--primary-color);
            font-weight: 700;
            font-size: 1.75rem;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            position: relative;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        
        .form-title i {
            background: var(--primary-light);
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-color);
            font-size: 1.25rem;
        }
        
        .required:after {
            content: " *";
            color: var(--danger-color);
            font-weight: 600;
        }
        
        .btn-custom {
            min-width: 130px;
            padding: 0.75rem 1.75rem;
            font-weight: 600;
            border-radius: 10px;
            transition: var(--transition);
            font-size: 0.9375rem;
            letter-spacing: 0.3px;
            box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            position: relative;
            overflow: hidden;
        }
        
        .btn-primary:hover {
            background-color: var(--primary-hover);
            border-color: var(--primary-hover);
            transform: translateY(-2px);
            box-shadow: 0 4px 6px -1px rgba(59, 130, 246, 0.3), 0 2px 4px -1px rgba(59, 130, 246, 0.2);
        }
        
        .btn-outline-secondary {
            color: var(--secondary-color);
            border-color: var(--border-color);
            background: white;
        }
        
        .btn-outline-secondary:hover {
            background-color: #f8fafc;
            border-color: #cbd5e1;
            color: var(--text-primary);
            transform: translateY(-2px);
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -1px rgba(0, 0, 0, 0.05);
        }
        
        .form-label {
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
            font-size: 0.9375rem;
        }
        
        .form-control, .form-select {
            padding: 0.8125rem 1.25rem;
            border-radius: 10px;
            border: 1px solid var(--border-color);
            font-size: 0.9375rem;
            transition: var(--transition);
            background-color: #fff;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.15);
            background-color: #fff;
        }
        
        .form-control::placeholder {
            color: #94a3b8;
            opacity: 0.8;
        }
        
        .input-group-text {
            background-color: #f8fafc;
            border: 1px solid var(--border-color);
            color: var(--text-secondary);
            font-weight: 500;
            padding: 0 1.25rem;
        }
        
        .invalid-feedback {
            font-size: 0.8125rem;
            margin-top: 0.5rem;
            font-weight: 500;
            padding-left: 0.5rem;
        }
        
        .page-header {
            background: linear-gradient(135deg, #fff 0%, #f8fafc 100%);
            padding: 2rem 2.5rem;
            border-radius: 16px;
            margin-bottom: 2.5rem;
            box-shadow: var(--card-shadow);
            border: 1px solid rgba(0, 0, 0, 0.04);
            position: relative;
            overflow: hidden;
        }
        
        .page-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            bottom: 0;
            width: 4px;
            background: linear-gradient(to bottom, #3b82f6, #8b5cf6);
        }
        
        .page-header h2 {
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        
        .page-header h2 i {
            background: var(--primary-light);
            width: 42px;
            height: 42px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-color);
            font-size: 1.1rem;
        }
        
        .page-header p {
            color: var(--text-secondary);
            margin-bottom: 0;
            font-size: 0.9375rem;
        }
        
        .form-section {
            background: #f8fafc;
            border-radius: 12px;
            padding: 1.75rem;
            margin-bottom: 2rem;
            border: 1px solid rgba(0, 0, 0, 0.03);
        }
        
        .form-section-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 1.5rem;
            padding-bottom: 0.75rem;
            border-bottom: 1px dashed #e2e8f0;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        
        .form-section-title i {
            color: var(--primary-color);
            font-size: 1.25rem;
        }
    </style>
</head>
<body>
    <div class="container py-6">
        <div class="page-header">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h2 class="mb-2">
                        <i class="fas fa-crown text-primary me-3"></i>Subscription Tier
                    </h2>
                    <div class="d-flex align-items-center gap-4">
                        <div class="d-flex align-items-center">
                            <i class="fas fa-circle-info text-primary me-2"></i>
                            <span class="text-muted">Create a new subscription tier</span>
                        </div>
                        <div class="d-flex align-items-center">
                            <i class="fas fa-clock text-primary me-2"></i>
                            <span class="text-muted">Last updated: <fmt:formatDate value="${lastUpdated}" pattern="dd/MM/yyyy HH:mm" /></span>
                        </div>
                    </div>
                </div>
                <div class="d-flex gap-3">
                    <a href="admin?action=accounttier" class="btn btn-outline-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Back to List
                    </a>
                    <button type="button" class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#helpModal">
                        <i class="fas fa-question-circle me-2"></i>Help
                    </button>
                </div>
            </div>
        </div>
        
        <!-- Help Modal -->
        <div class="modal fade" id="helpModal" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Tier Creation Help</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row g-4">
                            <div class="col-md-6">
                                <h6 class="mb-3">Basic Information</h6>
                                <ul class="list-unstyled">
                                    <li><i class="fas fa-check text-success me-2"></i>Enter a unique tier name</li>
                                    <li><i class="fas fa-check text-success me-2"></i>Select tier status (Active/Inactive)</li>
                                    <li><i class="fas fa-check text-success me-2"></i>Add detailed description</li>
                                </ul>
                            </div>
                            <div class="col-md-6">
                                <h6 class="mb-3">Pricing & Limits</h6>
                                <ul class="list-unstyled">
                                    <li><i class="fas fa-check text-success me-2"></i>Set price in VND</li>
                                    <li><i class="fas fa-check text-success me-2"></i>Configure duration in days</li>
                                    <li><i class="fas fa-check text-success me-2"></i>Set job post limit</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="form-container">
            <div class="form-section">
                <div class="form-section-title">
                    <i class="fas fa-info-circle"></i>
                    <span>Basic Information</span>
                </div>
                
                <form action="admin" method="POST" id="tierForm" class="needs-validation" novalidate>
                <input type="hidden" name="action" value="addTier">
                <input type="hidden" name="status" id="statusValue" value="1">
                
                <div class="row g-4 mb-4">
                    <!-- Tier Name -->
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="tierName" class="form-label required">Tier Name</label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-tag"></i>
                                </span>
                                <input type="text" class="form-control" id="tierName" name="tierName" required 
                                       placeholder="E.g., Basic, Professional, Enterprise">
                            </div>
                            <div class="form-text text-muted small">
                                Enter a unique name for this tier
                            </div>
                            <div class="invalid-feedback">Please enter a tier name.</div>
                        </div>
                    </div>
                    
                    <!-- Status -->
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label required">Status</label>
                            <div class="form-check form-switch">
                                <input class="form-check-input" type="checkbox" role="switch" id="statusSwitch" checked>
                                <label class="form-check-label" for="statusSwitch" id="statusLabel">Active</label>
                            </div>
                            <div class="form-text text-muted small">
                                Toggle to activate/deactivate this tier
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Description -->
                <div class="mb-4">
                    <div class="form-group">
                        <label for="description" class="form-label">Description</label>
                        <textarea class="form-control" id="description" name="description" rows="3"
                                placeholder="Enter detailed description about this tier"></textarea>
                        <div class="form-text text-muted small">
                            Add a detailed description of the tier features and benefits
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
                                    <i class="fas fa-money-bill-wave"></i>
                                </span>
                                <input type="number" class="form-control text-end" id="price" name="price" 
                                       required min="1000" step="1000" value="1000">
                                <span class="input-group-text">₫</span>
                            </div>
                            <div class="form-text text-muted small">
                                Minimum 1,000 VND, increments of 1,000
                            </div>
                            <div class="invalid-feedback">Please enter a valid price (minimum 1,000 VND).</div>
                        </div>
                    </div>
                    
                    <!-- Duration -->
                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="durationDays" class="form-label required">Duration (Days)</label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-calendar-alt"></i>
                                </span>
                                <input type="number" class="form-control" id="durationDays" name="durationDays" 
                                       min="1" required value="30">
                                <span class="input-group-text">Days</span>
                            </div>
                            <div class="form-text text-muted small">
                                Number of days this tier is valid
                            </div>
                            <div class="invalid-feedback">Duration must be greater than 0.</div>
                        </div>
                    </div>
                    
                    <!-- Job Post Limit -->
                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="jobPostLimit" class="form-label required">Job Post Limit</label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-bullhorn"></i>
                                </span>
                                <input type="number" class="form-control" id="jobPostLimit" name="jobPostLimit" 
                                       min="1" required value="10">
                                <span class="input-group-text">Posts</span>
                            </div>
                            <div class="form-text text-muted small">
                                Maximum number of job posts allowed
                            </div>
                            <div class="invalid-feedback">Job post limit must be greater than 0.</div>
                        </div>
                    </div>
                    
                    <!-- User Type Scope -->
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="userTypeScope" class="form-label required">User Type</label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-users"></i>
                                </span>
                                <select class="form-select" id="typeScope" name="typeScope" required>
                                    <option value="Recruiter" selected>Recruiter</option>
                                    <option value="Jobseeker">Jobseeker</option>
                                </select>
                            </div>
                            <div class="form-text text-muted small">
                                Select the user type for this tier
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="d-flex justify-content-end gap-4 pt-4">
                    <a href="admin?action=accounttier" class="btn btn-outline-secondary btn-custom">
                        <i class="fas fa-times me-2"></i>Cancel
                    </a>
                    <button type="submit" class="btn btn-primary btn-custom">
                        <i class="fas fa-save me-2"></i>Save Tier
                    </button>
                </div>
            </form>
        </div>
    </div>
    
    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Form validation
        (function () {
            'use strict'
            
            // Fetch the form we want to apply custom Bootstrap validation styles to
            var form = document.getElementById('tierForm')
            
            form.addEventListener('submit', function (event) {
                if (!form.checkValidity()) {
                    event.preventDefault()
                    event.stopPropagation()
                }
                
                form.classList.add('was-validated')
                
                // Scroll to first invalid field
                if (!form.checkValidity()) {
                    const firstInvalid = form.querySelector(':invalid')
                    if (firstInvalid) {
                        firstInvalid.scrollIntoView({
                            behavior: 'smooth',
                            block: 'center'
                        })
                        firstInvalid.focus()
                    }
                }
            }, false)
            
            // Format price input
            const priceInput = document.getElementById('price')
            if (priceInput) {
                priceInput.addEventListener('input', function(e) {
                    // Remove non-numeric characters
                    let value = this.value.replace(/\D/g, '')
                    // Format with thousand separators
                    this.value = new Intl.NumberFormat('vi-VN').format(value)
                })
            }
        })()
    </script>
            </form>
        </div>
    </div>
    
    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Form validation
        (function () {
            'use strict'
            
            // Fetch the form we want to apply custom Bootstrap validation styles to
            var form = document.getElementById('tierForm')
            
            form.addEventListener('submit', function (event) {
                if (!form.checkValidity()) {
                    event.preventDefault()
                    event.stopPropagation()
                }
                
                form.classList.add('was-validated')
                
                // Scroll to first invalid field
                if (!form.checkValidity()) {
                    const firstInvalid = form.querySelector(':invalid')
                    if (firstInvalid) {
                        firstInvalid.scrollIntoView({
                            behavior: 'smooth',
                            block: 'center'
                        })
                        firstInvalid.focus()
                    }
                }
            }, false)
            
            // Format price input
            const priceInput = document.getElementById('price')
            if (priceInput) {
                priceInput.addEventListener('input', function(e) {
                    // Remove non-numeric characters
                    let value = this.value.replace(/\D/g, '')
                    // Format with thousand separators
                    this.value = new Intl.NumberFormat('vi-VN').format(value)
                })
            }
        })()
    </script>
</body>
</html>
