<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Freelancer" %>
<%
    Freelancer f = (Freelancer) session.getAttribute("freelancer");
    if (f == null) {
        response.sendRedirect("loginjobseeker.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Freelancer Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 40px;
            background-color: #f2f2f2;
        }

        .profile-box {
            background-color: white;
            padding: 30px;
            border-radius: 12px;
            max-width: 600px;
            margin: auto;
            box-shadow: 0 6px 12px rgba(0,0,0,0.2);
        }

        .profile-box h2 {
            color: #0072ff;
        }

        .profile-img {
            width: 150px;
            border-radius: 50%;
            margin-bottom: 20px;
        }

        .info {
            font-size: 16px;
        }
    </style>
</head>
<body>

<div class="profile-box">
    <h2>Welcome, <%= f.getFirstName() + " " + f.getLastName() %></h2>
    <img src="<%= f.getImage() %>" class="profile-img" alt="Profile Image"><br>
    <div class="info">
        <strong>Username:</strong> <%= f.getUsername() %><br>
        <strong>Email:</strong> <%= f.getEmailContact() %><br>
        <strong>Phone:</strong> <%= f.getPhoneContact() %><br>
        <strong>Gender:</strong> <%= f.isGender() ? "Male" : "Female" %><br>
        <strong>DOB:</strong> <%= f.getDob() %><br>
        <strong>Status:</strong> <%= f.getStatus() %><br>
        <strong>About:</strong> <%= f.getDescribe() %><br>
    </div>
</div>

</body>
</html>