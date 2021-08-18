<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.tracking.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Change Status</title>
	<link rel="stylesheet" href="about.css">
	<style>
	h1{
		font-family: "Times New Roman", Times, serif;
		text-align: center;
		color: white;
		font-size: 30px;
	}
	
	#para10{
		text-align: center;
		font-size: 20px;
		color: #F33A3A;
		text-decoration: underline;  
	}
	
	#para11{
		text-align: center;
		font-size: 20px;
		color: black;
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
	
	.form-group1{
	  width: 90%;
	  max-width: 500px;
	  margin: 0 auto;
	  padding: 10px;
	  box-shadow: 0px 0px 20px #00000010;
	  background-color: #C8C8C8;
	  border-radius: 8px;
	  margin-bottom: 20px;
	}
	
	textarea {
	  resize: vertical;
	}
	button[type="submit"] {
	  width: 100%;
	  border: none;
	  outline: none;
	  padding: 20px;
	  font-size: 24px;
	  border-radius: 8px;
	  font-family: "Montserrat";
	  color: rgb(27, 166, 247);
	  text-align: center;
	  cursor: pointer;
	  margin-top: 10px;
	  transition: 0.3s ease background-color;
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
	</head>
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
			
			int taskID = Integer.parseInt(request.getParameter("taskID"));
			String mentee_name = request.getParameter("mentee_name");
			String title = request.getParameter("title");
			String status = request.getParameter("status");
	%>
	<h1>Change Task Status for <%=title %></h1><br>
	
	<div class="container">
			<form action="changeStatus_confirm.jsp" method="POST"
				id="my-form">
				<div class="form-group1">
					<p id="para10">Current Status <br> </p>
					<p id="para11"> <%=status %></p>
				</div>
				<div class="form-group">
					 
					<input list="category11" name="category11" placeholder="Select your status...">
					 
					<datalist id="category11">
					  <option value="Complete">
					  <option value="In Progress">
					  <option value="Not Started">
					</datalist> 
				</div>
				
				<input type="hidden" name="taskID1" value="<%=taskID%>">
				<input type="hidden" name="mentee_name1" value="<%=mentee_name%>">
				<input type="hidden" name="title1" value="<%=title%>">
				<button type="submit">Submit</button>
			</form>
		</div>
	<%
	}catch (Exception ex) {
			out.print(ex);
			out.print("Failed to Display!");
		}
	%>
	</body>
</html>