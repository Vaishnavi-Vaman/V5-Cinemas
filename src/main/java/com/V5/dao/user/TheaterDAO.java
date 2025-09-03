package com.V5.dao.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.V5.dto.TheaterMovie;
import com.V5.util.ConnectionClass;
// theater list by location based

public class TheaterDAO {
	public static List<String> getLocationsByMovie(int movieId) {
	    List<String> list = new ArrayList<>();
	    String sql = "SELECT DISTINCT t.location FROM theaters t " +
	                 "JOIN theater_movies tm ON t.theater_id = tm.theater_id " +
	                 "WHERE tm.movie_id = ?";
	    
	    try (Connection con = ConnectionClass.getConnect();
	         PreparedStatement ps = con.prepareStatement(sql)) {
	        
	        ps.setInt(1, movieId);
	        
	        try (ResultSet rs = ps.executeQuery()) {
	            while (rs.next()) {
	                String location = rs.getString("location");
	                System.out.println("Location: " + location);
	                list.add(location);
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    
	    return list;
	}

	
// theater list with movieid
	public static List<TheaterMovie> getTheatersByMovieAndLocation(int movieId, String location) {
	    List<TheaterMovie> list = new ArrayList<>();
	    String sql = "SELECT tm.theater_movie_id, t.theater_id, t.name, tm.poster_url, tm.trailer_url " +
	                 "FROM theaters t " +
	                 "JOIN theater_movies tm ON t.theater_id = tm.theater_id " +
	                 "WHERE tm.movie_id=? AND t.location=?";
	    try (Connection con = ConnectionClass.getConnect();
	         PreparedStatement ps = con.prepareStatement(sql)) {
	        ps.setInt(1, movieId);
	        ps.setString(2, location);
	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            TheaterMovie tm = new TheaterMovie();
	            tm.setTheaterMovieId(rs.getInt("theater_movie_id"));
	            tm.setTheaterId(rs.getInt("theater_id"));
	            tm.setTheaterName(rs.getString("name"));
	            tm.setPosterUrl(rs.getString("poster_url"));
	            tm.setTrailerUrl(rs.getString("trailer_url"));
	            list.add(tm);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}


}
