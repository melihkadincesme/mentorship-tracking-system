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
	<title>Mentee Message Confirm</title>
	<link rel="stylesheet" href="about.css">	
	
	</head>
	<body>
	<%
	try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		Statement stmt1 = con.createStatement();

		int taskID = Integer.parseInt(request.getParameter("taskID2"));
		String mentee_name = request.getParameter("mentee_name2");
		String title = request.getParameter("title2");
		String message1 = request.getParameter("message");
		
		String new_message = "INSERT INTO task_message(taskID, full_name, message) VALUES (?, ?, ?)";
		PreparedStatement ps_val = con.prepareStatement(new_message);
		
		ps_val.setInt(1, taskID);
		ps_val.setString(2, mentee_name);
		ps_val.setString(3, message1);
		
		ps_val.executeUpdate();
		
		ResultSet rs_mentor_name, rs_mentor_email;
		rs_mentor_name = stmt.executeQuery("SELECT mentor_name FROM task_unique WHERE taskID=" + taskID);
		rs_mentor_name.next();
		String mentor_name = rs_mentor_name.getString("mentor_name");
		
		rs_mentor_email = stmt1.executeQuery("SELECT email FROM mentor WHERE full_name='" + mentor_name + "';");
		rs_mentor_email.next();
		String mentor_email = rs_mentor_email.getString("email");
		
		Properties properties = new Properties();
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.starttls.enable", "true");
		properties.put("mail.smtp.host", "smtp.gmail.com");
		properties.put("mail.smtp.port", "587");
		
		String myEmail = "mentortrackingsystem@gmail.com";

		String myPassword = "Mentor4141";
		String subject = "New Message From " + mentee_name + " for " + title + " task.";
		boolean check = false;
		
			
				String recipient = mentor_email;
		
				String messageText = String.join(
				        System.getProperty("line.separator"),
				        "Dear " + mentor_name,
				        "",
				        "A new message has been sent to " + title + " task.",
				        "",
				        "From " + mentee_name,
				        "----------",
				        message1
				);
				Session session1 = Session.getInstance(properties, new Authenticator(){
					@Override
					protected PasswordAuthentication getPasswordAuthentication(){
						return new PasswordAuthentication("mentortrackingsystem@gmail.com", "Mentor4141");
					}
				});
		
					try{
						Message message = new MimeMessage(session1);
						message.setFrom(new InternetAddress(myEmail));
						message.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
						message.setSubject(subject);
						message.setText(messageText);
						Transport.send(message);
						if(check == false){	
							check = true;
						}
					}catch (MessagingException mex) { 
						   mex.printStackTrace(); 
						   out.println("Error: unable to connect...."); 
					}
					response.sendRedirect("mentee_task_communication.jsp?taskID=" + taskID + "&mentee_name=" + mentee_name + "&title=" + title);	

		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Failed to Display!");
	}
	%>
	</body>
</html>