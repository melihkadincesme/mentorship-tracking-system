<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.tracking.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>CreateDept</title>
	<link rel="stylesheet" href="about.css">
	<link rel="stylesheet" href="box.css">
	
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
			ResultSet rs, rs1;
			
			String code = request.getParameter("ccode");
			rs = st.executeQuery("select unique_code from company where unique_code='" + code + "'");	

			if(rs.next()){
				String get_val = "select c.company_name from company c where c.unique_code=?";
				PreparedStatement ps_val = con.prepareStatement(get_val);
				
				ps_val.setString(1, code);
				rs1 = ps_val.executeQuery();
				
				while(rs1.next()){
				String company_name = rs1.getString("company_name");
				%>
					<form class="box" action="createDeptConfirm.jsp" method = "get">
					<h1>Create a Department for <%=company_name%> </h1>
						<table>
					 			<tr>
					 			 <td id="parag1">Department name</td><td><input type="text" name = "deptName"></td>
					 			</tr>
					 			<input type="hidden" name="code" value="<%=code%>">
					 		</table>
					 		<input type="submit" value="Submit">	 	
					</form>
				<%
				}
			}else{
				out.println("Invalid Unique Code");
			}
		}catch(Exception ex){
			out.print(ex);
			out.print("Failed");
		}
	%>
	</body>
</html>