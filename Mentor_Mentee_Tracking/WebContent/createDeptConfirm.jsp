<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.tracking.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>CreateDeptConfirm</title>
	<link rel="stylesheet" href="about.css">
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
	
	<%
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			//Create a SQL statement
			Statement st = con.createStatement();
			ResultSet rs = null;
			
			String count = "SELECT COUNT(*) FROM department";
			PreparedStatement ps1 = con.prepareStatement(count);
			rs = ps1.executeQuery();
			rs.next();
			
			int deptID = rs.getInt("count(*)") + 1;
			String unique_code = request.getParameter("code");
			String dept_name = request.getParameter("deptName");
			
			String insert = "INSERT INTO department(deptID, unique_code, dept_name) VALUES (?, ?, ?)";
			
			PreparedStatement ps = con.prepareStatement(insert);

			ps.setInt(1, deptID);
			ps.setString(2, unique_code);
			ps.setString(3, dept_name);
			
			ps.executeUpdate();
			con.close();
			out.print("Successfully Added a department to " + dept_name);

		}catch(Exception ex){
			out.print(ex);
			out.print("Failed");
		}
	%>
	
	</body>
</html>