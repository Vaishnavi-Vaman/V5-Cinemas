<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.time.format.DateTimeFormatter, java.time.LocalDate" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="navbar.jsp" %>

<html>
<head>
    <title>Theater Shows</title>
    <style>
        body {
            background: #fff;
            color: #333;
            font-family: 'Roboto', Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
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

        /* Date Bar */
        .date-bar {
            display: flex;
            justify-content: center;
            border-bottom: 1px solid #ddd;
            margin: 15px 0;
            padding: 10px 0;
            background: #fff;
            overflow-x: auto;
        }
        .date-box {
            flex: 0 0 auto;
            padding: 10px 15px;
            margin: 0 5px;
            border-radius: 6px;
            text-align: center;
            text-decoration: none;
            color: #333;
            border: 1px solid #ddd;
            background: #fff;
            min-width: 70px;
            transition: all 0.2s;
        }
        .date-box:hover {
            border-color: #e50914;
            color: #e50914;
        }
        .date-box.active {
            background: #e50914;
            color: #fff;
            font-weight: bold;
        }
        .day {
            font-size: 12px;
            text-transform: uppercase;
        }
        .date {
            font-size: 16px;
            font-weight: bold;
        }
        .month {
            font-size: 12px;
        }

        /* Theater Block */
        .theater-block {
            background: #fff;
            padding: 20px;
            margin: 15px auto;
            width: 85%;
            border: 1px solid #eee;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        .theater-block h3 {
            margin: 0 0 10px;
            font-size: 18px;
            display: flex;
            align-items: center;
            color: #222;
        }

        /* Showtimes */
        .showtimes {
            margin-top: 15px;
        }
        .showtime-btn {
            display: inline-block;
            padding: 10px 20px;
            margin: 8px;
            border: 1px solid #21c179;
            border-radius: 6px;
            color: #21c179;
            font-weight: bold;
            font-size: 14px;
            text-decoration: none;
            transition: 0.3s;
            cursor: pointer;
        }
        .showtime-btn:hover {
            background: #21c179;
            color: #fff;
        }

        /* Status Legends */
        .legends {
            display: flex;
            gap: 20px;
            justify-content: center;
            font-size: 12px;
            margin: 10px 0 20px;
        }
        .legend-dot {
            display: inline-block;
            width: 10px;
            height: 10px;
            border-radius: 50%;
            margin-right: 5px;
        }
        .available { background: #21c179; }
        .fast-filling { background: #f5a623; }

        /* ==== Vehicle Popup (added only) ==== */
        .popup-overlay {
            display: none; /* hidden initially */
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0,0,0,0.6);
            align-items: center;
            justify-content: center;
            z-index: 1000;
        }
        .popup-content {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            width: 320px;
        }
        .popup-content h2 {
            margin: 0 0 15px;
            font-size: 18px;
        }
        .popup-content select {
            padding: 8px;
            margin-bottom: 15px;
        }
        .popup-content img {
            width: 100px;
            margin-bottom: 15px;
        }
        .popup-content button {
            padding: 10px 20px;
            background: #e50914;
            border: none;
            color: #fff;
            border-radius: 6px;
            cursor: pointer;
        }
        .popup-content button:hover {
            background: #c20812;
        }
    </style>
</head>
<body>


<%
    DateTimeFormatter dayFormatter = DateTimeFormatter.ofPattern("EEE");
    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd");
    DateTimeFormatter monthFormatter = DateTimeFormatter.ofPattern("MMM");
%>

<!-- Date Selection Bar -->
<div class="date-bar">
    <c:forEach var="d" items="${next7Days}">
        <a href="TheaterListServlet?movieId=${movieId}&location=${location}&date=${d}"
           class="date-box ${d eq selectedDate ? 'active' : ''}">
            <div class="day"><%= ((LocalDate)pageContext.findAttribute("d")).format(dayFormatter) %></div>
            <div class="date"><%= ((LocalDate)pageContext.findAttribute("d")).format(dateFormatter) %></div>
            <div class="month"><%= ((LocalDate)pageContext.findAttribute("d")).format(monthFormatter) %></div>
        </a>
    </c:forEach>
</div>

<!-- Legends -->
<div class="legends">
    <span><span class="legend-dot available"></span>Available</span>
    <span><span class="legend-dot fast-filling"></span>Fast Filling</span>
</div>

<!-- Theater & Shows -->
<c:set var="hasShows" value="false" />

<c:forEach var="theater" items="${theaterShows}">
    <c:forEach var="entry" items="${theater.value}">
        <c:if test="${entry.key eq selectedDate and fn:length(entry.value) > 0}">
            <c:set var="hasShows" value="true" />
            <div class="theater-block">
                <h3>${theater.key}</h3>
                <div class="showtimes">
                    <c:forEach var="show" items="${entry.value}">
                        <button class="showtime-btn" onclick="openPopup(${show.id})">
                            ${show.time}
                        </button>
                    </c:forEach>
                </div>
            </div>
        </c:if>
    </c:forEach>
</c:forEach>

<c:if test="${not hasShows}">
    <div class="theater-block" style="text-align:center; font-size:14px; color:#666;">
        No shows scheduled for this date
    </div>
</c:if>

<!-- ===== Vehicle Popup ===== -->
<<!-- ===== Vehicle Popup (BookMyShow Style) ===== -->
<div class="popup-overlay" id="popup">
    <div class="popup-content">
        <!-- Close cross -->
        <span class="close-btn" onclick="closePopup()">×</span>

        <h2>How many seats?</h2>

        <!-- Seat selection buttons -->
        <div class="seat-buttons">
            <button onclick="selectSeats(1)">1</button>
            <button onclick="selectSeats(2)">2</button>
            <button onclick="selectSeats(3)">3</button>
            <button onclick="selectSeats(4)">4</button>
            <button onclick="selectSeats(5)">5</button>
            <button onclick="selectSeats(6)">6</button>
            <button onclick="selectSeats(7)">7</button>
            <button onclick="selectSeats(8)">8</button>
            <button onclick="selectSeats(9)">9</button>
            <button onclick="selectSeats(10)">10</button>
        </div>

        <!-- Vehicle image -->
        <div>
            <img id="vehicleImage" src="images/bike.png" alt="Vehicle">
        </div>

        <!-- Action buttons -->
        <div style="margin-top:15px;">
            <button onclick="proceed()">Continue</button>
            <button style="background:#555; margin-left:10px;" onclick="skipSeats()">Skip</button>
        </div>
    </div>
</div>

<script>
    let selectedShowId = null;
    let selectedSeats = null;

    function openPopup(showId) {
        selectedShowId = showId;
        document.getElementById("popup").style.display = "flex";
    }

    function closePopup() {
        document.getElementById("popup").style.display = "none";
    }

    function selectSeats(num) {
        selectedSeats = num;
        const img = document.getElementById("vehicleImage");

        if (num == 2) img.src = "images/bike.png";
        else if (num == 3) img.src = "images/Desktop/Riksha.avif";
        else if (num == 4 || num == 5 || num == 6) img.src = "images/Desktop/car.png";
        else if (num == 7 || num == 8) img.src = "images/Desktop/van.jpg";
        else if (num >= 9) img.src = "images/Desktop/bus.webp";
        else img.src = "images/bike.png"; // default
    }

    function proceed() {
        if (selectedSeats == null) {
            alert("Please select number of seats or click Skip.");
            return;
        }
        closePopup();
        // Redirect with seats
        window.location.href = "UserSeats?showId=" + selectedShowId + "&seats=" + selectedSeats;
    }

    function skipSeats() {
        closePopup();
        // Redirect without seat restriction
        window.location.href = "UserSeats?showId=" + selectedShowId;
    }
</script>

<style>
    .seat-buttons {
        display: flex;
        flex-wrap: wrap;
        gap: 8px;
        justify-content: center;
        margin-bottom: 15px;
    }
    .seat-buttons button {
        padding: 8px 12px;
        border: 1px solid #ddd;
        border-radius: 6px;
        background: #f9f9f9;
        cursor: pointer;
        font-weight: bold;
        color:black;
    }
    .seat-buttons button:hover {
        background: #e50914;
        color: #fff;
    }

    /* Close button style */
    .close-btn {
        position: absolute;
        top: 10px;
        right: 15px;
        font-size: 22px;
        font-weight: bold;
        color: #333;
        cursor: pointer;
    }
    .close-btn:hover {
        color: #e50914;
    }

    .popup-content {
        position: relative; /* so close-btn is positioned properly */
    }
</style>
<%@ include file="footer.jsp" %>

</body>
</html>


