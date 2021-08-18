<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.tracking.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Choose Create Account Side</title>
	<link rel="stylesheet" href="about.css">
	<link rel="stylesheet" href="box.css">
	<style>
	.box input[list="category12"]{
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
		
		<form class="box" action="chooseSideConfirm.jsp" method = "get">
		<h1>Choose Type of Account</h1>
			<table>
		 			<tr>
		 			 <td id="parag1">Type of Account</td><td>
						 <input list="category12" name="category12">
						 
						 <datalist id="category12">
							 <option value="Mentee">
							 <option value="Mentor">
						 </datalist> 
					 </td>
					 
		 			</tr>
		 		</table>
		 		<input type="submit" value="Submit">	 	
		</form>
	</body>
</html>