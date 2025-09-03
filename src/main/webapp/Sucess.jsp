<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Booking Receipt</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: #f2f2f2;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .ticket {
    margin-top: 40px;
    margin-bottom: 40px;
}
        
        .ticket {
            background: #fff;
            border: 2px dashed #333;
            border-radius: 12px;
            width: 450px;
            padding: 20px;
            position: relative;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
        }
        .ticket::before, .ticket::after {
            content: '';
            position: absolute;
            width: 20px;
            height: 20px;
            background: #f2f2f2;
            border-radius: 50%;
            top: 50%;
            transform: translateY(-50%);
        }
        .ticket::before { left: -11px; }
        .ticket::after { right: -11px; }
        h2 {
            text-align: center;
            margin-bottom: 15px;
            color: #e50914; /* Netflix red style */
        }
        .details {
            font-size: 15px;
            line-height: 1.6;
        }
        .details p {
            margin: 5px 0;
        }
        .highlight {
            font-weight: bold;
            color: #111;
        }
        .divider {
            border-top: 2px dashed #aaa;
            margin: 15px 0;
        }
        .qr {
            text-align: center;
            margin-top: 15px;
        }
        .qr img {
            width: 100px;
            height: 100px;
        }
        .footer {
            text-align: center;
            font-size: 12px;
            margin-top: 10px;
            color: red;
        }
        .note {
            text-align: center;
            font-size: 13px;
            margin-top: 12px;
            color: red;
            font-style: italic;
        }
    </style>
</head>
<body>
    <div class="ticket">
        <h2>🎟️ Booking Receipt</h2>
        <div class="details">
            <p><span class="highlight">Booking ID:</span> ${receipt.bookingId}</p>
            <p><span class="highlight">Customer:</span> ${receipt.customerName}</p>
            <p><span class="highlight">Movie:</span> ${receipt.movieTitle}</p>
            <p><span class="highlight">Theater:</span> ${receipt.theaterName}</p>
            <p><span class="highlight">Screen:</span> ${receipt.screenName}</p>
            <p><span class="highlight">Show Time:</span> ${receipt.showTime}</p>
            <p><span class="highlight">Seats:</span> ${receipt.seatNumbers}</p>
            <p><span class="highlight">Amount Paid:</span> ₹${receipt.amount}</p>
            <p><span class="highlight">Payment Status:</span> ${receipt.paymentStatus}</p>
        </div>
        
        <div class="divider"></div>
        
        <div class="qr">
            <img src="https://api.qrserver.com/v1/create-qr-code/?size=100x100&data=${receipt.bookingId}" alt="QR Code">
            <p>Scan for Entry</p>
        </div>

        <div class="footer">
            * Please arrive 15 minutes before showtime.<br>
            * This ticket is non-refundable.
        </div>

        <div class="note">
            📧 A confirmation email has been sent to your registered email address.
        </div>
    </div>
   
</body>
</html>
