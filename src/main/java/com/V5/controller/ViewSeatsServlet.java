package com.V5.controller;

import com.V5.dao.TheaterDAO;
import com.V5.dto.Seat;
import com.V5.util.ConnectionClass;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.*;

@WebServlet("/ViewSeats")
public class ViewSeatsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // required param
            String screenParam = req.getParameter("screenId");
            if (screenParam == null || screenParam.isEmpty()) {
                resp.sendRedirect("error.jsp?msg=screenId+is+required");
                return;
            }
            int screenId = Integer.parseInt(screenParam);

            // optional param
            String showParam = req.getParameter("showId");
            Integer showId = null;
            if (showParam != null && !showParam.isEmpty()) {
                try { showId = Integer.parseInt(showParam); } catch (NumberFormatException ignore) { showId = null; }
            }

            // seats for screen
            List<Seat> seats = TheaterDAO.getSeatsByScreen(screenId);

            // group by row (preserve order)
            Map<String, List<Seat>> groupedSeats = new LinkedHashMap<>();
            for (Seat s : seats) {
                groupedSeats.computeIfAbsent(s.getRowLabel(), k -> new ArrayList<>()).add(s);
            }

            // defaults (no show => no price / no booked)
            Map<String, Double> rowPriceMap = null;
            List<Integer> bookedSeats = Collections.emptyList();
            Set<Integer> bookedSeatSet = Collections.emptySet();

            String movieTitle = null;
            String screenName = getScreenName(screenId); // show even if no showId
            LocalDateTime showTime = null;
            Double basePrice = null;

            if (showId != null) {
                // base price (0 means not set)
                double bp = TheaterDAO.getBasePriceForShow(showId);
                if (bp > 0) {
                    basePrice = bp;

                    // booked seats
                    bookedSeats = TheaterDAO.getBookedSeatsForShow(showId);
                    bookedSeatSet = new HashSet<>(bookedSeats);

                    // price tiers: first 2 = base, next 5 = base*1.5, remaining = base*2
                    rowPriceMap = new LinkedHashMap<>();
                    List<String> rows = new ArrayList<>(groupedSeats.keySet());
                    for (int i = 0; i < rows.size(); i++) {
                        double price;
                        if (i < 2) price = basePrice;
                        else if (i < 7) price = basePrice * 1.5; // rows 2..6 => 5 rows
                        else price = basePrice * 2;
                        rowPriceMap.put(rows.get(i), price);
                    }
                }

                // header (movie title, screen name, show time)
                ShowHeader h = getShowHeader(showId);
                if (h != null) {
                    movieTitle = h.movieTitle;
                    showTime = h.showTime;
                    if (h.screenName != null && !h.screenName.isEmpty()) {
                        screenName = h.screenName; // prefer DB screen name
                    }
                }
            }

            // push to JSP
            req.setAttribute("groupedSeats", groupedSeats);
            req.setAttribute("bookedSeats", bookedSeats);
            req.setAttribute("bookedSeatSet", bookedSeatSet);
            req.setAttribute("rowPriceMap", rowPriceMap); // null => no pricing
            req.setAttribute("screenId", screenId);
            req.setAttribute("screenName", screenName);
            req.setAttribute("showId", showId);
            req.setAttribute("basePrice", basePrice);
            req.setAttribute("movieTitle", movieTitle);
            req.setAttribute("showTime", showTime);

            RequestDispatcher rd = req.getRequestDispatcher("admin_seats.jsp");
            rd.forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("error.jsp?msg=Unable+to+load+seats");
        }
    }

    private String getScreenName(int screenId) {
        String sql = "SELECT name FROM screens WHERE screen_id = ?";
        try (Connection con = ConnectionClass.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, screenId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getString("name");
            }
        } catch (Exception ignored) {}
        return "Screen " + screenId;
    }

    // ✅ fixed join: screen joins through sh.screen_id (not tm)
    private ShowHeader getShowHeader(int showId) {
        String sql =
            "SELECT m.title AS movie_title, sc.name AS screen_name, sh.show_time " +
            "FROM shows sh " +
            "JOIN theater_movies tm ON sh.theater_movie_id = tm.theater_movie_id " +
            "JOIN movies m ON tm.movie_id = m.movie_id " +
            "JOIN screens sc ON sh.screen_id = sc.screen_id " +
            "WHERE sh.show_id = ?";
        try (Connection con = ConnectionClass.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, showId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    ShowHeader h = new ShowHeader();
                    h.movieTitle = rs.getString("movie_title");
                    Timestamp ts = rs.getTimestamp("show_time");
                    h.showTime = ts != null ? ts.toLocalDateTime() : null;
                    h.screenName = rs.getString("screen_name");
                    return h;
                }
            }
        } catch (Exception ignored) {}
        return null;
    }

    private static class ShowHeader {
        String movieTitle;
        String screenName;
        LocalDateTime showTime;
    }
}
