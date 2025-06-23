<%@page import="Model.Jobseeker"%>
<%@page import="Model.UserLoginInfo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ sơ của tôi - FindWorks</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Modern CSS Reset */
        *, *::before, *::after {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        /* Smooth Scrolling */
        html {
            scroll-behavior: smooth;
        }
        
        /* Base Typography */
        :root {
            /* Light blue color palette */
            --primary: #3b82f6;
            --primary-light: #dbeafe;
            --primary-lighter: #eff6ff;
            --primary-dark: #2563eb;
            --primary-darker: #1d4ed8;
            --secondary: #64748b;
            --success: #10b981;
            --info: #0ea5e9;
            --warning: #f59e0b;
            --danger: #ef4444;
            --light: #f8fafc;
            --dark: #0f172a;
            
            /* Grayscale */
            --gray-50: #f8fafc;
            --gray-100: #f1f5f9;
            --gray-200: #e2e8f0;
            --gray-300: #cbd5e1;
            --gray-400: #94a3b8;
            --gray-500: #64748b;
            --gray-600: #475569;
            --gray-700: #334155;
            --gray-800: #1e293b;
            --gray-900: #0f172a;
            
            /* Gradients */
            --gradient: linear-gradient(135deg, #3b82f6 0%, #60a5fa 100%);
            --gradient-subtle: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
            --gradient-light: linear-gradient(135deg, #f8fafc 0%, #f0f9ff 100%);
            
            /* Shadows */
            --shadow-xs: 0 1px 2px 0 rgb(0 0 0 / 0.05);
            --shadow-sm: 0 1px 3px 0 rgb(0 0 0 / 0.1), 0 1px 2px -1px rgb(0 0 0 / 0.1);
            --shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
            --shadow-md: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
            --shadow-lg: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
            --shadow-xl: 0 25px 50px -12px rgb(0 0 0 / 0.25);
            --shadow-2xl: 0 25px 50px -12px rgb(0 0 0 / 0.25);
            
            /* Border radius */
            --radius-sm: 0.25rem;
            --radius: 0.5rem;
            --radius-md: 0.75rem;
            --radius-lg: 1rem;
            --radius-xl: 1.5rem;
            --radius-2xl: 2rem;
            --radius-full: 9999px;
            
            /* Transitions */
            --transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
            --transition-slow: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            --transition-fast: all 0.15s cubic-bezier(0.4, 0, 0.2, 1);
            
            /* Typography */
            --font-sans: 'Inter', system-ui, -apple-system, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
            --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            --shadow-md: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            --shadow-lg: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            --shadow-xl: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            --border-radius: 0.5rem;
            --border-radius-lg: 0.75rem;
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            
            --font-sans: 'Segoe UI', system-ui, -apple-system, Roboto, 'Helvetica Neue', Arial, sans-serif;
            --shadow-sm: 0 .125rem .25rem rgba(0,0,0,.075);
            --shadow: 0 .5rem 1rem rgba(0,0,0,.15);
            --shadow-lg: 0 1rem 3rem rgba(0,0,0,.175);
            --border-radius: 0.35rem;
            --transition: all 0.3s ease;
        }
        
        /* Base Styles */
        
        body {
            font-family: var(--font-sans);
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
            background-color: var(--gray-50);
            color: var(--gray-700);
            line-height: 1.6;
            font-size: 1rem;
            font-weight: 400;
            text-rendering: optimizeLegibility;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }
        
        @supports (font-variation-settings: normal) {
            body {
                font-family: 'Inter var', 'Inter', sans-serif;
            }
        }
        
        /* Typography */
        h1, h2, h3, h4, h5, h6 {
            font-weight: 700;
            line-height: 1.3;
            color: var(--gray-900);
            margin-bottom: 1rem;
        }
        
        h1 { font-size: 2rem; }
        h2 { font-size: 1.75rem; }
        h3 { font-size: 1.5rem; }
        h4 { font-size: 1.25rem; }
        h5 { font-size: 1.1rem; }
        h6 { font-size: 1rem; }
        
        /* Layout */
        .container {
            width: 100%;
            padding-right: 15px;
            padding-left: 15px;
            margin-right: auto;
            margin-left: auto;
        }
        
        @media (min-width: 1200px) {
            .container {
                max-width: 1140px;
            }
        }
        
        /* Cards */
        .card {
            position: relative;
            display: flex;
            flex-direction: column;
            min-width: 0;
            word-wrap: break-word;
            background-color: #fff;
            background-clip: border-box;
            border: 1px solid var(--gray-200);
            border-radius: var(--radius);
            box-shadow: var(--shadow-sm);
            transition: var(--transition);
            margin-bottom: 1rem;
            overflow: hidden;
            background: white;
        }
        
        .card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-md);
            border-color: var(--primary-light);
            z-index: 1;
        }
        
        .card:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
        }
        
        .card:hover {
            box-shadow: var(--shadow);
            transform: translateY(-2px);
        }
        
        .card-header {
            padding: 0.5rem 1rem;
            margin-bottom: 0;
            background-color: #fff;
            border-bottom: 1px solid var(--gray-100);
            border-top-left-radius: var(--radius) !important;
            border-top-right-radius: var(--radius) !important;
            position: relative;
            z-index: 1;
            background: var(--gradient-light);
            border-left: 3px solid var(--primary);
        }
        
        .card-header h6 {
            font-size: 0.875rem;
            font-weight: 600;
            color: var(--gray-800);
            margin: 0;
            display: flex;
            align-items: center;
            letter-spacing: 0.3px;
        }
        
        .card-header h6 i {
            margin-right: 0.5rem;
            color: var(--primary);
        }
        
        .card-body {
            flex: 1 1 auto;
            min-height: 1px;
            padding: 1rem;
            color: var(--gray-700);
            font-size: 0.875rem;
        }
        
        /* Buttons */
        .btn {
            display: inline-block;
            font-weight: 500;
            color: #212529;
            text-align: center;
            vertical-align: middle;
            user-select: none;
            background-color: transparent;
            border: 1px solid transparent;
            padding: 0.375rem 0.75rem;
            font-size: 0.875rem;
            line-height: 1.5;
            border-radius: 0.25rem;
            transition: var(--transition);
        }
        
        .btn {
            font-weight: 500;
            padding: 0.625rem 1.25rem;
            border-radius: var(--radius);
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            font-size: 0.9375rem;
            line-height: 1.5;
            position: relative;
            overflow: hidden;
            border: 1px solid transparent;
            cursor: pointer;
            text-decoration: none;
        }
        
        .btn-sm {
            padding: 0.4rem 0.8rem;
            font-size: 0.875rem;
            line-height: 1.25;
        }
        
        .btn i {
            font-size: 0.9em;
        }
        
        .btn-primary {
            color: white;
            background: var(--gradient);
            border: none;
            box-shadow: var(--shadow-sm);
            position: relative;
            overflow: hidden;
            z-index: 1;
            font-weight: 600;
            letter-spacing: 0.3px;
        }
        
        .btn-primary:hover {
            transform: translateY(-1px);
            box-shadow: var(--shadow);
            color: white;
        }
        
        .btn-primary::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 0;
            height: 100%;
            background: linear-gradient(135deg, #3a0ca3 0%, #4361ee 100%);
            transition: all 0.4s ease;
            z-index: -1;
        }
        
        .btn-primary:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 6px -1px rgba(79, 70, 229, 0.2), 0 2px 4px -1px rgba(79, 70, 229, 0.1);
            background: var(--primary);
        }
        
        .btn-primary:hover::before {
            width: 100%;
        }
        
        .btn-outline-primary {
            color: var(--primary);
            border: 2px solid var(--primary);
            background: transparent;
        }
        
        .btn-outline-primary:hover {
            background: var(--primary);
            color: white;
            border-color: var(--primary);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(67, 97, 238, 0.2);
        }
        
        /* Badges */
        .badge {
            display: inline-block;
            padding: 0.35em 0.65em;
            font-size: 75%;
            font-weight: 700;
            line-height: 1;
            text-align: center;
            white-space: nowrap;
            vertical-align: baseline;
            border-radius: 0.25rem;
        }
        
        .badge-primary {
            color: white;
            background: var(--gradient);
            border: none;
            padding: 0.5rem 0.9rem;
            font-weight: 600;
            letter-spacing: 0.3px;
        }
        
        .badge-outline-primary {
            color: var(--primary);
            background: transparent;
            border: 1px solid var(--primary);
        }
        
        /* Tables */
        .table {
            width: 100%;
            margin-bottom: 1rem;
            color: var(--gray-800);
            border-collapse: collapse;
        }
        
        .table th,
        .table td {
            padding: 0.5rem;
            vertical-align: top;
            border-top: 1px solid var(--gray-200);
        }
        
        .table thead th {
            vertical-align: bottom;
            border-bottom: 2px solid var(--gray-200);
            background-color: var(--gray-100);
            color: var(--gray-700);
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.75rem;
            letter-spacing: 0.5px;
        }
        
        .table tbody tr:hover {
            background-color: var(--gray-100);
        }
        
        /* Card text adjustments */
        .card {
            font-size: 0.9rem;
            border: 1px solid #e2e8f0;
            border-radius: 0.5rem;
            overflow: hidden;
            transition: all 0.3s ease;
            margin-bottom: 1.5rem;
            background-color: #fff;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
        }
        
        .card:hover {
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            transform: translateY(-2px);
        }
        
        .card-header {
            background-color: #fff;
            border-bottom: 1px solid #e2e8f0;
            padding: 1rem 1.25rem;
        }
        
        .card-body {
            padding: 1.25rem;
        }
        
        .card-title {
            font-weight: 700;
            margin-bottom: 0.75rem;
            color: #2d3748;
            font-size: 1.1rem;
        }
        
        .card-subtitle {
            color: #718096;
            font-size: 0.875rem;
            margin-bottom: 1rem;
        }
        
        .card-text {
            color: #4a5568;
            line-height: 1.6;
            margin-bottom: 1rem;
        }
        
        /* Job card specific styles */
        .job-card .company-logo {
            width: 48px;
            height: 48px;
            object-fit: cover;
            border-radius: 8px;
            margin-right: 1rem;
        }
        
        .job-card .job-title {
            font-size: 17px;
            font-weight: 600;
            margin-bottom: 4px;
            color: #1a202c;
            line-height: 1.4;
        }
        
        .job-card .company-name {
            font-size: 0.875rem; /* 14px */
            color: #4a5568;
            margin-bottom: 0.5rem;
            font-weight: 500;
            letter-spacing: -0.01em;
        }
        
        .job-card .job-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
            margin-bottom: 1rem;
            font-family: 'Inter', 'Roboto', sans-serif;
        }
        
        /* Responsive Adjustments */
        @media (max-width: 991.98px) {
            .main-content {
                margin-left: 0 !important;
                padding: 1rem !important;
            }
        }
        
        /* Set explicit font family for all text elements */
        h1, h2, h3, h4, h5, h6, p, span, div, a, li, td, th, label, input, textarea, select, button {
            font-family: inherit;
        }
        
        .job-card .badge {
            font-weight: 500;
            padding: 0.35em 0.65em;
            border-radius: 0.25rem;
            font-size: 0.75rem;
            font-family: 'Inter', 'Roboto', sans-serif;
            letter-spacing: 0.01em;
            line-height: 1.5;
        }
        
        /* Button text */
        .btn {
            font-weight: 600;
            letter-spacing: 0.3px;
        }
        
        .profile-header {
            background: var(--gradient);
            border-radius: var(--radius-lg);
            color: white;
            padding: 3.5rem 2.5rem;
            margin: -1.5rem -1.5rem 3rem;
            box-shadow: var(--shadow-md);
            position: relative;
            overflow: hidden;
            background-image: 
                radial-gradient(at 10% 20%, rgba(59, 130, 246, 0.3) 0%, transparent 40%),
                radial-gradient(at 90% 80%, rgba(96, 165, 250, 0.3) 0%, transparent 40%),
                var(--gradient);
            background-size: 200% 200%;
            animation: gradient 15s ease infinite;
        }
        
        @keyframes gradient {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }
        
        .profile-header::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 100%;
            height: 100%;
            background: url("data:image/svg+xml,%3Csvg width='100' height='100' viewBox='0 0 100 100' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M11 18c3.866 0 7-3.134 7-7s-3.134-7-7-7-7 3.134-7 7 3.134 7 7 7zm48 25c3.866 0 7-3.134 7-7s-3.134-7-7-7-7 3.134-7 7 3.134 7 7 7zm-43-7c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zm63 31c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zM34 90c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zm56-76c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zM12 86c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm28-65c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm23-11c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm-6 60c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm29-22c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zM32 63c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm57-13c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm-9-29c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM60 91c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM35 41c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM12 60c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2z' fill='%23ffffff' fill-opacity='0.1' fill-rule='evenodd'/%3E%3C/svg%3E");
            opacity: 0.5;
        }
        
        .btn-primary:hover::before {
            width: 100%;
        }
        
        .job-card {
            border: 1px solid var(--gray-200);
            border-radius: var(--radius);
            padding: 1.25rem;
            transition: var(--transition);
            height: 100%;
            display: flex;
            flex-direction: column;
            background: white;
            position: relative;
            overflow: hidden;
            box-shadow: var(--shadow-sm);
            font-size: 0.9375rem;
        }
        
        .job-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-md);
            border-color: var(--primary-light);
        }
        
        .job-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 0;
            background: var(--gradient);
            transition: height 0.3s ease;
        }
        
        .job-card:hover::before {
            height: 100%;
        }
        
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
        }
        
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 0.5rem 1.5rem 0 rgba(58, 59, 69, 0.2);
        }
        
        .profile-avatar {
            width: 140px;
            height: 140px;
            border-radius: var(--radius-xl);
            border: 4px solid rgba(255, 255, 255, 0.9);
            object-fit: cover;
            margin: 0 auto 1.5rem;
            display: block;
            box-shadow: var(--shadow-lg);
            transition: var(--transition-slow);
            background: white;
            padding: 0.25rem;
            position: relative;
            z-index: 1;
        }
        
        .profile-avatar:hover {
            transform: translateY(-3px) scale(1.02);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
        }
        
        .progress {
            height: 0.5rem;
            border-radius: 1rem;
            background-color: var(--gray-100);
            overflow: visible;
            position: relative;
            box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.05);
        }
        
        .progress-bar {
            background: var(--gradient);
            border-radius: 1rem;
            position: relative;
            overflow: hidden;
            transition: width 0.6s ease;
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
                rgba(255, 255, 255, 0.1) 0%,
                rgba(255, 255, 255, 0.6) 50%,
                rgba(255, 255, 255, 0.1) 100%
            );
            background-size: 200% 100%;
            animation: shimmer 1.5s infinite;
            border-radius: 1rem;
        }
        
        @keyframes shimmer {
            0% { background-position: 200% 0; }
            100% { background-position: -200% 0; }
        }
        
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            margin-bottom: 20px;
        }
        
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 0.5rem 1.5rem 0 rgba(58, 59, 69, 0.2);
        }
        
        .stat-card {
            border-left: 4px solid var(--primary-color);
        }
        
        .stat-card.applications {
            border-left-color: var(--success-color);
        }
        
        .stat-card.saved {
            border-left-color: var(--warning-color);
        }
        
        .stat-card.views {
            border-left-color: var(--danger-color);
        }
        
        .nav-pills .nav-link {
            color: var(--text-color);
            border-radius: 10px;
            margin: 5px 0;
        }
        
        .nav-pills .nav-link.active {
            background-color: var(--primary-color);
            color: white;
        }
        
        .badge-custom {
            padding: 0.5em 0.8em;
            font-weight: 500;
            border-radius: 50px;
        }
    </style>
