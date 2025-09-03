<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
    <title>Select Seats</title>
  <!-- Put this in <head>, not inside <style> -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
/* General Body Styling */
body {
    background-color: #000;   /* Pure black */
    font-family: 'Segoe UI', sans-serif;
    color: #fff;
    padding: 20px;
}

/* Title Styling */
h2 {
    color: #e50914;
    margin-bottom: 30px;
    font-size: 2rem;
    text-align: center;
}

.proceed-container {
    text-align: center;
    margin-top: 20px;
}
.proceed-container button {
    display: inline-block;
}

/* Screen Banner */
.screen {
    background-color: #333;
    color: #fff;
    padding: 12px;
    margin: 0 auto 30px;
    width: 80%;
    border-radius: 10px;
    font-weight: bold;
    box-shadow: 0 0 10px rgba(255,255,255,0.1);
    text-align: center;
}

/* Seat Row Layout */
.seat-row {
    display: flex;
    align-items: center;
    justify-content: center;
    flex-wrap: wrap;
    margin-bottom: 15px;
}

/* Row Label with White Background */
.row-label {
    background-color: #fff;
    color: #000;
    font-weight: bold;
    border-radius: 6px;
    padding: 8px 12px;
    margin-right: 10px;
    min-width: 30px;
    text-align: center;
}

/* Seat Style Base */
.seat {
    position: relative;
    width: 36px;
    height: 36px;
    margin: 6px;
    background-color: #a9a9a9; /* Lighter Grey seats */
    border: 3px solid transparent;
    border-radius: 6px;
    cursor: pointer;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 12px;
    font-weight: bold;
    color: #fff;
    animation: fadeIn 0.5s ease-in;
}

/* Decorative Backrest */
.seat::before {
    content: '';
    position: absolute;
    top: -16px;
    left: 0;
    width: 36px;
    height: 16px;
    background-color: inherit;
    border-radius: 6px 6px 0 0;
}

/* Decorative Base */
.seat::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    width: 36px;
    height: 36px;
    background-color: inherit;
    border-radius: 6px;
    z-index: -1;
}

/* Selected Seat */
.selected {
    background-color: #2e7d32;
    box-shadow: 0 0 10px #2e7d32;
    transform: scale(1.1);
}

/* Booked Seat */
.booked {
    background-color: #f44336 !important;
    border-color: #f44336 !important;
    cursor: not-allowed;
    opacity: 0.6;
}

/* Hover Effect for Available Seats */
.available:hover {
    transform: scale(1.1);
    box-shadow: 0 0 8px rgba(255,255,255,0.3);
}

/* Seat Types (Border Differentiation) */
.premium {
    border-color: #FFD700; /* Gold */
}
.gold {
    border-color: #FF9800; /* Deep Orange */
}
.silver {
    border-color: #B0C4DE; /* Light Steel Blue */
}

/* Aisle Spacing */
.aisle {
    margin-right: 30px;
}

/* Seat Selection Summary */
#summary {
    margin: 30px auto;
    font-size: 1.1rem;
    color: #ffeb3b;
    font-weight: bold;
    text-align: center;
}

/* Bootstrap-style Button Overrides */
button {
    background-color: #e50914;
    color: #fff;
    border: none;
    border-radius: 20px;
    padding: 12px 24px;
    font-size: 1rem;
    cursor: pointer;
    margin: 10px;
    transition: background-color 0.3s ease;
}
button:hover {
    background-color: #b00610;
}

/* Booking Popup Modal */
#popup {
    background-color: #1e1e1e;
    color: #fff;
    padding: 25px;
    border-radius: 10px;
    box-shadow: 0 0 20px rgba(255,255,255,0.2);
    position: fixed;
    top: 50%; left: 50%;
    transform: translate(-50%, -50%);
    display: none;
    z-index: 100;
    width: 300px;
    animation: slideUp 0.4s ease-out;
}

/* Input Fields in Popup */
#popup input {
    width: 90%;
    padding: 10px;
    margin: 10px 0;
    border-radius: 8px;
    border: none;
    font-size: 14px;
}

