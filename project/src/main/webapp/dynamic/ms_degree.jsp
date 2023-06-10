<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>MS Degree Home Page</title>
</head>

<body>
	<%-- Set the scripting language to Java and --%>
	<%@ page language="java" import="java.sql.*" %>

	<%-- -------- Open Connection Code -------- --%>
	<%
			try {
				// Load Oracle Driver ms_degree file
				DriverManager.registerDriver (new org.postgresql.Driver());
				String GET_MS_DEGREE_QUERY = "Select * from ms_degree";
				
				// Make a connection to the Oracle datasource
				Connection connection = DriverManager.getConnection
				("jdbc:postgresql:tables?user=postgres&password=trungtinvo");
				%>
	<%-- Check if an insertion is requested --%>
	<% String action = request.getParameter("action");
				if (action != null && action.equals("insert")) {
					connection.setAutoCommit(false); %>
	<%-- Create the prepared statement and use it to --%>
	<%-- INSERT the ms_degree attrs INTO the ms_degree table. --%>
	<% 
					PreparedStatement pstmt = connection.prepareStatement(
							("INSERT INTO ms_degree VALUES (?, ?, ?, ?, ?, ?, ?)"));
					
					pstmt.setInt(1,Integer.parseInt(request.getParameter("degree_id")));
					pstmt.setString(2,request.getParameter("concentration_min_grade"));
					pstmt.setInt(3,Integer.parseInt(request.getParameter("concentration_1_units")));
					pstmt.setInt(4,Integer.parseInt(request.getParameter("concentration_2_units")));
					pstmt.setInt(5,Integer.parseInt(request.getParameter("concentration_3_units")));
					pstmt.setInt(6,Integer.parseInt(request.getParameter("concentration_total_units")));
					pstmt.setString(7,request.getParameter("ms_name"));
					
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
	<%-- UPDATE the ms_degree attributes in the ms_degree table. --%>
	<% 
					
					PreparedStatement pstmt = connection.prepareStatement(
							"UPDATE ms_degree SET concentration_min_grade = ?, " +
		                      "concentration_1_units = ?, concentration_2_units = ?, " + 
								"concentration_3_units = ?, concentration_total_units = ?, ms_name = ? " +
								"WHERE degree_id = ?");
					
					pstmt.setString(1,request.getParameter("concentration_min_grade"));
					pstmt.setInt(2,Integer.parseInt(request.getParameter("concentration_1_units")));
					pstmt.setInt(3,Integer.parseInt(request.getParameter("concentration_2_units")));
					pstmt.setInt(4,Integer.parseInt(request.getParameter("concentration_3_units")));
					pstmt.setInt(5,Integer.parseInt(request.getParameter("concentration_total_units")));
					pstmt.setString(6,request.getParameter("ms_name"));
					pstmt.setInt(7,Integer.parseInt(request.getParameter("degree_id")));
	                  
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
	<%-- DELETE the ms_degree FROM the ms_degree table. --%>
	<% 
					
					PreparedStatement pstmt = connection.prepareStatement(
							"DELETE FROM ms_degree WHERE degree_id = ?");
					
					pstmt.setInt(1,Integer.parseInt(request.getParameter("degree_id")));
	                  
	                pstmt.executeUpdate();
	                
	              	//connection.commit();
					connection.setAutoCommit(false);
					connection.setAutoCommit(true);
					}
				%>

	<%
				// Create the statement
				Statement stmt = connection.createStatement();
				
				// Use the statement to SELECT the ms_degree attributes
				// FROM the ms_degree table.
				ResultSet rs = stmt.executeQuery(GET_MS_DEGREE_QUERY);
				
				%>
	<%-- Entry Form --%>
	<table>
		<tr>
			<th>degree_id</th>
			<th>concentration_min_grade</th>
			<th>concentration_1_units</th>
			<th>concentration_2_units</th>
			<th>concentration_3_units</th>
			<th>concentration_total_units</th>
			<th>ms_name</th>
		</tr>

		<%-- Insert Form Code --%>
		<tr>
			<form action="ms_degree.jsp" method="get">
				<input type="hidden" value="insert" name="action">

				<th><input value="" name="degree_id" size="15"></th>
				<th><input value="" name="concentration_min_grade" size="15"></th>
				<th><input value="" name="concentration_1_units" size="15"></th>
				<th><input value="" name="concentration_2_units" size="15"></th>
				<th><input value="" name="concentration_3_units" size="15"></th>
				<th><input value="" name="concentration_total_units" size="15"></th>
				<th><input value="" name="ms_name" size="15"></th>

				<th><input type="submit" value="Insert"></th>
			</form>
		</tr>

		<%
				
				// Iterate over the ResultSet
				while ( rs.next() ) {
				%>
		<%-- Update Form Code --%>
		<tr>
			<form action="ms_degree.jsp" method="get">
				<input type="hidden" value="update" name="action">
				<td><input value="<%= rs.getInt("degree_id")%>" name="degree_id"></td>
				<td><input value="<%= rs.getString("concentration_min_grade")%>" name="concentration_min_grade"></td>
				<td><input value="<%= rs.getInt("concentration_1_units")%>" name="concentration_1_units"></td>
				<td><input value="<%= rs.getInt("concentration_2_units")%>" name="concentration_2_units"></td>
				<td><input value="<%= rs.getInt("concentration_3_units")%>" name="concentration_3_units"></td>
				<td><input value="<%= rs.getInt("concentration_total_units")%>" name="concentration_total_units"></td>
				<td><input value="<%= rs.getString("ms_name")%>" name="ms_name"></td>

				<td>
					<input type="submit" value="Update">
				</td>
			</form>

			<form action="ms_degree.jsp" method="get">
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