<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="navbar.jsp" %>
<html>
<head>
    <title>Payment Page</title>
    <style>
        body {
            background: radial-gradient(circle at top, #0d0d0d, #1a1a1a);
            color: #fff;
            font-family: 'Roboto', sans-serif;
            text-align: center;
            margin: 0;
            padding: 0;
        }

        h2 {
            font-size: 2.5em;
            color: #ff3d00;
            margin-top: 40px;
            text-shadow: 0 0 10px #ff3d00;
        }

        .payment-method {
            margin: 20px 0;
        }

        .payment-method button {
            background: #ff3d00;
            border: none;
            color: #fff;
            padding: 10px 25px;
            margin: 10px;
            font-size: 1em;
            cursor: pointer;
            border-radius: 10px;
            transition: 0.3s;
        }

        .payment-method button:hover {
            background: #ff5722;
        }

        .panel {
            width: 420px;
            margin: 20px auto;
            border-radius: 15px;
            box-shadow: 0 0 20px #ff3d00;
            overflow: hidden;
            background: #111;
            transition: max-height 0.7s ease;
            max-height: 0;
        }

        .panel.active {
            max-height: 500px;
        }

        .card-form, .upi-panel {
            padding: 20px;
            box-sizing: border-box;
        }

        .card-form label {
            display: block;
            margin-top: 10px;
            text-align: left;
        }

        .card-form input {
            width: 90%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 8px;
            border: none;
            font-size: 1em;
        }

        .submit-btn {
            background: #00e676;
            color: #000;
            border: none;
            padding: 10px 25px;
            border-radius: 10px;
            font-size: 1em;
            cursor: pointer;
            margin-top: 15px;
            transition: 0.3s;
        }

        .submit-btn:hover {
            background: #00c853;
        }

        .upi-panel img {
            width: 180px;
            height: 180px;
            margin-top: 20px;
        }
    </style>
</head>
<body>

<h2>Payment Page</h2>
<p>Booking ID: ${param.bookingId}</p>
<p>Amount: ₹${param.amount}</p>

<div class="payment-method">
    <button onclick="showPanel('card')">Card Payment</button>
    <button onclick="showPanel('upi')">UPI Payment</button>
</div>

<!-- Card Payment Panel -->
<div class="panel" id="cardPanel">
    <form class="card-form" action="PaymentServlet" method="post" onsubmit="return validateCardForm()">
        <input type="hidden" name="bookingId" value="${param.bookingId}">
        <input type="hidden" name="amount" value="${param.amount}">
        <input type="hidden" name="action" value="success">

        <label>Card Number</label>
        <input type="text" id="cardNumber" name="cardNumber" placeholder="1234 5678 9012 3456" maxlength="16">

        <label>Card Holder</label>
        <input type="text" id="cardHolder" name="cardHolder" placeholder="John Doe">

        <label>Expiry (MM/YY)</label>
        <input type="text" id="expiry" name="expiry" placeholder="MM/YY" maxlength="5">

        <label>CVV</label>
        <input type="password" id="cvv" name="cvv" placeholder="123" maxlength="3">

        <button type="submit" class="submit-btn">Confirm Payment</button>
    </form>
</div>

<!-- UPI Payment Panel -->
<div class="panel" id="upiPanel">
    <div class="upi-panel">
        <p>Scan QR with UPI app</p>
        
        <!--  
        <img src="https://api.qrserver.com/v1/create-qr-code/
        ?size=150x150&data=upi://pay?
        pa=dummy@upi&pn=CinemaApp&am=${param.amount}" alt="Dummy UPI QR">
        -->
        
        <img src="https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=upi://pay?pa=7996395887-2@ybl&pn=CinemaApp&am=${param.amount}&cu=INR" 
     alt="UPI QR Code">
        
        <form action="PaymentServlet" method="post">
            <input type="hidden" name="bookingId" value="${param.bookingId}">
            <input type="hidden" name="amount" value="${param.amount}">
            <input type="hidden" name="action" value="success">
            <button type="submit" class="submit-btn">Payment Done</button>
        </form>
    </div>
</div>

<script>
    function showPanel(option) {
        const cardPanel = document.getElementById('cardPanel');
        const upiPanel = document.getElementById('upiPanel');

        if(option === 'card') {
            cardPanel.classList.add('active');
            upiPanel.classList.remove('active');
        } else {
            upiPanel.classList.add('active');
            cardPanel.classList.remove('active');
        }
    }

    function validateCardForm() {
        const cardNumber = document.getElementById('cardNumber').value.replace(/\s+/g, '');
        const expiry = document.getElementById('expiry').value;
        const cvv = document.getElementById('cvv').value;
        const cardHolder = document.getElementById('cardHolder').value;

        if (!/^\d{16}$/.test(cardNumber)) {
            alert("Enter a valid 16-digit card number.");
            return false;
        }

        if (!/^(0[1-9]|1[0-2])\/\d{2}$/.test(expiry)) {
            alert("Enter a valid expiry date in MM/YY format.");
            return false;
        }

        if (!/^\d{3}$/.test(cvv)) {
            alert("Enter a valid 3-digit CVV.");
            return false;
        }

        if (cardHolder.trim() === "") {
            alert("Enter card holder name.");
            return false;
        }

        alert("Dummy Card Payment Successful!");
        return true;
    }
</script>
<%@ include file="footer.jsp" %>

</body>
</html>
