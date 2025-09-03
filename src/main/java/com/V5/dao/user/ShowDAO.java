package com.V5.dao.user;

import com.V5.dto.Show;
import com.V5.util.ConnectionClass;

import java.sql.*;

public class ShowDAO {

    public Show getShowById(int showId) throws SQLException {
        Show show = null;
        String sql = "SELECT * FROM shows WHERE show_id = ?";

        try (Connection con = ConnectionClass.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, showId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    show = new Show();
                    show.setShowId(rs.getInt("show_id"));
                    show.setTheaterMovieId(rs.getInt("theater_movie_id"));
                    show.setScreenId(rs.getInt("screen_id"));
                    show.setShowTime(rs.getTimestamp("show_time").toLocalDateTime());
                    show.setPrice(rs.getDouble("price"));   // ✅ using column already in your DB
                }
            }
        }
        return show;
    }
    public static double getPriceByShowId(int showId) throws Exception {
        String sql = "SELECT price FROM shows WHERE show_id=?";
        try (Connection con = ConnectionClass.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, showId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("price");
                } else {
                    throw new Exception("Show not found with id " + showId);
                }
            }
        }
    }
}
