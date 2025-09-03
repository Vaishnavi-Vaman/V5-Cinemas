package com.V5.controller;


	import com.V5.dao.TheaterDAO;
	import java.io.IOException;
	import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
	import jakarta.servlet.http.HttpServletRequest;
	import jakarta.servlet.http.HttpServletResponse;
	
	@WebServlet("/DeleteShowServlet")
	public class DeleteShowServlet extends HttpServlet {
	    private static final long serialVersionUID = 1L;

	    @Override
	    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
	            throws ServletException, IOException {

	        try {
	            // Get show ID from request
	            int showId = Integer.parseInt(request.getParameter("showId"));

	            // Delete show from database
	            TheaterDAO.deleteShow(showId);

	            // Set success message
	            request.getSession().setAttribute("message", "Show deleted successfully!");
	            request.getSession().setAttribute("messageType", "success");

	        } catch (Exception e) {
	            e.printStackTrace();
	            // Set error message
	            request.getSession().setAttribute("message", "Error deleting show: " + e.getMessage());
	            request.getSession().setAttribute("messageType", "error");
	        }

	        // Redirect back to shows page
	        response.sendRedirect("AdminDashboard?tab=shows");
	    }
	}


