<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.tracking.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Admin Page</title>
	<link rel="stylesheet" href="about.css">
	
	<style>
		h1{
			color: white;
			font-family: "Times New Roman", Times, serif;
			font-size: 30px;
			text-align: center;
		}
		p{
			color: white;
			font-family: "Times New Roman", Times, serif;
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
	<br><br>
	
	<h1>Admin Page</h1>
	<br>
	<p>Hello Admin! Please select from the navigation bar to continue.</p>
	<p>If you want to create a new company, please go to "Create Company" bar.</p>
	<p>If you want to create a new department for that company, please navigate to "Create Department" bar.</p>
	<br>
	
	</body>
</html>