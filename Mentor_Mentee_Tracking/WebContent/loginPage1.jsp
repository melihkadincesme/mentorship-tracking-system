<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.tracking.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Login Page1</title>
	<link rel="stylesheet" href="about.css">
	
	<style>
		body{
			margin: 0;
			padding: 0;
			font-family: "Times New Roman", Times, serif;
			background-image: url(1.jpg); 
		 	background-repeat: no-repeat;
		 	background-size: auto;
		 	background-position: center; 
		}
	h3{
		font-family: "Times New Roman", Times, serif;
		color: white;
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
		<br><br>
	<%
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			//Create a SQL statement
			Statement st1 = con.createStatement();
			Statement st2 = con.createStatement();
			Statement st3 = con.createStatement();

			
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			ResultSet rs_mentor = null; 
			ResultSet rs_mentee = null;
			ResultSet rs_admin = null;
			
			rs_mentor = st1.executeQuery("select username, password from mentor where username='" + username + "' and password='" + password + "'");
			rs_mentee = st2.executeQuery("select username, password from mentee where username='" + username + "' and password='" + password + "'");
			rs_admin = st3.executeQuery("select username, password from customer_rep where username='" + username + "' and password='" + password + "'");

			//Check what kind of user logged in
			if(rs_mentor.next()){
				session.setAttribute("Username", username);
				out.println("Welcome user");
				out.println("<a href = 'logout.jsp'>Log out</a>");
				response.sendRedirect("mentor_main.jsp");
			}else if(rs_mentee.next()){
				session.setAttribute("Username", username);
				out.println("Welcome user");
				out.println("<a href = 'logout.jsp'>Log out</a>");
				response.sendRedirect("mentee_main.jsp");
			}else if(rs_admin.next()){
				session.setAttribute("Username", username);
				out.println("Welcome user");
				out.println("<a href = 'logout.jsp'>Log out</a>");
				response.sendRedirect("adminPage.jsp");	
			}else{
				out.println("<h3>Invalid Login Details. Please try again</h3>");	
			}
			
			con.close();

		}catch(Exception ex){
			out.print(ex);
			out.print("Failed");
		}
	%>
	</body>
</html>