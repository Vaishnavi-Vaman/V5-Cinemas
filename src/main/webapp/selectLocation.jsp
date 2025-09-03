<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="navbar.jsp" %>
<html>
<head>
    <title>Select Location</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f9f9f9;
            text-align: center;
            
        }
        
        .search-box {
            width: 300px;
            margin: 20px auto;
            position: relative;
        }
        .search-box input {
            width: 100%;
            padding: 20px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .suggestions {
            position: absolute;
            background: #fff;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: 100%;
            max-height: 200px;
            overflow-y: auto;
            display: none;
            z-index: 1000;
        }
        .suggestions div {
            padding: 10px;
            cursor: pointer;
        }
        .suggestions div:hover {
            background: #f0f0f0;
        }
        .btn {
            margin-top: 20px;
            padding: 10px 20px;
            font-size: 16px;
            background: #d81b60;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-bottom: 420px;
        }
        h2{
        margin-top: 100px;
        }
    </style>
</head>
<body>

<h2>Select Your City</h2>
<c:if test="${not empty msg}">
    <p style="color:red; font-weight:bold; margin-top:10px;">${msg}</p>
</c:if>


<form id="locationForm" action="TheaterListServlet" method="get">
    <input type="hidden" name="movieId" value="${movieId}" />
    
    <div class="search-box">
        <input type="text" id="cityInput" name="location" placeholder="Search for your city..." autocomplete="off" required>
        <div class="suggestions" id="suggestions"></div>
    </div>

    <button type="submit" class="btn">Continue</button>
</form>

<script>
    const availableLocations = [
        <c:forEach var="loc" items="${locations}">
            "${loc}",
        </c:forEach>
    ];

    const input = document.getElementById("cityInput");
    const suggestionsBox = document.getElementById("suggestions");

    input.addEventListener("input", function() {
        const query = this.value.toLowerCase();
        suggestionsBox.innerHTML = "";
        
        if (query.length === 0) {
            suggestionsBox.style.display = "none";
            return;
        }

        const filtered = availableLocations.filter(loc => 
            loc.toLowerCase().includes(query)
        );

        if (filtered.length === 0) {
            suggestionsBox.innerHTML = "<div>Not available</div>";
            suggestionsBox.style.display = "block";
        } else {
            filtered.forEach(loc => {
                const div = document.createElement("div");
                div.textContent = loc;
                div.onclick = function() {
                    input.value = loc;
                    suggestionsBox.style.display = "none";
                };
                suggestionsBox.appendChild(div);
            });
            suggestionsBox.style.display = "block";
        }
    });

    document.addEventListener("click", function(e) {
        if (!e.target.closest(".search-box")) {
            suggestionsBox.style.display = "none";
        }
    });
</script>
<%@ include file="footer.jsp" %>

</body>
</html>
