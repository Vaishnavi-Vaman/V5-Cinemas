<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Logged Out</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            text-align: center;
            margin: 0;
            padding: 0;
        }
        .container {
            margin-top: 100px;
        }
        h2 {
            color: #333;
        }
        a {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background: #ff6600;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        a:hover {
            background: #cc5200;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>You have successfully logged out.</h2>
    <a href="Login.jsp">Login Again</a>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>
