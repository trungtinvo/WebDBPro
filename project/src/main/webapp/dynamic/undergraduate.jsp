<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Undergraduate Home Page</title>
</head>

<body>
	<%-- Set the scripting language to Java and --%>
	<%@ page language="java" import="java.sql.*" %>

	<%-- -------- Open Connection Code -------- --%>
	<%
			try {
				// Load Oracle Driver class file
				DriverManager.registerDriver (new org.postgresql.Driver());
				String GET_UNDERGRADUATE_QUERY = "Select * from undergraduate";
				
				// Make a connection to the Oracle datasource
				Connection connection = DriverManager.getConnection
				("jdbc:postgresql:tables?user=postgres&password=trungtinvo");
				%>
	<%-- Check if an insertion is requested --%>
	<% String action = request.getParameter("action");
				if (action != null && action.equals("insert")) {
					connection.setAutoCommit(false); %>
	<%-- Create the prepared statement and use it to --%>
	<%-- INSERT the undergraduate attrs INTO the undergraduate table. --%>
	<% 
					PreparedStatement pstmt = connection.prepareStatement(
							("INSERT INTO undergraduate VALUES (?, ?, ?, ?)"));
					
					pstmt.setInt(1, Integer.parseInt(request.getParameter("student_id")));
					pstmt.setString(2,request.getParameter("major"));
					pstmt.setString(3,request.getParameter("minor"));
					pstmt.setString(4,request.getParameter("college"));
					
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
	<%-- UPDATE the undergraduate attributes in the undergraduate table. --%>
	<% 
					
					PreparedStatement pstmt = connection.prepareStatement(
							"UPDATE undergraduate SET major = ?, minor = ?, " +
		                      "college = ? WHERE student_id = ?");
					
					pstmt.setString(1,request.getParameter("major"));
					pstmt.setString(2, request.getParameter("minor"));
					pstmt.setString(3, request.getParameter("college"));
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
	<%-- DELETE the undergraduate FROM the undergraduate table. --%>
	<% 
					
					PreparedStatement pstmt = connection.prepareStatement(
							"DELETE FROM undergraduate WHERE student_id = ?");
					
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
				
				// Use the statement to SELECT the undergraduate attributes
				// FROM the undergraduate table.
				ResultSet rs = stmt.executeQuery(GET_UNDERGRADUATE_QUERY);
				
				%>
	<%-- Entry Form --%>
	<table>
		<tr>
			<th>student_id</th>
			<th>major</th>
			<th>minor</th>
			<th>college</th>
		</tr>

		<%-- Insert Form Code --%>
		<tr>
			<form action="undergraduate.jsp" method="get">
				<input type="hidden" value="insert" name="action">
				<th><input value="" name="student_id" size="10"></th>
				<th><input value="" name="major" size="10"></th>
				<th><input value="" name="minor" size="10"></th>
				<th><input value="" name="college" size="15"></th>

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
			<form action="undergraduate.jsp" method="get">
				<input type="hidden" value="update" name="action">
				<td><input value="<%= rs.getInt("student_id")%>" name="student_id"></td>
				<td><input value="<%= rs.getString("major")%>" name="major"></td>
				<td><input value="<%= rs.getString("minor")%>" name="minor"></td>
				<td><input value="<%= rs.getString("college")%>" name="college"></td>

				<td>
					<input type="submit" value="Update">
				</td>
			</form>

			<form action="undergraduate.jsp" method="get">
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