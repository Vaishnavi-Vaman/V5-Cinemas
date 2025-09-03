package com.V5.controller;

import com.V5.dao.MovieDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/DeleteMovie")
public class DeleteMovieServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("movieId");
        if (idStr == null) {
            response.sendRedirect("SuperAdminDashboard?error=Invalid+id");
            return;
        }

        try {
            int movieId = Integer.parseInt(idStr);
            MovieDAO.deleteMovie(movieId);
            response.sendRedirect("SuperAdminDashboard");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("SuperAdminDashboard");
        }
    }
}
