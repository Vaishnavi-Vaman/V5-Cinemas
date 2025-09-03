
	package com.V5.controller.user;

	
	import java.io.IOException;

import com.V5.dao.user.BookingDAO;
import com.V5.dao.user.GuestDAO;
import com.V5.dao.user.ShowDAO;
import com.V5.dto.User;
import com.V5.dto.user.Guest;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ConfirmBooking")

	public class BookingServlet extends HttpServlet {
	    @Override
	   
	    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	        try {
	            HttpSession session = req.getSession();

	            // Get parameters from form
	            String seatsParam = req.getParameter("seats");
	            String[] seatIds = (seatsParam != null && !seatsParam.isEmpty()) ? seatsParam.split(",") : new String[0];
	            int showId = Integer.parseInt(req.getParameter("showId"));

	            // 🔹 Calculate total amount dynamically
	            double totalAmount = 0.0;
	            for (String sid : seatIds) {
	                int seatId = Integer.parseInt(sid);
	                double seatPrice = com.V5.dao.user.SeatDAO.getSeatPriceForBooking(showId, seatId);
	                totalAmount += seatPrice;
	            }

	            User loggedUser = (User) session.getAttribute("user");
	            Integer userId = null, guestId = null;

	            if (loggedUser != null) {
	                userId = loggedUser.getUserId();
	            } else {
	                String name = req.getParameter("name");
	                String email = req.getParameter("email");
	                Guest guest = new Guest(name, email);
	                guestId = GuestDAO.insertGuest(guest);
	            }

	            // Call DAO
	            int bookingId = BookingDAO.createBooking(userId, guestId, showId, seatIds, totalAmount);

	            // Redirect to payment
	            resp.sendRedirect("Payment.jsp?bookingId=" + bookingId + "&amount=" + totalAmount);

	        } catch (Exception e) {
	            throw new ServletException("Booking failed", e);
	        }
	    }}