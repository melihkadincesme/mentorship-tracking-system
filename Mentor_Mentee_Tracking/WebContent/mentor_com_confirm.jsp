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
	<title>Mentor Communication Message</title>
	<link rel="stylesheet" href="about.css">	
	</head>
	<style>
	h1{
		font-family: "Times New Roman", Times, serif;
		color: white;
		text-align: center;	
		font-size: 20px;
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
	  width: 100%;
	  max-width: 500px;
	  margin: 0 auto;
	  /*padding: 30px;*/
	  box-shadow: 0px 0px 20px #00000010;
	  background-color: #C4FFE8;
	  border-radius: 8px;
	  margin-bottom: 20px;
	}
	textarea {
	  resize: vertical;
	}
	button[type="submit"] {
	  width: 70%;
	  border: none;
	  outline: none;
	  padding: 8px;
	  font-size: 20px;
	  border-radius: 9px;
	  font-family: "Times New Roman", Times, serif;
	  color: rgb(27, 166, 247);
	  text-align: center;
	  cursor: pointer;
	  margin-top: 10px;
	  transition: 0.3s ease background-color;
	  margin-left: 80px;
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
	#p2{
		text-align:center;
	}
	#p3{
		text-align:left;
		color: #6E6E6E;
	}
	#p4{
		text-align:left;
		color: black;
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
		<a class="logo" href="mentor_main.jsp"><img src="logo-whitetulip-health.png" alt="logo" width="300" height="100"></a>
            <nav>
                <ul class="nav__links">
                    <li><a href="mentor_main.jsp">Dashboard</a></li>
                    <li><a href="menteeTaskCreate.jsp">Create a Task</a></li>
                    <li><a href="manageTasks.jsp">Manage Tasks</a></li>
                    <li><a href="communicationMentor.jsp">Communication</a></li>
                    <li><a href="seeMentees.jsp">See Mentees</a></li>
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
		Statement stmt1 = con.createStatement();
		
			
		int taskID = Integer.parseInt(request.getParameter("taskID"));
		String mentor_name = request.getParameter("mentor_name");
		String title = request.getParameter("title");
	%>
	<h1>Discussion for <%=title %> Task</h1><br>
	<%
		ResultSet rs_total;
		rs_total = stmt1.executeQuery("SELECT COUNT(*) FROM task_message WHERE taskID=" + taskID + ";");
		rs_total.next();
		int total_messages = rs_total.getInt("count(*)");
		
		if(total_messages == 0){
			%>
			<div class="container">
				<form action="mentor_message_confirm.jsp" method="POST">
					<div class="form-group1">
						<p id="p2">No Messages found!</p>
					</div>
					<div class="form-group">
						<label for="message">Type your message:</label>
						<textarea name="message" id="message" cols="30" rows="2" placeholder="Yor message..."></textarea>
						<input type="hidden" name="taskID" value="<%=taskID%>">
						<input type="hidden" name="mentor_name" value="<%=mentor_name%>">
						<input type="hidden" name="title" value="<%=title%>">
						<button type="submit">Submit</button>
					</div>
				</form>
			</div>
			<%
		}else{
			ResultSet rs_message;
			rs_message = stmt.executeQuery("SELECT message, full_name FROM task_message WHERE taskID=" + taskID + ";");
		%>
			<div class="container">
				<form action="mentor_message_confirm.jsp" method="POST">
		<%
			while(rs_message.next()){
				String message = rs_message.getString("message");
				String full_name = rs_message.getString("full_name");
		%>
					<div class="form-group1">
						<p id="p3"><%=full_name %>:</p>
						<p id="p4"><%=message %></p>
					</div>
					
			<%
			}
			%>
			<div class="form-group">
						<label for="message">Type your message:</label>
						<textarea name="message" id="message" cols="30" rows="2" placeholder="Yor message..."></textarea>
						<input type="hidden" name="taskID" value="<%=taskID%>">
						<input type="hidden" name="mentor_name" value="<%=mentor_name%>">
						<button type="submit">Submit</button>					</div>
				</form>
			</div>
			<% 
		}
	
	} catch (Exception ex) {
		out.print(ex);
		out.print("Failed to Display!");
	}
	%>
	</body>
</html>