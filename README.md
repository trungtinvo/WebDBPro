# CSE132B_Database_System_Application

## Group:
- **Anh Vuong**
- **Trung Tin Vo**

## Home Page
### [Data Entry Forms](/project/src/main/webapp/dynamic/)
1. Student Entry Form
   - Period Of Attendance Form
   - Degree Earned Determination Form
   - Probation Info Submission
   - Undergraduate Info Submission
   - BS/MS Program Info Submission
   - Graduate Info Submission
     - MS Info Submission
     - PhD Candidates Info Submission
     - Thesis Committee Submission
     - Advisor Submission
2. Faculty Entry Form
Teaching Submission
3. Course Enrollment
4. Class Entry Form  
   - Classes Taken In the Past
   - Meeting Sessions 
     - Review Session Info Submission
     - Weekly Session Info Submission
5. Course Entry Form
6. Degree Requirements’ Info Submission
   - MS Degree Requirement Info
### [Query Forms](/project/src/main/webapp/query/)
1. Reports I
   - [Current Class Report](/project/src/main/webapp/query/1a.jsp)
   - [Class Roster Report](/project/src/main/webapp/query/1b.jsp)
   - [Grade Report](/project/src/main/webapp/query/1c.jsp)
   - [Undergraduate Degree Requirement Report](/project/src/main/webapp/query/1d.jsp)
   - [MS Degree Requirement Report](/project/src/main/webapp/query/1e.jsp)
2. Reports II
   - [Class Schedule Report](/project/src/main/webapp/query/2a.jsp)
   - [Review Schedule Report](/project/src/main/webapp/query/2b.jsp)
3. Reports III
   - [Grade Distribution Report](/project/src/main/webapp/query/3a.jsp)
### [Milestone5 Query Forms](/project/src/main/webapp/query/)
1. Milestone 5_2
   - [CPQG Grade Distribution Report](/project/src/main/webapp/query/5_2_2.jsp)
   - [CPG Grade Distribution Report](/project/src/main/webapp/query/5_2_3.jsp)
2. Milestone 5_3
   - [Entry Form & Grade Distribution Report](/project/src/main/webapp/query/5_3.jsp)

## Project Milestones  
### [Part 1](/milestone_1.pdf): Schema Design  
Design an **E/R schema** that fully captures the data set. Include key information.
If there is information that is not captured in the schema include it in the form of notes associated with the appropriate entities or relationships.  
Translate your E/R schema into a 3th Normal Form **relational schema**.  
Include in the relational schema all applicable information on keys and foreign keys.  
You are advised to look ahead: Does the schema you produced make development of queries and constraints clean and easy? A bit more work now will save you from much more later.  
  
### [Part 2](/project/src/main/webapp/dynamic/): Entry Forms  
You are requested to build applications for inserting pieces of the [data](/data.sql) set in the [database](/tables.sql). In particular, the following data entry forms are required. Please enforce the primary-foreign key intergrity constraints on the database at table creation time.  
  
**1. Course Entry Form:** Provide forms that prompt for course data, one at a time, and appropriately insert them into the database. Course data include prerequisite information.  
**2. Class Entry Form:** Provide forms that prompt for class data (excluding the list of students who are taking the class) and insert them into the database. Classes will have to refer to courses you have already entered.  
**3.Student Entry Form:** Forms, again. Exclude information about the classes that the student takes or has taken, the probations he may have received, and his committee info. They will be covered by forms described below.  
**4. Faculty Entry Form**  
**5. Course Enrollment:** Provide a form that allows us to insert in the database that student X takes the course Y in the current quarter. If the course has multiple sections prompt for section. If the course is flexible on the number of units prompt the student for the number of units he wants to take.  
**6. Classes taken in the Past:** Provide a form that allows us to insert in the database that student X took the course Y in quarter Z. If the course has multiple sections prompt for section. Also, ask for the grade G of the student.  
**7. Thesis Committee Submission:** Provide a form that allows graduate students to submit their thesis committee.  
**8. Probation Info Submission**  
**9. Review Session Info Submission**  
**10. Degree Requirements’ Info Submission**  
  
You should make sure that the entry forms that you have build make it possible to enter every possible piece of data described in the data set.  
  
You could have additional forms if you think it is necessary (for instance to enter departments).  
  
### [Part 3](/project/src/main/webapp/query/): Reports and Decision Support Queries  
Build query forms and reports for the queries listed above. Your forms must prompt for the X, Y, Z, etc that appear in the query specification and they should produce reports with the results. The reports will most likely be tabular. Again, do not spend too much time on the UI.  
  
### [Part 4](/milestone_4.sql): Constraints
As we all very well know, there are multiple constraints on students, schedules, degree requirements, etc. Such requirements must be reflected in the database by using an appropriate schema design or explicit constraints. In every case, when data are entered that violate a constraint you should reject the data and display a message that explains which constraint has been violated.  
  
You will have to build the following constraints using triggers. Hints: You can use additional tables and variables to store intermediate results if necessary. Every time a trigger is triggered you should take necessary actions to restore the correctness of the database (if it has been compromised) and **display an appropriate message** to the user.  
  
1. The lectures ('LE'), discussions('DI') and lab('LAB') meetings of a section should not happen at the same time.  
2. If the enrollment limit of a section has been reached then additional enrollments should be rejected. It is not required to update the waitlist.  
3. A professor should not have multiple sections at the same time. For example, a professor that is scheduled to teach classes X and Y should not have conflicting sections, mainly overlapping meetings. It is enough to check for the regular meetings (e.g., "LE"). Extra credit is given for checking conflicts on the irregular meetings too.  
In your application, data should be entered using a Web interface. You can use the one you created in part 2, Data Entry, of the project or modify it. The error message to be displayed should include the error text coming from the DB server, possibly accompanied by your own message which clearly identifies the constraint that was violated.  
  
*Hint:* you can use additional tables and variables as needed to store the intermediate results.  
  
### [Part 5](/milestone_5.sql): Materialized Views and Maintenance  
Build the decision support queries [(3.a.2)](/project/src/main/webapp/query/5_2_2.jsp) and [(3.a.3)](/project/src/main/webapp/query/5_2_3.jsp) again, using the views described in the Materialized Views section. Then build [triggers](/project/src/main/webapp/query/5_3.jsp) that **incrementally** update (i.e., avoid deleting the old views and then recomputing them using the new values, but try to update the content of the materialized views in an incremental fashion: update the content of the views with the latest arrived updates) the materialized views upon insertion or change of a student’s grade.  