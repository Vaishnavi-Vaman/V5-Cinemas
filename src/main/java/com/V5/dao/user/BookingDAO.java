package com.V5.dao.user;

import com.V5.dto.BookingSummary;
import com.V5.util.ConnectionClass;

import java.sql.*;

public class BookingDAO {

    public static int createBooking(Integer userId, Integer guestId, int showId, String[] seatIds, double totalAmount) throws Exception {
        int bookingId = -1;
        String sql = "INSERT INTO bookings (user_id, guest_id, show_id, total_amount) VALUES (?, ?, ?, ?)";
        
        try (Connection con = ConnectionClass.getConnect()) {
            con.setAutoCommit(false);

            // 🔹 Insert into bookings
            try (PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                if (userId != null) ps.setInt(1, userId); else ps.setNull(1, Types.INTEGER);
                if (guestId != null) ps.setInt(2, guestId); else ps.setNull(2, Types.INTEGER);
                ps.setInt(3, showId);
                ps.setDouble(4, totalAmount);
                ps.executeUpdate();

                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) bookingId = rs.getInt(1);
                }
            }

            // 🔹 Insert booking_seats (with price per seat)
            String seatSql = "INSERT INTO booking_seats (booking_id, seat_id, price) VALUES (?, ?, ?)";
            try (PreparedStatement ps = con.prepareStatement(seatSql)) {
                for (String sid : seatIds) {
                    int seatId = Integer.parseInt(sid);
                    double seatPrice = SeatDAO.getSeatPriceForBooking(showId, seatId);

                    ps.setInt(1, bookingId);
                    ps.setInt(2, seatId);
                    ps.setDouble(3, seatPrice);
                    ps.addBatch();
                }
                ps.executeBatch();
            }

            // 🔹 Insert pending payment
            String paySql = "INSERT INTO payments (booking_id, amount, status) VALUES (?, ?, 'pending')";
            try (PreparedStatement ps = con.prepareStatement(paySql)) {
                ps.setInt(1, bookingId);
                ps.setDouble(2, totalAmount);
                ps.executeUpdate();
            }

            con.commit();
        }
        return bookingId;
    }

    public static void updatePaymentStatus(int bookingId, String status) throws Exception {
        String sql = "UPDATE payments SET status=?, payment_date=NOW() WHERE booking_id=?";
        try (Connection con = ConnectionClass.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, bookingId);
            ps.executeUpdate();
        }
    }
    public static BookingSummary getBookingReceipt(int bookingId) throws Exception {
        String sql =
            "SELECT b.booking_id, " +
            "       COALESCE(u.name, g.name) AS customer_name, " +
            "       u.email AS user_email, " +
            "       g.email AS guest_email, " +
            "       m.title AS movie_title, " +
            "       s.show_time, " +
            "       b.booking_date, " +
            "       sc.name AS screen_name, " +
            "       t.name AS theater_name, " +
            "       COALESCE(p.amount, 0) AS amount, " +
            "       COALESCE(p.status, 'pending') AS payment_status, " +
            "       GROUP_CONCAT(CONCAT(st.row_label, st.seat_number) " +
            "                    ORDER BY st.row_label, st.seat_number " +
            "                    SEPARATOR ', ') AS seat_numbers " +
            "FROM bookings b " +
            "LEFT JOIN users u ON b.user_id = u.user_id " +
            "LEFT JOIN guests g ON b.guest_id = g.guest_id " +
            "JOIN shows s ON b.show_id = s.show_id " +
            "JOIN screens sc ON s.screen_id = sc.screen_id " +
            "JOIN theater_movies tm ON s.theater_movie_id = tm.theater_movie_id " +
            "JOIN movies m ON tm.movie_id = m.movie_id " +
            "JOIN theaters t ON tm.theater_id = t.theater_id " +
            "LEFT JOIN ( " +
            "    SELECT p1.booking_id, p1.amount, p1.status " +
            "    FROM payments p1 " +
            "    WHERE p1.payment_date = ( " +
            "        SELECT MAX(p2.payment_date) " +
            "        FROM payments p2 " +
            "        WHERE p2.booking_id = p1.booking_id " +
            "    ) " +
            ") p ON b.booking_id = p.booking_id " +
            "LEFT JOIN booking_seats bs ON b.booking_id = bs.booking_id " +
            "LEFT JOIN seats st ON bs.seat_id = st.seat_id " +
            "WHERE b.booking_id = ? " +
            "GROUP BY b.booking_id, customer_name, user_email, guest_email, " +
            "         m.title, s.show_time, b.booking_date, sc.name, t.name, p.amount, p.status";

        try (Connection con = ConnectionClass.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, bookingId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    BookingSummary bs = new BookingSummary();
                    bs.setBookingId(rs.getInt("booking_id"));
                    bs.setCustomerName(rs.getString("customer_name"));
                    bs.setUserEmail(rs.getString("user_email"));     // 👈 new field
                    bs.setGuestEmail(rs.getString("guest_email"));   // 👈 new field
                    bs.setMovieTitle(rs.getString("movie_title"));
                    bs.setTheaterName(rs.getString("theater_name"));
                    bs.setScreenName(rs.getString("screen_name"));
                    bs.setBookingDate(rs.getTimestamp("booking_date"));
                    bs.setShowTime(rs.getTimestamp("show_time"));
                    bs.setAmount(rs.getDouble("amount"));
                    bs.setPaymentStatus(rs.getString("payment_status"));
                    bs.setSeatNumbers(rs.getString("seat_numbers"));

                    return bs;
                }
            }
        }
        return null;
    }

    

}
