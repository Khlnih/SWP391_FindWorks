<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*"%>

<!-- Toggle Button with Chevron -->
<button class="sidebar-toggle" onclick="toggleSidebar()" aria-label="Toggle Sidebar">
    <i class="fa fa-chevron-right"></i>
</button>

<!-- Sidebar -->
<aside class="sidebar" id="sidebar">
    <div class="sidebar-header">
        <div class="logo-container">
            <i class="fa fa-shield-alt logo-icon"></i>
            <h3 class="logo-text">Admin Panel</h3>
        </div>
        <div class="sidebar-close" onclick="toggleSidebar()" title="Collapse Menu">
            <i class="fa fa-times"></i>
        </div>
    </div>
    
<!--    <div class="sidebar-profile">
        <div class="profile-avatar">
            <i class="fa fa-user-circle"></i>
        </div>
        <div class="profile-info">
            <div class="profile-name">${sessionScope.admin.name}</div>
            <div class="profile-role">Administrator</div>
        </div>
    </div>-->
    
    <nav class="sidebar-nav">
        <ul class="nav-menu">
            <li class="nav-item">
                <a href="admin?action=dashboard" class="nav-link ${param.action == 'dashboard' || empty param.action ? 'active' : ''}">
                    <i class="fa fa-tachometer-alt"></i>
                    <span class="link-text">Dashboard</span>
                    <span class="link-badge"></span>
                </a>
            </li>
            
            <li class="nav-item">
                <a href="admin?action=jobseekers" class="nav-link ${param.action == 'jobseekers' ? 'active' : ''}">
<!--                    <i class="fa fa-users"></i>-->
                    <span class="link-text">Manager JobSeekers</span>
                </a>
            </li>
            
            <li class="nav-item">
                <a href="admin?action=recruiters" class="nav-link ${param.action == 'recruiters' ? 'active' : ''}">
<!--                    <i class="fa fa-user-tie"></i>-->
                    <span class="link-text">Manager Recruiters</span>
                </a>
            </li>
            
            <li class="nav-item">
                <a href="admin?action=jobs" class="nav-link ${param.action == 'jobs' ? 'active' : ''}">
<!--                    <i class="fa fa-briefcase"></i>-->
                    <span class="link-text">Job Listings</span>
                </a>
            </li>
            
            <li class="nav-item">
                <a href="admin?action=skills" class="nav-link ${param.action == 'skills' ? 'active' : ''}">
<!--                    <i class="fa fa-cogs"></i>-->
                    <span class="link-text">Skills</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="admin?action=accounttier" class="nav-link ${param.action == 'skills' ? 'active' : ''}">
<!--                    <i class="fa fa-cogs"></i>-->
                    <span class="link-text">Manager account tier</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="admin?action=registration" class="nav-link ${param.action == 'skills' ? 'active' : ''}">
<!--                    <i class="fa fa-cogs"></i>-->
                    <span class="link-text">Manager tier registrations</span>
                </a>
            </li>
            
            
            <li class="nav-divider"></li>
            
            <li class="nav-item">
                <a href="admin?action=settings" class="nav-link ${param.action == 'settings' ? 'active' : ''}">
                    <i class="fa fa-cog"></i>
                    <span class="link-text">Settings</span>
                </a>
            </li>
            
            <li class="nav-item">
                <a href="admin?action=help" class="nav-link ${param.action == 'help' ? 'active' : ''}">
                    <i class="fa fa-question-circle"></i>
                    <span class="link-text">Help & Support</span>
                </a>
            </li>
            
            <li class="nav-item logout-item">
                <a href="logout.jsp" class="nav-link">
                    <i class="fa fa-sign-out-alt"></i>
                    <span class="link-text">Logout</span>
                </a>
            </li>
        </ul>
    </nav>
    
    <div class="sidebar-footer">
        <div class="system-status">
            <div class="status-indicator online"></div>
            <span>Account Status: <strong>Online</strong></span>
        </div>
    </div>
</aside>

