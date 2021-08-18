<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.tracking.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Create Department</title>
	<link rel="stylesheet" href="about.css">
	<link rel="stylesheet" href="box.css">
	
	<style>
		#parag1 {
			color:white;
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
	
	<form class="box" action="createDept.jsp" method = "get">
		<h1>Create a Company</h1>
			<table>
		 			<tr>
		 			 <td id="parag1">Company Unique Code</td><td><input type="text" name = "ccode"></td>
		 			</tr>
		 		</table>
		 		<input type="submit" value="Submit">	 	
		</form>
	</body>
</html>