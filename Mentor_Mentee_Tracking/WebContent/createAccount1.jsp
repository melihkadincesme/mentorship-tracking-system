<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.tracking.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Unique Code Create Account</title>
	<link rel="stylesheet" href="about.css">
	<link rel="stylesheet" href="box.css">
	
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
		
		<form class="box" action="cAccountconfirm.jsp" method = "get">
		<h1>Create an Account</h1>
			<table>
		 			<tr>
		 			 <td id="parag1">Company Unique Code</td><td><input type="text" name = "ccode"></td>
		 			</tr>
		 		</table>
		 		<input type="submit" value="Submit">	 	
		</form>
	</body>
</html>