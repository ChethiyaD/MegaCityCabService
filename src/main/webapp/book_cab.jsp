<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.megacitycab.dao.CarDAO, com.megacitycab.models.Car, java.util.List" %>

<%
    CarDAO carDAO = new CarDAO();
    List<Car> availableCars = carDAO.getAvailableCars(); // Fetch only available cars
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Book a Cab</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@700&display=swap" rel="stylesheet">

    <script>
        function updateCarImage() {
            var selectedCar = document.getElementById("carSelect");
            var carImage = document.getElementById("carImage");

            if (selectedCar.value) {
                var image = selectedCar.options[selectedCar.selectedIndex].getAttribute("data-image");
                carImage.src = "uploads/" + image;
            } else {
                carImage.src = "uploads/default.png"; // Show default if no car selected
            }
        }
    </script>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #222831;
            background-image: url('images/Customer.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            color: #EEEEEE;
            line-height: 1.6;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            overflow-x: hidden;
            backdrop-filter: blur(5px);
            -webkit-backdrop-filter: blur(5px);
        }
        header {
            background: linear-gradient(90deg, rgba(45, 64, 89, 0.95), rgba(34, 40, 49, 0.95));
            padding: 20px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.4);
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        header h2 {
            font-family: 'Montserrat', sans-serif;
            font-size: 48px;
            color: #FF5722;
            font-weight: 700;
            text-transform: uppercase;
        }
        main {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            min-height: calc(100vh - 120px);
        }
        .container {
            max-width: 1200px;
            width: 100%;
            padding: 30px;
            background: linear-gradient(135deg, rgba(45, 64, 89, 0.95), rgba(34, 40, 49, 0.95));
            border-radius: 15px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.5);
            text-align: center;
            animation: fadeIn 0.6s ease-in-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        h2 {
            font-family: 'Montserrat', sans-serif;
            font-size: 36px;
            color: #FF5722;
            margin-bottom: 20px;
        }
        p {
            font-size: 18px;
            margin-bottom: 20px;
            color: #F44336; /* Red for error messages */
        }
        form {
            display: flex;
            flex-direction: column;
            gap: 15px;
            max-width: 500px;
            margin: 0 auto;
        }
        label {
            font-size: 16px;
            font-weight: 500;
            color: #EEEEEE;
            text-align: left;
        }
        input[type="text"],
        select {
            padding: 10px;
            font-size: 14px;
            border: none;
            border-radius: 10px;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid #4A90E2;
            color: #EEEEEE;
            width: 100%;
            box-sizing: border-box;
            transition: box-shadow 0.3s ease;
        }
        input[type="text"]:focus,
        select:focus {
            outline: none;
            box-shadow: 0 0 10px rgba(255, 87, 34, 0.5);
            border-color: #FF5722;
        }
        input[type="submit"] {
            padding: 10px 25px;
            background: linear-gradient(90deg, #FF5722, #FF7043);
            color: #FFFFFF;
            border: none;
            border-radius: 25px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        input[type="submit"]:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 18px rgba(255, 87, 34, 0.6);
        }
        input[type="submit"]:active {
            transform: translateY(0);
            box-shadow: 0 2px 8px rgba(255, 87, 34, 0.4);
        }
        #carImage {
            width: 150px;
            height: auto;
            margin-top: 10px;
            border-radius: 5px;
            border: 2px solid #FF5722;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
        }
        a.back-btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 25px;
            background: linear-gradient(90deg, #4A90E2, #4A90E2);
            color: #FFFFFF;
            text-decoration: none;
            border-radius: 25px; /* Rounded as in Manage Customers */
            font-size: 16px;
            font-weight: 600;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        a.back-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 18px rgba(74, 144, 226, 0.6);
        }
        footer {
            background: linear-gradient(90deg, rgba(45, 64, 89, 0.95), rgba(34, 40, 49, 0.95));
            padding: 20px;
            text-align: center;
            box-shadow: 0 -4px 15px rgba(0, 0, 0, 0.4);
            margin-top: 20px;
        }
        footer .links {
            margin-bottom: 10px;
        }
        footer .links a {
            color: #FF5722;
            text-decoration: none;
            margin: 0 15px;
            font-size: 14px;
            transition: color 0.3s ease;
        }
        footer .links a:hover {
            color: #4A90E2;
        }
        footer p {
            font-size: 12px;
            color: #CCCCCC;
        }
        @media (max-width: 768px) {
            header h2 { font-size: 36px; }
            .container { padding: 20px; }
            h2 { font-size: 30px; }
            p { font-size: 16px; }
            input[type="text"],
            select { font-size: 14px; }
            input[type="submit"],
            a.back-btn { padding: 8px 20px; font-size: 14px; }
            #carImage { width: 120px; }
        }
        @media (max-width: 480px) {
            header { padding: 15px; }
            header h2 { font-size: 28px; }
            .container { padding: 15px; }
            h2 { font-size: 24px; }
            p { font-size: 14px; }
            input[type="text"],
            select { font-size: 12px; }
            input[type="submit"],
            a.back-btn { padding: 6px 15px; font-size: 12px; }
            #carImage { width: 100px; }
            footer .links a { display: block; margin: 5px 0; }
        }
    </style>
</head>
<body>
<!-- Header -->
<header>
    <h2>Book a Cab</h2>
</header>

<!-- Main Content -->
<main>
    <div class="container">
        <% if (availableCars.isEmpty()) { %>
        <p>No available cars at the moment. Please check back later.</p>
        <a href="customer_dashboard.jsp" class="back-btn">Back to Dashboard</a>
        <% } else { %>
        <form action="BookCabServlet" method="post">
            <label>Pickup Location:</label>
            <input type="text" name="pickup_location" class="form-control" required><br>

            <label>Dropoff Location:</label>
            <input type="text" name="dropoff_location" class="form-control" required><br>

            <label>Select Car:</label>
            <select name="car_id" id="carSelect" class="form-control" onchange="updateCarImage()">
                <% for (Car car : availableCars) { %>
                <option value="<%= car.getId() %>" data-image="<%= car.getImage() %>">
                    <%= car.getCarName() %> - <%= car.getCarNumber() %>
                </option>
                <% } %>
            </select>

            <br>
            <img id="carImage" src="uploads/<%= availableCars.get(0).getImage() %>" alt="Car Image"><br>

            <input type="submit" value="Book Now" class="btn btn-primary">
        </form>

        <br>
        <a href="customer_dashboard.jsp" class="back-btn mt-3">Back to Dashboard</a>
        <% } %>
    </div>
</main>

<!-- Footer -->
<footer>
    <div class="links">
        <a href="about.jsp">About Us</a>
        <a href="contact.jsp">Contact Us</a>
    </div>
    <p>© 2025 MegaCityCab. All rights reserved.</p>
</footer>
</body>
</html>