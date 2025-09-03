package com.V5.controller;


import com.V5.dao.TheaterDAO;
import com.V5.dto.BookingSummary;
import com.V5.dto.Movie;
import com.V5.dto.Screen;
import com.V5.dto.Show;
import com.V5.dto.Theater;
import com.V5.dto.TheaterMovie;
import com.V5.dto.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/AdminDashboard")
public class AdminDashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            HttpSession session = req.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                resp.sendRedirect("Login.jsp");
                return;
            }
            User admin = (User) session.getAttribute("user");

            List<Theater> theaters = TheaterDAO.listByAdmin(admin.getUserId());
            List<Screen> screens = TheaterDAO.listScreensByAdmin(admin.getUserId());
            List<Movie> globalMovies = TheaterDAO.listAllGlobalMovies();
            List<TheaterMovie> publishedMovies = TheaterDAO.listTheaterMoviesByAdmin(admin.getUserId());
            List<Show> shows = TheaterDAO.listShowsByAdmin(admin.getUserId());
            List<BookingSummary> bookings = TheaterDAO.getBookingsForAdmin(admin.getUserId());

            
            System.out.println("====================================");
            System.out.println(globalMovies);
            globalMovies.forEach(System.out::println);
            req.setAttribute("theaters", theaters);
            req.setAttribute("screens", screens);
            req.setAttribute("globalMovies", globalMovies);
            req.setAttribute("publishedMovies", publishedMovies);
            req.setAttribute("shows", shows);
            req.setAttribute("bookings", bookings);

            req.getRequestDispatcher("admin-dashboard.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("error.jsp?msg=Unable+to+load+dashboard");
        }
    }
}
