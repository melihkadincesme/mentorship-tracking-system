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
	<title>Description Change</title>
	</head>
	<body>
	<%
	try{
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		int taskID = Integer.parseInt(request.getParameter("taskID"));
		String new_description = request.getParameter("description");
		
		String update_description = "UPDATE task_unique SET description=? WHERE taskID=?";
		PreparedStatement status_ps = con.prepareStatement(update_description);
		status_ps.setString(1, new_description);
		status_ps.setInt(2, taskID);
		status_ps.executeUpdate();
		
		String update_description2 = "UPDATE task SET description=? WHERE taskID=?";
		PreparedStatement status_ps2 = con.prepareStatement(update_description2);
		status_ps2.setString(1, new_description);
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