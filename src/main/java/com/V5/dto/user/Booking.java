package com.V5.dto.user;



	import java.time.LocalDateTime;

	public class Booking {
	    private int bookingId;
	    private Integer userId;   // nullable
	    private Integer guestId;  // nullable
	    private int showId;
	    private LocalDateTime bookingDate;
	    private double totalAmount;

	    public int getBookingId() { return bookingId; }
	    public void setBookingId(int bookingId) { this.bookingId = bookingId; }
	    public Integer getUserId() { return userId; }
	    public void setUserId(Integer userId) { this.userId = userId; }
	    public Integer getGuestId() { return guestId; }
	    public void setGuestId(Integer guestId) { this.guestId = guestId; }
	    public int getShowId() { return showId; }
	    public void setShowId(int showId) { this.showId = showId; }
	    public LocalDateTime getBookingDate() { return bookingDate; }
	    public void setBookingDate(LocalDateTime bookingDate) { this.bookingDate = bookingDate; }
	    public double getTotalAmount() { return totalAmount; }
	    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }
	}



