package com.V5.util;

import com.V5.dto.user.RatingRequest;

public class FeedbackMailUtil {

    // Change this to your deployed domain
    private static final String BASE_URL = "http://localhost:8080/V5";

    public static void sendFeedbackMail(RatingRequest r) throws Exception {
        if (r.getEmail() == null || r.getEmail().isEmpty()) return;

        // Build link to rating form
        String link = BASE_URL + "/rating_form.jsp?movieId=" + r.getMovieId()
                + "&bookingId=" + r.getBookingId();

        if (r.getUserId() != null)  link += "&userId="  + r.getUserId();
        if (r.getGuestId() != null) link += "&guestId=" + r.getGuestId();

        // Build subject
        String subject = "Rate your experience: " + (r.getMovieTitle() != null ? r.getMovieTitle() : "movie");

        // Build HTML body using concatenation (Java 8 compatible)
        String html = "<div style=\"font-family:Arial,sans-serif\">"
                + "<h2>How was your experience"
                + (r.getMovieTitle() != null ? " for <em>" + r.getMovieTitle() + "</em>" : "")
                + "?</h2>"
                + "<p>Please take 10 seconds to leave a star rating and an optional comment.</p>"
                + "<p>"
                + "<a href=\"" + link + "\" style=\"background:#ff5722;color:#fff;padding:10px 16px;border-radius:8px;text-decoration:none;\">"
                + "Rate now"
                + "</a>"
                + "</p>"
                + "<p style=\"color:#666;font-size:12px\">This link opens a simple form with stars + a text box.</p>"
                + "</div>";

        // Send email using your existing EmailUtil
        EmailUtil.sendEmail(r.getEmail(), subject, html);
    }
}
