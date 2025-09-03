package com.V5.dao.user;

	import com.V5.dto.user.Rating;
import com.V5.util.ConnectionClass;

	import java.sql.*;
	import java.util.ArrayList;
	import java.util.List;

	public class RatingDAO {

	    // Fetch all ratings for a movie
	    public List<Rating> getRatingsByMovieId(int movieId) throws Exception {
	        List<Rating> list = new ArrayList<>();
	        String sql = "SELECT * FROM ratings WHERE movie_id=? ORDER BY rating_date DESC";
	        try (Connection con = ConnectionClass.getConnect();
	             PreparedStatement ps = con.prepareStatement(sql)) {
	            ps.setInt(1, movieId);
	            try (ResultSet rs = ps.executeQuery()) {
	                while (rs.next()) {
	                    Rating r = new Rating();
	                    r.setRatingId(rs.getInt("rating_id"));
	                    r.setUserId(rs.getInt("user_id"));
	                    r.setMovieId(rs.getInt("movie_id"));
	                    r.setRating(rs.getInt("rating"));
	                    r.setFeedback(rs.getString("feedback"));
	                    Timestamp ts = rs.getTimestamp("rating_date");
	                    if (ts != null) {
	                        r.setRatingDate(ts.toLocalDateTime());
	                    }
	                    list.add(r);
	                }
	            }
	        }
	        return list;
	    }

	    // Optionally: insert a new rating
	    public void addRating(Rating rating) throws Exception {
	        String sql = "INSERT INTO ratings (user_id, movie_id, rating, feedback) VALUES (?, ?, ?, ?)";
	        try (Connection con = ConnectionClass.getConnect();
	             PreparedStatement ps = con.prepareStatement(sql)) {
	            ps.setInt(1, rating.getUserId());
	            ps.setInt(2, rating.getMovieId());
	            ps.setInt(3, rating.getRating());
	            ps.setString(4, rating.getFeedback());
	            ps.executeUpdate();
	        }
	    }
	 // Fetch average rating for a movie
	    public double getAverageRatingByMovieId(int movieId) throws Exception {
	        String sql = "SELECT AVG(rating) as avg_rating FROM ratings WHERE movie_id=?";
	        try (Connection con = ConnectionClass.getConnect();
	             PreparedStatement ps = con.prepareStatement(sql)) {
	            ps.setInt(1, movieId);
	            try (ResultSet rs = ps.executeQuery()) {
	                if (rs.next()) {
	                    return rs.getDouble("avg_rating");
	                }
	            }
	        }
	        return 0.0;
	    }
	 // Count total ratings for a movie
	    public int getRatingCountByMovieId(int movieId) throws Exception {
	        String sql = "SELECT COUNT(*) as count FROM ratings WHERE movie_id=?";
	        try (Connection con = ConnectionClass.getConnect();
	             PreparedStatement ps = con.prepareStatement(sql)) {
	            ps.setInt(1, movieId);
	            try (ResultSet rs = ps.executeQuery()) {
	                if (rs.next()) {
	                    return rs.getInt("count");
	                }
	            }
	        }
	        return 0;
	    }


	}



