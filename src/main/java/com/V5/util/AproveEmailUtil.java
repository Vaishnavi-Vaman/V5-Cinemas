package com.V5.util;



	import jakarta.mail.*;
	import jakarta.mail.internet.*;
	import java.util.Properties;
	import java.io.*;
	import jakarta.mail.PasswordAuthentication;

	
	public class AproveEmailUtil { 

		// Paste this inside EmailUtil class (in addition to your existing method)
		public static void sendApprovalEmail(String toEmail, String action, File pdfFile) {
		    final String fromEmail = "vjvignesh276@gmail.com";   // same as your existing method
		    final String password  = "myph ubxw sgbh vbtm";      // same app password

		    Properties props = new Properties();
		    props.put("mail.smtp.host", "smtp.gmail.com");
		    props.put("mail.smtp.port", "587");
		    props.put("mail.smtp.auth", "true");
		    props.put("mail.smtp.starttls.enable", "true");

		    Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
		        protected PasswordAuthentication getPasswordAuthentication() {
		            return new PasswordAuthentication(fromEmail, password);
		        }
		    });

		    try {
		        Message message = new MimeMessage(session);
		        message.setFrom(new InternetAddress(fromEmail));
		        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
		        message.setSubject("V5 Cinemas - Request " + action);

		        // Body
		        MimeBodyPart textPart = new MimeBodyPart();
		        String emailBody = "Dear Candidate,\n\n" +
		                   "We would like to inform you that your request for admin access at V5 Cinemas has been " 
		                   + action.toUpperCase() + ".\n\n" +
		                   "Please find the attached PDF containing further details regarding your request.\n\n" +
		                   "For any additional information or clarification, feel free to reach out to us at: vjvignesh276@gmail.com\n\n" +
		                   "Best Regards,\n" +
		                   "V5 Cinemas Team";

		textPart.setText(emailBody);


		        // Attachment (use the PDF created in the servlet)
		        MimeBodyPart attachmentPart = new MimeBodyPart();
		        attachmentPart.attachFile(pdfFile);
		        attachmentPart.setFileName("V5-" + action.toUpperCase() + ".pdf");

		        Multipart multipart = new MimeMultipart();
		        multipart.addBodyPart(textPart);
		        multipart.addBodyPart(attachmentPart);

		        message.setContent(multipart);

		        Transport.send(message);
		        System.out.println("✅ Mail sent successfully to " + toEmail);
		    } catch (MessagingException | IOException e) {
		        System.out.println("❌ Mail sending failed: " + e.getMessage());
		        e.printStackTrace();
		    }
		}

	}


