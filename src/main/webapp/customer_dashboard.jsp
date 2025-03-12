<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.megacitycab.models.User" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession sessionObj = request.getSession(false);
    User user = (sessionObj != null) ? (User) sessionObj.getAttribute("user") : null;
    String role = (sessionObj != null) ? (String) sessionObj.getAttribute("role") : null;

    if (user == null || role == null || !"customer".equalsIgnoreCase(role)) {
        response.sendRedirect("index.jsp?error=Unauthorized access");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Dashboard</title>
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

        /* Header Styles (Sticky) */
        header {
            background-color: rgba(45, 64, 89, 0.95);
            padding: 15px 20px;
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
            font-size: 36px;
            color: #FF5722;
            font-weight: 700;
            text-transform: uppercase;
            cursor: pointer;
            transition: color 0.3s ease;
        }

        header h1:hover {
            color: #ff7f50;
        }

        /* Profile Picture and Logout Container */
        .header-right {
            display: flex;
            align-items: center;
            gap: 10px; /* Reduced gap to move profile pic closer to logout */
        }

        .profile-container {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .profile-picture {
            width: 60px; /* Increased from 50px */
            height: 60px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #FF5722;
        }

        .profile-name {
            font-size: 16px;
            color: #EEEEEE;
        }

        /* Logout Button in Header */
        .logout-btn {
            padding: 10px 20px;
            background-color: #FF4444;
            color: #FFFFFF;
            text-decoration: none;
            border-radius: 50px;
            font-size: 14px;
            font-weight: 500;
            transition: background-color 0.3s ease, transform 0.1s ease;
        }

        .logout-btn:hover {
            background-color: #ff6666;
            transform: translateY(-2px);
        }

        /* Main Content Styles */
        main {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 20px;
        }

        .container {
            max-width: 800px;
            width: 100%;
            padding: 40px;
            background: rgba(45, 64, 89, 0.9);
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.5);
            text-align: center;
        }

        h2 {
            font-family: 'Montserrat', sans-serif;
            font-size: 36px;
            color: #FF5722;
            margin-bottom: 20px;
        }

        p {
            font-size: 18px;
            margin-bottom: 20px;
        }

        .dashboard-links {
            list-style: none;
            padding: 0;
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .dashboard-links li {
            display: inline-block;
        }

        .dashboard-links a {
            display: block;
            padding: 12px 20px;
            background-color: #FF5722;
            color: #FFFFFF;
            text-decoration: none;
            border-radius: 50px;
            font-size: 16px;
            font-weight: 500;
            transition: background-color 0.3s ease, transform 0.1s ease;
        }

        .dashboard-links a:hover {
            background-color: #ff7f50;
            transform: translateY(-2px);
        }

        /* Footer Styles */
        footer {
            background-color: rgba(45, 64, 89, 0.95);
            padding: 30px 20px;
            text-align: center;
            box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.3);
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
            margin: 10px 0 0;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            header {
                flex-wrap: wrap;
                padding: 10px 15px;
            }

            header h1 {
                font-size: 30px;
            }

            .profile-picture {
                width: 50px;
                height: 50px;
            }

            .profile-name {
                font-size: 14px;
            }

            .logout-btn {
                font-size: 12px;
                padding: 8px 15px;
            }

            .container {
                max-width: 90%;
                padding: 30px;
            }

            h2 {
                font-size: 30px;
            }

            p {
                font-size: 16px;
            }

            .dashboard-links a {
                font-size: 14px;
                padding: 10px 15px;
            }
        }

        @media (max-width: 480px) {
            header {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }

            header h1 {
                font-size: 24px;
                order: 0;
                text-align: center;
                width: 100%;
            }

            .header-right {
                flex-direction: column;
                align-items: flex-end;
            }

            .profile-container {
                flex-direction: row;
                align-items: center;
            }

            .profile-picture {
                width: 40px;
                height: 40px;
            }

            .profile-name {
                font-size: 12px;
            }

            .logout-btn {
                font-size: 12px;
                padding: 6px 12px;
            }

            .container {
                padding: 20px;
            }

            h2 {
                font-size: 24px;
            }

            p {
                font-size: 14px;
            }

            .dashboard-links a {
                font-size: 12px;
                padding: 8px 12px;
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
    <h1>MegaCityCab</h1>
    <div class="header-right">
        <div class="profile-container">
            <span class="profile-name"><%= user.getName() %></span>
            <img src="uploads/<%= user.getProfilePicture() != null ? user.getProfilePicture() : "default_profile.jpg" %>" alt="Profile Picture" class="profile-picture">
        </div>
        <a href="LogoutServlet" class="logout-btn">Logout</a>
    </div>
</header>

<!-- Main Content -->
<main>
    <div class="container">
        <h2>Welcome, <%= user.getName() %>!</h2>
        <p>You are logged in as: <strong><%= user.getUsername() %></strong></p>
        <ul class="dashboard-links">
            <li><a href="book_cab.jsp">Book a Cab</a></li>
            <li><a href="view_bookings.jsp">View My Bookings</a></li>
            <li><a href="manage_profile.jsp">Manage Profile</a></li>
        </ul>
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
</body>
</html>