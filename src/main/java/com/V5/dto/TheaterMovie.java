package com.V5.dto;

public class TheaterMovie {
    private int theaterMovieId;
    private int theaterId;
    private int movieId;
    private String posterUrl;
    private String trailerUrl;
    private Movie movie;
    private String theaterName;

    public int getTheaterMovieId() {
        return theaterMovieId;
    }
    public void setTheaterMovieId(int theaterMovieId) {
        this.theaterMovieId = theaterMovieId;
    }
    public int getTheaterId() {
        return theaterId;
    }
    public void setTheaterId(int theaterId) {
        this.theaterId = theaterId;
    }
    public int getMovieId() {
        return movieId;
    }
    public void setMovieId(int movieId) {
        this.movieId = movieId;
    }
    public String getPosterUrl() {
        return posterUrl;
    }
    public void setPosterUrl(String posterUrl) {
        this.posterUrl = posterUrl;
    }
    public String getTrailerUrl() {
        return trailerUrl;
    }
    public void setTrailerUrl(String trailerUrl) {
        this.trailerUrl = trailerUrl;
    }
    public Movie getMovie() { return movie; }
    public void setMovie(Movie movie) { this.movie = movie; }

    public String getTheaterName() { return theaterName; }
    public void setTheaterName(String theaterName) { this.theaterName = theaterName; }
}

