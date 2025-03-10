<%@ page session="true" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List, com.megacitycab.dao.CarDAO, com.megacitycab.models.Car" %>

<%
  if (session.getAttribute("role") == null || !"admin".equals(session.getAttribute("role"))) {
    response.sendRedirect("index.jsp");
    return;
  }

  CarDAO carDAO = new CarDAO();
  List<Car> cars = carDAO.getAllCars();

  String success = request.getParameter("success");
  String error = request.getParameter("error");
  String message = success != null ? success : (error != null ? error : null);
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Manage Cars</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@700&display=swap" rel="stylesheet">

  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body {
      font-family: 'Roboto', sans-serif;
      background-color: #222831;
      background-image: url('images/background.jpg');
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
    #searchInput {
      max-width: 400px;
      margin: 0 auto 20px;
      background: rgba(255, 255, 255, 0.1);
      border: none;
      border-radius: 25px;
      padding: 10px 15px;
      color: #EEEEEE;
    }
    #searchInput::placeholder { color: #CCCCCC; }
    #searchInput:focus {
      outline: none;
      box-shadow: 0 0 10px rgba(255, 87, 34, 0.5);
    }
    .btn-primary {
      background: linear-gradient(90deg, #FF5722, #FF7043);
      border: none;
      padding: 10px 25px;
      border-radius: 25px;
      font-weight: 600;
      transition: transform 0.2s ease, box-shadow 0.2s ease;
    }
    .btn-primary:hover {
      transform: translateY(-3px);
      box-shadow: 0 6px 18px rgba(255, 87, 34, 0.6);
    }
    .btn-primary:active {
      transform: translateY(0);
      box-shadow: 0 2px 8px rgba(255, 87, 34, 0.4);
    }
    table {
      border-collapse: collapse;
      width: 100%;
      background: rgba(74, 144, 226, 0.1);
      border-radius: 10px;
      overflow: hidden;
    }
    th, td {
      border: 1px solid #4A90E2;
      padding: 12px;
      text-align: center;
      color: #EEEEEE;
    }
    th {
      background: linear-gradient(90deg, #4A90E2, #4A90E2);
      font-weight: 700;
    }
    tr:nth-child(even) { background: rgba(74, 144, 226, 0.2); }
    tr:hover {
      background: rgba(255, 87, 34, 0.2);
      transition: background 0.3s ease;
    }
    td img {
      border-radius: 5px;
      border: 2px solid #FF5722;
    }
    .action-buttons {
      display: flex;
      justify-content: center;
      gap: 10px;
    }
    .btn-warning, .btn-danger {
      padding: 5px 15px;
      border-radius: 20px;
      font-weight: 500;
      transition: transform 0.2s ease, box-shadow 0.2s ease;
    }
    .btn-warning {
      background: linear-gradient(90deg, #FF9800, #FFB300);
    }
    .btn-warning:hover {
      transform: translateY(-2px);
      box-shadow: 0 4px 12px rgba(255, 152, 0, 0.5);
    }
    .btn-danger {
      background: linear-gradient(90deg, #F44336, #EF5350);
    }
    .btn-danger:hover {
      transform: translateY(-2px);
      box-shadow: 0 4px 12px rgba(244, 67, 54, 0.5);
    }
    .btn-secondary {
      background: linear-gradient(90deg, #4A90E2, #4A90E2);
      border: none;
      padding: 10px 25px;
      border-radius: 25px;
      font-weight: 600;
      transition: transform 0.2s ease, box-shadow 0.2s ease;
    }
    .btn-secondary:hover {
      transform: translateY(-3px);
      box-shadow: 0 6px 18px rgba(74, 144, 226, 0.6);
    }
    .modal-content {
      background: linear-gradient(135deg, rgba(45, 64, 89, 0.95), rgba(34, 40, 49, 0.95));
      border-radius: 15px;
      color: #EEEEEE;
    }
    .modal-header {
      background: linear-gradient(90deg, #FF5722, #FF7043);
      border-top-left-radius: 15px;
      border-top-right-radius: 15px;
    }
    .modal-title {
      font-family: 'Montserrat', sans-serif;
      font-weight: 700;
    }
    .modal-body label { font-weight: 500; }
    .form-control {
      background: rgba(255, 255, 255, 0.1);
      border: 1px solid #4A90E2;
      border-radius: 10px;
      color: #EEEEEE;
    }
    .form-control:focus {
      outline: none;
      box-shadow: 0 0 10px rgba(255, 87, 34, 0.5);
      border-color: #FF5722;
    }
    .btn-success {
      background: linear-gradient(90deg, #4CAF50, #66BB6A);
      border: none;
      padding: 10px 25px;
      border-radius: 25px;
      font-weight: 600;
      transition: transform 0.2s ease, box-shadow 0.2s ease;
    }
    .btn-success:hover {
      transform: translateY(-3px);
      box-shadow: 0 6px 18px rgba(76, 175, 80, 0.6);
    }
    #message {
      display: none;
      max-width: 600px;
      margin: 20px auto;
      padding: 15px;
      background: linear-gradient(90deg, #4CAF50, #66BB6A);
      border-radius: 25px;
      text-align: center;
      font-weight: 500;
      color: #FFFFFF;
      box-shadow: 0 4px 15px rgba(76, 175, 80, 0.5);
      animation: fadeIn 0.5s ease-in, fadeOut 0.5s ease-out 3s forwards;
    }
    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(-20px); }
      to { opacity: 1; transform: translateY(0); }
    }
    @keyframes fadeOut {
      from { opacity: 1; }
      to { opacity: 0; }
    }
    footer {
      background: linear-gradient(90deg, rgba(45, 64, 89, 0.95), rgba(34, 40, 49, 0.95));
      padding: 20px;
      text-align: center;
      box-shadow: 0 -4px 15px rgba(0, 0, 0, 0.4);
      margin-top: 20px;
    }
    footer .links { margin-bottom: 10px; }
    footer .links a {
      color: #FF5722;
      text-decoration: none;
      margin: 0 15px;
      font-size: 14px;
      transition: color 0.3s ease;
    }
    footer .links a:hover { color: #4A90E2; }
    footer p { font-size: 12px; color: #CCCCCC; }
    .error-text {
      color: #F44336;
      font-size: 12px;
      display: none;
      margin-top: 5px;
    }
    .form-control.invalid {
      border-color: #F44336;
      box-shadow: 0 0 5px rgba(244, 67, 54, 0.5);
    }
    @media (max-width: 768px) {
      header h2 { font-size: 36px; }
      .container { padding: 20px; }
      #searchInput { max-width: 100%; }
      th, td { padding: 8px; font-size: 14px; }
      .btn-primary, .btn-secondary { padding: 8px 20px; font-size: 14px; }
      .btn-warning, .btn-danger { padding: 4px 12px; font-size: 12px; }
      .modal-content { margin: 0 10px; }
      .form-control { font-size: 14px; }
      .btn-success { padding: 8px 20px; font-size: 14px; }
      #message { max-width: 100%; padding: 10px; }
    }
    @media (max-width: 480px) {
      header { padding: 15px; }
      header h2 { font-size: 28px; }
      .container { padding: 15px; }
      table { font-size: 12px; }
      th, td { padding: 6px; }
      .action-buttons { flex-direction: column; gap: 5px; }
      .btn-primary, .btn-secondary, .btn-success { width: 100%; margin-bottom: 10px; }
      .btn-warning, .btn-danger { width: 100%; }
      footer .links a { display: block; margin: 5px 0; }
    }
  </style>

  <script>
    function validateForm() {
      let isValid = true;
      const carName = document.getElementById("editCarName");
      const carModel = document.getElementById("editCarModel");
      const carNumber = document.getElementById("editCarNumber");
      const farePerKm = document.getElementById("editFarePerKm");

      [carName, carModel, carNumber, farePerKm].forEach(input => {
        input.classList.remove("invalid");
        const errorDiv = document.getElementById(input.id + "Error");
        if (errorDiv) errorDiv.style.display = "none";
      });

      if (!carName.value.trim()) {
        showError(carName, "Car name is required");
        isValid = false;
      } else if (carName.value.length > 50) {
        showError(carName, "Car name must be less than 50 characters");
        isValid = false;
      }

      if (!carModel.value.trim()) {
        showError(carModel, "Car model is required");
        isValid = false;
      } else if (carModel.value.length > 50) {
        showError(carModel, "Car model must be less than 50 characters");
        isValid = false;
      }

      const carNumberPattern = /^[A-Za-z0-9-]{1,20}$/;
      if (!carNumber.value.trim()) {
        showError(carNumber, "Car number is required");
        isValid = false;
      } else if (!carNumberPattern.test(carNumber.value)) {
        showError(carNumber, "Car number must be alphanumeric (max 20 characters)");
        isValid = false;
      }

      if (!farePerKm.value || farePerKm.value <= 0) {
        showError(farePerKm, "Fare per KM must be a positive number");
        isValid = false;
      } else if (farePerKm.value > 10000) {
        showError(farePerKm, "Fare per KM cannot exceed 10,000");
        isValid = false;
      }

      return isValid;
    }

    function showError(input, message) {
      input.classList.add("invalid");
      const errorDiv = document.getElementById(input.id + "Error");
      if (errorDiv) {
        errorDiv.textContent = message;
        errorDiv.style.display = "block";
      }
    }

    function openEditModal(id, carName, carModel, carNumber, carType, farePerKm, availability, image) {
      document.getElementById("editModalTitle").innerText = id ? "Edit Car" : "Add Car";
      document.getElementById("editCarId").value = id || '';
      document.getElementById("editCarName").value = carName || '';
      document.getElementById("editCarModel").value = carModel || '';
      document.getElementById("editCarNumber").value = carNumber || '';
      document.getElementById("editCarType").value = carType || 'Sedan';
      document.getElementById("editFarePerKm").value = farePerKm || '0.00';
      document.getElementById("editAvailability").value = availability || 'Available';

      // Updated image path logic without cache-busting
      if (image) {
        document.getElementById("currentCarImage").src = "uploads/" + image;
        document.getElementById("existingImage").value = image;
      } else {
        document.getElementById("currentCarImage").src = "uploads/default.png";
        document.getElementById("existingImage").value = "default.png";
      }

      const form = document.getElementById("editForm");
      form.action = id ? "EditCarServlet" : "AddCarServlet";
      console.log("Form action set to: " + form.action + " for ID: " + id);

      ["editCarName", "editCarModel", "editCarNumber", "editFarePerKm"].forEach(id => {
        const input = document.getElementById(id);
        input.classList.remove("invalid");
        const errorDiv = document.getElementById(id + "Error");
        if (errorDiv) errorDiv.style.display = "none";
      });

      var modal = new bootstrap.Modal(document.getElementById("editCarModal"));
      modal.show();
    }

    function searchCars() {
      let input = document.getElementById("searchInput").value.toLowerCase();
      let rows = document.querySelectorAll("#carsTable tbody tr");

      rows.forEach(row => {
        let carName = row.cells[0].textContent.toLowerCase();
        let carModel = row.cells[1].textContent.toLowerCase();
        let carNumber = row.cells[2].textContent.toLowerCase();
        let carType = row.cells[3].textContent.toLowerCase();
        let availability = row.cells[4].textContent.toLowerCase();
        let farePerKm = row.cells[6].textContent.toLowerCase();

        if (carName.includes(input) || carModel.includes(input) || carNumber.includes(input) ||
                carType.includes(input) || availability.includes(input) || farePerKm.includes(input)) {
          row.style.display = "";
        } else {
          row.style.display = "none";
        }
      });
    }

    function confirmDelete(event) {
      if (!confirm("Are you sure you want to delete this car?")) {
        event.preventDefault();
      }
    }

    window.onload = function() {
      const message = "<%= message != null ? message : "" %>";
      if (message) {
        const messageDiv = document.getElementById("message");
        messageDiv.textContent = message;
        messageDiv.style.background = message.includes("success")
                ? "linear-gradient(90deg, #4CAF50, #66BB6A)"
                : "linear-gradient(90deg, #F44336, #EF5350)";
        messageDiv.style.display = "block";
        setTimeout(() => {
          messageDiv.style.opacity = "0";
          setTimeout(() => {
            messageDiv.style.display = "none";
            messageDiv.style.opacity = "1";
            // Removed cache-busting refresh logic
          }, 500);
        }, 3000);
      }
    };
  </script>
</head>
<body>
<header>
  <h2>Manage Cars</h2>
</header>

<main>
  <div class="container">
    <input type="text" id="searchInput" class="form-control mb-3"
           placeholder="Search by Name, Model, Number, Type, Availability, or Fare"
           onkeyup="searchCars()">

    <button type="button" class="btn btn-primary" onclick="openEditModal('', '', '', '', 'Sedan', '0.00', 'Available', 'default.png')">
      Add Car
    </button>

    <div id="message"></div>

    <table border="1" class="mt-3" id="carsTable">
      <thead>
      <tr>
        <th>Car Name</th>
        <th>Model</th>
        <th>Car Number</th>
        <th>Type</th>
        <th>Availability</th>
        <th>Image</th>
        <th>Fare per KM (Rs.)</th>
        <th>Actions</th>
      </tr>
      </thead>
      <tbody>
      <% for (Car car : cars) { %>
      <tr>
        <td><%= car.getCarName() %></td>
        <td><%= car.getCarModel() %></td>
        <td><%= car.getCarNumber() %></td>
        <td><%= car.getCarType() %></td>
        <td><%= car.isAvailable() ? "Available" : "Not Available" %></td>
        <td>
          <img src="uploads/<%= car.getImage() != null ? car.getImage() : "default.png" %>" alt="Car Image" width="50">
        </td>
        <td><%= car.getFarePerKmLKR() %></td>
        <td class="action-buttons">
          <button class="btn btn-warning btn-sm" onclick="openEditModal(
                  '<%= car.getId() %>',
                  '<%= car.getCarName() %>',
                  '<%= car.getCarModel() %>',
                  '<%= car.getCarNumber() %>',
                  '<%= car.getCarType() %>',
                  '<%= car.getFarePerKmLKR() %>',
                  '<%= car.isAvailable() ? "Available" : "Not Available" %>',
                  '<%= car.getImage() != null ? car.getImage() : "default.png" %>'
                  )">Edit</button>

          <form action="DeleteCarServlet" method="post" style="display:inline;" onsubmit="confirmDelete(event)">
            <input type="hidden" name="car_id" value="<%= car.getId() %>">
            <input type="submit" class="btn btn-danger btn-sm" value="Delete">
          </form>
        </td>
      </tr>
      <% } %>
      </tbody>
    </table>

    <div class="modal fade" id="editCarModal" tabindex="-1" aria-labelledby="editModalTitle" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="editModalTitle">Edit Car</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <form id="editForm" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
              <input type="hidden" name="car_id" id="editCarId">
              <input type="hidden" name="existing_image" id="existingImage">

              <label>Car Name:</label>
              <input type="text" name="car_name" id="editCarName" class="form-control" required>
              <div id="editCarNameError" class="error-text"></div><br>

              <label>Model:</label>
              <input type="text" name="car_model" id="editCarModel" class="form-control" required>
              <div id="editCarModelError" class="error-text"></div><br>

              <label>Car Number:</label>
              <input type="text" name="car_number" id="editCarNumber" class="form-control" required>
              <div id="editCarNumberError" class="error-text"></div><br>

              <label>Type:</label>
              <select name="car_type" id="editCarType" class="form-control">
                <option value="Sedan">Sedan</option>
                <option value="SUV">SUV</option>
                <option value="Hatchback">Hatchback</option>
              </select><br>

              <label>Fare per KM (Rs.):</label>
              <input type="number" step="0.01" name="fare_per_km" id="editFarePerKm" class="form-control" required>
              <div id="editFarePerKmError" class="error-text"></div><br>

              <label>Availability:</label>
              <select name="availability" id="editAvailability" class="form-control">
                <option value="Available">Available</option>
                <option value="Not Available">Not Available</option>
              </select><br>

              <label>Car Image:</label>
              <input type="file" name="image" class="form-control" accept="image/*"><br>

              <img id="currentCarImage" src="uploads/default.png" width="100"><br>

              <button type="submit" class="btn btn-success">Save Changes</button>
            </form>
          </div>
        </div>
      </div>
    </div>

    <br>
    <a href="admin_dashboard.jsp" class="btn btn-secondary mt-3">Back to Dashboard</a>
  </div>
</main>

<footer>
  <div class="links">
    <a href="about.jsp">About Us</a>
    <a href="contact.jsp">Contact Us</a>
  </div>
  <p>© 2025 MegaCityCab. All rights reserved.</p>
</footer>

</body>
</html>