/* Animations */
@keyframes fadeIn {
    from { opacity: 0; transform: scale(0.8); }
    to { opacity: 1; transform: scale(1); }
}
@keyframes slideUp {
    from { transform: translate(-50%, 60%); opacity: 0; }
    to { transform: translate(-50%, -50%); opacity: 1; }
}
</style>
   

    <script>
        let selectedSeats = [];

        function toggleSeat(seatId, seatLabel, price) {
            const seatDiv = document.getElementById("seat-" + seatId);
            if (seatDiv.classList.contains("booked")) return;

            if (selectedSeats.some(s => s.id === seatId)) {
                selectedSeats = selectedSeats.filter(s => s.id !== seatId);
                seatDiv.classList.remove("selected");
            } else {
                selectedSeats.push({id: seatId, label: seatLabel, price: price});
                seatDiv.classList.add("selected");
            }

            document.getElementById("summary").innerText =
                (selectedSeats.length ? "Selected: " + selectedSeats.map(s => s.label).join(", ") : "No seats selected")
                + " | Total ₹" + selectedSeats.reduce((sum,s)=>sum+s.price,0);
        }

        function confirmBooking() {
            if (selectedSeats.length === 0) { alert("Please select at least one seat!"); return; }
            document.getElementById("popup").style.display = "block";
        }

        function submitBooking() {
            const name = document.getElementById("uname").value;
            const email = document.getElementById("uemail").value;
            if (!name || !email) { alert("Enter name and email!"); return; }
            document.getElementById("seatsField").value = selectedSeats.map(s => s.id).join(",");
            document.getElementById("nameField").value = name;
            document.getElementById("emailField").value = email;
            document.getElementById("bookingForm").submit();
        }

        function closePopup(){ document.getElementById("popup").style.display = "none"; }
    </script>
</head>

<body>

<div class="screen">SCREEN THIS WAY</div>

<c:set var="currentRow" value="" />
<c:forEach var="seat" items="${seats}" varStatus="seatStatus">
    <c:if test="${currentRow ne seat.rowLabel}">
        <c:if test="${currentRow ne ''}"></div></c:if>
        <div class="seat-row">
            <span class="row-label">${seat.rowLabel}</span>
        <c:set var="currentRow" value="${seat.rowLabel}" />
    </c:if>

    <!-- Frontend-only seat type coloring -->
    <c:set var="seatClass" value="available" />
    <c:choose>
        <c:when test="${seatStatus.index % 3 == 0}"><c:set var="seatClass" value="premium"/></c:when>
        <c:when test="${seatStatus.index % 3 == 1}"><c:set var="seatClass" value="gold"/></c:when>
        <c:otherwise><c:set var="seatClass" value="silver"/></c:otherwise>
    </c:choose>

    <c:choose>
        <c:when test="${fn:contains(bookedSeats, seat.seatId)}">
            <div id="seat-${seat.seatId}" class="seat booked">${seat.rowLabel}${seat.seatNumber}</div>
        </c:when>
        <c:otherwise>
            <c:set var="price" value="${seatPrices[seat.seatId]}" />
            <div id="seat-${seat.seatId}" class="seat ${seatClass}"
                 onclick="toggleSeat(${seat.seatId}, '${seat.rowLabel}${seat.seatNumber}', ${price})"
                 title="₹${price}">
                ${seat.rowLabel}${seat.seatNumber}
            </div>
        </c:otherwise>
    </c:choose>

    <!-- Insert aisle every 5 seats (frontend-only) -->
    <c:if test="${seat.seatNumber % 5 == 0}"><div class="aisle"></div></c:if>

    <c:if test="${seatStatus.last}"></div></c:if>
</c:forEach>

<h3 id="summary">No seats selected</h3>
<div class="proceed-container">
    <button onclick="confirmBooking()">Proceed</button>
</div>


<!-- Popup (unchanged) -->
<div id="popup">
    <h3>Enter Details</h3>
    <input type="text" id="uname" placeholder="Name" /><br/>
    <input type="email" id="uemail" placeholder="Email" /><br/>
    <button onclick="submitBooking()">Confirm</button>
    <button onclick="closePopup()">Cancel</button>
</div>

<!-- Hidden Form (unchanged) -->
<form id="bookingForm" method="post" action="ConfirmBooking">
    <input type="hidden" name="showId" value="${showId}">
    <input type="hidden" name="seats" id="seatsField">
    <input type="hidden" name="name" id="nameField">
    <input type="hidden" name="email" id="emailField">
</form>
</
