package com.V5.controller;

import com.V5.dao.MovieDAO;
import com.V5.dto.Movie;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/AddMovie")
public class AddMovieServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            request.setCharacterEncoding("UTF-8");
            Movie m = new Movie();
            m.setTitle(request.getParameter("title"));
            m.setLanguage(request.getParameter("language"));
            m.setDuration(Integer.parseInt(request.getParameter("duration")));
            m.setGenre(request.getParameter("genre"));
            m.setReleaseDate(request.getParameter("release_date"));
            m.setPosterUrl(request.getParameter("poster_url"));
            m.setTrailerUrl(request.getParameter("trailer_url"));

            int res = MovieDAO.addMovie(m);
            if (res > 0) {
                response.sendRedirect("SuperAdminDashboard");
            } else {
                response.sendRedirect("SuperAdminDashboard");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("SuperAdminDashboard?error=Server+error");
        }
    }
}
