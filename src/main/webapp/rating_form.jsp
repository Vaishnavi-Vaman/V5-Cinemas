<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <title>Rate Your Experience</title>
  <style>
    body{background:#0e0e0e;color:#fff;font-family:Arial;margin:0;text-align:center}
    .card{max-width:480px;margin:60px auto;background:#171717;padding:24px;border-radius:16px;box-shadow:0 10px 30px rgba(0,0,0,.4)}
    .stars span{font-size:32px;cursor:pointer;color:#555;user-select:none}
    .stars span.selected{color:#ffc107}
    textarea{width:100%;min-height:120px;border-radius:12px;padding:12px;border:1px solid #333;background:#101010;color:#eee}
    button{margin-top:16px;padding:12px 18px;border:none;border-radius:12px;background:#ffc107;color:#111;font-weight:700;cursor:pointer}
    .meta{color:#bbb;font-size:14px}
  </style>
  <script>
    function selectStar(n){
      document.getElementById('rating').value = n;
      for(let i=1;i<=5;i++){
        const el = document.getElementById('s'+i);
        if(el) el.classList.toggle('selected', i<=n);
      }
    }
    function validateForm(){
      const r = document.getElementById('rating').value;
      if(!r || parseInt(r) < 1){ alert('Please select a star rating.'); return false; }
      return true;
    }
  </script>
</head>
<body>
  <div class="card">
    <h2>Rate your experience</h2>
    <p class="meta">Booking: ${param.bookingId} · Movie: ${param.movieId}</p>

    <form action="submitRating" method="post" onsubmit="return validateForm()">
      <input type="hidden" name="movieId" value="${param.movieId}">
      <input type="hidden" name="bookingId" value="${param.bookingId}">
      <c:if test="${not empty param.userId}">
        <input type="hidden" name="userId" value="${param.userId}">
      </c:if>
      <c:if test="${not empty param.guestId}">
        <input type="hidden" name="guestId" value="${param.guestId}">
      </c:if>
      <input type="hidden" id="rating" name="rating" value="0">

      <div class="stars" aria-label="Star rating">
        <span id="s1" onclick="selectStar(1)">★</span>
        <span id="s2" onclick="selectStar(2)">★</span>
        <span id="s3" onclick="selectStar(3)">★</span>
        <span id="s4" onclick="selectStar(4)">★</span>
        <span id="s5" onclick="selectStar(5)">★</span>
      </div>

      <br>
      <textarea name="feedback" placeholder="Tell us more (optional)..."></textarea>
      <button type="submit">Submit feedback</button>
    </form>
  </div>
</body>
</html>
