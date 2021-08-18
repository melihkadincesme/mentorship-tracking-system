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
	<title>Deadline Change Confirm</title>
	</head>
	<body>
	<%
	try{
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String deadline = request.getParameter("deadline1");
		String mentee_name = (String)session.getAttribute("mentee_name1");
		int taskID = (Integer)session.getAttribute("taskID1");	
				
		String update_deadline = "UPDATE task SET deadline=? WHERE mentee_name=? and taskID=?";
		PreparedStatement ps_check2 = con.prepareStatement(update_deadline);
		ps_check2.setString(1, deadline);
		ps_check2.setString(2, mentee_name);
		ps_check2.setInt(3, taskID);

		ps_check2.executeUpdate();
		
		response.sendRedirect("manageTasks.jsp");
		
	}catch (Exception ex) {
		out.print(ex);
		out.print("Failed to operate!");
	}
	%>
	</body>
</html>