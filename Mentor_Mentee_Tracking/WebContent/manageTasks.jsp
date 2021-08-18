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
	<title>Manage Task Mentor</title>
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
	
	.content-table tbody tr.not_complete {
	  background-color: #FCA698;
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
			ResultSet rs_mentor_name;
			
			String mentor_userName = session.getAttribute("Username").toString();
			rs_mentor_name = stmt.executeQuery("SELECT full_name from mentor where username='" + mentor_userName + "'" + ";");
			
			while(rs_mentor_name.next()){
				String mentor_name = rs_mentor_name.getString("full_name");
				%>
				<h1>Assigned Tasks from <%=mentor_name %></h1><br><br>
				<%
			}
			%>
			<table class="content-table" style="width: 90%">
			<thead>
				<tr>
					<th>Title</th>
					<th>Description</th>
					<th>Status</th>
					<th>Mentee Status</th>
					<th>Manage Task</th>
				</tr>
			</thead>
			<%
				ResultSet rs_desc;
				
				String get_task = "SELECT * FROM task_unique;";
				PreparedStatement ps_task = con.prepareStatement(get_task);
				
				String tasks_desc = "SELECT title, description, taskID, status FROM task_unique ORDER BY taskID DESC";
				PreparedStatement ps4 = con.prepareStatement(tasks_desc);
				rs_desc = ps4.executeQuery();
				%>
				<tbody>
				<%
				
				while(rs_desc.next()){
					String status = rs_desc.getString("status");
					int task_id = rs_desc.getInt("taskID");
				
					ResultSet mentee_list;
					
					String get_mentee = "SELECT mentee_name, status from task where taskID=?";
					PreparedStatement ps_check2 = con.prepareStatement(get_mentee);
					ps_check2.setInt(1, task_id);
					mentee_list = ps_check2.executeQuery();
					
					boolean complete = false;
					
					while(mentee_list.next()){
						String menteeName = mentee_list.getString("mentee_name");
						String menteeStatus = mentee_list.getString("status");
						
						if(menteeStatus.equals("Complete")){
							complete = true;
						}else if(menteeStatus.equals("Not Started") || menteeStatus.equals("In Progress")){
							complete = false;
							break;
						}
					}
					
					if(complete == true){ //then update status in task_unique to complete
						String update_status = "UPDATE task_unique SET status = 'Complete' WHERE taskID=?";
						PreparedStatement status_ps = con.prepareStatement(update_status);
						status_ps.setInt(1, task_id);
						status_ps.executeUpdate();
					}else if(complete == false){
						String update_status1 = "UPDATE task_unique SET status = 'Not Complete' WHERE taskID=?";
						PreparedStatement status_ps1 = con.prepareStatement(update_status1);
						status_ps1.setInt(1, task_id);
						status_ps1.executeUpdate();
					}
					
					if(status.equals("Not Complete")){
					%>
						<tr class="not_complete">
							<td><%=rs_desc.getString("title") %></td>
							<td><%=rs_desc.getString("description") %></td>
							<td><%=status%></td>
							<td><a href="menteeStatus.jsp?val1=<%=rs_desc.getInt("taskID")%>"><button class="button button1">Status</button></a></td>
							<td><a href="taskSettings.jsp?val2=<%=rs_desc.getString("taskID")%>"><button class="button button1">Settings</button></a></td>
						</tr>
					<%
					}else if(status.equals("Complete")){
						%>
						<tr class="complete">
							<td><%=rs_desc.getString("title") %></td>
							<td><%=rs_desc.getString("description") %></td>
							<td><%=status%></td>
							<td><a href="menteeStatus.jsp?val1=<%=rs_desc.getInt("taskID")%>"><button class="button button1">Status</button></a></td>
							<td><a href="taskSettings.jsp?val2=<%=rs_desc.getString("taskID")%>"><button class="button button1">Settings</button></a></td>
						</tr>
						<%
					}
				}
			%></tbody><%
			con.close();
		}catch (Exception ex) {
			out.print(ex);
			out.print("Failed to Display!");
		}	
	%>
	</table>
	</body>
</html>