</head>
<body>
    <jsp:include page="/includes/jobseeker_sidebar.jsp" />
    <div class="container py-5" style="margin-left: 163px; transition: all 0.3s ease;">
        <div class="animate__animated animate__fadeIn">
        <!-- Back to top button -->
        <button onclick="topFunction()" id="backToTop" class="btn btn-primary btn-floating" title="Go to top" style="display: none;">
            <i class="fas fa-arrow-up"></i>
        </button>
        <!-- Back to top button -->
        <button onclick="topFunction()" id="backToTop" class="btn btn-primary btn-floating" title="Go to top">
            <i class="fas fa-arrow-up"></i>
        </button>
        <!-- Header -->
        <div class="profile-header p-4 mb-4 text-center text-md-start">
            <div class="row align-items-center">
                <div class="col-md-2 text-center">
                    <div class="position-relative d-inline-block">
                        <img src="${sessionScope.jobseeker.image}" 
                             class="rounded-circle border border-3 border-white" 
                             alt="Profile Avatar"
                             style="width: 100px; height: 100px; object-fit: cover;">
                        
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="d-flex align-items-center gap-3 mb-1">
                        <h2 class="mb-0">${sessionScope.jobseeker.first_Name} ${sessionScope.jobseeker.last_Name}</h2>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Stats Cards -->
            <div class="row mb-4">
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="card stat-card h-100">
                        <div class="card-body">
                            <div class="row no-gutters align-items-center">
                                <div class="col mr-2">
                                    <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                        Đơn ứng tuyển</div>
                                    <div class="h5 mb-0 font-weight-bold text-gray-800">24</div>
                                </div>
                                <div class="col-auto">
                                    <i class="fas fa-file-alt fa-2x text-gray-300"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="card stat-card h-100">
                        <div class="card-body">
                            <div class="row no-gutters align-items-center">
                                <div class="col mr-2">
                                    <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                        CV trực tuyến</div>
                                    <div class="h5 mb-0 font-weight-bold text-gray-800">3/5</div>
                                </div>
                                <div class="col-auto">
                                    <i class="fas fa-file-pdf fa-2x text-gray-300"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="card stat-card h-100">
                        <div class="card-body">
                            <div class="row no-gutters align-items-center">
                                <div class="col mr-2">
                                    <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                                        Công việc đã lưu</div>
                                    <div class="h5 mb-0 font-weight-bold text-gray-800">12</div>
                                </div>
                                <div class="col-auto">
                                    <i class="fas fa-bookmark fa-2x text-gray-300"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="card stat-card h-100">
                        <div class="card-body">
                            <div class="row no-gutters align-items-center">
                                <div class="col mr-2">
                                    <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                        Lượt xem hồ sơ</div>
                                    <div class="h5 mb-0 font-weight-bold text-gray-800">156</div>
                                </div>
                                <div class="col-auto">
                                    <i class="fas fa-eye fa-2x text-gray-300"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Page Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="h4 mb-0">Tổng quan hồ sơ</h2>

            </div>
                        
        </div>
        </div>
    </div>
    
    <style>
        /* Smooth scroll behavior */
        html {
            scroll-behavior: smooth;
        }
        
        /* Back to top button */
        #backToTop {
            position: fixed;
            bottom: 2rem;
            right: 2rem;
            width: 3rem;
            height: 3rem;
            border-radius: 50%;
            background: var(--gradient);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: var(--shadow-md);
            border: none;
            opacity: 0;
            transform: translateY(20px);
            transition: all 0.3s ease;
            z-index: 999;
        }
        
        #backToTop.visible {
            opacity: 1;
            transform: translateY(0);
        }
        
        #backToTop:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-lg);
        }
        
        /* Animation classes */
        .fade-in {
            animation: fadeIn 0.6s ease-out forwards;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        /* Responsive adjustments */
        @media (max-width: 992px) {
            .container {
                margin-left: 15px !important;
                padding-right: 30px;
            }
            
            .profile-header {
                padding: 2rem 1.25rem;
                margin: -1rem -1rem 2rem;
                border-radius: 0 0 var(--radius-lg) var(--radius-lg);
            }
            
            .profile-avatar {
                width: 100px;
                height: 100px;
            }
        }
    </style>
    
    <script>
        // Back to top button
        const backToTopButton = document.getElementById('backToTop');
        
        window.addEventListener('scroll', () => {
            if (window.pageYOffset > 300) {
                backToTopButton.classList.add('visible');
            } else {
                backToTopButton.classList.remove('visible');
            }
        });
        
        backToTopButton.addEventListener('click', () => {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });
        
        // Add fade-in animation to elements with data-animate attribute
        document.addEventListener('DOMContentLoaded', () => {
            const animateElements = document.querySelectorAll('[data-animate]');
            
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.classList.add('fade-in');
                    }
                });
            }, {
                threshold: 0.1
            });
            
            animateElements.forEach(el => observer.observe(el));
        });
    </script>
