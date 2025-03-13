<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.megacitycab.dao.BookingDAO, com.megacitycab.models.Booking, java.util.List" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="com.megacitycab.dao.CarDAO" %>

<%
    HttpSession sessionObj = request.getSession(false);
    String driverUsername = (sessionObj != null) ? (String) sessionObj.getAttribute("username") : null;

    if (driverUsername == null) {
        response.sendRedirect("index.jsp?error=Unauthorized access");
        return;
    }

    BookingDAO bookingDAO = new BookingDAO();
    List<Booking> assignedBookings = bookingDAO.getBookingsByDriver(driverUsername);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Assigned Bookings</title>
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
            background-image: url('images/Driver.jpg');
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
            max-width: none;
            padding: 20px;
            background: linear-gradient(135deg, rgba(45, 64, 89, 0.95), rgba(34, 40, 49, 0.95));
            border-radius: 0;
            box-shadow: none;
            text-align: center;
            animation: fadeIn 0.6s ease-in-out;
            max-height: calc(100vh - 140px);
            overflow-y: auto;
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
            color: #F44336;
        }
        .table-wrapper {
            overflow-x: auto;
            max-height: calc(100% - 100px);
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
            padding: 10px;
            text-align: center;
            color: #EEEEEE;
            white-space: nowrap;
        }
        th {
            background: linear-gradient(90deg, #4A90E2, #4A90E2);
            font-weight: 700;
            font-size: 16px;
        }
        tr:nth-child(even) { background: rgba(74, 144, 226, 0.2); }
        tr:hover {
            background: rgba(255, 87, 34, 0.2);
            transition: background 0.3s ease;
        }
        td img {
            border-radius: 5px;
            border: 2px solid #FF5722;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
            width: 80px;
            height: auto;
        }
        .status {
            display: inline-block;
            padding: 8px 15px;
            border-radius: 15px;
            font-size: 14px;
            font-weight: 600;
            color: #FFFFFF;
            text-transform: capitalize;
        }
        .status-pending { background: linear-gradient(90deg, #FF9800, #FFB300); }
        .status-confirmed { background: linear-gradient(90deg, #4CAF50, #66BB6A); }
        .status-completed { background: linear-gradient(90deg, #4A90E2, #4A90E2); }
        .status-cancelled { background: linear-gradient(90deg, #F44336, #EF5350); }
        input[type="number"],
        input[type="text"] {
            padding: 8px;
            font-size: 14px;
            border: none;
            border-radius: 10px;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid #4A90E2;
            color: #EEEEEE;
            width: 100px;
            box-sizing: border-box;
            transition: box-shadow 0.3s ease;
            text-align: center;
        }
        input[type="number"]:focus,
        input[type="text"]:focus {
            outline: none;
            box-shadow: 0 0 10px rgba(255, 87, 34, 0.5);
            border-color: #FF5722;
        }
        input[type="submit"] {
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
        input[type="submit"]:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(255, 87, 34, 0.6);
        }
        .btn-secondary {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 25px;
            background: linear-gradient(90deg, #4A90E2, #4A90E2);
            color: #FFFFFF;
            text-decoration: none;
            border-radius: 25px;
            font-size: 16px;
            font-weight: 600;
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
            th, td { padding: 8px; font-size: 12px; }
            input[type="number"], input[type="text"] { width: 80px; }
            input[type="submit"] { padding: 6px 15px; }
        }
    </style>

    <script>
        function calculateBill(input) {
            let row = input.closest("tr");
            let farePerKm = parseFloat(row.querySelector(".farePerKm").innerText.replace(" LKR", ""));
            let distance = parseFloat(input.value);
            let billField = row.querySelector(".calculatedBill");
            let hiddenBillField = row.querySelector("input[name='bill_amount']");
            if (!isNaN(farePerKm) && !isNaN(distance)) {
                let billAmount = farePerKm * distance;
                billField.value = billAmount.toFixed(2) + " LKR"; // Display with LKR
                hiddenBillField.value = billAmount.toFixed(2); // Hidden field without LKR
            } else {
                billField.value = "N/A";
                hiddenBillField.value = "";
            }
        }
    </script>
</head>
<body>
<header>
    <h2>Assigned Bookings</h2>
</header>

<main>
    <div class="container">
        <% if (assignedBookings.isEmpty()) { %>
        <p>No assigned bookings.</p>
        <% } else { %>
        <div class="table-wrapper">
            <table border="1">
                <tr>
                    <th>Booking ID</th>
                    <th>Customer Name</th>
                    <th>Car</th>
                    <th>Pickup Location</th>
                    <th>Dropoff Location</th>
                    <th>Driver</th>
                    <th>Status</th>
                    <th>Fare Per KM</th>
                    <th>Distance (KM)</th>
                    <th>Estimated Bill</th>
                    <th>Confirm Booking</th>
                    <th>Cancel Booking</th>
                </tr>
                <% for (Booking booking : assignedBookings) { %>
                <tr>
                    <td><%= booking.getId() %></td>
                    <td><%= booking.getCustomerUsername() %></td>
                    <td>
                        <%= booking.getCarName() %><br>
                        <img src="uploads/<%= booking.getCarImage() %>" alt="Car Image">
                    </td>
                    <td><%= booking.getPickupLocation() %></td>
                    <td><%= booking.getDropoffLocation() %></td>
                    <td><%= booking.getDriverUsername() %></td>
                    <td><span class="status status-<%= booking.getStatus().toLowerCase() %>"><%= booking.getStatus() %></span></td>
                    <td class="farePerKm"><%= booking.getCarId() != 0 ? new CarDAO().getFarePerKm(booking.getCarId()) : "N/A" %> LKR</td>
                    <td><input type="number" name="distance" step="0.01" placeholder="Enter distance" required oninput="calculateBill(this)"></td>
                    <td><input type="text" class="calculatedBill" readonly></td>
                    <td>
                        <form action="confirm_booking.jsp" method="post">
                            <input type="hidden" name="booking_id" value="<%= booking.getId() %>">
                            <input type="hidden" name="fare_per_km" value="<%= booking.getCarId() != 0 ? new CarDAO().getFarePerKm(booking.getCarId()) : "0" %>">
                            <input type="hidden" name="bill_amount" class="billAmount">
                            <input type="hidden" name="distance" class="distanceInput">
                            <input type="submit" value="Confirm Booking" onclick="this.form.distance.value = this.closest('tr').querySelector('input[name=distance]').value; this.form.bill_amount.value = this.closest('tr').querySelector('input[name=bill_amount]').value;">
                        </form>
                    </td>
                    <td>
                        <form action="CancelBookingServlet" method="post">
                            <input type="hidden" name="booking_id" value="<%= booking.getId() %>">
                            <input type="submit" value="Cancel Booking" onclick="return confirm('Are you sure you want to cancel this booking?');">
                        </form>
                    </td>
                </tr>
                <% } %>
            </table>
        </div>
        <% } %>
        <a href="driver_dashboard.jsp" class="btn-secondary">Back to Dashboard</a>
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