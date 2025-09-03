<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>V5 Cinemas Intro</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background: white;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
      overflow: hidden;
      cursor: pointer;
      font-family: "Poppins", sans-serif;
    }

    .logo-container {
      text-align: center;
      animation: fadeIn 1s ease-in-out;
    }

    .welcome {
      font-size: 1.8rem;
      font-weight: 500;
      letter-spacing: 2px;
      color: #444;
      opacity: 0;
      animation: fadeInText 1s ease forwards;
    }

    .logo {
      width: 160px;   /* slightly smaller */
      margin: 8px 0;
      opacity: 0;
      animation: dropDown 1s ease forwards;
      animation-delay: 0.5s;
    }

    .title {
      font-size: 3rem;
      font-weight: bold;
      background: linear-gradient(to right, #e52d27, #b31217, #f39c12);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      text-shadow: 2px 2px 6px rgba(0,0,0,0.3);
      opacity: 0;
      animation: zoomIn 1s ease forwards;
      animation-delay: 1s;
    }

    /* Animations */
    @keyframes dropDown {
      from { transform: translateY(-100px); opacity: 0; }
      to { transform: translateY(0); opacity: 1; }
    }

    @keyframes zoomIn {
      from { transform: scale(0.8); opacity: 0; }
      to { transform: scale(1); opacity: 1; }
    }

    @keyframes fadeInText {
      from { opacity: 0; transform: translateY(-10px); }
      to { opacity: 1; transform: translateY(0); }
    }

    @keyframes fadeIn {
      from { opacity: 0; }
      to { opacity: 1; }
    }
  </style>
</head>
<body onclick="skipAnimation()">
  <div class="logo-container">
    <div class="welcome">WELCOME TO</div>
    <img src="images/intro.png" alt="Logo" class="logo">
    <div class="title">V5 CINEMAS</div>
  </div>

  <script>
    function skipAnimation() {
      window.location.href = "HomeServlet"; // go to your main page
    }
    // Auto skip after 3.5s
    setTimeout(skipAnimation, 3500);
  </script>
</body>
</html>
    