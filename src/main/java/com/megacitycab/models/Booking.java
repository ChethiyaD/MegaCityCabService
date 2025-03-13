package com.megacitycab.models;

import java.sql.Timestamp;

public class Booking {
    private int id;
    private String customerUsername;
    private int carId;
    private String carNumber;
    private String carName;
    private String carImage;
    private String driverUsername;
    private String driverImage;
    private String pickupLocation;
    private String dropoffLocation;
    private String status;
    private double estimatedBill; // Fare in LKR
    private double distance; // Distance in KM
    private Timestamp bookingTime;
    private String cancelledBy;

    // Constructor with all fields
    public Booking(int id, String customerUsername, int carId, String carNumber, String carName, String carImage,
                   String driverUsername, String driverImage, String pickupLocation, String dropoffLocation,
                   String status, double estimatedBill, double distance, Timestamp bookingTime, String cancelledBy) {
        this.id = id;
        this.customerUsername = customerUsername;
        this.carId = carId;
        this.carNumber = carNumber;
        this.carName = carName;
        this.carImage = carImage;
        this.driverUsername = driverUsername;
        this.driverImage = driverImage;
        this.pickupLocation = pickupLocation;
        this.dropoffLocation = dropoffLocation;
        this.status = status;
        this.estimatedBill = estimatedBill;
        this.distance = distance;
        this.bookingTime = bookingTime;
        this.cancelledBy = cancelledBy;
    }

    // Constructor for minimal booking info
    public Booking(int id, String customerUsername, int carId, String pickupLocation, String dropoffLocation,
                   String status, double estimatedBill) {
        this.id = id;
        this.customerUsername = customerUsername;
        this.carId = carId;
        this.pickupLocation = pickupLocation;
        this.dropoffLocation = dropoffLocation;
        this.status = status;
        this.estimatedBill = estimatedBill;
        this.distance = 0.0;
        this.carNumber = "";
        this.carName = "";
        this.carImage = "";
        this.driverUsername = "";
        this.driverImage = "";
        this.bookingTime = new Timestamp(System.currentTimeMillis());
        this.cancelledBy = null;
    }

    // Constructor with driver and distance
    public Booking(int id, String customerUsername, int carId, String driverUsername, String pickupLocation,
                   String dropoffLocation, String status, double estimatedBill, double distance) {
        this.id = id;
        this.customerUsername = customerUsername;
        this.carId = carId;
        this.driverUsername = driverUsername;
        this.pickupLocation = pickupLocation;
        this.dropoffLocation = dropoffLocation;
        this.status = status;
        this.estimatedBill = estimatedBill;
        this.distance = distance;
        this.carNumber = "";
        this.carName = "";
        this.carImage = "";
        this.driverImage = "";
        this.bookingTime = new Timestamp(System.currentTimeMillis());
        this.cancelledBy = null;
    }

    // Constructor matching the one expected by BookingDAO (int, String, int, String, String, String, double, double, Timestamp, String)
    public Booking(int id, String customerUsername, int carId, String driverUsername, String pickupLocation,
                   String dropoffLocation, String status, double estimatedBill, double distance, Timestamp bookingTime, String cancelledBy) {
        this.id = id;
        this.customerUsername = customerUsername;
        this.carId = carId;
        this.driverUsername = driverUsername;
        this.pickupLocation = pickupLocation;
        this.dropoffLocation = dropoffLocation;
        this.status = status;
        this.estimatedBill = estimatedBill;
        this.distance = distance;
        this.carNumber = "";
        this.carName = "";
        this.carImage = "";
        this.driverImage = "";
        this.bookingTime = bookingTime;
        this.cancelledBy = cancelledBy;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getCustomerUsername() { return customerUsername; }
    public void setCustomerUsername(String customerUsername) { this.customerUsername = customerUsername; }
    public int getCarId() { return carId; }
    public void setCarId(int carId) { this.carId = carId; }
    public String getCarNumber() { return carNumber; }
    public void setCarNumber(String carNumber) { this.carNumber = carNumber; }
    public String getCarName() { return carName; }
    public void setCarName(String carName) { this.carName = carName; }
    public String getCarImage() { return carImage; }
    public void setCarImage(String carImage) { this.carImage = carImage; }
    public String getDriverUsername() { return driverUsername; }
    public void setDriverUsername(String driverUsername) { this.driverUsername = driverUsername; }
    public String getDriverImage() { return driverImage; }
    public void setDriverImage(String driverImage) { this.driverImage = driverImage; }
    public String getPickupLocation() { return pickupLocation; }
    public void setPickupLocation(String pickupLocation) { this.pickupLocation = pickupLocation; }
    public String getDropoffLocation() { return dropoffLocation; }
    public void setDropoffLocation(String dropoffLocation) { this.dropoffLocation = dropoffLocation; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public double getEstimatedBill() { return estimatedBill; }
    public void setEstimatedBill(double estimatedBill) { this.estimatedBill = estimatedBill; }
    public double getDistance() { return distance; }
    public void setDistance(double distance) { this.distance = distance; }
    public Timestamp getBookingTime() { return bookingTime; }
    public void setBookingTime(Timestamp bookingTime) { this.bookingTime = bookingTime; }
    public String getCancelledBy() { return cancelledBy; }
    public void setCancelledBy(String cancelledBy) { this.cancelledBy = cancelledBy; }

    public boolean isCarOrDriverInfoMissing() {
        return (carNumber == null || carNumber.isEmpty()) ||
                (carName == null || carName.isEmpty()) ||
                (carImage == null || carImage.isEmpty()) ||
                (driverUsername == null || driverUsername.isEmpty()) ||
                (driverImage == null || driverImage.isEmpty());
    }
}