<!-- Sidebar Styles -->
<style>
    /* Sidebar Variables - Even Brighter Theme */
    :root {
        --sidebar-width: 280px;
        --sidebar-bg: #4d7ba6;
        --sidebar-text: #ffffff;
        --sidebar-hover: #5f8cb8;
        --sidebar-active: #5da8ff;
        --sidebar-border: rgba(255, 255, 255, 0.2);
        --sidebar-transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        --sidebar-shadow: 2px 0 15px rgba(0, 0, 0, 0.2);
        --sidebar-header-height: 70px;
        --sidebar-footer-height: 70px;
    }
    
    /* Sidebar Base Styles */
    .sidebar {
        width: var(--sidebar-width);
        height: 100vh;
        position: fixed;
        left: calc(-1 * var(--sidebar-width));
        top: 0;
        background: var(--sidebar-bg);
        color: var(--sidebar-text);
        box-shadow: var(--sidebar-shadow);
        transition: var(--sidebar-transition);
        z-index: 1100;
        display: flex;
        flex-direction: column;
        overflow: hidden;
    }
    
    .sidebar.active {
        left: 0;
    }
    
    /* Sidebar Header */
    .sidebar-header {
        padding: 0 20px;
        height: var(--sidebar-header-height);
        display: flex;
        align-items: center;
        justify-content: space-between;
        border-bottom: 1px solid var(--sidebar-border);
        background: rgba(0, 0, 0, 0.1);
    }
    
    .logo-container {
        display: flex;
        align-items: center;
        gap: 12px;
    }
    
    .logo-icon {
        font-size: 1.8rem;
        color: var(--sidebar-active);
    }
    
    .logo-text {
        margin: 0;
        font-size: 1.4rem;
        font-weight: 600;
        color: white;
        letter-spacing: 0.5px;
    }
    
    .sidebar-close {
        padding: 8px;
        cursor: pointer;
        color: var(--sidebar-text);
        opacity: 0.7;
        transition: var(--sidebar-transition);
        border-radius: 4px;
    }
    
    .sidebar-close:hover {
        opacity: 1;
        background: rgba(255, 255, 255, 0.1);
    }
    
    /* Profile Section */
    .sidebar-profile {
        padding: 20px;
        display: flex;
        align-items: center;
        gap: 15px;
        border-bottom: 1px solid var(--sidebar-border);
        background: rgba(0, 0, 0, 0.1);
    }
    
    .profile-avatar {
        width: 50px;
        height: 50px;
        border-radius: 50%;
        background: rgba(255, 255, 255, 0.1);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 24px;
        color: var(--sidebar-active);
    }
    
    .profile-info {
        flex: 1;
        overflow: hidden;
    }
    
    .profile-name {
        font-weight: 600;
        font-size: 1rem;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }
    
    .profile-role {
        font-size: 0.8rem;
        opacity: 0.8;
        margin-top: 3px;
    }
    
    /* Navigation Menu */
    .sidebar-nav {
        flex: 1;
        overflow-y: auto;
        padding: 15px 0;
        scrollbar-width: thin;
        scrollbar-color: rgba(255, 255, 255, 0.2) transparent;
    }
    
    .sidebar-nav::-webkit-scrollbar {
        width: 5px;
    }
    
    .sidebar-nav::-webkit-scrollbar-thumb {
        background: rgba(255, 255, 255, 0.2);
        border-radius: 10px;
    }
    
    .nav-menu {
        list-style: none;
        padding: 0;
        margin: 0;
    }
    
    .nav-item {
        margin: 5px 0;
    }
    
    .nav-link {
        display: flex;
        align-items: center;
        padding: 12px 25px;
        color: var(--sidebar-text);
        text-decoration: none;
        transition: var(--sidebar-transition);
        position: relative;
        opacity: 0.9;
    }
    
    .nav-link:hover {
        background: var(--sidebar-hover);
        padding-left: 30px;
        opacity: 1;
    }
    
    .nav-link i {
        font-size: 1.1rem;
        width: 24px;
        text-align: center;
        margin-right: 15px;
        transition: var(--sidebar-transition);
    }
    
    .nav-link .link-text {
        flex: 1;
        font-size: 0.95rem;
        font-weight: 500;
        transition: var(--sidebar-transition);
    }
    
    .link-badge {
        background: var(--sidebar-active);
        color: white;
        font-size: 0.7rem;
        font-weight: 600;
        padding: 2px 8px;
        border-radius: 10px;
        margin-left: 10px;
    }
    
    .nav-link.active {
        background: var(--sidebar-active);
        color: white;
        opacity: 1;
    }
    
    .nav-link.active .link-badge {
        background: white;
        color: var(--sidebar-active);
    }
    
    .nav-divider {
        height: 1px;
        background: var(--sidebar-border);
        margin: 15px 25px;
    }
    
    .logout-item .nav-link {
        color: #e74c3c;
    }
    
    .logout-item .nav-link:hover {
        background: rgba(231, 76, 60, 0.1);
    }
    
    /* Sidebar Footer */
    .sidebar-footer {
        padding: 15px 20px;
        border-top: 1px solid var(--sidebar-border);
        font-size: 0.8rem;
        background: rgba(0, 0, 0, 0.1);
    }
    
    .system-status {
        display: flex;
        align-items: center;
        gap: 8px;
        margin-bottom: 5px;
    }
    
    .status-indicator {
        width: 10px;
        height: 10px;
        border-radius: 50%;
        background: #2ecc71;
    }
    
    .status-indicator.online {
        background: #2ecc71;
        box-shadow: 0 0 10px #2ecc71;
    }
    
    .app-version {
        opacity: 0.6;
        font-size: 0.75rem;
    }
    
    /* Toggle Button - Top Left Arrow */
    .sidebar-toggle {
        position: fixed;
        top: 20px;
        left: 0;
        background: var(--sidebar-active);
        color: white;
        border: none;
        border-top-right-radius: 4px;
        border-bottom-right-radius: 4px;
        width: 40px;
        height: 40px;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        z-index: 1050;
        box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
        transition: all 0.3s ease;
        padding: 0;
        margin: 0;
        opacity: 0.9;
    }
    
    .sidebar-toggle i {
        font-size: 1.2rem;
        transition: transform 0.3s ease;
    }
    
    .sidebar-toggle:hover {
        opacity: 1;
        transform: translateX(2px);
        box-shadow: 3px 3px 8px rgba(0, 0, 0, 0.25);
    }
    
    .sidebar.active + .sidebar-toggle {
        left: var(--sidebar-width);
        transform: rotate(180deg);
        background: var(--sidebar-hover);
        opacity: 1;
    }
    
    .sidebar.active + .sidebar-toggle:hover {
        transform: rotate(180deg) translateX(2px);
    }
    
    .sidebar-toggle:hover {
        transform: scale(1.1);
    }
    
    .sidebar.active + .sidebar-toggle:hover {
        transform: translateX(-100%) scale(1.1);
    }
    
    /* Responsive Adjustments */
    @media (max-width: 992px) {
        .sidebar {
            left: calc(-1 * var(--sidebar-width));
            box-shadow: 2px 0 20px rgba(0, 0, 0, 0.2);
        }
        
        .sidebar.active {
            left: 0;
        }
    }
    
    /* Animation for sidebar items */
    @keyframes slideIn {
        from {
            opacity: 0;
            transform: translateX(-20px);
        }
        to {
            opacity: 1;
            transform: translateX(0);
        }
    }
    
    .nav-item {
        animation: slideIn 0.3s ease-out forwards;
        opacity: 0;
    }
    
    .nav-item:nth-child(1) { animation-delay: 0.1s; }
    .nav-item:nth-child(2) { animation-delay: 0.15s; }
    .nav-item:nth-child(3) { animation-delay: 0.2s; }
    .nav-item:nth-child(4) { animation-delay: 0.25s; }
    .nav-item:nth-child(5) { animation-delay: 0.3s; }
    .nav-item:nth-child(6) { animation-delay: 0.35s; }
    .nav-item:nth-child(7) { animation-delay: 0.4s; }
    .nav-item:nth-child(8) { animation-delay: 0.45s; }
    .nav-item:nth-child(9) { animation-delay: 0.5s; }

    .menu-item.active i {
        color: white;
    }

    /* Toggle Button */
    .toggle-btn {
        position: fixed;
        top: 20px;
        left: 20px;
        background: var(--primary-color, #2196F3);
        color: white;
        border: none;
        border-radius: 50%;
        width: 40px;
        height: 40px;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        z-index: 1001;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        transition: all 0.3s ease;
    }

    .toggle-btn:hover {
        background: var(--primary-dark, #0D47A1);
        transform: scale(1.05);
    }

    /* Responsive Adjustments */
    @media (max-width: 768px) {
        .sidebar {
            width: 220px;
        }
        
        .main-content {
            margin-left: 0;
        }
        
        .sidebar.active ~ .main-content {
            margin-left: 220px;
        }
    }
</style>

<!-- Sidebar Script -->
<script>
    // Toggle sidebar
    function toggleSidebar() {
        const sidebar = document.getElementById('sidebar');
        const content = document.querySelector('.main-content');
        sidebar.classList.toggle('active');
        if (content) {
            content.classList.toggle('active');
        }
    }

    // Close sidebar when clicking outside
    document.addEventListener('click', function(event) {
        const sidebar = document.getElementById('sidebar');
        const toggleBtn = document.querySelector('.toggle-btn');
        
        if (sidebar && toggleBtn && !sidebar.contains(event.target) && !toggleBtn.contains(event.target)) {
            sidebar.classList.remove('active');
            const content = document.querySelector('.main-content');
            if (content) {
                content.classList.remove('active');
            }
        }
    });
</script>
