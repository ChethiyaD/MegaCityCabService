package com.megacitycab.controllers;

import com.megacitycab.dao.UserDAO;
import com.megacitycab.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

@WebServlet("/UpdateProfileServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 10 * 1024 * 1024)
public class UpdateProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve the logged-in user from session
        String username = request.getParameter("username");
        if (username == null || username.trim().isEmpty()) {
            response.sendRedirect("manage_profile.jsp?error=Invalid username");
            return;
        }

        // Retrieve form data
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String nic = request.getParameter("nic");
        String address = request.getParameter("address");

        // Handle Profile Picture upload
        Part filePart = request.getPart("profilePicture");
        String fileName = null;
        if (filePart != null && filePart.getSize() > 0) {
            fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = getServletContext().getRealPath("") + "uploads"; // Path to save images
            Files.createDirectories(Paths.get(uploadPath)); // Create directories if they don't exist
            Files.copy(filePart.getInputStream(), Paths.get(uploadPath, fileName), StandardCopyOption.REPLACE_EXISTING); // Save file
        }

        // Fetch the existing customer to retain the old profile picture if no new one is uploaded
        UserDAO userDAO = new UserDAO();
        User existingCustomer = userDAO.getUserByUsername(username);
        if (existingCustomer == null) {
            response.sendRedirect("manage_profile.jsp?error=Customer not found");
            return;
        }

        // If no new profile picture is uploaded, use the old one
        if (fileName == null) {
            fileName = existingCustomer.getProfilePicture();
        }

        // Create updated user object with the new details
        User customer = new User(username, "", "customer", name, address, phone, nic, fileName);

        // Update customer information in the database
        if (userDAO.updateCustomer(customer)) {
            // Update the session with the new customer details
            HttpSession session = request.getSession();
            session.setAttribute("user", customer);

            response.sendRedirect("manage_profile.jsp?success=Profile updated successfully");
        } else {
            response.sendRedirect("manage_profile.jsp?error=Failed to update profile");
        }
    }
}

