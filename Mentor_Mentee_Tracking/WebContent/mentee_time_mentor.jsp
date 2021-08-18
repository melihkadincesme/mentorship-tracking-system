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
	<title>See Mentee Tracking from Mentor Side</title>
	<link rel="stylesheet" href="about.css">
	</head>
	<style>
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
	</header><br>
	<%
	try{
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String mentee_name = request.getParameter("mentee_name");
		
		ResultSet rs_time;
		rs_time = stmt.executeQuery("SELECT title, description, num_hours, date_tracking FROM time_tracking WHERE full_name='" + mentee_name + "' ORDER BY date_tracking DESC");
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
	</table>
	</body>
</html>