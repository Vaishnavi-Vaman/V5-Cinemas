
	package com.V5.dto;

	public class Seat {
	    private int seatId;
	    private String rowLabel;
	    private int seatNumber;
	    private int screenId;
	    private String seatType;

	    public void setSeatId(int seatId) {
			this.seatId = seatId;
		}

		public void setRowLabel(String rowLabel) {
			this.rowLabel = rowLabel;
		}

		public void setSeatNumber(int seatNumber) {
			this.seatNumber = seatNumber;
		}

		public void setScreenId(int screenId) {
			this.screenId = screenId;
		}

		public void setSeatType(String seatType) {
			this.seatType = seatType;
		}

		public Seat(int seatId, String rowLabel, int seatNumber, int screenId, String seatType) {
	        this.seatId = seatId;
	        this.rowLabel = rowLabel;
	        this.seatNumber = seatNumber;
	        this.screenId = screenId;
	        this.seatType = seatType;
	    }

	    public Seat() {
			// TODO Auto-generated constructor stub
		}

		public int getSeatId() { return seatId; }
	    public String getRowLabel() { return rowLabel; }
	    public int getSeatNumber() { return seatNumber; }
	    public int getScreenId() { return screenId; }
	    public String getSeatType() { return seatType; }
	}



