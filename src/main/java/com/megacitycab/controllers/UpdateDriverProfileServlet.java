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

@WebServlet("/UpdateDriverProfileServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 10 * 1024 * 1024)
public class UpdateDriverProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve the logged-in driver from session
        String username = request.getParameter("username");
        if (username == null || username.trim().isEmpty()) {
            response.sendRedirect("manage_driver_profile.jsp?error=Invalid username");
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

        // Fetch the existing driver to retain the old profile picture if no new one is uploaded
        UserDAO userDAO = new UserDAO();
        User existingDriver = userDAO.getDriverByUsername(username);
        if (existingDriver == null) {
            response.sendRedirect("manage_driver_profile.jsp?error=Driver not found");
            return;
        }

        // If no new profile picture is uploaded, use the old one
        if (fileName == null) {
            fileName = existingDriver.getProfilePicture();
        }

        // Create updated driver object with the new details
        User driver = new User(username, "", "driver", name, address, phone, nic, fileName, existingDriver.getExperience(), existingDriver.getStatus());

        // Update driver information in the database
        if (userDAO.updateDriver(driver)) {
            // Update the session with the new driver details
            HttpSession session = request.getSession();
            session.setAttribute("user", driver);

            response.sendRedirect("manage_driver_profile.jsp?success=Profile updated successfully"); // Updated to match customer servlet
        } else {
            response.sendRedirect("manage_driver_profile.jsp?error=Failed to update profile");
        }
    }
}