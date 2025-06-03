<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> <%-- JSTL Core library declaration --%>
<%@page import="DAO.SkillDAO"%> <%-- Import SkillDAO class --%>
<%@page import="Model.SkillSet"%> <%-- Import SkillSet Model class --%>
<%@page import="java.util.List"%> <%-- Import List --%>
<%@page import="java.util.ArrayList"%> <%-- Import ArrayList --%>

<%-- Java Scriptlet block for business logic --%>
<%
    // Initialize SkillDAO object to interact with the DB
    SkillDAO skillDAO = new SkillDAO();

    // Get search parameter from request
    String keyword = request.getParameter("keyword");
    // For skills, searching might be simpler, e.g., always search by name or description.
    // Currently, assume simple search by skill_set_name.
    
    // Configure pagination
    int defaultPageSize = 10; // Default 10 skills per page
    int pageSize = defaultPageSize; // Number of skills per page, initially default
    
    // Get pageSize parameter from request (if user changes it)
    String pageSizeParam = request.getParameter("pageSize");
    if (pageSizeParam != null && !pageSizeParam.isEmpty()) {
        try {
            int customPageSize = Integer.parseInt(pageSizeParam);
            if (customPageSize > 0) { // Only accept positive pageSize
                pageSize = customPageSize;
            }
        } catch (NumberFormatException e) {
            // If parsing error (e.g., user enters text), keep default pageSize
        }
    }
    
    // Get current page parameter from request
    int currentPage = 1; // Default to the first page
    String pageParam = request.getParameter("page");
    if (pageParam != null && !pageParam.isEmpty()) {
        try {
            currentPage = Integer.parseInt(pageParam);
        } catch (NumberFormatException e) {
            currentPage = 1; // If error, go back to page 1
        }
    }
    
    int totalSkills;          // Total number of skills (based on search or all)
    List<SkillSet> skillList; // List of skills to display

    // Get data based on whether there is a search keyword
    if (keyword != null && !keyword.trim().isEmpty()) { // If there is a search keyword
        totalSkills = skillDAO.countSearchedSkills(keyword); // Count skills matching the keyword
        skillList = skillDAO.searchSkills(keyword, currentPage, pageSize); // Get list of matching skills with pagination
    } else { // If no search keyword (display all)
        totalSkills = skillDAO.countTotalSkills(); // Count total skills
        skillList = skillDAO.getSkillsByPage(currentPage, pageSize); // Get list of skills with pagination
    }
    if (keyword != null && !keyword.trim().isEmpty()) {
    keyword = keyword.trim().replaceAll("\\s+", " "); 
    totalSkills = skillDAO.countSearchedSkills(keyword);
    skillList = skillDAO.searchSkills(keyword, currentPage, pageSize);
} else {
    totalSkills = skillDAO.countTotalSkills();
    skillList = skillDAO.getSkillsByPage(currentPage, pageSize);
}

    // Calculate total pages based on total skills and page size
    int totalPages = (int) Math.ceil((double) totalSkills / pageSize);
    
    // Ensure current page does not exceed total pages (if there is data)
    if (currentPage > totalPages && totalPages > 0) {
        currentPage = totalPages;
    }
    // Ensure current page is not less than 1
    if (currentPage < 1) {
        currentPage = 1;
    }
    
    // Set attributes in request for JSP to access and display
    request.setAttribute("skillList", skillList);         // List of skills
    request.setAttribute("currentPage", currentPage);     // Current page
    request.setAttribute("totalPages", totalPages);       // Total pages
    request.setAttribute("totalSkills", totalSkills);     // Total skills
    request.setAttribute("currentKeyword", keyword);      // Current search keyword (to repopulate search box)
