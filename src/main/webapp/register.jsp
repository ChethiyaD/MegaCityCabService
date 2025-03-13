<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@700&display=swap" rel="stylesheet">

    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        html, body {
            height: 100%;
            font-family: 'Roboto', sans-serif;
            background-color: #222831;
            background-image: url('images/Customer.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            color: #EEEEEE;
            line-height: 1.4;
            overflow: hidden; /* Prevent scrolling */
        }
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        header {
            background: linear-gradient(90deg, rgba(45, 64, 89, 0.95), rgba(34, 40, 49, 0.95));
            padding: 15px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.4);
            position: sticky;
            top: 0;
            z-index: 1000;
            flex-shrink: 0;
        }
        header h2 {
            font-family: 'Montserrat', sans-serif;
            font-size: 36px;
            color: #FF5722;
            font-weight: 700;
            text-transform: uppercase;
            margin: 0;
        }
        main {
            flex: 1 0 auto;
            display: flex;
            justify-content: center;
            align-items: center; /* Center vertically */
            padding: 5px;
        }
        .container {
            width: 100%;
            max-width: 500px;
            padding: 15px;
            background: linear-gradient(135deg, rgba(45, 64, 89, 0.95), rgba(34, 40, 49, 0.95));
            border-radius: 10px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.5);
            text-align: center;
            animation: fadeIn 0.6s ease-in-out;
            display: flex;
            flex-direction: column;
            height: calc(100% - 10px); /* Fit within main, accounting for padding */
            justify-content: center;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes fadeOut {
            from { opacity: 1; }
            to { opacity: 0; }
        }
        h2 {
            font-family: 'Montserrat', sans-serif;
            font-size: 24px;
            color: #FF5722;
            margin-bottom: 10px;
            flex-shrink: 0;
        }
        #message {
            display: none;
            max-width: 350px;
            margin: 10px auto;
            padding: 8px;
            border-radius: 20px;
            text-align: center;
            font-weight: 500;
            color: #FFFFFF;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.5);
            animation: fadeIn 0.5s ease-in, fadeOut 0.5s ease-out 3s forwards;
            font-size: 14px;
            flex-shrink: 0;
        }
        #message.success {
            background: linear-gradient(90deg, #4CAF50, #66BB6A);
            box-shadow: 0 4px 15px rgba(76, 175, 80, 0.5);
        }
        #message.error {
            background: linear-gradient(90deg, #F44336, #EF5350);
            box-shadow: 0 4px 15px rgba(244, 67, 54, 0.5);
        }
        form {
            display: flex;
            flex-direction: column;
            gap: 8px;
            max-width: 350px;
            margin: 0 auto;
            flex-grow: 1; /* Allow form to take available space */
        }
        label {
            font-size: 14px;
            font-weight: 500;
            color: #EEEEEE;
            text-align: left;
            margin-bottom: 2px;
        }
        input[type="text"],
        input[type="password"],
        input[type="file"],
        select {
            padding: 6px;
            font-size: 12px;
            border: none;
            border-radius: 8px;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid #4A90E2;
            color: #EEEEEE;
            width: 100%;
            box-sizing: border-box;
            transition: box-shadow 0.3s ease;
        }
        input[type="text"]:focus,
        input[type="password"]:focus,
        input[type="file"]:focus,
        select:focus {
            outline: none;
            box-shadow: 0 0 8px rgba(255, 87, 34, 0.5);
            border-color: #FF5722;
        }
        input.invalid {
            border: 1px solid #F44336;
            background-color: rgba(244, 67, 54, 0.1);
        }
        .error-text {
            color: #F44336;
            font-size: 10px;
            display: none;
            margin-top: 2px;
            text-align: left;
        }
        button[type="submit"] {
            padding: 8px 20px;
            background: linear-gradient(90deg, #FF5722, #FF7043);
            color: #FFFFFF;
            border: none;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            margin-top: 10px;
            flex-shrink: 0;
        }
        button[type="submit"]:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(255, 87, 34, 0.6);
        }
        button[type="submit"]:active {
            transform: translateY(0);
            box-shadow: 0 2px 6px rgba(255, 87, 34, 0.4);
        }
        footer {
            background: linear-gradient(90deg, rgba(45, 64, 89, 0.95), rgba(34, 40, 49, 0.95));
            padding: 15px;
            text-align: center;
            box-shadow: 0 -4px 15px rgba(0, 0, 0, 0.4);
            flex-shrink: 0;
        }
        footer .links a {
            color: #FF5722;
            text-decoration: none;
            margin: 0 10px;
            font-size: 12px;
            transition: color 0.3s ease;
        }
        footer .links a:hover {
            color: #4A90E2;
        }
        footer p {
            font-size: 10px;
            color: #CCCCCC;
            margin: 0;
        }
        @media (max-width: 768px) {
            header h2 { font-size: 30px; }
            .container { padding: 10px; }
            h2 { font-size: 20px; }
            #message { max-width: 300px; padding: 6px; font-size: 12px; }
            input[type="text"], input[type="password"], input[type="file"], select { font-size: 11px; }
            button[type="submit"] { padding: 6px 15px; font-size: 12px; }
        }
        @media (max-width: 480px) {
            header { padding: 10px; }
            header h2 { font-size: 24px; }
            .container { padding: 8px; max-width: 400px; }
            h2 { font-size: 18px; }
            #message { font-size: 11px; padding: 5px; }
            label { font-size: 12px; }
            input[type="text"], input[type="password"], input[type="file"], select { font-size: 10px; padding: 5px; }
            .error-text { font-size: 8px; }
            button[type="submit"] { padding: 5px 12px; font-size: 11px; }
            footer .links a { display: block; margin: 3px 0; }
            footer p { font-size: 9px; }
        }
    </style>

    <script>
        window.onload = function() {
            const urlParams = new URLSearchParams(window.location.search);
            const error = urlParams.get('error');
            const messageDiv = document.getElementById("message");

            if (error) {
                showMessage(error, 'error');
            }

            // Real-time validation
            const usernameInput = document.getElementById('username');
            const passwordInput = document.getElementById('password');
            const nameInput = document.getElementById('name');
            const addressInput = document.getElementById('address');
            const phoneInput = document.getElementById('phone');
            const nicInput = document.getElementById('nic');
            const roleInput = document.getElementById('role');

            usernameInput.addEventListener('input', validateUsername);
            passwordInput.addEventListener('input', validatePassword);
            nameInput.addEventListener('input', validateName);
            addressInput.addEventListener('input', validateAddress);
            phoneInput.addEventListener('input', validatePhone);
            nicInput.addEventListener('input', validateNic);

            function validateUsername() {
                const username = usernameInput.value.trim();
                let isValid = true;
                let errorMsg = '';
                const errorElement = document.getElementById('username-error');

                if (username.length < 3) {
                    isValid = false;
                    errorMsg = 'Username must be at least 3 characters long';
                } else if (!/^[a-zA-Z0-9_]+$/.test(username)) {
                    isValid = false;
                    errorMsg = 'Username can only contain letters, numbers, and underscores';
                }

                toggleError(usernameInput, errorElement, isValid, errorMsg);
                return isValid;
            }

            function validatePassword() {
                const password = passwordInput.value.trim();
                let isValid = true;
                let errorMsg = '';
                const errorElement = document.getElementById('password-error');

                if (password.length < 6) {
                    isValid = false;
                    errorMsg = 'Password must be at least 6 characters long';
                } else if (!/[A-Z]/.test(password)) {
                    isValid = false;
                    errorMsg = 'Password must contain at least one uppercase letter';
                } else if (!/[0-9]/.test(password)) {
                    isValid = false;
                    errorMsg = 'Password must contain at least one number';
                }

                toggleError(passwordInput, errorElement, isValid, errorMsg);
                return isValid;
            }

            function validateName() {
                const name = nameInput.value.trim();
                let isValid = true;
                let errorMsg = '';
                const errorElement = document.getElementById('name-error');

                if (name.length < 2) {
                    isValid = false;
                    errorMsg = 'Name must be at least 2 characters long';
                } else if (!/^[a-zA-Z\s]+$/.test(name)) {
                    isValid = false;
                    errorMsg = 'Name can only contain letters and spaces';
                }

                toggleError(nameInput, errorElement, isValid, errorMsg);
                return isValid;
            }

            function validateAddress() {
                const address = addressInput.value.trim();
                let isValid = true;
                let errorMsg = '';
                const errorElement = document.getElementById('address-error');

                if (address.length < 5) {
                    isValid = false;
                    errorMsg = 'Address must be at least 5 characters long';
                }

                toggleError(addressInput, errorElement, isValid, errorMsg);
                return isValid;
            }

            function validatePhone() {
                const phone = phoneInput.value.trim();
                let isValid = true;
                let errorMsg = '';
                const errorElement = document.getElementById('phone-error');

                if (!/^\d{10}$/.test(phone)) {
                    isValid = false;
                    errorMsg = 'Phone must be exactly 10 digits';
                }

                toggleError(phoneInput, errorElement, isValid, errorMsg);
                return isValid;
            }

            function validateNic() {
                const nic = nicInput.value.trim();
                let isValid = true;
                let errorMsg = '';
                const errorElement = document.getElementById('nic-error');

                if (!/^\d{9}[vV]|\d{12}$/.test(nic)) {
                    isValid = false;
                    errorMsg = 'NIC must be 9 digits followed by "V" or "v" or 12 digits';
                }

                toggleError(nicInput, errorElement, isValid, errorMsg);
                return isValid;
            }

            function toggleError(input, errorElement, isValid, errorMsg) {
                if (!isValid) {
                    input.classList.add('invalid');
                    errorElement.textContent = errorMsg;
                    errorElement.style.display = 'block';
                } else {
                    input.classList.remove('invalid');
                    errorElement.style.display = 'none';
                }
            }

            function validateForm() {
                const isUsernameValid = validateUsername();
                const isPasswordValid = validatePassword();
                const isNameValid = validateName();
                const isAddressValid = validateAddress();
                const isPhoneValid = validatePhone();
                const isNicValid = validateNic();
                return isUsernameValid && isPasswordValid && isNameValid && isAddressValid && isPhoneValid && isNicValid;
            }

            // Handle form submission with AJAX
            document.querySelector('form').addEventListener('submit', function(e) {
                e.preventDefault();
                if (!validateForm()) return;

                const formData = new FormData(this);
                fetch('register', {
                    method: 'POST',
                    body: formData
                })
                    .then(response => response.json())
                    .then(data => {
                        if (data.status === "success") {
                            showMessage('Registration successful! Redirecting to login...', 'success', () => {
                                const redirectUrl = data.role === "customer" ? "customers_login.jsp" : "drivers_login.jsp";
                                window.location.href = redirectUrl;
                            });
                            document.querySelector('form').reset(); // Clear form
                        } else {
                            showMessage('Registration failed! Try again.', 'error');
                        }
                    })
                    .catch(error => {
                        showMessage('An error occurred. Please try again.', 'error');
                        console.error('Error:', error);
                    });
            });

            function showMessage(text, type, callback) {
                const messageDiv = document.getElementById("message");
                messageDiv.textContent = text;
                messageDiv.className = 'message ' + type; // Add success or error class
                messageDiv.style.display = "block";
                setTimeout(() => {
                    messageDiv.style.opacity = "0";
                    setTimeout(() => {
                        messageDiv.style.display = "none";
                        messageDiv.style.opacity = "1";
                        if (callback) callback(); // Execute callback after fade out
                    }, 500);
                }, 3000);
            }
        };
    </script>
</head>
<body>
<!-- Header -->
<header>
    <h2>Registration</h2>
</header>

<!-- Main Content -->
<main>
    <div class="container">
        <div id="message"></div>
        <form enctype="multipart/form-data" onsubmit="return false;">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
            <span id="username-error" class="error-text"></span>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
            <span id="password-error" class="error-text"></span>

            <label for="role">Role:</label>
            <select id="role" name="role" required>
                <option value="customer">Customer</option>
                <option value="driver">Driver</option>
            </select>

            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required>
            <span id="name-error" class="error-text"></span>

            <label for="address">Address:</label>
            <input type="text" id="address" name="address" required>
            <span id="address-error" class="error-text"></span>

            <label for="phone">Phone:</label>
            <input type="text" id="phone" name="phone" required>
            <span id="phone-error" class="error-text"></span>

            <label for="nic">NIC:</label>
            <input type="text" id="nic" name="nic" required>
            <span id="nic-error" class="error-text"></span>

            <label for="profile_picture">Profile Picture:</label>
            <input type="file" id="profile_picture" name="profile_picture" accept="image/*">

            <button type="submit">Register</button>
        </form>
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