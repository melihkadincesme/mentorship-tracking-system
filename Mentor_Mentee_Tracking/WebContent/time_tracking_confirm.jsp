<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.tracking.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Time Tracking Confirm</title>
	</head>
	<body>
	<% 
		try{
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			String title = request.getParameter("task_choose");
			String description = request.getParameter("description");
			int hours = Integer.parseInt(request.getParameter("num_hours"));
			String date = request.getParameter("date_task");
			String mentee_name = request.getParameter("mentee_name");
			
			String insert = "INSERT INTO time_tracking(title, description, full_name, num_hours, date_tracking) VALUES (?, ?, ?, ?, ?)";
			PreparedStatement ps_val = con.prepareStatement(insert);
			
			ps_val.setString(1, title);
			ps_val.setString(2, description);
			ps_val.setString(3, mentee_name);
			ps_val.setInt(4, hours);
			ps_val.setString(5, date);
			
			ps_val.executeUpdate();
			
			response.sendRedirect("mentee_time_tracking.jsp");
			
		}catch (Exception ex) {
			out.print(ex);
			out.print("Failed to Display!");
		}
	%>
	</body>
</html>