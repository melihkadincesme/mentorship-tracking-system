<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.tracking.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Choose Side Confirm</title>
	</head>
	<body>
	<%
		try{
			String category = request.getParameter("category12");
			
			if(category.equals("Mentee")){
				response.sendRedirect("menteeCreateAccount.jsp");
			}else if(category.equals("Mentor")){
				response.sendRedirect("createAccount.jsp");
			}else{
				session.invalidate();
				response.sendRedirect("index.jsp");
			}
		
		}catch (Exception ex) {
			out.print(ex);
			out.print("Failed to create an auction!");
		}
	%>
	</body>
</html>