</body>
                <!-- Recommended Jobs -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3 d-flex justify-content-between align-items-center">
                        <h6 class="m-0 font-weight-bold text-primary">Công việc gợi ý</h6>
                        <a href="jobs.jsp" class="btn btn-sm btn-primary">
                            <i class="fas fa-search fa-sm"></i> Xem thêm
                        </a>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <!-- Job Card 1 -->
                            <div class="col-lg-6 mb-4">
                                <div class="card job-card h-100">
                                    <div class="card-body">
                                        <div class="d-flex mb-3">
                                            <img src="https://via.placeholder.com/48" alt="Company Logo" class="company-logo">
                                            <div>
                                                <h5 class="job-title mb-1">Lập trình viên Java Senior</h5>
                                                <p class="company-name text-muted mb-2">Công ty Công nghệ ABC</p>
                                                <div class="job-meta">
                                                    <span class="badge bg-light text-dark"><i class="fas fa-map-marker-alt fa-fw me-1"></i> Hà Nội</span>
                                                    <span class="badge bg-light text-dark"><i class="fas fa-dollar-sign fa-fw me-1"></i> $2000 - $3000</span>
                                                    <span class="badge bg-light text-dark"><i class="far fa-clock fa-fw me-1"></i> Full-time</span>
                                                </div>
                                            </div>
                                        </div>
                                        <p class="job-description">Chúng tôi đang tìm kiếm một Lập trình viên Java Senior có kinh nghiệm để tham gia vào dự án phát triển phần mềm quy mô lớn...</p>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <small class="text-muted">2 ngày trước</small>
                                            <div>
                                                <button class="btn btn-sm btn-outline-primary me-1"><i class="far fa-heart"></i></button>
                                                <a href="job_detail.jsp" class="btn btn-sm btn-primary">Ứng tuyển ngay</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Job Card 2 -->
                            <div class="col-lg-6 mb-4">
                                <div class="card job-card h-100">
                                    <div class="card-body">
                                        <div class="d-flex mb-3">
                                            <img src="https://via.placeholder.com/48" alt="Company Logo" class="company-logo">
                                            <div>
                                                <h5 class="job-title mb-1">Chuyên viên Phân tích Dữ liệu</h5>
                                                <p class="company-name text-muted mb-2">Tập đoàn XYZ</p>
                                                <div class="job-meta">
                                                    <span class="badge bg-light text-dark"><i class="fas fa-map-marker-alt fa-fw me-1"></i> TP. Hồ Chí Minh</span>
                                                    <span class="badge bg-light text-dark"><i class="fas fa-dollar-sign fa-fw me-1"></i> $1500 - $2500</span>
                                                    <span class="badge bg-light text-dark"><i class="far fa-clock fa-fw me-1"></i> Full-time</span>
                                                </div>
                                            </div>
                                        </div>
                                        <p class="job-description">Tìm kiếm chuyên viên phân tích dữ liệu có kinh nghiệm làm việc với các công cụ phân tích dữ liệu và xử lý dữ liệu lớn...</p>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <small class="text-muted">3 ngày trước</small>
                                            <div>
                                                <button class="btn btn-sm btn-outline-primary me-1"><i class="far fa-heart"></i></button>
                                                <a href="job_detail.jsp" class="btn btn-sm btn-primary">Ứng tuyển ngay</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Profile Completion -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">Hoàn thiện hồ sơ</h6>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <div class="d-flex justify-content-between mb-1">
                                <span>Tiến độ hoàn thành</span>
                                <span>75%</span>
                            </div>
                            <div class="progress">
                                <div class="progress-bar bg-success" role="progressbar" style="width: 75%" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="d-flex align-items-center mb-3">
                                    <div class="bg-light rounded-circle p-2 me-3">
                                        <i class="fas fa-user text-primary"></i>
                                    </div>
                                    <div>
                                        <h6 class="mb-0">Thông tin cá nhân</h6>
                                        <small class="text-success"><i class="fas fa-check-circle me-1"></i> Đã hoàn thành</small>
                                    </div>
                                </div>
                                <div class="d-flex align-items-center mb-3">
                                    <div class="bg-light rounded-circle p-2 me-3">
                                        <i class="fas fa-graduation-cap text-primary"></i>
                                    </div>
                                    <div>
                                        <h6 class="mb-0">Học vấn</h6>
                                        <small class="text-success"><i class="fas fa-check-circle me-1"></i> Đã hoàn thành</small>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="d-flex align-items-center mb-3">
                                    <div class="bg-light rounded-circle p-2 me-3">
                                        <i class="fas fa-briefcase text-primary"></i>
                                    </div>
                                    <div>
                                        <h6 class="mb-0">Kinh nghiệm làm việc</h6>
                                        <small class="text-warning"><i class="fas fa-exclamation-circle me-1"></i> Cần cập nhật</small>
                                    </div>
                                </div>
                                <div class="d-flex align-items-center">
                                    <div class="bg-light rounded-circle p-2 me-3">
                                        <i class="fas fa-file-alt text-primary"></i>
                                    </div>
                                    <div>
                                        <h6 class="mb-0">CV trực tuyến</h6>
                                        <small class="text-danger"><i class="fas fa-times-circle me-1"></i> Chưa tải lên</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="text-center mt-3">
                            <a href="jobseeker_detail.jsp" class="btn btn-primary">
                                <i class="fas fa-edit me-2"></i> Cập nhật hồ sơ
                            </a>
                            
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Custom scripts -->
    <script>
        // Enable tooltips
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });

        // Back to top button
        window.onscroll = function() {scrollFunction()};
        
        function scrollFunction() {
            var backToTopBtn = document.getElementById("backToTop");
            if (document.body.scrollTop > 300 || document.documentElement.scrollTop > 300) {
                backToTopBtn.style.display = "block";
                backToTopBtn.classList.add("animate__fadeIn");
                backToTopBtn.classList.remove("animate__fadeOut");
            } else {
                backToTopBtn.classList.remove("animate__fadeIn");
                backToTopBtn.classList.add("animate__fadeOut");
                setTimeout(function() {
                    if (document.body.scrollTop < 300 && document.documentElement.scrollTop < 300) {
                        backToTopBtn.style.display = "none";
                    }
                }, 200);
            }
        }
        
        function topFunction() {
            window.scrollTo({top: 0, behavior: 'smooth'});
        }
        
        // Add animation on scroll
        // Add active class to current nav link
        document.addEventListener('DOMContentLoaded', function() {
            const currentPage = location.pathname.split('/').pop() || 'index.html';
            document.querySelectorAll('.nav-link').forEach(link => {
                if (link.getAttribute('href') === currentPage) {
                    link.classList.add('active');
                }
            });
        });
    </script>
