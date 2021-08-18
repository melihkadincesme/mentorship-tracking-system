<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.tracking.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<!--  -->

<html>
	<head>
		<meta charset="UTF-8">
		<title>Login Page</title>
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
		
		#para1, #para2 {
			color:white;
		}
		
		.box input[type = "submit"]:hover{
			background: #2ecc71;
		}
		
		h1{
			color:white;
			font-family: "Lucida Console", "Courier New", monospace;
			text-align: center;			
		}
		
		* {
		  box-sizing: border-box;
		  margin: 0;
		  padding: 0;
		}
		
		header {
		  display: flex;
		  justify-content: flex-end;
		  align-items: center;
		  padding: 4px 7%;
		  /*background-color: #24252a;*/
		}
		
		.logo {
		  margin-right: auto;
		}
		
		.nav__links {
		  list-style: none;
		  display: flex;
		}
		
		.nav__links a,
		.cta,
		.overlay__content a {
		  font-family: "Times New Roman", Times, serif;
		  font-weight: 500;
		  color: #edf0f1;
		  text-decoration: none;
		}
		
		.nav__links li {
		  padding: 0px 20px;
		}
		
		.nav__links li a {
		  transition: all 0.3s ease 0s;
		}
		
		.nav__links li a:hover {
		  color: #0088a9;
		}
		
		.cta {
		  margin-left: 20px;
		  padding: 9px 25px;
		  background-color: rgba(0, 136, 169, 1);
		  border: none;
		  border-radius: 50px;
		  cursor: pointer;
		  transition: all 0.3s ease 0s;
		}
		
		.cta:hover {
		  background-color: rgba(0, 136, 169, 0.8);
		}
		
		/* Mobile Nav */
		
		.menu {
		  display: none;
		}
		
		.overlay {
		  height: 100%;
		  width: 0;
		  position: fixed;
		  z-index: 1;
		  left: 0;
		  top: 0;
		  background-color: #24252a;
		  overflow-x: hidden;
		  transition: all 0.5s ease 0s;
		}
		
		.overlay--active {
		  width: 100%;
		}
		
		.overlay__content {
		  display: flex;
		  height: 100%;
		  flex-direction: column;
		  align-items: center;
		  justify-content: center;
		}
		
		.overlay a {
		  padding: 15px;
		  font-size: 36px;
		  display: block;
		  transition: all 0.3s ease 0s;
		}
		
		.overlay a:hover,
		.overlay a:focus {
		  color: #0088a9;
		}
		.overlay .close {
		  position: absolute;
		  top: 20px;
		  right: 45px;
		  font-size: 60px;
		  color: #edf0f1;
		  cursor: pointer;
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
		
		<h1>Mentor Mentee Tracking System</h1>
		
		<form class="box" action="loginPage1.jsp" method = "get">
			<h1>Login</h1>
			<input type = "text" name="username" placeholder = "username">
			<input type = "password" name="password" placeholder = "password">
			<input type = "submit" value="Login">
			<p id="para2"> Don't have your account?</p>
			<br>
			<a id="para1" href='createAccount1.jsp'>Create Account</a> 
		</form>
	</body>
</html>

