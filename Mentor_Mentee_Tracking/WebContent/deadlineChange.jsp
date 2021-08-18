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
	<title>Deadline Change</title>
	<link rel="stylesheet" href="about.css">
	<link rel="stylesheet" href="contactFile.css">
	
	<style>
	p{
			font-family: "Times New Roman", Times, serif;
			color: white;
			font-size: 30px;
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
		//String mentee_name = (String)session.getAttribute("mentee_name"); 
		//int taskID = (Integer)session.getAttribute("taskID_num"); 
		
		String mentee_name = request.getParameter("mentee_name");
		int taskID = Integer.parseInt(request.getParameter("taskID"));
		 
		ResultSet rs;
		
		String deadline_change = "SELECT deadline from task WHERE mentee_name=? and taskID=?";
		PreparedStatement ps_check2 = con.prepareStatement(deadline_change);
		ps_check2.setString(1, mentee_name);
		ps_check2.setInt(2, taskID);
		
		rs = ps_check2.executeQuery();
				
		while(rs.next()){
			if(rs.getString("deadline") == null){
				%>
				 <p>You cannot access to that page</p>
				<%
			}
		}
		
		session.setAttribute("mentee_name1", mentee_name);
		session.setAttribute("taskID1", taskID);
		%>
		<br><br>
		<div class="container">
			<form action="deadlineChangeConfirm.jsp" method="POST" id="my-form">
				<div class="form-group">
					<label for="Deadline">Change Deadline for <%=mentee_name %></label> 
                        <input type="datetime-local" id=deadline name="deadline1" value="2021-07-1T12:00" min="2021-04-17T00:00" max="2023-06-14T00:00">
				</div>		
				<button type="submit">Submit</button>
			</form>
		</div>
		 
	<%
		
		}catch (Exception ex) {
		out.print(ex);
		out.print("Failed to operate!");
	}
	%>
	</body>
</html>