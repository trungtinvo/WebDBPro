<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Teaching Home Page</title>
</head>
<style>
	table,
	th,
	td {
		border: 1px solid black;
	}
</style>

<body>
	<%-- Set the scripting language to Java and --%>
	<%@ page language="java" import="java.sql.*" %>

	<%-- -------- Open Connection Code -------- --%>
	<%
			try {
				// Load Oracle Driver Teaching file
				DriverManager.registerDriver (new org.postgresql.Driver());
				String GET_TEACHING_QUERY = "Select * from teaching";
				
				// Make a connection to the Oracle datasource
				Connection connection = DriverManager.getConnection
				("jdbc:postgresql:tables?user=postgres&password=trungtinvo");
				%>
	<%-- Check if an insertion is requested --%>
	<% String action = request.getParameter("action");
				ResultSet ss = null;
				
				connection.setAutoCommit(false);
				PreparedStatement pstmt1 = connection.prepareStatement(
						("SELECT * FROM weekly w NATURAL JOIN teaching t WHERE t.section_id = w.section_id"));
				ss = pstmt1.executeQuery();
				connection.commit();
				connection.setAutoCommit(true);
				

				if (action != null && action.equals("insert")) {
					connection.setAutoCommit(false); %>
	<%-- Create the prepared statement and use it to --%>
	<%-- INSERT the teaching attrs INTO the teaching table. --%>
	<% 
					PreparedStatement pstmt = connection.prepareStatement(
							("INSERT INTO teaching VALUES (?, ?)"));
					
					pstmt.setInt(1,Integer.parseInt(request.getParameter("section_id")));
					pstmt.setString(2, request.getParameter("faculty_name"));
										
					pstmt.executeUpdate();
					
					connection.commit();
				/* 	connection.setAutoCommit(false); */
					connection.setAutoCommit(true);
					
					}
				%>

	<%-- Update Info --%>
	<% 
				if (action != null && action.equals("update")) {
					connection.setAutoCommit(false);%>
	<%-- Create the prepared statement and use it to --%>
	<%-- UPDATE the teaching attributes in the teaching table. --%>
	<% 
					
					PreparedStatement pstmt = connection.prepareStatement(
							"UPDATE teaching SET faculty_name = ? WHERE section_id = ?");
					
					pstmt.setString(1,request.getParameter("faculty_name"));
					pstmt.setInt(2,Integer.parseInt(request.getParameter("section_id")));
					
	                  
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
	<%-- DELETE the courses FROM the courses table. --%>
	<% 
					
					PreparedStatement pstmt = connection.prepareStatement(
							"DELETE FROM teaching WHERE section_id = ?");
					
					pstmt.setInt(1, Integer.parseInt(request.getParameter("section_id")));
	                  
	                pstmt.executeUpdate();
	                
	              	//connection.commit();
					connection.setAutoCommit(false);
					connection.setAutoCommit(true);
					}
				%>

	<%
				// Create the statement
				Statement stmt = connection.createStatement();
				
				// Use the statement to SELECT the courses attributes
				// FROM the courses table.
				ResultSet rs = stmt.executeQuery(GET_TEACHING_QUERY);
				
				%>
	<%-- Entry Form --%>
	<table>
		<tr>
			<th>section_id</th>
			<th>faculty_name</th>
		</tr>

		<%-- Insert Form Code --%>
		<tr>
			<form action="teaching.jsp" method="get">
				<input type="hidden" value="insert" name="action">
				<th><input value="" name="section_id" size="10"></th>
				<th><input value="" name="faculty_name" size="10"></th>

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
			<form action="teaching.jsp" method="get">
				<input type="hidden" value="update" name="action">
				<td><input value="<%= rs.getInt("section_id")%>" name="section_id"></td>
				<td><input value="<%= rs.getString("faculty_name")%>" name="faculty_name"></td>

				<td>
					<input type="submit" value="Update">
				</td>
			</form>

			<form action="teaching.jsp" method="get">
				<input type="hidden" value="delete" name="action">
				<input type="hidden" value="<%= rs.getInt("section_id") %>" name="section_id">
				<td><input type="submit" value="Delete"></td>
			</form>
		</tr>
		<%
				}
				%>
	</table>

	<h3>Section Info Table</h3>

	<table style="width:100%">
		<tr>
			<th>Section_ID</th>
			<th>Faculty_Name</th>
			<th>Date_Time</th>
			<th>Begin_Time</th>
			<th>End_Time</th>
		</tr>

		<%
			if(ss != null)
			{	
				//System.out.println("Test0: " + student_info.isBeforeFirst());
					
				if(!ss.isBeforeFirst())
				{
					%>
		<p>No Information</p>
		<%
				}
				else
				{
					//System.out.println("Test1");
					while(ss.next())
					{
					%>
		<form>
			<tr>
				<td><%=ss.getInt("section_id") %></td>
				<td><%=ss.getString("faculty_name") %></td>
				<td><%=ss.getDate("date_time") %></td>
				<td><%=ss.getTime("begin_time") %></td>
				<td><%=ss.getTime("end_time") %></td>
			</tr>
			<%
					}
				}
			}
			%>
		</form>
	</table>

	<%
				// Close the ResultSet
				rs.close();
				/* ss.close(); */
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