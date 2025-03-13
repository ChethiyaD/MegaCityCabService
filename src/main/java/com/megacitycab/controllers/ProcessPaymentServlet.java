package com.megacitycab.controllers;

import com.megacitycab.dao.BookingDAO;
import com.megacitycab.dao.PaymentDAO;
import com.megacitycab.models.Booking;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;

@WebServlet("/ProcessPaymentServlet")
public class ProcessPaymentServlet extends HttpServlet {
    private static final String EMAIL_USERNAME = "singaplife@gmail.com"; // Replace with your Gmail email
    private static final String EMAIL_PASSWORD = "llau zxec vahm cxox";    // Replace with your app password

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("booking_id"));
        double totalAmount = Double.parseDouble(request.getParameter("total_amount"));
        String cardNumber = request.getParameter("card_number");
        String cardHolderName = request.getParameter("card_holder_name");
        String expiryDate = request.getParameter("expiry_date");
        String cvv = request.getParameter("cvv");
        String email = request.getParameter("email"); // Retrieve the email

        BookingDAO bookingDAO = new BookingDAO();
        PaymentDAO paymentDAO = new PaymentDAO();
        Booking booking = bookingDAO.getBookingById(bookingId);

        if (booking == null) {
            response.sendRedirect("view_bookings.jsp?error=Booking not found");
            return;
        }

        // Update booking status to "Paid"
        boolean paymentSuccess = bookingDAO.updateBookingStatus(bookingId, totalAmount);

        if (paymentSuccess) {
            // Save payment details in the `payment` table, including the email
            boolean paymentRecorded = paymentDAO.savePayment(
                    bookingId, booking.getCustomerUsername(), cardNumber, cardHolderName, expiryDate, cvv, totalAmount, email
            );

            if (paymentRecorded) {
                // Send confirmation email
                try {
                    sendConfirmationEmail(email, booking, totalAmount);
                    response.sendRedirect("payment_success.jsp?booking_id=" + bookingId + "&total_amount=" + totalAmount + "&success=Payment successful and confirmation email sent");
                } catch (MessagingException e) {
                    response.sendRedirect("payment_success.jsp?booking_id=" + bookingId + "&total_amount=" + totalAmount + "&success=Payment successful but failed to send email: " + e.getMessage());
                }
            } else {
                response.sendRedirect("view_bookings.jsp?error=Payment not saved to database");
            }
        } else {
            response.sendRedirect("view_bookings.jsp?error=Payment processing failed");
        }
    }

    private void sendConfirmationEmail(String recipientEmail, Booking booking, double totalAmount) throws MessagingException {
        // Email server properties
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        // Get the Session object
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL_USERNAME, EMAIL_PASSWORD);
            }
        });

        // Create a default MimeMessage object
        Message message = new MimeMessage(session);

        // Set From: header field
        message.setFrom(new InternetAddress(EMAIL_USERNAME));

        // Set To: header field
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));

        // Set Subject
        message.setSubject("Booking Confirmation - Payment Successful");

        // Set the email body
        StringBuilder body = new StringBuilder();
        body.append("Dear ").append(booking.getCustomerUsername()).append(",\n\n");
        body.append("Your payment for the booking has been successfully processed. Below are the details:\n\n");
        body.append("Booking ID: ").append(booking.getId()).append("\n");
        body.append("Pickup Location: ").append(booking.getPickupLocation()).append("\n");
        body.append("Dropoff Location: ").append(booking.getDropoffLocation()).append("\n");
        body.append("Driver: ").append(booking.getDriverUsername() != null ? booking.getDriverUsername() : "Not Assigned").append("\n");
        body.append("Estimated Bill: LKR ").append(String.format("%.2f", booking.getEstimatedBill())).append("\n");
        body.append("Total Amount Paid: LKR ").append(String.format("%.2f", totalAmount)).append("\n");
        body.append("Status: Paid\n\n");
        body.append("Thank you for choosing MegaCityCab!\n");
        body.append("Best regards,\nMegaCityCab Team");

        message.setText(body.toString());

        // Send message
        Transport.send(message);
        System.out.println("Email sent successfully to " + recipientEmail);
    }
}