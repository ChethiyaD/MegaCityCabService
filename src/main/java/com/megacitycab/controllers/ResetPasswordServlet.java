package com.megacitycab.controllers;

import com.megacitycab.dao.UserDAO;
import com.megacitycab.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Random;

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String step = request.getParameter("step");
        String username = request.getParameter("username");

        if ("1".equals(step)) {
            // Step 1: Verify username
            User user = userDAO.getUserByUsername(username);
            if (user == null) {
                response.sendRedirect("reset_password_step1.jsp?error=Username does not exist");
            } else {
                request.getSession().setAttribute("username", username);
                response.sendRedirect("reset_password_step2.jsp");
            }
        } else if ("2".equals(step)) {
            // Step 2: Verify NIC
            String nic = request.getParameter("nic");
            username = (String) request.getSession().getAttribute("username");
            User user = userDAO.getUserByUsername(username);
            System.out.println("Debug - Username: " + username);
            System.out.println("Debug - Retrieved User NIC: " + (user != null ? user.getNic() : "User not found"));
            System.out.println("Debug - Entered NIC: " + nic);

            if (user == null) {
                response.sendRedirect("reset_password_step2.jsp?error=User not found");
            } else if (user.getNic() == null || !user.getNic().equals(nic)) {
                response.sendRedirect("reset_password_step2.jsp?error=Invalid NIC. Please try again.");
            } else {
                request.getSession().setAttribute("username", username);
                response.sendRedirect("reset_password_step3.jsp");
            }
        } else if ("3".equals(step)) {
            // Step 3: Reset password
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");
            username = (String) request.getSession().getAttribute("username");

            if (!newPassword.equals(confirmPassword)) {
                response.sendRedirect("reset_password_step3.jsp?username=" + username + "&error=Passwords do not match");
            } else {
                User user = userDAO.getUserByUsername(username);
                if (user != null) {
                    user.setPassword(newPassword); // Hash password in production
                    if (userDAO.updateUser(user)) {
                        request.getSession().removeAttribute("username");
                        response.sendRedirect("index.jsp?message=Password reset successfully");
                    } else {
                        response.sendRedirect("reset_password_step3.jsp?username=" + username + "&error=Failed to update password");
                    }
                } else {
                    response.sendRedirect("reset_password_step3.jsp?username=" + username + "&error=User not found");
                }
            }
        }
    }
}