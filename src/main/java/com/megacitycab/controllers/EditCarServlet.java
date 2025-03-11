package com.megacitycab.controllers;

import com.megacitycab.dao.CarDAO;
import com.megacitycab.models.Car;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

@WebServlet("/EditCarServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024
)
public class EditCarServlet extends HttpServlet {
    private static final String UPLOAD_DIRECTORY = "uploads"; // Folder for storing images

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String carIdStr = request.getParameter("car_id");
            if (carIdStr == null || carIdStr.trim().isEmpty()) {
                response.sendRedirect("manage_cars.jsp?error=Car ID is required");
                return;
            }

            int carId = Integer.parseInt(carIdStr);
            String carNumber = request.getParameter("car_number");
            String carName = request.getParameter("car_name");
            String carModel = request.getParameter("car_model");
            String carType = request.getParameter("car_type");
            String availabilityStr = request.getParameter("availability");
            String farePerKmStr = request.getParameter("fare_per_km");
            String existingImage = request.getParameter("existing_image"); // Keep track of old image

            if (carNumber == null || carNumber.trim().isEmpty() || farePerKmStr == null || farePerKmStr.trim().isEmpty()) {
                response.sendRedirect("manage_cars.jsp?error=Car number and fare per KM are required");
                return;
            }

            boolean availability = "Available".equals(availabilityStr);
            double farePerKm = Double.parseDouble(farePerKmStr);

            CarDAO carDAO = new CarDAO();
            Car existingCar = carDAO.getCarById(carId);
            if (existingCar == null) {
                response.sendRedirect("manage_cars.jsp?error=Car not found");
                return;
            }

            // Handle file upload
            Part filePart = request.getPart("image");
            String fileName = existingImage; // Default to existing image

            if (filePart != null && filePart.getSize() > 0) {
                String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
                fileName = UUID.randomUUID().toString() + fileExtension; // Unique filename

                String uploadPath = getServletContext().getRealPath("/") + UPLOAD_DIRECTORY;
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                String filePath = Paths.get(uploadPath, fileName).toString();
                try {
                    Files.copy(filePart.getInputStream(), Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);
                    System.out.println("DEBUG: Image successfully saved to " + filePath);
                } catch (IOException e) {
                    System.err.println("ERROR: Failed to save image to " + filePath + ": " + e.getMessage());
                    fileName = existingImage; // Revert to old image if saving fails
                }
            }

            // Update car details in the database
            Car car = new Car(carId, carName, carModel, carNumber, carType, availability, fileName, farePerKm);
            if (carDAO.updateCar(car)) {
                response.sendRedirect("manage_cars.jsp?success=Car updated successfully");
            } else {
                response.sendRedirect("manage_cars.jsp?error=Failed to update car");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manage_cars.jsp?error=Error updating car: " + e.getMessage());
        }
    }
}
