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
	<title>Deadline Confirm</title>	
	</head>
	<link rel="stylesheet" href="about.css">
	<style>
		p{
			font-family: "Times New Roman", Times, serif;
			color: white;
			text-align: center;	
			font-size: 30px;
		}
		p.pemail{
			font-family: "Times New Roman", Times, serif;
			color: white;
			text-align: center;	
			font-size: 30px;
			margin-top: 20px;
		}
	
	</style>
	<body>
	<header>
		<a class="logo" href="mentor_main.jsp"><img src="logo-whitetulip-health.png" alt="logo" width="300" height="100"></a>
            <nav>
                <ul class="nav__links">
                    <li><a href="mentor_main.jsp">Dashboard</a></li>
                    <li><a href="menteeTaskCreate.jsp">Create a Task</a></li>
                    <li><a href="manageTasks.jsp">Manage Tasks</a></li>
                    <li><a href="communicationMentor.jsp">Communication</a></li>
                    <li><a href="seeMentees.jsp">See Mentees</a></li>
                    <li><a href="mentorUserSettings.jsp">User Settings</a></li>
                </ul>
            </nav>
            <a class="cta" href="logout.jsp">Logout</a>		
	</header>
	<%
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			String[] mentees = (String[])session.getAttribute("select_mentee");
			
			//get mentor name first
			ResultSet rs_mentor_name, rs_count;
			
			String mentor_userName = session.getAttribute("Username").toString();
			String title = session.getAttribute("title").toString();
			String description = session.getAttribute("description").toString();
			String deadline = request.getParameter("deadline1");
			
			String count = "SELECT COUNT(*) FROM task";
			PreparedStatement ps1 = con.prepareStatement(count);
			rs_count = ps1.executeQuery();
			rs_count.next();
			int taskID = rs_count.getInt("count(*)") + 1;

			rs_mentor_name = stmt.executeQuery("SELECT full_name from mentor where username='" + mentor_userName + "'" + ";");

			while(rs_mentor_name.next()){
				String mentor_name = rs_mentor_name.getString("full_name");
				
				if(mentees != null){
					boolean unique = true;
					for(int i=0; i<mentees.length; i++){
						String insert_task = "INSERT INTO task(taskID, title, description, mentor_name, mentee_name, deadline, status) VALUES (?, ?, ?, ?, ?, ?, ?)";						
						PreparedStatement ps2 = con.prepareStatement(insert_task);
						
						String status = "Not Started";
						
						ps2.setInt(1, taskID);
						ps2.setString(2, title);
						ps2.setString(3, description);
						ps2.setString(4, mentor_name);
						ps2.setString(5, mentees[i]);
						ps2.setString(6, deadline);
						ps2.setString(7, status);

						
						ps2.executeUpdate();
						
						if(unique == true){
							//you add details to task_unique
							String insert_unique = "INSERT INTO task_unique(taskID, title, mentor_name, description, deadline, check_live, status) VALUES (?, ?, ?, ?, ?, ?, ?)";						
							PreparedStatement ps3 = con.prepareStatement(insert_unique);
							
							String status1 = "Not Complete";
							
							ps3.setInt(1, taskID);
							ps3.setString(2, title);
							ps3.setString(3, mentor_name);
							ps3.setString(4, description);
							ps3.setString(5, deadline);
							ps3.setInt(6, 1);
							ps3.setString(7, status1);

							ps3.executeUpdate();
							unique = false;
						}
						
					}
				}
			}
			//con.close();
			//out.print("<p>Successfully Created a Task!</p>");
			
			Properties properties = new Properties();
			properties.put("mail.smtp.auth", "true");
			properties.put("mail.smtp.starttls.enable", "true");
			properties.put("mail.smtp.host", "smtp.gmail.com");
			properties.put("mail.smtp.port", "587");
			
			//String myEmail = "mentortrackingsystem@gmail.com";
			String myEmail = "mentortrackingsystem@gmail.com";

			String myPassword = "Mentor4141";
			String subject = "Mentor-Mentee Tracking System Customer Inquiry";
			boolean check = false;
			
			for(int i=0; i<mentees.length; i++){
				//String recipient = "mentortrackingsystem@gmail.com";
				ResultSet rs_mentee_email;
				String get_mentee_email = "SELECT email from mentee where full_name=?";
				PreparedStatement ps3 = con.prepareStatement(get_mentee_email);

				ps3.setString(1, mentees[i]);
				rs_mentee_email = ps3.executeQuery();
				
				while(rs_mentee_email.next()){
					String mentee_email = rs_mentee_email.getString("email");
					String recipient = mentee_email;
			
					String messageText = String.join(
					        System.getProperty("line.separator"),
					        "Dear " + mentees[i],
					        "",
					        "You have been assigned to a new task by your mentor. Please see details below.",
					        "",
					        "Title: " + title,
					        "",
					        "Description: ", description,
					        "",
					        "Deadline: " + deadline
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
								%>
								<p class = "pemail">Successfully created a task and your assigned mentees will be informed by email.</p>
								<%
								check = true;
							}
						}catch (MessagingException mex) { 
							   mex.printStackTrace(); 
							   out.println("Error: unable to connect...."); 
						}
				}
			}
			
		} catch (Exception ex) {
			out.print(ex);
			out.print("Failed to Display!");
		}
	%>
	</body>
</html>