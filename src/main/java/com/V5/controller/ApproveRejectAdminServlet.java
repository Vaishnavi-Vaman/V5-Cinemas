package com.V5.controller;

import com.V5.dao.UserDAO;
import com.V5.util.AproveEmailUtil;
import com.V5.util.EmailUtil;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.PdfWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

// 🔹 Added imports for PDF

import java.io.File;
import java.io.FileOutputStream;

@WebServlet("/ApproveRejectAdmin")
public class ApproveRejectAdminServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        int userId = Integer.parseInt(request.getParameter("userId"));
        String email = request.getParameter("email");
        System.out.println("[DEBUG] Preparing to send mail to " + email + " with action " + action);

        // 🔹 1. Create PDF in temp directory
        File pdfFile = File.createTempFile("approval_", ".pdf");
        try {
            Document document = new Document();
            PdfWriter.getInstance(document, new FileOutputStream(pdfFile));
            document.open();
            document.add(new Paragraph("V5 - CINEMAS"));
            document.add(new Paragraph(" "));
            document.add(new Paragraph("SUBJECT: Your request has been " + action.toUpperCase()));
            document.close();
            System.out.println("[DEBUG] PDF created at: " + pdfFile.getAbsolutePath());
        } catch (DocumentException e) {
            e.printStackTrace();
        }

        // 🔹 2. Send Email with PDF
        AproveEmailUtil.sendApprovalEmail(email, action, pdfFile);

        try {
            if ("approve".equals(action)) {
                UserDAO.updateUserRole(userId, "admin", false);
            } else if ("reject".equals(action)) {
                UserDAO.deleteUser(userId);  // ❌ remove from DB instead of converting
            }

            response.sendRedirect("SuperAdminDashboard");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?msg=Action+failed");
        }
    }
}