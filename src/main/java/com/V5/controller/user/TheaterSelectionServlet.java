package com.V5.controller.user;
	import com.V5.dao.user.TheaterDAO;
import com.V5.dto.TheaterMovie;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
	import java.util.List;

	@WebServlet("/TheaterSelectionServlet")
	public class TheaterSelectionServlet extends HttpServlet {
	    @Override
	    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        int movieId = Integer.parseInt(request.getParameter("movieId"));

	        // Fetch distinct locations where this movie is available
	        List<String> locations = TheaterDAO.getLocationsByMovie(movieId);
	      
	        System.out.println(" ============= locations ============="+locations);
	        locations.forEach(System.out::println);

	        request.setAttribute("movieId", movieId);
	        request.setAttribute("locations", locations);
	        String city = request.getParameter("city");
	        System.out.println("Selected City: " + city);

	        request.getRequestDispatcher("selectLocation.jsp").forward(request, response);
	    }
	}



