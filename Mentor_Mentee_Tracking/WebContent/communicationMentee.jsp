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
	<title>Communication Mentee</title>
	<link rel="stylesheet" href="about.css">
	</head>
	<style>
	h1{
		font-family: "Times New Roman", Times, serif;
		text-align: center;
		color: white;
		font-size: 30px;
	}
	
	.container {
	  width: 90%;
	  max-width: 500px;
	  margin: 0 auto;
	  padding: 10px;
	  box-shadow: 0px 0px 20px #00000010;
	  background-color: white;
	  border-radius: 8px;
	  margin-bottom: 20px;
	}
	.form-group {
	  width: 100%;
	  margin-top: 10px;
	  font-size: 20px;
	}
	
	.form-group input,
	.form-group textarea {
	  width: 100%;
	  padding: 5px;
	  font-size: 18px;
	  border: 1px solid rgba(128, 128, 128, 0.199);
	  margin-top: 5px;
	  font-family: "Times New Roman", Times, serif;
	}
	
	textarea {
	  resize: vertical;
	}
	button[type="submit"] {
	  width: 70%;
	  border: none;
	  outline: none;
	  padding: 8px;
	  font-size: 24px;
	  border-radius: 8px;
	  font-family: "Montserrat";
	  color: rgb(27, 166, 247);
	  text-align: center;
	  cursor: pointer;
	  margin-top: 10px;
	  transition: 0.3s ease background-color;
	  margin-left: 70px;
	}
	button[type="submit"]:hover {
	  background-color: rgb(214, 226, 236);
	}
	#status {
	  width: 90%;
	  max-width: 500px;
	  text-align: center;
	  padding: 10px;
	  margin: 0 auto;
	  border-radius: 8px;
	}
	#status.success {
	  background-color: rgb(211, 250, 153);
	  animation: status 4s ease forwards;
	}
	#status.error {
	  background-color: rgb(250, 129, 92);
	  color: white;
	  animation: status 4s ease forwards;
	}
	@keyframes status {
	  0% {
	    opacity: 1;
	    pointer-events: all;
	  }
	  90% {
	    opacity: 1;
	    pointer-events: all;
	  }
	  100% {
	    opacity: 0;
	    pointer-events: none;
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
	
	<h1>Please Choose your Type of Communication!</h1><br>
	
	<div class="container">
			<form action="comMentee_confirm.jsp" method="POST"
				id="my-form">
				
				<div class="form-group">
					 
					<input list="category15" name="category15" placeholder="Choose your communication type...">
					 
					<datalist id="category15">
					  <option value="Contact to Customer Representative">
					  <option value="Task Discussions">
					</datalist> 
				</div>
				
				<button type="submit">Submit</button>
			</form>
		</div>
	
	</body>
</html>