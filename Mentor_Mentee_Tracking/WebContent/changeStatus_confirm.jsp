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
	<title>Change Status Confirm</title>
	</head>
	<body>
	<%
		try{
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			//Create a SQL statement
			Statement stmt = con.createStatement();
			Statement stmt1 = con.createStatement();

			String category = request.getParameter("category11");
			String mentee_name = request.getParameter("mentee_name1");
			int taskID = Integer.parseInt(request.getParameter("taskID1"));
			String title = request.getParameter("title1");
			
			ResultSet rs_mentor;
			
			if(category.equals("Not Started")){
				String notStarted = "UPDATE task SET status='Not Started' WHERE taskID=" + taskID + " and mentee_name='" + mentee_name + "';";
				PreparedStatement ps_check = con.prepareStatement(notStarted);
				ps_check.executeUpdate();
			}else if(category.equals("In Progress")){
				String in_progress = "UPDATE task SET status='In Progress' WHERE taskID=" + taskID + " and mentee_name='" + mentee_name + "';";
				PreparedStatement ps_check2 = con.prepareStatement(in_progress);
				ps_check2.executeUpdate();
			}else if(category.equals("Complete")){
				String in_progress = "UPDATE task SET status='Complete' WHERE taskID=" + taskID + " and mentee_name='" + mentee_name + "';";
				PreparedStatement ps_check3 = con.prepareStatement(in_progress);
				ps_check3.executeUpdate();
			}else{
				response.sendRedirect("see_mentee_tasks.jsp");
			}
			
			rs_mentor = stmt.executeQuery("SELECT mentor_name FROM task WHERE taskID=" + taskID + " and mentee_name='" + mentee_name + "';");
			rs_mentor.next();
			String mentor_name = rs_mentor.getString("mentor_name");
			
			ResultSet rs_mentorEmail;
			rs_mentorEmail = stmt1.executeQuery("SELECT email FROM mentor WHERE full_name='" + mentor_name + "';");
			rs_mentorEmail.next();
			String mentor_email = rs_mentorEmail.getString("email");
			
			Properties properties = new Properties();
			properties.put("mail.smtp.auth", "true");
			properties.put("mail.smtp.starttls.enable", "true");
			properties.put("mail.smtp.host", "smtp.gmail.com");
			properties.put("mail.smtp.port", "587");
			
			String myEmail = "mentortrackingsystem@gmail.com";

			String myPassword = "Mentor4141";
			String recipient = mentor_email;
			
			String subject = "";
			String messageText = "";
			if(category.equals("Not Started")){
				subject = mentee_name + " has not completed Task " + taskID;
				messageText = String.join(
				        System.getProperty("line.separator"),
				        "Dear " + mentor_name,
				        "",
				        "Your mentee " + mentee_name + " has not completed " + title + " task.",
				        "",
				        "-------------------------",
				        ""
				);
			}else if(category.equals("In Progress")){
				subject = mentee_name + " is in progress of Task " + taskID;
				messageText = String.join(
				        System.getProperty("line.separator"),
				        "Dear " + mentor_name,
				        "",
				        "Your mentee " + mentee_name + " is in progress of " + title + " task.",
				        "",
				        "-------------------------",
				        ""
				);
			}else if(category.equals("Complete")){
				subject = mentee_name + " has completed Task " + taskID;
				messageText = String.join(
				        System.getProperty("line.separator"),
				        "Dear " + mentor_name,
				        "",
				        "Your mentee " + mentee_name + " has completed " + title + " task.",
				        "",
				        "-------------------------",
				        ""
				);
			}
			
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
				}catch (MessagingException mex) { 
					   mex.printStackTrace(); 
				}
				
		response.sendRedirect("see_mentee_tasks.jsp");
				
		}catch (Exception ex) {
			out.print(ex);
			out.print("Failed to Display!");
		}
	%>
	</body>
</html>