package com.V5.dao.user;


	import com.V5.dto.Seat;
	import com.V5.util.ConnectionClass;

	import java.sql.*;
	import java.util.*;

	public class UserSeatDAO {

	    // Fetch seats for a screen
	    public static List<Seat> getSeatsByScreen(int screenId) throws Exception {
	        List<Seat> list = new ArrayList<>();
	        String sql = "SELECT * FROM seats WHERE screen_id=? ORDER BY row_label, seat_number";
	        try (Connection con = ConnectionClass.getConnect();
	             PreparedStatement ps = con.prepareStatement(sql)) {
	            ps.setInt(1, screenId);
	            try (ResultSet rs = ps.executeQuery()) {
	                while (rs.next()) {
	                    Seat seat = new Seat(
	                            rs.getInt("seat_id"),
	                            rs.getString("row_label"),
	                            rs.getInt("seat_number"),
	                            rs.getInt("screen_id"),
	                            rs.getString("seat_type")
	                    );
	                    list.add(seat);
	                }
	            }
	        }
	        return list;
	    }

	    // Get base price for show
	    public static double getBasePriceForShow(int showId) throws Exception {
	        String sql = "SELECT base_price FROM shows WHERE show_id=?";
	        try (Connection con = ConnectionClass.getConnect();
	             PreparedStatement ps = con.prepareStatement(sql)) {
	            ps.setInt(1, showId);
	            try (ResultSet rs = ps.executeQuery()) {
	                if (rs.next()) {
	                    return rs.getDouble("base_price");
	                }
	            }
	        }
	        return 0;
	    }

	    // Get already booked seat IDs for a show
	    public static List<Integer> getBookedSeatsForShow(int showId) throws Exception {
	        List<Integer> list = new ArrayList<>();
	        String sql = "SELECT seat_id FROM bookings WHERE show_id=?";
	        try (Connection con = ConnectionClass.getConnect();
	             PreparedStatement ps = con.prepareStatement(sql)) {
	            ps.setInt(1, showId);
	            try (ResultSet rs = ps.executeQuery()) {
	                while (rs.next()) {
	                    list.add(rs.getInt("seat_id"));
	                }
	            }
	        }
	        return list;
	    }

	    // Save user details into users table
	    public static int saveUser(String name, String email) throws Exception {
	        String sql = "INSERT INTO users (name, email, role) VALUES (?, ?, 'customer')";
	        try (Connection con = ConnectionClass.getConnect();
	             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
	            ps.setString(1, name);
	            ps.setString(2, email);
	            ps.executeUpdate();
	            try (ResultSet rs = ps.getGeneratedKeys()) {
	                if (rs.next()) return rs.getInt(1); // return new user_id
	            }
	        }
	        return -1;
	    }

	    // Save booking (after user picks seats)
	    public static void saveBooking(int userId, int showId, List<Integer> seatIds) throws Exception {
	        String sql = "INSERT INTO bookings (user_id, show_id, seat_id, booking_time) VALUES (?, ?, ?, NOW())";
	        try (Connection con = ConnectionClass.getConnect();
	             PreparedStatement ps = con.prepareStatement(sql)) {
	            for (int seatId : seatIds) {
	                ps.setInt(1, userId);
	                ps.setInt(2, showId);
	                ps.setInt(3, seatId);
	                ps.addBatch();
	            }
	            ps.executeBatch();
	        }
	    }
	}



