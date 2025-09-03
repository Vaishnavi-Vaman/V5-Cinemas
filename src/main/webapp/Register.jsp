<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Movie Management Registration</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
     
    <link href="https://fonts.googleapis.com/css2?family=Cinzel+Decorative:wght@700&display=swap" rel="stylesheet">
    
    <style>
 /* === Body and Background Overlay === */
body {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  margin: 0;
  font-family: 'Segoe UI', sans-serif;
  background: url('images/original.webp') no-repeat center center/cover;
  position: relative;
}

body::before {
  content: "";
  position: absolute;
  top: 0; left: 0;
  width: 100%; height: 100%;
  background: rgba(0, 0, 0, 0.75);
  z-index: 0;
}

/* === Form Container === */
.form-container.compact-form {
  position: absolute;
  top: 50%; left: 50%;
  transform: translate(-50%, -50%);
  animation: fadeIn 1s ease-in-out;
  z-index: 1;
  width: 100%;
  max-width: 400px;
  min-height: 420px;
  padding: 32px 40px;
  background: rgba(0, 0, 0, 0.6);
  backdrop-filter: blur(10px);
  border-radius: 16px;
  color: #ffffff;
  box-shadow: 0 0 20px rgba(255, 255, 255, 0.2);
  border: 1px solid rgba(255, 255, 255, 0.4); /* thin white border */
}

/* === Title Styling === */
.cinema-title {
  text-align: center;
  margin-bottom: 20px;
  font-size: 36px;
  letter-spacing: 2px;
  background: linear-gradient(90deg, #FFD700, #FF8C00);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  text-shadow: 0 2px 6px rgba(0,0,0,0.7);
  font-family: 'Cinzel Decorative', cursive;
}

/* === Headings === */
.compact-form h2 {
  font-size: 20px;
  color: #ffffff;
  text-align: center;
  margin-bottom: 20px;
  letter-spacing: 1px;
}

/* === Labels === */
.compact-form .form-label {
  font-size: 14px;
  margin-bottom: 4px;
  color: #ffffff;
  font-weight: 500;
}

/* === Inputs, Selects, Textareas === */
input,
input[type="text"],
input[type="email"],
input[type="password"],
input[type="url"],
select,
textarea,
#roleSelect,
#license {
  background-color: transparent !important;
  color: #ffffff !important;
  border: 1px solid rgba(255, 255, 255, 0.3);
  border-radius: 6px;
  padding: 0.6rem 1rem;
  font-size: 15px;
  caret-color: #FFD700;
  appearance: none;
  box-shadow: none !important;
}

/* === Autofill Override (Chrome/WebKit) === */
input:-webkit-autofill,
input:-webkit-autofill:hover,
input:-webkit-autofill:focus {
  -webkit-box-shadow: 0 0 0 1000px rgba(0, 0, 0, 0.6) inset !important;
  -webkit-text-fill-color: #ffffff !important;
  background-color: transparent !important;
  caret-color: #FFD700;
  transition: background-color 9999s ease-out, color 9999s ease-out;
}

/* === Focus Glow === */
input:focus,
select:focus,
textarea:focus,
#roleSelect:focus,
#license:focus {
  outline: none !important;
  border: 2px solid #FFD700 !important;
  box-shadow: 0 0 10px #FFD700 !important;
  background-color: rgba(255, 255, 255, 0.15) !important;
}

/* === Placeholder Styling === */
.compact-form .form-control::placeholder {
  color: #aaa;
}

