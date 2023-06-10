<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Course Enrollment Home Page</title>
</head>

<body>
	<%-- Set the scripting language to Java and --%>
	<%@ page language="java" import="java.sql.*" %>

	<%-- -------- Open Connection Code -------- --%>
	<%
			try {
				// Load Oracle Driver class file
				DriverManager.registerDriver (new org.postgresql.Driver());
				String GET_COURSE_ENROLLMENT_QUERY = "Select * from course_enrollment";
				
				// Make a connection to the Oracle datasource
				Connection connection = DriverManager.getConnection
				("jdbc:postgresql:tables?user=postgres&password=ahvuong");
				%>
	<%-- Check if an insertion is requested --%>
	<% String action = request.getParameter("action");
				if (action != null && action.equals("insert")) {
					connection.setAutoCommit(false); %>
	<%-- Create the prepared statement and use it to --%>
	<%-- INSERT the course_enrollment attrs INTO the course_enrollment table. --%>
	<% 
					PreparedStatement pstmt = connection.prepareStatement(
							("INSERT INTO course_enrollment VALUES (?, ?, ?, ?, ?, ?, ?)"));
					
					pstmt.setInt(1,Integer.parseInt(request.getParameter("student_id")));
					pstmt.setInt(2,Integer.parseInt(request.getParameter("section_id")));
					pstmt.setString(3,request.getParameter("class_name"));
					pstmt.setInt(4, Integer.parseInt(request.getParameter("year")));
					pstmt.setString(5, request.getParameter("quarter"));
					pstmt.setInt(6, Integer.parseInt(request.getParameter("units")));
					pstmt.setString(7, request.getParameter("grade"));
					
					pstmt.executeUpdate();
					//connection.commit();
					connection.setAutoCommit(false);
					connection.setAutoCommit(true);
					}
				%>

	<%-- Update Info --%>
	<% 
				if (action != null && action.equals("update")) {
					connection.setAutoCommit(false);%>
	<%-- Create the prepared statement and use it to --%>
	<%-- UPDATE the course_enrollment attributes in the course_enrollment table. --%>
	<% 
					
					PreparedStatement pstmt = connection.prepareStatement(
							"UPDATE course_enrollment SET class_name = ?, " +
		                      "year = ?, quarter = ?, units = ?, " +
								"grade = ? WHERE student_id = ? AND section_id = ?");
					
					pstmt.setString(1,request.getParameter("class_name"));
					pstmt.setInt(2, Integer.parseInt(request.getParameter("year")));
					pstmt.setString(3, request.getParameter("quarter"));
					pstmt.setInt(4, Integer.parseInt(request.getParameter("units")));
					pstmt.setString(5, request.getParameter("grade"));
					pstmt.setInt(6,Integer.parseInt(request.getParameter("student_id")));
					pstmt.setInt(7,Integer.parseInt(request.getParameter("section_id")));
	                  
	                pstmt.executeUpdate();
	                
	              	//connection.commit();
					connection.setAutoCommit(false);
					connection.setAutoCommit(true);
					}
				%>

	<%-- Delete --%>
	<% 
				if (action != null && action.equals("delete")) {
					connection.setAutoCommit(false);%>
	<%-- Create the prepared statement and use it to --%>
	<%-- DELETE the course_enrollment FROM the course_enrollment table. --%>
	<% 
					
					PreparedStatement pstmt = connection.prepareStatement(
							"DELETE FROM course_enrollment WHERE student_id = ? AND section_id = ?");
					
					pstmt.setInt(1,Integer.parseInt(request.getParameter("student_id")));
					pstmt.setInt(2,Integer.parseInt(request.getParameter("section_id")));
	                  
	                pstmt.executeUpdate();
	                
	              	//connection.commit();
					connection.setAutoCommit(false);
					connection.setAutoCommit(true);
					}
				%>

	<%
				// Create the statement
				Statement stmt = connection.createStatement();
				
				// Use the statement to SELECT the course_enrollment attributes
				// FROM the course_enrollment table.
				ResultSet rs = stmt.executeQuery(GET_COURSE_ENROLLMENT_QUERY);
				
				%>
	<%-- Entry Form --%>
	<table>
		<tr>
			<th>student_id</th>
			<th>section_id</th>
			<th>class_name</th>
			<th>year</th>
			<th>quarter</th>
			<th>units</th>
			<th>grade</th>
		</tr>

		<%-- Insert Form Code --%>
		<tr>
			<form action="course_enrollment.jsp" method="get">
				<input type="hidden" value="insert" name="action">
				<th><input value="" name="student_id" size="9"></th>
				<th><input value="" name="section_id" size="10"></th>
				<th><input value="" name="class_name" size="10"></th>
				<th><input value="" name="year" size="10"></th>
				<th><input value="" name="quarter" size="10"></th>
				<th><input value="" name="units" size="10"></th>
				<th>
					<select name="grade">
						<option value="LETTER">LETTER</option>
						<option value="S/U" >S/U</option>
						<option value="LETTER  & S/U">LETTER  & S/U</option>
					</select>
				</th>
		<tr>
			<th><input type="submit" value="Insert"></th>
		</tr>
		</form>
		</tr>

		<%
				//System.out.print("hello1\n");
				// Iterate over the ResultSet
				while ( rs.next() ) {
					//System.out.print("hello\n");
				%>
		<%-- Update Form Code --%>
		<tr>
			<form action="course_enrollment.jsp" method="get">
				<input type="hidden" value="update" name="action">
				<td><input value="<%= rs.getInt("student_id")%>" name="student_id"></td>
				<td><input value="<%= rs.getInt("section_id")%>" name="section_id"></td>
				<td><input value="<%= rs.getString("class_name")%>" name="class_name"></td>
				<td><input value="<%= rs.getInt("year")%>" name="year"></td>
				<td><input value="<%= rs.getString("quarter")%>" name="quarter"></td>
				<td><input value="<%= rs.getInt("units")%>" name="units"></td>
				<td><input value="<%= rs.getString("grade")%>" name="grade"></td>
				<td>
					<select name="grade" required>
	                    <% String s = rs.getString("grade"); %>
	                    <option value="LETTER" <%= s.equals("LETTER") ? "selected":"" %>>LETTER</option>
	                    <option value="S/U" <%= s.equals("S/U") ? "selected":"" %>>S/U</option>
	                    <option value="LETTER  & S/U" <%= s.equals("LETTER  & S/U") ? "selected":"" %>>LETTER  & S/U</option>
                	</select></td>
				<td>
		<tr>
			<th><input type="submit" value="Update"></th>
		</tr>

		</form>

		<form action="course_enrollment.jsp" method="get">
			<input type="hidden" value="delete" name="action">
			<input type="hidden" value="<%= rs.getInt("student_id") %>" name="student_id">
			<input type="hidden" value="<%= rs.getInt("section_id") %>" name="section_id">
			<tr>
				<th><input type="submit" value="Delete"></th>
			</tr>
		</form>
		</tr>
		<%
				}
				%>
	</table>

	<%
				// Close the ResultSet
				rs.close();
				// Close the Statement
				stmt.close();
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
<a href="../index.html">Go to Home Page</a>
</html>