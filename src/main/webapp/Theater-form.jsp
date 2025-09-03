<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title><c:choose><c:when test="${not empty theater}">Edit Theater</c:when><c:otherwise>Add Theater</c:otherwise></c:choose> - V5 Cinemas</title>
    <style>
        body { background:#121212; color:white; font-family:Arial; }
        form { width:420px; margin:40px auto; background:#1e1e1e; padding:20px; border-radius:8px; }
        label { display:block; margin-top:10px; }
        input { width:100%; padding:8px; margin-top:6px; border-radius:5px; border:none; }
        button { margin-top:12px; width:100%; padding:10px; background:#e50914; border:none; color:white; cursor:pointer;}
    </style>
</head>
<body>
    <h2 style="text-align:center;"><c:choose><c:when test="${not empty theater}">Edit Theater</c:when><c:otherwise>Add Theater</c:otherwise></c:choose></h2>

    <form action="TheaterServlet" method="post">
        <c:if test="${not empty theater}">
            <input type="hidden" name="theaterId" value="${theater.theaterId}" />
        </c:if>

        <label>Theater Name</label>
        <input type="text" name="name" value="${theater.name}" required />

        <label>Location</label>
        <input type="text" name="location" value="${theater.location}" required />

        <button type="submit"><c:choose><c:when test="${not empty theater}">Update</c:when><c:otherwise>Save</c:otherwise></c:choose></button>
    </form>
</body>
</html>
