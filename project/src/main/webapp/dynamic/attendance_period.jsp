<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Period of Attendance Home Page</title>
</head>
<body>
<%-- Set the scripting language to Java and --%>
			<%@ page language="java" import="java.sql.*" %>
			
			<%-- -------- Open Connection Code -------- --%>
			<%
			try {
				// Load Oracle Driver attendance_period file
				DriverManager.registerDriver (new org.postgresql.Driver());
				String GET_PERIOD_QUERY = "Select * from attendance_period";
				
				// Make a connection to the Oracle datasource
				Connection connection = DriverManager.getConnection
				("jdbc:postgresql:tables?user=postgres&password=ahvuong");
				%>
				<%-- Check if an insertion is requested --%> 
				<% String action = request.getParameter("action");
				if (action != null && action.equals("insert")) {
					connection.setAutoCommit(false); %>
					<%-- Create the prepared statement and use it to --%>
					<%-- INSERT the attendance_period attrs INTO the attendance_period table. --%>
					<% 
					PreparedStatement pstmt = connection.prepareStatement(
							("INSERT INTO attendance_period VALUES (?, ?, ?)"));
					
					pstmt.setInt(1,Integer.parseInt(request.getParameter("student_id")));
					pstmt.setString(2,request.getParameter("begin"));
					pstmt.setString(3, request.getParameter("complete"));
					
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
					<%-- UPDATE the attendance_period attributes in the attendance_period table. --%>
					<% 
					
					PreparedStatement pstmt = connection.prepareStatement(
							"UPDATE attendance_period SET begin = ?, complete = ? " +
								"WHERE student_id = ?");
					
					pstmt.setString(1,request.getParameter("begin"));
					pstmt.setString(2, request.getParameter("complete"));
					pstmt.setInt(3, Integer.parseInt(request.getParameter("student_id")));
	                  
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
					<%-- DELETE the attendance_period FROM the attendance_period table. --%>
					<% 
					
					PreparedStatement pstmt = connection.prepareStatement(
							"DELETE FROM attendance_period WHERE student_id = ?");
					
					pstmt.setInt(1,Integer.parseInt(request.getParameter("student_id")));
	                  
	                pstmt.executeUpdate();
	                
	              	//connection.commit();
					connection.setAutoCommit(false);
					connection.setAutoCommit(true);
					}
				%>
				
				<%
				// Create the statement
				Statement stmt = connection.createStatement();
				
				// Use the statement to SELECT the attendance_period attributes
				// FROM the attendance_period table.
				ResultSet rs = stmt.executeQuery(GET_PERIOD_QUERY);
				
				%>
				<%-- Entry Form --%>
				<table>
					<tr>
						<th>student_id</th>
						<th>begin</th>
                      	<th>complete</th>
					</tr>
					
					<%-- Insert Form Code --%>
					<tr>
						<form action="attendance_period.jsp" method="get">
							<input type="hidden" value="insert" name="action">
							
							<th><input value="" name="student_id" size="15"></th>
							<th><input value="" name="begin" size="10"></th>
							<th><input value="" name="complete" size="10"></th>
							
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
					<form action="attendance_period.jsp" method="get">
				        <input type="hidden" value="update" name="action">
				        <td><input value="<%= rs.getInt("student_id")%>" name="student_id"></td>
				        <td><input value="<%= rs.getString("begin")%>" name="begin"></td>
				        <td><input value="<%= rs.getString("complete")%>" name="complete"></td>
				        
				        <td>
				            <input type="submit" value="Update">
				        </td>
			    	</form>
					
					<form action="attendance_period.jsp" method="get">
						<input type="hidden" value="delete" name="action">
						<input type="hidden" value="<%= rs.getInt("student_id") %>" name="student_id">
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