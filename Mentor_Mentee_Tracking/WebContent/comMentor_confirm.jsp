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
	<title>Communication Mentor Confirm</title>
	<link rel="stylesheet" href="about.css">
	<link rel="stylesheet" href="contactFile.css">
	</head>
	<style>
	h1{
		font-family: "Times New Roman", Times, serif;
		text-align: center;
		color: white;
		font-size: 30px;
	}
	
	.button {
	  background-color: #4CAF50; 
	  border: none;
	  color: white;
	  padding: 10px 17px;
	  text-align: center;
	  text-decoration: none;
	  display: inline-block;
	  font-size: 16px;
	  margin: 8px 190px;
	  transition-duration: 0.4s;
	  cursor: pointer;
	  font-family: "Times New Roman", Times, serif;
	}
	
	.button1 {
	  background-color: green; 
	  color: white; 
	  border: 2px solid #4CAF50;
	}
	
	.button1:hover {
	  background-color: #4CAF50;
	  color: white;
	}
	
	#para12{
		text-align: center;
		font-size: 18px;
	}
	
	#para41{
		left: 80px;
		color: white;
		font-size: 18px;
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
		try{
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			//Create a SQL statement
			Statement stmt = con.createStatement();
			Statement stmt1 = con.createStatement();
			
			String com_type = request.getParameter("category16");
			ResultSet rs_mentee, rs_task;
			
			String mentor_userName = session.getAttribute("Username").toString();
			rs_mentee = stmt.executeQuery("SELECT full_name, email FROM mentor WHERE username='" + mentor_userName + "';");
			rs_mentee.next();
			
			String mentor_name = rs_mentee.getString("full_name");
			String mentor_email = rs_mentee.getString("email");

			rs_task = stmt1.executeQuery("SELECT taskID, title FROM task_unique WHERE mentor_name='" + mentor_name + "' ORDER BY taskID DESC;");
			
			if(com_type.equals("Contact to Customer Representative")){
				%>
				<h1>Contact with a Customer Representative</h1><br>
				<p id="para41" style = "position:relative; left:80px;">Please enter your message to contact with a customer representative. He/She will be contacting with you by email in 2-3 business days.</p><br>
				
				<div class="container">				
				<form action="customerRep_mentor.jsp" method="POST"
					id="my-form">
					<div class="form-group">
						<label for="massage">Massage</label>
						<textarea name="massage" id="massage" cols="30" rows="10"></textarea>
					</div>
					<input type="hidden" name="mentor_name1" value="<%=mentor_name%>">
					<input type="hidden" name="mentor_email1" value="<%=mentor_email%>">
					<button type="submit">Submit</button>
				</form>
			</div>
			<%	
			}else if(com_type.equals("Task Discussions")){
				%>
				<h1>Task Discussions for <%= mentor_name%></h1><br>
				<%
				while(rs_task.next()){
					int taskID = rs_task.getInt("taskID");
					String title = rs_task.getString("title");
				%>
					<div class="container">
						<p id="para12"><%= title%></p>
						<a href="mentor_com_confirm.jsp?taskID=<%=taskID%>&mentor_name=<%=mentor_name%>&title=<%=title%>"><button class="button1 button">Discussion</button></a>
					</div>
					<%
				}	
			}else{
				response.sendRedirect("communicationMentor.jsp");
			}
			
		}catch (Exception ex) {
			out.print(ex);
			out.print("Failed to Display!");
		}
	%>
	</body>
</html>