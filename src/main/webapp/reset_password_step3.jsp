<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reset Password - Step 3</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@700&display=swap" rel="stylesheet">

    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        html, body {
            height: 100%;
            font-family: 'Roboto', sans-serif;
            background-color: #222831;
            background-image: url('images/Customer.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            color: #EEEEEE;
            line-height: 1.4;
            overflow-x: hidden;
        }
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        header {
            background: linear-gradient(90deg, rgba(45, 64, 89, 0.95), rgba(34, 40, 49, 0.95));
            padding: 15px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.4);
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        header h2 {
            font-family: 'Montserrat', sans-serif;
            font-size: 36px;
            color: #FF5722;
            font-weight: 700;
            text-transform: uppercase;
            margin: 0;
        }
        main {
            flex: 1 0 auto;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 5px;
        }
        .container {
            width: 100%;
            max-width: 500px;
            padding: 15px;
            background: linear-gradient(135deg, rgba(45, 64, 89, 0.95), rgba(34, 40, 49, 0.95));
            border-radius: 10px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.5);
            text-align: center;
            animation: fadeIn 0.6s ease-in-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes fadeOut {
            from { opacity: 1; }
            to { opacity: 0; }
        }
        h2 {
            font-family: 'Montserrat', sans-serif;
            font-size: 24px;
            color: #FF5722;
            margin-bottom: 10px;
        }
        #message {
            display: none;
            max-width: 350px;
            margin: 10px auto;
            padding: 8px;
            border-radius: 20px;
            text-align: center;
            font-weight: 500;
            color: #FFFFFF;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.5);
            animation: fadeIn 0.5s ease-in, fadeOut 0.5s ease-out 3s forwards;
        }
        #message.error { background: linear-gradient(90deg, #F44336, #EF5350); }
        #message.success { background: linear-gradient(90deg, #4CAF50, #66BB6A); }
        form {
            display: flex;
            flex-direction: column;
            gap: 8px;
            max-width: 350px;
            margin: 0 auto;
        }
        label {
            font-size: 14px;
            font-weight: 500;
            color: #EEEEEE;
            text-align: left;
            margin-bottom: 2px;
        }
        input[type="password"],
        input[type="hidden"] {
            padding: 6px;
            font-size: 12px;
            border: none;
            border-radius: 8px;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid #4A90E2;
            color: #EEEEEE;
            width: 100%;
            box-sizing: border-box;
            transition: box-shadow 0.3s ease;
        }
        input[type="password"]:focus {
            outline: none;
            box-shadow: 0 0 8px rgba(255, 87, 34, 0.5);
            border-color: #FF5722;
        }
        input[type="hidden"] { display: none; }
        button[type="submit"] {
            padding: 8px 20px;
            background: linear-gradient(90deg, #FF5722, #FF7043);
            color: #FFFFFF;
            border: none;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        button[type="submit"]:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(255, 87, 34, 0.6);
        }
        a.back-btn {
            display: inline-block;
            margin-top: 10px;
            padding: 8px 20px;
            background: linear-gradient(90deg, #4A90E2, #4A90E2);
            color: #FFFFFF;
            text-decoration: none;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        a.back-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(74, 144, 226, 0.6);
        }
        footer {
            background: linear-gradient(90deg, rgba(45, 64, 89, 0.95), rgba(34, 40, 49, 0.95));
            padding: 15px;
            text-align: center;
            box-shadow: 0 -4px 15px rgba(0, 0, 0, 0.4);
            flex-shrink: 0;
        }
        footer .links a {
            color: #FF5722;
            text-decoration: none;
            margin: 0 10px;
            font-size: 12px;
            transition: color 0.3s ease;
        }
        footer .links a:hover { color: #4A90E2; }
        footer p { font-size: 10px; color: #CCCCCC; margin: 0; }
        @media (max-width: 768px) {
            header h2 { font-size: 30px; }
            .container { padding: 10px; }
            h2 { font-size: 20px; }
            input[type="password"] { font-size: 11px; }
            button[type="submit"], a.back-btn { padding: 6px 15px; font-size: 12px; }
        }
        @media (max-width: 480px) {
            header { padding: 10px; }
            header h2 { font-size: 24px; }
            .container { padding: 8px; max-width: 400px; }
            h2 { font-size: 18px; }
            label { font-size: 12px; }
            input[type="password"] { font-size: 10px; padding: 5px; }
            button[type="submit"], a.back-btn { padding: 5px 12px; font-size: 11px; }
            footer .links a { display: block; margin: 3px 0; }
        }
    </style>

    <script>
        window.onload = function() {
            const urlParams = new URLSearchParams(window.location.search);
            const error = urlParams.get('error');
            const message = urlParams.get('message');
            const messageDiv = document.getElementById("message");

            if (error) {
                messageDiv.textContent = error;
                messageDiv.className = "error";
                messageDiv.style.display = "block";
                setTimeout(() => {
                    messageDiv.style.opacity = "0";
                    setTimeout(() => {
                        messageDiv.style.display = "none";
                        messageDiv.style.opacity = "1";
                    }, 500);
                }, 3000);
            } else if (message) {
                messageDiv.textContent = message;
                messageDiv.className = "success";
                messageDiv.style.display = "block";
                setTimeout(() => {
                    messageDiv.style.opacity = "0";
                    setTimeout(() => {
                        messageDiv.style.display = "none";
                        messageDiv.style.opacity = "1";
                    }, 500);
                }, 3000);
            }
        };
    </script>
</head>
<body>
<header>
    <h2>Reset Password - Step 3</h2>
</header>
<main>
    <div class="container">
        <div id="message"></div>
        <form action="ResetPasswordServlet" method="post">
            <input type="hidden" name="step" value="3">
            <label for="newPassword">New Password:</label>
            <input type="password" id="newPassword" name="newPassword" required>
            <label for="confirmPassword">Confirm Password:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required>
            <button type="submit">Reset Password</button>
        </form>
        <a href="index.jsp" class="back-btn">Back to Login</a>
    </div>
</main>
<footer>
    <div class="links">
        <a href="about.jsp">About Us</a>
        <a href="contact.jsp">Contact Us</a>
    </div>
    <p>© 2025 MegaCityCab. All rights reserved.</p>
</footer>
</body>
</html>