<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.tracking.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "java.io.*,java.util.*,javax.mail.*"%>
<%@ page import = "javax.mail.internet.*,javax.activation.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.sql.Timestamp,java.text.SimpleDateFormat,java.util.Date" %>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>See Mentees</title>
	<link rel="stylesheet" href="about.css">
	</head>
	<style>
	h1{
			font-family: "Times New Roman", Times, serif;
			color: white;
			text-align: center;	
			font-size: 30px;
	}
	.content-table {
	  border-collapse: collapse;
	 /* margin: 25px 0;*/
	  font-size: 0.9em;
	  min-width: 400px;
	  border-radius: 5px 5px 0 0;
	  overflow: hidden;
	  box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
	  margin-left: auto;
	  margin-right: auto;
	}
	
	.content-table thead tr {
	  background-color: #009879;
	  color: #ffffff;
	  text-align: center;
	  font-weight: bold;
	  font-size: 18px;
	  
	}
	
	.content-table th,
	.content-table td {
	  padding: 12px 15px;
	}
	
	.content-table tbody tr {
	  border-bottom: 1px solid;
	  text-align: center;
	  font-size: 18px;
	  font-family: "Times New Roman", Times, serif;
	}
	
	.content-table tbody tr:nth-of-type(even) {
	  background-color: #AFE5A8;*/
	}
	
	.content-table tbody tr:nth-of-type(odd) {
	  background-color: #D8D8D4;*/
	}
	
	.content-table tbody tr:last-of-type {
	  border-bottom: 2px solid #009879;*/
	}
	
	.button {
	  background-color: #4CAF50; /* Green */
	  border: none;
	  color: white;
	  padding: 10px 17px;
	  text-align: center;
	  text-decoration: none;
	  display: inline-block;
	  font-size: 16px;
	  margin: 4px 2px;
	  transition-duration: 0.4s;
	  cursor: pointer;
	  font-family: "Times New Roman", Times, serif;
	  
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
	
	
	
	.topnav {
  overflow: hidden;
 margin-right: 80px;
}

.topnav a {
  float: left;
  display: block;
  color: black;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  font-size: 17px;
}

.topnav a:hover {
  background-color: #ddd;
  color: black;
}

.topnav a.active {
  background-color: #2196F3;
  color: white;
}

.topnav input[type=text] {
  float: right;
  padding: 6px;
  margin-top: 8px;
  margin-right: 16px;
  border: none;
  font-size: 17px;
}

@media screen and (max-width: 600px) {
  .topnav a, .topnav input[type=text] {
    float: none;
    display: block;
    text-align: left;
    width: 100%;
    margin: 0;
    padding: 14px;
  }
  
  .topnav input[type=text] {
    border: 1px solid #ccc;  
  }
}
.topnav {
  overflow: hidden;
 
}
	</style>

<script>
	function myFunction() {
		var input, filter, table, tr, td, i, txtValue;
		input = document.getElementById("myInput");
		filter = input.value.toUpperCase();
		table = document.getElementById("myTable");
		tr = table.getElementsByTagName("tr");
		for (i = 0; i < tr.length; i++) {
			td = tr[i].getElementsByTagName("td")[0];
			if (td) {
				txtValue = td.textContent || td.innerText;
				if (txtValue.toUpperCase().indexOf(filter) > -1) {
					tr[i].style.display = "";
				} else {
					tr[i].style.display = "none";
				}
			}
		}
	}
</script>

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
	
	<h1>Mentee Details</h1><br>
	
	<div class="topnav">
		<input type="text" id="myInput" onkeyup="myFunction()" placeholder="Search for names.." title="Type in a name">
  	</div>
  	<br>
	<table class="content-table" style="width: 90%" id="myTable">
	<thead>
		<tr>
			<th>Full Name</th>
			<th>Email</th>
			<th>Phone Number</th>
			<th>Position</th>
			<th>Medical School</th>
			<th>graduation Year</th>
			<th>Location</th>
			<th>See Task Status</th>
			<th>See Time Tracking</th>
		</tr>
	</thead>
	<%
	try{
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String mentor_userName = session.getAttribute("Username").toString();
		ResultSet rs_mentor;
		
		rs_mentor = stmt.executeQuery("select full_name from mentor where username='" + mentor_userName + "'");
		
		while(rs_mentor.next()){
			String mentor_name = rs_mentor.getString("full_name");
			
			ResultSet rs_mentee;
			String mentee_deatils = "SELECT full_name, email, phone, position, school, grad_year, location FROM mentee WHERE mentor_name=?";
			PreparedStatement ps_check = con.prepareStatement(mentee_deatils);
			ps_check.setString(1, mentor_name);
			rs_mentee = ps_check.executeQuery();
			
			while(rs_mentee.next()){
				String mentee_name = rs_mentee.getString("full_name");
				String email = rs_mentee.getString("email");
				String phone = rs_mentee.getString("phone");
				String position = rs_mentee.getString("position");
				String school = rs_mentee.getString("school");
				int grad_year = rs_mentee.getInt("grad_year");
				String location = rs_mentee.getString("location");
			%>
			<tr>
				<td><%= mentee_name%></td>
				<td><%= email%></td>
				<td><%= phone%></td>
				<td><%= position%></td>
				<td><%= school%></td>
				<td><%= grad_year%></td>
				<td><%= location%></td>
				<td><a href="mentee_tasks.jsp?mentee_name=<%=mentee_name%>"><button class="button button1">Tasks</button></a></td>
				<td><a href="mentee_time_mentor.jsp?mentee_name=<%=mentee_name%>"><button class="button button1">Time</button></a></td>
			</tr>
			<%	
			}
		}
		
	}catch (Exception ex) {
		out.print(ex);
		out.print("Failed to Display!");
	}	
	%>
	</table>
	</body>
</html>