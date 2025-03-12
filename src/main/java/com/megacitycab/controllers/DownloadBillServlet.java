package com.megacitycab.controllers;

import com.megacitycab.dao.BookingDAO;
import com.megacitycab.models.Booking;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDType1Font;

@WebServlet("/DownloadBillServlet")
public class DownloadBillServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("booking_id"));

        BookingDAO bookingDAO = new BookingDAO();
        Booking booking = bookingDAO.getBookingById(bookingId);

        if (booking == null) {
            response.sendRedirect("view_bookings.jsp?error=Booking not found");
            return;
        }

        // PDF Configuration
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=Bill_" + bookingId + ".pdf");

        try (OutputStream out = response.getOutputStream()) {
            PDDocument document = new PDDocument();
            PDPage page = new PDPage();
            document.addPage(page);

            PDPageContentStream contentStream = new PDPageContentStream(document, page);
            contentStream.beginText();

            // Header: MegaCityCab - Invoice
            contentStream.setFont(PDType1Font.HELVETICA_BOLD, 18);
            contentStream.newLineAtOffset(200, 750);  // Positioning header
            contentStream.showText("MegaCityCab - Invoice");
            contentStream.endText();

            // Content font
            contentStream.setFont(PDType1Font.HELVETICA, 12);
            contentStream.beginText();
            contentStream.newLineAtOffset(50, 700);

            // Formatting invoice details with better alignment
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String date = formatter.format(new Date());

            // Adding invoice details to PDF with alignment
            contentStream.showText("Invoice Date: " + date);
            contentStream.newLine();
            contentStream.showText("Booking ID: " + booking.getId());
            contentStream.newLine();
            contentStream.showText("Customer: " + booking.getCustomerUsername());
            contentStream.newLine();
            contentStream.showText("Driver: " + booking.getDriverUsername());
            contentStream.newLine();
            contentStream.showText("Pickup Location: " + booking.getPickupLocation());
            contentStream.newLine();
            contentStream.showText("Dropoff Location: " + booking.getDropoffLocation());
            contentStream.newLine();
            contentStream.showText("Estimated Bill: LKR " + String.format("%.2f", booking.getEstimatedBill()));
            contentStream.newLine();

            // Tax, Discount, and Total Calculation
            double taxAmount = booking.getEstimatedBill() * 0.05;
            double discountAmount = bookingDAO.calculateDiscount(booking.getCustomerUsername(), booking.getDriverUsername());
            double totalAmount = booking.getEstimatedBill() + taxAmount - discountAmount;

            // Adding tax, discount, and total amount details
            contentStream.showText("Tax (5%): LKR " + String.format("%.2f", taxAmount));
            contentStream.newLine();
            contentStream.showText("Discount: LKR " + String.format("%.2f", discountAmount));
            contentStream.newLine();
            contentStream.showText("Total Amount Paid: LKR " + String.format("%.2f", totalAmount));
            contentStream.endText();

            // Closing the content stream and saving the document
            contentStream.close();
            document.save(out);
            document.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
