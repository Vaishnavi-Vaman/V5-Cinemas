<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>V5Cinemas - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Cinzel+Decorative:wght@700&display=swap" rel="stylesheet">
    
    <style>
        /* Page background */
        :root {
  --bg1: #0a192f;   /* deep navy */
  --accent: #3a86ff; /* bright blue */
  --text: #e0f2ff; 
}

        html,body{
            height:100%;
            margin:0;
            padding:0;
        }
      body {
    font-family: Arial, sans-serif;
    background: 
        /* dark overlay for readability */
        linear-gradient(180deg, rgba(15,23,32,0.85), rgba(11,15,20,0.9)),
        /* glow gradients */
        radial-gradient(1200px 600px at 10% 10%, rgba(229,9,20,0.06), transparent 8%),
        radial-gradient(1000px 500px at 90% 90%, rgba(0,255,136,0.03), transparent 8%),
        /* background image */
        url("images/gif.webp");
    background-size: cover;
    background-position: center;
    background-attachment: fixed; /* optional parallax feel */
    color: white;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}

        /* subtle animated glow behind card */
        .hero-glow {
            position: absolute;
            width: 70vmax;
            height: 70vmax;
            filter: blur(160px);
            background: conic-gradient(from 90deg, rgba(229,9,20,0.12), rgba(0,255,136,0.07), rgba(229,9,20,0.08));
            z-index: 0;
            pointer-events: none;
            transform: translateY(-10%);
            opacity: 0.9;
        }

      .login-wrap {
    position: relative;
    z-index: 2; /* above glow */
    width: 360px;
    max-width: calc(100% - 40px);
    padding: 28px;
    border-radius: 16px;
    box-sizing: border-box;

    /* glassmorphism with less transparency */
    background: linear-gradient(180deg, rgba(30,30,30,0.75), rgba(20,20,20,0.7));
    border: 1px solid rgba(255,255,255,0.25);

    box-shadow: 0 8px 30px rgba(2,6,23,0.6);
    backdrop-filter: blur(12px) saturate(120%);
    -webkit-backdrop-filter: blur(12px) saturate(120%);
    border-radius: 16px;
    overflow: hidden;
    transition: transform 0.25s ease, box-shadow 0.25s ease;
    box-shadow: 0 0 20px rgba(255, 255, 255, 0.2);
  border-color: rgba(255, 255, 255, 0.6);
}


        .login-wrap:hover{
            transform: translateY(-6px);
            box-shadow: 0 20px 50px rgba(2,6,23,0.75);
        }

      h2 {
    text-align: center;
    margin: 0 0 20px 0;
    font-size: 36px;
    letter-spacing: 2px;
    background: linear-gradient(90deg, #FFD700, #FF8C00);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    text-shadow: 0 2px 6px rgba(0,0,0,0.7);
    font-family: 'Cinzel Decorative', cursive;
}



        .sub-title {
            text-align:center;
            font-size:12px;
            color: rgba(255,255,255,0.7);
            margin-bottom: 18px;
        }

        label {
            display: block;
            margin-top: 12px;
            font-size: 13px;
            color: rgba(255,255,255,0.85);
        }

        input {
            width: 100%;
            padding: 10px 12px;
            margin-top: 6px;
            border-radius: 10px;
            border: 1px solid rgba(255,255,255,0.08);
            background: rgba(255,255,255,0.03);
            color: #fff;
            outline: none;
            box-sizing: border-box;
            transition: box-shadow 0.15s ease, transform 0.12s ease;
            font-size: 14px;
            -webkit-appearance: none;
        }
        input::placeholder{
            color: rgba(255,255,255,0.55);
        }
        input:focus{
            box-shadow: 0 8px 20px rgba(229,9,20,0.12);
            transform: translateY(-2px);
            border-color: rgba(229,9,20,0.6);
            background: rgba(255,255,255,0.035);
        }

        button {
            margin-top: 18px;
            width: 100%;
            padding: 11px;
            background: linear-gradient(90deg, var(--accent), #ff3b2f);
            border: none;
            color: white;
            cursor: pointer;
            font-size: 15px;
            border-radius: 10px;
            box-shadow: 0 6px 18px rgba(229,9,20,0.20);
            transition: transform 0.12s ease, box-shadow 0.12s ease;
        }
        button:hover {
            transform: translateY(-3px);
            box-shadow: 0 14px 30px rgba(229,9,20,0.24);
        }

        .links {
            margin-top: 12px;
            font-size: 13px;
            text-align: center;
            color: rgba(255,255,255,0.75);
        }
        .links a {
            color: rgba(255,255,255,0.9);
            text-decoration: none;
            font-weight: 600;
        }

        .error {
            color: #ff6b6b;
            text-align: center;
            font-size: 14px;
            margin-bottom: 8px;
        }
        .msg {
            color: #7fffd4;
            text-align: center;
            font-size: 14px;
            margin-bottom: 8px;
        }

        /* small device adjustments */
        @media (max-width:420px){
            .login-wrap{
                padding:20px;
                border-radius:12px;
            }
            h2{ font-size:20px; }
        }
        .links a {
   
  color: #FFD700; /* golden yellow */
  font-size:0.9rem; /* slightly larger font */
  text-decoration: none;
}

    
    </style>
</head>
<body>

<div class="hero-glow" aria-hidden="true"></div>

<div class="login-wrap">
    <h2>V5 Cinemas</h2>
    <div class="sub-title">Welcome back - sign in to continue</div>

    <!-- Success or Error Messages -->
    <c:if test="${not empty param.error}">
        <p class="error">${param.error}</p>
    </c:if>
    <c:if test="${not empty param.msg}">
        <p class="msg">${param.msg}</p>
    </c:if>

    <form action="LoginServlet" method="post" autocomplete="on">
        <label for="email">Email:</label>
        <input id="email" type="email" name="email" required placeholder="you@example.com">

      <label for="password">Password:</label>
<div style="position: relative;">
    <input id="password" type="password" name="password" required placeholder="Enter your password">
    <i id="togglePassword" class="bi bi-eye" 
       style="position: absolute; right: 12px; top: 50%; transform: translateY(-50%);
              cursor: pointer; font-size: 18px; color: rgba(255,255,255,0.8);"></i>
</div>


        <button type="submit">Login</button>
    </form>

    <div class="links">
        <span>New here? <a href="Register.jsp">Create account</a></span>
    </div>
</div>
<script>
    const passwordInput = document.getElementById("password");
    const togglePassword = document.getElementById("togglePassword");

    togglePassword.addEventListener("click", () => {
        const isPassword = passwordInput.getAttribute("type") === "password";
        passwordInput.setAttribute("type", isPassword ? "text" : "password");

        // Toggle icon
        togglePassword.classList.toggle("bi-eye");
        togglePassword.classList.toggle("bi-eye-slash");
    });
</script>


</body>
</html>