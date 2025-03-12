package com.megacitycab.controllers;

import com.megacitycab.dao.CarDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/DeleteCarServlet")
public class DeleteCarServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String carIdStr = request.getParameter("car_id");
        if (carIdStr == null || carIdStr.trim().isEmpty()) {
            response.sendRedirect("manage_cars.jsp?error=Car ID is required");
            return;
        }

        try {
            int carId = Integer.parseInt(carIdStr);
            CarDAO carDAO = new CarDAO();
            if (carDAO.deleteCarById(carId)) { // Assuming CarDAO has a deleteCarById method
                response.sendRedirect("manage_cars.jsp?success=Car deleted successfully");
            } else {
                response.sendRedirect("manage_cars.jsp?error=Failed to delete car");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("manage_cars.jsp?error=Invalid car ID format");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manage_cars.jsp?error=An error occurred while deleting the car");
        }
    }
}