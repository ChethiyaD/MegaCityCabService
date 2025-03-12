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

import java.io.File;
import java.io.IOException;

@WebServlet("/register")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
        maxFileSize = 1024 * 1024 * 10,       // 10MB
        maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class RegisterServlet extends HttpServlet {
    private static final String UPLOAD_DIRECTORY = "uploads";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String nic = request.getParameter("nic");
        String email = request.getParameter("email"); // Capture email

        if (!"driver".equals(role)) {
            role = "customer";
        }

        // Validate email if role is customer
        if ("customer".equals(role) && (email == null || email.trim().isEmpty())) {
            response.sendRedirect("register.jsp?error=Email is required for customers");
            return;
        }

        // Handle File Upload
        Part filePart = request.getPart("profile_picture");
        String fileName = "default.png"; // Default profile picture

        if (filePart != null && filePart.getSize() > 0) {
            fileName = username + "_" + System.currentTimeMillis() + ".png"; // Unique filename
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir(); // Create uploads directory if it doesn't exist

            filePart.write(uploadPath + File.separator + fileName); // Save file
        }

        // Save user details with profile picture in DB
        User newUser = new User(username, password, role, name, address, phone, nic, fileName);
        if ("customer".equals(role)) {
            newUser.setEmail(email); // Set email for customers
        }
        UserDAO userDAO = new UserDAO();

        if (userDAO.registerUser(newUser)) {
            response.sendRedirect("index.jsp?success=Registration successful! Please log in.");
        } else {
            response.sendRedirect("register.jsp?error=Registration failed! Try again.");
        }
    }
}