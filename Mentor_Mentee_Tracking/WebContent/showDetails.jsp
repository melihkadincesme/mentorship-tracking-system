<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.tracking.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Show Company Details</title>
	<link rel="stylesheet" href="about.css">
	<link rel="stylesheet" href="box.css">
	
	<style>
	h1{
			color: white;
			font-family: "Times New Roman", Times, serif;
			font-size: 30px;
			text-align: center;
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
	
	<form class="box" action="companyDetails.jsp" method = "get">
		<h1>Access All Company Details</h1>
			<table>
		 			<tr>
		 			 <td id="parag1">Admin Unique Code</td><td><input type="password" name = "cust_code"></td>
		 			</tr>
		 		</table>
		 		<input type="submit" value="Submit">	 	
	</form>
	
</body>
</html>