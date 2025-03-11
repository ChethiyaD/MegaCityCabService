<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.megacitycab.dao.BookingDAO" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    // Retrieve the booking ID, distance, and bill amount
    String bookingIdStr = request.getParameter("booking_id");
    String distanceStr = request.getParameter("distance");
    String billAmountStr = request.getParameter("bill_amount");

    if (bookingIdStr == null || distanceStr == null || billAmountStr == null) {
        response.sendRedirect("view_assigned_bookings.jsp?error=Invalid booking");
        return;
    }

    int bookingId;
    double distance;
    double billAmount;

    try {
        bookingId = Integer.parseInt(bookingIdStr);
        distance = Double.parseDouble(distanceStr);
        // Remove " LKR" from billAmountStr and parse it
        String cleanedBillAmountStr = billAmountStr.replace(" LKR", "").trim();
        billAmount = Double.parseDouble(cleanedBillAmountStr);
    } catch (NumberFormatException e) {
        response.sendRedirect("view_assigned_bookings.jsp?error=Invalid input format");
        return;
    }

    // Update the booking in the database
    BookingDAO bookingDAO = new BookingDAO();
    boolean isUpdated = bookingDAO.confirmBooking(bookingId, billAmount, distance);

    if (isUpdated) {
        response.sendRedirect("view_assigned_bookings.jsp?success=Booking confirmed");
    } else {
        response.sendRedirect("view_assigned_bookings.jsp?error=Failed to confirm booking");
    }
%>