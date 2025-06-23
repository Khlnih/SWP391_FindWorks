<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.Jobseeker, Model.Education, Model.Experience, Model.FreelancerLocation"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="Model.Skill"%>
<%@page import="Model.SkillSet"%>
<%@page import="java.util.List"%>
<%@page errorPage="error.jsp"%>
<%-- Initialize variables at the top of the JSP --%>
<%
    Jobseeker jobseeker = (Jobseeker) session.getAttribute("jobseeker");
    if (jobseeker == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    ArrayList<Education> educationList = (ArrayList<Education>) session.getAttribute("education");
    ArrayList<Experience> experienceList = (ArrayList<Experience>) session.getAttribute("experience");
    FreelancerLocation location = (FreelancerLocation) session.getAttribute("location");
    // Get skills from session (set in LoginServlet with key "listSkill")
    List<Skill> skills = (List<Skill>) session.getAttribute("listSkill");
    List<SkillSet> skillSets = (List<SkillSet>) session.getAttribute("skillSet");
    if (skills == null) {
        skills = new ArrayList<>(); // Initialize empty list if no skills found
    }
    if (skillSets == null) {
        skillSets = new ArrayList<>(); // Initialize empty list if no skill sets found
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= jobseeker.getFirst_Name() + " " + jobseeker.getLast_Name() %> - Profile | FindWorks</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        /* Custom Variables */
        :root {
            --primary: #4e73df;
            --primary-dark: #2e59d9;
            --secondary: #f8f9fc;
            --success: #1cc88a;
            --info: #36b9cc;
            --warning: #f6c23e;
            --danger: #e74a3b;
            --light: #f8f9fc;
            --dark: #5a5c69;
            --gray-100: #f8f9fc;
            --gray-200: #eaecf4;
            --gray-600: #858796;
            --gray-800: #5a5c69;
            --font-sans: 'Nunito', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            --box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
            --transition: all 0.3s ease;
        }

        /* Base Styles */
        body {
            font-family: var(--font-sans);
            color: var(--dark);
            background-color: var(--gray-100);
            line-height: 1.6;
        }

        /* Navigation */
        .navbar {
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
            background: white;
            padding: 0.8rem 0;
        }

        .navbar-brand {
            font-weight: 800;
            font-size: 1.5rem;
            color: var(--primary) !important;
        }

        .nav-link {
            font-weight: 600;
            padding: 0.5rem 1rem !important;
            color: var(--gray-800) !important;
            transition: var(--transition);
        }

        .nav-link:hover, .nav-link.active {
            color: var(--primary) !important;
        }

        /* Profile Header */
        .profile-header {
            background: linear-gradient(135deg, var(--primary) 0%, #224abe 100%);
            color: white;
            padding: 6rem 0 4rem;
            margin-bottom: 2rem;
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
            background: url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiPjxkZWZzPjxwYXR0ZXJuIGlkPSJwYXR0ZXJuIiB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHBhdHRlcm5Vbml0cz0idXNlclNwYWNlT25Vc2UiIHBhdHRlcm5UcmFuc2Zvcm09InJvdGF0ZSg0NSkiPjxyZWN0IHdpZHRoPSIyMCIgaGVpZ2h0PSIyMCIgZmlsbD0icmdiYSgyNTUsMjU1LDI1NSwwLjA1KSIvPjwvcGF0dGVybj48L2RlZnM+PHJlY3Qgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgZmlsbD0idXJsKCNwYXR0ZXJuKSIvPjwvc3ZnPg==') repeat;
            opacity: 0.3;
        }

        .profile-avatar {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            border: 5px solid rgba(255, 255, 255, 0.2);
            object-fit: cover;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease;
            background-color: #fff;
        }

        .profile-avatar:hover {
            transform: translateY(-5px);
            box-shadow: 0 0.8rem 1.5rem rgba(0, 0, 0, 0.3);
        }


        .profile-name {
            font-size: 2.5rem;
            font-weight: 700;
            margin: 1rem 0 0.5rem;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .profile-title {
            font-size: 1.25rem;
            font-weight: 400;
            opacity: 0.9;
            margin-bottom: 1.5rem;
        }

        .profile-social {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 1rem;
        }

        .profile-social a {
            color: white;
            background: rgba(255, 255, 255, 0.2);
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
            text-decoration: none;
        }

        .profile-social a:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
        }

        /* Main Content */
        .main-content {
            padding: 2rem 0;
        }

        .card {
            border: none;
            border-radius: 0.5rem;
            box-shadow: var(--box-shadow);
            margin-bottom: 1.5rem;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border: 1px solid rgba(0, 0, 0, 0.05);
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 0.5rem 2rem rgba(58, 59, 69, 0.2) !important;
        }

        .card-header {
            background-color: white;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            padding: 1.25rem 1.5rem;
            font-weight: 700;
            font-size: 1.1rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .card-header i {
            color: var(--primary);
            margin-right: 0.5rem;
        }

        .card-body {
            padding: 1.5rem;
        }

        .section-title {
            font-size: 1.25rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            color: var(--dark);
            position: relative;
            padding-bottom: 0.75rem;
        }

        .section-title::after {
            content: '';
            position: absolute;
            left: 0;
            bottom: 0;
            width: 50px;
            height: 3px;
            background: var(--primary);
            border-radius: 3px;
        }

        /* Info Item */
        .info-item {
            margin-bottom: 1.5rem;
            padding-bottom: 1.5rem;
            border-bottom: 1px solid var(--gray-200);
        }

        .info-item:last-child {
            margin-bottom: 0;
            padding-bottom: 0;
            border-bottom: none;
        }

        .info-title {
            font-weight: 600;
            color: var(--dark);
            margin-bottom: 0.25rem;
        }

        .info-subtitle {
            color: var(--gray-600);
            font-size: 0.9rem;
            margin-bottom: 0.25rem;
        }

        .info-date {
            font-size: 0.85rem;
            color: var(--gray-600);
            margin-bottom: 0.5rem;
        }

        .info-description {
            color: var(--gray-800);
            margin-top: 0.5rem;
            font-size: 0.95rem;
            line-height: 1.6;
        }

        /* Skills */
        .skill-tag {
            display: inline-block;
            background-color: var(--light);
            color: var(--dark);
            padding: 0.35rem 0.8rem;
            border-radius: 50px;
            font-size: 0.85rem;
            margin: 0.25rem;
            border: 1px solid var(--gray-200);
            transition: all 0.2s ease;
        }

        .skill-tag:hover {
            background-color: var(--primary);
            color: white;
            transform: translateY(-1px);
        }

        /* Timeline Styles */
        .timeline {
            position: relative;
            padding-left: 1.5rem;
        }

        .timeline::before {
            content: '';
            position: absolute;
            top: 0;
            bottom: 0;
            left: 0.5rem;
            width: 2px;
            background-color: #e9ecef;
        }

        .timeline-item {
            position: relative;
            padding-bottom: 1.5rem;
            padding-left: 1.5rem;
        }

        .timeline-item:last-child {
            padding-bottom: 0;
        }

        .timeline-marker {
            position: absolute;
            left: -0.5rem;
            top: 0.5rem;
            width: 1.25rem;
            height: 1.25rem;
            border-radius: 50%;
            background-color: var(--primary);
            border: 3px solid #fff;
            z-index: 1;
            box-shadow: 0 0 0 2px var(--primary);
        }

        .timeline-marker.bg-success {
            background-color: #198754;
            box-shadow: 0 0 0 2px #198754;
        }

        .timeline-content {
            position: relative;
            padding: 1rem;
            background-color: #fff;
            border-radius: 0.5rem;
            box-shadow: 0 0.125rem 0.5rem rgba(0, 0, 0, 0.05);
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .timeline-content:hover {
            transform: translateY(-2px);
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1);
        }

        /* Card hover effects */
        .card {
            transition: transform 0.2s, box-shadow 0.2s;
            border: 1px solid rgba(0, 0, 0, 0.05);
        }

        .card:hover {
            transform: translateY(-2px);
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1) !important;
        }

        /* Profile header */
        .profile-avatar {
            width: 150px;
            height: 150px;
            object-fit: cover;
            border: 4px solid #fff;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1);
        }

        /* Skill badges */
        .badge.skill-badge {
            font-weight: 500;
            padding: 0.4em 0.8em;
            font-size: 0.85rem;
            margin-bottom: 0.5rem;
            margin-right: 0.5rem;
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
        }

        /* Social links */
        .social-links .btn {
            width: 36px;
            height: 36px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            margin: 0 0.25rem;
            transition: all 0.2s;
        }

        .social-links .btn:hover {
            transform: translateY(-2px);
        }

        /* Timeline Styles */
        .timeline {
            position: relative;
            padding-left: 1.5rem;
        }

        .timeline::before {
            content: '';
            position: absolute;
            top: 0;
            bottom: 0;
            left: 0.5rem;
            width: 2px;
            background-color: var(--gray-200);
        }

        .timeline-item {
            position: relative;
            padding-bottom: 1.5rem;
            padding-left: 1.5rem;
        }

        .timeline-item:last-child {
            padding-bottom: 0;
        }

        .timeline-marker {
            position: absolute;
            left: -0.5rem;
            top: 0.25rem;
            width: 1rem;
            height: 1rem;
            border-radius: 50%;
            background-color: var(--primary);
            border: 3px solid white;
            z-index: 1;
        }

        .timeline-content {
            position: relative;
            padding: 1rem;
            background-color: white;
            border-radius: 0.5rem;
            box-shadow: 0 0.125rem 0.5rem rgba(0, 0, 0, 0.05);
        }

        /* Icon Circle */
        .icon-circle {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 2.5rem;
            height: 2.5rem;
            flex-shrink: 0;
        }

        /* Card Header Icons */
        .card-header i {
            color: var(--primary);
            font-size: 1.1rem;
        }

        /* Responsive Adjustments */
        @media (max-width: 991.98px) {
            .profile-header {
                padding: 4rem 0 2rem;
            }
            
            .profile-name {
                font-size: 2rem;
            }
            
            .profile-title {
                font-size: 1.1rem;
            }
            
            .btn-lg {
                padding: 0.5rem 1.25rem;
                font-size: 0.9rem;
            }
        }

        
        @media (max-width: 767.98px) {
            .profile-avatar {
                width: 120px;
                height: 120px;
            }
            
            .profile-name {
                font-size: 1.75rem;
            }
            
            .profile-social a {
                width: 32px;
                height: 32px;
                font-size: 0.9rem;
            }
            
            .btn-lg {
                padding: 0.4rem 1rem;
                font-size: 0.85rem;
            }
        }
        
        @media (max-width: 575.98px) {
            .profile-header {
                padding: 3rem 0 1.5rem;
            }
            
            .profile-avatar {
                width: 100px;
                height: 100px;
            }
            
            .profile-name {
                font-size: 1.5rem;
            }
            
            .profile-title {
                font-size: 1rem;
            }
            
            .badge {
                font-size: 0.75rem;
                padding: 0.35em 0.65em;
            }
            
            .btn-lg {
                padding: 0.35rem 0.75rem;
                font-size: 0.8rem;
            }
        }

        :root {
            --primary-color: #4e73df;
            --secondary-color: #f8f9fc;
            --text-color: #5a5c69;
            --border-color: #e3e6f0;
        }
        
        body {
            background-color: #f8f9fc;
            color: var(--text-color);
            font-family: 'Nunito', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
        }
        
        .navbar {
            background-color: #fff;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
        }
        
        .profile-header {
            background: linear-gradient(135deg, #4e73df 0%, #224abe 100%);
            color: white;
            padding: 3rem 0;
            margin-bottom: 2rem;
            border-radius: 0.5rem;
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
            background: url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiPjxkZWZzPjxwYXR0ZXJuIGlkPSJwYXR0ZXJuIiB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHBhdHRlcm5Vbml0cz0idXNlclNwYWNlT25Vc2UiIHBhdHRlcm5UcmFuc2Zvcm09InJvdGF0ZSg0NSkiPjxyZWN0IHg9IjAiIHk9IjAiIHdpZHRoPSIyMCIgaGVpZ2h0PSIyMCIgZmlsbD0icmdiYSgyNTUsMjU1LDI1NSwwLjA1KSIvPjwvcGF0dGVybj48L2RlZnM+PHJlY3QgeD0iMCIgeT0iMCIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgZmlsbD0idXJsKCNwYXR0ZXJuKSIvPjwvc3ZnPg==');
            opacity: 0.1;
        }
        
        .profile-avatar {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 5px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }
        
        .profile-avatar:hover {
            transform: scale(1.05);
            border-color: rgba(255, 255, 255, 0.5);
        }
        
        .section {
            margin-bottom: 2rem;
            padding: 1.5rem;
            background: #fff;
            border-radius: 0.5rem;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
            border: 1px solid var(--border-color);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .section:hover {
            transform: translateY(-5px);
            box-shadow: 0 0.5rem 1.5rem 0.5rem rgba(0, 0, 0, 0.1);
        }
        
        .section-title {
            color: var(--primary-color);
            border-bottom: 2px solid #f1f1f1;
            padding-bottom: 0.75rem;
            margin-bottom: 1.5rem;
            font-weight: 700;
            font-size: 1.5rem;
            display: flex;
            align-items: center;
        }
        
        .section-title i {
            margin-right: 10px;
        }
        
        .info-item {
            margin-bottom: 1.25rem;
            padding-bottom: 1rem;
            border-bottom: 1px dashed #eee;
        }
        
        .info-item:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }
        
        .info-label {
            font-weight: 600;
            color: #6c757d;
            margin-bottom: 0.25rem;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .info-value {
            color: var(--text-color);
            font-size: 1rem;
            line-height: 1.6;
        }
        
        .skill-tag {
            display: inline-block;
            background-color: var(--primary-color);
            color: white;
            padding: 0.35rem 0.75rem;
            border-radius: 50px;
            margin: 0.25rem;
            font-size: 0.85rem;
            transition: all 0.2s;
        }
        
        .social-links a {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background-color: #f8f9fc;
            color: var(--primary-color);
            margin-right: 0.5rem;
            transition: all 0.3s ease;
            text-decoration: none;
            border: 1px solid #e3e6f0;
        }
        
        .social-links a:hover {
            background-color: var(--primary-color);
            color: white;
            transform: translateY(-3px);
        }
        
        .btn-edit {
            position: absolute;
            top: 1.5rem;
            right: 1.5rem;
            z-index: 10;
        }
        
        @media (max-width: 768px) {
            .profile-header {
                padding: 2rem 0;
                text-align: center;
            }
            
            .btn-edit {
                position: relative;
                top: 0;
                right: 0;
                margin-bottom: 1rem;
                display: block;
                margin-left: auto;
                margin-right: auto;
            }
        }
    </style>
</head>
<body>

    <!-- Profile Header -->
    <header class="profile-header text-center text-white">
        <div class="container position-relative">
            <div class="d-flex justify-content-center mb-4">
                <div class="position-relative d-inline-block">
                    <% 
                        String avatarUrl = "";
                        if (jobseeker.getImage() != null && !jobseeker.getImage().isEmpty()) {
                            // Check if the path already starts with 'img/Jobseeker/'
                            if (jobseeker.getImage().startsWith("img/Jobseeker/")) {
                                avatarUrl = request.getContextPath() + "/" + jobseeker.getImage();
                            } else {
                                // Handle case where path might be just the filename
                                avatarUrl = request.getContextPath() + "/img/Jobseeker/" + jobseeker.getImage();
                            }
                        } else {
                            // Fallback to generated avatar
                            avatarUrl = "https://ui-avatars.com/api/?name=" + 
                                      jobseeker.getFirst_Name() + "+" + jobseeker.getLast_Name() + 
                                      "&background=4e73df&color=fff&size=300";
                        }
                    %>
                    <img src="<%= avatarUrl %>" 
                         alt="<%= jobseeker.getFirst_Name() %>" class="profile-avatar" 
                         id="currentAvatarImg" 
                         style="width: 150px; height: 150px; object-fit: cover; border: 3px solid #fff; box-shadow: 0 0 10px rgba(0,0,0,0.1);">
                    <!-- Debug Info -->
                    <div class="d-none">
                        Image Path: <%= jobseeker.getImage() %><br>
                        Resolved URL: <%= avatarUrl %>
                    </div>
                    <button class="btn btn-primary btn-sm position-absolute bottom-0 end-0 rounded-circle" 
                            style="width: 40px; height: 40px; line-height: 40px;"
                            data-bs-toggle="modal" data-bs-target="#changeAvatarModal"
                            data-bs-toggle="tooltip" data-bs-placement="top" title="Đổi ảnh đại diện">
                        <i class="bi bi-camera"></i>
                    </button>
                </div>
            </div>
            <h1 class="profile-name"><%= jobseeker.getFirst_Name() + " " + jobseeker.getLast_Name() %></h1>
            
<!--            <div class="d-flex justify-content-center gap-3 mb-3">
                <span class="badge bg-white text-primary px-3 py-2 rounded-pill">
                    <i class="bi bi-envelope me-1"></i>
                    <%= jobseeker.getEmail_contact() %>
                </span>
                <span class="badge bg-white text-primary px-3 py-2 rounded-pill">
                    <i class="bi bi-telephone me-1"></i>
                    <%= jobseeker.getPhone_contact() != null ? jobseeker.getPhone_contact() : "Not specified" %>
                </span>
            </div>-->
            
<!--            <div class="mt-4">
                <a href="edit-profile.jsp" class="btn btn-light btn-lg rounded-pill px-4 me-2">
                    <i class="bi bi-pencil-square me-2"></i>Edit Profile
                </a>
                <a href="#" class="btn btn-outline-light btn-lg rounded-pill px-4">
                    <i class="bi bi-download me-2"></i>Download CV
                </a>
            </div>-->
        </div>
    </header>

    <div class="container" style="padding-top: 6rem;">
        <!-- Success/Error Messages -->
        <% String successMessage = (String) session.getAttribute("successMessage"); 
           String errorMessage = (String) session.getAttribute("errorMessage");
           if (successMessage != null) { 
               session.removeAttribute("successMessage"); %>
               <div class="alert alert-success alert-dismissible fade show" role="alert">
                   <%= successMessage %>
                   <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
               </div>
        <% } 
           if (errorMessage != null) { 
               session.removeAttribute("errorMessage"); %>
               <div class="alert alert-danger alert-dismissible fade show" role="alert">
                   <%= errorMessage %>
                   <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
               </div>
        <% } %>
        <!-- Main Content -->
        <div class="row g-4">
            <!-- Left Sidebar -->
            <div class="col-lg-4">
                <!-- About Card -->
                <div class="card mb-4">
                    <div class="card-header bg-white d-flex justify-content-between align-items-center">
                        <h5 class="mb-0"><i class="bi bi-person-lines-fill me-2"></i>About Me</h5>
                        <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#editAboutModal">
                            <i class="bi bi-pencil"></i> Edit
                        </button>
                    </div>
                    <div class="card-body">
                        <p class="mb-0"><%= jobseeker.getDescribe() != null ? jobseeker.getDescribe() : "No bio available." %></p>
                    </div>
                </div>

                <!-- Contact Card -->
                <div class="card mb-4">
                    <div class="card-header bg-white d-flex justify-content-between align-items-center">
                        <h5 class="mb-0"><i class="bi bi-envelope-fill me-2"></i>Contact Information</h5>
                        <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#editContactModal">
                            <i class="bi bi-pencil"></i> Edit
                        </button>
                    </div>
                    <div class="card-body">
                        <div class="d-flex align-items-start mb-3">
                            <div class="icon-circle bg-light text-primary me-3 p-2 rounded-circle">
                                <i class="bi bi-envelope"></i>
                            </div>
                            <div>
                                <h6 class="mb-0">Email</h6>
                                <a href="mailto:<%= jobseeker.getEmail_contact() %>" class="text-muted"><%= jobseeker.getEmail_contact() %></a>
                            </div>
                        </div>
                        
                        <div class="d-flex align-items-start mb-3">
                            <div class="icon-circle bg-light text-primary me-3 p-2 rounded-circle">
                                <i class="bi bi-telephone"></i>
                            </div>
                            <div>
                                <h6 class="mb-0">Phone</h6>
                                <p class="mb-0 text-muted"><%= jobseeker.getPhone_contact() != null ? jobseeker.getPhone_contact() : "Not provided" %></p>
                            </div>
                        </div>
                        
                        <% if (location != null) { %>
                        <div class="d-flex align-items-start">
                            <div class="icon-circle bg-light text-primary me-3 p-2 rounded-circle">
                                <i class="bi bi-geo-alt"></i>
                            </div>
                            <div>
                                <h6 class="mb-0">Location</h6>
                                <p class="mb-0 text-muted">
                                    <i class="bi bi-geo-alt-fill me-1"></i>
                                    <%= location.getCity() %>, <%= location.getCountry() %>
                                    <% if (location.getLocationNotes() != null && !location.getLocationNotes().isEmpty()) { %>
                                        <br><small class="text-muted"><%= location.getLocationNotes() %></small>
                                    <% } %>
                                </p>
                            </div>
                        </div>
                        <% } %>
                    </div>
                </div>

                <!-- Skills Card -->
                <div class="card mb-4">
                    <div class="card-header bg-white d-flex justify-content-between align-items-center">
                        <h5 class="mb-0"><i class="bi bi-award me-2"></i>Skills</h5>
                        <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#addSkillModal">
                            <i class="bi bi-plus"></i> Add Skill
                        </button>
                    </div>
                    <div class="card-body">
                        <% if (skills != null && !skills.isEmpty()) { %>
                            <!-- Table View -->
                            <div class="skill-table-view">
                                <div class="table-responsive">
                                    <table class="table table-sm table-hover align-middle">
                                        <thead>
                                            <tr>
                                                <th>Skill</th>
                                                <th>Level</th>
                                                <th class="text-end">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% for (Skill skill : skills) { 
                                                String levelName = "";
                                                switch(skill.getLevel()) {
                                                    case 1: levelName = "Beginner"; break;
                                                    case 2: levelName = "Intermediate"; break;
                                                    case 3: levelName = "Advanced"; break;
                                                    case 4: levelName = "Expert"; break;
                                                }
                                            %>
                                                <tr>
                                                    <td><%= skill.getSkillSetName() %></td>
                                                    <td>
                                                        <div class="progress" style="height: 6px;">
                                                            <div class="progress-bar bg-primary" role="progressbar" 
                                                                style="width: <%= skill.getLevel() * 25 %>%" 
                                                                aria-valuenow="<%= skill.getLevel() * 25 %>" 
                                                                aria-valuemin="0" 
                                                                aria-valuemax="100">
                                                            </div>
                                                        </div>
                                                        <small class="text-muted">
                                                            <%= levelName %>
                                                        </small>
                                                    </td>
                                                    <td class="text-end">
                                                        <button class="btn btn-sm btn-outline-primary edit-skill" 
                                                            data-skill-id="<%= skill.getSkillID() %>"
                                                            data-skill-name="<%= skill.getSkillSetName() %>"
                                                            data-skill-level="<%= skill.getLevel() %>">
                                                            <i class="bi bi-pencil"></i>
                                                        </button>
                                                        <button class="btn btn-sm btn-outline-danger delete-skill" 
                                                            data-skill-id="<%= skill.getSkillID() %>">
                                                            <i class="bi bi-trash"></i>
                                                        </button>
                                                    </td>
                                                </tr>
                                            <% } %>  
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            
                        <% } else { %>
                            <div class="text-center py-3">
                                <i class="bi bi-award text-muted" style="font-size: 2rem;"></i>
                                <p class="mt-2 mb-0">No skills added yet</p>
                                <div class="d-flex gap-2">
                                    <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#addSkillModal">
                                        <i class="bi bi-plus"></i> Add Skill
                                    </button>
                                    <button class="btn btn-sm btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#viewSkillSetModal">
                                        <i class="bi bi-collection"></i> View All Skills
                                    </button>
                                </div>
                            </div>
                        <% } %>
                    </div>
                </div>

                
            </div>

            <!-- Main Content -->
            <div class="col-lg-8">
                <!-- Experience Section -->
                <div class="card mb-4">
                    <div class="card-header bg-white d-flex justify-content-between align-items-center">
                        <h5 class="mb-0"><i class="bi bi-briefcase me-2"></i>Work Experience</h5>
                        <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#addExperienceModal">
                            <i class="bi bi-plus"></i> Add Experience
                        </button>
                    </div>
                    <div class="card-body">
                        <% if (experienceList != null && !experienceList.isEmpty()) { %>
                            <div class="timeline">
                                <% for (Experience exp : experienceList) { %>
                                    <div class="timeline-item">
                                        <div class="timeline-marker"></div>
                                        <div class="timeline-content">
                                            <div class="d-flex justify-content-between">
                                                <div>
                                                    <h5 class="mb-1"><%= exp.getPosition() != null ? exp.getPosition() : "Position not specified" %></h5>
                                                    <h6 class="text-primary mb-2"><%= exp.getExperienceWorkName() != null ? exp.getExperienceWorkName() : "Company not specified" %></h6>
                                                </div>
                                                <div class="dropdown">
                                                    <button class="btn btn-sm btn-link text-muted p-0" type="button" id="expDropdown<%= exp.getExperienceID() %>" data-bs-toggle="dropdown" aria-expanded="false">
                                                        <i class="bi bi-three-dots-vertical"></i>
                                                    </button>
                                                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="expDropdown<%= exp.getExperienceID() %>">
                                                        <li>
                                                            <a class="dropdown-item edit-experience" href="#" 
                                                               data-exp-id="<%= exp.getExperienceID() %>"
                                                               data-company="<%= exp.getExperienceWorkName() %>"
                                                               data-position="<%= exp.getPosition() %>"
                                                               data-start="<%= exp.getStartDate() != null ? exp.getStartDate().toString() : "" %>"
                                                               data-end="<%= exp.getEndDate() != null ? exp.getEndDate().toString() : "" %>"
                                                               data-description="<%= exp.getYourProject() != null ? exp.getYourProject().replace("\"", "&quot;").replace("'", "&#39;") : "" %>"
                                                               data-current="<%= exp.getEndDate() == null %>">
                                                                <i class="bi bi-pencil me-2"></i>Edit
                                                            </a>
                                                        </li>
                                                        <li>
                                                            <form action="JobseekerDetailController" method="POST" class="d-inline">
                                                                <input type="hidden" name="action" value="delete-experience">
                                                                <input type="hidden" name="id" value="${jobseeker.getFreelancerID()}">
                                                                <input type="hidden" name="experienceId" value="<%= exp.getExperienceID() %>">
                                                                <button type="submit" class="dropdown-item text-danger" onclick="return confirm('Are you sure you want to delete this experience?')">
                                                                    <i class="bi bi-trash me-2"></i>Delete
                                                                </button>
                                                            </form>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <p class="text-muted small mb-2">
                                                <i class="bi bi-calendar3 me-1"></i> 
                                                <%= exp.getStartDate() %> - <%= exp.getEndDate() != null ? exp.getEndDate() : "Present" %>
                                            </p>
                                            <% if (exp.getYourProject() != null && !exp.getYourProject().isEmpty()) { %>
                                                <p class="mb-0"><%= exp.getYourProject() %></p>
                                            <% } %>
                                        </div>
                                    </div>
                                <% } %>
                            </div>
                        <% } else { %>
                            <div class="text-center py-4">
                                <i class="bi bi-briefcase text-muted" style="font-size: 2.5rem;"></i>
                                <p class="mt-2 mb-0">No work experience added yet.</p>
                                <button class="btn btn-sm btn-outline-primary mt-2" data-bs-toggle="modal" data-bs-target="#addExperienceModal">
                                    <i class="bi bi-plus-lg me-1"></i> Add Experience
                                </button>
                            </div>
                        <% } %>
                    </div>
                </div>

                <!-- Education Section -->
                <div class="card mb-4">
                    <div class="card-header bg-white d-flex justify-content-between align-items-center">
                        <h5 class="mb-0"><i class="bi bi-mortarboard me-2"></i>Education</h5>
                        <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#addEducationModal">
                            <i class="bi bi-plus"></i> Add Education
                        </button>
                    </div>
                    <div class="card-body">
                        <% if (educationList != null && !educationList.isEmpty()) { %>
                            <div class="timeline">
                                <% for (Education edu : educationList) { %>
                                    <div class="timeline-item">
                                        <div class="timeline-marker bg-success"></div>
                                        <div class="timeline-content">
                                            <div class="d-flex justify-content-between">
                                                <div>
                                                    <h5 class="mb-1"><%= edu.getDegreeName() != null ? edu.getDegreeName() : "Degree" %></h5>
                                                    <h6 class="text-primary mb-2"><%= edu.getUniversityName() != null ? edu.getUniversityName() : "School not specified" %></h6>
                                                </div>
                                                <div class="dropdown">
                                                    <button class="btn btn-sm btn-link text-muted p-0" type="button" id="eduDropdown<%= edu.getEducationID() %>" data-bs-toggle="dropdown" aria-expanded="false">
                                                        <i class="bi bi-three-dots-vertical"></i>
                                                    </button>
                                                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="eduDropdown<%= edu.getEducationID() %>">
                                                        <li>
                                                            <% 
                                                                String startDateStr = "";
                                                                String endDateStr = "";
                                                                boolean isCurrent = edu.getEndDate() == null;
                                                                if (edu.getStartDate() != null) {
                                                                    startDateStr = edu.getStartDate().toString().substring(0, 7);
                                                                }
                                                                if (edu.getEndDate() != null) {
                                                                    endDateStr = edu.getEndDate().toString().substring(0, 7);
                                                                }
                                                            %>
                                                            <a class="dropdown-item edit-education" href="#" 
                                                               data-id="<%= edu.getEducationID() %>"
                                                               data-degree="<%= edu.getDegreeName() != null ? edu.getDegreeName() : "Không yêu cầu" %>"
                                                               data-school="<%= edu.getUniversityName() != null ? edu.getUniversityName() : "" %>"
                                                               data-start="<%= startDateStr %>"
                                                               data-end="<%= endDateStr %>"
                                                               data-description=""
                                                               data-current="<%= isCurrent %>">
                                                                <i class="bi bi-pencil me-2"></i>Edit
                                                            </a>
                                                        </li>
                                                        <li>
                                                            <form action="JobseekerDetailController" method="POST" class="d-inline">
                                                                <input type="hidden" name="action" value="delete-education">
                                                                <input type="hidden" name="id" value="${jobseeker.getFreelancerID()}">
                                                                <input type="hidden" name="educationId" value="<%= edu.getEducationID() %>">
                                                                <button type="submit" class="dropdown-item text-danger" onclick="return confirm('Are you sure you want to delete this education entry?')">
                                                                    <i class="bi bi-trash me-2"></i>Delete
                                                                </button>
                                                            </form>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <p class="text-muted small mb-2">
                                                <i class="bi bi-calendar3 me-1"></i>
                                                <% if (edu.getStartDate() != null) { %>
                                                    <%= edu.getStartDate().toString().substring(0, 7) %> - 
                                                    <%= edu.getEndDate() != null ? edu.getEndDate().toString().substring(0, 7) : "Hiện tại" %>
                                                <% } else { %>
                                                    Ngày không xác định
                                                <% } %>
                                                <!-- GPA and description fields removed as they don't exist in the Education model -->
                                            </p>
                                        </div>
                                    </div>
                                <% } %>
                            </div>
                        <% } else { %>
                            <div class="text-center py-4">
                                <i class="bi bi-mortarboard text-muted" style="font-size: 2.5rem;"></i>
                                <p class="mt-2 mb-0">No education information added yet.</p>
                                <button class="btn btn-sm btn-outline-primary mt-2" data-bs-toggle="modal" data-bs-target="#addEducationModal">
                                    <i class="bi bi-plus-lg me-1"></i> Add Education
                                </button>
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
    // Handle adding skill from skill set modal
    document.addEventListener('DOMContentLoaded', function() {
        // When clicking "Add to Profile" in the skill set modal
        document.addEventListener('click', function(e) {
            if (e.target.closest('.add-skill-from-set')) {
                const button = e.target.closest('.add-skill-from-set');
                const skillId = button.getAttribute('data-skill-id');
                const skillName = button.getAttribute('data-skill-name');
                
                // Set the value in the add skill modal
                const select = document.querySelector('select[name="skillId"]');
                if (select) {
                    select.value = skillId;
                    // Trigger change event to update any dependent fields
                    select.dispatchEvent(new Event('change'));
                }
                
                // Close the view modal and open the add skill modal
                const viewModal = bootstrap.Modal.getInstance(document.getElementById('viewSkillSetModal'));
                viewModal.hide();
                
                const addModal = new bootstrap.Modal(document.getElementById('addSkillModal'));
                addModal.show();
                
                // Scroll to the skill select field
                if (select) {
                    select.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }
            }
        });
    });
    </script>

    <!-- View All Skills Modal -->
    <div class="modal fade" id="viewSkillSetModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Available Skills</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row g-3">
                        <% if (skillSets != null && !skillSets.isEmpty()) { 
                            for (SkillSet skillSet : skillSets) { 
                                if (skillSet != null && skillSet.isActive()) { 
                        %>
                            <div class="col-md-6">
                                <div class="card h-100">
                                    <div class="card-body">
                                        <h6 class="card-title"><%= skillSet.getSkillSetName() %></h6>
                                        <% if (skillSet.getDescription() != null && !skillSet.getDescription().isEmpty()) { %>
                                            <p class="card-text small text-muted"><%= skillSet.getDescription() %></p>
                                        <% } %>
                                        <button class="btn btn-sm btn-outline-primary add-skill-from-set" 
                                                data-skill-id="<%= skillSet.getSkillSetId() %>"
                                                data-skill-name="<%= skillSet.getSkillSetName() %>">
                                            <i class="bi bi-plus-circle"></i> Add to Profile
                                        </button>
                                    </div>
                                </div>
                            </div>
                        <%  } 
                            } 
                        } else { %>
                            <div class="col-12 text-center py-4">
                                <i class="bi bi-exclamation-circle text-muted" style="font-size: 2rem;"></i>
                                <p class="mt-2">No skill sets available.</p>
                            </div>
                        <% } %>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Edit Skill Modal -->
    <div class="modal fade" id="editSkillModal" tabindex="-1" aria-labelledby="editSkillModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editSkillModalLabel">Edit Skill Level</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form id="editSkillForm">
                    <div class="modal-body">
                        <input type="hidden" id="editSkillId" name="skillId">
                        <div class="mb-3">
                            <label for="editSkillName" class="form-label">Skill</label>
                            <input type="text" class="form-control" id="editSkillName" disabled>
                        </div>
                        <div class="mb-3">
                            <label for="editSkillLevel" class="form-label">Proficiency Level</label>
                            <select class="form-select" id="editSkillLevel" name="level" required>
                                <option value="1">Beginner</option>
                                <option value="2">Intermediate</option>
                                <option value="3">Advanced</option>
                                <option value="4">Expert</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <!-- Add Skill Modal -->
    <div class="modal fade" id="addSkillModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Skill</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="JobseekerDetailController" method="POST">
                    <input type="hidden" name="action" value="add-skill">
                    <input type="hidden" name="jobseekerId" value="<%= jobseeker.getFreelancerID() %>">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Select Skill</label>
                            <select class="form-select" name="skillSetId" required>
                                <option value="">-- Select a skill --</option>
                                <% if (skillSets != null && !skillSets.isEmpty()) { 
                                    for (SkillSet skillSet : skillSets) { 
                                        if (skillSet != null && skillSet.isActive()) { 
                                %>
                                    <option value="<%= skillSet.getSkillSetId() %>">
                                        <%= skillSet.getSkillSetName() %>
                                        <% if (skillSet.getDescription() != null && !skillSet.getDescription().isEmpty()) { %>
                                            - <%= skillSet.getDescription() %>
                                        <% } %>
                                    </option>
                                <%  } 
                                    } 
                                } %>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Custom Skill Name (if not in list)</label>
                            <input type="text" name="customSkillName" class="form-control">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Proficiency Level</label>
                            <select class="form-select" name="proficiency">
                                <option value="">Select proficiency level (optional)</option>
                                <option value="Beginner">Beginner</option>
                                <option value="Intermediate">Intermediate</option>
                                <option value="Advanced">Advanced</option>
                                <option value="Expert">Expert</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Add Skill</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Add Experience Modal -->
    <div class="modal fade" id="addExperienceModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add Work Experience</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="JobseekerDetailController" method="POST">
                    <input type="hidden" name="action" value="add-experience">
                    <input type="hidden" name="id" value="${jobseeker.getFreelancerID()}">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Job Title</label>
                                <input type="text" name="position" class="form-control" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Company</label>
                                <input type="text" name="company" class="form-control" required>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Start Date</label>
                                <input type="month" name="startDate" class="form-control" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">End Date</label>
                                <div class="input-group">
                                    <input type="month" name="endDate" class="form-control">
                                    <div class="input-group-text">
                                        <input class="form-check-input mt-0" type="checkbox" id="currentJob" name="current" value="true">
                                        <label class="form-check-label ms-2" for="currentJob">I currently work here</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <textarea name="description" class="form-control" rows="4" placeholder="Describe your responsibilities and achievements"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Save Experience</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit About Me Modal -->
    <div class="modal fade" id="editAboutModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Edit About Me</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="JobseekerDetailController" method="POST" id="aboutForm">
                    <input type="hidden" name="id" value="${jobseeker.getFreelancerID()}">
                    <input type="hidden" name="action" value="update-about">

                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">About Me</label>
                            <textarea name="aboutText" class="form-control" rows="5" placeholder="Tell us about yourself..."><%= jobseeker.getDescribe() != null ? jobseeker.getDescribe() : "" %></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit Contact Information Modal -->
    <div class="modal fade" id="editContactModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Edit Contact Information</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="JobseekerDetailController" method="POST">
                    <input type="hidden" name="id" value="${jobseeker.getFreelancerID()}">
                    <input type="hidden" name="action" value="update-contact">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" name="email" class="form-control" value="<%= jobseeker.getEmail_contact() %>" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Phone Number</label>
                            <input type="tel" name="phone" class="form-control" value="<%= jobseeker.getPhone_contact() != null ? jobseeker.getPhone_contact() : "" %>">
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">City</label>
                                <input type="text" name="city" class="form-control" 
                                       value="<%= location != null && location.getCity() != null ? location.getCity() : "" %>">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Country</label>
                                <input type="text" name="country" class="form-control" 
                                       value="<%= location != null && location.getCountry() != null ? location.getCountry() : "" %>">
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Work Preference</label>
                            <select name="workPreference" class="form-select">
                                <option value="" <%= location == null || location.getWorkPreference() == null || location.getWorkPreference().isEmpty() ? "selected" : "" %>>Select work preference</option>
                                <option value="On-site" <%= location != null && "On-site".equals(location.getWorkPreference()) ? "selected" : "" %>>On-site</option>
                                <option value="Remote" <%= location != null && "Remote".equals(location.getWorkPreference()) ? "selected" : "" %>>Remote</option>
                                <option value="Hybrid" <%= location != null && "Hybrid".equals(location.getWorkPreference()) ? "selected" : "" %>>Hybrid</option>
                                <option value="Negotiable" <%= location != null && "Negotiable".equals(location.getWorkPreference()) ? "selected" : "" %>>Negotiable</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Location Notes</label>
                            <textarea name="locationNotes" class="form-control" rows="3" 
                                placeholder="Any additional location information..."><%= location != null && location.getLocationNotes() != null ? location.getLocationNotes() : "" %></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Add Education Modal -->
    <div class="modal fade" id="addEducationModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add Education</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="JobseekerDetailController" method="POST">
                    <input type="hidden" name="action" value="add-education">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Degree</label>
                            <select name="degree" class="form-select" required>
                                <option value="Không yêu cầu" disabled selected>Không yêu cầu</option>
                                <option value="Trung cấp">Trung cấp</option>
                                <option value="Cao đẳng">Cao đẳng</option>
                                <option value="Đại học">Đại học</option>
                                <option value="Thạc sĩ">Thạc sĩ</option>
                                <option value="Tiến sĩ">Tiến sĩ</option>
                                <option value="Chứng chỉ nghề">Chứng chỉ nghề</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">School/University</label>
                            <input type="text" name="school" class="form-control" required>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Start Date</label>
                                <input type="month" name="startDate" class="form-control" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">End Date</label>
                                <input type="month" name="endDate" class="form-control">
                                <div class="form-check mt-2">
                                    <input class="form-check-input" type="checkbox" id="currentEducation" name="current" value="true">
                                    <label class="form-check-label" for="currentEducation">I currently study here</label>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <textarea name="description" class="form-control" rows="3"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Save changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit Experience Modal -->
    <div class="modal fade" id="editExperienceModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Edit Work Experience</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form id="editExperienceForm" action="JobseekerDetailController" method="POST">
                    <input type="hidden" name="action" value="update-experience">
                    <input type="hidden" name="experienceId" id="editExperienceId">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Job Title</label>
                                <input type="text" name="position" id="editPosition" class="form-control" required value="">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Company</label>
                                <input type="text" name="company" id="editCompany" class="form-control" required value="">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Start Date</label>
                                <input type="month" name="startDate" id="editExpStartDate" class="form-control" required value="">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">End Date</label>
                                <div class="input-group">
                                    <input type="month" name="endDate" id="editExpEndDate" class="form-control">
                                    <div class="input-group-text">
                                        <input class="form-check-input mt-0" type="checkbox" id="editCurrentJob" name="current" value="true">
                                        <label class="form-check-label ms-2" for="editCurrentJob">I currently work here</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <textarea name="description" id="editExpDescription" class="form-control" rows="4" placeholder="Describe your responsibilities and achievements"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit Education Modal -->
    <div class="modal fade" id="editEducationModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Edit Education</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form id="editEducationForm" action="JobseekerDetailController" method="POST" >
                    <input type="hidden" name="action" value="update-education">
                    <input type="hidden" name="id" value="${jobseeker.getFreelancerID()}">
                    <input type="hidden" name="educationId" id="editEducationId" value="">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Degree</label>
                            <select name="degree" id="editDegree" class="form-select" required>
                                <option value="Không yêu cầu">Không yêu cầu</option>
                                <option value="Trung cấp">Trung cấp</option>
                                <option value="Cao đẳng">Cao đẳng</option>
                                <option value="Đại học">Đại học</option>
                                <option value="Thạc sĩ">Thạc sĩ</option>
                                <option value="Tiến sĩ">Tiến sĩ</option>
                                <option value="Chứng chỉ nghề">Chứng chỉ nghề</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">School/University</label>
                            <input type="text" name="school" id="editSchool" class="form-control" required>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Start Date</label>
                                <input type="month" name="startDate" id="editEduStartDate" class="form-control" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">End Date</label>
                                <input type="month" name="endDate" id="editEduEndDate" class="form-control">
                                <div class="form-check mt-2">
                                    <input class="form-check-input" type="checkbox" id="editCurrentEducation" name="current" value="true">
                                    <label class="form-check-label" for="editCurrentEducation">I currently study here</label>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <textarea name="description" id="editEduDescription" class="form-control" rows="3"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Change Avatar Modal -->
    <div class="modal fade" id="changeAvatarModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Change Profile Picture</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form id="avatarForm" action="JobseekerDetailController" method="POST" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="change-avatar">
                    <input type="hidden" name="id" value="${jobseeker.getFreelancerID()}">
                    <div class="modal-body">
                        <div class="text-center mb-3">
                            <img id="avatarPreview" src="${jobseeker.getImage()}" 
                                 class="rounded-circle" width="200" height="200" style="object-fit: cover;">
                        </div>
                        <div class="mb-3">
                            <label for="avatarInput" class="form-label">Choose new profile picture</label>
                            <input class="form-control" type="file" id="avatarInput" name="avatar" accept="image/*" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <style>
        /* Skill Table Styles */
        .skill-table-view table td, 
        .skill-table-view table th {
            padding: 0.5rem;
        }
        .skill-table-view .progress {
            min-width: 60px;
        }
    </style>
    
    <script>
        // Handle current education checkbox
        document.addEventListener('change', function(e) {
            if (e.target.id === 'currentEducation') {
                const endDateInput = e.target.closest('.modal-body').querySelector('input[name="endDate"]');
                endDateInput.disabled = e.target.checked;
                if (e.target.checked) {
                    endDateInput.value = '';
                }
            }
        });

        // Handle Edit Experience
        document.addEventListener('click', function(e) {
            // Edit Experience Click
            if (e.target.closest('.edit-experience') || e.target.classList.contains('edit-experience')) {
                e.preventDefault();
                const expId = e.target.closest('.edit-experience').getAttribute('data-exp-id');
                
                // Fetch experience details via AJAX
                fetch('JobseekerDetailController?action=get-experience&id=' + expId)
                    .then(response => response.json())
                    .then(exp => {
                        // Fill the edit form
                        document.getElementById('editExperienceId').value = exp.experienceID;
                        document.querySelector('#editExperienceModal input[name="position"]').value = exp.position || '';
                        document.querySelector('#editExperienceModal input[name="company"]').value = exp.experienceWorkName || '';
                        
                        // Format dates to YYYY-MM format
                        if (exp.startDate) {
                            const startDate = new Date(exp.startDate);
                            const formattedStartDate = startDate.getFullYear() + '-' + 
                                String(startDate.getMonth() + 1).padStart(2, '0');
                            document.querySelector('#editExperienceModal input[name="startDate"]').value = formattedStartDate;
                        }
                        
                        const currentJobCheckbox = document.querySelector('#editExperienceModal input[name="current"]');
                        const endDateInput = document.querySelector('#editExperienceModal input[name="endDate"]');
                        
                        if (exp.endDate) {
                            const endDate = new Date(exp.endDate);
                            const formattedEndDate = endDate.getFullYear() + '-' + 
                                String(endDate.getMonth() + 1).padStart(2, '0');
                            endDateInput.value = formattedEndDate;
                            currentJobCheckbox.checked = false;
                            endDateInput.disabled = false;
                        } else {
                            endDateInput.value = '';
                            currentJobCheckbox.checked = true;
                            endDateInput.disabled = true;
                        }
                        
                        document.querySelector('#editExperienceModal textarea[name="description"]').value = exp.yourProject || '';
                        
                        // Show the modal
                        const modal = new bootstrap.Modal(document.getElementById('editExperienceModal'));
                        modal.show();
                    })
                    .catch(error => {
                        console.error('Error fetching experience:', error);
                        alert('Failed to load experience details. Please try again.');
                    });
            }
            
            // Edit Education Click
            if (e.target.closest('.edit-education') || e.target.classList.contains('edit-education')) {
                e.preventDefault();
                const btn = e.target.closest('.edit-education') || e.target;
                
                // Lấy các phần tử form
                const form = document.getElementById('editEducationForm');
                const endDateInput = document.getElementById('editEduEndDate');
                const currentCheckbox = document.getElementById('editCurrentEducation');
                
                // Debug: Log dữ liệu từ nút edit
                console.log('Edit button data:', {
                    id: btn.dataset.id,
                    degree: btn.dataset.degree,
                    school: btn.dataset.school,
                    start: btn.dataset.start,
                    end: btn.dataset.end,
                    current: btn.dataset.current
                });
                
                // Đặt giá trị cho form
                const educationId = btn.dataset.id || '';
                document.getElementById('editEducationId').value = educationId;
                console.log('Setting education ID:', educationId);
                
                // Đặt các giá trị khác
                document.getElementById('editDegree').value = btn.dataset.degree || 'Không yêu cầu';
                document.getElementById('editSchool').value = btn.dataset.school || '';
                document.getElementById('editEduStartDate').value = btn.dataset.start || '';
                
                // Xử lý ngày kết thúc và checkbox hiện tại
                const isCurrent = btn.dataset.current === 'true' || !btn.dataset.end || btn.dataset.end === 'null';
                
                if (!isCurrent && btn.dataset.end && btn.dataset.end !== 'null') {
                    endDateInput.value = btn.dataset.end;
                    currentCheckbox.checked = false;
                    endDateInput.disabled = false;
                } else {
                    endDateInput.value = '';
                    currentCheckbox.checked = true;
                    endDateInput.disabled = true;
                }
                
                document.getElementById('editEduDescription').value = btn.dataset.description || '';
                
                // Debug: Log giá trị form trước khi hiển thị modal
                console.log('Form values:', {
                    id: document.getElementById('editEducationId').value,
                    degree: document.getElementById('editDegree').value,
                    school: document.getElementById('editSchool').value,
                    start: document.getElementById('editEduStartDate').value,
                    end: endDateInput.value,
                    current: currentCheckbox.checked
                });
                
                // Hiển thị modal
                const modalElement = document.getElementById('editEducationModal');
                const modal = bootstrap.Modal.getOrCreateInstance(modalElement);
                modal.show();
            }
        });
        
        // Handle current job/education toggle
        document.addEventListener('change', function(e) {
            if (e.target.id === 'editCurrentJob' || e.target.id === 'currentJob') {
                const endDateInput = e.target.closest('.input-group').querySelector('input[type="month"]');
                endDateInput.disabled = e.target.checked;
                if (e.target.checked) {
                    endDateInput.value = '';
                }
            }
            
            // Handle current education checkbox change
            if (e.target.id === 'editCurrentEducation' || e.target.id === 'currentEducation') {
                const modalBody = e.target.closest('.modal-body');
                if (!modalBody) return;
                
                const endDateInput = modalBody.querySelector('#editEduEndDate');
                if (!endDateInput) return;
                
                endDateInput.disabled = e.target.checked;
                if (e.target.checked) {
                    endDateInput.value = '';
                }
            }
        });
        
        // Initialize tooltips
        document.addEventListener('DOMContentLoaded', function() {
            // Skill view toggle
            document.querySelectorAll('.view-toggle').forEach(button => {
                button.addEventListener('click', function() {
                    const viewType = this.getAttribute('data-view');
                    // Update active state
                    document.querySelectorAll('.view-toggle').forEach(btn => btn.classList.remove('active'));
                    this.classList.add('active');
                    // Toggle views
                    if (viewType === 'badge') {
                        document.querySelector('.skill-badge-view').classList.remove('d-none');
                        document.querySelector('.skill-table-view').classList.add('d-none');
                    } else {
                        document.querySelector('.skill-badge-view').classList.add('d-none');
                        document.querySelector('.skill-table-view').classList.remove('d-none');
                    }
                });
            });
            
            // Handle edit skill
            document.querySelectorAll('.edit-skill').forEach(button => {
                button.addEventListener('click', function(e) {
                    e.preventDefault();
                    const skillId = this.getAttribute('data-skill-id');
                    const skillName = this.getAttribute('data-skill-name');
                    const skillLevel = this.getAttribute('data-skill-level');
                    
                    // Set values in the edit modal
                    document.getElementById('editSkillId').value = skillId;
                    document.getElementById('editSkillName').value = skillName;
                    document.getElementById('editSkillLevel').value = skillLevel;
                    
                    // Show the modal
                    const editModal = new bootstrap.Modal(document.getElementById('editSkillModal'));
                    editModal.show();
                });
            });
            
            // Handle edit skill form submission
            document.getElementById('editSkillForm').addEventListener('submit', function(e) {
                e.preventDefault();
                const form = e.target;
                const formData = new FormData(form);
                
                // Create a form element
                const submitForm = document.createElement('form');
                submitForm.method = 'POST';
                submitForm.action = 'JobseekerDetailController';
                
                // Add action parameter
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'update-skill';
                submitForm.appendChild(actionInput);
                
                // Add form data
                formData.forEach((value, key) => {
                    const input = document.createElement('input');
                    input.type = 'hidden';
                    input.name = key;
                    input.value = value;
                    submitForm.appendChild(input);
                });
                
                // Submit the form
                document.body.appendChild(submitForm);
                submitForm.submit();
            });
            
            // Handle delete skill
            document.querySelectorAll('.delete-skill').forEach(button => {
                button.addEventListener('click', function(e) {
                    e.preventDefault();
                    const skillId = this.getAttribute('data-skill-id');
                    const jobseekerId = '<%= jobseeker.getFreelancerID() %>';
                    if (confirm('Are you sure you want to delete this skill?')) {
                        // Create a form element
                        const form = document.createElement('form');
                        form.method = 'POST';
                        form.action = 'JobseekerDetailController';
                        
                        // Add action parameter
                        const actionInput = document.createElement('input');
                        actionInput.type = 'hidden';
                        actionInput.name = 'action';
                        actionInput.value = 'delete-skill';
                        form.appendChild(actionInput);
                        
                        // Add skill ID parameter
                        const skillIdInput = document.createElement('input');
                        skillIdInput.type = 'hidden';
                        skillIdInput.name = 'skillId';
                        skillIdInput.value = skillId;
                        form.appendChild(skillIdInput);
                        
                        // Add jobseeker ID parameter
                        const jobseekerIdInput = document.createElement('input');
                        jobseekerIdInput.type = 'hidden';
                        jobseekerIdInput.name = 'jobseekerId';
                        jobseekerIdInput.value = jobseekerId;
                        form.appendChild(jobseekerIdInput);
                        
                        // Submit the form
                        document.body.appendChild(form);
                        form.submit();
                    }
                });
            });
            // Initialize Bootstrap tooltips
            var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
            var tooltipList = tooltipTriggerList.map(function(tooltipTriggerEl) {
                return new bootstrap.Tooltip(tooltipTriggerEl);
            });
            
            // Handle current education checkbox
            const currentEducation = document.getElementById('currentEducation');
            if (currentEducation) {
                currentEducation.addEventListener('change', function() {
                    const endDate = document.querySelector('input[name="endDate"]');
                    endDate.disabled = this.checked;
                    if (this.checked) {
                        endDate.value = '';
                    }
                });
            }

            // Handle current job checkbox
            const currentJob = document.getElementById('currentJob');
            if (currentJob) {
                const endDate = document.querySelector('input[name="endDate"]');
                currentJob.addEventListener('change', function() {
                    endDate.disabled = this.checked;
                    if (this.checked) {
                        endDate.value = '';
                    }
                });
            }

            // Initialize dropdowns
            var dropdownElementList = [].slice.call(document.querySelectorAll('.dropdown-toggle'));
            var dropdownList = dropdownElementList.map(function (dropdownToggleEl) {
                return new bootstrap.Dropdown(dropdownToggleEl);
            });

            // Handle form validation
            const forms = document.querySelectorAll('.needs-validation');
            Array.from(forms).forEach(form => {
                form.addEventListener('submit', event => {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);
            });

            // Add smooth scrolling to all links
            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                anchor.addEventListener('click', function (e) {
                    e.preventDefault();
                    const targetId = this.getAttribute('href');
                    if (targetId === '#') return;
                    
                    const targetElement = document.querySelector(targetId);
                    if (targetElement) {
                        window.scrollTo({
                            top: targetElement.offsetTop - 80,
                            behavior: 'smooth'
                        });
                    }
                });
            });
        });
    </script>
</body>
</html>
