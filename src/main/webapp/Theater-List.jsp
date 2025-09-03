<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Theaters - V5 Cinemas</title>
    <style>
        body { background:#121212; color:white; font-family:Arial; }
        table { width:90%; margin:20px auto; border-collapse: collapse; }
        th,td { padding:10px; border:1px solid #444; text-align:left; }
        th { background:#e50914; }
        a { color:#00ffcc; text-decoration:none; }
    </style>
</head>
<body>
    <h2 style="text-align:center;">Theaters</h2>
    <div style="text-align:center; margin-bottom:10px;">
        <a href="TheaterServlet?action=new">+ Add Theater</a>
    </div>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Location</th>
                <th>Admin ID</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="theater" items="${theaterList}">
                <tr>
                    <td>${theater.theaterId}</td>
                    <td>${theater.name}</td>
                    <td>${theater.location}</td>
                    <td>${theater.adminId}</td>
                    <td>
                        <a href="TheaterServlet?action=edit&id=${theater.theaterId}">Edit</a> |
                        <a href="TheaterServlet?action=delete&id=${theater.theaterId}" onclick="return confirm('Delete?')">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
