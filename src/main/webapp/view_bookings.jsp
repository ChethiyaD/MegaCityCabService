<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.megacitycab.dao.BookingDAO, com.megacitycab.models.Booking, java.util.List" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession sessionObj = request.getSession(false);
    String username = (sessionObj != null) ? (String) sessionObj.getAttribute("username") : null;

    if (username == null) {
        response.sendRedirect("index.jsp?error=Unauthorized access");
        return;
    }

    BookingDAO bookingDAO = new BookingDAO();
    List<Booking> bookings = bookingDAO.getBookingsByCustomer(username);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Bookings</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@700&display=swap" rel="stylesheet">

    <script>
        function confirmCancellation(form) {
            if (confirm('Are you sure you want to cancel this booking?')) {
                form.submit();
            }
        }
    </script>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
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
        h2 {
            font-family: 'Montserrat', sans-serif;
            font-size: 36px;
            color: #FF5722;
            margin-bottom: 20px;
        }
        p {
            font-size: 18px;
            margin-bottom: 20px;
            color: #F44336; /* Red for error messages */
        }
        .status-legend {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-bottom: 20px;
            font-size: 14px;
        }
        .status-legend span {
            display: flex;
            align-items: center;
            gap: 5px;
        }
        .status-legend .pending::before,
        .status-legend .cancelled::before,
        .status-legend .confirmed::before,
        .status-legend .completed::before {
            content: '\f111'; /* Font Awesome circle */
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            font-size: 12px;
        }
        .status-legend .pending::before { color: #FF9800; }
        .status-legend .cancelled::before { color: #F44336; }
        .status-legend .confirmed::before { color: #2196F3; }
        .status-legend .completed::before { color: #4CAF50; }
        table {
            border-collapse: collapse;
            width: 100%;
            background: rgba(74, 144, 226, 0.1);
            border-radius: 10px;
            overflow: hidden;
            margin-top: 20px;
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
        .status-pending,
        .status-cancelled,
        .status-confirmed,
        .status-completed {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            font-weight: 500;
        }
        .status-pending::before,
        .status-cancelled::before,
        .status-confirmed::before,
        .status-completed::before {
            content: '\f111'; /* Font Awesome circle */
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            font-size: 12px;
        }
        .status-pending { color: #FF9800; }
        .status-pending::before { color: #FF9800; }
        .status-cancelled { color: #F44336; }
        .status-cancelled::before { color: #F44336; }
        .status-confirmed { color: #2196F3; }
        .status-confirmed::before { color: #2196F3; }
        .status-completed { color: #4CAF50; }
        .status-completed::before { color: #4CAF50; }
        .no-actions,
        .completed-no-actions {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 15px;
            font-weight: 500;
            text-align: center;
        }
        .no-actions {
            background-color: #757575; /* Dark gray for general no actions */
            color: #FFFFFF;
        }
        .completed-no-actions {
            background-color: #4CAF50; /* Green to match Completed status */
            color: #FFFFFF;
            opacity: 0.8;
        }
        td img {
            border-radius: 5px;
            border: 2px solid #FF5722;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
        }
        form {
            display: inline;
            margin: 0 5px;
        }
        input[type="submit"] {
            padding: 5px 15px;
            border: none;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        input[value="Pay Now"] {
            background: linear-gradient(90deg, #4CAF50, #66BB6A); /* Green for payment */
        }
        input[value="Pay Now"]:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(76, 175, 80, 0.5);
        }
        input[value="Cancel Booking"] {
            background: linear-gradient(90deg, #F44336, #EF5350); /* Red for cancellation */
        }
        input[value="Cancel Booking"]:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(244, 67, 54, 0.5);
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
            margin-top: 20px;
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
        @media (max-width: 768px) {
            header h2 { font-size: 36px; }
            .container { padding: 20px; }
            h2 { font-size: 30px; }
            p { font-size: 16px; }
            th, td { padding: 8px; font-size: 14px; }
            input[type="submit"] { padding: 4px 12px; font-size: 12px; }
            a.back-btn { padding: 8px 20px; font-size: 14px; }
            .status-legend { flex-direction: column; gap: 10px; }
        }
        @media (max-width: 480px) {
            header { padding: 15px; }
            header h2 { font-size: 28px; }
            .container { padding: 15px; }
            h2 { font-size: 24px; }
            p { font-size: 14px; }
            th, td { padding: 6px; font-size: 12px; }
            input[type="submit"] { padding: 3px 10px; font-size: 10px; }
            a.back-btn { padding: 6px 15px; font-size: 12px; }
            footer .links a { display: block; margin: 5px 0; }
        }
    </style>
</head>
<body>
<!-- Header -->
<header>
    <h2>My Bookings</h2>
</header>

<!-- Main Content -->
<main>
    <div class="container">
        <% if (bookings != null && !bookings.isEmpty()) { %>
        <!-- Status Legend -->
        <div class="status-legend">
            <span class="pending">Pending</span>
            <span class="cancelled">Cancelled</span>
            <span class="confirmed">Confirmed</span>
            <span class="completed">Completed</span>
        </div>

        <table border="1">
            <tr>
                <th>Booking ID</th>
                <th>Pickup Location</th>
                <th>Dropoff Location</th>
                <th>Car</th>
                <th>Driver</th>
                <th>Status</th>
                <th>Distance (KM)</th>
                <th>Estimated Bill (LKR)</th>
                <th>Actions</th>
            </tr>
            <% for (Booking booking : bookings) { %>
            <tr>
                <td><%= booking.getId() %></td>
                <td><%= booking.getPickupLocation() %></td>
                <td><%= booking.getDropoffLocation() %></td>
                <td>
                    <%= booking.getCarNumber() %> (<%= booking.getCarName() %>)<br>
                    <img src="uploads/<%= booking.getCarImage() %>" alt="Car Image" width="80">
                </td>
                <td>
                    <%= booking.getDriverUsername() != null ? booking.getDriverUsername() : "Not Assigned" %><br>
                    <% if (booking.getDriverImage() != null && !booking.getDriverImage().isEmpty()) { %>
                    <img src="uploads/<%= booking.getDriverImage() %>" alt="Driver Image" width="80">
                    <% } %>
                </td>
                <td>
                    <% if ("Pending".equals(booking.getStatus())) { %>
                    <span class="status-pending">Pending</span>
                    <% } else if ("Cancelled".equals(booking.getStatus())) { %>
                    <span class="status-cancelled">Cancelled</span>
                    <% } else if ("Confirmed".equals(booking.getStatus())) { %>
                    <span class="status-confirmed">Confirmed</span>
                    <% } else if ("Completed".equals(booking.getStatus())) { %>
                    <span class="status-completed">Completed</span>
                    <% } else { %>
                    <%= booking.getStatus() %>
                    <% } %>
                </td>
                <td><%= booking.getDistance() > 0 ? booking.getDistance() + " KM" : "Pending" %></td>
                <td><%= booking.getEstimatedBill() > 0 ? "LKR " + String.format("%.2f", booking.getEstimatedBill()) : "Calculating..." %></td>
                <td>
                    <% if ("Confirmed".equals(booking.getStatus())) { %>
                    <form action="payment_details.jsp" method="get">
                        <input type="hidden" name="booking_id" value="<%= booking.getId() %>">
                        <input type="hidden" name="total_amount" value="<%= booking.getEstimatedBill() %>">
                        <input type="submit" value="Pay Now" class="btn btn-sm">
                    </form>
                    <form action="CancelBookingByCustomerServlet" method="post" onsubmit="event.preventDefault(); confirmCancellation(this);">
                        <input type="hidden" name="booking_id" value="<%= booking.getId() %>">
                        <input type="submit" value="Cancel Booking" class="btn btn-sm">
                    </form>
                    <% } else if ("Cancelled".equals(booking.getStatus())) { %>
                    <span class="no-actions">No Actions</span>
                    <% } else if ("Completed".equals(booking.getStatus())) { %>
                    <span class="completed-no-actions">No Actions</span>
                    <% } else if ("Paid".equals(booking.getStatus())) { %>
                    <span class="no-actions">Paid</span>
                    <% } %>
                </td>
            </tr>
            <% } %>
        </table>
        <% } else { %>
        <p>No bookings found.</p>
        <a href="customer_dashboard.jsp" class="back-btn">Back to Dashboard</a>
        <% } %>
        <br>
        <a href="customer_dashboard.jsp" class="back-btn mt-3">Back to Dashboard</a>
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