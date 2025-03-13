<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <!-- Include Font Awesome for icons -->
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
            /* Blur effect for the background */
            backdrop-filter: blur(5px); /* Slight blur */
            -webkit-backdrop-filter: blur(5px); /* Safari support */
        }

        /* Header Styles (Sticky) */
        header {
            background: linear-gradient(90deg, rgba(45, 64, 89, 0.95), rgba(34, 40, 49, 0.95)); /* Gradient header */
            padding: 20px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.4);
            position: sticky;
            top: 0;
            z-index: 1000;
            transition: box-shadow 0.3s ease;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 20px;
        }

        header:hover {
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.6);
        }

        header h1 {
            font-family: 'Montserrat', sans-serif;
            font-size: 48px;
            color: #FF5722;
            font-weight: 700;
            text-transform: uppercase;
            cursor: pointer;
            transition: color 0.3s ease, transform 0.3s ease;
            flex-grow: 1;
        }

        header h1:hover {
            color: #4A90E2; /* Soft blue accent on hover */
            transform: scale(1.05);
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
            color: #4A90E2;
            text-decoration: underline;
        }

        .logout-btn {
            padding: 10px 25px;
            background: linear-gradient(90deg, #FF5722, #FF7043); /* Gradient button */
            color: #FFFFFF;
            border: none;
            border-radius: 50px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            box-shadow: 0 4px 12px rgba(255, 87, 34, 0.4);
            transition: transform 0.2s ease, box-shadow 0.3s ease;
            text-decoration: none;
            display: inline-block;
            margin-left: auto; /* Push to the right */
        }

        .logout-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 18px rgba(255, 87, 34, 0.6);
        }

        .logout-btn:active {
            transform: translateY(0);
            box-shadow: 0 2px 8px rgba(255, 87, 34, 0.4);
        }

        /* Admin Avatar */
        .admin-avatar-container {
            display: flex;
            justify-content: center;
            padding: 5px 0 5px; /* Reduced bottom padding to close the gap */
            position: relative;
        }

        .admin-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: url('images/icons8-administrator-male-100.png'); /* Placeholder admin avatar */
            background-size: cover;
            background-position: center;
            border: 4px solid #FF5722;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.5);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            animation: float 2s ease-in-out infinite; /* Animation for up-down motion */
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-20px); } /* Move up 20px and back */
        }

        .admin-avatar:hover {
            transform: scale(1.1) translateY(-20px); /* Enhance hover with scale */
            box-shadow: 0 6px 20px rgba(74, 144, 226, 0.4);
        }

        /* Main Content Styles */
        main {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center; /* Center content vertically */
            padding: 0 20px 20px; /* Adjusted padding */
            min-height: calc(100vh - 120px); /* Adjust for header and footer */
        }

        .dashboard {
            max-width: 900px;
            width: 100%;
            padding: 30px;
            background: linear-gradient(135deg, rgba(45, 64, 89, 0.95), rgba(34, 40, 49, 0.95)); /* Gradient overlay */
            border-radius: 15px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.5);
            text-align: center;
            animation: fadeIn 0.6s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .welcome {
            font-size: 42px;
            font-weight: 700;
            color: #EEEEEE;
            margin-bottom: 30px;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        }

        .controls {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .control-card {
            background: rgba(74, 144, 226, 0.1); /* Soft blue tint */
            padding: 20px;
            border-radius: 10px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            cursor: pointer;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 10px;
        }

        .control-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 15px rgba(74, 144, 226, 0.3);
        }

        .control-card i {
            font-size: 28px;
            color: #FF5722;
            transition: color 0.3s ease;
        }

        .control-card:hover i {
            color: #4A90E2;
        }

        .control-card a {
            color: #FF5722;
            font-size: 18px;
            font-weight: 500;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .control-card a:hover {
            color: #4A90E2;
        }

        /* Footer Styles */
        footer {
            background: linear-gradient(90deg, rgba(45, 64, 89, 0.95), rgba(34, 40, 49, 0.95));
            padding: 20px;
            text-align: center;
            box-shadow: 0 -4px 15px rgba(0, 0, 0, 0.4);
        }

        footer .links {
            margin-bottom: 10px;
        }

        footer .links a {
            color: #FF5722;
            text-decoration: none;
            margin: 0 15px;
            font-size: 14px;
            transition: color 0.3s ease;
        }

        footer .links a:hover {
            color: #4A90E2;
        }

        footer p {
            font-size: 12px;
            color: #CCCCCC;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            header h1 {
                font-size: 36px;
            }

            .logout-btn {
                font-size: 14px;
                padding: 8px 20px;
            }

            .dashboard {
                padding: 30px;
            }

            .welcome {
                font-size: 32px;
            }

            .control-card a {
                font-size: 16px;
            }

            .control-card i {
                font-size: 24px;
            }

            .admin-avatar {
                width: 100px;
                height: 100px;
            }
        }

        @media (max-width: 480px) {
            header {
                flex-direction: column;
                gap: 10px;
            }

            header h1 {
                font-size: 28px;
            }

            .logout-btn {
                margin-left: 0;
                width: 100%;
                text-align: center;
            }

            .dashboard {
                padding: 15px;
            }

            .welcome {
                font-size: 24px;
            }

            .controls {
                grid-template-columns: 1fr;
            }

            .control-card a {
                font-size: 14px;
            }

            .control-card i {
                font-size: 20px;
            }

            .admin-avatar {
                width: 80px;
                height: 80px;
            }

            footer .links a {
                display: block;
                margin: 5px 0;
            }
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
    <a href="LogoutServlet" class="logout-btn">Logout</a>
</header>

<!-- Admin Avatar -->
<div class="admin-avatar-container">
    <div class="admin-avatar"></div>
</div>

<!-- Main Content -->
<main>
    <div class="dashboard">
        <div class="welcome">Welcome, Admin!</div>
        <div class="controls">
            <div class="control-card">
                <i class="fas fa-car"></i>
                <a href="manage_cars.jsp">Manage Cars</a>
            </div>
            <div class="control-card">
                <i class="fas fa-user-tie"></i>
                <a href="manage_drivers.jsp">Manage Drivers</a>
            </div>
            <div class="control-card">
                <i class="fas fa-users"></i>
                <a href="manage_customers.jsp">Manage Customers</a>
            </div>
            <div class="control-card">
                <i class="fas fa-book"></i>
                <a href="manage_bookings.jsp">Manage Bookings</a>
            </div>
            <div class="control-card">
                <i class="fas fa-chart-bar"></i>
                <a href="MonthlyBookingReportServlet">Monthly Report</a>
            </div>
        </div>
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
        const buttons = document.querySelectorAll('.logout-btn');
        buttons.forEach(button => {
            button.addEventListener('click', () => {
                button.classList.add('clicked');
                setTimeout(() => button.classList.remove('clicked'), 200); // Remove class after animation
            });
        });
    });
</script>
</body>
</html>