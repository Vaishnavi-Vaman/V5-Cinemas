package com.V5.controller;


	import com.V5.dao.MovieDAO;
	import com.V5.dto.Movie;
	import jakarta.servlet.ServletException;
	import jakarta.servlet.annotation.WebServlet;
	import jakarta.servlet.http.*;

	import java.io.IOException;
	import java.util.List;

	@WebServlet("/HomeServlet")
	public class HomeServlet extends HttpServlet {
	    @Override
	    protected void doGet(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
	        try {
	            List<Movie> movies = MovieDAO.getAllMovies();
	            request.setAttribute("movies", movies);
	            request.getRequestDispatcher("home.jsp").forward(request, response);
	        } catch (Exception e) {
	            throw new ServletException(e);
	        }
	    }
	}



