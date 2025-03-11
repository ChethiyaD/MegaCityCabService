package com.megacitycab.controllers;

import com.megacitycab.dao.UserDAO;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeleteCustomerServlet")
public class DeleteCustomerServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        UserDAO userDAO = new UserDAO();

        if (userDAO.deleteCustomer(username)) {
            response.sendRedirect("manage_customers.jsp?success=Customer deleted successfully");
        } else {
            response.sendRedirect("admin_dashboard.jsp?error=Failed to delete customer");
        }
    }
}
