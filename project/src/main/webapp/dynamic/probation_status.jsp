<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Probation Status Home Page</title>
</head>
<body>
<%-- Set the scripting language to Java and --%>
			<%@ page language="java" import="java.sql.*" %>
			
			<%-- -------- Open Connection Code -------- --%>
			<%
			try {
				// Load Oracle Driver probation_status.jsp file
				DriverManager.registerDriver (new org.postgresql.Driver());
				String GET_PROBATION_QUERY = "Select * from probation_status";
				
				// Make a connection to the Oracle datasource
				Connection connection = DriverManager.getConnection
				("jdbc:postgresql:tables?user=postgres&password=ahvuong");
				%>
				<%-- Check if an insertion is requested --%> 
				<% String action = request.getParameter("action");
				if (action != null && action.equals("insert")) {
					connection.setAutoCommit(false); %>
					<%-- Create the prepared statement and use it to --%>
					<%-- INSERT the probation_status attrs INTO the probation_status table. --%>
					<% 
					PreparedStatement pstmt = connection.prepareStatement(
							("INSERT INTO probation_status VALUES (?, ?, ?, ?)"));
					
					pstmt.setInt(1, Integer.parseInt(request.getParameter("student_id")));
					pstmt.setString(2, request.getParameter("start"));
					pstmt.setString(3, request.getParameter("finish"));
					pstmt.setString(4, request.getParameter("reason"));
					
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
					<%-- UPDATE the probation_status attributes in the probation_status table. --%>
					<% 
					
					PreparedStatement pstmt = connection.prepareStatement(
							"UPDATE probation_status SET start = ?, finish = ?, " +
								"reason = ? WHERE student_id = ?");
					
					pstmt.setString(1,request.getParameter("start"));
					pstmt.setString(2, request.getParameter("finish"));
					pstmt.setString(3, request.getParameter("reason"));
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
					<%-- DELETE the probation_status FROM the probation_status table. --%>
					<% 
					
					PreparedStatement pstmt = connection.prepareStatement(
							"DELETE FROM probation_status WHERE student_id = ?");
					
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
				
				// Use the statement to SELECT the probation_status attributes
				// FROM the probation_status table.
				ResultSet rs = stmt.executeQuery(GET_PROBATION_QUERY);
				
				%>
				<%-- Entry Form --%>
				<table>
					<tr>
						<th>student_id</th>
						<th>start</th>
						<th>finish</th>
                      	<th>reason</th>
					</tr>
					
					<%-- Insert Form Code --%>
					<tr>
						<form action="probation_status.jsp" method="get">
							<input type="hidden" value="insert" name="action">
							
							<th><input value="" name="student_id" size="15"></th>
							<th><input value="" name="start" size="10"></th>
							<th><input value="" name="finish" size="10"></th>
							<th><input value="" name="reason" size="10"></th>
							
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
					<form action="probation_status.jsp" method="get">
				        <input type="hidden" value="update" name="action">
				        <td><input value="<%= rs.getInt("student_id")%>" name="student_id"></td>
				        <td><input value="<%= rs.getString("start")%>" name="start"></td>
				        <td><input value="<%= rs.getString("finish")%>" name="finish"></td>
				        <td><input value="<%= rs.getString("reason")%>" name="reason"></td>
				        
				        <td>
				            <input type="submit" value="Update">
				        </td>
			    	</form>
					
					<form action="probation_status.jsp" method="get">
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