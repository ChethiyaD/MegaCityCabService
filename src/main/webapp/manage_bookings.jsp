<%@ page session="true" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List, com.megacitycab.dao.BookingDAO, com.megacitycab.models.Booking" %>

<%
    if (session.getAttribute("role") == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("index.jsp");
        return;
    }

    BookingDAO bookingDAO = new BookingDAO();
    List<Booking> allBookings = bookingDAO.getAllBookings(); // Fetch all bookings
    String success = request.getParameter("success");
    String error = request.getParameter("error");
    String message = success != null ? success : (error != null ? error : null);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Bookings</title>
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
        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 10px;
        }
        .btn-danger {
            background: linear-gradient(90deg, #F44336, #EF5350);
            padding: 5px 15px;
            border-radius: 20px;
            font-weight: 500;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            border: none;
        }
        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(244, 67, 54, 0.5);
        }
        .btn-danger:active {
            transform: translateY(0);
            box-shadow: 0 2px 8px rgba(244, 67, 54, 0.4);
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
        @media (max-width: 768px) {
            header h2 { font-size: 36px; }
            .container { padding: 20px; }
            #searchInput { max-width: 100%; }
            th, td { padding: 8px; font-size: 14px; }
            .btn-secondary { padding: 8px 20px; font-size: 14px; }
            .btn-danger { padding: 4px 12px; font-size: 12px; }
            #message { max-width: 100%; padding: 10px; }
        }
        @media (max-width: 480px) {
            header { padding: 15px; }
            header h2 { font-size: 28px; }
            .container { padding: 15px; }
            table { font-size: 12px; }
            th, td { padding: 6px; }
            .action-buttons { flex-direction: column; gap: 5px; }
            .btn-secondary { width: 100%; margin-bottom: 10px; }
            .btn-danger { width: 100%; }
            footer .links a { display: block; margin: 5px 0; }
        }
    </style>

    <script>
        function cancelAdminBooking(bookingId, row) {
            if (confirm("Are you sure you want to cancel this booking? This action cannot be undone.")) {
                $.ajax({
                    url: "CancelBookingAdminServlet",
                    method: "POST",
                    data: { booking_id: bookingId },
                    success: function(response) {
                        if (response.trim() === "Booking successfully cancelled") {
                            $(row).remove(); // Remove the row from the table
                        } else {
                            alert("Failed to cancel booking!");
                        }
                    },
                    error: function() {
                        alert("An error occurred while cancelling the booking.");
                    }
                });
            }
        }

        function searchBookings() {
            let input = document.getElementById("searchInput").value.toLowerCase();
            let rows = document.querySelectorAll("#bookingsTable tbody tr");

            rows.forEach(row => {
                let bookingId = row.cells[0].textContent.toLowerCase();
                let customer = row.cells[1].textContent.toLowerCase();
                let driver = row.cells[2].textContent.toLowerCase();

                if (bookingId.includes(input) || customer.includes(input) || driver.includes(input)) {
                    row.style.display = "";
                } else {
                    row.style.display = "none";
                }
            });
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
    <h2>Manage All Bookings</h2>
</header>

<main>
    <div class="container">
        <!-- Search Bar -->
        <input type="text" id="searchInput" class="form-control mb-3" placeholder="Search by Booking ID, Customer Username, or Driver Username" onkeyup="searchBookings()">

        <div id="message"></div>

        <table class="mt-3" id="bookingsTable">
            <thead>
            <tr>
                <th>Booking ID</th>
                <th>Customer</th>
                <th>Driver</th>
                <th>Pickup Location</th>
                <th>Dropoff Location</th>
                <th>Fare (LKR)</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <% for (Booking booking : allBookings) { %>
            <tr id="booking-<%= booking.getId() %>">
                <td><%= booking.getId() %></td>
                <td><%= booking.getCustomerUsername() %></td>
                <td><%= (booking.getDriverUsername() != null) ? booking.getDriverUsername() : "Not Assigned" %></td>
                <td><%= booking.getPickupLocation() %></td>
                <td><%= booking.getDropoffLocation() %></td>
                <td>LKR <%= String.format("%.2f", booking.getEstimatedBill()) %></td>
                <td><%= booking.getStatus() %></td>
                <td class="action-buttons">
                    <button class="btn btn-danger btn-sm" onclick="cancelAdminBooking(<%= booking.getId() %>, this.closest('tr'))">Cancel</button>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>

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