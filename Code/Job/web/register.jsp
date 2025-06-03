<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Đăng ký</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        :root {
            --primary-color: #00b14f;
            --primary-hover: #019147;
            --input-border: #ccc;
            --text-dark: #333;
            --text-light: #555;
            --bg-color: #f7f7f7;
        }

        * {
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #0072ff;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding: 40px 16px;
            min-height: 100vh;
        }

        .form-container {
            background: #fff;
            padding: 32px;
            border-radius: 16px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
        }

        .form-container h2 {
            text-align: center;
            margin-bottom: 24px;
            color: var(--text-dark);
        }

        .form-group {
            margin-bottom: 18px;
        }

        .form-row {
            display: flex;
            gap: 16px;
            margin-bottom: 15px;
            flex-wrap: wrap;
        }

        .form-row .form-group {
            flex: 1;
            min-width: 48%;
        }

        label {
            font-weight: 600;
            display: block;
            margin-bottom: 6px;
            color: var(--text-light);
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        input[type="date"],
        select {
            width: 100%;
            padding: 10px 14px;
            border: 1px solid var(--input-border);
            border-radius: 8px;
            font-size: 15px;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        input:focus,
        select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(0, 177, 79, 0.15);
            outline: none;
        }

        .submit-btn {
            width: 100%;
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 12px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .submit-btn:hover {
            background-color: var(--primary-hover);
        }

        .error-message {
            color: red;
            text-align: center;
            margin-top: 10px;
        }

        ::placeholder {
            color: #aaa;
        }

        @media (max-width: 600px) {
            .form-row {
                flex-direction: column;
            }
            .form-row .form-group {
                min-width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Đăng ký tài khoản Recruiter</h2>
        <form method="post" action="recruitregister" onsubmit="return validateForm()">
            <div class="form-row">
                <div class="form-group">
                    <label for="lastName">Họ</label>
                    <input type="text" id="lastName" name="lastName" placeholder="Nhập họ">
                </div>
                <div class="form-group">
                    <label for="firstName">Tên</label>
                    <input type="text" id="firstName" name="firstName" placeholder="Nhập tên">
                </div>
            </div>

            <div class="form-group">
                <label for="phone">Số điện thoại</label>
                <input type="text" id="phone" name="phone" placeholder="Số điện thoại">
            </div>

            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="Sử dụng email có thật để xác thực" required>
            </div>

            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required>
            </div>

            <div class="form-group">
                <label for="password">Mật khẩu</label>
                <input type="password" id="password" name="password" placeholder="Từ 6 đến 50 ký tự, 1 chữ hoa, 1 số" required>
            </div>

            <div class="form-group">
                <label for="confirmPassword">Nhập lại mật khẩu</label>
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Xác nhận mật khẩu" required>
            </div>

            <div class="form-group">
                <label for="gender">Giới tính</label>
                <select id="gender" name="gender">
                    <option value="true">Nam</option>
                    <option value="false">Nữ</option>
                </select>
            </div>

            <div class="form-group">
                <label for="dob">Ngày sinh</label>
                <input type="date" id="dob" name="dob">
            </div>

            <input type="submit" class="submit-btn" value="Đăng ký">
        </form>

        <% if (request.getAttribute("error") != null) { %>
        <div class="error-message"><%= request.getAttribute("error") %></div>
        <% } %>
    </div>

    <script>
        function validateForm() {
            const phone = document.getElementById("phone").value.trim();
            const password = document.getElementById("password").value;
            const confirmPassword = document.getElementById("confirmPassword").value;

            const phoneRegex = /^[0-9]{9,11}$/;
            const passwordRegex = /^(?=.*[A-Z])(?=.*\d).{6,50}$/;

            if (!phoneRegex.test(phone)) {
                alert("Số điện thoại phải từ 9 đến 11 chữ số.");
                return false;
            }

            if (!passwordRegex.test(password)) {
                alert("Mật khẩu phải từ 6 đến 50 ký tự, chứa ít nhất 1 chữ hoa và 1 số.");
                return false;
            }

            if (password !== confirmPassword) {
                alert("Mật khẩu xác nhận không khớp.");
                return false;
            }

            return true;
        }
    </script>
</body>
</html>