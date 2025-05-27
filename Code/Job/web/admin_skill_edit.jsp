<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> <%-- JSTL Core library declaration --%>
<%@page import="Model.SkillSet"%> <%-- Import SkillSet Model class --%>

<%--
    This page expects a 'skillToEdit' attribute (SkillSet object) in the request scope.
    This attribute should be set by a servlet before forwarding to this page.
    Example (in Servlet):
    int skillId = Integer.parseInt(request.getParameter("id"));
    SkillDAO skillDAO = new SkillDAO();
    SkillSet skill = skillDAO.getSkillById(skillId);
    if (skill != null) {
        request.setAttribute("skillToEdit", skill);
        request.getRequestDispatcher("admin_skill_edit.jsp").forward(request, response);
    } else {
        // Handle skill not found, e.g., redirect back with an error message
        response.sendRedirect("admin?action=skills&error=Skill+not+found");
    }
--%>

<!DOCTYPE html>
<html class="no-js" lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Edit Skill - Admin Page</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSS Links (assuming these CSS files exist and paths are correct) -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/themify-icons.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/responsive.css">
    <style>
        :root {
            --primary-color: #ffc107; /* Yellow for edit actions, or stick to blue: #007bff */
            --primary-dark: #e0a800;  /* Darker yellow, or #0056b3 for blue */
            --primary-light: rgba(255, 193, 7, 0.1); /* Light yellow, or rgba(0, 123, 255, 0.1) for blue */
            --text-color: #2d3436;
            --white: #ffffff;
            --success-color: #28a745;
            --danger-color: #dc3545;
        }
        body { font-family: 'Poppins', sans-serif; margin: 0; padding: 0; overflow-x: hidden; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; } /* Different gradient for edit page */
        .sidebar { width: 250px; height: 100vh; position: fixed; left: -250px; background: var(--white); box-shadow: 0 0 20px rgba(0,0,0,0.1); transition: 0.3s ease; z-index: 1000; overflow-y: auto; }
        .sidebar.active { left: 0; }
        .sidebar-header { padding: 20px 50px; border-bottom: 1px solid rgba(0,0,0,0.1); position: relative; z-index: 1002;}
        .sidebar-header h3 { margin: 0; color: var(--text-color); font-size: 1.5rem; position: relative; z-index: 1002; }
        .sidebar-content { padding: 20px; }
        .menu-item { display: flex; align-items: center; padding: 10px 15px; margin: 5px 0; color: var(--text-color); text-decoration: none; border-radius: 5px; transition: 0.3s ease; }
        .menu-item i { margin-right: 10px; font-size: 1.2rem; }
        .menu-item:hover { background: var(--primary-light); color: var(--primary-color); }
        .menu-item.active { background: var(--primary-color); color: var(--white); } /* This needs to be based on main page, not edit action */
        .main-content { margin-left: 0; padding: 30px; background: rgba(255,255,255,0.95); transition: 0.3s ease; min-height: 100vh; }
        .sidebar.active ~ .main-content { margin-left: 250px; }
        .toggle-btn { position: fixed; top: 20px; left: 10px; background: var(--primary-color); color: var(--white); border: none; padding: 10px; border-radius: 50%; cursor: pointer; z-index: 1001; box-shadow: 0 2px 5px rgba(0,0,0,0.2); width: 32px; height: 32px; display: flex; align-items: center; justify-content: center; }
        .toggle-btn i { font-size: 1rem; }
        .admin-header { text-align: center; margin-bottom: 30px; } /* Reduced margin */
        .admin-header h2 { color: var(--text-color); font-weight: 700; font-size: 2.2rem; }
        .edit-skill-form-container { background: var(--white); border-radius: 12px; padding: 30px; box-shadow: 0 6px 20px rgba(0,0,0,0.08); border: 1px solid rgba(0,0,0,0.05); max-width: 700px; margin: 0 auto; }
        .edit-skill-form-container .form-label { font-weight: 500; color: var(--text-color); margin-bottom: 8px; display: block; font-size: 0.9rem; }
        .edit-skill-form-container .form-control, .edit-skill-form-container .form-select { height: 45px; border-radius: 8px; border: 1px solid #e0e0e0; transition: all 0.3s ease; font-size: 0.95rem; padding: 0.5rem 1rem; }
        .edit-skill-form-container .form-control:focus, .edit-skill-form-container .form-select:focus { border-color: var(--primary-color); box-shadow: 0 0 0 0.2rem var(--primary-light); }
        .edit-skill-form-container .btn { height: 45px; display: inline-flex; align-items: center; justify-content: center; font-weight: 500; transition: all 0.3s ease; padding: 0.5rem 1.5rem; font-size: 0.95rem; border-radius: 8px; }
        .edit-skill-form-container .btn i { margin-right: 8px; font-size: 1rem; }
        .btn-submit-update { background-color: var(--success-color); border-color: var(--success-color); color: var(--white); }
        .btn-submit-update:hover { background-color: #1e7e34; border-color: #1c7430; transform: translateY(-2px); }
        .btn-cancel { background-color: #6c757d; border-color: #6c757d; color: var(--white); }
        .btn-cancel:hover { background-color: #5a6268; border-color: #545b62; }
        .form-actions { margin-top: 25px; display: flex; justify-content: flex-end; gap: 10px; }

        @media (max-width: 768px) {
            .sidebar { width: 200px; }
            .main-content { margin-left: 0; }
            .toggle-btn { left: 10px; }
            .edit-skill-form-container { padding: 20px; }
        }
    </style>
</head>
<body>
    <!--[if lte IE 9]>
        <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="https://browsehappy.com/">upgrade your browser</a> to improve your experience and security.</p>
    <![endif]-->

    <button class="toggle-btn" onclick="toggleSidebar()">
        <i class="fa fa-bars"></i>
    </button>

    <div class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <h3>Admin Page</h3>
        </div>
        <div class="sidebar-content">
            <a href="admin?action=dashboard" class="menu-item ${param.action == 'dashboard' || empty param.action ? 'active' : ''}"><i class="fa fa-tachometer"></i> Dashboard</a>
            <a href="admin?action=jobseekers" class="menu-item ${param.action == 'jobseekers' ? 'active' : ''}"><i class="fa fa-users"></i> Manage Job Seekers</a>
            <a href="admin?action=recruiters" class="menu-item ${param.action == 'recruiters' ? 'active' : ''}"><i class="fa fa-user-md"></i> Manage Recruiters</a>
            <a href="admin?action=skills" class="menu-item active"><i class="fa fa-cogs"></i> Manage Skills</a> <%-- Keep 'Manage Skills' active --%>
            <a href="admin?action=settings" class="menu-item ${param.action == 'settings' ? 'active' : ''}"><i class="fa fa-cog"></i> Settings</a>
            <a href="logout.jsp" class="menu-item"><i class="fa fa-sign-out"></i> Logout</a>
        </div>
    </div>

    <div class="main-content">
        <div class="admin-header">
             <div class="d-flex justify-content-between align-items-center" style="margin-left: 20px;">
                <h2>Edit Skill</h2>
                <a href="admin?action=skills" class="btn btn-secondary">
                    <i class="fa fa-arrow-left me-2"></i>Back to Skills List
                </a>
            </div>
        </div>

        <%-- Display success or error messages from servlet (after update attempt or if skill not found) --%>
        <c:if test="${not empty requestScope.message}">
            <div class="alert alert-success alert-dismissible fade show col-md-8 offset-md-2" role="alert">
                ${requestScope.message}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        <c:if test="${not empty requestScope.error}">
            <div class="alert alert-danger alert-dismissible fade show col-md-8 offset-md-2" role="alert">
                ${requestScope.error}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <c:choose>
            <c:when test="${not empty skillToEdit}">
                <div class="edit-skill-form-container">
                    <form action="admin" method="post">
                        <input type="hidden" name="action" value="updateSkill">
                        <input type="hidden" name="skillSetId" value="${skillToEdit.skillSetId}">

                        <div class="mb-3">
                            <label for="skillName" class="form-label">Skill Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="skillName" name="skillName" value="<c:out value='${skillToEdit.skillSetName}'/>" required>
                        </div>

                        <div class="mb-3">
                            <label for="skillDescription" class="form-label">Description</label>
                            <input type="text" class="form-control" id="skillDescription" name="skillDescription" value="<c:out value='${skillToEdit.description}'/>">
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="statusSkill" class="form-label">Status</label>
                                <select class="form-select" id="statusSkill" name="statusSkill">
                                    <option value="1" ${skillToEdit.statusSkill == 1 ? 'selected' : ''}>Active</option>
                                    <option value="0" ${skillToEdit.statusSkill == 0 ? 'selected' : ''}>Inactive</option>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="expertId" class="form-label">Expert ID</label>
                                <input type="number" class="form-control" id="expertId" name="expertId" value="${skillToEdit.expertId == 0 ? '' : skillToEdit.expertId}" placeholder="Optional">
                            </div>
                        </div>

                        <div class="form-actions">
                             <a href="admin?action=skills" class="btn btn-cancel">
                                <i class="fa fa-times me-1"></i>Cancel
                            </a>
                            <button type="submit" class="btn btn-submit-update">
                                <i class="fa fa-check me-1"></i>Update Skill
                            </button>
                        </div>
                    </form>
                </div>
            </c:when>
            <c:otherwise>
                <%-- This part is shown if 'skillToEdit' is not found in request,
                     usually means an error occurred before forwarding or direct access without ID.
                     The servlet should ideally set an error message.
                --%>
                <c:if test="${empty requestScope.error}"> <%-- Show a generic error if no specific error was set --%>
                    <div class="alert alert-warning col-md-8 offset-md-2" role="alert">
                        Skill details are not available. Please go back to the <a href="admin?action=skills" class="alert-link">skills list</a> and try again.
                    </div>
                </c:if>
            </c:otherwise>
        </c:choose>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            sidebar.classList.toggle('active');
        }

        document.addEventListener('click', function(event) {
            const sidebar = document.getElementById('sidebar');
            const toggleBtn = document.querySelector('.toggle-btn');
            if (sidebar.classList.contains('active') && !sidebar.contains(event.target) && !toggleBtn.contains(event.target)) {
                sidebar.classList.remove('active');
            }
        });

        // Optional: Clear message/error from URL
        /*
        if (window.history.replaceState) {
            const url = new URL(window.location.href);
            url.searchParams.delete('message'); // if you pass it via URL for some reason
            url.searchParams.delete('error');   // if you pass it via URL for some reason
            // Better to use requestScope attributes for messages on forward
            // For redirects, use session attributes then remove them after display
            // window.history.replaceState({ path: url.href }, '', url.href);
        }
        */
    </script>
</body>
</html>