<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Pending Approval</title>
    <script type="text/javascript">
        window.onload = function() {
            alert("Your admin account is pending approval. Please wait until a Super Admin approves your request.");
            window.location.href = "Login.jsp"; // Redirect back to login
        }
    </script>
</head>
<body>
</body>
</html>