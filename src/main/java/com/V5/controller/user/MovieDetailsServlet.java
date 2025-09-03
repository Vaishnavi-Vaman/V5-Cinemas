package com.V5.controller.user;


import com.V5.dao.MovieDAO;
import com.V5.dao.user.RatingDAO;
import com.V5.dao.user.ShowDetailsDAO;
import com.V5.dto.Movie;
import com.V5.dto.user.Rating;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/movieDetails")
public class MovieDetailsServlet extends HttpServlet {

    private MovieDAO movieDAO;
    private RatingDAO ratingDAO;

    @Override
    public void init() {
        movieDAO = new MovieDAO();
        ratingDAO = new RatingDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int movieId = Integer.parseInt(request.getParameter("id"));

            Movie movie = ShowDetailsDAO.getMovieById(movieId);
            System.out.println("====================================");
            System.out.println(movie);
           
            if (movie == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Movie not found");
                return;
            }

            List<Rating> ratings = ratingDAO.getRatingsByMovieId(movieId);
            System.out.println(ratings);
            ratings.forEach(System.out::println);

            request.setAttribute("movie", movie);
            request.setAttribute("ratings", ratings);

            RequestDispatcher rd = request.getRequestDispatcher("movieDetails.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
