package com.V5.controller;



	import com.V5.dao.TheaterDAO;
	import com.V5.dto.Show;

	import java.io.IOException;
	import java.time.LocalDateTime;
	import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
	import jakarta.servlet.http.HttpServletRequest;
	import jakarta.servlet.http.HttpServletResponse;
	@WebServlet("/UpdateShowServlet")

	public class UpdateShowServlet extends HttpServlet {
	    private static final long serialVersionUID = 1L;

	    @Override
	    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
	            throws ServletException, IOException {

	        try {
	            // Get parameters from request
	            int showId = Integer.parseInt(request.getParameter("showId"));
	            LocalDateTime showTime = LocalDateTime.parse(request.getParameter("showTime").replace(" ", "T"));
	            double price = Double.parseDouble(request.getParameter("price"));

	            // Create Show object
	            Show show = new Show();
	            show.setShowId(showId);
	            show.setShowTime(showTime);
	            show.setPrice(price);

	            // Update show in database
	            TheaterDAO.updateShow(show);

	            // Set success message
	            request.getSession().setAttribute("message", "Show updated successfully!");
	            request.getSession().setAttribute("messageType", "success");

	        } catch (Exception e) {
	            e.printStackTrace();
	            // Set error message
	            request.getSession().setAttribute("message", "Error updating show: " + e.getMessage());
	            request.getSession().setAttribute("messageType", "error");
	        }

	        // Redirect back to shows page
	        response.sendRedirect("AdminDashboard?tab=shows");
	    }
	}


