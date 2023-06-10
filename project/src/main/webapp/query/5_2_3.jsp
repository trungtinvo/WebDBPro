<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>CPG Grade Distribution Report</title>
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
		<li>Choose course and professor to get the count of "A", "B", "C", "D", and "other" grades that the
			professor gave to the students taking course</li>
	</ol>

	<h2>Please Choose Info</h2>
	<form action="5_2_3.jsp" method="POST">

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
        

        PreparedStatement statement1 = connection.prepareStatement("SELECT count_a FROM CPG " +
                "WHERE title = ? AND instructor_name = ? ");
        PreparedStatement statement2 = connection.prepareStatement("SELECT count_b FROM CPG " +
                "WHERE title = ? AND instructor_name = ? ");
         PreparedStatement statement3 = connection.prepareStatement("SELECT count_c FROM CPG " +
                "WHERE title = ? AND instructor_name = ? ");        
         PreparedStatement statement4 = connection.prepareStatement("SELECT count_d FROM CPG " +
                "WHERE title = ? AND instructor_name = ? ");
        PreparedStatement statement5 = connection.prepareStatement("SELECT count_other FROM CPG " +
                "WHERE title = ? AND instructor_name = ? ");  
        
        statement1.setString(1, courseId);
        statement1.setString(2, professorName);
        
        statement2.setString(1, courseId);
        statement2.setString(2, professorName);

        statement3.setString(1, courseId);
        statement3.setString(2, professorName);

         statement4.setString(1, courseId);
        statement4.setString(2, professorName);

        statement5.setString(1, courseId);
        statement5.setString(2, professorName); 


        ResultSet resultSet1 = statement1.executeQuery();
        ResultSet resultSet2 = statement2.executeQuery();
        ResultSet resultSet3 = statement3.executeQuery();
        ResultSet resultSet4 = statement4.executeQuery();
        ResultSet resultSet5 = statement5.executeQuery();  
        
        int count_a = 0;
        int count_b = 0;
        int count_c = 0;
        int count_d = 0;
        int count_other = 0;
        
        while (resultSet1.next()) {
           	count_a += resultSet1.getInt("count_a");
        }
        while (resultSet2.next()) {
           	count_b += resultSet2.getInt("count_b");
        }
          while (resultSet3.next()) {
           	count_c = resultSet3.getInt("count_c");
        }
         while (resultSet4.next()) {
           	count_d = resultSet4.getInt("count_d");
        }
        while (resultSet5.next()) {
           	count_other = resultSet5.getInt("count_other");
         }  
        
        %>
	<p>courseId: <%= courseId %>, professorName: <%= professorName %></p>
	<table style="width:20%">
		<tr>
			<th>Count_A</th>
			<th>Count_B</th>
			<th>Count_C</th>
			<th>Count_D</th>
			<th>Count_Other</th>
		</tr>
		<tr>
			<td><%= count_a %></td>
			<td><%= count_b %></td>
			<td><%= count_c %></td>
			<td><%= count_d %></td>
			<td><%= count_other %></td>
		</tr>
	</table>
	<%       

        // Close the resources
        resultSet1.close();
		statement1.close();
		resultSet2.close();
		statement2.close();
 		resultSet3.close();
		statement3.close();
 		resultSet4.close();
		statement4.close();
		resultSet5.close();
		statement5.close();  
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