/* === Button Styling === */
.compact-form .btn-custom {
  background: linear-gradient(to right, #0047ab, #ff1c1c);
  color: white;
  font-weight: bold;
  border: none;
  border-radius: 6px;
  box-shadow: 0 0 10px rgba(255, 76, 76, 0.4);
  transition: background 0.3s ease;
}

.compact-form .btn-custom:hover {
  background: linear-gradient(to right, #ff1c1c, #0047ab);
}

/* === Input Group Icons === */
.input-group-text {
  background-color: transparent;
  border: none;
}

.input-group-text i {
  font-size: 18px;
  color: #00ffff;
  text-shadow: 0 0 4px rgba(0, 255, 255, 0.5);
}

/* === Input Group Effects === */
.input-group {
  transition: background-color 0.3s ease, box-shadow 0.3s ease;
}

.input-group:focus-within {
  background-color: #0047ab;
  border-radius: 6px;
  box-shadow: 0 0 8px rgba(0, 71, 171, 0.6);
}

.input-group:hover {
  box-shadow: 0 0 10px rgba(0, 255, 255, 0.2);
}

/* === Role Dropdown Styling === */
#roleSelect option {
  background-color: rgba(20, 20, 20, 0.95);
  color: #e0e0e0;
  font-size: 15px;
  padding: 8px;
}

#roleSelect option:checked {
  background-color: #222;
  color: #00ffff;
}

#roleSelect {
  background-image: url("data:image/svg+xml;charset=UTF-8,<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='white'><path d='M4 6l4 4 4-4'/></svg>");
  background-repeat: no-repeat;
  background-position: right 1rem center;
  background-size: 1rem;
}

/* === Validation Feedback === */
input.is-valid {
  border: 2px solid #28a745 !important;
  box-shadow: 0 0 8px rgba(40, 167, 69, 0.6) !important;
}

input.is-invalid {
  border: 2px solid #dc3545 !important;
  box-shadow: 0 0 8px rgba(220, 53, 69, 0.6) !important;
  background-image: none !important;
}

/* === Eye Icon Styling === */
#togglePassword {
  border: none;
  background: transparent;
  color: #00ffff;
  font-size: 18px;
}

#togglePassword:hover {
  color: #FFD700;
}

.input-group-text.toggle-icon {
  background: transparent;
  border: none;
  cursor: pointer;
  padding-left: 0;
  padding-right: 0;
}

.input-group-text.toggle-icon i {
  font-size: 18px;
  color: rgba(255,255,255,0.8);
  transition: color 0.3s ease;
}

.input-group-text.toggle-icon:hover i {
  color: #FFD700;
}

/* === Link Styling === */
.links a {
  color: #FFD700;
  font-size: 1.1rem;
  text-decoration: none;
}

.links a:hover {
  color: #FFFACD;
  text-shadow: 0 0 6px rgba(255, 140, 0, 0.6);
}

/* === License Link Styling === */
.license a {
  color: #ffffff;
  text-decoration: none;
  font-size: 0.9rem;
}

/* === Animations === */
@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translate(-50%, -50%) scale(0.95);
  }
  to {
    opacity: 1;
    transform: translate(-50%, -50%) scale(1);
  }
}

</style>

</head>
<body class="d-flex justify-content-center align-items-center">

    <div class="form-container compact-form">
    <h1 class="cinema-title">V5 Cinemas</h1>

    
       <!--  <h2 class="text-center mb-4">Register</h2> -->
        <form action="RegisterServlet" method="post">
        
            <div class="mb-3">
  <input type="text" name="name" class="form-control" placeholder="Your Name" required>
</div>

<div class="mb-3">
  <input type="email" name="email" class="form-control" placeholder="Email" required>
</div>

<!-- Password Field -->
<div class="position-relative mb-3">
  <input type="password" name="password" id="password" class="form-control pe-5" placeholder="Password" required>
  <i id="togglePassword" class="fas fa-eye position-absolute" 
     style="top: 50%; right: 16px; transform: translateY(-50%);
            cursor: pointer; color: rgba(255,255,255,0.8); font-size: 18px;"></i>
</div>
<small id="passwordHelp" class="form-text"></small>

<!-- Confirm Password Field 
<div class="position-relative mb-3">
  <input type="password" name="confirmPassword" id="confirmPassword" class="form-control pe-5" placeholder="Confirm Password" required>
  <i id="toggleConfirmPassword" class="fas fa-eye position-absolute" 
     style="top: 50%; right: 16px; transform: translateY(-50%);
            cursor: pointer; color: rgba(255,255,255,0.8); font-size: 18px;"></i>
