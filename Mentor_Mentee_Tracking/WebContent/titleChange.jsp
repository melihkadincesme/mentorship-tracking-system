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
	<title>Title Change</title>
	<link rel="stylesheet" href="about.css">
	
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
                    <li><a href="mentorUserSettings.jsp">User Settings</a></li>
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
		String new_title = request.getParameter("title");
		
		String update_title = "UPDATE task_unique SET title=? WHERE taskID=?";
		PreparedStatement status_ps = con.prepareStatement(update_title);
		status_ps.setString(1, new_title);
		status_ps.setInt(2, taskID);
		status_ps.executeUpdate();
		
		String update_title2 = "UPDATE task SET title=? WHERE taskID=?";
		PreparedStatement status_ps2 = con.prepareStatement(update_title2);
		status_ps2.setString(1, new_title);
		status_ps2.setInt(2, taskID);
		status_ps2.executeUpdate();
		
		response.sendRedirect("manageTasks.jsp");
	}catch (Exception ex) {
		out.print(ex);
		out.print("Failed to operate!");
	}
	%>
	</body>
</html>