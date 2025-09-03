package com.V5.controller;
import com.V5.dao.TheaterDAO;
import jakarta.servlet.annotation.WebServlet; import jakarta.servlet.http.*; import jakarta.servlet.ServletException;
import java.io.IOException;

@WebServlet("/DeleteScreenServlet")
public class DeleteScreenServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int screenId = Integer.parseInt(req.getParameter("screenId"));
            TheaterDAO.deleteScreen(screenId);
            resp.sendRedirect("AdminDashboard");
        } catch(Exception e){ e.printStackTrace(); resp.sendRedirect("AdminDashboard?error=DeleteScreenFailed"); }
    }
}

