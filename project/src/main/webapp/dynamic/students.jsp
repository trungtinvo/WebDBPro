<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student Home Page</title>
</head>
<body>
<%-- Set the scripting language to Java and --%>
			<%@ page language="java" import="java.sql.*" %>
			
			<%-- -------- Open Connection Code -------- --%>
			<%
			try {
				// Load Oracle Driver class file
				DriverManager.registerDriver (new org.postgresql.Driver());
				String GET_STUDENT_QUERY = "Select * from students";
				
				// Make a connection to the Oracle datasource
				Connection connection = DriverManager.getConnection
				("jdbc:postgresql:tables?user=postgres&password=ahvuong");
				%>
				<%-- Check if an insertion is requested --%> 
				<% String action = request.getParameter("action");
				if (action != null && action.equals("insert")) {
					connection.setAutoCommit(false); %>
					<%-- Create the prepared statement and use it to --%>
					<%-- INSERT the student attrs INTO the Student table. --%>
					<% 
					PreparedStatement pstmt = connection.prepareStatement(
							("INSERT INTO students VALUES (?, ?, ?, ?, ?, ?, ?)"));
					
					pstmt.setInt(1,Integer.parseInt(request.getParameter("student_id")));
					pstmt.setInt(2,Integer.parseInt(request.getParameter("ssn")));
					pstmt.setString(3, request.getParameter("first_name"));
					pstmt.setString(4, request.getParameter("middle_name"));
					pstmt.setString(5, request.getParameter("last_name"));
					pstmt.setString(6, request.getParameter("resident_status"));
					pstmt.setBoolean(7, Boolean.parseBoolean(request.getParameter("enrollment")));
					
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
					<%-- UPDATE the student attributes in the Student table. --%>
					<% 
					
					PreparedStatement pstmt = connection.prepareStatement(
							"UPDATE students SET ssn = ?, first_name = ?, " +
		                      "middle_name = ?, last_name = ?, resident_status = ?, " +
								"enrollment = ? WHERE student_id = ?");
					
					pstmt.setInt(1,Integer.parseInt(request.getParameter("ssn")));
					pstmt.setString(2, request.getParameter("first_name"));
					pstmt.setString(3, request.getParameter("middle_name"));
					pstmt.setString(4, request.getParameter("last_name"));
					pstmt.setString(5, request.getParameter("resident_status"));
					pstmt.setBoolean(6, Boolean.parseBoolean(request.getParameter("enrollment")));
					pstmt.setInt(7,Integer.parseInt(request.getParameter("student_id")));
	                  
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
					<%-- DELETE the student FROM the Student table. --%>
					<% 
					
					PreparedStatement pstmt = connection.prepareStatement(
							"DELETE FROM students WHERE student_id = ?");
					
					pstmt.setInt(1,Integer.parseInt(request.getParameter("student_id")));
	                  
	                pstmt.executeUpdate();%>
	                
	                <%-- DELETE the entries related to courses. --%>
	                <%
	                PreparedStatement attendance_period = connection.prepareStatement(
							"DELETE FROM attendance_period WHERE student_id = ?");
					PreparedStatement degree_earned = connection.prepareStatement(
							"DELETE FROM degree_earned WHERE student_id = ?");
					PreparedStatement probation_status = connection.prepareStatement(
							"DELETE FROM probation_status WHERE student_id = ?");
					PreparedStatement undergraduate = connection.prepareStatement(
							"DELETE FROM undergraduate WHERE student_id = ?");
					PreparedStatement bs_ms = connection.prepareStatement(
							"DELETE FROM BS_MS WHERE student_id = ?");
					PreparedStatement graduate = connection.prepareStatement(
							"DELETE FROM graduate WHERE student_id = ?");
					PreparedStatement ms_student = connection.prepareStatement(
							"DELETE FROM ms_student WHERE student_id = ?");
					PreparedStatement PhD_candidates = connection.prepareStatement(
							"DELETE FROM PhD_candidates WHERE student_id = ?");
					PreparedStatement advisor = connection.prepareStatement(
							"DELETE FROM advisor WHERE student_id = ?");
					PreparedStatement course_enrollment = connection.prepareStatement(
							"DELETE FROM course_enrollment WHERE student_id = ?");
					PreparedStatement past_classes = connection.prepareStatement(
							"DELETE FROM past_classes WHERE student_id = ?");
					PreparedStatement thesis_committee = connection.prepareStatement(
							"DELETE FROM thesis_committee WHERE student_id = ?");
					
					attendance_period.setInt(1,Integer.parseInt(request.getParameter("student_id")));
					degree_earned.setInt(1,Integer.parseInt(request.getParameter("student_id")));
					probation_status.setInt(1,Integer.parseInt(request.getParameter("student_id")));
					undergraduate.setInt(1,Integer.parseInt(request.getParameter("student_id")));
					bs_ms.setInt(1,Integer.parseInt(request.getParameter("student_id")));
					graduate.setInt(1,Integer.parseInt(request.getParameter("student_id")));
					ms_student.setInt(1,Integer.parseInt(request.getParameter("student_id")));
					PhD_candidates.setInt(1,Integer.parseInt(request.getParameter("student_id")));
					advisor.setInt(1,Integer.parseInt(request.getParameter("student_id")));
					course_enrollment.setInt(1,Integer.parseInt(request.getParameter("student_id")));
					past_classes.setInt(1,Integer.parseInt(request.getParameter("student_id")));
					thesis_committee.setInt(1,Integer.parseInt(request.getParameter("student_id")));
	                
					attendance_period.executeUpdate();
					degree_earned.executeUpdate();
					probation_status.executeUpdate();
					undergraduate.executeUpdate();
					bs_ms.executeUpdate();
					graduate.executeUpdate();
					ms_student.executeUpdate();
					PhD_candidates.executeUpdate();
					undergraduate.executeUpdate();
					course_enrollment.executeUpdate();
					past_classes.executeUpdate();
					thesis_committee.executeUpdate();
	                
	              	connection.commit();
					connection.setAutoCommit(true);
					}
				%>
				
				<%
				// Create the statement
				Statement stmt = connection.createStatement();
				
				// Use the statement to SELECT the student attributes
				// FROM the Student table.
				ResultSet rs = stmt.executeQuery(GET_STUDENT_QUERY);
				
				%>
				<%-- Entry Form --%>
				<table>
					<tr>
						<th>student_id</th>
						<th>ssn</th>
                      	<th>first_name</th>
                      	<th>middle_name</th>
                      	<th>last_name</th>
                      	<th>resident_status</th>
                      	<th>enrollment</th>
					</tr>
					
					<%-- Insert Form Code --%>
					<tr>
						<form action="students.jsp" method="get">
							<input type="hidden" value="insert" name="action">
							<th><input value="" name="student_id" size="10"></th>
							<th><input value="" name="ssn" size="9"></th>
							<th><input value="" name="first_name" size="15"></th>
							<th><input value="" name="middle_name" size="15"></th>
							<th><input value="" name="last_name" size="15"></th>
							<th>
								<%--<input type="radio" value="California Resident" name="resident_status">California Resident <br/>
								<input type="radio" value="Non-California Resident" name="resident_status">Non-California Resident <br/>
								<input type="radio" value="International Student" name="resident_status">International Student <br/>
								 --%>
								 <select name="resident_status">
									<option value="California Resident">
										California Resident</option>
									<option value="Non-California Resident" >
										Non-California Resident</option>
									<option value="International Student">
										International Student</option>
								</select>
							</th>
							<th>
								<%--<input type="radio" value="True" name="enrollment">	Yes <br/>
								<input type="radio" value="False" name="enrollment"> No --%>
								<select name="enrollment">
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
				//System.out.print("hello1\n");
				// Iterate over the ResultSet
				while ( rs.next() ) {
					//System.out.print("hello\n");
				%>
				<%-- Update Form Code --%>
				<tr>
					<form action="students.jsp" method="get">
				        <input type="hidden" value="update" name="action">
				        <td><input value="<%= rs.getInt("student_id")%>" name="student_id"></td>
				        <td><input value="<%= rs.getInt("ssn")%>" name="ssn"></td>
				        <td><input value="<%= rs.getString("first_name")%>" name="first_name"></td>
				        <td><input value="<%= rs.getString("middle_name")%>" name="middle_name"></td>
				        <td><input value="<%= rs.getString("last_name")%>" name="last_name"></td>
				        <td><select name="resident_status" required>
                            <% String s = rs.getString("resident_status"); %>
                                  <option value="California Resident" <%= s.equals("California Resident") ? "selected":"" %>>California Resident</option>
                                  <option value="Non-California Resident" <%= s.equals("Non-California Resident") ? "selected":"" %>>Non-California Resident</option>
                                  <option value="International Student" <%= s.equals("International Student") ? "selected":"" %>>International Student</option>
                            </select></td>
				        <td>
				            <select name="enrollment">
				                <option value="true" <%= rs.getBoolean("enrollment") ? "selected" : "" %>>Yes</option>
				                <option value="false" <%= !rs.getBoolean("enrollment") ? "selected" : "" %>>No</option>
				            </select>
				        </td>
				        <td>
				            <input type="submit" value="Update">
				        </td>
			    	</form>
					
					<form action="students.jsp" method="get">
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