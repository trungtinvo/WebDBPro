<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Grade Report</title>
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
								"FROM students s " + 
								"NATURAL JOIN past_classes p " + 
								"WHERE s.student_id = p.student_id " +
								"ORDER BY s.ssn ASC";
		String ssn = "";
		String first = "";
		String middle = "";
		String last = "";
		String grade = "";
		String quarter = "";
		int year = 0;
		double gpa = 0.0;
		double total_gpa = 0.0;
		double total_units = 0.0;
		double cumulative_gpa = 0.0;
		
		ResultSet class_info = null;
    	ResultSet student_info = null;
    	ResultSet gpa_info = null;
    	//ResultSet total_gpa_info = null;
    
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
				"SELECT c.section_id, c.new_number, c.title, " +
						"c.year, c.quarter, c.instructor_name, " + 
						"c.enrollment_limit, p.grade, p.units " +
				"FROM students s " +
				"INNER JOIN past_classes p " +
				"ON s.student_id = p.student_id " + 
				"INNER JOIN classes c " +
				"ON p.title = c.new_number AND p.year = c.year AND " +
				"p.quarter = c.quarter AND " +
				"p.section_id = c.section_id " +
				"WHERE s.student_id = " +
				"(SELECT student_id FROM students " +
				"WHERE ssn = ?) " +
				"ORDER BY c.quarter, c.year ASC"
				);
	
	stmt1.setInt(1, Integer.parseInt(request.getParameter("ssn")));
		//System.out.println("Test3");
	
	class_info = stmt1.executeQuery();
	
	connection.commit();
	connection.setAutoCommit(true);
	
	/* Display the GPA of each quarter and the cumulative GPA. 
	Exclude the incomplete grades (represented by 'IN') 
	from the GPA computation.*/
	connection.setAutoCommit(false); 
		
	PreparedStatement stmt2 = connection.prepareStatement(
					"SELECT c.quarter, c.year, " + 
							"SUM(g.number_grade * p.units) as quarter_gpa, " +
							"SUM(p.units) as quarter_units " +
					"FROM students s " +
					"INNER JOIN past_classes p " +
					"ON s.student_id = p.student_id " +
					"INNER JOIN grade_conversion g " +
					"ON p.grade = g.letter_grade " +
					"INNER JOIN classes c " +
					"ON p.title = c.new_number AND " + 
					"p.year = c.year AND " +
					"p.quarter = c.quarter AND " +
					"p.section_id = c.section_id " +
					"WHERE s.student_id = " +
					"(SELECT student_id FROM students " +
					"WHERE ssn = ?) " + 
					"GROUP BY c.quarter, c.year "
					);
		
	stmt2.setInt(1, Integer.parseInt(request.getParameter("ssn")));
		
	gpa_info = stmt2.executeQuery();
				
			connection.commit();
			connection.setAutoCommit(true);
		}
	%>

	<%-- Form --%>
	<h1>Student Information</h1>
	<form action="1c.jsp" method="POST">
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
	
	<h3>Taking Classes</h3>
	
		
	<table style="width:100%">
				<tr>
					<th>Section ID</th>
					<th>Class Name</th>
					<th>Title</th>
					<th>Year</th>
					<th>Quarter</th>
					<th>Instructor Name</th>
					<th>Enrollment Limit</th>
					<th>Grade</th>
					<th>Units</th>
				</tr>
				
	<%
	if(class_info != null)
	{	
		//System.out.println("Test0: " + student_info.isBeforeFirst());
			
		if(!class_info.isBeforeFirst())
		{
			%>
			<p>No Classes Are Taken</p>
			<%
		}
		else
		{
			//System.out.println("Test1");
			while(class_info.next())
			{
				grade = class_info.getString("grade");
				quarter = class_info.getString("quarter");
				year = class_info.getInt("year");
				//System.out.println("quarter " + quarter);
				//System.out.println("year " + year);
				//System.out.println("grade " + grade);
			%>
				<form>
					<tr>
						<td><%=class_info.getInt("section_id") %></td>
						<td><%=class_info.getString("new_number") %></td>
						<td><%=class_info.getString("title") %></td>
						<td><%=class_info.getInt("year") %></td>
						<td><%=class_info.getString("quarter") %></td>
						<td><%=class_info.getString("instructor_name") %></td>
						<td><%=class_info.getInt("enrollment_limit") %></td>
						<td><%=grade %></td>
						<td><%=class_info.getInt("units") %></td>
					</tr>
				<%
			}
		}
	}
	%>
		</form>
	</table>
	
	<h3>Student's GPA For Each Quarter</h3>
	<table style="width:100%">
				<tr>
					<th>Year</th>
					<th>Quarter</th>
					<th>GPA For Each Quarter</th>
				</tr>	
	<%
	if(grade.equals("S") || grade.equals("U") || grade.equals("IN"))
	{
		//System.out.println(grade);
		if(grade.equals("IN"))
		%>
		<form>
			<tr>
				<td><%=quarter %></td>
				<td><%=year %></td>
				<td><%=grade %></td>
			</tr>
		</form>
		<%
	}
	else
	{
		if(gpa_info != null)
		{	
			//System.out.println("Test0: " + student_info.isBeforeFirst());
			
			if(gpa_info.isBeforeFirst())
			{
				
				while(gpa_info.next())
				{
					//System.out.println(grade);	
					double units = gpa_info.getDouble("quarter_units");
					double quarter_gpa = gpa_info.getDouble("quarter_gpa");
					gpa = quarter_gpa / units;
					//System.out.println("gpa " + gpa + " quarter_gpa " + quarter_gpa + " units " + units);
					total_gpa += (quarter_gpa/2);
					total_units += (units/2);
					quarter = gpa_info.getString("quarter");
					year = gpa_info.getInt("year");
					//System.out.println(grade);
					%>
						<form>
							<tr>
								<td><%=quarter %></td>
								<td><%=year %></td>
								<td><%=gpa %></td>
							</tr>
						</form>
					<%
					}
				
				//System.out.println("total_gpa " + total_gpa + " total_units " + total_units);
				cumulative_gpa = total_gpa/total_units;
			}
			else
			{
			%>
			<p>No Classes Are Taken</p>
			<%
			}
		}
	}
	%>
	</table>
	
	<h3>Student's Cumulative GPA</h3>
	
	<table style="width:75%">
		<form>
			<tr>
				<td><b>Cumulative GPA</b></td>
				<td><%=cumulative_gpa %></td>
			</tr>
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