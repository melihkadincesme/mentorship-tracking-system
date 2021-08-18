<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.tracking.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Table of Companies</title>
	<link rel="stylesheet" href="about.css">
	<style>
h1 {
	color: white;
	text-align: center;
	font-size: 30px;
}

table, th, td {
	border: 1px solid white;
	border-collapse: collapse;
	color: white;
	font-size: 25px;
	text-align: center;
}

table.center {
	margin-left: auto;
	margin-right: auto;
}

button{
	text-align: center;
	font-size: 20px; 
}
</style>
	</head>
	<body>
	
	<header>
	<a class="logo" href="adminPage.jsp"><img src="logo-whitetulip-health.png" alt="logo" width="300" height="100"></a>
            <nav>
                <ul class="nav__links">
                    <li><a href="createCompany.jsp">Create Company</a></li>
                    <li><a href="createDepartment.jsp">Create Department</a></li>
                    <li><a href="showDetails.jsp">Show Details</a></li>
                    <li><a href="contactAdmin.jsp">Contact</a></li>
                </ul>
            </nav>
            <a class="cta" href="logout.jsp">Logout</a>		
	</header>

	<h1>Company Details</h1>
	<br><br>
	<table class="center" style="width: 90%">
		<tr>
			<th>Departments</th>
			<th>Name</th>
			<th>Unique Code</th>
			<th>Email<th>
		</tr>
	<%
	try{
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		ResultSet rs;
				
		rs = stmt.executeQuery("SELECT * FROM company");
		
		while(rs.next()){
		%>
		<tr>
			<td><a href="deptsList.jsp?val=<%=rs.getString("unique_code")%>"><button>Link</button></a></td>
			<td><%=rs.getString("company_name")%></td>
			<td><%=rs.getString("unique_code")%></td>
			<td><%=rs.getString("email")%></td>
		</tr>
		<% 
		}
	
	}catch (Exception ex) {
		out.print(ex);
		out.print("Failed to Display!");
	}
	%>
	</table>
</body>
</html>