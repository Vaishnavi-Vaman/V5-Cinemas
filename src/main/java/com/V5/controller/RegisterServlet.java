
package com.V5.controller;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

import com.V5.dao.UserDAO;
import com.V5.dto.User;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String roleChoice = request.getParameter("role");
        String licenseUrl = request.getParameter("licenseUrl");

        String finalRole = "customer";
        if ("admin".equals(roleChoice)) {
            finalRole = "pending_admin";
            if (licenseUrl == null || licenseUrl.trim().isEmpty()) {
                response.sendRedirect("register.jsp?error=Please+provide+cinema+license+URL");
                return;
            }
        }

        // No password hashing - store directly
        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole(finalRole);
        user.setLicensePath(licenseUrl);

        try {
            int result = UserDAO.registerUser(user);
            if (result > 0) {
                if ("pending_admin".equals(finalRole)) {
                    response.sendRedirect("Login.jsp?msg=Admin+request+submitted+for+approval");
                } else {
                    response.sendRedirect("Login.jsp?msg=Registration+successful");
                }
            } else if (result == -2) {
                response.sendRedirect("Register.jsp?error=Email+already+exists");
            } else {
                response.sendRedirect("Register.jsp?error=Registration+failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Register.jsp?error=Server+error");
        }
    }
}
