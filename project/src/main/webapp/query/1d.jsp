<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Undergraduate Degree Requirement Report</title>
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
    
        String action = request.getParameter("action");
        
        String student_id = "";
        String ssn = "";
		String first = "";
		String middle = "";
		String last = "";
        
        ResultSet student_info = null;
        ResultSet class_info = null;
        ResultSet degree_info = null;
        ResultSet filter_degree = null; 

        HashMap <String, Integer> required_units = new HashMap<>();
        HashMap <String, Integer> archieved_units = new HashMap<>();
        
        connection.setAutoCommit(false);
    	PreparedStatement pstmt2 = connection.prepareStatement("SELECT * FROM students where student_id in (select student_id from undergraduate)");
    	student_info = pstmt2.executeQuery();

    	PreparedStatement pstmt5 = connection.prepareStatement("SELECT * FROM undergraduate");
    	filter_degree = pstmt5.executeQuery(); 
    	
    	connection.commit();
    	connection.setAutoCommit(true);
    	
        if (action != null && action.equals("submit")) {
        	
            connection.setAutoCommit(false);
            
            String correct_major = null;
            
            PreparedStatement pstmt4 = connection.prepareStatement(
    				"SELECT * FROM undergraduate where student_id = ?"
    		);
            
            pstmt4.setInt(1, Integer.parseInt(request.getParameter("student_id")));

            ResultSet major_info = pstmt4.executeQuery();
            
            while (major_info.next()) {
            	correct_major = major_info.getString("major");
            }
            
            String majorValue = request.getParameter("major"); 
            if (majorValue.equals(correct_major)) { 
                PreparedStatement pstmt = connection.prepareStatement(
    				"SELECT * FROM degree where degree_name = ? AND degree_type = ?"
    			);
    			
                pstmt.setString(1, correct_major);
                pstmt.setString(2, "BS");

                degree_info = pstmt.executeQuery();	

            PreparedStatement pstmt3 = connection.prepareStatement(
    				"SELECT * FROM past_classes where student_id = ?"
    		);
    			
            pstmt3.setInt(1, Integer.parseInt(request.getParameter("student_id")));

            class_info = pstmt3.executeQuery();
            
            connection.commit();
            connection.setAutoCommit(true);
           	}
            
        }
        

    %>

	<h2>Choose Student And Degree Info</h2>
	<form action="1d.jsp" method="POST">

		<div>
			<select name="student_id">
			<option>--Choose A Student--</option>
				<%
					if (student_info.isBeforeFirst())
					{
						while(student_info.next()){
							student_id = student_info.getString("student_id");
							ssn = student_info.getString("ssn");
							first = student_info.getString("first_name");
							middle = student_info.getString("middle_name");
							last = student_info.getString("last_name");
							
							if (middle.equals("NULL"))
								middle = "";
							
							String student_information = "SSN: " + ssn + " " + 
														"First Name: " + first + " " + 
														"Middle Name: " + middle + " " +
														"Last Name: " + last + " ";
	                    %>
				<option value=<%=student_id%>><%=student_information%></option>
				<%
						}
					}
					%>
			</select>

		</div>
		<br>
		<div>
			<select name="major">
			<option>--Degree Name and Type--</option>
				<%
					if (filter_degree.isBeforeFirst())
					{
						while(filter_degree.next()){
	                       
							%>
				<option value="<%=filter_degree.getString("major")%>">
					<%=filter_degree.getString("major")%>
					(BS)
				</option>
				<%
						}
					}
					%>
			</select>
		</div>
		<br>
		<button type="submit" name="action" value="submit">Submit</button>
	<br>
	</form>

	<% 
  	 		if (degree_info != null) {
  				if (degree_info.isBeforeFirst()) {
					while(degree_info.next()) { 
/* 					    System.out.println("upper_units1: " + required_units.get("upper_units"));
					    System.out.println("lower_units1: " + required_units.get("lower_units")); */
					    int upperUnits = degree_info.getInt("upper_units");
					    int lowerUnits = degree_info.getInt("lower_units");
					    int electiveUnits = degree_info.getInt("elective_units");

					    required_units.put("upper_units", upperUnits);
					    required_units.put("lower_units", lowerUnits);
					    required_units.put("elective_units", electiveUnits);
		
/*  					System.out.println("upper_units1: " + required_units.get("upper_units"));
					    System.out.println("lower_units1: " + required_units.get("lower_units"));  */
					}
				}	
  			}  
	 			 		
  	 		if (class_info != null) {
				archieved_units.put("upper_units", 0);
				archieved_units.put("lower_units", 0);
				archieved_units.put("elective_units", 0);
  				if (class_info.isBeforeFirst()) {
					while(class_info.next()) { 
						String class_type = class_info.getString("class_type");
						int units = class_info.getInt("units");

						if (class_type.equals("upper_units")) {
							archieved_units.put("upper_units", archieved_units.get("upper_units") + units);
						}
						if (class_type.equals("lower_units")) {
							archieved_units.put("lower_units", archieved_units.get("lower_units") + units);
						}
						if (class_type.equals("elective_units")) {
							archieved_units.put("elective_units", archieved_units.get("elective_units") + units);
						}
						if (class_type.equals("UP&ELT_units")) {
							archieved_units.put("upper_units", archieved_units.get("upper_units") + units);
							archieved_units.put("elective_units", archieved_units.get("elective_units") + units);
						}
					}
				}	
  			}
   	 		int upper_remain = 0;	
 	 		int lower_remain = 0;
 	 		int elective_remain = 0;
 	 		int total_remain = 0;		

 	 			
   	 	 	if (class_info != null && degree_info != null) { 
		 		if(archieved_units.get("upper_units")>= required_units.get("upper_units")) {
		 			upper_remain = 0;
		 		} else {
		 			upper_remain = required_units.get("upper_units") - archieved_units.get("upper_units");
		 		}
		 		
		 		if(archieved_units.get("lower_units")>= required_units.get("lower_units")) {
		 			lower_remain = 0;
		 		} else {
		 			lower_remain = required_units.get("lower_units") - archieved_units.get("lower_units");
		 		}
		 		
		 		if(archieved_units.get("elective_units")>= required_units.get("elective_units")) {
		 			elective_remain = 0;
		 		} else {
		 			elective_remain = required_units.get("elective_units") - archieved_units.get("elective_units");
		 		}
		 		
		 		
		 		total_remain = upper_remain + lower_remain + elective_remain;
 	 		 }    
	 		
	 		if (class_info != null) {   
		 
	 		%>

	<%-- Table --%>
	<br>
	<table style="width:100%">
		<tr>
			<th>Student id</th>
			<th>Upper Units Remaining</th>
			<th>Lower Units Remaining</th>
			<th>Elective Units Remaining</th>
			<th>Total</th>

		</tr>
		<tr>
			<td><%= request.getParameter("student_id") %></td>
			<td><%= upper_remain %></td>
			<td><%= lower_remain %></td>
			<td><%= elective_remain %></td>
			<td><%= total_remain %></td>
		</tr>
	</table>
	<br>
	<% } 
	 else { %>
	<p><strong>Wrong major, please choose again!</strong></p>
	<% } %>

	<%-- iteration --%>
	
	<%
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