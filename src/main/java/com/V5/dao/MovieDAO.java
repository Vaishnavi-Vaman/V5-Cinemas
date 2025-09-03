package com.V5.dao;

import com.V5.dto.Movie;
import com.V5.util.ConnectionClass;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MovieDAO {

    public static int addMovie(Movie movie) throws Exception {
        String sql = "INSERT INTO movies (title, language, duration, genre, release_date, poster_url, trailer_url) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = ConnectionClass.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, movie.getTitle());
            ps.setString(2, movie.getLanguage());
            ps.setInt(3, movie.getDuration());
            ps.setString(4, movie.getGenre());
            ps.setString(5, movie.getReleaseDate());
            ps.setString(6, movie.getPosterUrl());
            ps.setString(7, movie.getTrailerUrl());

            return ps.executeUpdate();
        }
    }

    public static List<Movie> getAllMovies() throws Exception {
        List<Movie> list = new ArrayList<>();
        String sql = "SELECT movie_id, title, language, duration, genre, release_date, poster_url, trailer_url FROM movies ORDER BY movie_id DESC";
        try (Connection con = ConnectionClass.getConnect();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Movie m = new Movie();
                m.setMovieId(rs.getInt("movie_id"));
                m.setTitle(rs.getString("title"));
                m.setLanguage(rs.getString("language"));
                m.setDuration(rs.getInt("duration"));
                m.setGenre(rs.getString("genre"));
                m.setReleaseDate(rs.getString("release_date"));
                m.setPosterUrl(rs.getString("poster_url"));
                m.setTrailerUrl(rs.getString("trailer_url"));
                list.add(m);
            }
        }
        return list;
    }

    public static int deleteMovie(int movieId) throws Exception {
        try (Connection con = ConnectionClass.getConnect()) {
            con.setAutoCommit(false); // Start transaction

            try {
                // 1. Delete payments for bookings of shows linked to this movie
                String sql1 = "DELETE FROM payments WHERE booking_id IN (" +
                              "SELECT booking_id FROM bookings WHERE show_id IN (" +
                              "SELECT show_id FROM shows WHERE theater_movie_id IN (" +
                              "SELECT theater_movie_id FROM theater_movies WHERE movie_id = ?)))";
                try (PreparedStatement ps = con.prepareStatement(sql1)) {
                    ps.setInt(1, movieId);
                    ps.executeUpdate();
                }

                // 2. Delete booking seats
                String sql2 = "DELETE FROM booking_seats WHERE booking_id IN (" +
                              "SELECT booking_id FROM bookings WHERE show_id IN (" +
                              "SELECT show_id FROM shows WHERE theater_movie_id IN (" +
                              "SELECT theater_movie_id FROM theater_movies WHERE movie_id = ?)))";
                try (PreparedStatement ps = con.prepareStatement(sql2)) {
                    ps.setInt(1, movieId);
                    ps.executeUpdate();
                }

                // 3. Delete bookings
                String sql3 = "DELETE FROM bookings WHERE show_id IN (" +
                              "SELECT show_id FROM shows WHERE theater_movie_id IN (" +
                              "SELECT theater_movie_id FROM theater_movies WHERE movie_id = ?))";
                try (PreparedStatement ps = con.prepareStatement(sql3)) {
                    ps.setInt(1, movieId);
                    ps.executeUpdate();
                }

                // 4. Delete show seats
                String sql4 = "DELETE FROM show_seats WHERE show_id IN (" +
                              "SELECT show_id FROM shows WHERE theater_movie_id IN (" +
                              "SELECT theater_movie_id FROM theater_movies WHERE movie_id = ?))";
                try (PreparedStatement ps = con.prepareStatement(sql4)) {
                    ps.setInt(1, movieId);
                    ps.executeUpdate();
                }

                // 5. Delete shows
                String sql5 = "DELETE FROM shows WHERE theater_movie_id IN (" +
                              "SELECT theater_movie_id FROM theater_movies WHERE movie_id = ?)";
                try (PreparedStatement ps = con.prepareStatement(sql5)) {
                    ps.setInt(1, movieId);
                    ps.executeUpdate();
                }

                // 6. Delete theater_movies
                String sql6 = "DELETE FROM theater_movies WHERE movie_id = ?";
                try (PreparedStatement ps = con.prepareStatement(sql6)) {
                    ps.setInt(1, movieId);
                    ps.executeUpdate();
                }

                // 7. Delete ratings (if you want to remove feedback too)
                String sql7 = "DELETE FROM ratings WHERE movie_id = ?";
                try (PreparedStatement ps = con.prepareStatement(sql7)) {
                    ps.setInt(1, movieId);
                    ps.executeUpdate();
                }

                // 8. Finally delete the movie
                String sql8 = "DELETE FROM movies WHERE movie_id = ?";
                try (PreparedStatement ps = con.prepareStatement(sql8)) {
                    ps.setInt(1, movieId);
                    int rows = ps.executeUpdate();
                    con.commit();
                    return rows;
                }
            } catch (Exception e) {
                con.rollback();
                throw e;
            }
        }
    }
}

