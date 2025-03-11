<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="com.megacitycab.dao.BookingDAO, com.megacitycab.models.Booking" %>

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

    double totalAmount = Double.parseDouble(request.getParameter("total_amount"));
    double taxAmount = booking.getEstimatedBill() * 0.05;  // Assuming 5% tax
    double distance = booking.getDistance(); // Assuming distance is part of booking object
    String paymentTime = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment Successful</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@700&display=swap" rel="stylesheet">
    <!-- jsPDF -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>

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
        }
        .modal-content {
            background: linear-gradient(135deg, rgba(45, 64, 89, 0.95), rgba(34, 40, 49, 0.95));
            border-radius: 15px;
            color: #EEEEEE;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.5);
        }
        .modal-header {
            background: linear-gradient(90deg, #4CAF50, #66BB6A); /* Green gradient for success */
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
            padding: 15px;
            border-bottom: none;
        }
        .modal-title {
            font-family: 'Montserrat', sans-serif;
            font-size: 24px;
            font-weight: 700;
            color: #FFFFFF;
        }
        .modal-body {
            padding: 15px;
            text-align: center;
        }
        .success-message {
            color: #FFFFFF;
            font-size: 16px;
            font-weight: 500;
            margin-bottom: 15px;
            background: rgba(76, 175, 80, 0.2);
            padding: 10px;
            border-radius: 10px;
        }
        .success-message b {
            color: #FF5722;
        }
        h3 {
            font-family: 'Montserrat', sans-serif;
            font-size: 20px;
            color: #FF5722;
            margin-bottom: 10px;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            background: rgba(74, 144, 226, 0.1);
            border-radius: 8px;
            overflow: hidden;
            margin-bottom: 15px;
        }
        td {
            border: 1px solid #4A90E2;
            padding: 8px;
            text-align: left;
            color: #EEEEEE;
            font-size: 14px;
        }
        tr:nth-child(even) { background: rgba(74, 144, 226, 0.2); }
        tr:hover {
            background: rgba(255, 87, 34, 0.2);
            transition: background 0.3s ease;
        }
        .btn-success {
            background: linear-gradient(90deg, #FF5722, #FF7043); /* Matching app theme */
            border: none;
            padding: 8px 20px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
            color: #FFFFFF;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(255, 87, 34, 0.6);
        }
        .btn-success:active {
            transform: translateY(0);
            box-shadow: 0 2px 6px rgba(255, 87, 34, 0.4);
        }
        .btn-primary {
            background: linear-gradient(90deg, #4A90E2, #4A90E2);
            border: none;
            padding: 8px 20px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
            color: #FFFFFF;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(74, 144, 226, 0.6);
        }
        .modal-footer {
            padding: 10px;
            border-top: none;
            justify-content: center;
        }
        #countdown {
            color: #FF5722;
            font-weight: 600;
        }
        @media (max-width: 768px) {
            .modal-title { font-size: 20px; }
            .modal-body { padding: 10px; }
            .success-message { font-size: 14px; }
            h3 { font-size: 18px; }
            td { padding: 6px; font-size: 12px; }
            .btn-success, .btn-primary { padding: 6px 15px; font-size: 12px; }
        }
        @media (max-width: 480px) {
            .modal-dialog { margin: 10px; }
            .modal-title { font-size: 18px; }
            .modal-body { padding: 8px; }
            .success-message { font-size: 12px; padding: 8px; }
            h3 { font-size: 16px; }
            td { padding: 4px; font-size: 10px; }
            .btn-success, .btn-primary { padding: 5px 12px; font-size: 11px; }
        }
    </style>
</head>
<body>

<!-- Modal for Payment Success -->
<div class="modal fade" id="paymentSuccessModal" tabindex="-1" aria-labelledby="paymentSuccessModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="paymentSuccessModalLabel">Payment Successful</h5>
            </div>
            <div class="modal-body">
                <p class="success-message">Thank you, <b><%= username %></b>. Your payment has been successfully processed.</p>

                <h3>Payment Details</h3>
                <table>
                    <tr><td>Booking ID:</td><td><%= booking.getId() %></td></tr>
                    <tr><td>Pickup Location:</td><td><%= booking.getPickupLocation() %></td></tr>
                    <tr><td>Dropoff Location:</td><td><%= booking.getDropoffLocation() %></td></tr>
                    <tr><td>Driver:</td><td><%= booking.getDriverUsername() %></td></tr>
                    <tr><td>Total Paid:</td><td><b>LKR <%= String.format("%.2f", totalAmount) %></b></td></tr>
                    <tr><td>Tax (5%):</td><td>LKR <%= String.format("%.2f", taxAmount) %></td></tr>
                    <tr><td>Distance:</td><td><%= String.format("%.2f", distance) %> KM</td></tr>
                    <tr><td>Payment Time:</td><td><%= paymentTime %></td></tr>
                    <tr><td>Status:</td><td><b>Paid</b></td></tr>
                </table>

                <!-- Download Bill Button -->
                <button class="btn btn-success" id="downloadBillBtn">Download Bill</button>
                <br><br>

                <p>Redirecting to payment page in <span id="countdown">20</span> seconds...</p>
            </div>
            <div class="modal-footer">
                <a href="view_bookings.jsp" class="btn btn-primary">Back to My Bookings</a>
            </div>
        </div>
    </div>
</div>

<script>
    // Show the modal after the payment is successful
    var paymentSuccessModal = new bootstrap.Modal(document.getElementById('paymentSuccessModal'));
    paymentSuccessModal.show();

    // Countdown and redirect
    let countdown = 20;
    let countdownElement = document.getElementById("countdown");

    setInterval(() => {
        if (countdown > 1) {
            countdown--;
            countdownElement.textContent = countdown;
        } else {
            window.location.href = "payment.jsp"; // Redirect after 20 seconds
        }
    }, 1000);

    // Function to generate and download the PDF invoice
    document.getElementById("downloadBillBtn").addEventListener("click", function () {
        const { jsPDF } = window.jspdf;
        const doc = new jsPDF();

        doc.setFont("helvetica", "bold");
        doc.text("MegaCityCab - Invoice", 105, 20, { align: "center" });

        // Add invoice details dynamically from JSP variables
        doc.setFont("helvetica", "normal");
        doc.text("Booking ID: <%= booking.getId() %>", 20, 40);
        doc.text("Customer: <%= booking.getCustomerUsername() %>", 20, 50);
        doc.text("Driver: <%= booking.getDriverUsername() %>", 20, 60);
        doc.text("Pickup Location: <%= booking.getPickupLocation() %>", 20, 70);
        doc.text("Dropoff Location: <%= booking.getDropoffLocation() %>", 20, 80);
        doc.text("Total Paid: LKR <%= String.format("%.2f", totalAmount) %>", 20, 90);
        doc.text("Tax: LKR <%= String.format("%.2f", taxAmount) %>", 20, 100);
        doc.text("Distance: <%= String.format("%.2f", distance) %> KM", 20, 110);
        doc.text("Payment Time: <%= paymentTime %>", 20, 120);
        doc.text("Status: Paid", 20, 130);

        // Save the PDF
        doc.save("Invoice_<%= booking.getId() %>.pdf");
    });
</script>

</body>
</html>