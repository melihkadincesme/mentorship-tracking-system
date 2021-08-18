<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.tracking.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Create Account Confirm</title>
	<link rel="stylesheet" href="about.css">
	<style>
	p{
		color:white;
		font-family: "Lucida Console", "Courier New", monospace;
		text-align: center;	
		font-size: 20px;
	}
	</style>
	</head>
	<body>
	
	<header>
		<a class="logo" href="index.jsp"><img src="logo-whitetulip-health.png" alt="logo" width="300" height="100"></a>
            <nav>
                <ul class="nav__links">
                    <li><a href="index.jsp">Login</a></li>
                    <li><a href="about.jsp">About</a></li>
                </ul>
            </nav>
            <a class="cta" href="contact.jsp">Contact</a>		
	</header>
	<%
			try{
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
				//Create a SQL statement
				Statement stmt = con.createStatement();
				
				String name = request.getParameter("name");
				String username = request.getParameter("username1");
				String password = request.getParameter("password1");
				String email = request.getParameter("email");
				String dob = request.getParameter("dob");
				String dept_name = request.getParameter("category");
				String code = session.getAttribute("company_code").toString();
								
				String create_mentor = "INSERT INTO mentor(full_name, username, email, dob, password, dept_name, unique_code) VALUES (?, ?, ?, ?, ?, ?, ?)";
				PreparedStatement ps_val = con.prepareStatement(create_mentor);
				
				ps_val.setString(1, name);
				ps_val.setString(2, username);
				ps_val.setString(3, email);
				ps_val.setString(4, dob);
				ps_val.setString(5, password);
				ps_val.setString(6, dept_name);
				ps_val.setString(7, code);
				
				ps_val.executeUpdate();

				con.close();
				session.invalidate();
				out.println("<p>Successfully Created a Mentor Account");
		}catch (Exception ex) {
			out.print(ex);
			out.print("Failed to Display!");
		}
		%>
	
	
	</body>
</html>