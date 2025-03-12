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

@WebServlet("/AddCarServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024
)
public class AddCarServlet extends HttpServlet {
    private static final String UPLOAD_DIRECTORY = "uploads"; // Folder to store images

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String carNumber = request.getParameter("car_number");
            String carName = request.getParameter("car_name");
            String carModel = request.getParameter("car_model");
            String carType = request.getParameter("car_type");
            String availabilityStr = request.getParameter("availability");
            String farePerKmStr = request.getParameter("fare_per_km");

            if (carNumber == null || carNumber.trim().isEmpty() ||
                    carName == null || carName.trim().isEmpty() ||
                    farePerKmStr == null || farePerKmStr.trim().isEmpty()) {
                response.sendRedirect("manage_cars.jsp?error=Car number, name, and fare per KM are required");
                return;
            }

            boolean availability = "Available".equals(availabilityStr);
            double farePerKm = Double.parseDouble(farePerKmStr);

            // Handle file upload
            Part filePart = request.getPart("image");
            String fileName = "default.png"; // Default image if no file is uploaded

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
                    fileName = "default.png"; // Revert to default if saving fails
                }
            }

            // Save car details in the database
            CarDAO carDAO = new CarDAO();
            Car car = new Car(0, carName, carModel, carNumber, carType, availability, fileName, farePerKm);
            if (carDAO.addCar(car)) {
                response.sendRedirect("manage_cars.jsp?success=Car added successfully");
            } else {
                response.sendRedirect("manage_cars.jsp?error=Failed to add car. Ensure car number is unique.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manage_cars.jsp?error=Error adding car: " + e.getMessage());
        }
    }
}
