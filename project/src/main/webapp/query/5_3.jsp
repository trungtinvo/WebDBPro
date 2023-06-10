<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Entry Form & Grade Distribution Report</title>
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
		String GET_CPQG_QUERY = "SELECT * FROM CPQG";
		String GET_CPG_QUERY = "SELECT * FROM CPG";
		
		
		ResultSet class_info = null;
    	ResultSet cpqg_info = null;
    	ResultSet cpg_info = null;
    	
		if (action != null && action.equals("insert")) 
		{
			connection.setAutoCommit(false);

		    // Check if the record already exists
		    PreparedStatement selectStmt = connection.prepareStatement(
		        "SELECT * FROM past_classes WHERE student_id = ? AND section_id = ?"
		    );
		    selectStmt.setInt(1, Integer.parseInt(request.getParameter("student_id")));
		    selectStmt.setInt(2, Integer.parseInt(request.getParameter("section_id")));
		    ResultSet rs = selectStmt.executeQuery();

		    if (rs.next()) {
		        // Record already exists, update it instead of inserting
		        PreparedStatement updateStmt = connection.prepareStatement(
		            "UPDATE past_classes SET title = ?, year = ?, quarter = ?, instructor_name = ?, " +
		            "grade = ?, units = ?, grade_conversion = ?, class_type = ? " +
		            "WHERE student_id = ? AND section_id = ?"
		        );
		        updateStmt.setString(1, request.getParameter("title"));
		        updateStmt.setInt(2, Integer.parseInt(request.getParameter("year")));
		        updateStmt.setString(3, request.getParameter("quarter"));
		        updateStmt.setString(4, request.getParameter("instructor_name"));
		        updateStmt.setString(5, request.getParameter("grade"));
		        updateStmt.setInt(6, Integer.parseInt(request.getParameter("units")));
		        updateStmt.setDouble(7, Double.parseDouble(request.getParameter("grade_conversion")));
		        updateStmt.setString(8, request.getParameter("class_type"));
		        updateStmt.setInt(9, Integer.parseInt(request.getParameter("student_id")));
		        updateStmt.setInt(10, Integer.parseInt(request.getParameter("section_id")));
		        updateStmt.executeUpdate();
		    } else {
		        // Record doesn't exist, insert a new one
		        PreparedStatement insertStmt = connection.prepareStatement(
		            "INSERT INTO past_classes VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
		        );
		        insertStmt.setInt(1, Integer.parseInt(request.getParameter("student_id")));
		        insertStmt.setInt(2, Integer.parseInt(request.getParameter("section_id")));
		        insertStmt.setString(3, request.getParameter("title"));
		        insertStmt.setInt(4, Integer.parseInt(request.getParameter("year")));
		        insertStmt.setString(5, request.getParameter("quarter"));
		        insertStmt.setString(6, request.getParameter("instructor_name"));
		        insertStmt.setString(7, request.getParameter("grade"));
		        insertStmt.setInt(8, Integer.parseInt(request.getParameter("units")));
		        insertStmt.setDouble(9, Double.parseDouble(request.getParameter("grade_conversion")));
		        insertStmt.setString(10, request.getParameter("class_type"));
		        insertStmt.executeUpdate();
		    }

		    connection.commit();
		    connection.setAutoCommit(true);
			
		}
		// Select all class's information
    	connection.setAutoCommit(false);
		PreparedStatement stmt1 = connection.prepareStatement(GET_CPQG_QUERY);
		PreparedStatement stmt2 = connection.prepareStatement(GET_CPG_QUERY);
		
		cpqg_info = stmt1.executeQuery();
		cpg_info = stmt2.executeQuery();
		
		connection.commit();
		connection.setAutoCommit(true);
	%>

	<h3>Past Classes' Entry Form</h3>
	<%-- Entry Form --%>
	<table>
		<tr>
			<th>student_id</th>
			<th>section_id</th>
			<th>title</th>
			<th>year</th>
			<th>quarter</th>
			<th>instructor_name</th>
			<th>grade</th>
			<th>units</th>
			<th>grade_conversion</th>
			<th>class_type</th>
		</tr>
		<%-- Insert Form Code --%>
		<tr>
			<form action="5_3.jsp" method="get">
				<input type="hidden" value="insert" name="action">

				<th><input value="" name="student_id"></th>
				<th><input value="" name="section_id"></th>
				<th><input value="" name="title"></th>
				<th><input value="" name="year"></th>
				<th><input value="" name="quarter"></th>
				<th><input value="" name="instructor_name"></th>
				<th>
					<select name="grade">
						<option value="A+">A+</option>
						<option value="A">A</option>
						<option value="A-">A-</option>
						<option value="B+">B+</option>
						<option value="B">B</option>
						<option value="B-">B-</option>
						<option value="C+">C+</option>
						<option value="C">C</option>
						<option value="C-">C-</option>
						<option value="D">D</option>
						<option value="S">S</option>
						<option value="U">U</option>
					</select>
				</th>
				<th><input value="" name="units"></th>
				<th><input value="" name="grade_conversion" placeholder="Result will appear here"></th>
				<th>
					<select name="class_type">
						<option value="upper_units">upper_units</option>
						<option value="lower_units">lower_units</option>
						<option value="elective_units">elective_units</option>
						<option value="UP&ELT_units">UP&ELT_units</option>
						<option value="concentration_1_units">concentration_1_units</option>
						<option value="concentration_2_units">concentration_2_units</option>
						<option value="concentration_3_units">concentration_3_units</option>
					</select>
				</th>

				<script>
					var grade = document.getElementsByName("grade")[0];
					var grade_convert = document.getElementsByName("grade_conversion")[0];
					grade.addEventListener("input", function () {
						if (grade.value == "A+")
							grade_convert.value = 4.3;
						else if (grade.value == "A")
							grade_convert.value = 4.0;
						else if (grade.value == "A-")
							grade_convert.value = 3.7;
						else if (grade.value == "B+")
							grade_convert.value = 3.4;
						else if (grade.value == "B")
							grade_convert.value = 3.1;
						else if (grade.value == "B-")
							grade_convert.value = 2.8;
						else if (grade.value == "C+")
							grade_convert.value = 2.5;
						else if (grade.value == "C")
							grade_convert.value = 2.2;
						else if (grade.value == "C-")
							grade_convert.value = 1.9;
						else if (grade.value == "D")
							grade_convert.value = 1.6;
						else
							grade_convert.value = 0.0;
					});
				</script>

				<th><input type="submit" value="Insert"></th>
			</form>
		</tr>
		<%
		/*
		if(class_info != null)
		{	
			//System.out.println("Test0: " + student_info.isBeforeFirst());
				
			if(!class_info.isBeforeFirst())
			{
				%>
				<p>No Information</p>
				<%
			}
			else
			{
				//System.out.println("Test1");
				while(class_info.next())
				{
				%>
					<form>
						<tr>
							<td><%=class_info.getInt("student_id") %></td>
							<td><%=class_info.getInt("section_id") %></td>
							<td><%=class_info.getString("title") %></td>
							<td><%=class_info.getInt("year") %></td>
							<td><%=class_info.getString("quarter") %></td>
							<td><%=class_info.getString("instructor_name") %></td>
							<td><%=class_info.getString("grade") %></td>
							<td><%=class_info.getInt("units") %></td>
							<td><%=class_info.getDouble("grade_conversion") %></td>
							<td><%=class_info.getString("class_type") %></td>
						</tr>
					<%
				}
			}
		}*/
		%>
					</form>
		
	</table>
	
	<h3>CPQG Table</h3>
	
	<table style="width:100%">
				<tr>
					<th>Title</th>
					<th>Year</th>
					<th>Quarter</th>
					<th>Instructor Name</th>
					<th>Count A</th>
					<th>Count B</th>
					<th>Count C</th>
					<th>Count D</th>
					<th>Count Other</th>
				</tr>
				
	<%
	if(cpqg_info != null)
	{	
		//System.out.println("Test0: " + student_info.isBeforeFirst());
			
		if(!cpqg_info.isBeforeFirst())
		{
			%>
			<p>No Information</p>
			<%
		}
		else
		{
			//System.out.println("Test1");
			while(cpqg_info.next())
			{
			%>
				<form>
					<tr>
						<td><%=cpqg_info.getString("title") %></td>
						<td><%=cpqg_info.getInt("year") %></td>
						<td><%=cpqg_info.getString("quarter") %></td>
						<td><%=cpqg_info.getString("instructor_name") %></td>
						<td><%=cpqg_info.getInt("count_A") %></td>
						<td><%=cpqg_info.getInt("count_B") %></td>
						<td><%=cpqg_info.getInt("count_C") %></td>
						<td><%=cpqg_info.getInt("count_D") %></td>
						<td><%=cpqg_info.getInt("count_other") %></td>
					</tr>
				<%
			}
		}
	}
	%>
		</form>
	</table>
	
	<h3>CPG Table</h3>
	
	<table style="width:100%">
				<tr>
					<th>Title</th>
					<th>Instructor Name</th>
					<th>Count A</th>
					<th>Count B</th>
					<th>Count C</th>
					<th>Count D</th>
					<th>Count Other</th>
				</tr>
				
	<%
	if(cpg_info != null)
	{	
		//System.out.println("Test0: " + student_info.isBeforeFirst());
			
		if(!cpg_info.isBeforeFirst())
		{
			%>
			<p>No Information</p>
			<%
		}
		else
		{
			//System.out.println("Test1");
			while(cpg_info.next())
			{
			%>
				<form>
					<tr>
						<td><%=cpg_info.getString("title") %></td>
						<td><%=cpg_info.getString("instructor_name") %></td>
						<td><%=cpg_info.getInt("count_A") %></td>
						<td><%=cpg_info.getInt("count_B") %></td>
						<td><%=cpg_info.getInt("count_C") %></td>
						<td><%=cpg_info.getInt("count_D") %></td>
						<td><%=cpg_info.getInt("count_other") %></td>
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