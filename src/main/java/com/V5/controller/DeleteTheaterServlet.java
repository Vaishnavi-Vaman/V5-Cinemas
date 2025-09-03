package com.V5.controller;

import com.V5.dao.TheaterDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/DeleteTheaterServlet")
public class DeleteTheaterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect("AdminDashboard?error=Invalid+Theater+ID");
            return;
        }

        try {
            int theaterId = Integer.parseInt(idParam);
            TheaterDAO.deleteTheater(theaterId);
            response.sendRedirect("AdminDashboard?msg=Theater+deleted+successfully");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("AdminDashboard?error=Unable+to+delete+theater");
        }
    }
}
