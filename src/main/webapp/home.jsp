<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MegaCityCab - Home</title>
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
            background-image: url('images/background.jpg'); /* Page background image */
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            color: #EEEEEE; /* Light gray text */
            line-height: 1.6;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            overflow-x: hidden; /* Prevent horizontal scrolling */
        }

        /* Header Styles (Sticky) */
        header {
            background-color: rgba(45, 64, 89, 0.95); /* Semi-transparent dark blue header */
            padding: 20px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
            position: sticky; /* Sticky header */
            top: 0;
            z-index: 1000;
        }

        header h1 {
            font-family: 'Montserrat', sans-serif; /* Beautiful font */
            font-size: 48px; /* Large, bold title */
            color: #FF5722; /* Orange title */
            font-weight: 700;
            text-transform: uppercase;
            cursor: pointer;
            transition: color 0.3s ease;
        }

        header h1:hover {
            color: #ff7f50; /* Lighter orange on hover */
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

        /* Hero Section */
        .hero {
            height: 100vh; /* Full viewport height */
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            padding: 40px 20px;
            background: rgba(34, 40, 49, 0.6); /* Subtle overlay for readability */
            background-image: url('images/background.jpg'); /* Hero section background image */
            background-size: cover;
            background-position: center;
            position: relative;
        }

        .hero h2 {
            font-size: 56px; /* Large welcome message */
            font-weight: 700;
            margin-bottom: 20px;
            color: #EEEEEE;
        }

        .hero p {
            font-size: 20px;
            margin-bottom: 30px;
            color: #EEEEEE;
        }

        /* Call-to-action button in hero section */
        .hero-btn {
            padding: 15px 40px;
            background-color: #FF5722; /* Orange button */
            color: #ffffff;
            border: none;
            border-radius: 50px; /* Rounded button */
            font-size: 20px;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.1s ease;
        }

        .hero-btn:hover {
            background-color: #ff7f50; /* Lighter orange on hover */
            transform: translateY(-2px);
        }

        .hero-btn:active {
            transform: translateY(0);
        }

        .hero-btn.clicked {
            animation: buttonClick 0.3s ease;
        }

        /* Role Selection Section */
        .role-section {
            padding: 60px 20px;
            background: rgba(45, 64, 89, 0.8); /* Slightly darker section */
            text-align: center;
        }

        .role-section h3 {
            font-size: 36px;
            font-weight: 700;
            color: #EEEEEE;
            margin-bottom: 20px;
        }

        .role-section p {
            font-size: 18px;
            color: #EEEEEE;
            margin-bottom: 40px;
        }

        /* Role Selection Buttons */
        .role-btn {
            display: inline-block;
            padding: 15px 30px;
            background-color: #FF5722; /* Orange buttons */
            color: #ffffff;
            border: none;
            border-radius: 50px; /* Rounded button */
            font-size: 18px;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.1s ease;
            margin: 10px;
            width: 150px;
        }

        .role-btn:hover {
            background-color: #ff7f50; /* Lighter orange on hover */
            transform: translateY(-2px);
        }

        .role-btn:active {
            transform: translateY(0);
        }

        .role-btn.clicked {
            animation: buttonClick 0.3s ease;
        }

        /* Footer Styles */
        footer {
            background-color: rgba(45, 64, 89, 0.95); /* Semi-transparent dark blue footer */
            padding: 30px 20px;
            text-align: center;
            box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.3);
        }

        footer .about-us {
            margin-bottom: 20px;
        }

        footer .about-us h3 {
            font-size: 24px;
            font-weight: 700;
            color: #EEEEEE;
            margin-bottom: 10px;
        }

        footer .about-us p {
            font-size: 14px;
            color: #EEEEEE;
            margin-bottom: 15px;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
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
            header h1 {
                font-size: 40px;
            }

            .hero h2 {
                font-size: 48px;
            }

            .hero p {
                font-size: 18px;
            }

            .hero-btn {
                font-size: 18px;
                padding: 12px 30px;
            }

            .role-section h3 {
                font-size: 30px;
            }

            .role-section p {
                font-size: 16px;
            }

            .role-btn {
                width: 130px;
                font-size: 16px;
                padding: 12px 20px;
            }

            footer .about-us h3 {
                font-size: 20px;
            }

            footer .about-us p {
                font-size: 12px;
            }
        }

        @media (max-width: 480px) {
            header h1 {
                font-size: 32px;
            }

            .hero h2 {
                font-size: 36px;
            }

            .hero p {
                font-size: 16px;
            }

            .hero-btn {
                font-size: 16px;
                padding: 10px 25px;
            }

            .role-section h3 {
                font-size: 24px;
            }

            .role-section p {
                font-size: 14px;
            }

            .role-btn {
                width: 100px;
                font-size: 14px;
                padding: 10px 15px;
                margin: 5px;
            }

            footer .about-us h3 {
                font-size: 18px;
            }

            footer .about-us p {
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
    <h1 id="title">MegaCityCab</h1>
    <div id="admin-login">
        <a href="index.jsp">Admin Login</a>
    </div>
</header>

<!-- Hero Section -->
<section class="hero">
    <h2>Welcome to MegaCityCab</h2>
    <p>Your trusted partner for reliable and affordable transportation across the city.</p>
    <button class="hero-btn" onclick="document.getElementById('role-section').scrollIntoView({behavior: 'smooth'})">Get Started</button>
</section>

<!-- Role Selection Section -->
<section class="role-section" id="role-section">
    <h3>Choose Your Role</h3>
    <p>Select your role to proceed with MegaCityCab services:</p>
    <div class="role-btn" onclick="window.location.href='customers_login.jsp'">Customer</div>
    <div class="role-btn" onclick="window.location.href='drivers_login.jsp'">Driver</div>
</section>

<!-- Footer -->
<footer>
    <div class="about-us">
        <h3>About Us</h3>
        <p>MegaCityCab is your trusted partner for reliable and affordable transportation. We connect customers with experienced drivers across the city, ensuring a safe and comfortable ride every time.</p>
    </div>
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
        const buttons = document.querySelectorAll('.role-btn, .hero-btn');
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