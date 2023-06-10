<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Review Schedule Report</title>
</head>

<style>
table, th, td {
  border:1px solid black;
}
</style>

<body>
	<%-- Set the scripting language to Java and --%>
	<%@ page language="java" import="java.sql.*" import="java.util.*" 
	import="java.util.Date" import="java.text.SimpleDateFormat" %>

	<%-- -------- Open Connection Code -------- --%>
	
	<%
	try {
		// Load Oracle Driver class file
		DriverManager.registerDriver (new org.postgresql.Driver());
		//String GET_ADVISOR_QUERY = "Select * from advisor";
				
		// Make a connection to the Oracle datasource
		Connection connection = DriverManager.getConnection
		("jdbc:postgresql:tables?user=postgres&password=ahvuong");
	%>
	<%-- Check if an insertion is requested --%>
	<% 
		String action = request.getParameter("action");
		String second_action = request.getParameter("second_action");
		
		String num = "";
		String title = "";
		String quarter = "";
		String sdate = "";
		String edate = "";
		int id = 0;
		int year = 0;
		
		ResultSet class_info = null;
    	ResultSet review_info = null;
    
    	// Select all class's information
    	connection.setAutoCommit(false);
		PreparedStatement pstmt2 = connection.prepareStatement(
								"SELECT * FROM classes c " +
								"WHERE c.quarter = 'SP' AND c.year = 2023 " +
								"ORDER BY c.section_id");
					
	
		class_info = pstmt2.executeQuery();
		connection.commit();
		connection.setAutoCommit(true);
	
		
		if (action != null && action.equals("submit")) 
		{
			connection.setAutoCommit(false); %>
	<%-- Create the prepared statement and use it to --%>
	<% 				
				PreparedStatement pstmt = connection.prepareStatement(
						"WITH date AS (SELECT DISTINCT date::date " +
										"FROM GENERATE_SERIES(?::date, ?::date, '1 day'::interval) date " +
										"ORDER BY date::date " +
										"), " +
								"time AS (SELECT DISTINCT time::time " +
											"FROM GENERATE_SERIES(?::date, ?::date, '1 hour'::interval) time " +
											"ORDER BY time::time " +
										"), " +
								"date_time AS(SELECT DISTINCT d.date, t.time as begin_time, t.time " +
																"+ '1 hour'::interval as end_time " +
											"FROM date d, time t " +
											"ORDER BY d.date, t.time " +
											"), " +
								"student_cur_course AS (SELECT student_id " +
														"FROM course_enrollment " +
														"WHERE section_id = ? AND class_name = ? " +
														"), " +
								"weekly_section AS (SELECT w.date_time, w.begin_time, w.end_time " +
													"FROM weekly w, course_enrollment ce " +
													"WHERE w.section_id = ce.section_id " +
															"AND w.new_number = ce.class_name " +
															"AND ce.student_id IN " + 
																			"(SELECT * FROM student_cur_course) " +
													") " +
						"SELECT d.date, d.begin_time, d.end_time " +
						"FROM date_time d " +
						"WHERE d.begin_time >= '08:00:00' AND d.begin_time <> '23:00:00' " +
							"AND d.end_time <= '20:00:00' AND d.end_time <> '00:00:00' " +
							"AND NOT EXISTS (SELECT w.date_time, w.begin_time, w.end_time " +
											"FROM weekly_section w " +
											"WHERE w.date_time = d.date " +
											"AND (w.begin_time, w.end_time) OVERLAPS (d.begin_time, d.end_time) " +
											")"
						);
			
			String[] info = request.getParameter("class_information").split(" ");
	
			sdate = request.getParameter("start");
			edate = request.getParameter("end");
			//System.out.println("sdate " + sdate);
			//System.out.println("edate " + edate);
			
			id = Integer.parseInt(info[1]);
			num = info[3];
			
			pstmt.setString(1, sdate);
			pstmt.setString(2, edate);
			pstmt.setString(3, sdate);
			pstmt.setString(4, edate);
			pstmt.setInt(5, id);
			pstmt.setString(6, num);
			
			//System.out.println("Test3");
		
			review_info = pstmt.executeQuery();
			
			connection.commit();
			connection.setAutoCommit(true);
		}
	%>

	<%-- Form --%>
	<h2>Review Schedule Information</h2>
	<form action="2b.jsp" method="POST">
		<div>
			<select name="class_information">
			<option>--Choose A Class--</option>
			<%
				if (class_info.isBeforeFirst())
				{
					while(class_info.next())
					{
						num = class_info.getString("new_number");
						year = class_info.getInt("year");
						quarter = class_info.getString("quarter");
						id = class_info.getInt("section_id");
						title = class_info.getString("title");
						
						String class_information =  "Section: " + String.valueOf(id) + " " +
													"Course: " + num + " " +  
													"Class: " + title + " " + 
													"Year: " + String.valueOf(year) + " " + 
													"Quarter: " + quarter + " ";
						//System.out.println(class_information);
			%>
			<option value="<%=class_information%>"><%=class_information%></option>
			<%
					}
				}
			%>
			</select>
			<br>
			<h3>Choose Time Period</h3>
			<label>START_DATE</label>
			<input type="date" name="start" min='2023-04-01' max='2023-06-15'><br><br>
			<label>END_DATE</label>
			<input type="date" name="end" min='2023-04-01' max='2023-06-15'>
		</div>
		<br>
		
		<button type="submit" name="action" value="submit">Submit</button>
	</form>
	
	<h3>Review Session For</h3>
	<%
	String[] info1 = request.getParameter("class_information").split(" ");
	%>
	<table style="width:100%">
		<tr>
			<th>Section ID</th>
			<th>Course</th>
            <th>Class Title</th>
			<th>Year</th>
            <th>Quarter</th>
		</tr>
		<%
		if(info1.length != 0)
		{	
		%>	
			<tr>
				<td><%=info1[1] %></td>
				<td><%=info1[3] %></td>
				<td><%=info1[5] %></td>
				<td><%=info1[7] %></td>
				<td><%=info1[9] %></td>
			</tr>
		<%
		}
		%>
	</table>
	<br>
	
	<h3>Available Times:</h3>
	
	<%-- Table --%>
		<%
		if(review_info != null)
		{	
			//System.out.println("Test0: " + student_info.isBeforeFirst());
			
			if(!review_info.isBeforeFirst())
			{
				%>
				<p>No Review Schedule</p>
				<%
			}
			else
			{
				%>
				<table style="width:100%">
				<tr>
					<th>Date</th>
					<th>Begin Time</th>
					<th>End Time</th>
				</tr>
				<%
				//System.out.println("Test1");
				while(review_info.next())
				{
					String date = review_info.getString("date");
					String begin_time = review_info.getString("begin_time");
					String end_time = review_info.getString("end_time");
					
					//System.out.println("begin_time " + begin_time);
				%>
					<form>
						<tr>
							<td><%=date %></td>
							<td><%=begin_time %></td>
							<td><%=end_time %></td>
						</tr>
					
				<%
				}
			}
		}
		%>
		
		</form>
	</table>
	<br>

	<%-- Close --%>
	<%
		// Close the ResultSet
		//rs.close();
		// Close the Statement
		//stmt.close();
		// Close the Connection
		connection.close();
	} catch (SQLException sqle) {
		out.println(sqle.getMessage());
	} catch (Exception e) {
		//out.println(e.getMessage());
		out.println("Select Class Above First");
	}
	%>
	<br><br>
</body>
<a href="../index.html">Go to Home Page</a>
</html>