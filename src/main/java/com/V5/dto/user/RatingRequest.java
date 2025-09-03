package com.V5.dto.user;

import java.time.LocalDateTime;

public class RatingRequest {
    private int bookingId;
    private Integer userId;   // nullable
    private Integer guestId;  // nullable
    private int movieId;
    private String movieTitle;
    private String email;
    private LocalDateTime showEndTime;

    public int getBookingId() { return bookingId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }
    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    public Integer getGuestId() { return guestId; }
    public void setGuestId(Integer guestId) { this.guestId = guestId; }
    public int getMovieId() { return movieId; }
    public void setMovieId(int movieId) { this.movieId = movieId; }
    public String getMovieTitle() { return movieTitle; }
    public void setMovieTitle(String movieTitle) { this.movieTitle = movieTitle; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public LocalDateTime getShowEndTime() { return showEndTime; }
    public void setShowEndTime(LocalDateTime showEndTime) { this.showEndTime = showEndTime; }
}
