package com.V5.util;

import com.V5.dto.BookingSummary;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;

import jakarta.mail.*;
import jakarta.mail.internet.*;

import java.io.*;
import java.util.Properties;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.apache.pdfbox.pdmodel.graphics.image.PDImageXObject;

public class EmailUtil {

    public static void sendEmailWithPdf(String toEmail, String subject, String body, BookingSummary summary) throws Exception {
        // ✅ 1. Setup Mail Server
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                // ⚠️ Replace with your Gmail + App Password
                return new PasswordAuthentication("vjvignesh276@gmail.com", "myph ubxw sgbh vbtm");
            }
        });

        // ✅ 2. Generate PDF
        File pdfFile = generatePdfTicket(summary);

        // ✅ 3. Create Email with Attachment
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress("vjvignesh276@gmail.com"));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject(subject);

        // Body Part (HTML)
        MimeBodyPart messageBodyPart = new MimeBodyPart();
        messageBodyPart.setContent(body, "text/html; charset=utf-8");

        // Attachment Part
        MimeBodyPart attachmentPart = new MimeBodyPart();
        attachmentPart.attachFile(pdfFile);

        Multipart multipart = new MimeMultipart();
        multipart.addBodyPart(messageBodyPart);
        multipart.addBodyPart(attachmentPart);

        message.setContent(multipart);

        // ✅ 4. Send
        Transport.send(message);

        // cleanup temp file
        pdfFile.delete();
    }

    private static File generatePdfTicket(BookingSummary summary) throws IOException, WriterException {
        File pdfFile = File.createTempFile("ticket_", ".pdf");

        try (PDDocument document = new PDDocument()) {
            PDPage page = new PDPage(PDRectangle.A6);
            document.addPage(page);

            PDPageContentStream contentStream = new PDPageContentStream(document, page);

            // 🎨 Watermark
            contentStream.saveGraphicsState();
            contentStream.setNonStrokingColor(230, 230, 230);
            contentStream.beginText();
            contentStream.setFont(PDType1Font.HELVETICA_BOLD, 36);
            contentStream.setTextMatrix((float) Math.cos(Math.toRadians(45)), (float) Math.sin(Math.toRadians(45)),
                    (float) -Math.sin(Math.toRadians(45)), (float) Math.cos(Math.toRadians(45)),
                    60, 150);
            contentStream.showText("V5 CINEMAS");
            contentStream.endText();
            contentStream.restoreGraphicsState();

            // 🎟 Border
            contentStream.setLineWidth(1.2f);
            contentStream.addRect(20, 20, page.getMediaBox().getWidth() - 40, page.getMediaBox().getHeight() - 40);
            contentStream.stroke();

            // 🎬 Title
            contentStream.beginText();
            contentStream.setFont(PDType1Font.HELVETICA_BOLD, 18);
            float titleWidth = PDType1Font.HELVETICA_BOLD.getStringWidth(" V5 CINEMAS ") / 1000 * 18;
            float titleX = (page.getMediaBox().getWidth() - titleWidth) / 2;
            contentStream.newLineAtOffset(titleX, 400);
            contentStream.showText(" V5 CINEMAS ");
            contentStream.endText();

            // Divider line under title
            contentStream.moveTo(30, 390);
            contentStream.lineTo(page.getMediaBox().getWidth() - 30, 390);
            contentStream.stroke();

            // 🎟 Ticket details
            float y = 360;
            float leftX = 40;

            y = addText(contentStream, "Movie: ", summary.getMovieTitle(), leftX, y);
            y = addText(contentStream, "Theater: ", summary.getTheaterName(), leftX, y);
            y = addText(contentStream, "Screen: ", summary.getScreenName(), leftX, y);
            java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd MMM yyyy, hh:mm a");
            String formattedShowTime = summary.getShowTime() != null
                    ? sdf.format(summary.getShowTime())
                    : "";
            y = addText(contentStream, "Show Time: ", formattedShowTime, leftX, y);
            y = addText(contentStream, "Seats: ", summary.getSeatNumbers(), leftX, y);
            y = addText(contentStream, "Paid: ", "Rs. " + summary.getAmount(), leftX, y);

            // 🎟 QR Code
            String qrData = "Booking ID: " + summary.getBookingId()
                    + "\nMovie: " + summary.getMovieTitle()
                    + "\nTheater: " + summary.getTheaterName()
                    + "\nSeats: " + summary.getSeatNumbers();

            QRCodeWriter qrCodeWriter = new QRCodeWriter();
            BitMatrix bitMatrix = qrCodeWriter.encode(qrData, BarcodeFormat.QR_CODE, 100, 100);

            File qrFile = File.createTempFile("qr_", ".png");
            MatrixToImageWriter.writeToPath(bitMatrix, "PNG", qrFile.toPath());

            PDImageXObject pdImage = PDImageXObject.createFromFile(qrFile.getAbsolutePath(), document);
            contentStream.drawImage(pdImage, 200, 230, 100, 100);

            qrFile.delete();

            // 🎟 Tear-line (dashed line for stub)
            contentStream.setLineDashPattern(new float[]{5, 3}, 0); // dash style
            contentStream.moveTo(30, 80);
            contentStream.lineTo(page.getMediaBox().getWidth() - 30, 80);
            contentStream.stroke();

            // Reset dash pattern
            contentStream.setLineDashPattern(new float[]{}, 0);

            // 🎟 Stub text
            contentStream.beginText();
            contentStream.setFont(PDType1Font.HELVETICA_OBLIQUE, 10);
            contentStream.newLineAtOffset(40, 60);
            contentStream.showText(" Keep this stub for entry ");
            contentStream.endText();

            contentStream.close();
            document.save(pdfFile);
        }
        return pdfFile;
    }

    private static float addText(PDPageContentStream contentStream, String label, String value, float x, float y) throws IOException {
        contentStream.beginText();
        contentStream.setFont(PDType1Font.HELVETICA_BOLD, 10);
        contentStream.newLineAtOffset(x, y);
        contentStream.showText(label);
        contentStream.setFont(PDType1Font.HELVETICA, 10);
        contentStream.showText(value != null ? value : "");
        contentStream.endText();
        return y - 20;
    }
 // Generic HTML email (for feedback)
    public static void sendEmail(String toEmail, String subject, String body) throws Exception {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                // ⚠️ Replace with your Gmail + App Password
                return new PasswordAuthentication("vjvignesh276@gmail.com", "");
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress("vjvignesh276@gmail.com"));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject(subject);
        message.setContent(body, "text/html; charset=utf-8");

        Transport.send(message);
    }

}
