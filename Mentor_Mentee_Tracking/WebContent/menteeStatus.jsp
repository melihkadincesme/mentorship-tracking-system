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
	<title>Mentee Status</title>
	<link rel="stylesheet" href="about.css">
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
	
	.button {
	  background-color: #4CAF50; /* Green */
	  border: none;
	  color: white;
	  padding: 10px 17px;
	  text-align: center;
	  text-decoration: none;
	  display: inline-block;
	  font-size: 16px;
	  margin: 4px 2px;
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
	
	</style>
	</head>
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
			
			ResultSet rs_title;//srs_count, rs_get, 
			
			int taskID = Integer.parseInt(request.getParameter("val1"));
			
			String get_title = "SELECT title FROM task_unique WHERE taskID=?";
			PreparedStatement ps3 = con.prepareStatement(get_title);
			ps3.setInt(1, taskID);
			rs_title = ps3.executeQuery();
			
			while(rs_title.next()){
				String title = rs_title.getString("title");
				out.println("<h1>Mentee Status for " + title + "</h1> <br><br>");
			}
			%>
			<table class="content-table" style="width: 90%">
			<thead>
				<tr>
					<th>Mentee</th>
					<th>Status</th>
					<th>Deadline</th>
					<th>Manage Deadline</th>
				</tr>
			</thead>
			<%
			ResultSet mentee_list;
			
			String get_mentee = "SELECT mentee_name, status, deadline FROM task where taskID=?";
			PreparedStatement ps_check2 = con.prepareStatement(get_mentee);
			ps_check2.setInt(1, taskID);
			mentee_list = ps_check2.executeQuery();
			%>
			<tbody>
			<%
			while(mentee_list.next()){
				String menteeName = mentee_list.getString("mentee_name");
				String menteeStatus = mentee_list.getString("status");
				String get_deadline = mentee_list.getString("deadline");

				if(menteeStatus.equals("Not Started")){
					%>
					<tr class="not_started">
						<td><a href="mentee_tasks.jsp?mentee_name=<%=menteeName%>"><%= menteeName%></a></td>
						<td><%= menteeStatus%></td>
						<td><%= get_deadline %></td>
						<td><a href="deadlineChange.jsp?mentee_name=<%=menteeName%>&taskID=<%=taskID%>"><button class="button button1">Deadline</button></a></td>
					</tr>
					<%
				}else if(menteeStatus.equals("In Progress")){
					%>
					<tr class="in_progress">
						<td><a href="mentee_tasks.jsp?mentee_name=<%=menteeName%>"><%= menteeName%></a></td>
						<td><%= menteeStatus%></td>
						<td><%= get_deadline %></td>
						<td><a href="deadlineChange.jsp?mentee_name=<%=menteeName%>&taskID=<%=taskID%>"><button class="button button1">Deadline</button></a></td>
					</tr>
					<%
				}else if(menteeStatus.equals("Complete")){
					%>
					<tr class="complete">
						<td><a href="mentee_tasks.jsp?mentee_name=<%=menteeName%>"><%= menteeName%></a></td>
						<td><%= menteeStatus%></td>
						<td><%= get_deadline %></td>
						<td><a href="deadlineChange.jsp?mentee_name=<%=menteeName%>&taskID=<%=taskID%>"><button class="button button1">Deadline</button></a></td>
					</tr>
					<%
				}
			}
			%>
			</tbody>
			<%
		}catch (Exception ex) {
			out.print(ex);
			out.print("Failed to Display!");
		}	
	%>
	</table>
	</body>
</html>