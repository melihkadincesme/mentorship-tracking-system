<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.tracking.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Mentee Main</title>
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
		#para1{
			font-family: "Times New Roman", Times, serif;
			color: black;
			font-size: 20px;
			text-align:center;
		}
		#para2{
			text-align: center;
			color: black;
			font-size: 20px;
			 font-family: "Times New Roman", Times, serif;
		}
		
		.inside{
			width: 100%;
			max-width: 500px;
			margin: 0 auto;
			padding: 10px;
			box-shadow: 0px 0px 20px #00000010;
			background-color: #BBBBBB;
			border-radius: 8px;
			margin-bottom: 20px;
			 font-family: "Times New Roman", Times, serif;
		}
		
		.button {
		  background-color: #4CAF50; /* Green */
		  border: none;
		  color: white;
		  padding: 10px 17px;
		  text-align: center;
		  text-decoration: none;
		  display: inline-block;
		  font-size: 20px;
		  margin: 4px 2px;
		  transition-duration: 0.4s;
		  cursor: pointer;
		  font-family: "Times New Roman", Times, serif;
		  width: 70%;
		  margin-left: 75px;
		}
		
		.button1 {
		  background-color: green; 
		  color: white; 
		  border: 2px solid #4CAF50;
		}
		
		.button1:hover {
		  background-color: #4CAF50;
		  color: white;
		}
	</style>
	</head>
	<body>
	<header>
		<a class="logo" href="mentee_main.jsp"><img src="logo-whitetulip-health.png" alt="logo" width="300" height="100"></a>
            <nav>
                <ul class="nav__links">
                    <li><a href="mentee_main.jsp">Dashboard</a></li>
                    <li><a href="see_mentee_tasks.jsp">Assigned Tasks</a></li>
                    <li><a href="communicationMentee.jsp">Communication</a></li>
                    <li><a href="mentee_time_tracking.jsp">Time Tracking</a></li>
                </ul>
            </nav>
            <a class="cta" href="logout.jsp">Logout</a>		
	</header>
	<%
		try{
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			ResultSet rs_name, rs_total, rs_complete, rs_inProgress, rs_NotStarted;
			
			String mentee_userName = session.getAttribute("Username").toString();
			
			rs_name = stmt.executeQuery("SELECT full_name FROM mentee WHERE username='" + mentee_userName + "';");
			rs_name.next();
			String mentee_name = rs_name.getString("full_name");

			String total = "SELECT count(*) FROM task WHERE mentee_name='" + mentee_name + "'";
			PreparedStatement ps1 = con.prepareStatement(total);
			rs_total = ps1.executeQuery();
			rs_total.next();
			int total_tasks = rs_total.getInt("count(*)");
			
			String complete = "SELECT count(*) FROM task WHERE mentee_name= '" + mentee_name + "' and status = 'Complete';";
			PreparedStatement ps2 = con.prepareStatement(complete);
			rs_complete = ps2.executeQuery();
			rs_complete.next();
			int complete_tasks = rs_complete.getInt("count(*)");
			
			String inProgress_task = "SELECT count(*) FROM task WHERE mentee_name= '" + mentee_name + "' and status = 'In Progress';";
			PreparedStatement ps3 = con.prepareStatement(inProgress_task);
			rs_inProgress = ps3.executeQuery();
			rs_inProgress.next();
			int in_progess = rs_inProgress.getInt("count(*)");
			
			String not_startedTask = "SELECT count(*) FROM task WHERE mentee_name= '" + mentee_name + "' and status = 'Not Started';";
			PreparedStatement ps4 = con.prepareStatement(not_startedTask);
			rs_NotStarted = ps4.executeQuery();
			rs_NotStarted.next();
			int not_started = rs_NotStarted.getInt("count(*)");
			
			%>
			<br>
				<h1>Welcome <%=mentee_name%>!</h1>
			<br>
			
			<div class="container">
				<p id="para2">Dashboard</p><br>
				<div class="inside">
					<p id="para1">Total Tasks Assigned <br>
					<%= total_tasks %>
				</p>
				</div>
				
				<div class="inside">
					<p id="para1">Total Complete Tasks <br>		
					<%= complete_tasks %>
				</p>
				</div>
				
				<div class="inside">
					<p id="para1">Total In-Progress Tasks<br>			
					<%= in_progess %>
					</p>
				</div>
				
				<div class="inside">
					<p id="para1">Total Not Started Tasks <br>			
					<%= not_started %>
					</p>
				</div>
				<a href="see_mentee_tasks.jsp"><button class="button button1">See Tasks</button></a>
			</div>	
			<%
		}catch (Exception ex) {
			out.print(ex);
			out.print("Failed to Display!");
		}
	%>
	</body>
</html>