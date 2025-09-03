package com.V5.controller.user;

import com.V5.dao.user.BookingDAO;
import com.V5.dto.BookingSummary;
import com.V5.util.EmailUtil;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int bookingId = Integer.parseInt(req.getParameter("bookingId"));
            String action = req.getParameter("action"); // "success" or "fail"

            // ✅ Fetch booking summary
            BookingSummary summary = BookingDAO.getBookingReceipt(bookingId);

            // ✅ Decide email to send to
            String userEmail = summary.getUserEmail();
            String guestEmail = summary.getGuestEmail();
            String toEmail = (userEmail != null && !userEmail.isEmpty()) ? userEmail : guestEmail;

            if ("success".equals(action)) {
                // ✅ Update payment status
                BookingDAO.updatePaymentStatus(bookingId, "completed");

                // ✅ Reload updated booking summary
                summary = BookingDAO.getBookingReceipt(bookingId);

                // ✅ Prepare and send confirmation email
                String subject = "Booking Confirmation - " + summary.getMovieTitle();
                String body = "<h2>Booking Confirmed ✅</h2>"
                        + "<p>Hi " + summary.getCustomerName() + ",</p>"
                        + "<p>Your booking has been confirmed successfully.</p>"
                        + "<p><b>Movie:</b> " + summary.getMovieTitle() + "</p>"
                        + "<p><b>Theater:</b> " + summary.getTheaterName() + "</p>"
                        + "<p><b>Screen:</b> " + summary.getScreenName() + "</p>"
                        + "<p><b>Show Time:</b> " + summary.getShowTime() + "</p>"
                        + "<p><b>Seats:</b> " + summary.getSeatNumbers() + "</p>"
                        + "<p><b>Total Paid:</b> ₹" + summary.getAmount() + "</p>"
                        + "<br><p>This ticket was sent to: <b>" + toEmail + "</b></p>"
                        + "<br><p>Enjoy your movie 🎬</p>";

                try {
                    EmailUtil.sendEmailWithPdf(toEmail, subject, body, summary);
                } catch (Exception e) {
                    e.printStackTrace();
                }

            } else { 
                // ❌ Failure case
                BookingDAO.updatePaymentStatus(bookingId, "failed");

                // ✅ Reload updated booking summary
                summary = BookingDAO.getBookingReceipt(bookingId);

                // ✅ Prepare failure email
                String subject = "Booking Failed ❌";
                String body = "<h2>Payment Failed</h2>"
                        + "<p>Hi " + summary.getCustomerName() + ",</p>"
                        + "<p>Unfortunately, your payment could not be processed.</p>"
                        + "<p>Please try booking again.</p>";

                try {
                    EmailUtil.sendEmailWithPdf(toEmail, subject, body, summary);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            // ✅ Forward to single BookingReceipt.jsp (with updated status)
            req.setAttribute("receipt", summary);
            RequestDispatcher rd = req.getRequestDispatcher("Bookingreciept.jsp");
            rd.forward(req, resp);

        } catch (Exception e) {
            throw new ServletException("Payment process failed", e);
        }
    }
}
