package com.V5.dto;

import java.time.LocalDateTime;

public class Show {
    private int showId;
    private int theaterMovieId;
    private int screenId;
    private LocalDateTime showTime;
    private double price;

    public int getShowId() {
        return showId;
    }
    public void setShowId(int showId) {
        this.showId = showId;
    }
    public int getTheaterMovieId() {
        return theaterMovieId;
    }
    public void setTheaterMovieId(int theaterMovieId) {
        this.theaterMovieId = theaterMovieId;
    }
    public int getScreenId() {
        return screenId;
    }
    public void setScreenId(int screenId) {
        this.screenId = screenId;
    }
    public LocalDateTime getShowTime() {
        return showTime;
    }
    public void setShowTime(LocalDateTime showTime) {
        this.showTime = showTime;
    }
    public double getPrice() {
        return price;
    }
    public void setPrice(double price) {
        this.price = price;
    }
}
