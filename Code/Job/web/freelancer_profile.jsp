<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.Freelancer"%>
<%
    Freelancer freelancer = (Freelancer) session.getAttribute("loggedFreelancer");
    if (freelancer == null) {
        response.sendRedirect("loginjobseeker.jsp");
        return;
    }
%>
<html>
<head>
    <title>Freelancer Profile</title>
</head>
<body>
    <h2>Thông tin Freelancer</h2>
    <form action="freelancer-profile" method="post">
        <p><strong>Username:</strong> <%=freelancer.getUsername()%></p>

        Password: <input type="password" name="password" value="<%=freelancer.getPassword()%>" /><br/>
        First Name: <input type="text" name="firstName" value="<%=freelancer.getFirstName()%>" /><br/>
        Last Name: <input type="text" name="lastName" value="<%=freelancer.getLastName()%>" /><br/>
        Image URL: <input type="text" name="image" value="<%=freelancer.getImage()%>" /><br/>
        Gender: 
        <input type="radio" name="gender" value="true" <%=freelancer.isGender() ? "checked" : ""%>> Nam
        <input type="radio" name="gender" value="false" <%=!freelancer.isGender() ? "checked" : ""%>> Nữ<br/>
        Date of Birth: <input type="date" name="dob" value="<%=freelancer.getDob()%>" /><br/>
        Mô tả: <textarea name="describe"><%=freelancer.getDescribe()%></textarea><br/>
        Email: <input type="email" name="emailContact" value="<%=freelancer.getEmailContact()%>" /><br/>
        Phone: <input type="text" name="phoneContact" value="<%=freelancer.getPhoneContact()%>" /><br/>

        <input type="submit" value="Cập nhật" />
    </form>
</body>
</html>