</body>
</html>
                    
                
                <!-- Recent Applications -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3 d-flex justify-content-between align-items-center">
                        <h6 class="m-0 font-weight-bold text-primary">Đơn ứng tuyển gần đây</h6>
                        <a href="#" class="btn btn-sm btn-primary">
                            <i class="fas fa-list-ul fa-sm"></i> Xem tất cả
                        </a>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover" id="dataTable" width="100%" cellspacing="0">
                                <thead class="table-light">
                                    <tr>
                                        <th>Công việc</th>
                                        <th>Nhà tuyển dụng</th>
                                        <th>Ngày nộp</th>
                                        <th>Trạng thái</th>
                                        <th class="text-end">Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div class="me-3">
                                                    <div class="bg-primary bg-opacity-10 rounded-circle p-2">
                                                        <i class="fas fa-laptop-code text-primary"></i>
                                                    </div>
                                                </div>
                                                <div>
                                                    <h6 class="mb-0 font-weight-bold">Lập trình viên Java</h6>
                                                    <small class="text-muted">Full-time • Hà Nội</small>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="align-middle">
                                            <div class="d-flex align-items-center">
                                                <img src="https://via.placeholder.com/30" alt="Company Logo" class="rounded-circle me-2" style="width: 30px; height: 30px; object-fit: cover;">
                                                <span>Công ty Cổ phần ABC</span>
                                            </div>
                                        </td>
                                        <td class="align-middle">15/06/2023</td>
                                        <td class="align-middle">
                                            <span class="badge rounded-pill bg-warning bg-opacity-15 text-warning">
                                                <i class="fas fa-clock me-1"></i> Đang xử lý
                                            </span>
                                        </td>
                                        <td class="text-end align-middle">
                                            <button class="btn btn-sm btn-outline-primary rounded-pill px-3">
                                                <i class="far fa-eye me-1"></i> Xem
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div class="me-3">
                                                    <div class="bg-success bg-opacity-10 rounded-circle p-2">
                                                        <i class="fas fa-paint-brush text-success"></i>
                                                    </div>
                                                </div>
                                                <div>
                                                    <h6 class="mb-0 font-weight-bold">Chuyên viên Thiết kế UX/UI</h6>
                                                    <small class="text-muted">Full-time • Hồ Chí Minh</small>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="align-middle">
                                            <div class="d-flex align-items-center">
                                                <img src="https://via.placeholder.com/30" alt="Company Logo" class="rounded-circle me-2" style="width: 30px; height: 30px; object-fit: cover;">
                                                <span>Tập đoàn XYZ</span>
                                            </div>
                                        </td>
                                        <td class="align-middle">10/06/2023</td>
                                        <td class="align-middle">
                                            <span class="badge rounded-pill bg-success bg-opacity-15 text-success">
                                                <i class="fas fa-check-circle me-1"></i> Đã xem hồ sơ
                                            </span>
                                        </td>
                                        <td class="text-end align-middle">
                                            <button class="btn btn-sm btn-outline-primary rounded-pill px-3">
                                                <i class="far fa-eye me-1"></i> Xem
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div class="me-3">
                                                    <div class="bg-info bg-opacity-10 rounded-circle p-2">
                                                        <i class="fas fa-chart-line text-info"></i>
                                                    </div>
                                                </div>
                                                <div>
                                                    <h6 class="mb-0 font-weight-bold">Chuyên viên Phân tích Dữ liệu</h6>
                                                    <small class="text-muted">Part-time • Đà Nẵng</small>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="align-middle">
                                            <div class="d-flex align-items-center">
                                                <img src="https://via.placeholder.com/30" alt="Company Logo" class="rounded-circle me-2" style="width: 30px; height: 30px; object-fit: cover;">
                                                <span>Công ty TNHH DEF</span>
                                            </div>
                                        </td>
                                        <td class="align-middle">05/06/2023</td>
                                        <td class="align-middle">
                                            <span class="badge rounded-pill bg-info bg-opacity-15 text-info">
                                                <i class="fas fa-user-check me-1"></i> Đã mời phỏng vấn
                                            </span>
                                        </td>
                                        <td class="text-end align-middle">
                                            <button class="btn btn-sm btn-outline-primary rounded-pill px-3">
                                                <i class="far fa-eye me-1"></i> Xem
                                            </button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                
                <!-- Recommended Jobs -->
                <div class="card">
                    <div class="card-header bg-white">
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="d-flex align-items-center mb-2">
                                <h4 class="mb-0 me-3">${sessionScope.user.fullName}</h4>
                                <a href="jobseeker_detail.jsp" class="btn btn-sm btn-outline-light">
                                    <i class="fas fa-external-link-alt me-1"></i>Xem chi tiết
                                </a>
                            </div>
                            <p class="mb-0">${sessionScope.user.role}</p>
                        </div>
                        <div class="d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Gợi ý việc làm</h5>
                            <a href="jobs" class="btn btn-sm btn-outline-primary">Xem tất cả</a>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <!-- Job Card 1 -->
                            <div class="col-lg-6 mb-4">
                                <div class="card border-left-primary shadow-sm h-100 hover-lift">
                                    <div class="card-body">
                                        <div class="d-flex mb-3">
                                            <div class="me-3">
                                                <div class="bg-primary bg-opacity-10 rounded-circle p-3">
                                                    <i class="fas fa-laptop-code fa-2x text-primary"></i>
                                                </div>
                                            </div>
                                            <div class="flex-grow-1">
                                                <div class="d-flex justify-content-between align-items-start">
                                                    <h5 class="font-weight-bold text-gray-900 mb-1">Senior Java Developer</h5>
                                                    <span class="badge bg-success bg-opacity-10 text-success">Mới</span>
                                                </div>
                                                <p class="text-muted mb-2">Công ty Công nghệ ABC</p>
                                                <div class="d-flex flex-wrap gap-2 mb-3">
                                                    <span class="badge bg-light text-dark"><i class="fas fa-map-marker-alt text-primary me-1"></i> Hà Nội</span>
                                                    <span class="badge bg-light text-dark"><i class="far fa-clock text-primary me-1"></i> Full-time</span>
                                                    <span class="badge bg-light text-dark"><i class="fas fa-briefcase text-primary me-1"></i> 3+ năm kinh nghiệm</span>
                                                </div>
                                                <p class="text-muted small mb-3">Tuyển dụng lập trình viên Java có kinh nghiệm từ 3 năm trở lên, làm việc với Spring Boot, Microservices.</p>
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <span class="text-success fw-bold">$2500 - $3500</span>
                                                    <button class="btn btn-sm btn-primary rounded-pill px-3">
                                                        <i class="fas fa-paper-plane me-1"></i> Ứng tuyển ngay
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Job Card 2 -->
                            <div class="col-lg-6 mb-4">
                                <div class="card border-left-success shadow-sm h-100 hover-lift">
                                    <div class="card-body">
                                        <div class="d-flex mb-3">
                                            <div class="me-3">
                                                <div class="bg-success bg-opacity-10 rounded-circle p-3">
                                                    <i class="fas fa-paint-brush fa-2x text-success"></i>
                                                </div>
                                            </div>
                                            <div class="flex-grow-1">
                                                <div class="d-flex justify-content-between align-items-start">
                                                    <h5 class="font-weight-bold text-gray-900 mb-1">Senior UX/UI Designer</h5>
                                                    <span class="badge bg-warning bg-opacity-10 text-warning">Hot</span>
                                                </div>
                                                <p class="text-muted mb-2">Tập đoàn XYZ</p>
                                                <div class="d-flex flex-wrap gap-2 mb-3">
                                                    <span class="badge bg-light text-dark"><i class="fas fa-map-marker-alt text-success me-1"></i> Hồ Chí Minh</span>
                                                    <span class="badge bg-light text-dark"><i class="far fa-clock text-success me-1"></i> Full-time</span>
                                                    <span class="badge bg-light text-dark"><i class="fas fa-briefcase text-success me-1"></i> 2+ năm kinh nghiệm</span>
                                                </div>
                                                <p class="text-muted small mb-3">Tuyển dụng UX/UI Designer có kinh nghiệm thiết kế giao diện người dùng cho các ứng dụng di động và web.</p>
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <span class="text-success fw-bold">$2000 - $3000</span>
                                                    <button class="btn btn-sm btn-success rounded-pill px-3">
                                                        <i class="fas fa-paper-plane me-1"></i> Ứng tuyển ngay
                                                    </button>
                                                </div>
                                                <span class="text-muted d-block small">Hồ Chí Minh</span>
                                            </div>
                                            <button class="btn btn-sm btn-outline-primary">Ứng tuyển</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div> <!-- Close main-content -->
    </div> <!-- Close container -->

    <!-- Footer -->
    <footer class="bg-dark text-white py-4 mt-5">
        <div class="container">
            <div class="row">
                <div class="col-md-4 mb-4 mb-md-0">
                    <h5>Về FindWorks</h5>
                    <p class="text-muted">Kết nối nhà tuyển dụng và ứng viên một cách hiệu quả nhất.</p>
                </div>
                <div class="col-md-2 mb-4 mb-md-0">
                    <h5>Dịch vụ</h5>
                    <ul class="list-unstyled text-muted">
                        <li><a href="#" class="text-decoration-none text-muted">Tìm việc làm</a></li>
                        <li><a href="#" class="text-decoration-none text-muted">Đăng tin tuyển dụng</a></li>
                        <li><a href="#" class="text-decoration-none text-muted">Tạo hồ sơ</a></li>
                    </ul>
                </div>
                <div class="col-md-2 mb-4 mb-md-0">
                    <h5>Công ty</h5>
                    <ul class="list-unstyled text-muted">
                        <li><a href="#" class="text-decoration-none text-muted">Giới thiệu</a></li>
                        <li><a href="#" class="text-decoration-none text-muted">Điều khoản</a></li>
                        <li><a href="#" class="text-decoration-none text-muted">Chính sách bảo mật</a></li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h5>Kết nối với chúng tôi</h5>
                    <div class="d-flex gap-3 mb-3">
                        <a href="#" class="text-white"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="text-white"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="text-white"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#" class="text-white"><i class="fab fa-instagram"></i></a>
                    </div>
                    <p class="text-muted mb-0">© 2023 FindWorks. All rights reserved.</p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Custom JS -->
    <script>
        // Update profile completion progress
        document.addEventListener('DOMContentLoaded', function() {
            // You can fetch actual data from your backend here
            const completionPercentage = 75; // This should come from your backend
            
            // Update progress bar
            const progressBar = document.querySelector('.progress-bar');
            if (progressBar) {
                progressBar.style.width = `${completionPercentage}%`;
                progressBar.setAttribute('aria-valuenow', completionPercentage);
            }
            
            // Tab switching functionality - Only for tab links with data-toggle="tab"
            const tabLinks = document.querySelectorAll('.nav-link[data-toggle="tab"]');
            tabLinks.forEach(link => {
                link.addEventListener('click', function(e) {
                    e.preventDefault();
                    // Remove active class from all tab links
                    tabLinks.forEach(l => l.classList.remove('active'));
                    // Add active class to clicked tab link
                    this.classList.add('active');
                    // Get the target tab content and show it
                    const target = document.querySelector(this.getAttribute('href'));
                    if (target) {
                        document.querySelectorAll('.tab-pane').forEach(pane => {
                            pane.classList.remove('show', 'active');
                        });
                        target.classList.add('show', 'active');
                    }
                });
            });
        });
    </script>
</body>
</html>
