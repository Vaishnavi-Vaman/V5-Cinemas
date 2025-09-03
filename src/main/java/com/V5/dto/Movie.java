package com.V5.dto;

public class Movie {
    private int movieId;
    private  String title;
    private String language;
    private int duration;
    private String genre;
    private String releaseDate;
    private String posterUrl;
    private String trailerUrl;
    
    

    @Override
	public String toString() {
		return "Movie [movieId=" + movieId + ", title=" + title + ", language=" + language + ", duration=" + duration
				+ ", genre=" + genre + ", releaseDate=" + releaseDate + ", posterUrl=" + posterUrl + ", trailerUrl="
				+ trailerUrl + "]";
	}
	public int getMovieId() { return movieId; }
    public void setMovieId(int movieId) { this.movieId = movieId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getLanguage() { return language; }
    public void setLanguage(String language) { this.language = language; }

    public int getDuration() { return duration; }
    public void setDuration(int duration) { this.duration = duration; }

    public String getGenre() { return genre; }
    public void setGenre(String genre) { this.genre = genre; }

    public String getReleaseDate() { return releaseDate; }
    public void setReleaseDate(String releaseDate) { this.releaseDate = releaseDate; }

    public String getPosterUrl() { return posterUrl; }
    public void setPosterUrl(String posterUrl) { this.posterUrl = posterUrl; }

    public String getTrailerUrl() { return trailerUrl; }
    public void setTrailerUrl(String trailerUrl) { this.trailerUrl = trailerUrl; }
}
