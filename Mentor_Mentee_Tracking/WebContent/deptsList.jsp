<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.tracking.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Department List</title>
	<link rel="stylesheet" href="about.css">
<style>
h1 {
	color: white;
	text-align: center;
	font-size: 30px;
}

table, th, td {
	border: 1px solid white;
	border-collapse: collapse;
	color: white;
	font-size: 25px;
	text-align: center;
}

table.center {
	margin-left: auto;
	margin-right: auto;
}

p{
	color: white;
	text-align: center;
	font-size: 20px;
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
	<%
	try{
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		ResultSet rs;
		String unique_code = request.getParameter("val");
		out.println(unique_code);
		
		String get_comp_name = "SELECT company_name FROM company where unique_code=?";
		PreparedStatement st_name = con.prepareStatement(get_comp_name);
		
		st_name.setString(1, unique_code);
		rs = st_name.executeQuery();
		
		while(rs.next()){
			String company_name = rs.getString("company_name");
	%>
	<h1>Department Details for company <%=company_name%></h1>
	<br><br>
	<%
		}
	%>
	<table class="center" style="width: 90%">
		<tr>
			<th>Department ID</th>
			<th>Name</th>
		</tr>
		<%
		ResultSet rs2;
		
		String get_dept = "SELECT * FROM department where unique_code=?";
		PreparedStatement st_dept = con.prepareStatement(get_dept);
		
		st_dept.setString(1, unique_code);
		rs2 = st_dept.executeQuery();
				
		while(rs2.next()){
		%>
		<tr>
			<td><%=rs2.getInt("deptID")%></td>
			<td><%=rs2.getString("dept_name")%></td>
		</tr>
		<%	
		}
		%>
	</table>
	
	<p><a href="companyDetConfirm.jsp"><button>Back to Company List</button></a><p>
	<%	
	}catch (Exception ex) {
		out.print(ex);
		out.print("Failed to Display!");
	}
	%>
	</body>
</html>