<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.tracking.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Contact</title>
	<link rel="stylesheet" href="about.css">
	<link rel="stylesheet" href="contactFile.css">
	<style>
	h1{
		font-family: "Times New Roman", Times, serif;
		text-align: center;
		color: white;
		font-size: 40px;
	}
	p{
		left: 80px;
		color: white;
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
	
	<h1>Contact to Customer Representative</h1>
	<br>
	<p style = "position:relative; left:80px;">Dear customer, <br><br> If you are a business holder and want to start to use our application, please contact to our customer representative to get started with the Mentor-Mentee Tracking System.<br>
	Once you contact to one of our agents, they will provide you details. <br>
	Please indicate your company name and department names in your text.<br><br>
	Sincerely, <br>
	Melih Kadincesme <br>
	The founder of Mentor-Mentee Tracking System
	</p>

	<section>
		<div class="container">
			<form action="contactConfirm.jsp" method="POST"
				id="my-form">

				<div class="form-group">
					<label for="firstName"> Full Name</label> <input type="text"
						id="firstName" name="firstName">
				</div>

				<div class="form-group">
					<label for="email">Email</label> <input type="email" id="email"
						name="email">
				</div>

				<div class="form-group">
					<label for="massage">Massage</label>
					<textarea name="massage" id="massage" cols="30" rows="10"></textarea>
				</div>

				<button type="submit">Submit</button>
			</form>
		</div>
		<div id="status"></div>
	</section>
</body>
</html>