<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.tracking.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Mentee Tasks</title>
	<link rel="stylesheet" href="about.css">
	<link rel="stylesheet" href="mentee_table.css">
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
	</header><br>
	<%
		try{
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			ResultSet rs_name, rs_mentee;
			String mentee_userName = session.getAttribute("Username").toString();
			
			rs_name = stmt.executeQuery("SELECT full_name FROM mentee WHERE username='" + mentee_userName + "';");
			rs_name.next();
			String mentee_name = rs_name.getString("full_name");
			
			String mentee_list = "SELECT taskID, title, description, status, deadline FROM task WHERE mentee_name='" + mentee_name + "' ORDER BY taskID DESC;";
			PreparedStatement ps1 = con.prepareStatement(mentee_list);
			rs_mentee = ps1.executeQuery();
		%>
			<h1>Assigned Tasks for <%= mentee_name %></h1><br>
			<table class="content-table" style="width: 90%">
			<thead>
				<tr>
					<th>Title</th>
					<th>Description</th>
					<th>Your Status</th>
					<th>Deadline</th>
					<th>Change Status</th>
				</tr>
			</thead>
		<%
			while(rs_mentee.next()){
				int taskID = rs_mentee.getInt("taskID");
				String title = rs_mentee.getString("title");
				String description = rs_mentee.getString("description");
				String status = rs_mentee.getString("status");
				String deadline = rs_mentee.getString("deadline");
				
				if(status.equals("Not Started")){
					%>
					<tr class="not_started">
						<td><%= title%></td>
						<td><%= description %></td>
						<td><%= status %></td>
						<td><%= deadline %></td>
						<td><a href="change_status.jsp?mentee_name=<%=mentee_name%>&taskID=<%=taskID%>&title=<%=title%>&status=<%=status%>"><button class="button button1">Status</button></a></td>
					</tr>
					<%
				}else if(status.equals("In Progress")){
					%>
					<tr class="in_progress">
						<td><%= title%></td>
						<td><%= description %></td>
						<td><%= status %></td>
						<td><%= deadline %></td>
						<td><a href="change_status.jsp?mentee_name=<%=mentee_name%>&taskID=<%=taskID%>&title=<%=title%>&status=<%=status%>"><button class="button button1">Status</button></a></td>
					</tr>
					<%
				}else if(status.equals("Complete")){
					%>
					<tr class="complete">
						<td><%= title%></td>
						<td><%= description %></td>
						<td><%= status %></td>
						<td><%= deadline %></td>
						<td><a href="change_status.jsp?mentee_name=<%=mentee_name%>&taskID=<%=taskID%>&title=<%=title%>&status=<%=status%>"><button class="button button1">Status</button></a></td>
					</tr>
					<%
				}
			}
		}catch (Exception ex) {
			out.print(ex);
			out.print("Failed to Display!");
		}
	%>
	</table>
	</body>
</html>