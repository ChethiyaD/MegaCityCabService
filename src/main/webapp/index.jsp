<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
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
            background-color: #222831; /* Dark gray background */
            background-image: url('images/Admin.jpg'); /* Page background image */
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            color: #EEEEEE; /* Light gray text */
            line-height: 1.6;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            overflow-x: hidden; /* Prevent horizontal scrolling */
            /* Blur effect for the background */
            backdrop-filter: blur(5px); /* Slight blur */
            -webkit-backdrop-filter: blur(5px); /* Safari support */
        }

        /* Header Styles (Sticky) */
        header {
            background-color: rgba(45, 64, 89, 0.95); /* Semi-transparent dark blue header */
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
            position: sticky; /* Sticky header */
            top: 0;
            z-index: 1000;
            display: flex; /* Use flexbox for layout */
            justify-content: space-between; /* Space between home button and title */
            align-items: center; /* Vertically center items */
        }

        header h1 {
            font-family: 'Montserrat', sans-serif; /* Beautiful font */
            font-size: 48px; /* Large, bold title */
            color: #FF5722; /* Orange title */
            font-weight: 700;
            text-transform: uppercase;
            cursor: pointer;
            transition: color 0.3s ease;
            flex-grow: 1; /* Allow title to take available space */
            text-align: center; /* Keep title centered */
        }

        header h1:hover {
            color: #ff7f50; /* Lighter orange on hover */
        }

        /* Home Button Styles */
        .home-btn {
            background: linear-gradient(90deg, #4A90E2, #4A90E2); /* Blue gradient */
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

        /* Main Content Styles */
        main {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px 0;
            min-height: calc(100vh - 120px); /* Adjust for header and footer */
        }

        .container {
            max-width: 400px; /* Compact size for login form */
            width: 100%;
            padding: 30px;
            background: rgba(45, 64, 89, 0.9); /* Semi-transparent dark blue container */
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
            color: #FF4444; /* Red for error messages */
            margin-bottom: 15px;
            font-size: 14px;
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

        button {
            padding: 12px;
            background-color: #FF5722; /* Orange button */
            color: #ffffff;
            border: none;
            border-radius: 50px; /* Rounded button */
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.1s ease;
        }

        button:hover {
            background-color: #ff7f50; /* Lighter orange on hover */
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

        /* Footer Styles */
        footer {
            background-color: rgba(45, 64, 89, 0.95); /* Semi-transparent dark blue footer */
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

        /* Responsive Design */
        @media (max-width: 768px) {
            header {
                padding: 15px;
            }

            header h1 {
                font-size: 40px;
            }

            .home-btn {
                padding: 8px 15px;
                font-size: 14px;
            }

            .container {
                max-width: 90%;
                padding: 30px;
            }

            h2 {
                font-size: 30px;
            }

            button {
                font-size: 14px;
            }
        }

        @media (max-width: 480px) {
            header {
                padding: 10px;
                flex-wrap: wrap; /* Allow wrapping if space is tight */
            }

            header h1 {
                font-size: 32px;
                order: 1; /* Ensure title stays in the center */
                flex-basis: 100%; /* Take full width on small screens */
                text-align: center;
            }

            .home-btn {
                padding: 6px 12px;
                font-size: 12px;
                order: 0; /* Place home button first */
                margin-bottom: 10px;
            }

            .container {
                padding: 20px;
            }

            h2 {
                font-size: 24px;
            }

            label {
                font-size: 14px;
            }

            input {
                font-size: 12px;
            }

            button {
                font-size: 12px;
                padding: 10px;
            }

            a {
                font-size: 12px;
            }

            footer .links a {
                display: block;
                margin: 5px 0;
            }
        }

        /* Animations */
        @keyframes buttonClick {
            0% { transform: scale(1); }
            50% { transform: scale(0.95); }
            100% { transform: scale(1); }
        }
    </style>
</head>
<body>
<!-- Header -->
<header>
    <a href="home.jsp" class="home-btn">Home</a>
    <h1 id="title">MegaCityCab</h1>
    <div id="admin-login">
        <a href="index.jsp">Admin Login</a>
    </div>
</header>

<!-- Main Content -->
<main>
    <div class="container">
        <h2>Login</h2>
        <% String error = request.getParameter("error");
            if (error != null) { %>
        <p class="error"><%= error %></p>
        <% } %>
        <form action="login" method="post">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required><br>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required><br>
            <button type="submit">Login</button>
        </form>
    </div>
</main>

<!-- Footer -->
<footer>
    <div class="links">
        <a href="about.jsp">About Us</a>
        <a href="contact.jsp">Contact Us</a>
    </div>
    <p>© 2025 MegaCityCab. All rights reserved.</p>
</footer>

<!-- JavaScript for Admin Login reveal and button animation -->
<script>
    document.addEventListener('DOMContentLoaded', () => {
        // Ensure the page starts at the top
        window.scrollTo(0, 0);

        const title = document.getElementById('title');
        const adminLogin = document.getElementById('admin-login');
        let clickCount = 0;

        // Reveal Admin Login after 3 clicks on the title
        title.addEventListener('click', () => {
            clickCount++;
            if (clickCount === 3) {
                adminLogin.style.display = 'block';
            }
        });

        // Button click animation
        const buttons = document.querySelectorAll('button');
        buttons.forEach(button => {
            button.addEventListener('click', () => {
                button.classList.add('clicked');
                setTimeout(() => button.classList.remove('clicked'), 300); // Remove class after animation
            });
        });
    });
</script>
</body>
</html>