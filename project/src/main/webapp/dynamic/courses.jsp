<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Course Home Page</title>
</head>
<body>
<%-- Set the scripting language to Java and --%>
			<%@ page language="java" import="java.sql.*" %>
			
			<%-- -------- Open Connection Code -------- --%>
			<%
			try {
				// Load Oracle Driver class file
				DriverManager.registerDriver (new org.postgresql.Driver());
				String GET_COURSE_QUERY = "Select * from courses";
				
				// Make a connection to the Oracle datasource
				Connection connection = DriverManager.getConnection
				("jdbc:postgresql:tables?user=postgres&password=ahvuong");
				%>
				<%-- Check if an insertion is requested --%> 
				<% String action = request.getParameter("action");
				if (action != null && action.equals("insert")) {
					connection.setAutoCommit(false); %>
					<%-- Create the prepared statement and use it to --%>
					<%-- INSERT the courses attrs INTO the courses table. --%>
					<% 
					PreparedStatement pstmt = connection.prepareStatement(
							("INSERT INTO courses VALUES (?, ?, ?, ?, ?, ?, ?)"));
					
					pstmt.setString(1,request.getParameter("new_number"));
					pstmt.setString(2,request.getParameter("old_number"));
					pstmt.setInt(3, Integer.parseInt(request.getParameter("units")));
					pstmt.setString(4, request.getParameter("department"));
					pstmt.setString(5, request.getParameter("prerequisites"));
					pstmt.setString(6, request.getParameter("lab_requirements"));
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
					<%-- UPDATE the courses attributes in the courses table. --%>
					<% 
					
					PreparedStatement pstmt = connection.prepareStatement(
							"UPDATE courses SET old_number = ?, units = ?, " +
		                      "department = ?, prerequisites = ?, lab_requirements = ?, " +
								"grade = ? WHERE new_number = ?");
					
					pstmt.setString(1,request.getParameter("old_number"));
					pstmt.setInt(2, Integer.parseInt(request.getParameter("units")));
					pstmt.setString(3, request.getParameter("department"));
					pstmt.setString(4, request.getParameter("prerequisites"));
					pstmt.setString(5, request.getParameter("lab_requirements"));
					pstmt.setString(6, request.getParameter("grade"));
					pstmt.setString(7,request.getParameter("new_number"));
	                  
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
							"DELETE FROM courses WHERE new_number = ?");
					
					pstmt.setString(1,request.getParameter("new_number"));
	                
	                pstmt.executeUpdate();%>
	                
	                <%-- DELETE the entries related to courses. --%>
	                <%
	                PreparedStatement class_del = connection.prepareStatement(
							"DELETE FROM classes WHERE new_number = ?");
					
					PreparedStatement meeting = connection.prepareStatement(
							"DELETE FROM meeting_sections WHERE new_number = ?");
					
					PreparedStatement weekly = connection.prepareStatement(
							"DELETE FROM weekly WHERE new_number = ?");
					
					PreparedStatement review = connection.prepareStatement(
							"DELETE FROM review WHERE new_number = ?");
					
					class_del.setString(1,request.getParameter("new_number"));
					meeting.setString(1,request.getParameter("new_number"));
					weekly.setString(1,request.getParameter("new_number"));
					review.setString(1,request.getParameter("new_number"));
	                
					class_del.executeUpdate();
					meeting.executeUpdate();
					weekly.executeUpdate();
					review.executeUpdate();
	                
	              	connection.commit();
					connection.setAutoCommit(true);
					}
				%>
				
				<%
				// Create the statement
				Statement stmt = connection.createStatement();
				
				// Use the statement to SELECT the courses attributes
				// FROM the courses table.
				ResultSet rs = stmt.executeQuery(GET_COURSE_QUERY);
				
				%>
				<%-- Entry Form --%>
				<table>
					<tr>
						<th>new_number</th>
						<th>old_number</th>
                      	<th>units</th>
                      	<th>department</th>
                      	<th>prerequisites</th>
                      	<th>lab_requirements</th>
                      	<th>grade</th>
					</tr>
					
					<%-- Insert Form Code --%>
					<tr>
						<form action="courses.jsp" method="get">
							<input type="hidden" value="insert" name="action">
							<th><input value="" name="new_number" size="10"></th>
							<th><input value="" name="old_number" size="10"></th>
							<th><input value="" name="units" size="15"></th>
							<th><input value="" name="department" size="15"></th>
							<th><input value="" name="prerequisites" size="15"></th>
							<th><input value="" name="lab_requirements" size="15"></th>
							<th>
								<select name="grade">
									<option value="LETTER">LETTER</option>
									<option value="S/U" >S/U</option>
									<option value="IN">IN</option>
								</select>
							</th>
							
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
					<form action="courses.jsp" method="get">
				        <input type="hidden" value="update" name="action">
				        <td><input value="<%= rs.getString("new_number")%>" name="new_number"></td>
				        <td><input value="<%= rs.getString("old_number")%>" name="old_number"></td>
				        <td><input value="<%= rs.getInt("units")%>" name="units"></td>
				        <td><input value="<%= rs.getString("department")%>" name="department"></td>
				        <td><input value="<%= rs.getString("prerequisites")%>" name="prerequisites"></td>
				        <td><input value="<%= rs.getString("lab_requirements")%>" name="lab_requirements"></td>
				        <td>
							<select name="grade" required>
			                    <% String s = rs.getString("grade"); %>
			                    <option value="LETTER" <%= s.equals("LETTER") ? "selected":"" %>>LETTER</option>
			                    <option value="S/U" <%= s.equals("S/U") ? "selected":"" %>>S/U</option>
			                    <option value="IN" <%= s.equals("IN") ? "selected":"" %>>IN</option>
		                	</select></td>
						<td>
				        
				        <td>
				            <input type="submit" value="Update">
				        </td>
			    	</form>
					
					<form action="courses.jsp" method="get">
						<input type="hidden" value="delete" name="action">
						<input type="hidden" value="<%= rs.getString("new_number") %>" name="new_number">
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