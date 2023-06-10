<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Faculty Home Page</title>
</head>

<body>
	<%-- Set the scripting language to Java and --%>
	<%@ page language="java" import="java.sql.*" %>

	<%-- -------- Open Connection Code -------- --%>
	<%
			try {
				// Load Oracle Driver class file
				DriverManager.registerDriver (new org.postgresql.Driver());
				String GET_FACULTY_QUERY = "Select * from faculty";
				
				// Make a connection to the Oracle datasource
				Connection connection = DriverManager.getConnection
				("jdbc:postgresql:tables?user=postgres&password=ahvuong");
				%>
	<%-- Check if an insertion is requested --%>
	<% String action = request.getParameter("action");
				if (action != null && action.equals("insert")) {
					connection.setAutoCommit(false); %>
	<%-- Create the prepared statement and use it to --%>
	<%-- INSERT the faculty attrs INTO the faculty table. --%>
	<% 
					PreparedStatement pstmt = connection.prepareStatement(
							("INSERT INTO faculty VALUES (?, ?, ?)"));
	
					pstmt.setString(1,request.getParameter("faculty_name"));
					pstmt.setString(2, request.getParameter("member_name"));
					pstmt.setString(3, request.getParameter("member_title"));
					
					pstmt.executeUpdate();
					
					connection.commit();
					connection.setAutoCommit(true);
					}
				%>

	<%-- Update Info --%>
	<% 
				if (action != null && action.equals("update")) {
					connection.setAutoCommit(false);%>
	<%-- Create the prepared statement and use it to --%>
	<%-- UPDATE the faculty attributes in the faculty table. --%>
	<% 
					
					PreparedStatement pstmt = connection.prepareStatement(
							"UPDATE faculty SET member_name = ?, member_title = ? " +
		         				" WHERE faculty_name = ?");
					
					pstmt.setString(1, request.getParameter("member_name"));
					pstmt.setString(2, request.getParameter("member_title"));
					pstmt.setString(3,request.getParameter("faculty_name"));
	                  
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
	<%-- DELETE the faculty FROM the faculty table. --%>
	<% 
					
					PreparedStatement pstmt = connection.prepareStatement(
							"DELETE FROM faculty WHERE faculty_name = ?");
					
					pstmt.setString(1,request.getParameter("faculty_name"));
	                  
	                pstmt.executeUpdate();%>
	                
	                <%-- DELETE the entries related to courses. --%>
	                <%
	                PreparedStatement teaching = connection.prepareStatement(
							"DELETE FROM teaching WHERE faculty_name = ?");
					
	                teaching.setString(1,request.getParameter("faculty_name"));
	                
	                teaching.executeUpdate();
	                
	              	connection.commit();
					connection.setAutoCommit(true);
					}
				%>

	<%
				// Create the statement
				Statement stmt = connection.createStatement();
				
				// Use the statement to SELECT the faculty attributes
				// FROM the faculty table.
				ResultSet rs = stmt.executeQuery(GET_FACULTY_QUERY);
				
				%>
	<%-- Entry Form --%>
	<table>
		<tr>
			<th>faculty_name</th>
			<th>member_name</th>
			<th>member_title</th>
		</tr>

		<%-- Insert Form Code --%>
		<tr>
			<form action="faculty.jsp" method="get">
				<input type="hidden" value="insert" name="action">

				<th><input value="" name="faculty_name" size="15"></th>
				<th><input value="" name="member_name" size="10"></th>
				<th><input value="" name="member_title" size="10"></th>

				<th><input type="submit" value="Insert"></th>
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
			<form action="faculty.jsp" method="get">
				<input type="hidden" value="update" name="action">
				<td><input value="<%= rs.getString("faculty_name")%>" name="faculty_name"></td>
				<td><input value="<%= rs.getString("member_name")%>" name="member_name"></td>
				<td><input value="<%= rs.getString("member_title")%>" name="member_title"></td>

				<td>
					<input type="submit" value="Update">
				</td>
			</form>

			<form action="faculty.jsp" method="get">
				<input type="hidden" value="delete" name="action">
				<input type="hidden" value="<%= rs.getString("faculty_name") %>" name="faculty_name">
				<td><input type="submit" value="Delete"></td>
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
</body>
<a href="../index.html">Go to Home Page</a>
</html>