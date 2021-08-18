<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.tracking.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>

<html>
	<head>
	<meta charset="UTF-8">
	<title>Create Company</title>
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
		
		.box{
			width: 300px;
			padding: 40px;
			position: absolute;
			top: 50%;
			left: 50%;
			transform: translate(-50%, -50%);
			text-align: center;
		}
		
		.box h1{
			color: white;
			text-transform: uppercase;
			font-weight: 500;
		}
		
		.box input[type = "text"], .box input[type = "password"]{
			border: 0;
			background: none;
			font-size: 15px;
			font-family: "Times New Roman", Times, serif;
			display: block;
			margin: 20px auto;
			text-align: center;
			border: 2px solid #3498db;
			padding: 14px 10px;
			width: 200px;
			outline: none;
			color: white;
			border-radius: 24px;
			transition: 0.25s;
		}
		
		.box input[type = "text"]:focus, .box input[type = "password"]:focus{
			width: 280px;
			border-color: #2ecc71;
		}
		
		.box input[type = "submit"]{
			border:0;
			background: none;
			display: block;
			margin: 20px auto;
			text-align: center;
			border:2px solid #2ecc71;
			padding: 14px 40px;
			width: 200px;
			outline: none;
			color: white;
			border-radius: 24px;
			transition: 0.25s;
			cursor: pointer;
		}
		
		#parag1, #parag2, #parag3 {
			color:white;
		}
		
		.box input[type = "submit"]:hover{
			background: #2ecc71;
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
	
	<form class="box" action="createCompanyConfirm.jsp" method = "get">
		<h1>Create a Company</h1>
			<table>
		 			<tr>
		 			 <td id="parag1">Company Name</td><td><input type="text" name = "cname"></td>
		 			</tr>
		 			<tr>
		 				<td id="parag2">Company Email</td><td><input type="text" name = "cemail"></td>
		 			</tr>
		 			<tr>
		 				<td id="parag3">Company Unique Code</td><td><input type="text" name = "uniqueCode"></td>
		 			</tr>
		 		</table>
		 		<input type="submit" value="Submit">	 	
		</form>
		
	</body>
</html>