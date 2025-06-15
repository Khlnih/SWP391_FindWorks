<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="DAO.AccountTierDAO"%>
<%@page import="Model.AccountTier"%>
<%@page import="java.util.List"%>
<%@page import="java.math.BigDecimal"%>

<% 
    AccountTierDAO accountTierDAO = new AccountTierDAO();
    List<AccountTier> accountTiers = accountTierDAO.getAllAccountTier();
    request.setAttribute("accounts", accountTiers);
%>

<!DOCTYPE html>
<html class="no-js" lang="vi">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Quản lý Gói Dịch Vụ - Admin Panel</title>
    <meta name="description" content="Quản lý các gói dịch vụ tài khoản">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" type="image/x-icon" href="assets/img/icon/favicon.png">

    <!-- CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@2.1.0/css/boxicons.min.css">
    <style>
        :root {
            /* Main Colors */
            --primary: #4e73df;
            --primary-light: #e8eefd;
            --primary-dark: #2e59d9;
            --secondary: #858796;
            --secondary-light: #e3e6f0;
            --success: #1cc88a;
            --success-light: #d1f2e9;
            --info: #36b9cc;
            --info-light: #d1ecf1;
            --warning: #f6c23e;
            --warning-light: #fdf6e3;
            --danger: #e74a3b;
            --danger-light: #f8d7da;
            --light: #f8f9fc;
            --dark: #2e2f33;
            
            /* Gray Scale */
            --gray-50: #f9fafb;
            --gray-100: #f8f9fc;
            --gray-150: #f0f2f5;
            --gray-200: #f1f3f9;
            --gray-250: #e9ecef;
            --gray-300: #dddfeb;
            --gray-350: #d6d8e0;
            --gray-400: #d1d3e2;
            --gray-450: #c4c8d1;
            --gray-500: #b7b9cc;
            --gray-550: #9ea0ab;
            --gray-600: #858796;
            --gray-650: #7a7b83;
            --gray-700: #6e707e;
            --gray-750: #5f616a;
            --gray-800: #5a5c69;
            --gray-850: #4a4b53;
            --gray-900: #3a3b45;
            --gray-950: #2a2b32;
            
            /* Gradients */
            --gradient-primary: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            --gradient-success: linear-gradient(135deg, var(--success) 0%, #17a673 100%);
            --gradient-warning: linear-gradient(135deg, var(--warning) 0%, #e0a800 100%);
            --gradient-danger: linear-gradient(135deg, var(--danger) 0%, #e02d1b 100%);
            --gradient-info: linear-gradient(135deg, var(--info) 0%, #2c9faf 100%);
            
            /* Shadows */
            --shadow-sm: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
            --shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
            --shadow-md: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            --shadow-lg: 0 1rem 3rem rgba(0, 0, 0, 0.175);
            --shadow-inset: inset 0 1px 2px rgba(0, 0, 0, 0.075);
            
            /* Border Radius */
            --border-radius-sm: 0.25rem;
            --border-radius: 0.5rem;
            --border-radius-lg: 0.75rem;
            --border-radius-xl: 1rem;
            --border-radius-pill: 50rem;
            
            /* Transitions */
            --transition: all 0.3s ease;
            --transition-slow: all 0.5s ease;
            --transition-fast: all 0.15s ease;
            
            /* Z-index */
            --zindex-dropdown: 1000;
            --zindex-sticky: 1020;
            --zindex-fixed: 1030;
            --zindex-modal-backdrop: 1040;
            --zindex-modal: 1050;
            --zindex-popover: 1060;
            --zindex-tooltip: 1070;
            
            /* Spacing */
            --spacer: 1rem;
            --spacer-2: 0.5rem;
            --spacer-3: 1rem;
            --spacer-4: 1.5rem;
            --spacer-5: 3rem;
            
            /* Font Sizes */
            --font-size-xs: 0.75rem;
            --font-size-sm: 0.875rem;
            --font-size-base: 1rem;
            --font-size-lg: 1.25rem;
            --font-size-xl: 1.5rem;
            --font-size-2xl: 2rem;
            --font-size-3xl: 2.5rem;
            
            /* Line Heights */
            --line-height-sm: 1.25;
            --line-height-base: 1.6;
            --line-height-lg: 2;
        }

        body {
            font-family: 'Nunito', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background-color: #f8f9fc;
            color: #5a5c69;
            line-height: 1.6;
        }

        /* Sidebar */
        .main-content {
            margin-left: 1.25rem; /* Reduced from 2.5rem to 1.25rem (20px) to shift content left by 20px more */
            min-height: 100vh;
            transition: var(--transition);
            padding: 2rem 1.5rem 2rem 2.5rem;
        }

        .sidebar-collapsed .main-content {
            margin-left: 0;
            padding-left: 1.5rem;
        }

        /* Header */
        .admin-header {
            background: #fff;
            padding: 1.5rem 1.75rem;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            margin-bottom: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-left: 4px solid var(--primary);
        }

        .page-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--dark);
            margin: 0;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding-left: 0.25rem;
        }

        .page-title i {
            color: var(--primary);
            font-size: 1.75rem;
        }

        .page-subtitle {
            color: var(--gray-600);
            font-size: 0.9rem;
            margin: 0.25rem 0 0 0;
        }

        /* Card Styling */
        /* Card Styles */
        /* Compact Card Styles */
        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
            margin-bottom: 1.25rem;
            overflow: hidden;
            position: relative;
            background: #fff;
            border-left: 4px solid var(--primary);
            transform: translateY(0);
            will-change: transform, box-shadow;
            height: auto;
        }
        
        .card:hover {
            transform: translateY(-3px);
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
        }
        
        .card.highlight {
            border: 2px solid var(--primary);
            box-shadow: 0 0 0 0.2rem rgba(78, 115, 223, 0.25);
        }

        .card.premium {
            border-top-color: var(--warning);
        }

        .card.enterprise {
            border-top-color: var(--danger);
            box-shadow: 0 0.5rem 1.5rem 0.5rem rgba(58, 59, 69, 0.2);
        }
        
        .tier-card .card-header {
            background: transparent;
            border: none;
            padding: 1.5rem 1.5rem 1rem;
            position: relative;
            z-index: 1;
            text-align: left;
        }
        
        .tier-card .card-header h5 {
            font-size: 1.25rem;
            font-weight: 700;
            margin: 0 0 0.25rem 0;
            color: var(--dark);
            position: relative;
            z-index: 1;
        }
        
        .tier-card .card-header h5 p {
            color: var(--gray-600);
            margin: 0;
            font-size: 0.85rem;
            font-weight: 500;
            opacity: 0.8;
        }
        
        .tier-card .card-header h5::after {
            content: '';
            position: absolute;
            bottom: -8px;
            left: 50%;
            transform: translateX(-50%);
            width: 40px;
            height: 3px;
            background: linear-gradient(90deg, var(--primary), var(--primary-dark));
            border-radius: 3px;
        }
        
        .tier-card.premium .card-header h5::after {
            background: linear-gradient(90deg, #ffc107, #ff9800);
        }
        
        .tier-card.enterprise .card-header h5::after {
            background: linear-gradient(90deg, #e74a3b, #e02d1b);
        }
        
        .card-header:hover {
            background: var(--gray-50);
        }

        .card-title {
            font-size: var(--font-size-lg);
            font-weight: 700;
            color: var(--gray-900);
            margin: 0;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .card-title i {
            color: var(--primary);
            font-size: 1.25em;
        }

        .badge {
            font-weight: 700;
            padding: 0.5em 1.2em;
            border-radius: 50px;
            font-size: 0.7rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            position: relative;
            z-index: 1;
            overflow: hidden;
        }
        
        .badge::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(255,255,255,0.1);
            z-index: -1;
            opacity: 0;
            transition: all 0.3s ease;
        }
        
        .badge:hover::after {
            opacity: 1;
        }
        
        .badge.bg-primary {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark)) !important;
        }
        
        .badge.bg-warning {
            background: linear-gradient(135deg, #ffc107, #ff9800) !important;
        }
        
        .badge.bg-danger {
            background: linear-gradient(135deg, #e74a3b, #e02d1b) !important;
        }

        .badge.bg-primary {
            background-color: var(--primary) !important;
        }

        /* Modern Glassmorphism Card Design */
        .tier-card {
            border: none;
            border-radius: 12px;
            overflow: hidden;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            background: #fff;
            border-left: 4px solid var(--primary);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            position: relative;
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        
        .tier-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            border-radius: 20px;
            padding: 1px;
            background: linear-gradient(145deg, rgba(255,255,255,0.3), rgba(255,255,255,0.1));
            -webkit-mask: linear-gradient(#fff 0 0) content-box, linear-gradient(#fff 0 0);
            -webkit-mask-composite: xor;
            mask-composite: exclude;
            pointer-events: none;
        }
        
        .tier-card::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, var(--primary), var(--primary-dark));
            z-index: 2;
            transition: all 0.6s cubic-bezier(0.16, 1, 0.3, 1);
        }
        
        .tier-card.premium::before {
            background: linear-gradient(90deg, #ffc107, #ff9800);
        }
        
        .tier-card.enterprise::before {
            background: linear-gradient(90deg, #e74a3b, #e02d1b);
        }

        .tier-card.premium {
            border-left-color: var(--warning);
        }

        .tier-card.enterprise {
            border-left-color: var(--danger);
        }

        .tier-card .card-body {
            padding: 0 1.5rem 1.5rem;
            position: relative;
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .tier-price {
            font-size: 2.5rem;
            font-weight: 800;
            color: var(--primary);
            margin: 1.5rem 0;
            line-height: 1;
            position: relative;
            display: inline-block;
        }
        
        .tier-price::before {
            /* Removed the '₫' symbol from price display */
            content: '';
            font-size: 1.5rem;
            font-weight: 500;
            margin-right: 0.25rem;
            vertical-align: top;
            line-height: 1.8;
            display: inline-block;
        }
        
        .card.premium .tier-price {
            color: var(--warning);
        }

        .card.enterprise .tier-price {
            color: var(--danger);
        }

        .tier-duration {
            color: var(--gray-600);
            font-size: 0.8rem;
            margin: 0 0 0.5rem 0;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .tier-description {
            color: var(--gray-700);
            margin-bottom: 1.5rem;
            line-height: 1.6;
        }

        .tier-features {
            margin: 1rem 0;
            padding: 0;
            list-style: none;
        }
        
        .tier-features li {
            padding: 0.5rem 0;
            display: flex;
            align-items: flex-start;
            color: var(--gray-700);
            font-size: 0.9rem;
            line-height: 1.5;
            position: relative;
            padding-left: 1.75rem;
        }
        
        .tier-features li:before {
            content: '✓';
            color: var(--success);
            position: absolute;
            left: 0;
            top: 0.5rem;
            font-size: 0.8rem;
        }
        
        .tier-features li + li {
            border-top: 1px dashed var(--gray-200);
        }

        /* Buttons */
        /* Button Styles */
        .btn {
            font-weight: 600;
            padding: 0.75rem 1.75rem;
            border-radius: var(--border-radius-pill);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            font-size: var(--font-size-sm);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border: none;
            cursor: pointer;
            position: relative;
            overflow: hidden;
            z-index: 1;
            box-shadow: var(--shadow-sm);
        }
        
        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.1);
            opacity: 0;
            transition: var(--transition);
            z-index: -1;
        }
        
        .btn:hover::before {
            opacity: 1;
        }
        
        .btn:active {
            transform: translateY(1px);
            box-shadow: var(--shadow-sm) !important;
        }

        .btn-add {
            background: var(--gradient-primary);
            color: white;
            font-weight: 700;
            padding: 0.875rem 2rem;
            box-shadow: 0 4px 15px rgba(78, 115, 223, 0.3);
            position: relative;
            overflow: hidden;
        }
        
        .btn-add:hover {
            transform: translateY(-2px);
            box-shadow: 0 7px 20px rgba(78, 115, 223, 0.4);
        }
        
        .btn-add i {
            transition: var(--transition);
        }
        
        .btn-add:hover i {
            transform: translateX(3px);
        }

        .btn-edit {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white !important;
            border: none;
            box-shadow: 0 4px 15px rgba(78, 115, 223, 0.25);
            position: relative;
            overflow: hidden;
            z-index: 1;
            transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
            font-weight: 700;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            font-size: 0.8rem;
            padding: 1rem 1.5rem;
            border-radius: 12px;
        }
        
        .btn-edit::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, var(--primary-dark), var(--primary));
            z-index: -1;
            opacity: 0;
            transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
        }
        
        .tier-card.premium .btn-edit {
            background: linear-gradient(135deg, #ffc107, #ff9800);
            box-shadow: 0 4px 15px rgba(255, 152, 0, 0.25);
        }
        
        .tier-card.enterprise .btn-edit {
            background: linear-gradient(135deg, #e74a3b, #e02d1b);
            box-shadow: 0 4px 15px rgba(231, 74, 59, 0.25);
        }
        
        .btn-edit:hover {
            transform: translateY(-3px) scale(1.02);
            box-shadow: 0 10px 30px rgba(78, 115, 223, 0.35);
            color: white !important;
        }
        
        .btn-edit:hover::before {
            opacity: 1;
        }
        
        .tier-card.premium .btn-edit:hover {
            box-shadow: 0 8px 25px rgba(255, 152, 0, 0.4);
        }
        
        .tier-card.enterprise .btn-edit:hover {
            box-shadow: 0 8px 25px rgba(231, 74, 59, 0.4);
        }

        .btn-edit, .btn-delete {
            padding: 0.8rem 1.5rem;
            border-radius: 10px;
            font-weight: 600;
            transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
            text-transform: uppercase;
            font-size: 0.75rem;
            letter-spacing: 0.5px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 100%;
            margin-bottom: 0.75rem;
            position: relative;
            overflow: hidden;
        }

        .btn-delete {
            background: transparent;
            color: var(--gray-600) !important;
            border: 2px solid rgba(0, 0, 0, 0.08);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            margin-top: 0.5rem;
            position: relative;
            overflow: hidden;
            z-index: 1;
            font-weight: 600;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            font-size: 0.8rem;
            padding: 0.9rem 1.5rem;
            border-radius: 12px;
            background: rgba(255, 255, 255, 0.6);
            backdrop-filter: blur(5px);
        }
        
        .btn-delete::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(231, 74, 59, 0.1);
            z-index: -1;
            opacity: 0;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }
        
        .btn-delete:hover {
            background: rgba(255, 255, 255, 0.8);
            color: var(--danger) !important;
            transform: translateY(-3px) scale(1.02);
            border-color: var(--danger);
            box-shadow: 0 8px 25px rgba(231, 74, 59, 0.15);
        }
        
        .btn-delete:hover::before {
            opacity: 1;
        }
        
        .btn-delete i {
            transition: var(--transition);
        }
        
        .btn-delete:hover i {
            transform: scale(1.1);
        }

        /* Pagination */
        .pagination {
            margin-top: 2rem;
        }

        .page-item.active .page-link {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .page-link {
            color: var(--primary-color);
            border: 1px solid #d1d3e2;
            padding: 0.5rem 0.9rem;
            margin: 0 0.2rem;
            border-radius: 0.35rem !important;
            font-weight: 500;
        }

        .page-link:hover {
            background-color: #eaecf4;
            color: #224abe;
            border-color: #d1d3e2;
        }

        /* Page size selector */
        .page-size-selector {
            width: auto;
            display: inline-block;
            margin-left: 0.5rem;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
                padding: 1rem;
            }
            
            .sidebar-collapsed .main-content {
                margin-left: 0;
            }
            
            .admin-header {
                flex-direction: column;
                gap: 1rem;
                align-items: flex-start;
            }
            
            .action-buttons {
                width: 100%;
            }
        }
        /* Tier Pricing */
        .tier-price {
            font-size: 2.5rem;
            font-weight: 800;
            color: var(--primary);
            margin: 1.5rem 0;
            line-height: 1;
            position: relative;
            display: inline-block;
        }
        
        .tier-price::before {
            font-size: 1.5rem;
            font-weight: 500;
            margin-right: 0.25rem;
            vertical-align: top;
            line-height: 1.8;
            display: inline-block;
        }
        
        .card.premium .tier-price {
            color: var(--warning);
        }
        
        .card.enterprise .tier-price {
            color: var(--danger);
        }

            .tier-duration {
                color: var(--gray-600);
                font-size: 0.9rem;
                margin-bottom: 1.5rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .tier-description {
                color: var(--gray-700);
                margin-bottom: 1.5rem;
                line-height: 1.6;
            }

            .tier-features {
                margin: 0 0 2rem 0;
                padding: 0;
            }

            .tier-features .feature-item {
                display: flex;
                align-items: flex-start;
                margin-bottom: 0.75rem;
                color: var(--gray-700);
            }

            .tier-features .feature-item i {
                color: var(--success);
                margin-right: 0.75rem;
            }

            /* Search and Filter */
            .search-box {
                position: relative;
                max-width: 500px;
            }

            .search-box .form-control {
                padding-left: 2.5rem;
                border-radius: 50px;
                border: 1px solid var(--gray-300);
                height: 45px;
                font-size: 0.9rem;
            }

            .search-box .search-icon {
                position: absolute;
                left: 1.25rem;
                top: 50%;
                transform: translateY(-50%);
                color: var(--gray-500);
                z-index: 10;
            }

            .form-select {
                height: 45px;
                border-radius: 50px;
                border: 1px solid var(--gray-300);
                font-size: 0.9rem;
                padding: 0.5rem 1.5rem;
            }

            /* Pagination */
            .pagination {
                margin: 2.5rem 0 1.5rem;
                justify-content: center;
            }

            .page-item.active .page-link {
                background: var(--primary);
                border-color: var(--primary);
                color: #fff;
            }

            .page-link {
                color: var(--gray-700);
                border: 1px solid var(--gray-300);
                padding: 0.6rem 1rem;
                margin: 0 0.2rem;
                border-radius: 50% !important;
                width: 40px;
                height: 40px;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: var(--transition);
            }

            .page-link:hover {
                background: var(--primary-light);
                color: var(--primary);
                border-color: var(--primary-light);
            }

            .page-item:first-child .page-link,
            .page-item:last-child .page-link {
                border-radius: 50% !important;
            }
            
            /* Page Info */
            .page-info {
                color: var(--gray-600);
                font-size: 0.9rem;
            }
            
            /* Responsive */
            @media (max-width: 991.98px) {
                .main-content {
                    margin-left: 0;
                    padding: 1.25rem 1rem;
                }
                
                .admin-header {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 1.25rem;
                    padding: 1.25rem 1.5rem;
                }
                
                .search-box {
                    max-width: 100%;
                    margin-top: 1rem;
                }
            }
            
            @media (max-width: 767.98px) {
                .card {
                    margin-bottom: 1.25rem;
                }
                
                .tier-price {
                    font-size: 2rem;
                }
            }
            
            @media (max-width: 575.98px) {
                .page-title {
                    font-size: 1.35rem;
                }
                
                .btn {
                    padding: 0.65rem 1.25rem;
                    font-size: 0.8rem;
                }
                
                .page-link {
                    width: 35px;
                    height: 35px;
                    padding: 0.5rem;
                    font-size: 0.85rem;
                }
            }
        
    </style>

            
    </head>
    <body>
        <jsp:include page="/includes/admin_sidebar.jsp" />

        <div class="main-content">
            <!-- Header -->
            <div class="container-fluid">
    <%-- Hiển thị thông báo thành công --%>
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show mt-3" role="alert">
            ${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <%-- Xóa thông báo sau khi hiển thị --%>
        <c:remove var="successMessage" scope="session" />
    </c:if>
    
    <%-- Hiển thị thông báo lỗi --%>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show mt-3" role="alert">
            ${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <%-- Xóa thông báo sau khi hiển thị --%>
        <c:remove var="errorMessage" scope="session" />
    </c:if>
    
    <div class="admin-header">
                <div class="d-flex justify-content-between align-items-center w-100">
                    <div>
                        <h1 class="page-title mb-0">Account Tiers Management</h1>
                        
                        <!-- Search Form -->
                        <form method="GET" action="admin" class="mt-4 p-4 bg-light rounded-3 shadow-sm">
                            <input type="hidden" name="action" value="accounttier">
                            <div class="row g-3">
                                <div class="col-md-3">
                                    <label for="minPrice" class="form-label">Price from</label>
                                    <input type="number" class="form-control" id="minPrice" name="minPrice" 
                                           value="${param.minPrice}" placeholder="Minimum" min="0">
                                </div>
                                <div class="col-md-3">
                                    <label for="maxPrice" class="form-label">To</label>
                                    <input type="number" class="form-control" id="maxPrice" name="maxPrice" 
                                           value="${param.maxPrice}" placeholder="Maximum" min="0">
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label">Duration (days)</label>
                                    <div class="input-group">
                                        <input type="number" class="form-control" id="minDuration" name="minDuration" 
                                               value="${param.minDuration}" placeholder="From" min="1">
                                        <span class="input-group-text">-</span>
                                        <input type="number" class="form-control" id="maxDuration" name="maxDuration" 
                                               value="${param.maxDuration}" placeholder="To" min="1">
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <label for="userTypeScope" class="form-label">User Type</label>
                                    <select class="form-select" id="userTypeScope" name="userTypeScope">
                                        <option value="">All</option>
                                        <c:forEach items="${userTypes}" var="type">
                                            <option value="${type}" ${param.userTypeScope eq type ? 'selected' : ''}>
                                                <c:choose>
                                                    <c:when test="${type == 'Recruiter'}">Recruiter</c:when>
                                                    <c:when test="${type == 'Jobseeker'}">Jobseeker</c:when>
                                                    <c:otherwise>Both</c:otherwise>
                                                </c:choose>
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <label for="isActive" class="form-label">Status</label>
                                    <select class="form-select" id="isActive" name="isActive">
                                        <option value="">All</option>
                                        <option value="true" ${param.isActive == 'true' ? 'selected' : ''}>Active</option>
                                        <option value="false" ${param.isActive == 'false' ? 'selected' : ''}>Inactive</option>
                                    </select>
                                </div>
                                <div class="col-md-12 mt-4">
                                    <button type="submit" class="btn btn-primary me-2">
                                        <i class="fas fa-search me-1"></i> Search
                                    </button>
                                    <a href="admin?action=accounttier" class="btn btn-outline-secondary">
                                        <i class="fas fa-undo me-1"></i> Reset
                                    </a>
                                </div>
                            </div>
                        </form>
                    </div>
                    <a href="add_tier.jsp" class="btn btn-add">
                        <i class="fas fa-plus"></i> Add account tier
                    </a>
                </div>
            </div>
            
            <!-- Main Content -->
            <div class="container-fluid px-0">
                
                <c:if test="${empty accountTiers}">
                    <div class="card">
                        <div class="card-body text-center py-5">
                            <c:choose>
                                <c:when test="${not empty param.search or not empty param.minPrice or not empty param.maxPrice or not empty param.isActive or not empty param.userTypeScope}">
                                    <i class="fas fa-search fa-4x text-muted mb-4"></i>
                                    <h4 class="mb-3">No matching results found</h4>
                                    <p class="text-muted mb-4">No account tiers match your search criteria</p>
                                    <a href="admin?action=accounttier" class="btn btn-primary">
                                        <i class="fas fa-undo me-2"></i>Clear filters
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <i class="fas fa-box-open fa-4x text-muted mb-4"></i>
                                    <h4 class="mb-3">No account tiers available</h4>
                                    <p class="text-muted mb-4">Click the "Add New Tier" button to create your first account tier</p>
                                    <a href="admin?action=addTier" class="btn btn-primary">
                                        <i class="fas fa-plus me-2"></i>Add New Tier
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:if>
                
                <!-- Tiers Grid -->
                <div class="row g-3">
                    <c:forEach var="account" items="${accountTiers}">
                        <div class="col-12 col-md-6 col-lg-4 col-xl-3">
                                <div class="card h-100 tier-card ${fn:toLowerCase(account.tierName).contains('premium') ? 'premium' : ''} ${fn:toLowerCase(account.tierName).contains('enterprise') ? 'enterprise' : ''} shadow-sm">
                                <div class="card-header bg-light bg-opacity-25 py-2">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <h6 class="card-title">Name: </h6>
                                        <span class="badge bg-${account.tierName.toLowerCase().contains('premium') ? 'warning' : account.tierName.toLowerCase().contains('enterprise') ? 'danger' : 'primary'} text-uppercase small">
                                            ${account.tierName}
                                        </span>
                                    </div>
                                </div>
                                <div class="card-body p-3">
                                    <!-- Price Section -->
                                    <div class="text-center mb-3 p-3 bg-light rounded">
                                        <h4 class="tier-price mb-1">
                                            <fmt:formatNumber value="${account.price}" type="number" pattern="#,##0"/> VND
                                        </h4>
                                        <div class="text-muted small">/ ${account.durationDays} days</div>
                                    </div>
                                    
                                    <!-- Description Section -->
                                    <div class="mb-3">
                                        <h6 class="text-muted small mb-1">Description:</h6>
                                        <p class="mb-0 small" style="min-height: 40px; overflow: hidden; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical;">
                                            ${not empty account.description ? account.description : 'No description available'}
                                        </p>
                                    </div>
                                    
                                    <!-- Features List -->
                                    <div class="tier-features small">
                                        <div class="d-flex align-items-center mb-2">
                                            <i class="fas fa-calendar-alt text-primary me-2"></i>
                                            <span>Duration: ${account.durationDays} days</span>
                                        </div>
                                        <div class="d-flex align-items-center mb-2">
                                            <i class="fas fa-tag text-primary me-2"></i>
                                            <span>Price: <fmt:formatNumber value="${account.price}" type="number" pattern="#,##0"/> VND</span>
                                        </div>
                                        <div class="d-flex align-items-center mb-2">
                                            <i class="fas fa-user-tag text-primary me-2"></i>
                                            <span>For: ${account.userTypeScope eq 'BOTH' ? 'All User Types' : account.userTypeScope eq 'Recruiter' ? 'Recruiter' : 'JobSeekers'}</span>
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <i class="fas fa-bullhorn text-primary me-2"></i>
                                            <span>Posts: ${account.jobPostLimit == 0 ? 'Unlimited' : account.jobPostLimit} ${account.jobPostLimit == 0 ? '' : 'posts'}</span>
                                        </div>
                                    </div>
                                    
                                    <div class="d-grid gap-2 mt-3">
                                        <a href="admin?action=editTier&id=${account.tierID}" class="btn btn-edit">
                                            <i class="fas fa-edit me-2"></i>Edit
                                        </a>
                                        <button type="button" class="btn btn-delete" onclick="confirmDelete(${account.tierID})">
                                            <i class="fas fa-trash-alt me-2"></i>Delete
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="?action=accounttier&page=${currentPage - 1}&pageSize=${pageSize}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                            
                            <!-- First page -->
                            <c:if test="${currentPage > 3}">
                                <li class="page-item">
                                    <a class="page-link" href="?action=accounttier&page=1&pageSize=${pageSize}">1</a>
                                </li>
                                <c:if test="${currentPage > 4}">
                                    <li class="page-item disabled">
                                        <span class="page-link">...</span>
                                    </li>
                                </c:if>
                            </c:if>
                    </div>
                </div>
            </div>
        </div>

        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
        function confirmDelete(tierId) {
            if (confirm('Bạn có chắc chắn muốn xóa gói tài khoản này? Hành động này không thể hoàn tác.')) {
                window.location.href = 'admin?action=deleteTier&id=' + tierId;
            }
        }
            
            document.addEventListener('DOMContentLoaded', function() {
                const pageSizeSelect = document.querySelector('select[name="pageSize"]');
                if (pageSizeSelect) {
                    pageSizeSelect.addEventListener('change', function() {
                        const pageSize = this.value;
                        const currentUrl = new URL(window.location.href);
                        currentUrl.searchParams.set('pageSize', pageSize);
                        currentUrl.searchParams.set('page', '1'); // Reset to first page
                        window.location.href = currentUrl.toString();
                    });
                }
            });
            
            // Format currency on input
            function formatCurrency(input) {
                // Implementation of formatCurrency function
                // Remove non-numeric characters
                let value = input.value.replace(/\D/g, '');
                
                // Format with thousand separators
                if (value.length > 0) {
                    value = parseInt(value).toLocaleString('vi-VN');
                    input.value = value;
                } else {
                    input.value = '';
                }
            }
        </script>
    </body>
</html>
