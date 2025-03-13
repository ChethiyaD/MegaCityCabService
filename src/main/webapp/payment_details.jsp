<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.megacitycab.dao.BookingDAO, com.megacitycab.models.Booking" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession sessionObj = request.getSession(false);
    String username = (sessionObj != null) ? (String) sessionObj.getAttribute("username") : null;

    if (username == null) {
        response.sendRedirect("index.jsp?error=Unauthorized access");
        return;
    }

    String bookingIdParam = request.getParameter("booking_id");
    if (bookingIdParam == null) {
        response.sendRedirect("view_bookings.jsp?error=Invalid booking ID");
        return;
    }

    int bookingId = Integer.parseInt(bookingIdParam);
    BookingDAO bookingDAO = new BookingDAO();
    Booking booking = bookingDAO.getBookingById(bookingId);

    if (booking == null) {
        response.sendRedirect("view_bookings.jsp?error=Booking not found");
        return;
    }

    // Tax and Discount Settings
    double taxRate = 0.05; // 5% tax
    double discountRate = bookingDAO.hasPreviousBookingWithSameDriver(username, booking.getDriverUsername()) ? 0.10 : 0.0; // 10% discount if same driver before

    double estimatedBill = booking.getEstimatedBill();
    double taxAmount = estimatedBill * taxRate;
    double discountAmount = estimatedBill * discountRate;
    double totalAmount = estimatedBill + taxAmount - discountAmount;
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment Summary & Details</title>
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
            overflow-y: auto;
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
            align-items: flex-start;
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
        h2 {
            font-family: 'Montserrat', sans-serif;
            font-size: 24px;
            color: #FF5722;
            margin-bottom: 10px;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            background: rgba(74, 144, 226, 0.1);
            border-radius: 8px;
            overflow: hidden;
            margin-bottom: 10px;
        }
        th, td {
            border: 1px solid #4A90E2;
            padding: 8px;
            text-align: left;
            color: #EEEEEE;
            font-size: 14px;
        }
        th {
            background: linear-gradient(90deg, #4A90E2, #4A90E2);
            font-weight: 600;
        }
        tr:nth-child(even) { background: rgba(74, 144, 226, 0.2); }
        tr:hover {
            background: rgba(255, 87, 34, 0.2);
            transition: background 0.3s ease;
        }
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
        input[type="text"],
        input[type="email"],
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
        input[type="text"]:focus,
        input[type="email"]:focus {
            outline: none;
            box-shadow: 0 0 8px rgba(255, 87, 34, 0.5);
            border-color: #FF5722;
        }
        input[type="hidden"] { display: none; }
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
        input[type="submit"]:active {
            transform: translateY(0);
            box-shadow: 0 2px 6px rgba(255, 87, 34, 0.4);
        }
        a.cancel-btn {
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
        a.cancel-btn:hover {
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
        footer .links a:hover {
            color: #4A90E2;
        }
        footer p {
            font-size: 10px;
            color: #CCCCCC;
            margin: 0;
        }
        @media (max-width: 768px) {
            header h2 { font-size: 30px; }
            .container { padding: 10px; }
            h2 { font-size: 20px; }
            th, td { padding: 6px; font-size: 12px; }
            input[type="text"],
            input[type="email"] { font-size: 11px; }
            input[type="submit"] { padding: 6px 15px; font-size: 12px; }
            a.cancel-btn { padding: 6px 15px; font-size: 12px; }
        }
        @media (max-width: 480px) {
            header { padding: 10px; }
            header h2 { font-size: 24px; }
            .container { padding: 8px; max-width: 400px; }
            h2 { font-size: 18px; }
            th, td { padding: 4px; font-size: 10px; }
            label { font-size: 12px; }
            input[type="text"],
            input[type="email"] { font-size: 10px; padding: 5px; }
            input[type="submit"] { padding: 5px 12px; font-size: 11px; }
            a.cancel-btn { padding: 5px 12px; font-size: 11px; }
            footer .links a { display: block; margin: 3px 0; }
            footer p { font-size: 9px; }
        }
    </style>
</head>
<body>
<!-- Header -->
<header>
    <h2>Payment Summary & Details</h2>
</header>

<!-- Main Content -->
<main>
    <div class="container">
        <table>
            <tr><th>Booking ID:</th><td><%= booking.getId() %></td></tr>
            <tr><th>Pickup Location:</th><td><%= booking.getPickupLocation() %></td></tr>
            <tr><th>Dropoff Location:</th><td><%= booking.getDropoffLocation() %></td></tr>
            <tr><th>Driver:</th><td><%= booking.getDriverUsername() %></td></tr>
            <tr><th>Estimated Bill:</th><td>LKR <%= String.format("%.2f", estimatedBill) %></td></tr>
            <tr><th>Tax (5%):</th><td>LKR <%= String.format("%.2f", taxAmount) %></td></tr>
            <tr><th>Discount (<%= discountRate * 100 %>% if applicable):</th><td>LKR <%= String.format("%.2f", discountAmount) %></td></tr>
            <tr><th>Total Amount:</th><td><b>LKR <%= String.format("%.2f", totalAmount) %></b></td></tr>
        </table>

        <h2>Enter Payment Details</h2>
        <form action="ProcessPaymentServlet" method="post">
            <input type="hidden" name="booking_id" value="<%= booking.getId() %>">
            <input type="hidden" name="total_amount" value="<%= totalAmount %>">

            <label for="card_holder_name">Card Holder Name:</label>
            <input type="text" id="card_holder_name" name="card_holder_name" required>

            <label for="card_number">Card Number:</label>
            <input type="text" id="card_number" name="card_number" required pattern="\d{16}" maxlength="16">

            <label for="expiry_date">Expiry Date (MM/YY):</label>
            <input type="text" id="expiry_date" name="expiry_date" required pattern="\d{2}/\d{2}" maxlength="5">

            <label for="cvv">CVV:</label>
            <input type="text" id="cvv" name="cvv" required pattern="\d{3}" maxlength="3">

            <label for="email">Email for Confirmation:</label>
            <input type="email" id="email" name="email" required pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" placeholder="example@email.com">

            <input type="submit" value="Submit Payment">
        </form>

        <a href="view_bookings.jsp" class="cancel-btn">Cancel</a>
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