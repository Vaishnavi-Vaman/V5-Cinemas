<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="navbar.jsp" %>
<html>
<head>
    <title>${movie.title} - Details</title>
    <style>
        body {
        margin-top:0px;
            background: #111;
            color: #fff;
            font-family: Arial, sans-serif;
            padding: 20px;
            text-align: center;
        }
        .movie-box {
        margin-top:20px;
            background: #222;
            padding: 20px;
            border-radius: 12px;
            display: inline-block;
        }
        .poster {
            width: 250px;
            height: 350px;
            border-radius: 10px;
            object-fit: cover;
        }
        h2 {
            color: #ffcc00;
            margin: 10px 0;
        }
        .genre {
            font-style: italic;
            margin-bottom: 20px;
        }
        .ratings {
            margin-top: 20px;
            text-align: left;
        }
        .rating-card {
            background: #333;
            padding: 10px;
            border-radius: 6px;
            margin-bottom: 8px;
        }
        .book-btn {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 20px;
            background: #ff6600;
            color: #fff;
            text-decoration: none;
            border-radius: 8px;
        }
        .book-btn:hover {
            background: #e65c00;
        }
    </style>
</head>
<body>

<div class="movie-box">
    <img src="${movie.posterUrl}" alt="${movie.title}" class="poster">
    <h2>${movie.title}</h2>
    <p class="genre">Genre: ${movie.genre}</p>

    <!-- ✅ Pass movieId while booking -->
    <a href="TheaterSelectionServlet?movieId=${movie.movieId}" class="book-btn">Book Tickets</a>

    <!-- Ratings -->
    <div class="ratings">
        <h3>User Ratings</h3>
        <c:if test="${empty ratings}">
            <p>No ratings yet</p>
        </c:if>
        <c:forEach var="r" items="${ratings}">
            <div class="rating-card">
                ⭐ ${r.rating}/5 <br/>
                <i>${r.feedback}</i>
            </div>
        </c:forEach>
    </div>
</div>
<%@ include file="footer.jsp" %>
</body>
</html>
