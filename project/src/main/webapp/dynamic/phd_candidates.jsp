<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PhD Candidates Home Page</title>
</head>
<body>
<%-- Set the scripting language to Java and --%>
			<%@ page language="java" import="java.sql.*" %>
			
			<%-- -------- Open Connection Code -------- --%>
			<%
			try {
				// Load Oracle Driver phd_candidates file
				DriverManager.registerDriver (new org.postgresql.Driver());
				String GET_CANDIDATES_QUERY = "Select * from phd_candidates";
				
				// Make a connection to the Oracle datasource
				Connection connection = DriverManager.getConnection
				("jdbc:postgresql:tables?user=postgres&password=ahvuong");
				%>
				<%-- Check if an insertion is requested --%> 
				<% String action = request.getParameter("action");
				if (action != null && action.equals("insert")) {
					connection.setAutoCommit(false); %>
					<%-- Create the prepared statement and use it to --%>
					<%-- INSERT the phd_candidates attrs INTO the phd_candidates table. --%>
					<% 
					PreparedStatement pstmt = connection.prepareStatement(
							("INSERT INTO phd_candidates VALUES (?, ?, ?)"));
					
					pstmt.setInt(1,Integer.parseInt(request.getParameter("student_id")));
					pstmt.setString(2,request.getParameter("department"));
					pstmt.setBoolean(3, Boolean.parseBoolean(request.getParameter("phd_candidate")));
					
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
					<%-- UPDATE the phd_candidates attributes in the phd_candidates table. --%>
					<% 
					
					PreparedStatement pstmt = connection.prepareStatement(
							"UPDATE phd_candidates SET department = ?, phd_candidate = ? WHERE student_id = ?");
					
					pstmt.setString(1,request.getParameter("department"));
					pstmt.setBoolean(2, Boolean.parseBoolean(request.getParameter("phd_candidate")));
					pstmt.setInt(3,Integer.parseInt(request.getParameter("student_id")));
					
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
					<%-- DELETE the phd_candidates FROM the phd_candidates table. --%>
					<% 
					
					PreparedStatement pstmt = connection.prepareStatement(
							"DELETE FROM phd_candidates WHERE student_id = ?");
					
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
				
				// Use the statement to SELECT the phd_candidates attributes
				// FROM the phd_candidates table.
				ResultSet rs = stmt.executeQuery(GET_CANDIDATES_QUERY);
				
				%>
				<%-- Entry Form --%>
				<table>
					<tr>
						<th>student_id</th>
						<th>department</th>
						<th>phd_candidate</th>
					</tr>
					
					<%-- Insert Form Code --%>
					<tr>
						<form action="phd_candidates.jsp" method="get">
							<input type="hidden" value="insert" name="action">
							
							<th><input value="" name="student_id" size="15"></th>
							<th><input value="" name="department" size="10"></th>
							<th>
								<select name="phd_candidate">
									<option value="True">
										Yes</option>
									<option value="False" >
										No</option>
								</select>
							</th>
							
							<th><input type="submit" value="Insert"></th>
						</form>
					</tr>
				
				<%
				// Iterate over the ResultSet
				while ( rs.next() ) {
				%>
				<%-- Update Form Code --%>
				<tr>
					<form action="phd_candidates.jsp" method="get">
				        <input type="hidden" value="update" name="action">
				        <td><input value="<%= rs.getInt("student_id")%>" name="student_id"></td>
				        <td><input value="<%= rs.getString("department")%>" name="department"></td>
				        <td>
				            <select name="phd_candidate">
				                <option value="true" <%= rs.getBoolean("phd_candidate") ? "selected" : "" %>>Yes</option>
				                <option value="false" <%= !rs.getBoolean("phd_candidate") ? "selected" : "" %>>No</option>
				            </select>
				        </td>
				        
				        <td>
				            <input type="submit" value="Update">
				        </td>
			    	</form>
					
					<form action="phd_candidates.jsp" method="get">
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