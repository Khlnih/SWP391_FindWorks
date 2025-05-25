<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html class="no-js" lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Manage Jobseekers - Admin Panel</title>
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
        }

        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            overflow-x: hidden;
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
            min-height: 100vh;
        }

        /* Sidebar Styles */
        .sidebar {
            width: 250px;
            height: 100vh;
            position: fixed;
            left: -250px;
            background: var(--white);
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            transition: 0.3s ease;
            z-index: 1000;
            overflow-y: auto;
        }

        .sidebar.active {
            left: 0;
        }

        .sidebar-header {
            padding: 20px 50px;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
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

        /* Main Content Styles */
        .main-content {
            margin-left: 0;
            padding: 30px;
            background: rgba(255, 255, 255, 0.95);
            transition: 0.3s ease;
            min-height: 100vh;
        }

        .sidebar.active ~ .main-content {
            margin-left: 250px;
        }

        /* Toggle Button */
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
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
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
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
        }

        /* Jobseeker Table Styles */
        .jobseeker-table {
            background: var(--white);
            border-radius: 12px;
            padding: 24px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            border: 1px solid rgba(0, 0, 0, 0.05);
            transition: 0.3s ease;
        }

        .jobseeker-table:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            border-color: var(--primary-color);
        }

        .search-box {
            margin-bottom: 30px;
            background: var(--white);
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .search-box input {
            width: 100%;
            padding: 12px;
            border: 1px solid rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            font-size: 14px;
            background: transparent;
            color: var(--text-color);
            transition: 0.3s ease;
        }

        .search-box input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px var(--primary-light);
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 0;
        }

        .table th,
        .table td {
            padding: 15px;
            vertical-align: middle;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
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

        .user-avatar {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 15px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .status-badge {
            padding: 5px 12px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: 500;
            display: inline-block;
        }

        .status-badge.active {
            background-color: #28a745;
            color: var(--white);
        }

        .status-badge.inactive {
            background-color: #dc3545;
            color: var(--white);
        }

        .action-buttons {
            display: flex;
            gap: 10px;
        }

        .action-btn {
            padding: 8px 15px;
            border-radius: 8px;
            text-decoration: none;
            color: var(--white);
            display: flex;
            align-items: center;
            gap: 5px;
            transition: 0.3s ease;
            font-size: 14px;
        }

        .action-btn i {
            font-size: 14px;
        }

        .btn-view {
            background: var(--primary-color);
        }

        .btn-edit {
            background: #ffc107;
            color: #000;
        }

        .btn-delete {
            background: #dc3545;
        }

        .btn-view:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
        }

        .btn-edit:hover {
            background: #e0a800;
            transform: translateY(-2px);
        }

        .btn-delete:hover {
            background: #c82333;
            transform: translateY(-2px);
        }

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

            .jobseeker-table {
                padding: 20px;
            }

            .search-box {
                margin-bottom: 20px;
            }
        }
    </style>
</head>
<body>
    <!--[if lte IE 9]>
        <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="https://browsehappy.com/">upgrade your browser</a> to improve your experience and security.</p>
    <![endif]-->

    <button class="toggle-btn" onclick="toggleSidebar()">
        <i class="fas fa-bars"></i>
    </button>

    <div class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <h3>Admin Panel</h3>
        </div>
        <div class="sidebar-content">
            <a href="Admin_jobseekersController?action=dashboard" class="menu-item">
                <i class="fas fa-chart-line"></i>
                Dashboard
            </a>
            <a href="Admin_jobseekersController?action=jobseekers" class="menu-item active">
                <i class="fas fa-user-tie"></i>
                Manage Jobseekers
            </a>
            <a href="Admin_jobseekersController?action=jobs" class="menu-item">
                <i class="fas fa-briefcase-medical"></i>
                Manage Jobs
            </a>
            <a href="Admin_jobseekersController?action=companies" class="menu-item">
                <i class="fas fa-building-columns"></i>
                Manage Companies
            </a>
            <a href="Admin_jobseekersController?action=settings" class="menu-item">
                <i class="fas fa-gear"></i>
                Settings
            </a>
            <a href="logout.jsp" class="menu-item">
                <i class="fas fa-right-from-bracket"></i>
                Logout
            </a>
        </div>
    </div>

    <div class="main-content">
        <div class="admin-header">
            <div class="d-flex justify-content-between align-items-center" style="margin-left: 20px;">
                <h2>Manage Jobseekers</h2>
                <a href="admin.jsp" class="btn btn-primary">Back to Dashboard</a>
            </div>
        </div>

        <div class="jobseeker-table">
            <div class="search-box">
                <input type="text" id="searchInput" placeholder="Search jobseekers..." class="form-control">
                <button type="button" class="btn btn-primary" onclick="searchJobseekers()">
                    <i class="fas fa-search"></i>
                </button>
            </div>
            
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    ${error}
                </div>
            </c:if>
            
            <c:if test="${empty jobseekers}">
                <div class="alert alert-info">
                    No jobseekers found
                </div>
            </c:if>
            
            <c:if test="${not empty jobseekers}">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Avatar</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Gender</th>
                            <th>DOB</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="jobseeker" items="${jobseekers}">
                            <tr>
                                <td>
                                    <img src="${jobseeker.image}" alt="Avatar" class="user-avatar">
                                </td>
                                <td>${jobseeker.firstName} ${jobseeker.lastName}</td>
                                <td>${jobseeker.email__contact}</td>
                                <td>${jobseeker.phone_contact}</td>
                                <td>
                                    <span class="badge ${jobseeker.gender ? 'badge-info' : 'badge-warning'}">
                                        ${jobseeker.gender ? 'Male' : 'Female'}
                                    </span>
                                </td>
                                <td>${jobseeker.dob}</td>
                                <td>
                                    <span class="badge ${jobseeker.status == 'active' ? 'badge-success' : 'badge-danger'}">
                                        ${jobseeker.status}
                                    </span>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <a href="Admin_jobseekersController?action=view&id=${jobseeker.freelanceID}" class="action-btn btn-view">
                                            <i class="fas fa-eye"></i> View
                                        </a>
                                        <a href="Admin_jobseekersController?action=edit&id=${jobseeker.freelanceID}" class="action-btn btn-edit">
                                            <i class="fas fa-edit"></i> Edit
                                        </a>
                                        <a href="#" class="action-btn btn-delete" onclick="confirmDelete(${jobseeker.freelanceID})">
                                            <i class="fas fa-trash"></i> Delete
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </div>
    </div>

    <script>
        function confirmDelete(id) {
            if (confirm('Are you sure you want to delete this jobseeker?')) {
                window.location.href = 'Admin_jobseekersController?action=delete&id=' + id;
            }
        }

        function searchJobseekers() {
            const searchInput = document.getElementById('searchInput').value;
            window.location.href = 'Admin_jobseekersController?action=search&keyword=' + searchInput;
        }
    </script>

    <script>
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            const content = document.querySelector('.main-content');
            sidebar.classList.toggle('active');
            content.classList.toggle('sidebar-active');
        }

        document.getElementById('searchInput').addEventListener('keyup', function() {
            const searchValue = this.value.toLowerCase();
            const rows = document.getElementsByTagName('tr');
            
            for (let i = 1; i < rows.length; i++) {
                const name = rows[i].getElementsByTagName('td')[1].textContent.toLowerCase();
                const email = rows[i].getElementsByTagName('td')[2].textContent.toLowerCase();
                
                if (name.includes(searchValue) || email.includes(searchValue)) {
                    rows[i].style.display = '';
                } else {
                    rows[i].style.display = 'none';
                }
            }
        });
    </script>
</body>
</html>
