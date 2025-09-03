package com.V5.dto;

import java.sql.Timestamp;
import java.util.Arrays;
import java.util.List;

public class BookingSummary {
    private int bookingId;
    private String customerName;
    private String movieTitle;
    private String theaterName;
    private String screenName;
    private Timestamp bookingDate;
    private Timestamp showTime;
    private double amount;
    private String paymentStatus;

    // store seats as comma separated string
    private String seatNumbers;
    private String userEmail;
    private String guestEmail;

    public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getGuestEmail() {
		return guestEmail;
	}
	public void setGuestEmail(String guestEmail) {
		this.guestEmail = guestEmail;
	}
	public int getBookingId() {
        return bookingId;
    }
    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public String getCustomerName() {
        return customerName;
    }
    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getMovieTitle() {
        return movieTitle;
    }
    public void setMovieTitle(String movieTitle) {
        this.movieTitle = movieTitle;
    }

    public String getTheaterName() {
        return theaterName;
    }
    public void setTheaterName(String theaterName) {
        this.theaterName = theaterName;
    }

    public String getScreenName() {
        return screenName;
    }
    public void setScreenName(String screenName) {
        this.screenName = screenName;
    }

    public Timestamp getBookingDate() {
        return bookingDate;
    }
    public void setBookingDate(Timestamp bookingDate) {
        this.bookingDate = bookingDate;
    }

    public Timestamp getShowTime() {
        return showTime;
    }
    public void setShowTime(Timestamp showTime) {
        this.showTime = showTime;
    }

    public double getAmount() {
        return amount;
    }
    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }
    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getSeatNumbers() {
        return seatNumbers;
    }
    public void setSeatNumbers(String seatNumbers) {
        this.seatNumbers = seatNumbers;
    }

    // Helper: return list of seats instead of raw string
    public List<String> getSeatList() {
        if (seatNumbers == null || seatNumbers.isEmpty()) {
            return List.of();
        }
        return Arrays.asList(seatNumbers.split(","));
    }
}
