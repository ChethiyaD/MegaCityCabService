<%@ page session="true" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List, com.megacitycab.dao.UserDAO, com.megacitycab.models.User" %>

<%
    if (session.getAttribute("role") == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("index.jsp");
        return;
    }

    UserDAO userDAO = new UserDAO();
    List<User> customers = userDAO.getAllCustomers();
    String success = request.getParameter("success");
    String error = request.getParameter("error");
    String message = success != null ? success : (error != null ? error : null);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Customers</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@700&display=swap" rel="stylesheet">

    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #222831;
            background-image: url('images/background.jpg');
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
        }
        main {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            min-height: calc(100vh - 120px);
        }
        .container {
            max-width: 1200px;
            width: 100%;
            padding: 30px;
            background: linear-gradient(135deg, rgba(45, 64, 89, 0.95), rgba(34, 40, 49, 0.95));
            border-radius: 15px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.5);
            text-align: center;
            animation: fadeIn 0.6s ease-in-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        #searchInput {
            max-width: 400px;
            margin: 0 auto 20px;
            background: rgba(255, 255, 255, 0.1);
            border: none;
            border-radius: 25px;
            padding: 10px 15px;
            color: #EEEEEE;
        }
        #searchInput::placeholder { color: #CCCCCC; }
        #searchInput:focus {
            outline: none;
            box-shadow: 0 0 10px rgba(255, 87, 34, 0.5);
        }
        .btn-primary {
            background: linear-gradient(90deg, #FF5722, #FF7043);
            border: none;
            padding: 10px 25px;
            border-radius: 25px;
            font-weight: 600;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 18px rgba(255, 87, 34, 0.6);
        }
        .btn-primary:active {
            transform: translateY(0);
            box-shadow: 0 2px 8px rgba(255, 87, 34, 0.4);
        }
        table {
            border-collapse: collapse;
            width: 100%;
            background: rgba(74, 144, 226, 0.1);
            border-radius: 10px;
            overflow: hidden;
        }
        th, td {
            border: 1px solid #4A90E2;
            padding: 12px;
            text-align: center;
            color: #EEEEEE;
        }
        th {
            background: linear-gradient(90deg, #4A90E2, #4A90E2);
            font-weight: 700;
        }
        tr:nth-child(even) { background: rgba(74, 144, 226, 0.2); }
        tr:hover {
            background: rgba(255, 87, 34, 0.2);
            transition: background 0.3s ease;
        }
        td img {
            border-radius: 5px;
            border: 2px solid #FF5722;
        }
        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 10px;
        }
        .btn-warning, .btn-danger {
            padding: 5px 15px;
            border-radius: 20px;
            font-weight: 500;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .btn-warning {
            background: linear-gradient(90deg, #FF9800, #FFB300);
        }
        .btn-warning:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(255, 152, 0, 0.5);
        }
        .btn-danger {
            background: linear-gradient(90deg, #F44336, #EF5350);
        }
        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(244, 67, 54, 0.5);
        }
        .btn-secondary {
            background: linear-gradient(90deg, #4A90E2, #4A90E2);
            border: none;
            padding: 10px 25px;
            border-radius: 25px;
            font-weight: 600;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .btn-secondary:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 18px rgba(74, 144, 226, 0.6);
        }
        .modal-content {
            background: linear-gradient(135deg, rgba(45, 64, 89, 0.95), rgba(34, 40, 49, 0.95));
            border-radius: 15px;
            color: #EEEEEE;
        }
        .modal-header {
            background: linear-gradient(90deg, #FF5722, #FF7043);
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
        }
        .modal-title {
            font-family: 'Montserrat', sans-serif;
            font-weight: 700;
        }
        .modal-body {
            max-height: 60vh;
            overflow-y: auto;
            padding: 20px;
        }
        .modal-body label { font-weight: 500; }
        .form-control {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid #4A90E2;
            border-radius: 10px;
            color: #EEEEEE;
        }
        .form-control:focus {
            outline: none;
            box-shadow: 0 0 10px rgba(255, 87, 34, 0.5);
            border-color: #FF5722;
        }
        .btn-success {
            background: linear-gradient(90deg, #4CAF50, #66BB6A);
            border: none;
            padding: 10px 25px;
            border-radius: 25px;
            font-weight: 600;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .btn-success:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 18px rgba(76, 175, 80, 0.6);
        }
        #message {
            display: none;
            max-width: 600px;
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
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes fadeOut {
            from { opacity: 1; }
            to { opacity: 0; }
        }
        footer {
            background: linear-gradient(90deg, rgba(45, 64, 89, 0.95), rgba(34, 40, 49, 0.95));
            padding: 20px;
            text-align: center;
            box-shadow: 0 -4px 15px rgba(0, 0, 0, 0.4);
            margin-top: 20px;
        }
        footer .links { margin-bottom: 10px; }
        footer .links a {
            color: #FF5722;
            text-decoration: none;
            margin: 0 15px;
            font-size: 14px;
            transition: color 0.3s ease;
        }
        footer .links a:hover { color: #4A90E2; }
        footer p { font-size: 12px; color: #CCCCCC; }
        .error-text {
            color: #F44336;
            font-size: 12px;
            display: none;
            margin-top: 5px;
        }
        .form-control.invalid {
            border-color: #F44336;
            box-shadow: 0 0 5px rgba(244, 67, 54, 0.5);
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
            color: #4A90E2;
        }
        .password-container .toggle-password:hover {
            color: #FF5722;
        }
        @media (max-width: 768px) {
            header h2 { font-size: 36px; }
            .container { padding: 20px; }
            #searchInput { max-width: 100%; }
            th, td { padding: 8px; font-size: 14px; }
            .btn-primary, .btn-secondary { padding: 8px 20px; font-size: 14px; }
            .btn-warning, .btn-danger { padding: 4px 12px; font-size: 12px; }
            .modal-content { margin: 0 10px; }
            .form-control { font-size: 14px; }
            .btn-success { padding: 8px 20px; font-size: 14px; }
            #message { max-width: 100%; padding: 10px; }
        }
        @media (max-width: 480px) {
            header { padding: 15px; }
            header h2 { font-size: 28px; }
            .container { padding: 15px; }
            table { font-size: 12px; }
            th, td { padding: 6px; }
            .action-buttons { flex-direction: column; gap: 5px; }
            .btn-primary, .btn-secondary, .btn-success { width: 100%; margin-bottom: 10px; }
            .btn-warning, .btn-danger { width: 100%; }
            footer .links a { display: block; margin: 5px 0; }
        }
    </style>

    <script>
        function openEditModal(username, name, phone, nic, address, profilePicture) {
            document.getElementById("editModalTitle").innerText = username ? "Edit Customer" : "Add Customer";
            document.getElementById("editUsername").value = username || '';
            document.getElementById("editUsername").readOnly = !!username;
            document.getElementById("editPassword").value = '';
            document.getElementById("editName").value = name || '';
            document.getElementById("editPhone").value = phone || '';
            document.getElementById("editNic").value = nic || '';
            document.getElementById("editAddress").value = address || '';
            document.getElementById("currentProfilePicture").src = "uploads/" + (profilePicture || "default.png");
            document.getElementById("editForm").action = username ? "EditCustomerServlet" : "AddCustomerServlet";
            new bootstrap.Modal(document.getElementById("editCustomerModal")).show();
        }

        function searchCustomers() {
            let input = document.getElementById("searchInput").value.toLowerCase();
            let rows = document.querySelectorAll("#customersTable tbody tr");

            rows.forEach(row => {
                let username = row.cells[0].textContent.toLowerCase();
                let name = row.cells[1].textContent.toLowerCase();
                let phone = row.cells[2].textContent.toLowerCase();
                let nic = row.cells[3].textContent.toLowerCase();
                let address = row.cells[4].textContent.toLowerCase();

                if (username.includes(input) || name.includes(input) || phone.includes(input) || nic.includes(input) || address.includes(input)) {
                    row.style.display = "";
                } else {
                    row.style.display = "none";
                }
            });
        }

        function togglePassword() {
            const passwordInput = document.getElementById("editPassword");
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
        }

        window.onload = function() {
            const urlParams = new URLSearchParams(window.location.search);
            const message = urlParams.get('success') || urlParams.get('error');
            if (message) {
                const messageDiv = document.getElementById("message");
                messageDiv.textContent = message;
                messageDiv.style.background = urlParams.get('success') ? "linear-gradient(90deg, #4CAF50, #66BB6A)" : "linear-gradient(90deg, #F44336, #EF5350)";
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
    <h2>Manage Customers</h2>
</header>

<main>
    <div class="container">
        <input type="text" id="searchInput" class="form-control mb-3"
               placeholder="Search by Username, Name, Phone, NIC, or Address" onkeyup="searchCustomers()">

        <button type="button" class="btn btn-primary" onclick="openEditModal('', '', '', '', '', 'default.png')">
            Add Customer
        </button>

        <div id="message"></div>

        <table border="1" class="mt-3" id="customersTable">
            <thead>
            <tr>
                <th>Username</th>
                <th>Name</th>
                <th>Phone</th>
                <th>NIC</th>
                <th>Address</th>
                <th>Profile Picture</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <% for (User customer : customers) { %>
            <tr>
                <td><%= customer.getUsername() %></td>
                <td><%= customer.getName() %></td>
                <td><%= customer.getPhone() %></td>
                <td><%= customer.getNic() %></td>
                <td><%= customer.getAddress() != null ? customer.getAddress() : "Not Set" %></td>
                <td>
                    <img src="uploads/<%= customer.getProfilePicture() %>" alt="Profile Picture" width="50">
                </td>
                <td class="action-buttons">
                    <button class="btn btn-warning btn-sm" onclick="openEditModal(
                            '<%= customer.getUsername() %>',
                            '<%= customer.getName() %>',
                            '<%= customer.getPhone() %>',
                            '<%= customer.getNic() %>',
                            '<%= customer.getAddress() %>',
                            '<%= customer.getProfilePicture() %>'
                            )">Edit</button>
                    <form action="DeleteCustomerServlet" method="post" style="display:inline;">
                        <input type="hidden" name="username" value="<%= customer.getUsername() %>">
                        <input type="submit" class="btn btn-danger btn-sm" value="Delete">
                    </form>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>

        <div class="modal fade" id="editCustomerModal" tabindex="-1" aria-labelledby="editModalTitle" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editModalTitle">Edit Customer</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="editForm" method="post" enctype="multipart/form-data">
                            <label>Username:</label>
                            <input type="text" name="username" id="editUsername" class="form-control" required><br>

                            <label>Password:</label>
                            <div class="password-container">
                                <input type="password" name="password" id="editPassword" class="form-control" required>
                                <i class="fas fa-eye toggle-password" id="togglePasswordIcon" onclick="togglePassword()"></i>
                            </div><br>

                            <label>Name:</label>
                            <input type="text" name="name" id="editName" class="form-control" required><br>

                            <label>Phone:</label>
                            <input type="text" name="phone" id="editPhone" class="form-control" required><br>

                            <label>NIC:</label>
                            <input type="text" name="nic" id="editNic" class="form-control" required><br>

                            <label>Address:</label>
                            <input type="text" name="address" id="editAddress" class="form-control" required><br>

                            <label>Profile Picture:</label>
                            <input type="file" name="profile_picture" class="form-control"><br>

                            <img id="currentProfilePicture" src="uploads/default.png" width="100"><br>

                            <button type="submit" class="btn btn-success">Save Changes</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <br>
        <a href="admin_dashboard.jsp" class="btn btn-secondary mt-3">Back to Dashboard</a>
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