package com.megacitycab.dao;

import com.megacitycab.utils.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;

public class PaymentDAO {
    private Connection conn;

    public PaymentDAO() {
        try {
            this.conn = DBConnection.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean savePayment(int bookingId, String customerUsername, String cardNumber, String cardHolderName, String expiryDate, String cvv, double totalAmount, String email) {
        Connection connection = null;
        PreparedStatement stmt = null;
        try {
            // Get a new connection for this operation
            connection = DBConnection.getConnection();
            if (connection == null) {
                throw new SQLException("Failed to establish database connection");
            }

            String sql = "INSERT INTO payments (booking_id, customer_username, card_number, card_holder_name, expiry_date, cvv, total_amount, email, payment_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)";
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, bookingId);
            stmt.setString(2, customerUsername); // Changed from username to customer_username
            stmt.setString(3, cardNumber);
            stmt.setString(4, cardHolderName);
            stmt.setString(5, expiryDate);
            stmt.setString(6, cvv);
            stmt.setDouble(7, totalAmount); // Changed from amount to total_amount
            stmt.setString(8, email);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error saving payment: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            // Close resources to prevent leaks
            try {
                if (stmt != null) stmt.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                System.err.println("Error closing database resources: " + e.getMessage());
                e.printStackTrace();
            }
        }
    }
}
