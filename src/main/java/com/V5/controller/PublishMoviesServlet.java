package com.V5.controller;

import com.V5.dao.TheaterDAO;
import com.V5.dto.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import java.io.IOException;

@WebServlet("/PublishMoviesServlet")
public class PublishMoviesServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User admin = (session != null) ? (User) session.getAttribute("user") : null;

        if (admin == null || !"admin".equalsIgnoreCase(admin.getRole())) {
            resp.sendRedirect("login.jsp?error=Please+login+as+admin");
            return;
        }

        try {
            int theaterId = Integer.parseInt(req.getParameter("theaterId"));
            int movieId = Integer.parseInt(req.getParameter("movieId"));
            String posterUrl = req.getParameter("posterUrl");
            String trailerUrl = req.getParameter("trailerUrl");

            // 1️⃣ Check if movie is already published to this theater
            Integer existingId = TheaterDAO.getTheaterMovieId(theaterId, movieId);

            if (existingId != null) {
                // Already exists — maybe update poster/trailer
                TheaterDAO.updateTheaterMovie(existingId, posterUrl, trailerUrl);
            } else {
                // Doesn't exist — insert new
                TheaterDAO.linkMovieToTheater(theaterId, movieId, posterUrl, trailerUrl);
            }

            resp.sendRedirect("AdminDashboard?success=Movie+Published");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("AdminDashboard?error=LinkFailed");
        }
    }
}
