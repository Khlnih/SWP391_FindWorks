<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="no-js" lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Admin Dashboard</title>
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
        .sidebar.active ~ .toggle-btn {
            transform: translateX(250px);
        }

        .toggle-btn:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
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

        /* Stats Cards Styles */
        .admin-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 24px;
            padding: 20px;
        }

        .stat-card {
            padding: 24px;
            background: var(--white);
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            text-align: center;
            transition: 0.3s ease;
            border: 1px solid rgba(0, 0, 0, 0.05);
        }

        .stat-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            border-color: var(--primary-color);
        }

        .stat-icon {
            font-size: 28px;
            color: var(--primary-color);
            margin-bottom: 15px;
            position: relative;
        }

        .stat-icon i {
            width: 50px;
            height: 50px;
            line-height: 50px;
            text-align: center;
            border-radius: 50%;
            background: var(--primary-light);
            position: relative;
            z-index: 1;
        }

        .stat-icon::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 60px;
            height: 60px;
            background: var(--primary-color);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            opacity: 0.1;
            z-index: 0;
        }

        .stat-card h3 {
            color: var(--text-color);
            margin: 0 0 12px 0;
            font-size: 1.2rem;
            font-weight: 500;
        }

        .stat-card p {
            color: var(--primary-color);
            font-size: 2.2rem;
            font-weight: 700;
            margin: 0;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .main-content {
                padding: 20px;
            }

            .admin-header h2 {
                font-size: 2rem;
            }

            .stat-card {
                padding: 20px;
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
            <a href="Admin_jobseekersController?action=dashboard" class="menu-item active">
                <i class="fas fa-chart-line"></i>
                Dashboard
            </a>
            <a href="Admin_jobseekersController?action=jobseekers" class="menu-item">
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
            <h2>Admin Dashboard</h2>
        </div>
        
        <div class="breadcrumb-section">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item active" aria-current="page">
                        <i class="fas fa-home"></i> Dashboard
                    </li>
                </ol>
            </nav>
        </div>
        
        <div class="admin-section">
            <h3>Quick Stats</h3>
            <div class="admin-stats">
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-briefcase-medical"></i>
                    </div>
                    <h3>Total Jobs</h3>
                    <p>120</p>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-user-tie"></i>
                    </div>
                    <h3>Total Candidates</h3>
                    <p>350</p>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-building-columns"></i>
                    </div>
                    <h3>Total Companies</h3>
                    <p>45</p>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-file-contract"></i>
                    </div>
                    <h3>New Applications</h3>
                    <p>25</p>
                </div>
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
