# V5 Cinemas 🎬

A full-stack Java web application for online movie ticket booking.
This project is built using JSP, Servlets, JDBC, MySQL, HTML, CSS, Bootstrap, and follows an MVC pattern with DAO and DTO layers.

---

## 🚀 Features

* Authentication & Roles

  * User registration & login with session management
    
  * Role-based access:
    * Super Admin → Manage movies globally
    * Admin → Manage theaters, screens, and shows
    * Customer → Browse movies, book tickets, make payments
      
* Movie Management
  * Add, edit, delete movies
  * Global publishing of movies by Super Admin
    
* Theater & Show Management
  * Admins can add theaters and screens
  * Manage shows linked to movies and theaters
    
* Booking System
  * Customers can select shows, choose seats, and book tickets
  * Seat availability tracked in real-time
    
* Payments
  * Integrated payments table for tracking
    
* Ratings & Feedback
  * Customers can rate movies and provide feedback
    
* Responsive UI
  * Common Navbar & Footer included on all pages
  * Carousel on homepage
  * Mobile-friendly with Bootstrap

---

## 🛠 Tech Stack
* Frontend: JSP, HTML5, CSS3, Bootstrap 5
* Backend: Java Servlets (Jakarta EE)
* Database: MySQL
* Architecture: MVC with DAO & DTO layers
* Server: Apache Tomcat

---

## 📂 Project Structure

### Controllers (Servlets)
* HomeServlet.java
* LoginServlet.java
* LogoutServlet.java
* RegisterServlet.java
* BookingServlet.java
* PaymentServlet.java
* MovieDetailsServlet.java
* SubmitRatingServlet.java
* ViewSeatsServlet.java
* UserSeatBookingServlet.java
* TheaterSelectionServlet.java
* TheaterListServlet.java
* AddMovieServlet.java
* DeleteMovieServlet.java
* PublishMoviesServlet.java
* AddTheaterServlet.java
* EditTheaterServlet.java
* DeleteTheaterServlet.java
* AddScreenServlet.java
* EditScreenServlet.java
* DeleteScreenServlet.java
* AddShowServlet.java
* UpdateShowServlet.java
* DeleteShowServlet.java
* UnlinkMovieServlet.java
* AdminDashboardServlet.java
* SuperAdminDashboardServlet.java
* ApproveRejectAdminServlet.java

### DAO Layer
* UserDAO.java
* MovieDAO.java
* TheaterDAO.java
* ScreenDAO.java
* ShowDAO.java
* BookingDAO.java
* PaymentDAO.java
* RatingDAO.java

### DTO Layer
* User.java
* Movie.java
* Theater.java
* Screen.java
* Show.java
* Booking.java
* Payment.java
* Rating.java

### Frontend (JSP Pages)
* index.jsp (Homepage)
* login.jsp
* register.jsp
* movies.jsp
* movieDetails.jsp
* bookings.jsp
* payment.jsp
* ratings.jsp
* contactUs.jsp
* adminDashboard.jsp
* superAdminDashboard.jsp
* addTheater.jsp
* editTheater.jsp
* addShow.jsp
* editShow.jsp
* viewSeats.jsp

---

## 🗄 Database Schema

### Tables
* users (user\_id, name, email, password, role, status)
* theaters (theater\_id, name, location, admin\_id)
* screens (screen\_id, theater\_id, name, capacity)
* movies (movie\_id, title, description, duration, poster\_url)
* theater_movies (id, theater\_id, movie\_id)
* shows (show\_id, theater\_movie\_id, screen\_id, show\_time, price)
* seats (seat\_id, screen\_id, seat\_number)
* show_seats (id, show\_id, seat\_id, status)
* bookings (booking\_id, user\_id, show\_id, booking\_date, total\_amount)
* booking_seats (id, booking\_id, seat\_id)
* payments (payment\_id, booking\_id, amount, status, payment\_date)
* ratings (rating\_id, movie\_id, user\_id, stars, feedback, created\_at)

Relations:
* One user → many bookings
* One theater → many screens → many shows
* One movie → many theater_movies → many shows
* One show → many show_seats and bookings
* One booking → one payment

---

## ⚙ Setup Instructions

1. Clone/Extract Project

   bash
   git clone <repo-url>
   
   or extract v5Final.Zip.

2. Import into IDE
   * Open Eclipse/STS/IntelliJ
   * Import as Dynamic Web Project or Maven Project (if pom.xml exists)

3. Configure Database
   * Create a MySQL database:

     sql
     CREATE DATABASE v5cinemas;
     
   * Run the provided SQL schema file to create tables.
   * Update ConnectionClass.java with your DB credentials.

4. Deploy on Tomcat
   * Add project to Tomcat server
   * Start server
   * Access at:

     
     http://localhost:8080/V5Cinemas/
     
---

## ▶ How to Run

* Register a new user (default role = customer)
* Super Admin can log in → Manage movies
* Admin can log in → Manage theaters, screens, and shows
* Customer can log in → Browse movies, select shows, book tickets
* Complete payment → Ticket confirmed
* Provide rating/feedback after watching

---

## 🔮 Future Enhancements

* Add online payment gateway (Stripe/PayPal integration)
* Email notifications for bookings
* Mobile app (React Native/Flutter) with same backend
* Recommendation system for movies
* Admin analytics dashboard with charts

---

📌 Author: Vaishnavi Vaman Sirsat
📌 Project: V5 Cinemas

---

---
---

© 2025 Vaishnavi Vaman Sirsat. All rights reserved.  
This project is created and maintained by Tirumal Naik. Unauthorized copying, modification, or distribution is prohibited without permission.

© 2025 Vignesh V J. All rights reserved.  
This project is created and maintained by Vignesh V J. Unauthorized copying, modification, or distribution is prohibited without permission.
