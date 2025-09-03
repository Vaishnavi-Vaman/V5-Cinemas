package com.V5.dao.user;

import com.V5.dto.Seat;
import com.V5.util.ConnectionClass;

import java.sql.*;
import java.util.*;

public class SeatDAO {

    // Fetch all seats for a screen (ordered row A→Z, then seat number)
    public List<Seat> getSeatsByScreen(int screenId) throws Exception {
        List<Seat> list = new ArrayList<>();
        String sql = "SELECT * FROM seats WHERE screen_id = ? ORDER BY row_label, seat_number";
        try (Connection con = ConnectionClass.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, screenId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Seat seat = new Seat();
                    seat.setSeatId(rs.getInt("seat_id"));
                    seat.setScreenId(rs.getInt("screen_id"));
                    seat.setRowLabel(rs.getString("row_label"));
                    seat.setSeatNumber(rs.getInt("seat_number"));
                    seat.setSeatType(null); // seatType not used, set as null
                    list.add(seat);
                }
            }
        }
        return list;
    }

    // Get already booked seat IDs for a show
    public List<Integer> getBookedSeats(int showId) throws Exception {
        List<Integer> booked = new ArrayList<>();
        String sql = "SELECT bs.seat_id " +
                     "FROM booking_seats bs " +
                     "JOIN bookings b ON bs.booking_id = b.booking_id " +
                     "WHERE b.show_id = ?";
        try (Connection con = ConnectionClass.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, showId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    booked.add(rs.getInt("seat_id"));
                }
            }
        }
        return booked;
    }

    // Fetch base price from shows table
    public double getBasePriceForShow(int showId) throws Exception {
        String sql = "SELECT price FROM shows WHERE show_id = ?";
        try (Connection con = ConnectionClass.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, showId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("price");
                }
            }
        }
        return 0.0;
    }

    // Get screenId for a show (needed to render seats)
    public int getScreenIdForShow(int showId) throws Exception {
        String sql = "SELECT screen_id FROM shows WHERE show_id = ?";
        try (Connection con = ConnectionClass.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, showId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("screen_id");
                }
            }
        }
        return -1;
    }

    // Calculate price for a specific seat (row-based increment A=cheapest → Z=costliest)
    public double calculateSeatPrice(int showId, String rowLabel) throws Exception {
        double basePrice = getBasePriceForShow(showId);

        // Convert row label (A, B, C...) into index (A=0, B=1, ...)
        int rowIndex = rowLabel.toUpperCase().charAt(0) - 'A';

        // Example: Add 20 currency units per row step
        return basePrice + (rowIndex * 20);
    }
    public static double getSeatPriceForBooking(int showId, int seatId) throws Exception {
        String sql = "SELECT s.row_label, sh.price AS base_price " +
                     "FROM seats s " +
                     "JOIN shows sh ON sh.show_id = ? " +
                     "WHERE s.seat_id = ?";
        try (Connection con = ConnectionClass.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, showId);
            ps.setInt(2, seatId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String rowLabel = rs.getString("row_label");
                    double basePrice = rs.getDouble("base_price");

                    // Apply row-based increment
                    int rowIndex = rowLabel.charAt(0) - 'A'; 
                    return basePrice + (rowIndex * 20); // or whatever increment
                }
            }
        }
        throw new Exception("Seat not found for price calculation");
    }

}
