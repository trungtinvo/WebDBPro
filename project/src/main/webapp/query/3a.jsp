<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Grade Distribution Report</title>
</head>
<style>
	table,
	th,
	td {
		border: 1px solid black;
	}
</style>

<body>

	<%
    try {
        DriverManager.registerDriver(new org.postgresql.Driver());
    
        Connection connection = DriverManager.getConnection(
        		"jdbc:postgresql:tables?user=postgres&password=trungtinvo");
        Statement statement = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
    
        String action = request.getParameter("action");
        
        String courseID = "";
        ResultSet course_info = null;
        ResultSet class_info = null; 
        
        ArrayList<String> temp = new ArrayList<>();
        
        connection.setAutoCommit(false);
    	PreparedStatement pstmt2 = connection.prepareStatement("SELECT * FROM courses");
    	course_info = pstmt2.executeQuery();

    	class_info = statement.executeQuery("SELECT * FROM classes");
    	
    	connection.commit();
    	connection.setAutoCommit(true);
         
            
    %>
	<!--------------- choose inputs including course, professor, quarter ----------------->
	<h2>Instruction:</h2>
	<ol>
		<li>Choose course, professor, and a quarter to get the count of "A", "B", "C", "D", and "other" grades that the
			professor gave at the quarter to the students taking course</li>
		<li>Choose course, professor to get grade points average, the count of "A", "B", "C", "D", and "other" grades
			that the professor has given over the years.</li>
		<li>Choose the course to get the count of "A", "B", "C", "D", and "other" grades given to students over the
			years</li>
	</ol>

	<h2>Please Choose Info</h2>
	<form action="3a.jsp" method="POST">

		<div>
			<select name=new_number>
				<option>--Choose A Course--</option>
				<%
					if (course_info.isBeforeFirst())
					{
						while(course_info.next()){
							courseID = course_info.getString("new_number");
	                    %>
				<option value=<%=courseID%>><%=courseID%></option>
				<%
						}
					}
					%>
			</select>

		</div>
		<br>
		<div>
			<select name="instructor_name">
				<option>--Choose A Professor--</option>
				<%
					if (class_info.isBeforeFirst())
					{
						while(class_info.next()){
							if (!temp.contains(class_info.getString("instructor_name"))){
								temp.add(class_info.getString("instructor_name"));
				%>
				<option value="<%=class_info.getString("instructor_name")%>">
					<%=class_info.getString("instructor_name")%>
				</option>
				<%
								}
						}
						class_info.beforeFirst();
						temp.clear();
					}
				%>
			</select>
		</div>
		<br>
		<div>
			<select name="quarter">
				<option>--Choose A Quarter--</option>
				<%
					if (class_info.isBeforeFirst())
					{
						while(class_info.next()){
							if (!temp.contains(class_info.getString("quarter"))){
								temp.add(class_info.getString("quarter"));
				%>
				<option value="<%=class_info.getString("quarter")%>">
					<%=class_info.getString("quarter")%>
				</option>
				<%
							}
						}
						class_info.beforeFirst();
						temp.clear();
					}
					%>
			</select>
		</div>
		<br>
		<button type="submit" name="action" value="submit">Submit</button>
	</form>
	<br>

	<!-- ----------------------------------------------------------------------------- -->

	<%-- iteration --%>

	<%	
    if (action != null && action.equals("submit")) {
        connection.setAutoCommit(false);
        String correct_major = null;
        /* ----------------------------------------------------------------------------- */
        String courseId = request.getParameter("new_number");  
        String professorName = request.getParameter("instructor_name");
        String quarter = request.getParameter("quarter");          

        PreparedStatement statement1 = connection.prepareStatement("SELECT grade, COUNT(*) as count FROM past_classes " +
                "WHERE title = ? AND instructor_name = ? AND quarter = ? " +
                "GROUP BY grade");
        statement1.setString(1, courseId);
        statement1.setString(2, professorName);
        statement1.setString(3, quarter);

        ResultSet resultSet = statement1.executeQuery();

        int totalCount = 0;
        while (resultSet.next()) {
            String grade = resultSet.getString("grade");
            int count = resultSet.getInt("count");
            String name = "";

            if (grade.contains("U") || grade.contains("S") || grade.contains("I") ) {
            	name = "Other";
            } else {
            	name = grade;
            }
            %>
	<p>courseId: <%= courseId %>, professorName: <%= professorName %>, quarter: <%= quarter %></p>
	<table style="width:20%">
		<tr>
			<th>Grade</th>
			<th>Count</th>
		</tr>
		<tr>
			<td><%= name %></td>
			<td><%= count %></td>
		</tr>
	</table>
	<%       
        }
        /* ----------------------------------------------------------------------------- */
		if (quarter.contains("--Choose A Quarter--")&& !professorName.contains("--Choose A Professor--")) {
			
			String sql = "SELECT AVG(grade_conversion) as gpa FROM past_classes " +
                     "WHERE title = ? AND instructor_name = ?";

	        PreparedStatement statement2 = connection.prepareStatement("SELECT grade, COUNT(*) as count FROM past_classes " +
	                "WHERE title = ? AND instructor_name = ? " +
	                "GROUP BY grade");
	        statement2.setString(1, courseId);
	        statement2.setString(2, professorName);
	        
	        ResultSet resultSet2 = statement2.executeQuery();
	
	        int totalCount2 = 0;
	        while (resultSet2.next()) {
	            String grade = resultSet2.getString("grade");
	            int count = resultSet2.getInt("count");
	            String name = "";
	
	            if (grade.contains("U") || grade.contains("S") || grade.contains("I") ) {
	            	name = "Other";
	            } else {
	            	name = grade;
	            }
	            %>
	<p>courseId: <%= courseId %></p>
	<table style="width:20%">
		<tr>
			<th>Grade</th>
			<th>Count</th>
		</tr>
		<tr>
			<td><%= name %></td>
			<td><%= count %></td>
		</tr>
	</table>
	<%       
	        }
	        
            PreparedStatement statement4 = connection.prepareStatement(sql);
            statement4.setString(1, courseId);
            statement4.setString(2, professorName);

            // Execute the query and retrieve the result set
            ResultSet resultSet4 = statement4.executeQuery();

            // Process the result set to retrieve the GPA
            if (resultSet4.next()) {
                double gpa = resultSet4.getDouble("gpa");
           
	            %>
	<table style="width:20%">
		<tr>
			<th>Grade Point Average</th>
		</tr>
		<tr>
			<td><%= gpa %></td>
		</tr>
	</table>
	<%      
            }
            // Close the resources
            resultSet4.close();
            statement4.close();
	        resultSet2.close();
	        statement2.close();		
		}
        
        /* ----------------------------------------------------------------------------- */ 
		if (quarter.contains("--Choose A Quarter--") && professorName.contains("--Choose A Professor--")) {
	        PreparedStatement statement3 = connection.prepareStatement("SELECT grade, COUNT(*) as count FROM past_classes " +
	                "WHERE title = ? " +
	                "GROUP BY grade");
	        statement3.setString(1, courseId);
	        
	        ResultSet resultSet3 = statement3.executeQuery();
	
	        int totalCount3 = 0;
	        while (resultSet3.next()) {
	            String grade = resultSet3.getString("grade");
	            int count = resultSet3.getInt("count");
	            String name = "";
	
	            if (grade.contains("U") || grade.contains("S") || grade.contains("I") ) {
	            	name = "Other";
	            } else {
	            	name = grade;
	            }
	            %>
	<p>courseId: <%= courseId %>, professorName: <%= professorName %></p>
	<table style="width:20%">
		<tr>
			<th>Grade</th>
			<th>Count</th>
		</tr>
		<tr>
			<td><%= name %></td>
			<td><%= count %></td>
		</tr>
	</table>
	<%       
	        }
	        resultSet3.close();      
	        statement3.close();
		}
        // Close the resources
        resultSet.close();
        statement.close();
    
        connection.commit();
        connection.setAutoCommit(true);   
    }
	
      connection.close();
           
      } catch (SQLException e1) {
    	  throw new RuntimeException("SQL Exception!", e1); 
    	  
      } catch (Exception e2) {
    	  throw new RuntimeException("Exception!", e2); 
      }
      %>
	<br>
</body>
<a href="../index.html">Back To Home Page Here</a>

</html>