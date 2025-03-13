package com.megacitycab.controllers;

import com.megacitycab.dao.BookingDAO;
import com.megacitycab.models.Booking;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/MonthlyBookingReportServlet")
public class MonthlyBookingReportServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(MonthlyBookingReportServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        BookingDAO bookingDAO = new BookingDAO();
        List<Booking> allBookings = bookingDAO.getAllBookings();

        // Get current month and year
        SimpleDateFormat monthFormat = new SimpleDateFormat("MMMM yyyy");
        String currentMonthYear = monthFormat.format(new Date());

        // Filter bookings for the current month
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM");
        String currentMonth = dateFormat.format(new Date());

        // Generate and stream CSV report if download is requested
        String downloadParam = request.getParameter("download");
        if ("true".equalsIgnoreCase(downloadParam)) {
            generateAndStreamCsvReport(response, currentMonth, allBookings);
            return; // Exit after streaming the file
        }

        // Generate HTML report with download link
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Monthly Booking Report</title>");
        out.println("<style>");
        out.println("body {");
        out.println("    font-family: 'Roboto', sans-serif;");
        out.println("    margin: 0;");
        out.println("    padding: 0;");
        out.println("    background-color: #222831;");
        out.println("    background-image: url('images/background.jpg');"); // Replace with your image URL or path
        out.println("    background-size: cover;");
        out.println("    background-position: center;");
        out.println("    background-attachment: fixed;");
        out.println("    color: #EEEEEE;");
        out.println("    line-height: 1.6;");
        out.println("    min-height: 100vh;");
        out.println("    display: flex;");
        out.println("    flex-direction: column;");
        out.println("    overflow-x: hidden;");
        out.println("    backdrop-filter: blur(5px);");
        out.println("    -webkit-backdrop-filter: blur(5px);");
        out.println("}");
        out.println(".report-container {");
        out.println("    max-width: 800px;");
        out.println("    margin: 20px auto;");
        out.println("    padding: 30px;");
        out.println("    background: linear-gradient(135deg, rgba(45, 64, 89, 0.95), rgba(34, 40, 49, 0.95));");
        out.println("    border-radius: 15px;");
        out.println("    box-shadow: 0 8px 30px rgba(0, 0, 0, 0.5);");
        out.println("    text-align: center;");
        out.println("    animation: fadeIn 0.6s ease-in-out;");
        out.println("}");
        out.println("@keyframes fadeIn {");
        out.println("    from { opacity: 0; transform: translateY(20px); }");
        out.println("    to { opacity: 1; transform: translateY(0); }");
        out.println("}");
        out.println("h1 {");
        out.println("    color: #FF5722;");
        out.println("    text-align: center;");
        out.println("    font-family: 'Montserrat', sans-serif;");
        out.println("    font-size: 36px;");
        out.println("}");
        out.println("table {");
        out.println("    width: 100%;");
        out.println("    border-collapse: collapse;");
        out.println("    margin-top: 20px;");
        out.println("}");
        out.println("th, td {");
        out.println("    padding: 12px;");
        out.println("    border: 1px solid rgba(255, 255, 255, 0.1);");
        out.println("    text-align: left;");
        out.println("}");
        out.println("th {");
        out.println("    background-color: #4A90E2;");
        out.println("    color: white;");
        out.println("}");
        out.println("td {");
        out.println("    background-color: rgba(74, 144, 226, 0.1);");
        out.println("}");
        out.println(".back-btn, .download-btn {");
        out.println("    display: inline-block;");
        out.println("    margin-top: 20px;");
        out.println("    padding: 10px 20px;");
        out.println("    background: linear-gradient(90deg, #FF5722, #FF7043);");
        out.println("    color: white;");
        out.println("    text-decoration: none;");
        out.println("    border-radius: 50px;");
        out.println("    box-shadow: 0 4px 12px rgba(255, 87, 34, 0.4);");
        out.println("}");
        out.println(".back-btn:hover, .download-btn:hover {");
        out.println("    transform: translateY(-3px);");
        out.println("    box-shadow: 0 6px 18px rgba(255, 87, 34, 0.6);");
        out.println("}");
        out.println("</style>");
        out.println("<link href='https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap' rel='stylesheet'>");
        out.println("<link href='https://fonts.googleapis.com/css2?family=Montserrat:wght@700&display=swap' rel='stylesheet'>");
        out.println("</head>");
        out.println("<body>");
        out.println("<div class='report-container'>");
        out.println("<h1>Monthly Booking Report - " + currentMonthYear + "</h1>");
        out.println("<p>This report contains all booking details for the current month.</p>");
        out.println("<table>");
        out.println("<tr><th>Booking ID</th><th>Customer</th><th>Driver</th><th>Pickup Location</th><th>Dropoff Location</th><th>Fare (LKR)</th><th>Status</th></tr>");
        for (Booking booking : allBookings) {
            Timestamp bookingTimestamp = booking.getBookingTime();
            if (bookingTimestamp != null) {
                String bookingMonth = dateFormat.format(bookingTimestamp);
                if (bookingMonth.equals(currentMonth)) {
                    out.println("<tr>");
                    out.println("<td>" + booking.getId() + "</td>");
                    out.println("<td>" + booking.getCustomerUsername() + "</td>");
                    out.println("<td>" + (booking.getDriverUsername() != null ? booking.getDriverUsername() : "Not Assigned") + "</td>");
                    out.println("<td>" + booking.getPickupLocation() + "</td>");
                    out.println("<td>" + booking.getDropoffLocation() + "</td>");
                    out.println("<td>" + String.format("%.2f", booking.getEstimatedBill()) + "</td>");
                    out.println("<td>" + booking.getStatus() + "</td>");
                    out.println("</tr>");
                }
            }
        }
        out.println("</table>");
        out.println("<a href='MonthlyBookingReportServlet?download=true' class='download-btn'>Download Excel CSV</a>");
        out.println("<a href='admin_dashboard.jsp' class='back-btn'>Back to Dashboard</a>");
        out.println("</div>");
        out.println("</body>");
        out.println("</html>");

        out.close();
    }

    private void generateAndStreamCsvReport(HttpServletResponse response, String currentMonth, List<Booking> allBookings) throws IOException {
        try {
            // Set response headers for CSV file download
            String fileName = "Monthly_Booking_Report_" + new SimpleDateFormat("MMMM_yyyy").format(new Date()) + ".csv";
            response.setContentType("text/csv; charset=UTF-8");
            response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);

            // Write CSV to response output stream
            try (PrintWriter writer = response.getWriter()) {
                // Write UTF-8 BOM to ensure proper encoding in Excel
                writer.write('\uFEFF');
                // Write headers
                writer.println("Booking ID,Customer,Driver,Pickup Location,Dropoff Location,Fare (LKR),Status");
                // Write booking details for the current month
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM");
                for (Booking booking : allBookings) {
                    Timestamp bookingTimestamp = booking.getBookingTime();
                    if (bookingTimestamp != null) {
                        String bookingMonth = dateFormat.format(bookingTimestamp);
                        if (bookingMonth.equals(currentMonth)) {
                            writer.println(
                                    booking.getId() + "," +
                                            "\"" + booking.getCustomerUsername() + "\"," +
                                            "\"" + (booking.getDriverUsername() != null ? booking.getDriverUsername() : "Not Assigned") + "\"," +
                                            "\"" + booking.getPickupLocation() + "\"," +
                                            "\"" + booking.getDropoffLocation() + "\"," +
                                            String.format("%.2f", booking.getEstimatedBill()) + "," +
                                            "\"" + booking.getStatus() + "\""
                            );
                        }
                    }
                }
                writer.flush();
            }

        } catch (Exception e) {
            LOGGER.severe("Error generating and streaming CSV report: " + e.getMessage());
            response.setContentType("text/html");
            try (PrintWriter writer = response.getWriter()) {
                writer.println("<html><body><p style='color: red;'>Error generating CSV report: " + e.getMessage() + "</p></body></html>");
            }
        }
    }
}