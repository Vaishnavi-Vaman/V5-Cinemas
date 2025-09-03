package com.V5.controller;

import com.V5.dao.TheaterDAO;
import com.V5.dto.Screen;
import com.V5.dto.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import java.io.IOException;

@WebServlet("/AddScreenServlet")
public class AddScreenServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User admin = (User) req.getSession(false).getAttribute("user");
        if (admin == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        try {
            // Read form inputs
            String screenName = req.getParameter("screenName");
            int theaterId = Integer.parseInt(req.getParameter("theaterId"));
            int totalSeats = Integer.parseInt(req.getParameter("totalSeats"));

            // Create Screen DTO
            Screen s = new Screen();
            s.setName(screenName);
            s.setTheaterId(theaterId);

            // Insert screen and get generated ID
            int screenId = TheaterDAO.addScreen(s);

            // Auto-generate seats for the new screen
            TheaterDAO.generateSeats(screenId, totalSeats);

            resp.sendRedirect("AdminDashboard");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("AdminDashboard?error=AddScreenFailed");
        }
    }
}
