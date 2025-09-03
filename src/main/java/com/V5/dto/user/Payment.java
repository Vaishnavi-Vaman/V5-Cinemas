package com.V5.dto.user;


	import java.time.LocalDateTime;

	public class Payment {
	    private int paymentId;
	    private int bookingId;
	    private double amount;
	    private String status;
	    private LocalDateTime paymentDate;

	    public int getPaymentId() { return paymentId; }
	    public void setPaymentId(int paymentId) { this.paymentId = paymentId; }
	    public int getBookingId() { return bookingId; }
	    public void setBookingId(int bookingId) { this.bookingId = bookingId; }
	    public double getAmount() { return amount; }
	    public void setAmount(double amount) { this.amount = amount; }
	    public String getStatus() { return status; }
	    public void setStatus(String status) { this.status = status; }
	    public LocalDateTime getPaymentDate() { return paymentDate; }
	    public void setPaymentDate(LocalDateTime paymentDate) { this.paymentDate = paymentDate; }
	}



