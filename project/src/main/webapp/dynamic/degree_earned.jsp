<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Degree Earned Home Page</title>
</head>

<body>
	<%-- Set the scripting language to Java and --%>
	<%@ page language="java" import="java.sql.*" %>

	<%-- -------- Open Connection Code -------- --%>
	<%
			try {
				// Load Oracle Driver class file
				DriverManager.registerDriver (new org.postgresql.Driver());
				String GET_DEGREE_EARNED_QUERY = "Select * from degree_earned";
				
				// Make a connection to the Oracle datasource
				Connection connection = DriverManager.getConnection
				("jdbc:postgresql:tables?user=postgres&password=trungtinvo");
				%>
	<%-- Check if an insertion is requested --%>
	<% String action = request.getParameter("action");
				if (action != null && action.equals("insert")) {
					connection.setAutoCommit(false); %>
	<%-- Create the prepared statement and use it to --%>
	<%-- INSERT the degree_earned attrs INTO the degree_earned table. --%>
	<% 
					PreparedStatement pstmt = connection.prepareStatement(
							("INSERT INTO degree_earned VALUES (?, ?, ?, ?)"));
					
					pstmt.setInt(1, Integer.parseInt(request.getParameter("student_id")));
					pstmt.setInt(2, Integer.parseInt(request.getParameter("degree_id")));
					pstmt.setString(3,request.getParameter("degree_type"));
					pstmt.setString(4,request.getParameter("school"));
					
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
	<%-- UPDATE the degree_earned attributes in the degree_earned table. --%>
	<% 
					
					PreparedStatement pstmt = connection.prepareStatement(
							"UPDATE degree_earned SET degree_id = ?, degree_type = ?, " +
		                      "school = ? WHERE student_id = ?");
					
					pstmt.setInt(1, Integer.parseInt(request.getParameter("degree_id")));
					pstmt.setString(2,request.getParameter("degree_type"));
					pstmt.setString(3, request.getParameter("school"));
					pstmt.setInt(4, Integer.parseInt(request.getParameter("student_id")));
	                  
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
	<%-- DELETE the degree_earned FROM the degree_earned table. --%>
	<% 
					
					PreparedStatement pstmt = connection.prepareStatement(
							"DELETE FROM degree_earned WHERE student_id = ?");
					
					pstmt.setInt(1, Integer.parseInt(request.getParameter("student_id")));
	                  
	                pstmt.executeUpdate();
	                
	              	//connection.commit();
					connection.setAutoCommit(false);
					connection.setAutoCommit(true);
					}
				%>

	<%
				// Create the statement
				Statement stmt = connection.createStatement();
				
				// Use the statement to SELECT the degree_earned attributes
				// FROM the degree_earned table.
				ResultSet rs = stmt.executeQuery(GET_DEGREE_EARNED_QUERY);
				
				%>
	<%-- Entry Form --%>
	<table>
		<tr>
			<th>student_id</th>
			<th>degree_id</th>
			<th>degree_type</th>
			<th>school</th>
		</tr>

		<%-- Insert Form Code --%>
		<tr>
			<form action="degree_earned.jsp" method="get">
				<input type="hidden" value="insert" name="action">
				<th><input value="" name="student_id" size="10"></th>
				<th><input value="" name="degree_id" size="10"></th>
				<th><input value="" name="degree_type" size="10"></th>
				<th><input value="" name="school" size="15"></th>

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
			<form action="degree_earned.jsp" method="get">
				<input type="hidden" value="update" name="action">
				<td><input value="<%= rs.getInt("student_id")%>" name="student_id"></td>
				<td><input value="<%= rs.getInt("degree_id")%>" name="degree_id"></td>
				<td><input value="<%= rs.getString("degree_type")%>" name="degree_type"></td>
				<td><input value="<%= rs.getString("school")%>" name="school"></td>

				<td>
					<input type="submit" value="Update">
				</td>
			</form>

			<form action="degree_earned.jsp" method="get">
				<input type="hidden" value="delete" name="action">
				<input type="hidden" value="<%= rs.getString("student_id") %>" name="student_id">
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