package com.V5.controller;

import com.V5.dao.MovieDAO;
import com.V5.dao.UserDAO;
import com.V5.dto.Movie;
import com.V5.dto.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/SuperAdminDashboard")
public class SuperAdminDashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // optional: role check (redirect if not super_admin)
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp?error=Please+login");
            return;
        }
        com.V5.dto.User logged = (com.V5.dto.User) session.getAttribute("user");
        if (logged == null || !"super_admin".equalsIgnoreCase(logged.getRole())) {
            response.sendRedirect("login.jsp?error=Access+denied");
            return;
        }

        try {
            List<User> pendingAdmins = UserDAO.getPendingAdmins();
            List<Movie> movies = MovieDAO.getAllMovies();

            request.setAttribute("pendingAdmins", pendingAdmins);
            request.setAttribute("movies", movies);

            // forward to JSP (webapp root). Use path you keep (Pending.jsp or superAdminDashboard.jsp)
            request.getRequestDispatcher("Super-Admin-Dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?msg=Unable+to+load+dashboard");
        }
    }
}
