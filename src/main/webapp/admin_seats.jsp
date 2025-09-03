<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Seat Layout</title>
    <style>
        body{background:#111;color:#fff;font-family:Arial,sans-serif;margin:0}
        .wrap{max-width:980px;margin:0 auto;padding:24px}
        .header{display:flex;align-items:center;justify-content:space-between;gap:16px;flex-wrap:wrap}
        .titles{display:flex;flex-direction:column;gap:4px}
        .movie{font-size:20px;font-weight:700}
        .meta{opacity:.85}
        .screen-bar{background:#cfcfcf;color:#000;margin:18px auto 10px;width:60%;text-align:center;padding:8px;border-radius:6px;font-weight:700;letter-spacing:.5px}
        .tiers{display:flex;gap:8px;flex-wrap:wrap;margin:8px 0 16px}
        .chip{border:1px solid #777;border-radius:999px;padding:6px 10px;font-size:12px}
        .grid{display:flex;flex-direction:column;gap:6px;align-items:center}
        .row{display:flex;gap:6px;align-items:center}
        .row-label{width:26px;opacity:.8}
        .seat{width:30px;height:30px;border-radius:4px;display:flex;align-items:center;justify-content:center;font-size:12px;font-weight:700}
        .available{background:#4CAF50;cursor:pointer}
        .booked{background:#d32f2f;cursor:not-allowed}
        .price-header{width:100%;max-width:760px;margin:14px auto 4px;display:flex;align-items:center;gap:10px}
        .price-line{flex:1;height:1px;background:#333}
        .price-tag{font-weight:700}
        .legend{display:flex;gap:18px;justify-content:center;margin-top:18px;font-size:13px;opacity:.9}
        .dot{width:16px;height:16px;border-radius:4px;display:inline-block;margin-right:6px;vertical-align:middle}
    </style>
</head>
<body>
<div class="wrap">

    <!-- top header (only if we actually have show metadata) -->
    <div class="header">
        <div class="titles">
            <div class="movie">
                <c:out value="${empty movieTitle ? 'Seat Layout' : movieTitle}"/>
            </div>
            <div class="meta">
                <c:if test="${not empty screenName}">
                    Screen: <strong><c:out value="${screenName}"/></strong>
                </c:if>
                <c:if test="${not empty showTime}">
                    &nbsp;·&nbsp;
                    <fmt:formatDate value="${showTime}" pattern="EEE, dd MMM yyyy HH:mm" />
                </c:if>
            </div>
        </div>

        <!-- Tier chips when basePrice exists -->
        <c:if test="${not empty basePrice && not empty rowPriceMap}">
            <div class="tiers">
                <span class="chip">STANDARD · ₹<fmt:formatNumber value="${basePrice}" minFractionDigits="0" maxFractionDigits="2"/></span>
                <span class="chip">GOLD · ₹<fmt:formatNumber value="${basePrice * 1.5}" minFractionDigits="0" maxFractionDigits="2"/></span>
                <span class="chip">PLATINUM · ₹<fmt:formatNumber value="${basePrice * 2}" minFractionDigits="0" maxFractionDigits="2"/></span>
            </div>
        </c:if>
    </div>

    <!-- screen bar always -->
    <div class="screen-bar">SCREEN</div>

    <!-- seat grid -->
    <div class="grid">
        <c:set var="lastPrice" value="-1" />
        <c:forEach var="entry" items="${groupedSeats}">
            <c:set var="rowLabel" value="${entry.key}" />
            <c:set var="rowSeats" value="${entry.value}" />
            <c:set var="price" value="${empty rowPriceMap ? null : rowPriceMap[rowLabel]}" />

            <!-- price header appears only when pricing exists and the band changes -->
            <c:if test="${not empty price && price != lastPrice}">
                <div class="price-header">
                    <div class="price-line"></div>
                    <div class="price-tag">
                        <c:choose>
                            <c:when test="${price == basePrice}">STANDARD</c:when>
                            <c:when test="${price == basePrice * 1.5}">GOLD</c:when>
                            <c:otherwise>PLATINUM</c:otherwise>
                        </c:choose>
                        &nbsp;· ₹<fmt:formatNumber value="${price}" minFractionDigits="0" maxFractionDigits="2"/>
                    </div>
                    <div class="price-line"></div>
                </div>
                <c:set var="lastPrice" value="${price}" />
            </c:if>

            <div class="row">
                <div class="row-label">${rowLabel}</div>
                <c:forEach var="s" items="${rowSeats}">
                    <c:set var="booked" value="${bookedSeatSet != null && bookedSeatSet.contains(s.seatId)}" />
                    <div class="seat ${booked ? 'booked' : 'available'}"
                         title="${rowLabel}${s.seatNumber}">
                        ${s.seatNumber}
                    </div>
                </c:forEach>
            </div>
        </c:forEach>
    </div>

    <!-- legend -->
    <div class="legend">
        <span><span class="dot" style="background:#4CAF50"></span>Available</span>
        <span><span class="dot" style="background:#d32f2f"></span>Booked</span>
    </div>
</div>
</body>
</html>
