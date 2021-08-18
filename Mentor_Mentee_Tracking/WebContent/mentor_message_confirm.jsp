<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.tracking.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "java.io.*,java.util.*,javax.mail.*"%>
<%@ page import = "javax.mail.internet.*,javax.activation.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.sql.Timestamp,java.text.SimpleDateFormat,java.util.Date" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Mentor Message Confirm</title>
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

		int taskID = Integer.parseInt(request.getParameter("taskID"));
		String mentor_name = request.getParameter("mentor_name");
		String message_new = request.getParameter("message");
		String title = request.getParameter("title");
		
		String new_message = "INSERT INTO task_message(taskID, full_name, message) VALUES (?, ?, ?)";
		PreparedStatement ps_val = con.prepareStatement(new_message);
		
		ps_val.setInt(1, taskID);
		ps_val.setString(2, mentor_name);
		ps_val.setString(3, message_new);
		
		ps_val.executeUpdate();
	
		//response.sendRedirect("mentor_com_confirm.jsp?taskID=" + taskID + "&mentor_name=" + mentor_name + "&title=" + title);	
	
		ResultSet rs_mentee;
		rs_mentee = stmt.executeQuery("SELECT mentee_name FROM task WHERE taskID=" + taskID + ";");
		String[] arr = new String[200];
		int i=0;
		
		while(rs_mentee.next()){
			String mentee_name = rs_mentee.getString("mentee_name");
			arr[i] = mentee_name;
			i++;
		}
		
		ResultSet rs_mentorEmail;
		
		rs_mentorEmail = stmt1.executeQuery("SELECT email FROM mentor WHERE full_name='" + mentor_name + "'");
		rs_mentorEmail.next();
		String mentor_email = rs_mentorEmail.getString("email");
		
		Properties properties = new Properties();
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.starttls.enable", "true");
		properties.put("mail.smtp.host", "smtp.gmail.com");
		properties.put("mail.smtp.port", "587");
		
		String myEmail = "mentortrackingsystem@gmail.com";

		String myPassword = "Mentor4141";
		String subject = "New Message From " + mentor_name + " for " + title + " task.";
		boolean check = false;
		
		for(int j=0; j<arr.length; j++){
			if(arr[j] == null){
				break;
			}
			ResultSet rs_mentee_email;
			String get_mentee_email = "SELECT email FROM mentee WHERE full_name=?";
			PreparedStatement ps3 = con.prepareStatement(get_mentee_email);

			ps3.setString(1, arr[j]);
			rs_mentee_email = ps3.executeQuery();
			
			while(rs_mentee_email.next()){
				String mentee_email = rs_mentee_email.getString("email");
				String recipient = mentee_email;
		
				String messageText = String.join(
				        System.getProperty("line.separator"),
				        "Dear " + arr[j],
				        "",
				        "A new message has been sent to " + title + " task.",
				        "",
				        "From " + mentor_name,
				        "----------",
				        message_new
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
			}
		}
		response.sendRedirect("mentor_com_confirm.jsp?taskID=" + taskID + "&mentor_name=" + mentor_name + "&title=" + title);	
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Failed to Display!");
	}
	%>
	</body>
</html>