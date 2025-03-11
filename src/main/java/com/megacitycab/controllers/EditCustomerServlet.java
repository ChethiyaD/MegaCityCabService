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

@WebServlet("/EditCustomerServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 10 * 1024 * 1024)
public class EditCustomerServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password"); // Get password
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String nic = request.getParameter("nic");
        String address = request.getParameter("address");
        String status = request.getParameter("status");

        if (username == null || username.trim().isEmpty()) {
            response.sendRedirect("manage_customers.jsp?error=Invalid username");
            return;
        }

        Part filePart = request.getPart("profile_picture");
        String fileName = null;

        if (filePart != null && filePart.getSize() > 0) {
            fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = getServletContext().getRealPath("") + "uploads";
            Files.createDirectories(Paths.get(uploadPath));
            Files.copy(filePart.getInputStream(), Paths.get(uploadPath, fileName), StandardCopyOption.REPLACE_EXISTING);
        }

        UserDAO userDAO = new UserDAO();
        User existingCustomer = userDAO.getUserByUsername(username);
        if (existingCustomer == null) {
            response.sendRedirect("manage_customers.jsp?error=Customer not found");
            return;
        }

        if (fileName == null) {
            fileName = existingCustomer.getProfilePicture();
        }

        if (status == null || status.trim().isEmpty()) {
            status = "Active"; // Default value
        }

        if (password == null || password.trim().isEmpty()) {
            password = existingCustomer.getPassword(); // Keep old password if not changed
        }

        User customer = new User(username, password, "customer", name, address, phone, nic, fileName, 0, status);

        if (userDAO.updateCustomer(customer)) {
            response.sendRedirect("manage_customers.jsp?success=Customer updated successfully");
        } else {
            response.sendRedirect("manage_customers.jsp?error=Failed to update customer");
        }
    }
}
