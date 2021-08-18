<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.tracking.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="about.css">
	
	<style>
	p{
			color: white;
			font-family: "Times New Roman", Times, serif;
			font-size: 20px;
	}
	</style>
	</head>
	<body>
	<!-- 
		Store the information to company table in our database
	 -->
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
	<br><br>
	 <%
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			//Create a SQL statement
			Statement st = con.createStatement();
			
			String cname = request.getParameter("cname");
			String cemail = request.getParameter("cemail");
			String unique_code = request.getParameter("uniqueCode");
			
			String insert = "INSERT INTO company(unique_code, company_name, email) VALUES (?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(insert);
			
			ps.setString(1, unique_code);
			ps.setString(2, cname);
			ps.setString(3, cemail);
			
			ps.executeUpdate();

			con.close();
			out.print("<p>Successfully Created a Company!</p>");
			
		}catch(Exception ex){
			out.print(ex);
			out.print("Failed");
		}
	%>
	 
	</body>
</html>