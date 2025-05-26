<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Verify OTP</title>
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
            padding: 20px;
            color: #333;
        }

        form {
            background-color: #ffffff;
            padding: 30px 25px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }

        form h2 {
            font-size: 26px;
            margin-bottom: 15px;
            color: #222;
        }

        form p {
            font-size: 15px;
            margin-bottom: 20px;
            color: #555;
        }

        .error {
            color: red;
            margin-bottom: 10px;
            font-size: 14px;
            display: block;
        }

        input[type="text"] {
            width: 100%;
            padding: 12px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
        }

        button[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #00c853; /* Màu xanh giống nút "Post A Job" */
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button[type="submit"]:hover {
            background-color: #00b44b;
        }

        form input, form button {
            margin-top: 12px;
        }
    </style>
</head>
<body>
    <form action="resetpassword" method="post">
        <h2>Verify OTP</h2>
        <p>Enter the OTP sent to your email.</p>
        
        <c:if test="${not empty errorMessage}">
            <span class="error">${errorMessage}</span>
        </c:if>

        <input type="hidden" name="action" value="verifyOTP">
        <input type="text" placeholder="Enter OTP" name="otp" required>
        <button type="submit">Verify OTP</button>
    </form>
</body>
</html>
