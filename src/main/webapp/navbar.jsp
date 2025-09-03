<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
*{
padding:0px;margin:0px}

   
    .navbar {
        background: black;
        margin: 0px;   /* remove extra gap */
        padding: 15px 40px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        color: #fff;
    }
    .navbar .logo {
        font-size: 22px;
        font-weight: bold;
        color: #ffcc00;
        text-decoration: none;
    }
    .navbar ul {
        list-style: none;
        display: flex;
        gap: 20px;
        margin: 0;
        padding: 0;
    }
    .navbar ul li {
        display: inline;
    }
    .navbar ul li a {
        text-decoration: none;
        color: #fff;
        font-size: 16px;
    }
    .navbar ul li a:hover {
        color: #ff6600;
    }
    img{
    height: 75px;
    }
</style>

<div class="navbar">
    <a href="HomeServlet" class="logo"><img alt="" src="images/V1.png"></a>
    <ul>
        <li><a href="HomeServlet">Home</a></li>
        <li><a href="MoviesServlet">Movies</a></li>
        <li><a href="BookingsServlet">My Bookings</a></li>
        <li><a href="ContactUs.jsp">Contact</a></li>
        <li><a href="LogoutServlet">Logout</a></li>
    </ul>
</div>
