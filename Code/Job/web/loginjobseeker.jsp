<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - Job Board</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #00c6ff, #0072ff);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #fff;
        }

        .login-container {
            background-color: #ffffff;
            color: #333;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.3);
            width: 350px;
            text-align: center;
        }

        .login-container h2 {
            margin-bottom: 20px;
            font-size: 26px;
            color: #0072ff;
        }

        .login-container input[type="text"],
        .login-container input[type="password"] {
            width: 90%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
        }

        .login-container input[type="submit"] {
            width: 95%;
            padding: 12px;
            background-color: #00c851;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s ease;
            margin-top: 10px;
        }

        .login-container input[type="submit"]:hover {
            background-color: #007e33;
        }

        .login-links {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
            font-size: 14px;
        }

        .login-links a {
            color: #0072ff;
            text-decoration: none;
        }

        .login-links a:hover {
            text-decoration: underline;
        }

        .error-message {
            margin-top: 15px;
            color: red;
            font-size: 14px;
        }

    </style>
</head>
<body>

<div class="login-container">
    <h2>Login to Your Account</h2>
    <form action="login" method="post">
        <input type="text" id="usernameOrEmail" name="usernameOrEmail" placeholder="Username or Email" required>

        <input type="password" id="password" name="password" placeholder="Password" required>

        <input type="submit" value="Login">

        <c:if test="${not empty error}">
            <p class="error-message">${error}</p>
        </c:if>
    </form>

    <div class="login-links">
        <a href="registerjoseeker.jsp">Register</a>
        <a href="forgotpasswordjob.jsp">Forgot Password?</a>
    </div>
</div>

</body>
</html>
