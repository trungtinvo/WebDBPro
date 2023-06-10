<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Current Class Report</title>
</head>

<style>
table, th, td {
  border:1px solid black;
}
</style>

<body>
	<%-- Set the scripting language to Java and --%>
	<%@ page language="java" import="java.sql.*" %>

	<%-- -------- Open Connection Code -------- --%>
	<%
	try {
		// Load Oracle Driver class file
		DriverManager.registerDriver (new org.postgresql.Driver());
		//String GET_ADVISOR_QUERY = "Select * from advisor";
				
		// Make a connection to the Oracle datasource
		Connection connection = DriverManager.getConnection
		("jdbc:postgresql:tables?user=postgres&password=ahvuong");
	%>
	<%-- Check if an insertion is requested --%>
	<% 
		String action = request.getParameter("action");
		String GET_STUDENT_QUERY = "SELECT * FROM students";
		String ssn = "";
		String first = "";
		String middle = "";
		String last = "";
		ResultSet class_info = null;
    	ResultSet student_info = null;
    
    	// Select all class's information
    	connection.setAutoCommit(false);
		PreparedStatement stmt = connection.prepareStatement(GET_STUDENT_QUERY);
	
		student_info = stmt.executeQuery();
		connection.commit();
		connection.setAutoCommit(true);
	
		
		if (action != null && action.equals("submit")) 
		{
			connection.setAutoCommit(false); %>
	<%-- Create the prepared statement and use it to --%>
	<%-- INSERT the advisor attrs INTO the advisor table. --%>
	<% 
			PreparedStatement stmt1 = connection.prepareStatement(
						"SELECT * " +
						"FROM course_enrollment c " +
						"WHERE c.student_id = " +
						"(SELECT student_id FROM students " +
						"WHERE ssn = ?)"
						);
			
				stmt1.setInt(1, Integer.parseInt(request.getParameter("ssn")));
				//System.out.println("Test3");
			
			class_info = stmt1.executeQuery();
			
			connection.commit();
			connection.setAutoCommit(true);
		}
	%>

	<%-- Form --%>
	<h2>Student Information</h2>
	<form action="1a.jsp" method="POST">
		<div>
			<select name="ssn">
			<option>--Choose A Student--</option>
				<%
				if (student_info.isBeforeFirst())
				{
					while(student_info.next())
					{
						ssn = student_info.getString("ssn");
						first = student_info.getString("first_name");
						middle = student_info.getString("middle_name");
						last = student_info.getString("last_name");
						
						if (middle.equals("NULL"))
							middle = "";
						
						String student_information = "SSN: " + ssn + " " + 
													"First Name: " + first + " " + 
													"Middle Name: " + middle + " " +
													"Last Name: " + last + " ";
						
					%>
						<option value=<%=ssn%>><%=student_information%></option>
					<%
					}
				}
				
				%>
			</select>
		</div>
		<br>
		<button type="submit" name="action" value="submit">Submit</button>
	</form>
	
	<h3>Student</h3>
	<%
		try
		{
			PreparedStatement stmt2 = connection.prepareStatement("SELECT * from students where ssn = ?");
			stmt2.setInt(1, Integer.parseInt(request.getParameter("ssn")));
			
			ResultSet rs = stmt2.executeQuery();
			
			if(rs != null)
			{
				if(rs.isBeforeFirst())
				{
					while(rs.next())
					{
						ssn = rs.getString("ssn");
						first = rs.getString("first_name");
						middle = rs.getString("middle_name");
						last = rs.getString("last_name");
					}
				}
			}
	%>
	
	<%-- Table --%>
	<table style="width:100%">
		<tr>
			<th>SSN</th>
            <th>First Name</th>
            <th>Middle Name</th>
			<th>Last Name</th>
		</tr>
		<tr>
				<td><%=ssn %></td>
				<td><%=first %></td>
				<td><%=middle %></td>
				<td><%=last %></td>
		</tr>
	</table>
	<%
		}
		catch (Exception e) 
		{
			out.println("Select Student Above First");
		}
	%>
	<h3>Taking Classes</h3>
	
	<%
	if(class_info != null)
	{	
		//System.out.println("Test0: " + student_info.isBeforeFirst());
		
		if(!class_info.isBeforeFirst())
		{
		%>
			<p>No Current Classes Have Conflict</p>
		<%
		}
		else
		{%>
			<table style="width:100%">
				<tr>
					<th>Section ID</th>
					<th>Class</th>
				</tr><%
			//System.out.println("Test1");
			while(class_info.next())
			{
				//System.out.println("Hello");
			%>
			<form>
				<tr>
					<td><%=class_info.getString("section_id") %></td>
					<td><%=class_info.getString("class_name") %></td>
				</tr>
				<%
			}
		}
	}
		%>
		</form>
	</table>

	<%-- Close --%>
	<%
		
		// Close the Connection
		connection.close();
	} catch (SQLException sqle) {
		out.println(sqle.getMessage());
	} catch (Exception e) {
		out.println(e.getMessage());
	}
	%>
	<br>
</body>
<a href="../index.html">Back To Home Page Here</a>
</html>