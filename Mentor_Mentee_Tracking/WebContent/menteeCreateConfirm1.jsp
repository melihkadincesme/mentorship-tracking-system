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
	<title>Mentee Create Account Confirm</title>
	<style>
	p{
		font-family: "Times New Roman", Times, serif;
		color: white;
		text-align: center;	
		font-size: 20px;
	}
	</style>
	<link rel="stylesheet" href="about.css">
	
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
		
		String mentor_get = request.getParameter("category");
		String mentor_name = "";
		String dept_name = "";
		
	    for(int i=0; i<mentor_get.length(); i++){
	      if(mentor_get.charAt(i) == '-'){
				mentor_name = mentor_get.substring(0, i);
	        	dept_name = mentor_get.substring(i+1);
			}
	    }
	   
	    String full_name = request.getParameter("name");
	    String email = request.getParameter("email");
	    String user_name = request.getParameter("username1");
	    String password = request.getParameter("password1");
	    String dob = request.getParameter("dob");
		String code = session.getAttribute("company_code").toString();
		String phone_num = request.getParameter("phone");
		String position = request.getParameter("position");
		String school = request.getParameter("school");
		int year = Integer.parseInt(request.getParameter("year"));
		String location = request.getParameter("location");
		
		String insert_mentee = "INSERT INTO mentee(full_name, username, email, dob, password, dept_name, unique_code, mentor_name, phone, position, school, grad_year, location) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(insert_mentee);
		
		ps.setString(1, full_name);
		ps.setString(2, user_name);
		ps.setString(3, email);
		ps.setString(4, dob);
		ps.setString(5, password);
		ps.setString(6, dept_name);
		ps.setString(7, code);
		ps.setString(8, mentor_name);
		ps.setString(9, phone_num);
		ps.setString(10, position);
		ps.setString(11, school);
		ps.setInt(12, year);
		ps.setString(13, location);

		ps.executeUpdate();

		Properties properties = new Properties();
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.starttls.enable", "true");
		properties.put("mail.smtp.host", "smtp.gmail.com");
		properties.put("mail.smtp.port", "587");
		
		String myEmail = "mentortrackingsystem@gmail.com";
		String myPassword = "Mentor4141";
		String recipient = email;
		String subject = "Mentor-Mentee Tracking System Mentee Login Informations";
		//String messageText = "Dear " + mentee_name + ", Your mentor is " + mentor_name + ". Please login using these infomrations. username: " + mentee_username + "password: " + mentee_password;
		
		String messageText = String.join(
		        System.getProperty("line.separator"),
		        "Dear " + full_name + ", ",
		        "",
		        "Welcome to the Mentor - Mentee Tracking System! Your mentor is " + mentor_name + " from the " + dept_name + " department.",
		        "",
		        "Username: " + user_name,
		        "Password: " + password,
		        "",
		        "Sincerely, ",
		        "Melih Kadincesme",
		        "The founder of Mentor-Mentee Tracking System"

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
				out.print("<p>Successfully Created a Mentee Account! The login information will be send to the user!</p>");
			}catch (MessagingException mex) { 
				   mex.printStackTrace(); 
				   out.println("Error: unable to connect...."); 
			}
	
		
		con.close();
	}catch (Exception ex) {
		out.print(ex);
		out.print("Failed to Display!");
	}
	%>
	</body>
</html>