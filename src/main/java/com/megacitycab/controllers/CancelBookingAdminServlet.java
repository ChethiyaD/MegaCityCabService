package com.megacitycab.controllers;

import com.megacitycab.dao.BookingDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/CancelBookingAdminServlet")
public class CancelBookingAdminServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookingIdStr = request.getParameter("booking_id");

        if (bookingIdStr == null || bookingIdStr.isEmpty()) {
            response.getWriter().write("Invalid booking ID");
            return;
        }

        try {
            int bookingId = Integer.parseInt(bookingIdStr);
            BookingDAO bookingDAO = new BookingDAO();

            boolean isDeleted = bookingDAO.cancelAdminBooking(bookingId); // Use new method

            if (isDeleted) {
                response.getWriter().write("Booking successfully cancelled");
            } else {
                response.getWriter().write("Failed to cancel booking");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error occurred while processing the cancellation");
        }
    }
}
