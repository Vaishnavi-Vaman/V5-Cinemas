package com.V5.controller;
import com.V5.dao.TheaterDAO; import com.V5.dto.Screen;
import jakarta.servlet.annotation.WebServlet; import jakarta.servlet.http.*; import jakarta.servlet.ServletException;
import java.io.IOException;

@WebServlet("/EditScreenServlet")
public class EditScreenServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Screen s = new Screen();
            s.setScreenId(Integer.parseInt(req.getParameter("screenId")));
            s.setName(req.getParameter("name"));
            s.setTheaterId(Integer.parseInt(req.getParameter("theaterId")));
            TheaterDAO.updateScreen(s);
            resp.sendRedirect("AdminDashboard");
        } catch(Exception e){ e.printStackTrace(); resp.sendRedirect("AdminDashboard?error=EditScreenFailed"); }
    }
}
