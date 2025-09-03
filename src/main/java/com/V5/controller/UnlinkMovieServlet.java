package com.V5.controller;
import com.V5.dao.TheaterDAO; import com.V5.dto.User;
import jakarta.servlet.annotation.WebServlet; import jakarta.servlet.http.*; import jakarta.servlet.ServletException;
import java.io.IOException;

@WebServlet("/UnlinkMovieServlet")
public class UnlinkMovieServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User admin = (User) req.getSession(false).getAttribute("user");
        if (admin==null) { resp.sendRedirect("login.jsp"); return; }
        try {
            int tmId = Integer.parseInt(req.getParameter("theaterMovieId"));
            TheaterDAO.unlinkMovieFromTheater(tmId, admin.getUserId());
            resp.sendRedirect("AdminDashboard");
        } catch(Exception e){ e.printStackTrace(); resp.sendRedirect("AdminDashboard?error=UnlinkFailed"); }
    }
}
