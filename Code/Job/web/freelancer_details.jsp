<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html class="no-js" lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Freelancer Details</title>
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
            --text-color: #2d3436;
            --white: #ffffff;
        }
        body { font-family: 'Poppins', sans-serif; background: #f5f7fa; color: var(--text-color); }
        .profile-header { background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%); color: white; padding: 30px 0; margin-bottom: 30px; border-radius: 0 0 10px 10px; box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); }
        .profile-avatar { width: 150px; height: 150px; border-radius: 50%; border: 5px solid white; object-fit: cover; box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1); }
        .profile-name { font-size: 2rem; font-weight: 700; margin: 15px 0 5px; }
        .profile-username { font-size: 1.1rem; opacity: 0.9; margin-bottom: 15px; }
        .card { border: none; border-radius: 10px; box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05); margin-bottom: 30px; }
        .card-header { background-color: white; border-bottom: 1px solid rgba(0, 0, 0, 0.05); font-weight: 600; font-size: 1.1rem; padding: 15px 20px; border-radius: 10px 10px 0 0 !important; }
        .card-body { padding: 20px; }
        .info-item { margin-bottom: 15px; padding-bottom: 15px; border-bottom: 1px dashed #eee; }
        .info-item:last-child { border-bottom: none; }
        .info-label { font-weight: 600; color: #6c757d; margin-bottom: 5px; font-size: 0.9rem; }
        .info-value { font-size: 1rem; color: var(--text-color); word-break: break-word; }
        .info-value.empty { color: #adb5bd; font-style: italic; }
        .btn-back { background-color: #f8f9fa; color: var(--text-color); border: 1px solid #dee2e6; padding: 8px 20px; border-radius: 5px; text-decoration: none; display: inline-flex; align-items: center; }
        .btn-back i { margin-right: 8px; }
        .badge { padding: 5px 12px; border-radius: 15px; font-size: 12px; font-weight: 500; text-transform: capitalize; display: inline-block; }
        .badge-success { background-color: #28a745; color: white; }
        .badge-danger { background-color: #dc3545; color: white; }
        .about-section { line-height: 1.7; color: #495057; white-space: pre-wrap; }
        .empty-state { color: #adb5bd; font-style: italic; padding: 20px 0; text-align: center; }
        .skill-container { margin-bottom: 1.5rem; }
        .skill-header { display: flex; justify-content: space-between; margin-bottom: 0.5rem; }
        .skill-name { font-weight: 600; }
        .skill-level { color: #636e72; font-size: 0.9em; }
        .progress-container { background-color: #f1f2f6; border-radius: 10px; height: 10px; overflow: hidden; }
        .progress-bar { height: 100%; border-radius: 10px; background: linear-gradient(90deg, #6c5ce7, #a29bfe); }
    </style>
</head>
<body>
    <div class="main-content">
        <c:if test="${not empty jobseeker}">
            <div class="profile-header text-center">
                <div class="container">
                    <img src="${not empty jobseeker.image ? jobseeker.image : 'images/default-avatar.png'}" alt="Profile Image" class="profile-avatar">
                    <h1 class="profile-name">${jobseeker.first_Name} ${jobseeker.last_Name}</h1>
                    <div class="profile-username">@${jobseeker.freelancerID}</div>
                    <span class="badge ${jobseeker.status.equalsIgnoreCase('active') ? 'badge-success' : 'badge-danger'}">
                        ${jobseeker.status}
                    </span>
                </div>
            </div>

            <div class="container">
                <div class="d-flex justify-content-start mb-4">
                    <a href="freelancer_list" class="btn-back">
                        <i class="fa fa-arrow-left"></i> Back to Freelancers
                    </a>
                </div>
                <div class="row">
                    <div class="col-lg-8">
                        <!-- Personal Information Card -->
                        <div class="card mb-4">
                            <div class="card-header"><i class="fa fa-user-circle mr-2"></i> Personal Information</div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="info-item">
                                            <div class="info-label">First Name</div>
                                            <div class="info-value">${jobseeker.first_Name}</div>
                                        </div>
                                        <div class="info-item">
                                            <div class="info-label">Last Name</div>
                                            <div class="info-value">${jobseeker.last_Name}</div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="info-item">
                                            <div class="info-label">Date of Birth</div>
                                            <div class="info-value"><fmt:formatDate value="${jobseeker.dob}" pattern="dd/MM/yyyy" /></div>
                                        </div>
                                        <div class="info-item">
                                            <div class="info-label">Gender</div>
                                            <div class="info-value">${jobseeker.gender ? "Male" : "Female"}</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Contact Information Card -->
                        <div class="card mb-4">
                            <div class="card-header"><i class="fa fa-address-card mr-2"></i> Contact Information</div>
                            <div class="card-body">
                                <div class="info-item">
                                    <div class="info-label">Email</div>
                                    <div class="info-value"><a href="mailto:${jobseeker.email_contact}">${jobseeker.email_contact}</a></div>
                                </div>
                                <div class="info-item">
                                    <div class="info-label">Phone Number</div>
                                    <div class="info-value"><a href="tel:${jobseeker.phone_contact}">${jobseeker.phone_contact}</a></div>
                                </div>
                            </div>
                        </div>

                        <!-- About Section -->
                        <div class="card mb-4">
                            <div class="card-header"><i class="fa fa-info-circle mr-2"></i> About</div>
                            <div class="card-body">
                                <c:choose>
                                    <c:when test="${not empty jobseeker.describe}"><div class="about-section">${jobseeker.describe}</div></c:when>
                                    <c:otherwise><div class="empty-state">No description provided.</div></c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>

                    <!-- Right Column -->
                    <div class="col-lg-4">
                        <!-- Skills Card -->
                        <div class="card mb-4">
                            <div class="card-header"><i class="fa fa-code mr-2"></i> Skills</div>
                            <div class="card-body">
                                <c:choose>
                                    <c:when test="${not empty skills}">
                                        <c:forEach var="skill" items="${skills}">
                                            <div class="skill-container">
                                                <div class="skill-header">
                                                    <span class="skill-name">${skill.skillSetName}</span>
                                                    <span class="skill-level">
                                                        <c:choose>
                                                            <c:when test="${skill.level == 5}">Expert</c:when>
                                                            <c:when test="${skill.level == 4}">Advanced</c:when>
                                                            <c:when test="${skill.level == 3}">Intermediate</c:when>
                                                            <c:when test="${skill.level == 2}">Basic</c:when>
                                                            <c:otherwise>Beginner</c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </div>
                                                <div class="progress-container">
                                                    <div class="progress-bar" style="width: ${skill.level * 20}%"></div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise><div class="empty-state">No skills listed.</div></c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
        <c:if test="${empty jobseeker}">
             <div class="container text-center mt-5">
                 <h2 class="text-danger">Error: Freelancer Not Found</h2>
                 <p>The freelancer you are looking for does not exist or could not be loaded.</p>
                 <a href="freelancer_list" class="btn btn-primary">Back to List</a>
             </div>
        </c:if>
    </div>

    <!-- JavaScript Libraries -->
    <script src="js/vendor/jquery-3.5.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>