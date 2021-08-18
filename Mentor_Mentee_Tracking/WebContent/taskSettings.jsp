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
	<title>Mentor Task Settings Page</title>
	<link rel="stylesheet" href="about.css">
	<style>
	.container {
	  width: 90%;
	  max-width: 500px;
	  margin: 0 auto;
	  padding: 10px;
	  box-shadow: 0px 0px 20px #00000010;
	  background-color: white;
	  border-radius: 8px;
	  margin-bottom: 20px;
	}
	.form-group {
	  width: 100%;
	  margin-top: 10px;
	  font-size: 20px;
	  text-align: center;
	}
	.form-group input,
	.form-group textarea {
	  width: 100%;
	  padding: 5px;
	  font-size: 18px;
	  border: 1px solid rgba(128, 128, 128, 0.199);
	  margin-top: 5px;
	  font-family: "Times New Roman", Times, serif;
	}
	.current{
	  text-align: center;
	  box-shadow: 0px 0px 20px #00000010;
	  background-color: #E6EBF0;
	  border-radius: 8px;
	  
	}
	textarea {
	  resize: vertical;
	}
	button[type="submit"] {
	  width: 50%;
	  border: none;
	  outline: none;
	  padding: 5px;
	  font-size: 20px;
	  border-radius: 5px;
	  font-family: "Montserrat";
	  color: rgb(27, 166, 247);
	  text-align: center;
	  cursor: pointer;
	  margin-top: 8px;
	  margin-left: 120px;
	  transition: 0.3s ease background-color;
	}
	
	button[type="submit"]:hover {
	  background-color: rgb(214, 226, 236);
	}
	#status {
	  width: 90%;
	  max-width: 500px;
	  text-align: center;
	  padding: 10px;
	  margin: 0 auto;
	  border-radius: 8px;
	}
	#status.success {
	  background-color: rgb(211, 250, 153);
	  animation: status 4s ease forwards;
	}
	#status.error {
	  background-color: rgb(250, 129, 92);
	  color: white;
	  animation: status 4s ease forwards;
	}
	@keyframes status {
	  0% {
	    opacity: 1;
	    pointer-events: all;
	  }
	  90% {
	    opacity: 1;
	    pointer-events: all;
	  }
	  100% {
	    opacity: 0;
	    pointer-events: none;
	  }
	}
	</style>
	</head>
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
	<%
	try{
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		int taskID = Integer.parseInt(request.getParameter("val2"));
		ResultSet rs;
		
		String get_vals = "SELECT title, description FROM task_unique WHERE taskID = ?";
		PreparedStatement ps3 = con.prepareStatement(get_vals);
		ps3.setInt(1, taskID);
		rs = ps3.executeQuery();
		
		while(rs.next()){
			String title = rs.getString("title");
			String description = rs.getString("description");
			
		%>	
		<div class="container">
			<form action="titleChange.jsp" method="GET" id="my-form">
					<div class="form-group">
						<label for="title">Title</label><br><br>
						<div class="current">
							<p><%= title%></p>
						</div><br>
						<p style="text-align:left;">Change Title:</p>
						<input type="text" id="title" name="title">
					</div>
					<input type="hidden" name="taskID" value="<%=taskID%>">
					<button type="submit">Submit</button>
			</form>
			<br>
			<form action="descriptionChange.jsp" method="POST" id="my-form">
					<div class="form-group">
						<label for="title">Description</label><br><br>
						<div class="current">
							<p><%= description%></p>
						</div><br>
						<p style="text-align:left;">Change Description:</p>
						<input type="hidden" name="taskID" value="<%=taskID%>">
						<textarea name="description" id="description" cols="30" rows="10"></textarea></div>
					<button type="submit">Submit</button>
			</form>
			<br>
			
		</div>
		<% 
		}
		
	}catch (Exception ex) {
		out.print(ex);
		out.print("Failed to operate!");
	}
	%>
	</body>
</html>