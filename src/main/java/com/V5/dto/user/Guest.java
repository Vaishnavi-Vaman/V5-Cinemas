package com.V5.dto.user;



	public class Guest {
	    private int guestId;
	    private String name;
	    private String email;

	    public Guest(String name, String email) {
	        this.name = name;
	        this.email = email;
	    }

	    public int getGuestId() { return guestId; }
	    public void setGuestId(int guestId) { this.guestId = guestId; }
	    public String getName() { return name; }
	    public String getEmail() { return email; }
	}