%>
<!DOCTYPE html>
<html class="no-js" lang="en"> <%-- Changed lang to "en" for English --%>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Manage Skills - Admin Page</title> <%-- Changed page title --%>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- CSS Links (assuming these CSS files exist and paths are correct) -->
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/font-awesome.min.css"> <%-- Font Awesome for icons --%>
        <link rel="stylesheet" href="css/themify-icons.css"> <%-- Themify Icons --%>
        <link rel="stylesheet" href="css/style.css"> <%-- Your custom CSS --%>
        <link rel="stylesheet" href="css/responsive.css"> <%-- CSS for responsive design --%>
        <style>
            /* CSS copied from admin_jobseeker.jsp, including pagination, sidebar, main content, etc. */
            /* ... (All CSS you provided) ... */
            :root {
                --primary-color: #007bff; /* Primary blue color for skill management */
                --primary-dark: #0056b3;
                --primary-light: rgba(0, 123, 255, 0.1);
                --text-color: #2d3436;
                --white: #ffffff;
            }
            /* (Rest of the CSS remains as you provided) */
            body {
                font-family: 'Poppins', sans-serif;
                margin: 0;
                padding: 0;
                overflow-x: hidden;
                background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
                min-height: 100vh;
            }
            .sidebar {
                width: 250px;
                height: 100vh;
                position: fixed;
                left: -250px;
                background: var(--white);
                box-shadow: 0 0 20px rgba(0,0,0,0.1);
                transition: 0.3s ease;
                z-index: 1000;
                overflow-y: auto;
            }
            .sidebar.active {
                left: 0;
            }
            .sidebar-header {
                padding: 20px 50px;
                border-bottom: 1px solid rgba(0,0,0,0.1);
                position: relative;
                z-index: 1002;
            }
            .sidebar-header h3 {
                margin: 0;
                color: var(--text-color);
                font-size: 1.5rem;
                position: relative;
                z-index: 1002;
            }
            .sidebar-content {
                padding: 20px;
            }
            .menu-item {
                display: flex;
                align-items: center;
                padding: 10px 15px;
                margin: 5px 0;
                color: var(--text-color);
                text-decoration: none;
                border-radius: 5px;
                transition: 0.3s ease;
            }
            .menu-item i {
                margin-right: 10px;
                font-size: 1.2rem;
            }
            .menu-item:hover {
                background: var(--primary-light);
                color: var(--primary-color);
            }
            .menu-item.active {
                background: var(--primary-color);
                color: var(--white);
            }
            .main-content {
                margin-left: 0;
                padding: 30px;
                background: rgba(255,255,255,0.95);
                transition: 0.3s ease;
                min-height: 100vh;
            }
            .sidebar.active ~ .main-content {
                margin-left: 250px;
            }
            .toggle-btn {
                position: fixed;
                top: 20px;
                left: 10px;
                background: var(--primary-color);
                color: var(--white);
                border: none;
                padding: 10px;
                border-radius: 50%;
                cursor: pointer;
                z-index: 1001;
                box-shadow: 0 2px 5px rgba(0,0,0,0.2);
                width: 32px;
                height: 32px;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .toggle-btn i {
                font-size: 1rem;
            }
            .admin-header {
                text-align: center;
                margin-bottom: 40px;
            }
            .admin-header h2 {
                color: var(--primary-color);
                font-weight: 700;
                font-size: 2.5rem;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
            }
            .data-table-container {
                background: var(--white);
                border-radius: 12px;
                padding: 24px;
                box-shadow: 0 4px 15px rgba(0,0,0,0.05);
                border: 1px solid rgba(0,0,0,0.05);
                transition: 0.3s ease;
            }
            .data-table-container:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 25px rgba(0,0,0,0.1);
                border-color: var(--primary-color);
            }
            .search-container {
                background: var(--white);
                padding: 20px;
                border-radius: 12px;
                box-shadow: 0 4px 15px rgba(0,0,0,0.05);
                margin-bottom: 30px;
                border: 1px solid rgba(0,0,0,0.05);
                transition: all 0.3s ease;
            }
            .search-container:hover {
                box-shadow: 0 8px 25px rgba(0,0,0,0.1);
                border-color: rgba(0,123,255,0.2);
            }
            .search-container .form-label {
                font-weight: 500;
                color: var(--text-color);
                margin-bottom: 8px;
                display: block;
                font-size: 0.9rem;
            }
            .search-container .form-control, .search-container .form-select {
                height: 45px;
                border-radius: 8px;
                border: 1px solid #e0e0e0;
                transition: all 0.3s ease;
                font-size: 0.95rem;
                padding: 0.5rem 1rem;
            }
            .search-container .form-control:focus, .search-container .form-select:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.2rem rgba(0,123,255,0.25);
            }
            .search-container .btn {
                height: 45px;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                font-weight: 500;
                transition: all 0.3s ease;
                padding: 0.5rem 1.25rem;
                font-size: 0.95rem;
                border-radius: 8px;
            }
            .search-container .btn i {
                margin-right: 8px;
                font-size: 1rem;
            }
            .search-container .btn-primary {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
            }
            .search-container .btn-primary:hover {
                background-color: var(--primary-dark);
                border-color: var(--primary-dark);
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(0,123,255,0.3);
            }
            .search-container .btn-outline-secondary {
                border: 1px solid #dee2e6;
                color: #6c757d;
            }
            .search-container .btn-outline-secondary:hover {
                background-color: #f8f9fa;
                border-color: #adb5bd;
                color: #495057;
                transform: translateY(-2px);
            }
            .table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 0;
            }
            .table th, .table td {
                padding: 15px;
                vertical-align: middle;
                border-bottom: 1px solid rgba(0,0,0,0.05);
            }
            .table th {
                background: var(--primary-light);
                color: var(--text-color);
                font-weight: 500;
                text-transform: uppercase;
                font-size: 0.875rem;
            }
            .table td {
                color: var(--text-color);
            }
            .action-buttons {
                display: flex;
                gap: 8px;
            } /* Reduced gap between action buttons */
            .action-btn {
                padding: 6px 12px;
                border-radius: 6px;
                text-decoration: none;
                color: var(--white);
                display: inline-flex;
                align-items: center;
                gap: 5px;
                transition: 0.3s ease;
                font-size: 13px;
            }
            .action-btn i {
                font-size: 13px;
            }
            .btn-edit {
                background: #ffc107;
                color: #212529;
            } /* Edit button */
            .btn-delete-skill {
                background: #dc3545;
            } /* Delete skill button (separate class) */
            .btn-edit:hover {
                background: #e0a800;
                transform: translateY(-2px);
            }
            .btn-delete-skill:hover {
                background: #c82333;
                transform: translateY(-2px);
            }
            .pagination .page-item.active .page-link {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
            }
            .pagination .page-link {
                color: var(--primary-color);
            }
            .pagination .page-link:hover {
                background-color: var(--primary-light);
                color: var(--primary-color);
            }
            .pagination .page-item.disabled .page-link {
                color: #6c757d;
                pointer-events: none;
                background-color: #fff;
                border-color: #dee2e6;
            }
            /* CSS for Add Skill Form */
            .add-skill-form {
                background: var(--white);
                padding: 20px;
                border-radius: 12px;
                box-shadow: 0 4px 15px rgba(0,0,0,0.05);
                margin-bottom: 30px;
                border: 1px solid rgba(0,0,0,0.05);
            }
            .add-skill-form h4 {
                color: var(--primary-color);
                margin-bottom: 20px;
            }

            /* Responsive CSS */
            @media (max-width: 768px) {
                .sidebar {
                    width: 200px;
                }
                .main-content {
                    margin-left: 0;
                }
                .toggle-btn {
                    left: 10px;
                }
                .data-table-container, .add-skill-form, .search-container {
                    padding: 15px;
                }
                .search-container .col-md-5, .search-container .col-md-4, .search-container .col-md-3 {
                    margin-bottom: 10px;
                }
                .search-container .btn {
                    width: 100%;
                }
            }
        </style>
    </head>
    <body>
        <!--[if lte IE 9]>
            <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="https://browsehappy.com/">upgrade your browser</a> to improve your experience and security.</p>
        <![endif]-->

        <%-- Sidebar Toggle Button --%>
        <button class="toggle-btn" onclick="toggleSidebar()">
            <i class="fa fa-bars"></i> <%-- Menu icon (hamburger) --%>
        </button>

        <%-- Sidebar --%>
        <div class="sidebar" id="sidebar">
            <div class="sidebar-header">
                <h3>Admin Page</h3>
            </div>
            <div class="sidebar-content">
                <%-- Menu items in sidebar, ${param.action} used to determine which item is active --%>
                <a href="admin?action=dashboard" class="menu-item ${param.action == 'dashboard' || empty param.action ? 'active' : ''}"><i class="fa fa-tachometer"></i> Dashboard</a>
                <a href="admin?action=jobseekers" class="menu-item ${param.action == 'jobseekers' ? 'active' : ''}"><i class="fa fa-users"></i> Manage Job Seekers</a>
                <a href="admin?action=recruiters" class="menu-item ${param.action == 'recruiters' ? 'active' : ''}"><i class="fa fa-user-md"></i> Manage Recruiters</a>
                <a href="admin?action=skills" class="menu-item ${param.action == 'skills' ? 'active' : ''}"><i class="fa fa-cogs"></i> Manage Skills</a>
                <%-- <a href="admin?action=companies" class="menu-item ${param.action == 'companies' ? 'active' : ''}"><i class="fa fa-building"></i> Manage Companies</a> --%>
                <a href="admin?action=settings" class="menu-item ${param.action == 'settings' ? 'active' : ''}"><i class="fa fa-cog"></i> Settings</a>
                <a href="logout.jsp" class="menu-item"><i class="fa fa-sign-out"></i> Logout</a>
            </div>
        </div>

        <%-- Main content of the page --%>
        <div class="main-content">
            <div class="admin-header">
                <div class="d-flex justify-content-between align-items-center" style="margin-left: 20px;">
                    <h2>Manage Skills <span class="badge bg-secondary">${totalSkills} total</span></h2>
                    <a href="admin?action=dashboard" class="btn btn-primary">Back to Dashboard</a>
                </div>
            </div>

            <%-- Display success or error messages from Controller (if any) --%>
            <c:if test="${not empty message}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <!-- Add New Skill Form -->
            <div class="add-skill-form mb-4">
                <h4>Add New Skill</h4>
                <form action="admin?action=addSkill" method="post"> <%-- Send data to 'addSkill' action via POST --%>
                    <div class="row g-3"> <%-- Use Bootstrap grid system --%>
                        <div class="col-md-4">
                            <label for="skillName" class="form-label">Skill Name <span class="text-danger">*</span></label> <%-- * indicates required field --%>
                            <input type="text" class="form-control" id="skillName" name="skillName" required>
                        </div>
                        <div class="col-md-4">
                            <label for="skillDescription" class="form-label">Description</label>
                            <input type="text" class="form-control" id="skillDescription" name="skillDescription">
                        </div>
                        <div class="col-md-2">
                            <label for="statusSkill" class="form-label">Status</label>
                            <select class="form-select" id="statusSkill" name="statusSkill">
                                <option value="1" selected>Active</option> <%-- Value 1 for Active --%>
                                <option value="0">Inactive</option> <%-- Value 0 for Inactive --%>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <label for="expertId" class="form-label">Expert ID</label>
                            <input type="number" class="form-control" id="expertId" name="expertId" placeholder="Optional">
                        </div>
                        <div class="col-12">
                            <button type="submit" class="btn btn-success">
                                <i class="fa fa-plus me-2"></i>Add Skill
                            </button>
                        </div>
                    </div>
                </form>
            </div>


            <%-- Container for data table and search box --%>
            <div class="data-table-container">
                <div class="search-container mb-4">
                    <form action="admin" method="get"> <%-- Search form, send via GET for friendly and bookmarkable URL --%>
                        <input type="hidden" name="action" value="skills"> <%-- Always send action=skills for controller to handle this page --%>
                        <div class="row g-3 align-items-end">
                            <div class="col-md-5">
                                <label for="searchKeyword" class="form-label">Search Skill Name</label>
                                <input type="text" id="searchKeyword" name="keyword" placeholder="Enter skill name..." class="form-control" value="${currentKeyword}"> <%-- Display the searched keyword again --%>
                            </div>
                            <%-- "Search By" box removed for simplicity, can be added back if needed --%>
                            <div class="col-md-4">
                                <label class="form-label d-block"> </label> <%-- Add empty label to align button --%>
                                <button type="submit" class="btn btn-primary w-auto">
                                    <i class="fa fa-search me-2"></i>Search
                                </button>
                                <a href="admin?action=skills" class="btn btn-outline-secondary w-auto ms-2"> <%-- Reset button, clears keyword and returns to first page --%>
                                    <i class="fa fa-refresh me-2"></i>Reset
                                </a>
                            </div>
                        </div>
                    </form>
                </div>

                <%-- Display message if no skills found and no other errors --%>
                <c:if test="${empty skillList && empty error}">
                    <div class="alert alert-info">
                        No skills found. Try adding new ones or adjusting your search keyword.
                    </div>
                </c:if>

                <%-- Only display table if there is skill data --%>
                <c:if test="${not empty skillList}">
                    <div class="table-responsive"> <%-- Helps table scroll horizontally on small screens --%>
                        <table class="table table-hover"> <%-- table-hover for hover effect on rows --%>
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Skill Name</th>
                                    <th>Description</th>
                                    <th>Status</th>
                                    <th>Expert ID</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%-- Loop through skill list to display each row --%>
                                <c:forEach var="skill" items="${skillList}">
                                    <tr>
                                        <td>${skill.skillSetId}</td>
                                        <td><c:out value="${skill.skillSetName}"/></td> <%-- Use c:out to prevent XSS --%>
                                        <td><c:out value="${skill.description}"/></td>
                                        <td>
                                            <%-- Display status with colored badge --%>
                                            <c:choose>
                                                <c:when test="${skill.statusSkill == 1}">
                                                    <span class="badge bg-success">Active</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-danger">Inactive</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${skill.expertId == 0 ? "-" : skill.expertId}</td> <%-- Display "-" if expertId is 0 (assume 0 means none) --%>
                                        <td>
                                            <div class="action-buttons">
                                                <%-- Edit button, navigates to 'editSkill' action with skill ID --%>
                                                <a href="admin?action=editSkill&id=${skill.skillSetId}" class="action-btn btn-edit">
                                                    <i class="fa fa-pencil"></i> Edit
                                                </a>
                                                <%-- Delete button, calls JavaScript confirmDeleteSkill function for confirmation before deleting --%>
                                                <a href="javascript:void(0);" onclick="confirmDeleteSkill('${skill.skillSetId}', '${skill.skillSetName}')" class="action-btn btn-delete-skill">
                                                    <i class="fa fa-trash"></i> Delete
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <!-- Pagination Section -->
                    <c:if test="${totalPages > 1}"> <%-- Only display pagination if there is more than 1 page --%>
                        <div class="pagination-container mt-4">
                            <div class="row mb-3 align-items-center">
                                <div class="col-md-4">
                                    <%-- Form to select number of items per page --%>
                                    <form action="admin" method="get" class="d-flex align-items-center">
                                        <input type="hidden" name="action" value="skills">
                                        <input type="hidden" name="keyword" value="${currentKeyword}"> <%-- Retain search keyword when changing page_size --%>
                                        <label for="itemsPerPage" class="form-label me-2 mb-0" style="white-space:nowrap;">Items per page:</label>
                                        <input type="number" id="itemsPerPage" name="pageSize" class="form-control form-control-sm" 
                                               min="1" max="100" <%-- Min and max limits for pageSize --%>
                                               value="${param.pageSize != null ? param.pageSize : '10'}" <%-- Display current or default pageSize --%>
                                               onchange="this.form.submit()" style="width: 70px;"> <%-- Auto-submit form on value change --%>
                                    </form>
                                </div>
                                <div class="col-md-8 text-md-end">
                                    <span class="text-muted">Page ${currentPage} of ${totalPages}</span> <%-- Current page / total pages info --%>
                                </div>
                            </div>
                            <nav aria-label="Page navigation">
                                <ul class="pagination justify-content-center">
                                    <%-- First page button --%>
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="admin?action=skills&page=1&pageSize=${param.pageSize != null ? param.pageSize : '10'}&keyword=${currentKeyword}" aria-label="First">
                                            <span aria-hidden="true">««</span>
                                        </a>
                                    </li>
                                    <%-- Previous page button --%>
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="admin?action=skills&page=${currentPage - 1}&pageSize=${param.pageSize != null ? param.pageSize : '10'}&keyword=${currentKeyword}" aria-label="Previous">
                                            <span aria-hidden="true">«</span>
                                        </a>
                                    </li>

                                    <%-- Logic to display page number buttons (e.g., show 2 pages before and 2 after current page) --%>
                                    <c:set var="startPage" value="${currentPage - 2}" />
                                    <c:set var="endPage" value="${currentPage + 2}" />

                                    <c:if test="${startPage < 1}"><c:set var="endPage" value="${endPage + (1 - startPage)}" /><c:set var="startPage" value="1" /></c:if>
                                    <c:if test="${endPage > totalPages}"><c:set var="startPage" value="${startPage - (endPage - totalPages) > 0 ? startPage - (endPage - totalPages) : 1}" /><c:set var="endPage" value="${totalPages}" /></c:if>

                                    <c:forEach begin="${startPage > 0 ? startPage : 1}" end="${endPage <= totalPages ? endPage : totalPages}" var="i">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}"> <%-- Mark current page as active --%>
                                            <a class="page-link" href="admin?action=skills&page=${i}&pageSize=${param.pageSize != null ? param.pageSize : '10'}&keyword=${currentKeyword}">${i}</a>
                                        </li>
                                    </c:forEach>

                                    <%-- Next page button --%>
                                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                        <a class="page-link" href="admin?action=skills&page=${currentPage + 1}&pageSize=${param.pageSize != null ? param.pageSize : '10'}&keyword=${currentKeyword}" aria-label="Next">
                                            <span aria-hidden="true">»</span>
                                        </a>
                                    </li>
                                    <%-- Last page button --%>
                                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                        <a class="page-link" href="admin?action=skills&page=${totalPages}&pageSize=${param.pageSize != null ? param.pageSize : '10'}&keyword=${currentKeyword}" aria-label="Last">
                                            <span aria-hidden="true">»»</span>
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </c:if> <%-- End of totalPages > 1 check --%>
                </c:if> <%-- End of not empty skillList check --%>
            </div> <%-- End of .data-table-container --%>
        </div> <%-- End of .main-content --%>

        <%-- Bootstrap JavaScript Link (needed for components like dismissible alerts) --%>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                                   // Function to toggle sidebar
                                                   function toggleSidebar() {
                                                       const sidebar = document.getElementById('sidebar');
                                                       sidebar.classList.toggle('active');
                                                       // Optional: Adjust main content margin if sidebar is "push" type
                                                       // const mainContent = document.querySelector('.main-content');
                                                       // mainContent.classList.toggle('active'); 
                                                   }

                                                   // Close sidebar when clicking outside (if sidebar is "overlay" type)
                                                   document.addEventListener('click', function (event) {
                                                       const sidebar = document.getElementById('sidebar');
                                                       const toggleBtn = document.querySelector('.toggle-btn');
                                                       // Check if sidebar is active and click is not within sidebar or toggle button
                                                       if (sidebar.classList.contains('active') && !sidebar.contains(event.target) && !toggleBtn.contains(event.target)) {
                                                           sidebar.classList.remove('active');
                                                       }
                                                   });

                                                   // Function to confirm before deleting a skill
                                                   function confirmDeleteSkill(id, skillName) {
                                                       // Display browser's confirm dialog
                                                       if (confirm('Are you sure you want to delete the skill "' + skillName + '" (ID: ' + id + ')? This action cannot be undone.')) {
                                                           // If user confirms, redirect to delete action
                                                           window.location.href = 'admin?action=deleteSkill&id=' + id;
                                                       }
                                                   }

                                                   // Optional: Handle Enter key press in search input
                                                   const searchKeywordInput = document.getElementById('searchKeyword');
                                                   if (searchKeywordInput) { // Check if element exists
                                                       searchKeywordInput.addEventListener('keyup', function (event) {
                                                           if (event.key === 'Enter') {
                                                               event.preventDefault(); // Prevent default form behavior (if not a GET form)
                                                               this.form.submit();    // Submit form
                                                           }
                                                       });
                                                   }


                                                   // Optional: Remove message/error parameters from URL after display (for a cleaner URL)
                                                   // Be careful with this if you rely on these parameters for other logic after reload.
                                                   /*
                                                    if (window.history.replaceState) {
                                                    const url = new URL(window.location.href);
                                                    url.searchParams.delete('message');
                                                    url.searchParams.delete('error');
                                                    window.history.replaceState({ path: url.href }, '', url.href);
                                                    }
                                                    */
        </script>
    </body>
</html>