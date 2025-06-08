<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="Model.Jobseeker" %>
<%@ page import="Model.Education" %>
<%@ page import="Model.Experience" %>
<%@ page import="Model.Skill" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.ArrayList" %>

<% 
    Jobseeker jobseeker = (Jobseeker) request.getAttribute("jobseeker");
    if (jobseeker == null) {
        response.sendRedirect("admin_jobseeker.jsp");
        return;
    }
    
    // Format date of birth
    String formattedDob = "";
    if (jobseeker.getDob() != null) {
        try {
            SimpleDateFormat outputFormat = new SimpleDateFormat("dd/MM/yyyy");
            formattedDob = outputFormat.format(jobseeker.getDob());
        } catch (Exception e) {
            formattedDob = "Not provided";
        }
    }
%>

<!DOCTYPE html>
<html class="no-js" lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Jobseeker Details - Admin Panel</title>
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

        .about-section {
            line-height: 1.7;
            color: #495057;
        }

        .about-section p:last-child {
            margin-bottom: 0;
        }

        .empty-state {
            color: #adb5bd;
            font-style: italic;
            padding: 20px 0;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="main-content">
        <div class="profile-header text-center">
            <div class="container">
                
                <div class="text-center">
                    <img src="<%= jobseeker.getImage() != null && !jobseeker.getImage().isEmpty() ? jobseeker.getImage() : "images/default-avatar.png" %>" 
                         alt="Profile Image" class="profile-avatar">
                    <h1 class="profile-name"><%= jobseeker.getFirst_Name() != null ? jobseeker.getFirst_Name() : "" %> <%= jobseeker.getLast_Name() != null ? jobseeker.getLast_Name() : "" %></h1>
                    <div class="profile-username">@<%= jobseeker.getFreelancerID() %></div>
                    <span class="badge <%= "active".equalsIgnoreCase(jobseeker.getStatus()) ? "badge-success" : 
                                               ("suspended".equalsIgnoreCase(jobseeker.getStatus()) ? "badge-danger" : "badge-warning") %>">
                        <%= jobseeker.getStatus() != null ? jobseeker.getStatus().toUpperCase() : "UNKNOWN" %>
                    </span>
                </div>
            </div>
        </div>

        <div class="container">
            <div class="d-flex justify-content-start mb-4">
                    <a href="admin_jobseeker.jsp" class="btn-back">
                        <i class="fa fa-arrow-left"></i> Back to Jobseekers
                    </a>
                </div>
            <div class="row">
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
                                        <div class="info-value"><%= jobseeker.getFirst_Name() != null ? jobseeker.getFirst_Name() : "<span class='empty'>Not provided</span>" %></div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-label">Last Name</div>
                                        <div class="info-value"><%= jobseeker.getLast_Name() != null ? jobseeker.getLast_Name() : "<span class='empty'>Not provided</span>" %></div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-label">User ID</div>
                                        <div class="info-value"><%= jobseeker.getFreelancerID() %></div>
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
                                            <%= jobseeker.isGender() ? "Male" : "Female" %>
                                        </div>
                                    </div>
                                    <div class="info-item">
                                        <div class="info-label">Account Status</div>
                                        <div class="info-value">
                                            <span class="status-toggle <%= "active".equalsIgnoreCase(jobseeker.getStatus()) ? "status-active" : "status-inactive" %>" 
                                                  onclick="toggleStatus(<%= jobseeker.getFreelancerID() %>, '<%= jobseeker.getStatus() %>')">
                                                <%= jobseeker.getStatus() != null ? jobseeker.getStatus().toUpperCase() : "UNKNOWN" %>
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
                                            <%= jobseeker.getEmail_contact() != null && !jobseeker.getEmail_contact().isEmpty() ? 
                                                "<a href='mailto:" + jobseeker.getEmail_contact() + "'>" + jobseeker.getEmail_contact() + "</a>" : 
                                                "<span class='empty'>Not provided</span>" %>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="info-item">
                                        <div class="info-label">Phone Number</div>
                                        <div class="info-value">
                                            <%= jobseeker.getPhone_contact() != null && !jobseeker.getPhone_contact().isEmpty() ? 
                                                "<a href='tel:" + jobseeker.getPhone_contact() + "'>" + jobseeker.getPhone_contact() + "</a>" : 
                                                "<span class='empty'>Not provided</span>" %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- About Section -->
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fa fa-info-circle mr-2"></i> About
                        </div>
                        <div class="card-body">
                            <% if (jobseeker.getDescribe() != null && !jobseeker.getDescribe().trim().isEmpty()) { %>
                                <div class="about-section">
                                    <%= jobseeker.getDescribe().replace("\n", "<br>") %>
                                </div>
                            <% } else { %>
                                <div class="empty-state">No description provided</div>
                            <% } %>
                        </div>
                    </div>
                    
                    <!-- Education Section -->
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fa fa-graduation-cap mr-2"></i> Education
                        </div>
                        <div class="card-body">
                            <c:choose>
                                <c:when test="${not empty educations}">
                                    <c:forEach var="education" items="${educations}">
                                        <div class="education-item mb-4 pb-3 border-bottom">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <h5 class="mb-1">${education.universityName}</h5>
                                                <span class="badge badge-info">${education.degreeName}</span>
                                            </div>
                                            <p class="text-muted mb-1">
                                                <c:choose>
                                                    <c:when test="${education.startDate != null}">
                                                        <fmt:formatDate value="${education.startDate}" pattern="MM/yyyy" />
                                                    </c:when>
                                                    <c:otherwise>N/A</c:otherwise>
                                                </c:choose>
                                                - 
                                                <c:choose>
                                                    <c:when test="${education.endDate != null}">
                                                        <fmt:formatDate value="${education.endDate}" pattern="MM/yyyy" />
                                                    </c:when>
                                                    <c:otherwise>Present</c:otherwise>
                                                </c:choose>
                                            </p>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="empty-state">No education information available</div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    
                    <!-- Experience Section -->
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fa fa-briefcase mr-2"></i> Work Experience
                        </div>
                        <div class="card-body">
                            <c:choose>
                                <c:when test="${not empty experiences}">
                                    <c:forEach var="experience" items="${experiences}">
                                        <div class="experience-item mb-4 pb-3 border-bottom">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <h5 class="mb-1">${experience.experienceWorkName}</h5>
                                                <span class="badge badge-secondary">${experience.position}</span>
                                            </div>
                                            <p class="text-muted mb-1">
                                                <c:choose>
                                                    <c:when test="${experience.startDate != null}">
                                                        <fmt:formatDate value="${experience.startDate}" pattern="MM/yyyy" />
                                                    </c:when>
                                                    <c:otherwise>N/A</c:otherwise>
                                                </c:choose>
                                                - 
                                                <c:choose>
                                                    <c:when test="${experience.endDate != null}">
                                                        <fmt:formatDate value="${experience.endDate}" pattern="MM/yyyy" />
                                                    </c:when>
                                                    <c:otherwise>Present</c:otherwise>
                                                </c:choose>
                                            </p>
                                            <c:if test="${not empty experience.yourProject}">
                                                <div class="project-details mt-2">
                                                    <p class="mb-0"><strong>Project: </strong>${experience.yourProject}</p>
                                                </div>
                                            </c:if>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="empty-state">No work experience information available</div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <!-- Right Column -->
                <div class="col-lg-4">
                    <!-- Skills Card -->
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fa fa-code mr-2"></i> Skills
                        </div>
                        <div class="card-body">
                            <style>
                                .skill-container {
                                    margin-bottom: 1.5rem;
                                }
                                .skill-header {
                                    display: flex;
                                    justify-content: space-between;
                                    margin-bottom: 0.5rem;
                                }
                                .skill-name {
                                    font-weight: 600;
                                    color: #2d3436;
                                }
                                .skill-level {
                                    color: #636e72;
                                    font-size: 0.9em;
                                }
                                .progress-container {
                                    background-color: #f1f2f6;
                                    border-radius: 10px;
                                    height: 10px;
                                    margin-bottom: 1rem;
                                    overflow: hidden;
                                }
                                .progress-bar {
                                    height: 100%;
                                    border-radius: 10px;
                                    background: linear-gradient(90deg, #6c5ce7, #a29bfe);
                                    transition: width 0.5s ease-in-out;
                                    position: relative;
                                }
                                .progress-bar::after {
                                    content: '';
                                    position: absolute;
                                    top: 0;
                                    left: 0;
                                    right: 0;
                                    bottom: 0;
                                    background: linear-gradient(
                                        to right,
                                        rgba(255, 255, 255, 0.2) 0%,
                                        rgba(255, 255, 255, 0.5) 50%,
                                        rgba(255, 255, 255, 0.2) 100%
                                    );
                                    background-size: 200% 100%;
                                    animation: shimmer 2s infinite linear;
                                }
                                @keyframes shimmer {
                                    0% { background-position: 200% 0; }
                                    100% { background-position: -200% 0; }
                                }
                            </style>
                            
                            <c:choose>
                                <c:when test="${not empty skills}">
                                    <div class="skill-categories">
                                        <c:forEach var="skill" items="${skills}">
                                            <div class="skill-container">
                                                <div class="skill-header">
                                                    <span class="skill-name">${skill.skillSetName}</span>
                                                    <span class="skill-level">
                                                        <c:choose>
                                                            <c:when test="${skill.level == 1}">Beginner</c:when>
                                                            <c:when test="${skill.level == 2}">Basic</c:when>
                                                            <c:when test="${skill.level == 3}">Intermediate</c:when>
                                                            <c:when test="${skill.level == 4}">Advanced</c:when>
                                                            <c:when test="${skill.level == 5}">Expert</c:when>
                                                            <c:otherwise>${skill.level}/5</c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </div>
                                                <div class="progress-container">
                                                    <div class="progress-bar" 
                                                         style="width: ${skill.level * 20}%">
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-center py-4">
                                        <i class="fa fa-code fa-3x text-muted mb-3"></i>
                                        <p class="text-muted">No skills added yet</p>
                                    </div>
                                    <div class="empty-state">No skills information available</div>
                                </c:otherwise>
                            </c:choose>
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
                                <button type="button" class="btn btn-delete btn-block" onclick="confirmDelete(<%= jobseeker.getFreelancerID() %>)">
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
                                <div class="info-value">#<%= jobseeker.getFreelancerID() %></div>
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
                    Are you sure you want to delete this jobseeker? This action cannot be undone.
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
                alert('Status update request sent for jobseeker ID: ' + id);
                // You can implement the actual status update logic here
            }
        }

        // Delete confirmation
        let jobseekerToDelete = null;
        
        function confirmDelete(id) {
            jobseekerToDelete = id;
            $('#deleteModal').modal('show');
        }
        
        document.getElementById('confirmDeleteBtn').addEventListener('click', function() {
            if (jobseekerToDelete) {
                // Here you would typically make an AJAX call to delete the jobseeker
                // For now, we'll just show an alert and redirect
                alert('Delete request sent for jobseeker ID: ' + jobseekerToDelete);
                window.location.href = 'AdminController?action=deleteJobseeker&id=' + jobseekerToDelete;
            }
        });
        
        // Initialize tooltips
        $(function () {
            $('[data-toggle="tooltip"]').tooltip();
        });
    </script>
</body>
</html>
