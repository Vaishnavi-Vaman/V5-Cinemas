package com.V5.dto.user;

import java.time.LocalDateTime;

public class Rating {
    private int ratingId;
    private Integer userId;   // nullable
    private Integer guestId;  // nullable
    private int movieId;
    private int rating;
    private String feedback;
    private LocalDateTime ratingDate;

    public int getRatingId() { return ratingId; }
    public void setRatingId(int ratingId) { this.ratingId = ratingId; }

    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }

    public Integer getGuestId() { return guestId; }
    public void setGuestId(Integer guestId) { this.guestId = guestId; }

    public int getMovieId() { return movieId; }
    public void setMovieId(int movieId) { this.movieId = movieId; }

    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }

    public String getFeedback() { return feedback; }
    public void setFeedback(String feedback) { this.feedback = feedback; }

    public LocalDateTime getRatingDate() { return ratingDate; }
    public void setRatingDate(LocalDateTime ratingDate) { this.ratingDate = ratingDate; }

    @Override
    public String toString() {
        return "Rating [ratingId=" + ratingId + ", userId=" + userId + ", guestId=" + guestId +
               ", movieId=" + movieId + ", rating=" + rating + ", feedback=" + feedback +
               ", ratingDate=" + ratingDate + "]";
    }
}
