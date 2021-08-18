<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.tracking.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "java.io.*,java.util.*,javax.mail.*"%>
<%@ page import = "javax.mail.internet.*,javax.activation.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Contact Confirm</title>
	<link rel="stylesheet" href="about.css">
	<style>
	p{
		font-family: "Times New Roman", Times, serif;
		color: white;
		text-align: center;	
		font-size: 20px;
	}
	</style>
	</head>
	<body>
	<header>
		<a class="logo" href="index.jsp"><img src="logo-whitetulip-health.png" alt="logo" width="300" height="100"></a>
            <nav>
                <ul class="nav__links">
                    <li><a href="index.jsp">Login</a></li>
                    <li><a href="about.jsp">About</a></li>
                </ul>
            </nav>
            <a class="cta" href="contact.jsp">Contact</a>		
	</header>
	<%
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			//Create a SQL statement
			Statement stmt = con.createStatement();
	
			String fullname = request.getParameter("firstName");
			String customer_email = request.getParameter("email");
			String text = request.getParameter("massage");
			
			Properties properties = new Properties();
			properties.put("mail.smtp.auth", "true");
			properties.put("mail.smtp.starttls.enable", "true");
			properties.put("mail.smtp.host", "smtp.gmail.com");
			properties.put("mail.smtp.port", "587");
			
			//String myEmail = "mentortrackingsystem@gmail.com";
			String myEmail = "contactmentortracking@gmail.com";

			String myPassword = "Testcontact41";
			String recipient = "mentortrackingsystem@gmail.com";
			String subject = "Mentor-Mentee Tracking System Customer Inquiry";
			//String messageText = "Dear " + mentee_name + ", Your mentor is " + mentor_name + ". Please login using these infomrations. username: " + mentee_username + "password: " + mentee_password;
			
			String messageText = String.join(
			        System.getProperty("line.separator"),
			        "Dear admin",
			        "",
			        "Customer inquiry for " + fullname + " with " + customer_email + " address.",
			        "",
			        "-------------------------",
			        "",
			        text
			);
			
			Session session1 = Session.getInstance(properties, new Authenticator(){
				@Override
				protected PasswordAuthentication getPasswordAuthentication(){
					return new PasswordAuthentication("contactmentortracking@gmail.com", "Testcontact41");
				}
			});
	
				try{
					Message message = new MimeMessage(session1);
					message.setFrom(new InternetAddress(myEmail));
					message.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
					message.setSubject(subject);
					message.setText(messageText);
					Transport.send(message);
					out.print("<p>Successfully sent an email to customer representative. Please wait for 1-2 business days to hear back.</p>");
				}catch (MessagingException mex) { 
					   mex.printStackTrace(); 
					   out.println("<p>Error: unable to connect....</p>"); 
				}
			
		} catch (Exception ex) {
			out.print(ex);
			out.print("Failed to Display!");
		}
	%>
</body>
</html>