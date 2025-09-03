package com.V5.dao.user;

import com.V5.dto.user.RatingRequest;
import com.V5.util.ConnectionClass;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class FeedbackDAO {

    // Find bookings whose show ended, payment ok, and not mailed yet
    public List<RatingRequest> getPendingFeedbackRequests() throws Exception {
        List<RatingRequest> list = new ArrayList<>();

        String sql = "SELECT "
                + "b.booking_id, "
                + "b.user_id, "
                + "b.guest_id, "
                + "tm.movie_id, "
                + "m.title AS movie_title, "
                + "TIMESTAMPADD(MINUTE, m.duration, s.show_time) AS show_end_time, "
                + "u.email AS user_email, "
                + "g.email AS guest_email "
                + "FROM bookings b "
                + "JOIN shows s ON b.show_id = s.show_id "
                + "JOIN theater_movies tm ON s.theater_movie_id = tm.theater_movie_id "
                + "JOIN movies m ON tm.movie_id = m.movie_id "
                + "JOIN payments p ON p.booking_id = b.booking_id "
                + "LEFT JOIN users u ON b.user_id = u.user_id "
                + "LEFT JOIN guests g ON b.guest_id = g.guest_id "
                + "WHERE p.status IN ('SUCCESS','PAID') "
                + "AND TIMESTAMPADD(MINUTE, m.duration, s.show_time) <= NOW() "
                + "AND b.feedback_sent = 0";

        try (Connection con = ConnectionClass.getConnect();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                RatingRequest r = new RatingRequest();
                r.setBookingId(rs.getInt("booking_id"));
                r.setUserId((Integer) rs.getObject("user_id"));
                r.setGuestId((Integer) rs.getObject("guest_id"));
                r.setMovieId(rs.getInt("movie_id"));
                r.setMovieTitle(rs.getString("movie_title"));

                Timestamp se = rs.getTimestamp("show_end_time");
                if (se != null) r.setShowEndTime(se.toLocalDateTime());

                String email = rs.getString("user_email");
                if (email == null || email.isEmpty()) email = rs.getString("guest_email");
                r.setEmail(email);

                list.add(r);
            }
        }
        return list;
    }

    public void markFeedbackSent(int bookingId) throws Exception {
        String sql = "UPDATE bookings SET feedback_sent = 1 WHERE booking_id = ?";
        try (Connection con = ConnectionClass.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ps.executeUpdate();
        }
    }
}
