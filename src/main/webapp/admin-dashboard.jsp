<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="com.V5.dto.User" %>


<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    User admin = (User) sessionObj.getAttribute("user");
%>
<html>
<head>
    <title>Admin Dashboard - V5 Cinemas</title>
    <style>
    
    .toast {
    visibility: hidden;
    min-width: 250px;
    background-color: #4CAF50;
    color: white;
    text-align: center;
    border-radius: 4px;
    padding: 16px;
    position: fixed;
    z-index: 1000;
    top: 30px;
    right: 30px;
    font-size: 16px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.3);
    opacity: 0;
    transition: opacity 0.3s, visibility 0.3s;
}

.toast.show {
    visibility: visible;
    opacity: 1;
}

.toast.error {
    background-color: #f44336;
}
        /* Your existing CSS unchanged */
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #0d0d0d, #1a1a1a);
            margin: 0;
            color: #f5f5f5;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            position: relative;
            padding: 15px 20px 15px 75px; /* Extra left padding for profile circle */
            background: rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
        }

        .profile-section {
            position: absolute;
            left: 20px;
            top: 50%;
            transform: translateY(-50%);
            z-index: 1000;
        }

        .profile-circle {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: linear-gradient(135deg, #e50914, #ff3333);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 20px;
            box-shadow: 0 4px 12px rgba(229, 9, 20, 0.4);
            border: 2px solid rgba(255, 255, 255, 0.2);
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .profile-circle:hover {
            transform: scale(1.1);
            box-shadow: 0 6px 16px rgba(229, 9, 20, 0.6);
        }

        .logo {
            font-size: 24px;
            font-weight: bold;
            color: gold;
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
            transition: opacity 0.3s ease;
        }

        .logo.hidden {
            opacity: 0;
            pointer-events: none;
        }

        .hamburger {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            width: 30px;
            height: 20px;
            cursor: pointer;
            margin: 20px;
            position: relative;
            z-index: 1000;
        }
        .hamburger span {
            height: 3px;
            width: 100%;
            background-color: #f5f5f5;
            border-radius: 3px;
            transition: all 0.3s ease;
            transform-origin: center;
        }
        .hamburger.active span:nth-child(1) {
            transform: rotate(45deg) translate(6px, 6px);
        }
        .hamburger.active span:nth-child(2) {
            opacity: 0;
        }
        .hamburger.active span:nth-child(3) {
            transform: rotate(-45deg) translate(6px, -6px);
        }
        .tabs {
            display: flex;
            flex-direction: row;
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            background: linear-gradient(180deg, #111 0%, #222 100%);
            box-shadow: 0 4px 12px rgba(0,0,0,0.8);
            width: 100%;
            z-index: 99;
            transform: translateY(-100%);
            transition: transform 0.6s cubic-bezier(0.4, 0, 0.2, 1);
            opacity: 0;
            visibility: hidden;
            padding: 10px 0;
            justify-content: center;
            align-items: center;
            gap: 10px;
        }
        .tabs.show {
            visibility: visible;
            opacity: 1;
            transform: translateY(0);
        }
        .tab { padding: 12px 16px; color: #f5f5f5; cursor: pointer; text-transform: uppercase; font-weight: bold; border-right: 3px solid transparent; transition: all 0.3s ease; white-space: nowrap; font-size: 0.9rem; }
        .tab:hover { background: #222; border-right: 3px solid #e50914; }
        .tab.active { background: #000; border-right: 3px solid gold; }
        .tab:last-child { border-right: none; }
        .tab-content { display: none; padding: 20px; background: rgba(0,0,0,0.85); border-radius: 10px; margin: 20px auto; box-shadow: 0 4px 12px rgba(0,0,0,0.5); max-width: 1200px; }
        .tab-content.active { display: block; }
        h2, h3 { color: gold; text-shadow: 0 0 5px #e50914; }
        table { border-collapse: collapse; width: 100%; margin-top: 10px; background: rgba(255,255,255,0.05); border-radius: 8px; overflow: hidden; }
        th, td { border: 1px solid rgba(255,255,255,0.1); padding: 10px; text-align: center; color: #f5f5f5; }
        th { background: #e50914; color: white; }
        tr:nth-child(even) { background: rgba(255,255,255,0.05); }
        input, select { padding: 8px; margin: 5px; border: none; border-radius: 5px; outline: none; background: rgba(255,255,255,0.1); color: white; width: calc(100% - 16px); max-width: 300px; }
        input::placeholder { color: #ccc; }
        select { cursor: pointer; appearance: none; background-image: url('data:image/svg+xml;utf8,<svg fill="white" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/><path d="M0 0h24v24H0z" fill="none"/></svg>'); background-repeat: no-repeat; background-position: right 8px center; padding-right: 30px; }
        select:focus { box-shadow: 0 0 0 2px rgba(229, 9, 20, 0.5); }
        select option { padding: 8px; background-color: #333; }
        button { padding: 8px 14px; background: #e50914; color: white; border: none; border-radius: 5px; cursor: pointer; transition: 0.3s; }
        button:hover { background: gold; color: black; }
        form { display: inline-block; }
        select option { color: black; }
        /* Global Movies Grid Styles */
        .movies-grid {
            display: flex;
            overflow-x: auto;
            scroll-behavior: smooth;
            padding: 20px;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 15px;
            border: 1px solid rgba(229, 9, 20, 0.2);
            gap: 15px;
            min-height: 220px;
            flex-wrap: nowrap;
            width: 100%;
        }
        
        .movies-grid::-webkit-scrollbar {
            height: 8px;
        }
        
        .movies-grid::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
        }
        
        .movies-grid::-webkit-scrollbar-thumb {
            background: #e50914;
            border-radius: 10px;
        }
        
        .movies-grid .movie-card {
            flex: 0 0 auto;
            width: 200px;
            min-width: 200px;
            max-width: 200px;
            margin-right: 10px;
        }
        
        .movies-container {
            width: 100%;
            overflow: hidden;
        }
        
        .movie-card {
            background: linear-gradient(145deg, #2a2a2a, #1a1a1a);
            border-radius: 12px;
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
            border: 1px solid rgba(229, 9, 20, 0.1);
            height: 200px;
        }
        
        .movie-card:hover {
            transform: translateY(-8px);
            border-color: #e50914;
            box-shadow: 0 8px 25px rgba(229, 9, 20, 0.3);
        }
        
        .movie-poster {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: all 0.3s ease;
        }
        
        .movie-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.7);
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            transition: opacity 0.3s ease;
        }
        
        .movie-card:hover .movie-overlay {
            opacity: 1;
        }
        
        .movie-info {
            padding: 15px;
            text-align: left;
        }
        
        .movie-info h4 {
            margin: 0 0 10px 0;
            color: #fff;
            font-size: 16px;
        }
        
        .movie-info p {
            margin: 5px 0;
            color: #ccc;
            font-size: 14px;
        }
        
        .publish-btn {
            background: #e50914;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            transition: background 0.3s ease;
        }
        
        .publish-btn:hover {
            background: #ff3333;
        }
        
        .delete-btn {
            background: #e50914;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            transition: background 0.3s ease;
            margin-top: 10px;
        }
        
        .delete-btn:hover {
            background: #ff3333;
            transform: scale(1.05);
        }
        
        .update-btn {
            background: #4CAF50;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            margin-right: 5px;
        }
        
        .update-btn:hover {
            background: #45a049;
        }
        
        .movie-card {
            position: relative;
            overflow: hidden;
        }
        
        .movie-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.7);
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            transition: opacity 0.3s ease;
        }
        
        .movie-card:hover .movie-overlay {
            opacity: 1;
        }
        
        /* Responsive Design */
        @media (max-width: 1200px) {
            .movies-grid {
                grid-template-columns: repeat(4, 1fr);
            }
        }
        
        @media (max-width: 992px) {
            .movies-grid {
                grid-template-columns: repeat(3, 1fr);
            }
        }
        
        @media (max-width: 768px) {
            .movies-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        
        @media (max-width: 480px) {
            .movies-grid {
                grid-template-columns: 1fr;
            }
        }
        .modal { display: none; position: fixed; z-index: 999; left: 0; top: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.7); justify-content: center; align-items: center; }
        .modal-content { background: #1a1a1a; padding: 20px; border-radius: 10px; width: 400px; position: relative; color: white; }
        .form-group { display: flex; flex-direction: column; }
    .search-container {
            text-align: center;
            margin-bottom: 20px;
        }
        
        #movieSearch {
            width: 400px;
            padding: 12px 20px;
            border-radius: 25px;
            border: 1px solid #444;
            background: #2a2a2a;
            color: white;
            font-size: 16px;
            outline: none;
            transition: all 0.3s ease;
        }
        
        #movieSearch:focus {
            border-color: gold;
            box-shadow: 0 0 10px rgba(255, 215, 0, 0.3);
        }
        
        #movieSearch::placeholder {
            color: #888;
        }
            color: #888;
        }
        
        .global-movies-header {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 20px;
            gap: 20px;
        }
        
        .global-movies-header h2 {
            margin: 0;
        }
    </style>
</head>
<body>

<!-- Header -->
<div class="header">
     <div class="profile-section">
        <div class="profile-circle" id="logoutProfile" title="Logout">
            <%= admin.getEmail().toUpperCase().charAt(0) %>
        </div>
    </div>
    <div class="logo" id="logo">V5 CINEMAS</div>
    <div class="hamburger" onclick="toggleMenu()">
        <span></span>
        <span></span>
        <span></span>
    </div>
</div>



<!-- TABS -->
<div class="tabs" id="tabs">
    <div class="tab active" onclick="openTab(0)">Global Movies</div>
    <div class="tab" onclick="openTab(1)">Add Theater</div>
    <div class="tab" onclick="openTab(2)">Add Screen</div>
    <div class="tab" onclick="openTab(3)">Published Movies</div>
    <div class="tab" onclick="openTab(4)">Schedule Shows</div>
    <div class="tab" onclick="openTab(5)">View Bookings</div>
</div>

<!-- TAB 0: Global Movies -->
<div class="tab-content active">
    <div class="global-movies-header">
        <h2>🌍 Global Movies Collection</h2>
        <input type="text" id="movieSearch" placeholder="Search movies...">
    </div>
    <div class="movies-container">
        <div class="movies-grid" id="moviesGrid">
            <c:forEach var="movie" items="${globalMovies}">
                <div class="movie-card" style="height: 240px; position: relative;" data-title="${movie.title.toLowerCase()}">
                    <img class="movie-poster" src="${movie.posterUrl}" alt="${movie.title}" style="height: 200px;">
                   
                    <div class="movie-overlay">
                        <button class="publish-btn" onclick="openPublishModal('${movie.movieId}')">Publish</button>
                    </div>
                    <!-- Toast Notification -->
						<div id="toast" class="toast">
						    <span id="toastMessage"></span>
						</div>
                    <div style="position: absolute; bottom: 0; left: 0; right: 0; background: rgba(0,0,0,0.8); padding: 8px; text-align: center;">
                        <span style="color: gold; font-size: 14px; font-weight: bold;">${movie.title}</span>
                    </div>
                </div>
            </c:forEach>
        </div>
        <div id="noMoviesFound" style="text-align: center; color: #ccc; font-size: 18px; display: none; margin-top: 50px;">
            No movies found for your search.
        </div>
        
    </div>
</div>

<!-- TAB 1: Add Theater -->
<div class="tab-content">
    <h2>Add Theater</h2>
    <form action="AddTheater" method="post">
        <input type="text" name="name" placeholder="Theater Name" required>
        <input type="text" name="location" placeholder="Location" required>
        <button type="submit">Add</button>
    </form>

    <h3>Your Theaters</h3>
    <table>
        <tr><th>ID</th><th>Name</th><th>Location</th><th>Actions</th></tr>
        <c:forEach var="t" items="${theaters}">
            <tr>
                <td>${t.theaterId}</td>
                <td>${t.name}</td>
                <td>${t.location}</td>
                <td>
                    <button type="button" class="update-btn" onclick="openUpdateTheaterModal('${t.theaterId}', '${t.name}', '${t.location}')">Update</button>
                    <form action="DeleteTheaterServlet" method="post" style="display:inline-block;">
                        <input type="hidden" name="id" value="${t.theaterId}" />
                        <button type="submit" onclick="return confirm('Delete this theater?')" style="background:red;">Delete</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>

<!-- TAB 2: Add Screen -->
<div class="tab-content">
    <!-- unchanged screen form -->
    <h2>Add Screen</h2>
    <form action="AddScreenServlet" method="post">
        <select name="theaterId" required>
            <option value="">Select Theater</option>
            <c:forEach var="t" items="${theaters}">
                <option value="${t.theaterId}">${t.name}</option>
            </c:forEach>
        </select>
        <input type="text" name="screenName" placeholder="Screen Name" required>
        <input type="number" name="totalSeats" placeholder="Total Seats" min="1" required>
        <button type="submit">Add</button>
    </form>

    <h3>Your Screens</h3>
    <table>
        <tr><th>ID</th><th>Name</th><th>Theater</th><th>Actions</th></tr>
        <c:forEach var="s" items="${screens}">
            <tr>
                <td>${s.screenId}</td>
                <td>${s.name}</td>
                <td>
                    <c:forEach var="t" items="${theaters}">
                        <c:if test="${t.theaterId == s.theaterId}">${t.name}</c:if>
                    </c:forEach>
                </td>
                <td>
                    <a href="ViewSeats?screenId=${s.screenId}" style="background:gold; color:black; padding:5px 10px; border-radius:4px; text-decoration:none; margin-right:5px;">View Seats</a>
                    <form action="DeleteScreenServlet" method="post" style="display:inline-block;">
                        <input type="hidden" name="screenId" value="${s.screenId}" />
                        <button type="submit" style="background:red; color:white; padding:5px 10px; border:none; border-radius:4px; cursor:pointer;" onclick="return confirm('Are you sure you want to delete this screen? This action cannot be undone.')">Delete Screen</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>

<!-- TAB 3: Publish Movies -->
<div class="tab-content">
    <h2>📽️ Published Movies</h2>
    <div class="movies-grid">
        <c:forEach var="tm" items="${publishedMovies}">
            <c:forEach var="m" items="${globalMovies}">
                <c:if test="${m.movieId == tm.movieId}">
                    <div class="movie-card">
                        <img class="movie-poster" src="${m.posterUrl}" alt="${m.title}">
                        <div class="movie-overlay">
                            <div style="text-align: center;">
                                <h4 style="color: white; margin-bottom: 10px;">${m.title}</h4>
                                <form action="UnlinkMovieServlet" method="post" style="display: inline;">
                                    <input type="hidden" name="theaterMovieId" value="${tm.theaterMovieId}">
                                    <button type="submit" class="delete-btn" onclick="return confirm('Are you sure you want to unpublish this movie?')">Delete</button>
                                </form>
                            </div>
                        </div>
                        <div class="movie-info">
                            <h4>${m.title} (${m.language})</h4>
                            <c:forEach var="t" items="${theaters}">
                                <c:if test="${t.theaterId == tm.theaterId}">
                                    <p>Theater: ${t.name}</p>
                                </c:if>
                            </c:forEach>
                            <p>Duration: ${m.duration} mins</p>
                            <p>Genre: ${m.genre}</p>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </c:forEach>
    </div>
</div>

<!-- Publish Modal -->
<div id="publishModal" class="modal">
    <!-- unchanged modal -->
     <div class="modal-content">
        <span class="close" onclick="closeModal('publishModal')">&times;</span>
        <h3 style="color:gold;">Publish Movie</h3>
        <form action="PublishMoviesServlet" method="post">
            <input type="hidden" name="movieId" id="modalMovieId">
            <label>Select Theater:</label>
            <select name="theaterId" required>
                <option value="">Select Theater</option>
                <c:forEach var="t" items="${theaters}">
                    <option value="${t.theaterId}">${t.name}</option>
                </c:forEach>
            </select>
            <button type="submit" style="margin-top:10px;">Publish</button>
        </form>
    </div>
</div>

<!-- TAB 4: Schedule Shows -->
<div class="tab-content">
    <h2>Your Shows</h2>
    <button onclick="openModal('scheduleModal')">+ Schedule Show</button>
    <table>
        <tr><th>ID</th><th>Movie</th><th>Screen</th><th>Time</th><th>Price</th><th>Action</th></tr>
        <c:forEach var="s" items="${shows}">
            <tr>
                <td>${s.showId}</td>
                <td>
                    <c:forEach var="tm" items="${publishedMovies}">
                        <c:if test="${tm.theaterMovieId == s.theaterMovieId}">
                            <c:forEach var="m" items="${globalMovies}">
                                <c:if test="${m.movieId == tm.movieId}">${m.title}</c:if>
                            </c:forEach>
                        </c:if>
                    </c:forEach>
                </td>
              <td>
    <c:forEach var="scr" items="${screens}">
        <c:if test="${scr.screenId == s.screenId}">
            ${scr.name}
        </c:if>
    </c:forEach>
</td>
                <td>${s.showTime}</td>
                
                <td>${s.price}</td>
                <td>
                    <button type="button" class="update-btn" onclick="openUpdateShowModal('${s.showId}', '${s.showTime}', ${s.price})">Update</button>
                    <form action="DeleteShowServlet" method="post" style="display:inline-block;">
                        <input type="hidden" name="showId" value="${s.showId}" />
                        <button type="submit" class="delete-btn" onclick="return confirm('Are you sure you want to delete this show? This action cannot be undone.')" style="background:red; color:white; padding:5px 10px; border:none; border-radius:4px; cursor:pointer;">Delete</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>

<!-- Update Show Modal -->
<div id="updateShowModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal('updateShowModal')">&times;</span>
        <h3 style="color:gold;">Update Show</h3>
        <form action="UpdateShowServlet" method="post" onsubmit="return validateShowUpdate()" style="display: grid; grid-template-columns: auto 1fr; gap: 12px; align-items: center;">
            <input type="hidden" name="showId" id="updateShowId">
            <label style="text-align: right;">Show Time:</label>
            <input type="datetime-local" name="showTime" id="updateShowTime" required style="padding: 8px; border-radius: 4px; background: #2a2a2a; color: white; border: 1px solid #444;">
            <label style="text-align: right;">Ticket Price:</label>
            <input type="number" step="0.01" name="price" id="updateShowPrice" required min="0" style="padding: 8px; border-radius: 4px; background: #2a2a2a; color: white; border: 1px solid #444;">
            <div style="grid-column: 1 / span 2; display: flex; justify-content: center; gap: 10px; margin-top: 15px;">
                <button type="submit" style="background: #4CAF50; margin-right: 10px; padding: 10px 20px;">Confirm</button>
                <button type="button" onclick="closeModal('updateShowModal')" style="background: #666; padding: 10px 20px;">Cancel</button>
            </div>
        </form>
    </div>
</div>

<!-- Update Theater Modal -->
<div id="updateTheaterModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal('updateTheaterModal')">&times;</span>
        <h3 style="color:gold;">Update Theater</h3>
        <form action="EditTheaterServlet" method="post" onsubmit="return validateTheaterUpdate()" style="display: grid; grid-template-columns: auto 1fr; gap: 12px; align-items: center;">
            <input type="hidden" name="theaterId" id="updateTheaterId">
            <label style="text-align: right;">Theater Name:</label>
            <input type="text" name="name" id="updateTheaterName" required style="padding: 8px; border-radius: 4px; background: #2a2a2a; color: white; border: 1px solid #444;">
            <label style="text-align: right;">Location:</label>
            <input type="text" name="location" id="updateTheaterLocation" required style="padding: 8px; border-radius: 4px; background: #2a2a2a; color: white; border: 1px solid #444;">
            <div style="grid-column: 1 / span 2; display: flex; justify-content: center; gap: 10px; margin-top: 15px;">
                <button type="submit" style="background: #4CAF50; margin-right: 10px; padding: 10px 20px;">Confirm</button>
                <button type="button" onclick="closeModal('updateTheaterModal')" style="background: #666; padding: 10px 20px;">Cancel</button>
            </div>
        </form>
    </div>
</div>

<!-- Schedule Modal -->
<div id="scheduleModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal('scheduleModal')">&times;</span>
        <h3 style="color:gold;">Schedule Show</h3>
        <form action="AddShowServlet" method="post" onsubmit="return validateSchedule()" style="display: grid; grid-template-columns: auto 1fr; gap: 12px; align-items: center;">
            <label style="text-align: right;">Select Published Movie:</label>
            <select name="theaterMovieId" id="publishedMovieSelect" onchange="setTheaterAndScreens()" required style="padding: 8px; border-radius: 4px; background: #2a2a2a; color: white; border: 1px solid #444;">
                <option value="">Select Movie</option>
                <c:forEach var="tm" items="${publishedMovies}">
                    <option value="${tm.theaterMovieId}" data-theater="${tm.theaterId}">
                        <c:forEach var="m" items="${globalMovies}">
                            <c:if test="${m.movieId == tm.movieId}">${m.title}</c:if>
                        </c:forEach> - 
                        <c:forEach var="t" items="${theaters}">
                            <c:if test="${t.theaterId == tm.theaterId}">${t.name}</c:if>
                        </c:forEach>
                    </option>
                </c:forEach>
            </select>
            <label style="text-align: right;">Theater:</label>
            <input type="text" id="selectedTheater" readonly style="padding: 8px; border-radius: 4px; background: #2a2a2a; color: white; border: 1px solid #444;">
            <label style="text-align: right;">Select Screen:</label>
            <select name="screenId" id="screenSelect" required style="padding: 8px; border-radius: 4px; background: #2a2a2a; color: white; border: 1px solid #444;"></select>
            <label style="text-align: right;">Show Time:</label>
            <input type="datetime-local" name="showTime" id="showTime" required style="padding: 8px; border-radius: 4px; background: #2a2a2a; color: white; border: 1px solid #444;">
            <label style="text-align: right;">Ticket Price:</label>
            <input type="number" step="0.01" name="price" required style="padding: 8px; border-radius: 4px; background: #2a2a2a; color: white; border: 1px solid #444;">
            <div style="grid-column: 1 / span 2; display: flex; justify-content: center;">
                <button type="submit" style="padding: 10px 20px;">Schedule</button>
            </div>
        </form>
    </div>
</div>

<!-- TAB 5: View Bookings -->
<!-- TAB 5: View Bookings -->
<div class="tab-content">
    <h2>View Bookings</h2>
   <table>
    <thead>
        <tr>
            <th>Booking ID</th>
            <th>Customer</th>
            <th>Movie</th>
            <th>Theater</th>
            <th>Screen</th>
            <th>Show Time</th>
            <th>Booking Date</th>
            <th>Seats</th>
            <th>Amount</th>
            <th>Status</th>
        </tr>
    </thead>
    <tbody>
    <c:forEach var="b" items="${bookings}">
        <tr>
            <td>${b.bookingId}</td>
            <td>${b.customerName}</td>
            <td>${b.movieTitle}</td>
            <td>${b.theaterName}</td>
            <td>${b.screenName}</td>
            <td><fmt:formatDate value="${b.showTime}" pattern="dd-MM-yyyy HH:mm"/></td>
            <td><fmt:formatDate value="${b.bookingDate}" pattern="dd-MM-yyyy HH:mm"/></td>

            <!-- Show seats as badges -->
            <td>
                <c:forEach var="seat" items="${b.seatList}">
                    <span class="seat-badge">${seat}</span>
                </c:forEach>
            </td>

            <td>${b.amount}</td>
            <td>${b.paymentStatus}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
   
   </div>


<script>

//Show alert for success/error messages
window.onload = function() {
    <c:if test="${not empty param.success}">
        showToast("${param.success}");
        // Remove the success parameter from URL without refreshing
        if (window.history.replaceState) {
            const url = new URL(window.location);
            url.searchParams.delete('success');
            window.history.replaceState({}, '', url);
        }
    </c:if>
    
    <c:if test="${not empty param.error}">
        showToast("${param.error}", true);
        // Remove the error parameter from URL without refreshing
        if (window.history.replaceState) {
            const url = new URL(window.location);
            url.searchParams.delete('error');
            window.history.replaceState({}, '', url);
        }
    </c:if>
};

function showToast(message, isError = false) {
    const toast = document.getElementById("toast");
    const toastMessage = document.getElementById("toastMessage");
    
    toastMessage.textContent = message;
    toast.className = isError ? "toast error" : "toast";
    toast.classList.add("show");
    
    setTimeout(() => {
        toast.classList.remove("show");
    }, 3000);
}
function openTab(index) {
    document.querySelectorAll('.tab').forEach((t, i) => {
        t.classList.toggle('active', i === index);
        document.querySelectorAll('.tab-content')[i].classList.toggle('active', i === index);
    });
    sessionStorage.setItem("activeTab", index); // save selected tab index
}
    function openModal(id) { document.getElementById(id).style.display = "flex"; }
    function closeModal(id) { document.getElementById(id).style.display = "none"; }
    function openPublishModal(movieId) {
        document.getElementById("modalMovieId").value = movieId;
        openModal('publishModal');
    }
    function setTheaterAndScreens() {
        let theaterId = document.querySelector("#publishedMovieSelect option:checked").getAttribute("data-theater");
        let theaterName = "";
        <c:forEach var="t" items="${theaters}">
            if ("${t.theaterId}" == theaterId) theaterName = "${t.name}";
        </c:forEach>
        document.getElementById("selectedTheater").value = theaterName;
        let screenSelect = document.getElementById("screenSelect");
        screenSelect.innerHTML = '<option value="">Select Screen</option>';
        <c:forEach var="s" items="${screens}">
            if ("${s.theaterId}" == theaterId) {
                let opt = document.createElement("option");
                opt.value = "${s.screenId}";
                opt.textContent = "${s.name}";
                screenSelect.appendChild(opt);
            }
        </c:forEach>
    }
    function validateSchedule() {
        let screenId = document.getElementById("screenSelect").value;
        let showTime = document.getElementById("showTime").value;
        let shows = [
            <c:forEach var="s" items="${shows}" varStatus="loop">
                { screenId: "${s.screenId}", showTime: "${s.showTime}" }<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
        ];
        for (let show of shows) {
            if (show.screenId === screenId && show.showTime === showTime) {
                alert("This screen already has a show at this time!");
                return false;
            }
        }
        return true;
    }

    function openUpdateTheaterModal(theaterId, currentName, currentLocation) {
        document.getElementById('updateTheaterId').value = theaterId;
        document.getElementById('updateTheaterName').value = currentName;
        document.getElementById('updateTheaterLocation').value = currentLocation;
        
        // Store original values for comparison
        document.getElementById('updateTheaterName').setAttribute('data-original', currentName);
        document.getElementById('updateTheaterLocation').setAttribute('data-original', currentLocation);
        
        openModal('updateTheaterModal');
    }

    function validateTheaterUpdate() {
        const nameInput = document.getElementById('updateTheaterName');
        const locationInput = document.getElementById('updateTheaterLocation');
        
        const originalName = nameInput.getAttribute('data-original');
        const originalLocation = locationInput.getAttribute('data-original');
        
        const newName = nameInput.value.trim();
        const newLocation = locationInput.value.trim();
        
        if (newName === originalName && newLocation === originalLocation) {
            alert('Current details and updated details are matching. No changes detected.');
            return false;
        }
        
        return true;
    }

    function openUpdateShowModal(showId, showTime, price) {
        document.getElementById('updateShowId').value = showId;
        document.getElementById('updateShowTime').value = showTime.replace(' ', 'T');
        document.getElementById('updateShowPrice').value = price;
        
        // Store original values for validation
        document.getElementById('updateShowTime').setAttribute('data-original-time', showTime.replace(' ', 'T'));
        document.getElementById('updateShowPrice').setAttribute('data-original-price', price);
        
        openModal('updateShowModal');
    }

    function validateShowUpdate() {
        const newTime = document.getElementById('updateShowTime').value;
        const newPrice = document.getElementById('updateShowPrice').value;
        const originalTime = document.getElementById('updateShowTime').getAttribute('data-original-time');
        const originalPrice = document.getElementById('updateShowPrice').getAttribute('data-original-price');
        
        if (newTime === originalTime && parseFloat(newPrice) === parseFloat(originalPrice)) {
            alert('Current details and updated details are matching. No changes made.');
            return false;
        }
        return true;
    }
    function toggleMenu() {
        const tabs = document.getElementById('tabs');
        const hamburger = document.querySelector('.hamburger');
        const logo = document.getElementById('logo');
        tabs.classList.toggle('show');
        hamburger.classList.toggle('active');
        logo.classList.toggle('hidden');
    }

    function openModal(modalId) {
        document.getElementById(modalId).style.display = 'flex';
    }

    function closeModal(modalId) {
            document.getElementById(modalId).style.display = 'none';
        }

        // Movie search functionality
        function initializeMovieSearch() {
            const searchInput = document.getElementById('movieSearch');
            const moviesGrid = document.getElementById('moviesGrid');
            const noMoviesFound = document.getElementById('noMoviesFound');
            
            if (!searchInput || !moviesGrid) return;
            
            searchInput.addEventListener('input', function() {
                const searchTerm = this.value.toLowerCase().trim();
                const movieCards = moviesGrid.querySelectorAll('.movie-card');
                let visibleMovies = 0;
                
                movieCards.forEach(card => {
                    const title = card.getAttribute('data-title');
                    
                    if (searchTerm === '' || title.includes(searchTerm)) {
                        card.style.display = 'block';
                        visibleMovies++;
                    } else {
                        card.style.display = 'none';
                    }
                });
                
                // Show/hide "no movies found" message
                if (visibleMovies === 0 && searchTerm !== '') {
                    noMoviesFound.style.display = 'block';
                } else {
                    noMoviesFound.style.display = 'none';
                }
            });
        }
        
        // Initialize search when page loads
        document.addEventListener('DOMContentLoaded', function() {
            initializeMovieSearch();
        });

    window.onclick = function(event) {
        if (event.target.classList.contains('modal')) {
            event.target.style.display = 'none';
        }
    }
    
 // Restore last opened tab after reload
    document.addEventListener("DOMContentLoaded", function () {
        let activeTab = sessionStorage.getItem("activeTab") || 0;
        openTab(parseInt(activeTab));
    });
</script>
<script>
    document.getElementById("logoutProfile").addEventListener("click", function() {
        window.location.href = "LogoutServlet";
    });
</script>

</body>
</html>