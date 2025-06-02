<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Popup Register</title>
  <style>
    /* N?n m? khi popup m? */
    .overlay {
      display: none;
      position: fixed;
      top: 0; left: 0;
      width: 100%; height: 100%;
      background: rgba(0, 0, 0, 0.5);
      z-index: 999;
    }

    /* N?i dung popup */
    .popup {
      background: white;
      padding: 20px;
      width: 300px;
      margin: 100px auto;
      border-radius: 10px;
      text-align: center;
      box-shadow: 0 0 10px rgba(0,0,0,0.25);
    }

    .popup button {
      margin: 10px;
      padding: 10px 20px;
      border: none;
      background-color: #007bff;
      color: white;
      border-radius: 5px;
      cursor: pointer;
    }

    .popup button:hover {
      background-color: #0056b3;
    }

    .close-btn {
      background-color: #dc3545;
    }

    .close-btn:hover {
      background-color: #c82333;
    }
  </style>
</head>
<body>

  <!-- Nút m? popup -->
  <a href="#" onclick="openPopup()">Register</a>

  <!-- Popup overlay -->
  <div id="popupOverlay" class="overlay">
    <div class="popup">
      <h2>Choose Registration Option</h2>
      <button onclick="location.href='register_customer.jsp'">Register as Customer</button>
      <button onclick="location.href='register_seller.jsp'">Register as Seller</button>
      <br><br>
      <button class="close-btn" onclick="closePopup()">Close</button>
    </div>
  </div>

  <!-- Script x? lý popup -->
  <script>
    function openPopup() {
      document.getElementById("popupOverlay").style.display = "block";
    }

    function closePopup() {
      document.getElementById("popupOverlay").style.display = "none";
    }
  </script>

</body>
</html>