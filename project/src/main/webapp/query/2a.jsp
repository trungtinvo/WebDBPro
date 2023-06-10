<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Class Schedule Report</title>
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
		/*The form is a HTML SELECT control with all students ever enrolled 
		(i.e. students that were enrolled at some quarter). 
		Display the SSN, FIRSTNAME, MIDDLENAME and LASTNAME attributes of STUDENT X, 
		but pass to the request only the SSN of X.*/
		
		String action = request.getParameter("action");
		String GET_STUDENT_QUERY = "SELECT DISTINCT s.ssn, s.first_name, " +
								"s.middle_name, s.last_name " +
								"FROM students s JOIN course_enrollment ce " + 
								"ON ce.student_id = s.student_id " +
								"WHERE ce.quarter = 'SP' AND ce.year = 2023 " + 
								"ORDER BY s.ssn ASC";
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
			connection.setAutoCommit(false); 
	%>
	<%-- Create the prepared statement and use it to --%>
	<%-- INSERT the advisor attrs INTO the advisor table. --%>
	<% 
		/* Display all the classes (all attributes of CLASS entities) 
		that have been taken by X. Group the classes by quarter 
		(see at the start of phase 3 what we mean by quarter). 
		Include the GRADE and UNITS attributes in the report.*/
		
		PreparedStatement stmt1 = connection.prepareStatement(
			"WITH enrolled_classes AS (SELECT w.* " +
									"FROM weekly w, course_enrollment ce, students s " +
									"WHERE s.student_id = ce.student_id " +
										"AND w.section_id = ce.section_id " +
										"AND w.new_number = ce.class_name " +
										"AND ce.quarter = 'SP' AND ce.year = 2023 " +
										"AND s.ssn = ? " +
									"), " +
				"unenrolled_classes AS (SELECT w.* " +
									"FROM weekly w, classes c " +
									"WHERE w.section_id = c.section_id " + 
									"AND w.new_number = c.new_number " +
									"AND c.quarter = 'SP' AND c.year = 2023 " +
									"AND w.new_number NOT IN " +
									"(SELECT new_number FROM enrolled_classes) " +
									") " +
				"SELECT DISTINCT ec.section_id AS sid, " + 
								"ec.new_number AS new_num, c1.title AS class_title, " +
								"uc.section_id AS cfw_section_id, " +
								"uc.new_number AS cfw_new_number, c2.title AS cfw_title " +
				"FROM classes c1, classes c2, " +
					"enrolled_classes ec, unenrolled_classes uc " +
				"WHERE ec.mandatory = TRUE " +
						"AND uc.mandatory = TRUE " +
						"AND c1.new_number = ec.new_number " +
						"AND c2.new_number = uc.new_number " +
						"AND ec.date_time = uc.date_time " +
						"AND (ec.begin_time, ec.end_time) OVERLAPS " +
							"(uc.begin_time, uc.end_time) " +
				"GROUP BY sid, new_num, class_title, " +
							"cfw_section_id, cfw_new_number, cfw_title "
				);
	
	stmt1.setInt(1, Integer.parseInt(request.getParameter("ssn")));
		//System.out.println("Test3");
	
	class_info = stmt1.executeQuery();
	
	connection.commit();
	connection.setAutoCommit(true);
		}
	%>

	<%-- Form --%>
	<h1>Student Information</h1>
	<form action="2a.jsp" method="POST">
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
				//System.out.println("Test3");
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
			PreparedStatement stmt3 = connection.prepareStatement("SELECT * from students where ssn = ?");
			stmt3.setInt(1, Integer.parseInt(request.getParameter("ssn")));
			
			ResultSet rs = stmt3.executeQuery();
			
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
	
	<h3>Class Schedule Warning</h3>
	
		
	
				
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
		{
			%>
			<table style="width:100%">
				<tr style="text-align: center; font-weight: bold;">
					<td colspan="3">Taking Class</td>
				    <td colspan="3">Conflicts With</td>
				</tr>
				<tr>
					<th>Section ID</th>
					<th>Class Name</th>
					<th>Title</th>
					<th>Section ID</th>
					<th>Class Name</th>
					<th>Title</th>
				</tr>
			<%
			//System.out.println("Test1");
			while(class_info.next())
			{
			%>
				<form>
					<tr>
						<td><%=class_info.getInt("sid") %></td>
						<td><%=class_info.getString("new_num") %></td>
						<td><%=class_info.getString("class_title") %></td>
						<td><%=class_info.getInt("cfw_section_id") %></td>
						<td><%=class_info.getString("cfw_new_number") %></td>
						<td><%=class_info.getString("cfw_title") %></td>
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