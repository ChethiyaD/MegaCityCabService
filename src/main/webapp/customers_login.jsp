<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        /* Import Google Fonts for modern typography */
        @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap');
        @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@700&display=swap');

        /* Reset and Base Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Roboto', sans-serif;
            background-color: #222831;
            background-image: url('images/Customer.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            color: #EEEEEE;
            line-height: 1.6;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            overflow-x: hidden;
            backdrop-filter: blur(5px);
            -webkit-backdrop-filter: blur(5px);
        }

        header {
            background-color: rgba(45, 64, 89, 0.95);
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
            position: sticky;
            top: 0;
            z-index: 1000;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        header h1 {
            font-family: 'Montserrat', sans-serif;
            font-size: 48px;
            color: #FF5722;
            font-weight: 700;
            text-transform: uppercase;
            cursor: pointer;
            transition: color 0.3s ease;
            flex-grow: 1;
            text-align: center;
        }

        header h1:hover {
            color: #ff7f50;
        }

        .home-btn {
            background: linear-gradient(90deg, #4A90E2, #4A90E2);
            color: #FFFFFF;
            padding: 10px 20px;
            border-radius: 25px;
            font-size: 16px;
            font-weight: 500;
            text-decoration: none;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .home-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 18px rgba(74, 144, 226, 0.6);
        }

        .home-btn:active {
            transform: translateY(0);
            box-shadow: 0 2px 8px rgba(74, 144, 226, 0.4);
        }

        #admin-login {
            display: none;
            margin-top: 10px;
        }

        #admin-login a {
            color: #FF5722;
            font-size: 16px;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        #admin-login a:hover {
            color: #ff7f50;
            text-decoration: underline;
        }

        main {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px 0;
            min-height: calc(100vh - 120px);
        }

        .container {
            max-width: 400px;
            width: 100%;
            padding: 40px;
            background: rgba(45, 64, 89, 0.9);
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.5);
            text-align: center;
        }

        h2 {
            font-size: 36px;
            font-weight: 700;
            color: #EEEEEE;
            margin-bottom: 20px;
        }

        .error {
            color: #FF4444;
            margin-bottom: 15px;
            font-size: 14px;
        }

        .error-text {
            color: #FF4444;
            font-size: 12px;
            display: none;
            margin-top: 5px;
            text-align: left;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        label {
            font-size: 16px;
            text-align: left;
            color: #EEEEEE;
        }

        input {
            padding: 10px;
            border: none;
            border-radius: 6px;
            background-color: rgba(255, 255, 255, 0.1);
            color: #EEEEEE;
            font-size: 14px;
            width: 100%;
        }

        input:focus {
            outline: none;
            background-color: rgba(255, 255, 255, 0.2);
        }

        input.invalid {
            border: 1px solid #FF4444;
            background-color: rgba(255, 68, 68, 0.1);
        }

        button {
            padding: 12px;
            background-color: #FF5722;
            color: #ffffff;
            border: none;
            border-radius: 50px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.1s ease;
        }

        button:hover {
            background-color: #ff7f50;
            transform: translateY(-2px);
        }

        button:active {
            transform: translateY(0);
        }

        button.clicked {
            animation: buttonClick 0.3s ease;
        }

        a {
            color: #FF5722;
            text-decoration: none;
            font-size: 14px;
            transition: color 0.3s ease;
        }

        a:hover {
            color: #ff7f50;
            text-decoration: underline;
        }

        .password-container {
            position: relative;
            width: 100%;
        }

        .password-container input {
            width: 100%;
            padding-right: 40px;
        }

        .password-container .toggle-password {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #FF5722;
        }

        .password-container .toggle-password:hover {
            color: #ff7f50;
        }

        footer {
            background-color: rgba(45, 64, 89, 0.95);
            padding: 30px 20px;
            text-align: center;
            box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.3);
        }

        footer .links {
            margin-bottom: 10px;
        }

        footer .links a {
            color: #FF5722;
            text-decoration: none;
            margin: 0 10px;
            transition: color 0.3s ease;
        }

        footer .links a:hover {
            color: #ff7f50;
            text-decoration: underline;
        }

        footer p {
            font-size: 14px;
            margin: 0;
        }

        @media (max-width: 768px) {
            header { padding: 15px; }
            header h1 { font-size: 40px; }
            .home-btn { padding: 8px 15px; font-size: 14px; }
            .container { max-width: 90%; padding: 30px; }
            h2 { font-size: 30px; }
            button { font-size: 14px; }
        }

        @media (max-width: 480px) {
            header { padding: 10px; flex-wrap: wrap; }
            header h1 { font-size: 32px; order: 1; flex-basis: 100%; text-align: center; }
            .home-btn { padding: 6px 12px; font-size: 12px; order: 0; margin-bottom: 10px; }
            .container { padding: 20px; }
            h2 { font-size: 24px; }
            label { font-size: 14px; }
            input { font-size: 12px; }
            button { font-size: 12px; padding: 10px; }
            a { font-size: 12px; }
            footer .links a { display: block; margin: 5px 0; }
        }

        @keyframes buttonClick {
            0% { transform: scale(1); }
            50% { transform: scale(0.95); }
            100% { transform: scale(1); }
        }
    </style>
</head>
<body>
<header>
    <a href="home.jsp" class="home-btn">Home</a>
    <h1 id="title">MegaCityCab</h1>
    <div id="admin-login">
        <a href="index.jsp">Admin Login</a>
    </div>
</header>

<main>
    <div class="container">
        <h2>Customer Login</h2>
        <% String error = request.getParameter("error");
            if (error != null) { %>
        <p class="error"><%= error %></p>
        <% } %>
        <form action="login" method="post" onsubmit="return validateForm()">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
            <span id="username-error" class="error-text"></span>

            <label for="password">Password:</label>
            <div class="password-container">
                <input type="password" id="password" name="password" required>
                <i class="fas fa-eye toggle-password" id="togglePasswordIcon" onclick="togglePassword()"></i>
            </div>
            <span id="password-error" class="error-text"></span>

            <button type="submit">Login</button>
        </form>
        <p><a href="reset_password_step1.jsp">Forgot Password?</a></p>
        <p><a href="register.jsp">Register</a></p>
    </div>
</main>

<footer>
    <div class="links">
        <a href="about.jsp">About Us</a>
        <a href="contact.jsp">Contact Us</a>
    </div>
    <p>© 2025 MegaCityCab. All rights reserved.</p>
</footer>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        window.scrollTo(0, 0);

        const title = document.getElementById('title');
        const adminLogin = document.getElementById('admin-login');
        let clickCount = 0;

        title.addEventListener('click', () => {
            clickCount++;
            if (clickCount === 3) {
                adminLogin.style.display = 'block';
            }
        });

        const buttons = document.querySelectorAll('button');
        buttons.forEach(button => {
            button.addEventListener('click', () => {
                button.classList.add('clicked');
                setTimeout(() => button.classList.remove('clicked'), 300);
            });
        });

        window.togglePassword = function() {
            const passwordInput = document.getElementById("password");
            const toggleIcon = document.getElementById("togglePasswordIcon");
            if (passwordInput.type === "password") {
                passwordInput.type = "text";
                toggleIcon.classList.remove("fa-eye");
                toggleIcon.classList.add("fa-eye-slash");
            } else {
                passwordInput.type = "password";
                toggleIcon.classList.remove("fa-eye-slash");
                toggleIcon.classList.add("fa-eye");
            }
        };

        // Real-time validation
        const usernameInput = document.getElementById('username');
        const passwordInput = document.getElementById('password');
        const usernameError = document.getElementById('username-error');
        const passwordError = document.getElementById('password-error');

        usernameInput.addEventListener('input', validateUsername);
        passwordInput.addEventListener('input', validatePassword);

        function validateUsername() {
            const username = usernameInput.value.trim();
            let isValid = true;
            let errorMsg = '';

            if (username.length < 3) {
                isValid = false;
                errorMsg = 'Username must be at least 3 characters long';
            } else if (!/^[a-zA-Z0-9_]+$/.test(username)) {
                isValid = false;
                errorMsg = 'Username can only contain letters, numbers, and underscores';
            }

            if (!isValid) {
                usernameInput.classList.add('invalid');
                usernameError.textContent = errorMsg;
                usernameError.style.display = 'block';
            } else {
                usernameInput.classList.remove('invalid');
                usernameError.style.display = 'none';
            }
            return isValid;
        }

        function validatePassword() {
            const password = passwordInput.value.trim();
            let isValid = true;
            let errorMsg = '';

            if (password.length < 6) {
                isValid = false;
                errorMsg = 'Password must be at least 6 characters long';
            } else if (!/[A-Z]/.test(password)) {
                isValid = false;
                errorMsg = 'Password must contain at least one uppercase letter';
            } else if (!/[0-9]/.test(password)) {
                isValid = false;
                errorMsg = 'Password must contain at least one number';
            }

            if (!isValid) {
                passwordInput.classList.add('invalid');
                passwordError.textContent = errorMsg;
                passwordError.style.display = 'block';
            } else {
                passwordInput.classList.remove('invalid');
                passwordError.style.display = 'none';
            }
            return isValid;
        }

        window.validateForm = function() {
            const isUsernameValid = validateUsername();
            const isPasswordValid = validatePassword();
            return isUsernameValid && isPasswordValid;
        };
    });
</script>
</body>
</html>