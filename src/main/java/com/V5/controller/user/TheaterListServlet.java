package com.V5.controller.user;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

import com.V5.dao.user.ShowDetailsDAO;
import com.V5.dto.Show;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/TheaterListServlet")
public class TheaterListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int movieId = Integer.parseInt(request.getParameter("movieId"));
        String location = request.getParameter("location");

        // DAO call: Map<TheaterName, Map<LocalDate, List<Show>>>
        Map<String, Map<LocalDate, List<Show>>> theaterShows =
                ShowDetailsDAO.getShowsByMovieAndLocation(movieId, location);

        // Format structure for JSP
        Map<String, Map<LocalDate, List<Map<String, Object>>>> formattedShows = new LinkedHashMap<>();
        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("hh:mm a");

        for (Map.Entry<String, Map<LocalDate, List<Show>>> theaterEntry : theaterShows.entrySet()) {
            String theaterName = theaterEntry.getKey();
            Map<LocalDate, List<Show>> dateMap = theaterEntry.getValue();

            Map<LocalDate, List<Map<String, Object>>> newDateMap = new LinkedHashMap<>();

            for (Map.Entry<LocalDate, List<Show>> dateEntry : dateMap.entrySet()) {
                LocalDate date = dateEntry.getKey();
                List<Show> shows = dateEntry.getValue();

                List<Map<String, Object>> formattedList = new ArrayList<>();

                for (Show s : shows) {
                    Map<String, Object> showMap = new HashMap<>();
                    showMap.put("time", s.getShowTime().format(timeFormatter));
                    showMap.put("id", s.getShowId());
                    formattedList.add(showMap);
                }
                newDateMap.put(date, formattedList);
            }
            formattedShows.put(theaterName, newDateMap);
        }

        // Generate next 7 days for date bar
        List<LocalDate> next7Days = new ArrayList<>();
        LocalDate today = LocalDate.now();
        for (int i = 0; i < 7; i++) {
            next7Days.add(today.plusDays(i));
        }
        request.setAttribute("next7Days", next7Days);

        // Selected date (default today)
        String selectedDateParam = request.getParameter("date");
        LocalDate selectedDate = (selectedDateParam != null)
                ? LocalDate.parse(selectedDateParam)
                : today;
        request.setAttribute("selectedDate", selectedDate);

        request.setAttribute("theaterShows", formattedShows);
        request.setAttribute("location", location);
        request.setAttribute("movieId", movieId);

        if (formattedShows.isEmpty()) {
            request.setAttribute("msg", "Selected movie not available in " + location);
            
            request.getRequestDispatcher("selectLocation.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("Theaterlistuser.jsp").forward(request, response);
        }
        
    }
}
