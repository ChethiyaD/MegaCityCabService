package com.megacitycab.controllers;

import com.megacitycab.dao.UserDAO;
import com.megacitycab.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

@WebServlet("/AddCustomerServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 10 * 1024 * 1024)
public class AddCustomerServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            String nic = request.getParameter("nic");
            String address = request.getParameter("address");
            String status = request.getParameter("status");
            String email = request.getParameter("email"); // Capture email
            String role = "customer";

            if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty() ||
                    nic == null || nic.trim().isEmpty() || email == null || email.trim().isEmpty()) {
                response.sendRedirect("manage_customers.jsp?error=Username, Password, NIC, and Email cannot be empty");
                return;
            }

            UserDAO userDAO = new UserDAO();

            // Check if username is already taken
            if (userDAO.isUsernameTaken(username)) {
                response.sendRedirect("manage_customers.jsp?error=Username already exists");
                return;
            }

            // Handle profile picture upload
            Part filePart = request.getPart("profile_picture");
            String fileName = "default.png";

            if (filePart != null && filePart.getSize() > 0) {
                fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String uploadPath = getServletContext().getRealPath("") + "uploads";
                Files.createDirectories(Paths.get(uploadPath));
                Files.copy(filePart.getInputStream(), Paths.get(uploadPath, fileName), StandardCopyOption.REPLACE_EXISTING);
            }

            User customer = new User(username, password, role, name, address, phone, nic, fileName, 0, status);
            customer.setEmail(email); // Set email

            // Register user
            if (userDAO.registerUser(customer)) {
                response.sendRedirect("manage_customers.jsp?success=Customer added successfully");
            } else {
                response.sendRedirect("manage_customers.jsp?error=Failed to add customer");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manage_customers.jsp?error=Invalid input data");
        }
    }
}