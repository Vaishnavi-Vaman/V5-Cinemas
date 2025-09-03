package com.V5.controller;
import com.V5.dao.TheaterDAO; import com.V5.dto.Show;
import jakarta.servlet.annotation.WebServlet; import jakarta.servlet.http.*; import jakarta.servlet.ServletException;
import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet("/AddShowServlet")
public class AddShowServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Show s = new Show();
            s.setTheaterMovieId(Integer.parseInt(req.getParameter("theaterMovieId")));
            s.setScreenId(Integer.parseInt(req.getParameter("screenId")));
            // datetime-local -> parse
            s.setShowTime(LocalDateTime.parse(req.getParameter("showTime")));
            s.setPrice(Double.parseDouble(req.getParameter("price")));
            TheaterDAO.addShow(s);
            // optionally generate show_seats using SeatGeneratorUtil
            resp.sendRedirect("AdminDashboard");
        } catch(Exception e){ e.printStackTrace(); resp.sendRedirect("AdminDashboard?error=AddShowFailed"); }
    }
}
