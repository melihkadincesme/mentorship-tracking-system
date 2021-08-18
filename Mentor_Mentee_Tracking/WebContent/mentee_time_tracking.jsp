<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.tracking.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Mentee Time Tracking</title>
	<link rel="stylesheet" href="about.css">
	</head>
	<style>
	.form1{
		 font-size: 18px;
	}
	#head1{
		font-size: 25px;
		color: black;
		text-align: center;
		font-family: "Times New Roman", Times, serif;
		
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
}

.content-table {
	border-collapse: collapse;
	/* margin: 25px 0;*/
	font-size: 0.9em;
	min-width: 400px;
	border-radius: 5px 5px 0 0;
	overflow: hidden;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
	margin-left: auto;
	margin-right: auto;
}

.content-table thead tr {
	background-color: #009879;
	color: #ffffff;
	text-align: center;
	font-weight: bold;
	font-size: 18px;
}

.content-table th, .content-table td {
	padding: 12px 15px;
}

.content-table tbody tr {
	border-bottom: 1px solid;
	text-align: center;
	font-size: 18px;
	font-family: "Times New Roman", Times, serif;
}

.content-table tbody tr.time_table {
	background-color: #DCDCDC;
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
	
	<%
		try{
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			//Create a SQL statement
			Statement stmt = con.createStatement();
			Statement stmt1 = con.createStatement();
			Statement stmt2 = con.createStatement();

			String mentee_userName = session.getAttribute("Username").toString();

			ResultSet rs_mentee_name;
			rs_mentee_name = stmt.executeQuery("SELECT full_name FROM mentee WHERE username='" + mentee_userName + "'");
			rs_mentee_name.next();
			String mentee_name = rs_mentee_name.getString("full_name");
			
			ResultSet rs_task;
			rs_task = stmt1.executeQuery("SELECT title FROM task WHERE mentee_name='" + mentee_name + "';");
		%>
		<section>
		<div class="container">
			<form action="time_tracking_confirm.jsp" method="POST" id="my-form">
			<h1 id="head1">Create a New Shift Time</h1><br>
			<div class="form1">
					<label for="task">Choose your Task:</label><br> 
					<% 
					while(rs_task.next()){
						String title = rs_task.getString("title");
						%>
						<input type="radio" name="task_choose" value="<%=title%>"><%=title%>
						<% 
					}
					%>
			</div>
			<div class="form-group">
					<label for="description">Description</label>
					<textarea name="description" id="description" cols="30" rows="2"></textarea>
			</div>
			<div class="form-group">
					<label for="hours">Number of Hours</label>
					<input type="number" name="num_hours"/>
			</div>
			<div class="form-group">
					<label for="date_task">Date</label> 
                    <input type="date" id=date_task name="date_task" min="2021-04-17" max="2023-06-14">
			</div>
			<input type="hidden" name="mentee_name" value="<%=mentee_name%>">
			<button type="submit">Submit</button>
		</form>
		</div>
		</section>
		<%
		
		ResultSet rs_time;
		rs_time = stmt2.executeQuery("SELECT title, description, num_hours, date_tracking FROM time_tracking WHERE full_name='" + mentee_name + "' ORDER BY date_tracking DESC;");
		%>
		<table class="content-table" style="width: 90%">
			<thead>
				<tr>
					<th>Title</th>
					<th>Description</th>
					<th>Number of Hours</th>
					<th>Date</th>
				</tr>
			</thead>
			<tbody>
		<%	
		while(rs_time.next()){
			String title = rs_time.getString("title");
			String description = rs_time.getString("description");
			int hours = rs_time.getInt("num_hours");
			String date = rs_time.getString("date_tracking");
			
			%>
			<tr class="time_table">
				<td><%=title %></td>
				<td><%=description %></td>
				<td><%=hours %></td>
				<td><%=date %></td>
			</tr>
			<% 
		}
		
		}catch (Exception ex) {
			out.print(ex);
			out.print("Failed to Display!");
		}
	%>
	</tbody>
	</table><br><br>
	</body>
</html>