package com.V5.controller.user;

import com.V5.dao.user.RatingDAO;
import com.V5.dto.user.Rating;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet("/submitRating")
public class SubmitRatingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String userIdStr  = req.getParameter("userId");
            String guestIdStr = req.getParameter("guestId");
            String ratingStr  = req.getParameter("rating");

            Rating rating = new Rating();

            if (userIdStr != null && !userIdStr.isEmpty()) {
                rating.setUserId(Integer.parseInt(userIdStr));
            }
            if (guestIdStr != null && !guestIdStr.isEmpty()) {
                rating.setGuestId(Integer.parseInt(guestIdStr));
            }

            rating.setMovieId(Integer.parseInt(req.getParameter("movieId")));
            int r = Integer.parseInt(ratingStr);
            if (r < 1 || r > 5) r = 5; // clamp as a safety net
            rating.setRating(r);
            rating.setFeedback(req.getParameter("feedback"));
            rating.setRatingDate(LocalDateTime.now());

            new RatingDAO().addRating(rating);

            resp.setContentType("text/html;charset=UTF-8");
            resp.getWriter().println("<h2 style='font-family:Arial'>✅ Thank you! Your feedback has been recorded.</h2>");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to save feedback");
        }
    }
}
