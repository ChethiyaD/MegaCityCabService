package com.megacitycab.models;

public class User {
    private String username;
    private String password;
    private String role;
    private String name;
    private String address;
    private String phone;
    private String nic;
    private String profilePicture;
    private int experience;
    private String status;
    private String email; // New field

    // Constructor for registration (without experience and status)
    public User(String username, String password, String role, String name, String address, String phone, String nic, String profilePicture) {
        this.username = username;
        this.password = password;
        this.role = role;
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.nic = nic;
        this.profilePicture = profilePicture;
        this.email = null; // Default to null
    }

    // Constructor for Add/Edit Customer (with experience and status)
    public User(String username, String password, String role, String name, String address, String phone, String nic, String profilePicture, int experience, String status) {
        this.username = username;
        this.password = password;
        this.role = role;
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.nic = nic;
        this.profilePicture = profilePicture;
        this.experience = experience;
        this.status = status;
        this.email = null; // Default to null
    }

    // Getters and setters
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getNic() { return nic; }
    public void setNic(String nic) { this.nic = nic; }

    public String getProfilePicture() { return profilePicture; }
    public void setProfilePicture(String profilePicture) { this.profilePicture = profilePicture; }

    public int getExperience() { return experience; }
    public void setExperience(int experience) { this.experience = experience; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    // New getter and setter for email
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
}