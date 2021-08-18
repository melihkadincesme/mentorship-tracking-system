<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.tracking.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>About Main</title>
	
	<link rel="stylesheet" href="about.css">
	
	<style>
	 h1{
		font-family: "Times New Roman", Times, serif;
		text-align: center;
		color: white;
	}
	.info #p1{
		width: 90%;
		max-width: 800px;
		margin: 0 auto;
		padding: 30px;
		box-shadow: 0px 0px 20px #00000010;
		background-color: white;
		border-radius: 8px;
		margin-bottom: 20px;
		
		color: black;
		font-size: 18px;
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
	
	<h1> About the Mentor-Mentee Tracking Website</h1>
	<div class="info">
	<br><br>
			
		<p id="p1" style = "position:fixed; left:80px; right:50px;">
	  		Dear our valued customers, <br><br>
	  		This mentor-mentee tracking system is intended to help our mentors to track their own mentees’ activities.  In our website, mentors are able to create their mentees’ accounts, create tasks, and see their mentees’ status on their assigned activities. On the other hand, mentees are able to track their own time, write their tasks for today, and ask questions to mentors regarding their project. 
	  		<br><br>
	  		In order to use our website, the company holder needs to contact to our customer representative to obtain company unique code, where mentors can create their own account. 
	  		<br><br>
	  		If you have any questions, please feel free to reach out to mentortrackingsystem@gmail.com.
	  		<br><br>
	  		Sincerely, <br>
			Melih Kadincesme <br>
			The founder of Mentor-Mentee Tracking System <br>
		</p>
	</div>
	
	</body>
</html>