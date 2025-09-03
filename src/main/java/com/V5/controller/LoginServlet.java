package com.V5.controller;

import java.io.IOException;

import com.V5.dao.UserDAO;
import com.V5.dto.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            User user = UserDAO.loginUser(email, password);

            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);

                // Role-based redirection
                switch (user.getRole().toLowerCase()) {
                    case "super_admin":
                        response.sendRedirect("SuperAdminDashboard");
                        break;
                    case "admin":
                        response.sendRedirect("AdminDashboard");
                        break;
                    case "pending_admin":
                        response.sendRedirect("pendingApproval.jsp");
                        break;
                    case "customer":
                        response.sendRedirect("HomeServlet");
                        break;
                    default:
                        response.sendRedirect("Login.jsp?error=Unknown+role");
                        break;
                }
            } else {
                response.sendRedirect("login.jsp?error=Invalid+email+or+password");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=Something+went+wrong");
        }
    }
}
