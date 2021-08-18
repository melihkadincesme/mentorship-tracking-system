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
	<title>Mentee Tasks</title>
	<link rel="stylesheet" href="about.css">
	</head>
	<style>
	h1{
			font-family: "Times New Roman", Times, serif;
			color: white;
			text-align: center;	
			font-size: 30px;
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
	
	.content-table th,
	.content-table td {
	  padding: 12px 15px;
	}
	
	.content-table tbody tr {
	  border-bottom: 1px solid;
	  text-align: center;
	  font-size: 18px;
	  font-family: "Times New Roman", Times, serif;
	}
	
	.content-table tbody tr:nth-of-type(even) {
	  background-color: #f3f3f3;*/
	}
	
	.content-table tbody tr:last-of-type {
	  border-bottom: 2px solid #009879;*/
	}
	
	.content-table tbody tr.not_started {
	  background-color: #FCA698;
	}
	.content-table tbody tr.not_started a{
	   	transition: all 0.3s ease 0s;
	}
	.content-table tbody tr.in_progress a{
	   	transition: all 0.3s ease 0s;
	}
	.content-table tbody tr.complete a{
	   	transition: all 0.3s ease 0s;
	}
	.content-table tbody a{
	  	font-family: "Times New Roman", Times, serif;
		font-weight: 500;
		color: #000000;
		text-decoration: none;
	}
	.content-table tbody tr.not_started a:hover{
		  color: #0088a9;
	}
	.content-table tbody tr.in_progress a:hover{
		  color: #0088a9;
	}
	.content-table tbody tr.complete a:hover{
		  color: #0088a9;
	}
	.content-table tbody tr.in_progress {
	  background-color: #F9E6B4;
	}
	.content-table tbody tr.complete {
	  background-color: #D1F68F;
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
	
		String menteeName = request.getParameter("mentee_name");
		
	%>
	<h1>Assigned Tasks for <%=menteeName%></h1><br>
	<table class="content-table" style="width: 90%">
	<thead>
		<tr>
			<th>Task ID</th>
			<th>Title</th>
			<th>Description</th>
			<th>Deadline</th>
			<th>Status</th>
		</tr>
	</thead>
	<%	
	ResultSet rs;
	
	String get_info = "SELECT taskID, title, description, deadline, status FROM task WHERE mentee_name=? ORDER BY taskID DESC";
	PreparedStatement ps_check = con.prepareStatement(get_info);
	ps_check.setString(1, menteeName);
	rs = ps_check.executeQuery();
	
	while(rs.next()){
		int taskID = rs.getInt("taskID");
		String title = rs.getString("title");
		String description = rs.getString("description");
		String deadline = rs.getString("deadline");
		String status = rs.getString("status");
		
		if(status.equals("Not Started")){
			%>
			<tr class="not_started">
				<td><%= taskID%></td>
				<td><%= title%></td>
				 <td><%= description%></td>
				<td><%= deadline%></td>
				<td><%= status%></td>
			</tr>
			<%
		}else if(status.equals("In Progress")){
			%>
			<tr class="in_progress">
				<td><%= taskID%></td>
				<td><%= title%></td>
				<td><%= description%></td>
				<td><%= deadline%></td>
				<td><%= status%></td>
			</tr>
			<%
		}else if(status.equals("Complete")){
			%>
			<tr class="complete">
				<td><%= taskID%></td>
				<td><%= title%></td>
				<td><%= description%></td>
				<td><%= deadline%></td>
				<td><%= status%></td>
			</tr>
			<%
		}else{
			continue;
		}
		
	}
	
	}catch (Exception ex) {
		out.print(ex);
		out.print("Failed to Display!");
	}	
	%>
	</table>
	<br><br>
	</body>
</html>