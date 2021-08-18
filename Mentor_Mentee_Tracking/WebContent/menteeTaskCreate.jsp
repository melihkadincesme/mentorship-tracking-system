<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.tracking.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Mentee Task Create</title>
	</head>
	<link rel="stylesheet" href="about.css">
	<link rel="stylesheet" href="contactFile.css">
	
	<style>
		h1{
			font-family: "Times New Roman", Times, serif;
			color: white;
			text-align: center;	
			font-size: 30px;
		}
		p{
			font-family: "Times New Roman", Times, serif;
			color: white;
			font-size: 20px;
		}
		.form1{
			  font-size: 18px;
		}
		
		.form2{
			font-size: 18px;
		}
	</style>
	
	<body>
	<header>
		<a class="logo" href="mentor_main.jsp"><img src="logo-whitetulip-health.png" alt="logo" width="300" height="100"></a>
            <nav>
                <ul class="nav__links">
                    <li><a href="mentor_main.jsp">Dashboard</a></li>
                    <li><a href="menteeTaskCreate.jsp">Create a Task</a></li>
                    <li><a href="manageTasks.jsp">Manage Tasks</a></li>
                    <li><a href="communicationMentor.jsp">Communication</a></li>
                    <li><a href="seeMentees.jsp">See Mentees</a></li>
                </ul>
            </nav>
            <a class="cta" href="logout.jsp">Logout</a>		
	</header>
	
	<h1>Create a Mentee Task</h1>
	<br>
	<br><br>	
	<%
	
	try{
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		Statement stmt1 = con.createStatement();

		
		ResultSet rs;
		ResultSet rs_mentor_name;
		
		String mentor_userName = session.getAttribute("Username").toString();
		
		rs_mentor_name = stmt.executeQuery("SELECT full_name from mentor where username='" + mentor_userName + "'" + ";");

		while(rs_mentor_name.next()){
			String mentor_name = rs_mentor_name.getString("full_name");
			
			rs = stmt1.executeQuery("SELECT full_name from mentee where mentor_name ='" + mentor_name + "'" + ";");			
		%>
		<section>
		<div class="container">
			<form action="taskConfirm.jsp" method="POST" id="my-form">
				
				<div class="form-group">
					<label for="title">Title</label> 
					<input type="text" id="title" name="title">
				</div>
				
				<div class="form-group">
					<label for="description">Description</label>
					<textarea name="description" id="description" cols="30" rows="10"></textarea>
				</div>
				<div class="form1">
				<label for="massage">Mentees</label><br>
		<% 
			while(rs.next()){ //display mentees' name while looping. You can put it into array list.
				%>		
					<input type="checkbox" name="mentee" value="<%=rs.getString("full_name")%>"><%=rs.getString("full_name")%>
				<% 
			}
			%>
			</div>
			<br>
			<div class="form1">
			<label for="deadline">Deadline</label><br>
			 <input type="radio" id="no_deadline" name="deadline" value="no_deadline">No Deadline
			 <input type="radio" id="choose_deadline" name="deadline" value="yes_deadline">Choose a Deadline 
			</div>
				<%
		}
		%>
		<button type="submit">Continue</button>
			</form>
		</div>
	</section>
	
	<%
	
	}catch (Exception ex) {
		out.print(ex);
		out.print("Failed to create an auction!");
	}
	
	
	%>
	
	
	</body>
	
</html>