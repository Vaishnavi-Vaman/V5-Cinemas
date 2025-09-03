package com.V5.dao.user;

import com.V5.dto.Movie;
import com.V5.dto.Show;
import com.V5.util.ConnectionClass;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.V5.dto.Movie;
import com.V5.util.ConnectionClass;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ShowDetailsDAO {

    // Fetch all movies (super admin added global movies)
    public List<Movie> getAllMovies() throws Exception {
        List<Movie> list = new ArrayList<>();
        String sql = "SELECT movie_id, title, language, genre, poster_url, trailer_url " +
                     "FROM movies ORDER BY movie_id DESC";
        try (Connection con = ConnectionClass.getConnect();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Movie m = new Movie();
                m.setMovieId(rs.getInt("movie_id"));
                m.setTitle(rs.getString("title"));
                m.setLanguage(rs.getString("language"));
                m.setGenre(rs.getString("genre"));
                m.setPosterUrl(rs.getString("poster_url"));
                m.setTrailerUrl(rs.getString("trailer_url"));
                list.add(m);
            }
        }
        return list;
    }

    // Fetch single movie by ID
    public static Movie getMovieById(int movieId) throws Exception {
        Movie movie = null;
        String sql = "SELECT movie_id, title, language, genre, poster_url, trailer_url " +
                     "FROM movies WHERE movie_id=?";
        try (Connection con = ConnectionClass.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, movieId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    movie = new Movie();
                    movie.setMovieId(rs.getInt("movie_id"));
                    movie.setTitle(rs.getString("title"));
                    movie.setLanguage(rs.getString("language"));
                    movie.setGenre(rs.getString("genre"));
                    movie.setPosterUrl(rs.getString("poster_url"));
                    movie.setTrailerUrl(rs.getString("trailer_url"));
                }
            }
        }
        return movie;
    }
    /**
     * Fetch theaters with shows in a given location.
     * Structure: Map<TheaterName, Map<Date, List<Show>>>
     */
    public static Map<String, Map<LocalDate, List<Show>>> getShowsByMovieAndLocation(int movieId, String location) {
        Map<String, Map<LocalDate, List<Show>>> data = new LinkedHashMap<>();

        String sql = "SELECT sh.show_id, sh.theater_movie_id, sh.screen_id, sh.show_time, sh.price, " +
                     "m.title AS movieTitle, sc.name AS screenName, th.name AS theaterName " +
                     "FROM shows sh " +
                     "JOIN theater_movies tm ON sh.theater_movie_id = tm.theater_movie_id " +
                     "JOIN movies m ON tm.movie_id = m.movie_id " +
                     "JOIN screens sc ON sh.screen_id = sc.screen_id " +
                     "JOIN theaters th ON tm.theater_id = th.theater_id " +
                     "WHERE tm.movie_id = ? AND th.location = ?  AND sh.show_time>now() " + 
                     "ORDER BY th.name, sh.show_time";

//        AND sh.show_time>
        try (Connection con = ConnectionClass.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, movieId);
            ps.setString(2, location);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Show sh = new Show();
                    sh.setShowId(rs.getInt("show_id"));
                    sh.setTheaterMovieId(rs.getInt("theater_movie_id"));
                    sh.setScreenId(rs.getInt("screen_id"));
                    Timestamp ts = rs.getTimestamp("show_time");
                    if (ts != null) sh.setShowTime(ts.toLocalDateTime());
                    sh.setPrice(rs.getDouble("price"));

                    String theaterName = rs.getString("theaterName");
                    LocalDate date = sh.getShowTime().toLocalDate();

                    // group shows by theater -> date -> list
                    data.putIfAbsent(theaterName, new LinkedHashMap<>());
                    data.get(theaterName).computeIfAbsent(date, k -> new ArrayList<>());
                    data.get(theaterName).get(date).add(sh);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return data;
    }
}
