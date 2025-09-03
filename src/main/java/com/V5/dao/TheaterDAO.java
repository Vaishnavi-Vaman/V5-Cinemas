package com.V5.dao;
import com.V5.util.ConnectionClass;

import com.V5.dto.BookingSummary;
import com.V5.dto.Movie;
import com.V5.dto.Screen;
import com.V5.dto.Seat;
import com.V5.dto.Show;
import com.V5.dto.Theater;
import com.V5.dto.TheaterMovie;
 // your existing util
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class TheaterDAO {

    // --------------------------
    // THEATERS
    // --------------------------
    public static int addTheater(Theater t) throws Exception {
        String sql = "INSERT INTO theaters (name, location, admin_id) VALUES (?, ?, ?)";
        try (Connection con = ConnectionClass.getConnect();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, t.getName());
            ps.setString(2, t.getLocation());
            ps.setInt(3, t.getAdminId());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                return rs.next() ? rs.getInt(1) : -1;
            }
        }
    }

    public static void updateTheater(Theater t) throws Exception {
        String sql = "UPDATE theaters SET name = ?, location = ? WHERE theater_id = ? AND admin_id = ?";
        try (Connection con = ConnectionClass.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, t.getName());
            ps.setString(2, t.getLocation());
            ps.setInt(3, t.getTheaterId());
            ps.setInt(4, t.getAdminId());
            ps.executeUpdate();
        }
    }

    public static void deleteTheater(int theaterId) throws Exception {
        try (Connection con = ConnectionClass.getConnect()){
            con.setAutoCommit(false); // transaction start

            // 1️⃣ Delete seats linked to screens in this theater
            try (PreparedStatement ps = con.prepareStatement(
                "DELETE FROM seats WHERE screen_id IN (SELECT screen_id FROM screens WHERE theater_id = ?)")) {
                ps.setInt(1, theaterId);
                ps.executeUpdate();
            }

            // 2️⃣ Delete show_seats linked to shows for this theater
            try (PreparedStatement ps = con.prepareStatement(
                "DELETE FROM show_seats WHERE show_id IN (SELECT show_id FROM shows WHERE screen_id IN (SELECT screen_id FROM screens WHERE theater_id = ?))")) {
                ps.setInt(1, theaterId);
                ps.executeUpdate();
            }

            // 3️⃣ Delete shows
            try (PreparedStatement ps = con.prepareStatement(
                "DELETE FROM shows WHERE screen_id IN (SELECT screen_id FROM screens WHERE theater_id = ?)")) {
                ps.setInt(1, theaterId);
                ps.executeUpdate();
            }

            // 4️⃣ Delete theater_movies entries
            try (PreparedStatement ps = con.prepareStatement(
                "DELETE FROM theater_movies WHERE theater_id = ?")) {
                ps.setInt(1, theaterId);
                ps.executeUpdate();
            }

            // 5️⃣ Delete screens
            try (PreparedStatement ps = con.prepareStatement(
                "DELETE FROM screens WHERE theater_id = ?")) {
                ps.setInt(1, theaterId);
                ps.executeUpdate();
            }

            // 6️⃣ Delete theater
            try (PreparedStatement ps = con.prepareStatement(
                "DELETE FROM theaters WHERE theater_id = ?")) {
                ps.setInt(1, theaterId);
                ps.executeUpdate();
            }

            con.commit(); // transaction commit
        }
    }



    public static List<Theater> listByAdmin(int adminId) throws Exception {
        List<Theater> list = new ArrayList<>();
        String sql = "SELECT theater_id, name, location, admin_id FROM theaters WHERE admin_id = ?";
        try (Connection con = ConnectionClass.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, adminId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Theater t = new Theater();
                    t.setTheaterId(rs.getInt("theater_id"));
                    t.setName(rs.getString("name"));
                    t.setLocation(rs.getString("location"));
                    t.setAdminId(rs.getInt("admin_id"));
                    list.add(t);
                }
            }
        }
        return list;
    }

    public static int getTheaterIdByAdmin(int adminId) throws Exception {
        // If admin has multiple theaters, you may want to return a list instead.
        String sql = "SELECT theater_id FROM theaters WHERE admin_id = LIMIT 1";
        // safer approach: return first theater found
        sql = "SELECT theater_id FROM theaters WHERE admin_id = ? LIMIT 1";
        try (Connection con = ConnectionClass.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, adminId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getInt("theater_id") : -1;
            }
        }
    }

    // --------------------------
    // SCREENS
    // --------------------------
    public static int addScreen(Screen s) throws Exception {
        String sql = "INSERT INTO screens (name, theater_id) VALUES (?, ?)";
        try (Connection con = ConnectionClass.getConnect();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, s.getName());
            ps.setInt(2, s.getTheaterId());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                return rs.next() ? rs.getInt(1) : -1;
            }
        }
    }

    public static void updateScreen(Screen s) throws Exception {
        String sql = "UPDATE screens SET name = ? WHERE screen_id = ? AND theater_id = ?";
        try (Connection con = ConnectionClass.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, s.getName());
            ps.setInt(2, s.getScreenId());
            ps.setInt(3, s.getTheaterId());
            ps.executeUpdate();
        }
    }

    public static void deleteScreen(int screenId) throws Exception {
        try (Connection con = ConnectionClass.getConnect()) {
            // 1. Delete mapping with shows
            try (PreparedStatement ps1 = con.prepareStatement("DELETE FROM shows WHERE screen_id = ?")) {
                ps1.setInt(1, screenId);
                ps1.executeUpdate();
            }

            // 2. Delete related seats if you track them by screen
            try (PreparedStatement ps2 = con.prepareStatement("DELETE FROM seats WHERE screen_id = ?")) {
                ps2.setInt(1, screenId);
                ps2.executeUpdate();
            }

            // 3. Finally delete screen
            try (PreparedStatement ps3 = con.prepareStatement("DELETE FROM screens WHERE screen_id = ?")) {
                ps3.setInt(1, screenId);
                ps3.executeUpdate();
            }
        }
    }

    public static List<Screen> listScreensByTheater(int theaterId) throws Exception {
        List<Screen> list = new ArrayList<>();
        String sql = "SELECT screen_id, name, theater_id FROM screens WHERE theater_id = ?";
        try (Connection con = ConnectionClass.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, theaterId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Screen sc = new Screen();
                    sc.setScreenId(rs.getInt("screen_id"));
                    sc.setName(rs.getString("name"));
                    sc.setTheaterId(rs.getInt("theater_id"));
                    list.add(sc);
                }
            }
        }
        return list;
    }

    public static List<Screen> listScreensByAdmin(int adminId) throws Exception {
        List<Screen> list = new ArrayList<>();
        String sql = "SELECT s.screen_id, s.name, s.theater_id FROM screens s JOIN theaters t ON s.theater_id = t.theater_id WHERE t.admin_id = ?";
        try (Connection con = ConnectionClass.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, adminId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Screen sc = new Screen();
                    sc.setScreenId(rs.getInt("screen_id"));
                    sc.setName(rs.getString("name"));
                    sc.setTheaterId(rs.getInt("theater_id"));
                    list.add(sc);
                }
            }
        }
        return list;
    }

    // --------------------------
    // SEATS (auto-generate & query)
    // --------------------------
    public static void generateSeats(int screenId, int totalSeats) throws Exception {
        if (totalSeats <= 0) return;

        final int seatsPerRow = 10;
        int rowCount = (int) Math.ceil(totalSeats / (double) seatsPerRow);

        String sql = "INSERT INTO seats (screen_id, seat_type,row_label, seat_number) VALUES (?, ?, ?, ?)";
        try (Connection con = ConnectionClass.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {

            for (int row = 0; row < rowCount; row++) {
                char rowLetter = (char) ('A' + row);
                for (int num = 1; num <= seatsPerRow && (row * seatsPerRow + num) <= totalSeats; num++) {
                	 ps.setInt(1, screenId);                  // ✅ screen_id
                     ps.setString(2, "Regular");              // ✅ seat_type
                     ps.setString(3, String.valueOf(rowLetter)); // ✅ row_label
                     ps.setInt(4, num);                       // ✅ seat_number
                     ps.addBatch();
                }
            }
            ps.executeBatch();
        }
    }

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

    public static List<Integer> getBookedSeatsForShow(int showId) throws Exception {
        List<Integer> booked = new ArrayList<>();
        String sql = "SELECT seat_id FROM show_seats WHERE show_id=? AND is_booked=1";
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


    // --------------------------
    // GLOBAL MOVIES (super admin) - listing helper
    // --------------------------
    public static List<Movie> listAllGlobalMovies() throws Exception {
        List<Movie> list = new ArrayList<>();
        String sql = "SELECT movie_id, title, language, duration, genre, release_date,poster_url,trailer_url FROM movies ORDER BY title";
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

    // --------------------------
    // THEATER_MOVIES (publish / unlink)
    // --------------------------
    public static void linkMovieToTheater(int theaterId, int movieId, String posterUrl, String trailerUrl) throws Exception {
        String sql = "INSERT INTO theater_movies (theater_id, movie_id, poster_url, trailer_url) VALUES (?, ?, ?, ?)";
        try (Connection con = ConnectionClass.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, theaterId);
            ps.setInt(2, movieId);
            ps.setString(3, posterUrl);
            ps.setString(4, trailerUrl);
            ps.executeUpdate();
        }
    }

    public static void unlinkMovieFromTheater(int theaterMovieId, int adminId) throws Exception {
        try (Connection con = ConnectionClass.getConnect()) {
            con.setAutoCommit(false); // Transaction

            try {
                // 1. Delete payments
                String sql1 = "DELETE p FROM payments p " +
                              "JOIN bookings b ON p.booking_id = b.booking_id " +
                              "JOIN shows s ON b.show_id = s.show_id " +
                              "WHERE s.theater_movie_id = ?";
                try (PreparedStatement ps = con.prepareStatement(sql1)) {
                    ps.setInt(1, theaterMovieId);
                    ps.executeUpdate();
                }

                // 2. Delete booking_seats
                String sql2 = "DELETE bs FROM booking_seats bs " +
                              "JOIN bookings b ON bs.booking_id = b.booking_id " +
                              "JOIN shows s ON b.show_id = s.show_id " +
                              "WHERE s.theater_movie_id = ?";
                try (PreparedStatement ps = con.prepareStatement(sql2)) {
                    ps.setInt(1, theaterMovieId);
                    ps.executeUpdate();
                }

                // 3. Delete bookings
                String sql3 = "DELETE b FROM bookings b " +
                              "JOIN shows s ON b.show_id = s.show_id " +
                              "WHERE s.theater_movie_id = ?";
                try (PreparedStatement ps = con.prepareStatement(sql3)) {
                    ps.setInt(1, theaterMovieId);
                    ps.executeUpdate();
                }

                // 4. Delete show_seats
                String sql4 = "DELETE ss FROM show_seats ss " +
                              "JOIN shows s ON ss.show_id = s.show_id " +
                              "WHERE s.theater_movie_id = ?";
                try (PreparedStatement ps = con.prepareStatement(sql4)) {
                    ps.setInt(1, theaterMovieId);
                    ps.executeUpdate();
                }

                // 5. Delete shows
                String sql5 = "DELETE FROM shows WHERE theater_movie_id = ?";
                try (PreparedStatement ps = con.prepareStatement(sql5)) {
                    ps.setInt(1, theaterMovieId);
                    ps.executeUpdate();
                }

                // 6. Delete from theater_movies (only if admin owns the theater)
                String sql6 = "DELETE tm FROM theater_movies tm " +
                              "JOIN theaters t ON tm.theater_id = t.theater_id " +
                              "WHERE tm.theater_movie_id = ? AND t.admin_id = ?";
                try (PreparedStatement ps = con.prepareStatement(sql6)) {
                    ps.setInt(1, theaterMovieId);
                    ps.setInt(2, adminId);
                    ps.executeUpdate();
                }

                con.commit();
            } catch (Exception e) {
                con.rollback();
                throw e;
            } finally {
                con.setAutoCommit(true);
            }
        }
    }


    public static List<TheaterMovie> listTheaterMoviesByAdmin(int adminId) throws Exception {
        List<TheaterMovie> list = new ArrayList<>();
        String sql = "SELECT tm.theater_movie_id, tm.theater_id, tm.movie_id, tm.poster_url, tm.trailer_url, m.title AS movie_title, t.name AS theater_name " +
                     "FROM theater_movies tm " +
                     "JOIN movies m ON tm.movie_id = m.movie_id " +
                     "JOIN theaters t ON tm.theater_id = t.theater_id " +
                     "WHERE t.admin_id = ?";
        try (Connection con = ConnectionClass.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, adminId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    TheaterMovie tm = new TheaterMovie();
                    tm.setTheaterMovieId(rs.getInt("theater_movie_id"));
                    tm.setTheaterId(rs.getInt("theater_id"));
                    tm.setMovieId(rs.getInt("movie_id"));
                    tm.setPosterUrl(rs.getString("poster_url"));
                    tm.setTrailerUrl(rs.getString("trailer_url"));
                    // set additional display fields if DTO supports them (not required)
                    list.add(tm);
                }
            }
        }
        return list;
    }

    // --------------------------
    // SHOWS (scheduling)
    // --------------------------
    public static int addShow(Show s) throws Exception {
        String sql = "INSERT INTO shows (theater_movie_id, screen_id, show_time, price) VALUES (?, ?, ?, ?)";
        try (Connection con = ConnectionClass.getConnect();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, s.getTheaterMovieId());
            ps.setInt(2, s.getScreenId());
            ps.setTimestamp(3, Timestamp.valueOf(s.getShowTime()));
            ps.setDouble(4, s.getPrice());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                return rs.next() ? rs.getInt(1) : -1;
            }
        }
    }

    public static void updateShow(Show s) throws Exception {
        String sql = "UPDATE shows SET show_time = ?, price = ? WHERE show_id = ?";
        try (Connection con = ConnectionClass.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setTimestamp(1, Timestamp.valueOf(s.getShowTime()));
            ps.setDouble(2, s.getPrice());
            ps.setInt(3, s.getShowId());
            ps.executeUpdate();
        }
    }

    public static void deleteShow(int showId) throws Exception {
        try (Connection con = ConnectionClass.getConnect()) {
            
            // 1. Delete payments
            String deletePayments = "DELETE FROM payments WHERE booking_id IN (SELECT booking_id FROM bookings WHERE show_id = ?)";
            try (PreparedStatement ps = con.prepareStatement(deletePayments)) {
                ps.setInt(1, showId);
                ps.executeUpdate();
            }

            // 2. Delete booking_seats
            String deleteBookingSeats = "DELETE FROM booking_seats WHERE booking_id IN (SELECT booking_id FROM bookings WHERE show_id = ?)";
            try (PreparedStatement ps = con.prepareStatement(deleteBookingSeats)) {
                ps.setInt(1, showId);
                ps.executeUpdate();
            }

            // 3. Delete bookings
            String deleteBookings = "DELETE FROM bookings WHERE show_id = ?";
            try (PreparedStatement ps = con.prepareStatement(deleteBookings)) {
                ps.setInt(1, showId);
                ps.executeUpdate();
            }

            // 4. Delete the show itself
            String deleteShow = "DELETE FROM shows WHERE show_id = ?";
            try (PreparedStatement ps = con.prepareStatement(deleteShow)) {
                ps.setInt(1, showId);
                ps.executeUpdate();
            }
        }
    }


    public static List<Show> listShowsByAdmin(int adminId) throws Exception {
        List<Show> list = new ArrayList<>();
        String sql = "SELECT sh.show_id, sh.theater_movie_id, sh.screen_id, sh.show_time, sh.price, m.title AS movieTitle, sc.name AS screenName " +
                     "FROM shows sh " +
                     "JOIN theater_movies tm ON sh.theater_movie_id = tm.theater_movie_id " +
                     "JOIN movies m ON tm.movie_id = m.movie_id " +
                     "JOIN screens sc ON sh.screen_id = sc.screen_id " +
                     "JOIN theaters th ON tm.theater_id = th.theater_id " +
                     "WHERE th.admin_id = ? ORDER BY sh.show_time DESC";
        try (Connection con = ConnectionClass.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, adminId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Show sh = new Show();
                    sh.setShowId(rs.getInt("show_id"));
                    sh.setTheaterMovieId(rs.getInt("theater_movie_id"));
                    sh.setScreenId(rs.getInt("screen_id"));
                    Timestamp ts = rs.getTimestamp("show_time");
                    if (ts != null) sh.setShowTime(ts.toLocalDateTime());
                    sh.setPrice(rs.getDouble("price"));
                    // optionally set display fields if DTO supports them
                    list.add(sh);
                }
            }
        }
        return list;
    }

    // --------------------------
    // BOOKINGS (ADMIN VIEW)
    // --------------------------
    public static List<BookingSummary> getBookingsForAdmin(int adminId) throws Exception {
        List<BookingSummary> bookings = new ArrayList<>();

        String sql =
            "SELECT b.booking_id, " +
            "       COALESCE(u.name, g.name) AS customer_name, " +
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
            "WHERE t.admin_id = ? " +
            "GROUP BY b.booking_id, customer_name, m.title, s.show_time, b.booking_date, sc.name, t.name, p.amount, p.status " +
            "ORDER BY b.booking_date DESC";

        try (Connection con = ConnectionClass.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, adminId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    BookingSummary bs = new BookingSummary();
                    bs.setBookingId(rs.getInt("booking_id"));
                    bs.setCustomerName(rs.getString("customer_name"));
                    bs.setMovieTitle(rs.getString("movie_title"));
                    bs.setTheaterName(rs.getString("theater_name"));
                    bs.setScreenName(rs.getString("screen_name"));
                    bs.setBookingDate(rs.getTimestamp("booking_date"));
                    bs.setShowTime(rs.getTimestamp("show_time"));
                    bs.setAmount(rs.getDouble("amount"));
                    bs.setPaymentStatus(rs.getString("payment_status"));
                    bs.setSeatNumbers(rs.getString("seat_numbers"));

                    bookings.add(bs);
                }
            }
        }
        return bookings;
    }



    public static Integer getTheaterMovieId(int theaterId, int movieId) throws SQLException {
        String sql = "SELECT theater_movie_id FROM theater_movies WHERE theater_id = ? AND movie_id = ?";
        try (Connection con = ConnectionClass.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, theaterId);
            ps.setInt(2, movieId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return null;
    }

    public static void updateTheaterMovie(int theaterMovieId, String posterUrl, String trailerUrl) throws SQLException {
        String sql = "UPDATE theater_movies SET poster_url = ?, trailer_url = ? WHERE theater_movie_id = ?";
        try (Connection con = ConnectionClass.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, posterUrl);
            ps.setString(2, trailerUrl);
            ps.setInt(3, theaterMovieId);
            ps.executeUpdate();
        }
    }



public static double getBasePriceForShow(int showId) throws Exception {
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
    return 0;
}

//show details for seat
public static String getMovieTitleByShowId(int showId) throws Exception {
	String sql = "SELECT m.title AS movie_title " +
            "FROM shows sh " +
            "JOIN theater_movies tm ON sh.theater_movie_id = tm.theater_movie_id " +
            "JOIN movies m ON tm.movie_id = m.movie_id " +
            "WHERE sh.show_id = ?";


    try (Connection con = ConnectionClass.getConnect();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setInt(1, showId);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getString("title");
            }
        }
    }
    return null;
}

public static double getShowPrice(int showId) throws Exception {
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
}


