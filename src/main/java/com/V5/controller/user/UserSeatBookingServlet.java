package com.V5.controller.user;

import com.V5.dao.user.SeatDAO;
import com.V5.dto.Seat;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/UserSeats")
public class UserSeatBookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int showId = Integer.parseInt(request.getParameter("showId"));

        SeatDAO dao = new SeatDAO();

        try {
            // Get screen ID for this show
            int screenId = dao.getScreenIdForShow(showId);

            // Fetch seats for this screen
            List<Seat> seats = dao.getSeatsByScreen(screenId);

            // Fetch already booked seats
            List<Integer> bookedSeats = dao.getBookedSeats(showId);

            // Calculate price per seat (based on row)
            Map<Integer, Double> seatPrices = new HashMap<>();
            for (Seat seat : seats) {
                double seatPrice = dao.calculateSeatPrice(showId, seat.getRowLabel());
                seatPrices.put(seat.getSeatId(), seatPrice);
            }

            // Pass data to JSP
            request.setAttribute("seats", seats);
            request.setAttribute("bookedSeats", bookedSeats);
            request.setAttribute("showId", showId);
            request.setAttribute("seatPrices", seatPrices); // NEW: dynamic price map

            RequestDispatcher rd = request.getRequestDispatcher("user_seats.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error loading seats", e);
        }
    }
}
