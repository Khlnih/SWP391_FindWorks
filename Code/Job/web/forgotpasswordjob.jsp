<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Forgot Password</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #3f86ed, #65c7f7);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #333;
        }

        form {
            background-color: #ffffff;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
            text-align: center;
        }

        h2 {
            font-size: 26px;
            margin-bottom: 15px;
            color: #111;
        }

        p {
            font-size: 15px;
            margin-bottom: 25px;
            color: #666;
        }

        .error {
            color: red;
            font-size: 14px;
            margin-bottom: 15px;
            display: block;
        }

        input[type="email"] {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ccc;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 15px;
        }

        button[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #28db67;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button[type="submit"]:hover {
            background-color: #22c45d;
        }
    </style>
</head>
<body>
    <form action="resetpasswordjob" method="post">
        <h2>Forgot Password</h2>
        <p>Enter your email to receive the OTP code.</p>

        <c:if test="${not empty errorMessage}">
            <span class="error">${errorMessage}</span>
        </c:if>

        <input type="hidden" name="action" value="sendOTP">
        <input type="email" name="email" placeholder="Enter your email" required>
        <button type="submit">Send OTP</button>
    </form>
</body>
</html>
