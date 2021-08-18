<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.tracking.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Code Confirm</title>
	<style>
	p{
			color: white;
			font-family: "Times New Roman", Times, serif;
			font-size: 30px;
			text-align: center;
		}
	</style>
	</head>
	<body>
	
	<%
	try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement st = con.createStatement();
	
		ResultSet rs;
		
		String code = request.getParameter("cust_code");
		rs = st.executeQuery("select * from customer_rep where cust_code='" + code + "'");
		
		if(rs.next()){
			response.sendRedirect("companyDetConfirm.jsp");
		}else{
			out.println("<p>Invalid admin code</p>");
		}
	}catch(Exception ex){
		out.print(ex);
		out.print("Failed");
	}
	%>
	</body>
</html>