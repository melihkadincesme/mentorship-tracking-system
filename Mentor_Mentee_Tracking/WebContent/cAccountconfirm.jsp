<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.tracking.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Company Unique Code Confirm</title>
	</head>
	<body>
	<%
	try{
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String code = request.getParameter("ccode");
		ResultSet rs;
		
		String get_code = "SELECT * from company where unique_code=?";
		PreparedStatement ps_val = con.prepareStatement(get_code);
		ps_val.setString(1, code);
		
		rs = ps_val.executeQuery();
		
		if(rs.next()){
			session.setAttribute("company_code", code);
			//response.sendRedirect("createAccount.jsp");
			response.sendRedirect("chooseSide.jsp");
		}else{
			response.sendRedirect("index.jsp");
		}

		
	}catch (Exception ex) {
		out.print(ex);
		out.print("Failed to Display!");
	}
	%>
	
	</body>
</html>