</div>
<small id="confirmPasswordHelp" class="form-text"></small>  -->


            <div class="mb-3">
                <label class="form-label">Role</label>
                <select name="role" id="roleSelect" class="form-select" onchange="toggleLicenseField()" required>
               <option value="" disabled selected hidden>Choose Role</option>
                    <option value="customer">Customer</option>
                    <option value="admin">Admin</option>
                </select>
            </div>

            <div id="licenseField" class="mb-3" style="display:none;">
                <label class="form-label">Cinema License URL</label>
                <input type="url" name="licenseUrl"  id="license"  class="form-control" placeholder="https://example.com/license.pdf">
            </div>
<div id="loadingSpinner" class="text-center mb-3" style="display: none;">
  <div class="spinner-border text-light" role="status">
    <span class="visually-hidden">Loading...</span>
  </div>
</div>

           <button type="submit" class="btn btn-custom w-100 mt-3" onclick="showSpinner()">Register</button>
           
                 <div class="text-center mt-4">
                  <span style="color: #ccc;">Already have an account?</span>
                  <a href="Login.jsp" style="color: #FFD700; text-decoration: none; font-weight: bold;">
                  Login here
                  </a>
                </div>

        </form>
    </div>

    <script>
        function toggleLicenseField() {
            const field = document.getElementById('licenseField');
            const role = document.getElementById('roleSelect').value;
            if (role === 'admin') {
                field.style.display = 'block';
                field.style.opacity = 0;
                setTimeout(() => field.style.opacity = 1, 10);
            } else {
                field.style.opacity = 0;
                setTimeout(() => field.style.display = 'none', 300);
            }
        }
        
        
        function showSpinner() {
          document.getElementById('loadingSpinner').style.display = 'block';
        }
      </script>

  <script>
  const passwordField = document.getElementById("password");
  const togglePassword = document.getElementById("togglePassword");
  const helpText = document.getElementById("passwordHelp");

  const regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%?&])[A-Za-z\d@$!%?&]{8,}$/;


  function validatePassword() {
    const password = passwordField.value;
    if (!regex.test(password)) {
      passwordField.classList.add("is-invalid");
      passwordField.classList.remove("is-valid");
      helpText.classList.add("text-danger");
      helpText.classList.remove("text-success");
      helpText.innerText = "Must be 8+ chars, include uppercase, lowercase, number & special char.";
      return false;
    } else {
      passwordField.classList.add("is-valid");
      passwordField.classList.remove("is-invalid");
      helpText.classList.remove("text-danger");
      helpText.classList.add("text-success");
      helpText.innerText = "Strong password ✔";
      return true;
    }
  }

  passwordField.addEventListener("input", validatePassword);

  togglePassword.addEventListener("click", () => {
    const type = passwordField.type === "password" ? "text" : "password";
    passwordField.type = type;
    togglePassword.classList.toggle("fa-eye");
    togglePassword.classList.toggle("fa-eye-slash");
  });

  document.querySelector("form").addEventListener("submit", function (e) {
    if (!validatePassword()) {
      e.preventDefault();
    } else {
      showSpinner();
    }
  });
  
  /* function validateConfirmPassword() { if (confirmPasswordField.value !== passwordField.value || confirmPasswordField.value === "") { confirmPasswordField.classList.add("is-invalid"); confirmPasswordField.classList.remove("is-valid"); confirmHelpText.classList.add("text-danger"); confirmHelpText.classList.remove("text-success"); confirmHelpText.innerText = "Passwords do not match ❌"; return false; } else { confirmPasswordField.classList.add("is-valid"); confirmPasswordField.classList.remove("is-invalid"); confirmHelpText.classList.remove("text-danger"); confirmHelpText.classList.add("text-success"); 
  confirmHelpText.innerText = "Passwords match ✔"; return true; } } */
</script>



</body>
</html>