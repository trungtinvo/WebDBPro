<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Degree Home Page</title>
</head>

<body>
	<%-- Set the scripting language to Java and --%>
	<%@ page language="java" import="java.sql.*" %>

	<%-- -------- Open Connection Code -------- --%>
	<%
			try {
				// Load Oracle Driver degree file
				DriverManager.registerDriver (new org.postgresql.Driver());
				String GET_DEGREE_QUERY = "Select * from degree";
				
				// Make a connection to the Oracle datasource
				Connection connection = DriverManager.getConnection
				("jdbc:postgresql:tables?user=postgres&password=trungtinvo");
				%>
	<%-- Check if an insertion is requested --%>
	<% String action = request.getParameter("action");
				if (action != null && action.equals("insert")) {
					connection.setAutoCommit(false); %>
	<%-- Create the prepared statement and use it to --%>
	<%-- INSERT the degree attrs INTO the degree table. --%>
	<% 
					PreparedStatement pstmt = connection.prepareStatement(
							("INSERT INTO degree VALUES (?, ?, ?, ?, ?, ?, ?, ?)"));
					
					pstmt.setInt(1,Integer.parseInt(request.getParameter("degree_id")));
					pstmt.setInt(2,Integer.parseInt(request.getParameter("upper_units")));
					pstmt.setInt(3,Integer.parseInt(request.getParameter("lower_units")));
					pstmt.setInt(4,Integer.parseInt(request.getParameter("elective_units")));
					pstmt.setInt(5,Integer.parseInt(request.getParameter("total_units")));
					pstmt.setString(6,request.getParameter("min_grade"));
					pstmt.setString(7,request.getParameter("degree_name"));
					pstmt.setString(8,request.getParameter("degree_type"));
					
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
	<%-- UPDATE the degree attributes in the degree table. --%>
	<% 
					
					PreparedStatement pstmt = connection.prepareStatement(
							"UPDATE degree SET upper_units = ?, lower_units = ?, " +
		                      "elective_units = ?, total_units = ?, min_grade = ?, degree_name = ?, degree_type = ? " +
								"WHERE degree_id = ?");
					
					pstmt.setInt(1,Integer.parseInt(request.getParameter("upper_units")));
					pstmt.setInt(2,Integer.parseInt(request.getParameter("lower_units")));
					pstmt.setInt(3,Integer.parseInt(request.getParameter("elective_units")));
					pstmt.setInt(4,Integer.parseInt(request.getParameter("total_units")));
					pstmt.setString(5,request.getParameter("min_grade"));
					pstmt.setString(6,request.getParameter("degree_name"));
					pstmt.setString(7,request.getParameter("degree_type"));
					pstmt.setInt(8,Integer.parseInt(request.getParameter("degree_id")));
	                  
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
	<%-- DELETE the degree FROM the degree table. --%>
	<% 
					
					PreparedStatement pstmt = connection.prepareStatement(
							"DELETE FROM degree WHERE degree_id = ?");
					
					pstmt.setInt(1,Integer.parseInt(request.getParameter("degree_id")));
	                  
	                pstmt.executeUpdate();%>

	<%-- DELETE the entries related to courses. --%>
	<%
	                PreparedStatement ms_degree = connection.prepareStatement(
							"DELETE FROM ms_degree WHERE degree_id = ?");
					
	                ms_degree.setInt(1,Integer.parseInt(request.getParameter("degree_id")));
	                
	                ms_degree.executeUpdate();
	                
	              	connection.commit();
					connection.setAutoCommit(true);
					}
				%>

	<%
				// Create the statement
				Statement stmt = connection.createStatement();
				
				// Use the statement to SELECT the degree attributes
				// FROM the degree table.
				ResultSet rs = stmt.executeQuery(GET_DEGREE_QUERY);
				
				%>
	<%-- Entry Form --%>
	<table>
		<tr>
			<th>degree_id</th>
			<th>upper_units</th>
			<th>lower_units</th>
			<th>elective_units</th>
			<th>total_units</th>
			<th>min_grade</th>
			<th>degree_name</th>
			<th>degree_type</th>
		</tr>

		<%-- Insert Form Code --%>
		<tr>
			<form action="degree.jsp" method="get">
				<input type="hidden" value="insert" name="action">

				<th><input value="" name="degree_id" size="15"></th>
				<th><input value="" name="upper_units" size="15"></th>
				<th><input value="" name="lower_units" size="15"></th>
				<th><input value="" name="elective_units" size="15"></th>
				<th><input value="" name="total_units" size="15"></th>
				<th><input value="" name="min_grade" size="15"></th>
				<th><input value="" name="degree_name" size="15"></th>
				<th><input value="" name="degree_type" size="15"></th>

				<th><input type="submit" value="Insert"></th>
			</form>
		</tr>

		<%
				
				// Iterate over the ResultSet
				while ( rs.next() ) {
				%>
		<%-- Update Form Code --%>
		<tr>
			<form action="degree.jsp" method="get">
				<input type="hidden" value="update" name="action">
				<td><input value="<%= rs.getInt("degree_id")%>" name="degree_id"></td>
				<td><input value="<%= rs.getInt("upper_units")%>" name="upper_units"></td>
				<td><input value="<%= rs.getInt("lower_units")%>" name="lower_units"></td>
				<td><input value="<%= rs.getInt("elective_units")%>" name="elective_units"></td>
				<td><input value="<%= rs.getInt("total_units")%>" name="total_units"></td>
				<td><input value="<%= rs.getString("min_grade")%>" name="min_grade"></td>
				<td><input value="<%= rs.getString("degree_name")%>" name="degree_name"></td>
				<td><input value="<%= rs.getString("degree_type")%>" name="degree_type"></td>

				<td>
					<input type="submit" value="Update">
				</td>
			</form>

			<form action="degree.jsp" method="get">
				<input type="hidden" value="delete" name="action">
				<input type="hidden" value="<%= rs.getInt("degree_id") %>" name="degree_id">
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