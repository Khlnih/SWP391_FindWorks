<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            padding: 20px;
            background: var(--primary-color);
            color: var(--white);
            text-align: center;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        }

        .sidebar-header h3 {
            font-size: 1.5rem;
            font-weight: 600;
            margin: 0;
        }

        .sidebar-content {
            padding: 20px;
        }

        .menu-item {
            padding: 12px 20px;
            color: var(--text-color);
            text-decoration: none;
            display: flex;
            align-items: center;
            transition: 0.3s ease;
            border-radius: 8px;
            margin-bottom: 8px;
        }

        .menu-item:hover {
            background: var(--primary-light);
            color: var(--primary-color);
        }

        .menu-item.active {
            background: var(--primary-color);
            color: var(--white);
            position: relative;
        }

        .menu-item.active::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            height: 100%;
            width: 3px;
            background: var(--white);
            border-radius: 4px 0 0 4px;
        }

        .menu-item i {
            margin-right: 12px;
            width: 20px;
            text-align: center;
        }

        /* Main Content Styles */
        .main-content {
            margin-left: 0;
            padding: 30px;
            background: rgba(255, 255, 255, 0.95);
            transition: 0.3s ease;
            min-height: 100vh;
        }

        /* Breadcrumb Styles */
        .breadcrumb-section {
            margin-bottom: 30px;
        }

        .breadcrumb {
            background: transparent;
            padding: 0;
            margin: 0;
        }

        .breadcrumb-item {
            font-size: 0.9rem;
            color: var(--text-color);
        }

        .breadcrumb-item a {
            color: var(--primary-color);
            text-decoration: none;
            transition: 0.3s ease;
        }

        .breadcrumb-item a:hover {
            color: var(--primary-dark);
        }

        .breadcrumb-item a i {
            margin-right: 5px;
        }

        .breadcrumb-item.active {
            color: var(--text-color);
            opacity: 0.7;
        }

        .sidebar.active ~ .main-content {
            margin-left: 250px;
        }

        .toggle-btn {
            padding: 12px 20px;
            background: var(--primary-color);
            color: var(--white);
            border: none;
            border-radius: 8px;
            cursor: pointer;
            position: fixed;
            top: 20px;
            left: 20px;
            z-index: 1002;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            transition: 0.3s ease;
            transform: translateX(0);
        }

        .toggle-btn:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
        }

        .sidebar.active ~ .toggle-btn {
            transform: translateX(250px);
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

        /* Jobseekers Table Styles */
        .jobseekers-table {
            background: var(--white);
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            overflow: hidden;
        }

        .table {
            margin-bottom: 0;
        }

        .table th {
            background: var(--primary-color);
            color: var(--white);
            font-weight: 600;
            text-align: center;
        }

        .table td {
            vertical-align: middle;
            padding: 15px;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
        }

        .user-name {
            font-weight: 500;
            color: var(--text-color);
        }

        .user-email {
            color: var(--primary-color);
            font-size: 0.9rem;
        }

        .status-badge {
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .status-active {
            background: #28a745;
            color: white;
        }

        .status-inactive {
            background: #dc3545;
            color: white;
        }

        .action-btn {
            padding: 5px 10px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            margin-right: 5px;
        }

        .btn-view {
            background: var(--primary-color);
            color: var(--white);
        }

        .btn-edit {
            background: #ffc107;
            color: var(--text-color);
        }

        .btn-delete {
            background: #dc3545;
            color: var(--white);
        }

        @media (max-width: 768px) {
            .main-content {
                padding: 20px;
            }

            .admin-header h2 {
                font-size: 2rem;
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
            <a href="admin.jsp" class="menu-item">
                <i class="fas fa-chart-line"></i>
                Dashboard
            </a>
            <a href="admin_jobseeker.jsp" class="menu-item active">
                <i class="fas fa-user-tie"></i>
                Manage Jobseekers
            </a>
            <a href="admin_jobs.jsp" class="menu-item">
                <i class="fas fa-briefcase-medical"></i>
                Manage Jobs
            </a>
            <a href="admin_companies.jsp" class="menu-item">
                <i class="fas fa-building-columns"></i>
                Manage Companies
            </a>
            <a href="admin_settings.jsp" class="menu-item">
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
            <h2>Manage Jobseekers</h2>
        </div>
        
        <div class="breadcrumb-section">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item">
                        <a href="admin.jsp">
                            <%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lý Jobseeker</title>
        <style>
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: left;
            }
            th {
                background-color: #4CAF50;
                color: white;
            }
            tr:nth-child(even) {
                background-color: #f2f2f2;
            }
            .search-box {
                margin: 20px 0;
                padding: 10px;
                background-color: #f9f9f9;
                border-radius: 5px;
            }
            .search-box input[type="text"] {
                width: 300px;
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            .search-box button {
                padding: 8px 16px;
                background-color: #4CAF50;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
            .search-box button:hover {
                background-color: #45a049;
            }
        </style>
    </head>
    <body>
        <h1>Quản lý Jobseeker</h1>
        
        <!-- Form tìm kiếm -->
        <div class="search-box">
            <form action="jobseeker" method="GET">
                <input type="hidden" name="action" value="search">
                <input type="text" name="keyword" placeholder="Tìm kiếm..." value="${keyword}">
                <button type="submit">Tìm kiếm</button>
            </form>
        </div>

        <!-- Hiển thị danh sách jobseeker -->
        <table>
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Họ tên</th>
                <th>Giới tính</th>
                <th>Ngày sinh</th>
                <th>Email</th>
                <th>Số điện thoại</th>
                <th>Trạng thái</th>
                <th>Chi tiết</th>
            </tr>
            <c:forEach items="${jobseekers}" var="j">
                <tr>
                    <td>${j.freelanceID}</td>
                    <td>${j.username}</td>
                    <td>${j.firstName} ${j.lastName}</td>
                    <td>${j.gender ? 'Nam' : 'Nữ'}</td>
                    <td>${j.dob}</td>
                    <td>${j.emailContact}</td>
                    <td>${j.phoneContact}</td>
                    <td>${j.status}</td>
                    <td>
                        <a href="jobseeker?action=view&id=${j.freelanceID}">Xem chi tiết</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </body>
</html>                    <div class="user-name">John Doe</div>
                                <div class="user-email">john.doe@example.com</div>
                            </td>
                            <td>+1 234 567 890</td>
                            <td>New York, USA</td>
                            <td>
                                <span class="status-badge status-active">Active</span>
                            </td>
                            <td>
                                <button class="action-btn btn-view">
                                    <i class="fas fa-eye"></i>
                                </button>
                                <button class="action-btn btn-edit">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button class="action-btn btn-delete">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </td>
                        </tr>
                        <!-- Add more rows as needed -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <script>
        function toggleSidebar() {
            document.getElementById('sidebar').classList.toggle('active');
        }
    </script>
</body>
</html>
