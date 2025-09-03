package com.V5.controller;

import com.V5.dao.TheaterDAO;
import com.V5.dto.Theater;
import com.V5.dto.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/AddTheater")
public class AddTheaterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User admin = (User) session.getAttribute("user");

        if (admin == null || !"admin".equalsIgnoreCase(admin.getRole())) {
            response.sendRedirect("login.jsp?error=Please+login+as+admin");
            return;
        }

        String name = request.getParameter("name");
        String location = request.getParameter("location");

        try {
            Theater theater = new Theater();
            theater.setName(name);
            theater.setLocation(location);
            theater.setAdminId(admin.getUserId());

            TheaterDAO.addTheater(theater);

            response.sendRedirect("AdminDashboard");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?msg=Unable+to+add+theater");
        }
    }
}
