<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.megacitycab.models.User, com.megacitycab.dao.UserDAO" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession sessionObj = request.getSession(false);
    User user = (sessionObj != null) ? (User) sessionObj.getAttribute("user") : null;

    if (user == null || user.getRole() == null || !"driver".equals(user.getRole())) {
        response.sendRedirect("index.jsp?error=Unauthorized access");
        return;
    }

    String success = request.getParameter("success");
    String error = request.getParameter("error");
    String message = success != null ? success : (error != null ? error : null);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Driver Profile</title>
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
            line-height: 1.6;
            overflow-x: hidden;
        }
        body {
            display: flex;
            flex-direction: column;
        }
        header {
            background: linear-gradient(90deg, rgba(45, 64, 89, 0.95), rgba(34, 40, 49, 0.95));
            padding: 20px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.4);
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        header h2 {
            font-family: 'Montserrat', sans-serif;
            font-size: 48px;
            color: #FF5722;
            font-weight: 700;
            text-transform: uppercase;
            margin: 0;
        }
        main {
            flex: 1 0 auto;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding: 10px;
            overflow-y: auto;
        }
        .container {
            width: 100%;
            max-width: 600px; /* Keep a reasonable max-width for readability */
            padding: 20px;
            background: linear-gradient(135deg, rgba(45, 64, 89, 0.95), rgba(34, 40, 49, 0.95));
            border-radius: 15px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.5);
            text-align: center;
            animation: fadeIn 0.6s ease-in-out;
            max-height: calc(100vh - 140px);
            overflow-y: auto;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes fadeOut {
            from { opacity: 1; }
            to { opacity: 0; }
        }
        h2 {
            font-family: 'Montserrat', sans-serif;
            font-size: 36px;
            color: #FF5722;
            margin-bottom: 20px;
        }
        #message {
            display: none;
            max-width: 400px;
            margin: 20px auto;
            padding: 15px;
            background: linear-gradient(90deg, #4CAF50, #66BB6A);
            border-radius: 25px;
            text-align: center;
            font-weight: 500;
            color: #FFFFFF;
            box-shadow: 0 4px 15px rgba(76, 175, 80, 0.5);
            animation: fadeIn 0.5s ease-in, fadeOut 0.5s ease-out 3s forwards;
        }
        #message.error {
            background: linear-gradient(90deg, #F44336, #EF5350);
            box-shadow: 0 4px 15px rgba(244, 67, 54, 0.5);
        }
        form {
            display: flex;
            flex-direction: column;
            gap: 15px;
            max-width: 400px;
            margin: 0 auto;
        }
        label {
            font-size: 16px;
            font-weight: 500;
            color: #EEEEEE;
            text-align: left;
        }
        input[type="text"],
        input[type="file"] {
            padding: 10px;
            font-size: 14px;
            border: none;
            border-radius: 10px;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid #4A90E2;
            color: #EEEEEE;
            width: 100%;
            box-sizing: border-box;
            transition: box-shadow 0.3s ease;
        }
        input[type="text"]:focus,
        input[type="file"]:focus {
            outline: none;
            box-shadow: 0 0 10px rgba(255, 87, 34, 0.5);
            border-color: #FF5722;
        }
        input[type="hidden"] {
            display: none;
        }
        input[type="submit"] {
            padding: 10px 25px;
            background: linear-gradient(90deg, #FF5722, #FF7043);
            color: #FFFFFF;
            border: none;
            border-radius: 25px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        input[type="submit"]:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 18px rgba(255, 87, 34, 0.6);
        }
        input[type="submit"]:active {
            transform: translateY(0);
            box-shadow: 0 2px 8px rgba(255, 87, 34, 0.4);
        }
        a.back-btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 25px;
            background: linear-gradient(90deg, #4A90E2, #4A90E2);
            color: #FFFFFF;
            text-decoration: none;
            border-radius: 25px;
            font-size: 16px;
            font-weight: 600;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        a.back-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 18px rgba(74, 144, 226, 0.6);
        }
        footer {
            background: linear-gradient(90deg, rgba(45, 64, 89, 0.95), rgba(34, 40, 49, 0.95));
            padding: 20px;
            text-align: center;
            box-shadow: 0 -4px 15px rgba(0, 0, 0, 0.4);
            flex-shrink: 0;
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
            margin: 0;
        }
        @media (max-width: 768px) {
            header h2 { font-size: 36px; }
            .container { padding: 15px; }
            h2 { font-size: 30px; }
            #message { max-width: 100%; padding: 10px; }
            input[type="text"], input[type="file"] { font-size: 14px; }
            input[type="submit"] { padding: 8px 20px; font-size: 14px; }
            a.back-btn { padding: 8px 20px; font-size: 14px; }
        }
        @media (max-width: 480px) {
            header { padding: 15px; }
            header h2 { font-size: 28px; }
            .container { padding: 10px; }
            h2 { font-size: 24px; }
            #message { font-size: 12px; }
            input[type="text"], input[type="file"] { font-size: 12px; }
            input[type="submit"] { padding: 6px 15px; font-size: 12px; }
            a.back-btn { padding: 6px 15px; font-size: 12px; }
            footer .links a { display: block; margin: 5px 0; }
        }
    </style>

    <script>
        window.onload = function() {
            const urlParams = new URLSearchParams(window.location.search);
            const success = urlParams.get('success');
            const error = urlParams.get('error');
            const messageDiv = document.getElementById("message");

            if (success || error) {
                messageDiv.textContent = success || error;
                messageDiv.className = error ? "error" : "";
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

        function validateForm(event) {
            event.preventDefault();
            const form = event.target;
            const name = form.name.value.trim();
            const phone = form.phone.value.trim();
            const nic = form.nic.value.trim();
            const address = form.address.value.trim();
            const profilePicture = form.profilePicture.value;

            // Validation patterns
            const namePattern = /^[A-Za-z\s]{2,50}$/;
            const phonePattern = /^\d{10}$/;
            const nicPattern = /^[0-9]{9}[vVxX]$|^[0-9]{12}$/; // Old NIC (9 digits + v/V/x/X) or new NIC (12 digits)

            let errors = [];

            if (!namePattern.test(name)) {
                errors.push("Name must be 2-50 characters long and contain only letters and spaces.");
            }
            if (!phonePattern.test(phone)) {
                errors.push("Phone must be a 10-digit number.");
            }
            if (!nicPattern.test(nic)) {
                errors.push("NIC must be 9 digits followed by v/V/x/X or 12 digits.");
            }
            if (address.length < 5 || address.length > 100) {
                errors.push("Address must be between 5 and 100 characters.");
            }
            if (profilePicture && !/\.(jpg|jpeg|png)$/i.test(profilePicture)) {
                errors.push("Profile picture must be a JPG, JPEG, or PNG file.");
            }

            const messageDiv = document.getElementById("message");
            if (errors.length > 0) {
                messageDiv.textContent = errors.join(" ");
                messageDiv.className = "error";
                messageDiv.style.display = "block";
                setTimeout(() => {
                    messageDiv.style.opacity = "0";
                    setTimeout(() => {
                        messageDiv.style.display = "none";
                        messageDiv.style.opacity = "1";
                    }, 500);
                }, 3000);
                return false;
            }

            form.submit();
        }
    </script>
</head>
<body>
<!-- Header -->
<header>
    <h2>Manage Driver Profile</h2>
</header>

<!-- Main Content -->
<main>
    <div class="container">
        <div id="message"></div>
        <form action="UpdateDriverProfileServlet" method="post" enctype="multipart/form-data" onsubmit="validateForm(event)">
            <input type="hidden" name="username" value="<%= user.getUsername() %>" />

            <label for="name">Name:</label>
            <input type="text" id="name" name="name" value="<%= user.getName() %>" required>

            <label for="phone">Phone:</label>
            <input type="text" id="phone" name="phone" value="<%= user.getPhone() %>" required>

            <label for="nic">NIC:</label>
            <input type="text" id="nic" name="nic" value="<%= user.getNic() %>" required>

            <label for="address">Address:</label>
            <input type="text" id="address" name="address" value="<%= user.getAddress() %>" required>

            <label for="profilePicture">Profile Picture:</label>
            <input type="file" id="profilePicture" name="profilePicture">

            <input type="submit" value="Update Profile">
        </form>
        <a href="driver_dashboard.jsp" class="back-btn">Back to Dashboard</a>
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