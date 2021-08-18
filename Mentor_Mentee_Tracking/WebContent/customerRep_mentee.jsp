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
	<title>Customer Rep and Mentee Communication</title>
	<link rel="stylesheet" href="about.css">
	</head>
	<style>
	p{
		font-family: "Times New Roman", Times, serif;
		color: white;
		text-align: center;	
		font-size: 20px;
	}
	</style>
	<body>
	<header>
		<a class="logo" href="mentee_main.jsp"><img src="logo-whitetulip-health.png" alt="logo" width="300" height="100"></a>
            <nav>
                <ul class="nav__links">
                    <li><a href="mentee_main.jsp">Dashboard</a></li>
                    <li><a href="see_mentee_tasks.jsp">Assigned Tasks</a></li>
                    <li><a href="communicationMentee.jsp">Communication</a></li>
                    <li><a href="mentee_time_tracking.jsp">Time Tracking</a></li>
                </ul>
            </nav>
            <a class="cta" href="logout.jsp">Logout</a>		
	</header>
	<%
		try{
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			//Create a SQL statement
			Statement stmt = con.createStatement();
		
			String mentee_name = request.getParameter("mentee_name1");
			String mentee_email = request.getParameter("mentee_email1");
			String text = request.getParameter("massage");

			Properties properties = new Properties();
			properties.put("mail.smtp.auth", "true");
			properties.put("mail.smtp.starttls.enable", "true");
			properties.put("mail.smtp.host", "smtp.gmail.com");
			properties.put("mail.smtp.port", "587");
			
			String myEmail = "contactmentortracking@gmail.com";

			String myPassword = "Testcontact41";
			String recipient = "mentortrackingsystem@gmail.com";
			String subject = "User " + mentee_name + " Customer Rep Inquiry";
			//String messageText = "Dear " + mentee_name + ", Your mentor is " + mentor_name + ". Please login using these infomrations. username: " + mentee_username + "password: " + mentee_password;
			
			String messageText = String.join(
			        System.getProperty("line.separator"),
			        "Dear admin",
			        "",
			        "Customer inquiry for " + mentee_name + " with " + mentee_email + " address.",
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
				
		}catch (Exception ex) {
			out.print(ex);
			out.print("Failed to Display!");
		}
	%>
	</body>
</html>