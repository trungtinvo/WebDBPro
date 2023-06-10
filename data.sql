-----------------Undergraduate students Info-----------------
INSERT INTO students(student_id, ssn, first_name, middle_name, last_name, resident_status, enrollment) 
VALUES ('1', '1', 'Benjamin', 'Ben', 'B', 'California Resident', 'Yes');
INSERT INTO undergraduate(student_id, major, minor, college) 
VALUES ('1', 'DSC', 'Math', 'Muir');

INSERT INTO students(student_id, ssn, first_name, middle_name, last_name, resident_status, enrollment) 
VALUES ('2', '2', 'Alex', 'Al', 'T', 'California Resident', 'Yes');
INSERT INTO undergraduate(student_id, major, minor, college) 
VALUES ('2', 'Math', 'CSE', 'Muir');

INSERT INTO students(student_id, ssn, first_name, middle_name, last_name, resident_status, enrollment) 
VALUES ('3', '3', 'Daniel', 'Dan', 'F', 'California Resident', 'Yes');
INSERT INTO undergraduate(student_id, college, major, minor) 
VALUES ('3', 'CSE', 'Math', 'Marshall');

INSERT INTO students(student_id, ssn, first_name, middle_name, last_name, resident_status, enrollment) 
VALUES ('4', '4', 'Helen', 'He', 'V', 'California Resident', 'Yes');
INSERT INTO undergraduate(student_id, major, minor, college) 
VALUES ('4', 'DSC', 'Math', 'Muir');

INSERT INTO students(student_id, ssn, first_name, middle_name, last_name, resident_status, enrollment) 
VALUES ('5', '5', 'Julie', '', 'C', 'Non-California Resident', 'No');
INSERT INTO undergraduate(student_id, college, major, minor) 
VALUES ('5', 'CSE', '', 'Revell');

INSERT INTO students(student_id, ssn, first_name, middle_name, last_name, resident_status, enrollment) 
VALUES ('6', '6', 'Kevin', '', 'L', 'California Resident', 'Yes');
INSERT INTO undergraduate(student_id, college, major, minor) 
VALUES ('6', 'MAE', '', 'Revell');

INSERT INTO students(student_id, ssn, first_name, middle_name, last_name, resident_status, enrollment) 
VALUES ('7', '7', 'Michael', '', 'B', 'Non-California Resident', 'Yes');
INSERT INTO undergraduate(student_id, college, major, minor) 
VALUES ('7', 'SE', '', 'Warren');

INSERT INTO students(student_id, ssn, first_name, middle_name, last_name, resident_status, enrollment) 
VALUES ('8', '8', 'Joseph', 'Jo', 'J', 'California Resident', 'Yes');
INSERT INTO undergraduate(student_id, college, major, minor) 
VALUES ('8', 'MAE', 'COGS', 'Marshall');

INSERT INTO students(student_id, ssn, first_name, middle_name, last_name, resident_status, enrollment)
VALUES ('9', '9', 'Devin', 'De', 'P', 'International Student', 'No');
INSERT INTO undergraduate(student_id, college, major, minor) 
VALUES ('9', 'MAE', '', 'Warren');

INSERT INTO students(student_id, ssn, first_name, middle_name, last_name, resident_status, enrollment) 
VALUES ('10', '10', 'Jim', 'Logan', 'F', 'Non-California Resident', 'Yes');
INSERT INTO undergraduate(student_id, college, major, minor) 
VALUES ('10', 'DSC', '', 'Muir');

INSERT INTO students(student_id, ssn, first_name, middle_name, last_name, resident_status, enrollment) 
VALUES ('11', '11', 'Joe', 'Vikram', 'N', 'California Resident', 'No');
INSERT INTO undergraduate(student_id, college, major, minor) 
VALUES ('11', 'ECE', '', 'Warren');

INSERT INTO students(student_id, ssn, first_name, middle_name, last_name, resident_status, enrollment) 
VALUES ('12', '12', 'Rachel', 'Ra', 'Z', 'International Student', 'Yes');
INSERT INTO undergraduate(student_id, college, major, minor) 
VALUES ('12', 'ECE', 'Math', 'Marshall');

INSERT INTO students(student_id, ssn, first_name, middle_name, last_name, resident_status, enrollment) 
VALUES ('13', '13', 'Zach', 'Za', 'M', 'Non-California Resident', 'Yes');
INSERT INTO undergraduate(student_id, college, major, minor) 
VALUES ('13', 'ECE', 'COGS', 'Warren');

INSERT INTO students(student_id, ssn, first_name, middle_name, last_name, resident_status, enrollment) 
VALUES ('14', '14', 'Justin', 'Ju', 'H', 'California Resident', 'Yes');
INSERT INTO undergraduate(student_id, college, major, minor) 
VALUES ('14', 'COGS', 'Math', 'Marshall');

INSERT INTO students(student_id, ssn, first_name, middle_name, last_name, resident_status, enrollment)
VALUES ('15', '15', 'Rahul', '', 'R', 'Non-California Resident', 'Yes');
INSERT INTO undergraduate(student_id, college, major, minor) 
VALUES ('15', 'COGS', 'Math', 'Warren');

-----------------MS students Info-----------------
INSERT INTO students(student_id, ssn, first_name, middle_name, last_name, resident_status, enrollment) 
VALUES ('16', '16', 'Dave', 'Da', 'C', 'Non-California Resident', 'No');
INSERT INTO graduate(student_id, department) 
VALUES ('16', 'CSE');
INSERT INTO ms_student(student_id, department) VALUES ('16', 'CE');

INSERT INTO students(student_id, ssn, first_name, middle_name, last_name, resident_status, enrollment) 
VALUES ('17', '17', 'Nelson', 'Ne', 'H', 'California Resident', 'Yes');
INSERT INTO graduate(student_id, department) 
VALUES ('17', 'MAE');
INSERT INTO ms_student(student_id, department) VALUES ('17', 'CSE');

INSERT INTO students(student_id, ssn, first_name, middle_name, last_name, resident_status, enrollment) 
VALUES ('18', '18', 'Andrew', 'An', 'P', 'Non-California Resident', 'Yes');
INSERT INTO graduate(student_id, department) 
VALUES ('18', 'ECE');
INSERT INTO ms_student(student_id, department) VALUES ('18', 'ME');

INSERT INTO students(student_id, ssn, first_name, middle_name, last_name, resident_status, enrollment) 
VALUES ('19', '19', 'Nathan', '', 'S', 'California Resident', 'Yes');
INSERT INTO graduate(student_id, department) 
VALUES ('19', 'SE');
INSERT INTO ms_student(student_id, department) VALUES ('19', 'CE');

INSERT INTO students(student_id, ssn, first_name, middle_name, last_name, resident_status, enrollment) 
VALUES ('20', '20', 'John', 'Jo', 'H', 'International Student', 'No');
INSERT INTO graduate(student_id, department) 
VALUES ('20', 'SE');
INSERT INTO ms_student(student_id, department) VALUES ('20', 'DS');

INSERT INTO students(student_id, ssn, first_name, middle_name, last_name, resident_status, enrollment) 
VALUES ('21', '21', 'Anwell', '', 'W', 'California Resident', 'Yes');
INSERT INTO graduate(student_id, department) 
VALUES ('21', 'CSE');
INSERT INTO ms_student(student_id, department) VALUES ('21', 'DS');

INSERT INTO students(student_id, ssn, first_name, middle_name, last_name, resident_status, enrollment) 
VALUES ('22', '22', 'Tim', 'Ti', 'K', 'International Student', 'Yes');
INSERT INTO graduate(student_id, department) 
VALUES ('22', 'ECE');
INSERT INTO ms_student(student_id, department) VALUES ('22', 'COGS');


-----------------Faculty Info-----------------
INSERT INTO faculty(faculty_name, department, member_title) 
VALUES ('Justin_Smith', 'COGS', 'Associate Professor');
INSERT INTO faculty(faculty_name, department, member_title) 
VALUES ('Jannet_Taylor', 'COGS', 'Associate Professor');
INSERT INTO faculty(faculty_name, department, member_title) 
VALUES ('Flo_Rence', 'CSE', 'Assistant Professor');
INSERT INTO faculty(faculty_name, department, member_title) 
VALUES ('Thomas_Lee', 'CSE', 'Professor');
INSERT INTO faculty(faculty_name, department, member_title) 
VALUES ('Ada_Riz', 'MAE', 'Professor');
INSERT INTO faculty(faculty_name, department, member_title) 
VALUES ('Russel_Lance', 'MAE', 'Assistant Professor');
INSERT INTO faculty(faculty_name, department, member_title) 
VALUES ('Taylor_Swan', 'ECE', 'Professor');
INSERT INTO faculty(faculty_name, department, member_title) 
VALUES ('Maison_Stain', 'ECE', 'Professor');
INSERT INTO faculty(faculty_name, department, member_title) 
VALUES ('Robert_Clarkson', 'DSC', 'Associate Professor');
INSERT INTO faculty(faculty_name, department, member_title) 
VALUES ('Ben_Ray', 'DSC', 'Professor');
INSERT INTO faculty(faculty_name, department, member_title) 
VALUES ('Adam_Cao', 'NANO', 'Instructor');
INSERT INTO faculty(faculty_name, department, member_title) 
VALUES ('Linn_Trump', 'NANO', 'Professor');
INSERT INTO faculty(faculty_name, department, member_title) 
VALUES ('Tim_Asreal', 'SE', 'Professor');
INSERT INTO faculty(faculty_name, department, member_title) 
VALUES ('Hellen_Spruce', 'SE', 'Instructor');

-----------------Course Info-----------------
INSERT INTO courses(new_number, old_number, units, department, prerequisites, lab_requirements, grade) 
VALUES('CSE132A', 'CSE132', 4, 'CSE', 'BOTH', 'Not_Required', 'LETTER');
INSERT INTO courses(new_number, old_number, units, department, prerequisites, lab_requirements, grade) 
VALUES('CSE132B', 'CSE132', 4, 'CSE', 'BOTH', 'Not_Required', 'LETTER');
INSERT INTO courses(new_number, old_number, units, department, prerequisites, lab_requirements, grade)  
VALUES('CSE142', 'CSE143', 4, 'CSE', 'BOTH', 'Required', 'S/U');
INSERT INTO courses(new_number, old_number, units, department, prerequisites, lab_requirements, grade)  
VALUES('DSC120', 'DS120A', 4, 'DSC', 'BOTH', 'Required', 'LETTER');
INSERT INTO courses(new_number, old_number, units, department, prerequisites, lab_requirements, grade)  
VALUES('ECE108', 'ECE108A', 4, 'ECE', 'BOTH', 'Not_Required', 'S/U');
INSERT INTO courses(new_number, old_number, units, department, prerequisites, lab_requirements, grade)  
VALUES('COGS101A', 'COGS101', 2, 'COGS', 'BOTH', 'Required', 'LETTER');
INSERT INTO courses(new_number, old_number, units, department, prerequisites, lab_requirements, grade)  
VALUES('DSC104', 'DS105', 4, 'DSC', 'BOTH', 'Required', 'LETTER');
INSERT INTO courses(new_number, old_number, units, department, prerequisites, lab_requirements, grade)  
VALUES('MAE180A', 'MAE180', 4, 'MAE', 'BOTH', 'Required', 'S/U');
INSERT INTO courses(new_number, old_number, units, department, prerequisites, lab_requirements, grade)  
VALUES('SE110B', 'SE110', 4, 'SE', 'BOTH', 'Required', 'LETTER');
INSERT INTO courses(new_number, old_number, units, department, prerequisites, lab_requirements, grade)  
VALUES('NANO119', 'NANO119A', 1, 'NANO', 'BOTH', 'Not_Required', 'LETTER');

INSERT INTO courses(new_number, old_number, units, department, prerequisites, lab_requirements, grade)  
VALUES('CE110', 'CE110', '4', 'CE', 'BOTH', 'Not_Required', 'LETTER');
INSERT INTO courses(new_number, old_number, units, department, prerequisites, lab_requirements, grade)  
VALUES('CE111', 'CE111', '4', 'CE', 'BOTH', 'Not_Required', 'LETTER');
INSERT INTO courses(new_number, old_number, units, department, prerequisites, lab_requirements, grade)  
VALUES('CE112', 'CE112', '4', 'CE', 'BOTH', 'Not_Required', 'LETTER');
INSERT INTO courses(new_number, old_number, units, department, prerequisites, lab_requirements, grade)  
VALUES('CE220', 'CE220', '4', 'CE', 'BOTH', 'Not_Required', 'LETTER');
INSERT INTO courses(new_number, old_number, units, department, prerequisites, lab_requirements, grade)  
VALUES('CE221', 'CE221', '4', 'CE', 'BOTH', 'Not_Required', 'LETTER');
INSERT INTO courses(new_number, old_number, units, department, prerequisites, lab_requirements, grade)  
VALUES('CE222', 'CE222', '4', 'CE', 'BOTH', 'Not_Required', 'LETTER');
INSERT INTO courses(new_number, old_number, units, department, prerequisites, lab_requirements, grade)  
VALUES('CE330', 'CE330', '4', 'CE', 'BOTH', 'Not_Required', 'LETTER');
INSERT INTO courses(new_number, old_number, units, department, prerequisites, lab_requirements, grade)  
VALUES('CE331', 'CE331', '4', 'CE', 'BOTH', 'Not_Required', 'LETTER');
INSERT INTO courses(new_number, old_number, units, department, prerequisites, lab_requirements, grade)  
VALUES('CE332', 'CE332', '4', 'CE', 'BOTH', 'Not_Required', 'LETTER');

INSERT INTO courses(new_number, old_number, units, department, prerequisites, lab_requirements, grade)  
VALUES('CSE110', 'CSE110', '4', 'CSE', 'BOTH', 'Not_Required', 'LETTER');
INSERT INTO courses(new_number, old_number, units, department, prerequisites, lab_requirements, grade)  
VALUES('CSE111', 'CSE111', '4', 'CSE', 'BOTH', 'Not_Required', 'LETTER');
INSERT INTO courses(new_number, old_number, units, department, prerequisites, lab_requirements, grade)  
VALUES('CSE220', 'CSE220', '4', 'CSE', 'BOTH', 'Not_Required', 'LETTER');
INSERT INTO courses(new_number, old_number, units, department, prerequisites, lab_requirements, grade)  
VALUES('CSE221', 'CSE221', '4', 'CSE', 'BOTH', 'Not_Required', 'LETTER');

INSERT INTO courses(new_number, old_number, units, department, prerequisites, lab_requirements, grade)  
VALUES('ME110', 'ME110', '4', 'ME', 'BOTH', 'Not_Required', 'LETTER');
INSERT INTO courses(new_number, old_number, units, department, prerequisites, lab_requirements, grade)  
VALUES('ME220', 'ME220', '4', 'ME', 'BOTH', 'Not_Required', 'LETTER');

INSERT INTO courses(new_number, old_number, units, department, prerequisites, lab_requirements, grade)  
VALUES('DS110', 'DS110', '4', 'DS', 'BOTH', 'Not_Required', 'LETTER');
INSERT INTO courses(new_number, old_number, units, department, prerequisites, lab_requirements, grade)  
VALUES('DS220', 'DS220', '4', 'DS', 'BOTH', 'Not_Required', 'LETTER');
INSERT INTO courses(new_number, old_number, units, department, prerequisites, lab_requirements, grade)  
VALUES('DS330', 'DS330', '4', 'DS', 'BOTH', 'Not_Required', 'LETTER');

INSERT INTO courses(new_number, old_number, units, department, prerequisites, lab_requirements, grade)  
VALUES('COGS110', 'COGS110', '4', 'COGS', 'BOTH', 'Not_Required', 'LETTER');
INSERT INTO courses(new_number, old_number, units, department, prerequisites, lab_requirements, grade)  
VALUES('COGS220', 'COGS220', '4', 'COGS', 'BOTH', 'Not_Required', 'LETTER');
INSERT INTO courses(new_number, old_number, units, department, prerequisites, lab_requirements, grade)  
VALUES('COGS330', 'COGS330', '4', 'COGS', 'BOTH', 'Not_Required', 'LETTER');


-----------------Class Info-----------------
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('1', 'CSE132B', 'Database', '2023', 'SP', 'Flo_Rence', '2');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('2', 'CSE132A', 'Database', '2020', 'WI', 'Flo_Rence', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('3', 'CSE142', 'CompArch', '2021', 'FA', 'Flo_Rence', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('4', 'CSE142', 'CompArch', '2023', 'FA', 'Flo_Rence', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('5', 'DSC120', 'Data_Analysis', '2023', 'SP', 'Robert_Clarkson', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('6', 'DSC120', 'Data_Analysis', '2021', 'SP', 'Robert_Clarkson', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('7', 'ECE108', 'DigCir', '2021', 'WI', 'Taylor_Swan', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('8', 'ECE108', 'DigCir', '2023', 'WI', 'Taylor_Swan', '100');

INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('9', 'MAE180A', 'Spacecraft', '2021', 'FA', 'Ada_Riz', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('10', 'MAE180A', 'Spacecraft', '2020', 'SP', 'Ada_Riz', '100');

INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('11', 'SE110B', 'SolidMech', '2023', 'SP', 'Tim_Asreal', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('12', 'SE110B', 'SolidMech', '2021', 'WI', 'Tim_Asreal', '100');

INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('13', 'COGS101A', 'SenNPer', '2023', 'SP', 'Justin_Smith', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('14', 'COGS101A', 'SenNPer', '2020', 'FA', 'Justin_Smith', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('15', 'DSC104', 'Data_Management', '2021', 'FA', 'Robert_Clarkson', '100');

INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('16', 'NANO119', 'SysDesign', '2023', 'SP', 'Adam_Cao', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('17', 'NANO119', 'SysDesign', '2023', 'SP', 'Adam_Cao', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('18', 'DSC104', 'Data_Management', '2023', 'SP', 'Robert_Clarkson', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('19', 'MAE180A', 'Spacecraft', '2023', 'SP', 'Ada_Riz', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('20', 'COGS101A', 'SenNPer', '2021', 'FA', 'Justin_Smith', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('63', 'DSC120', 'Data_Analysis', '2023', 'SP', 'Robert_Clarkson', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('72', 'ECE108', 'DigCir', '2023', 'SP', 'Taylor_Swan', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('81', 'MAE180A', 'Spacecraft', '2023', 'SP', 'Ada_Riz', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('82', 'MAE180A', 'Spacecraft', '2023', 'SP', 'Ada_Riz', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('91', 'NANO119', 'SysDesign', '2023', 'SP', 'Adam_Cao', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('92', 'NANO119', 'SysDesign', '2023', 'SP', 'Adam_Cao', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('93', 'NANO119', 'SysDesign', '2023', 'SP', 'Adam_Cao', '100');

INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('26', 'CE110', 'Computer Engineer 1', '2023', 'SP', 'Adam_Cao', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('27', 'CE111', 'Computer Engineer 2', '2023', 'FA', 'Adam_A', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('28', 'CE112', 'Computer Engineer 3', '2023', 'WI', 'Adam_B', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('29', 'CE220', 'Computer Engineer 4', '2023', 'WI', 'Adam_C', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('30', 'CE221', 'Computer Engineer 5', '2023', 'SP', 'Adam_C', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('31', 'CE222', 'Computer Engineer 6', '2023', 'FA', 'Adam_D', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('32', 'CE330', 'Computer Engineer 7', '2023', 'FA', 'Adam_E', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('33', 'CE331', 'Computer Engineer 8', '2023', 'SP', 'Adam_F', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('34', 'CE332', 'Computer Engineer 9', '2023', 'WI', 'Adam_F', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('35', 'CSE110', 'Computer Science 4', '2023', 'WI', 'GreenFord_A', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('36', 'CSE111', 'Computer Science 1', '2023', 'FA', 'GreenFord_B', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('37', 'CSE220', 'Computer Science 2', '2023', 'SP', 'GreenFord_C', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('38', 'CSE221', 'Computer Science 3', '2023', 'SP', 'GreenFord_D', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('39', 'ME110', 'Machnical Engineer 1', '2023', 'SP', 'Chris_A', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('40', 'ME220', 'Machnical Engineer 2', '2023', 'FA', 'Chris_B', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('41', 'DS110', 'Machnical Engineer 3', '2023', 'SP', 'Chris_C', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('42', 'DS220', 'Machnical Engineer 4', '2023', 'SP', 'Chris_D', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('43', 'DS330', 'Machnical Engineer 5', '2023', 'FA', 'Chris_E', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('44', 'COGS110', 'Cognitive Science 1', '2023', 'FA', 'Ben_1', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('45', 'COGS220', 'Cognitive Science 2', '2023', 'FA', 'Ben_2', '100');
INSERT INTO classes(section_id, new_number, title, year, quarter, instructor_name, enrollment_limit) 
VALUES('46', 'COGS330', 'Cognitive Science 3', '2023', 'WI', 'Ben_3', '100');

-----------------Course Enrollment Info-----------------
INSERT INTO course_enrollment(student_id, section_id, class_name, year, quarter, units, grade) 
VALUES('1', '1', 'CSE132B', '2023', 'SP', '4', 'LETTER');
INSERT INTO course_enrollment(student_id, section_id, class_name, year, quarter, units, grade) 
VALUES('2', '1', 'CSE132B', '2023', 'SP', '4', 'LETTER');

INSERT INTO course_enrollment(student_id, section_id, class_name, year, quarter, units, grade) 
VALUES('1', '5', 'DSC120', '2023', 'SP', '4', 'LETTER');
INSERT INTO course_enrollment(student_id, section_id, class_name, year, quarter, units, grade) 
VALUES('3', '8', 'ECE108', '2023', 'WI', '4', 'S/U');
INSERT INTO course_enrollment(student_id, section_id, class_name, year, quarter, units, grade) 
VALUES('4', '11', 'SE110B', '2023', 'SP', '4', 'LETTER');
INSERT INTO course_enrollment(student_id, section_id, class_name, year, quarter, units, grade) 
VALUES('5', '13', 'COGS101A', '2023', 'SP', '4', 'LETTER');
INSERT INTO course_enrollment(student_id, section_id, class_name, year, quarter, units, grade) 
VALUES('6', '16', 'NANO119', '2023', 'SP', '1', 'LETTER');
INSERT INTO course_enrollment(student_id, section_id, class_name, year, quarter, units, grade) 
VALUES('7', '17', 'NANO119', '2023', 'SP', '1', 'LETTER');
INSERT INTO course_enrollment(student_id, section_id, class_name, year, quarter, units, grade) 
VALUES('8', '18', 'DSC104', '2023', 'SP', '4', 'LETTER');
INSERT INTO course_enrollment(student_id, section_id, class_name, year, quarter, units, grade) 
VALUES('9', '19', 'MAE180A', '2023', 'SP', '4', 'S/U');
INSERT INTO course_enrollment(student_id, section_id, class_name, year, quarter, units, grade) 
VALUES('10', '72', 'ECE108', '2023', 'SP', '4', 'S/U');
INSERT INTO course_enrollment(student_id, section_id, class_name, year, quarter, units, grade) 
VALUES('11', '63', 'DSC120', '2023', 'SP', '4', 'LETTER');
INSERT INTO course_enrollment(student_id, section_id, class_name, year, quarter, units, grade) 
VALUES('10', '82', 'MAE180A', '2023', 'SP', '4', 'LETTER');
INSERT INTO course_enrollment(student_id, section_id, class_name, year, quarter, units, grade) 
VALUES('11', '82', 'MAE180A', '2023', 'SP', '4', 'LETTER');

-----------------Classes Taken In The Past Info-----------------
INSERT INTO past_classes(student_id, section_id, title, year, quarter, instructor_name, grade, units, grade_conversion,class_type) 
VALUES('1', '2', 'CSE132A', '2020', 'WI', 'Flo_Rence', 'A', '4','4.0','upper_units');
INSERT INTO past_classes(student_id, section_id, title, year, quarter, instructor_name, grade, units, grade_conversion,class_type) 
VALUES('1', '3', 'CSE142', '2021', 'FA', 'Flo_Rence', 'A-', '4','3.7', 'lower_units');
INSERT INTO past_classes(student_id, section_id, title, year, quarter, instructor_name, grade, units, grade_conversion,class_type) 
VALUES('1', '20', 'COGS101A', '2021', 'FA', 'Justin_Smith', 'A', '4','4.0', 'elective_units');
INSERT INTO past_classes(student_id, section_id, title, year, quarter, instructor_name, grade, units, grade_conversion,class_type) 
VALUES('1', '9', 'MAE180A', '2021', 'FA', 'Ada_Riz', 'U', '4','0.0','UP&ELT_units');
INSERT INTO past_classes(student_id, section_id, title, year, quarter, instructor_name, grade, units, grade_conversion,class_type) 
VALUES('2', '3', 'CSE142', '2021', 'FA', 'Flo_Rence', 'A-', '4','3.7','upper_units');
INSERT INTO past_classes(student_id, section_id, title, year, quarter, instructor_name, grade, units, grade_conversion,class_type) 
VALUES('2', '4', 'CSE142', '2021', 'FA', 'Flo_Rence', 'A-', '4','3.7','lower_units');
INSERT INTO past_classes(student_id, section_id, title, year, quarter, instructor_name, grade, units, grade_conversion,class_type) 
VALUES('2', '5', 'CSE142', '2021', 'FA', 'Flo_Rence', 'A-', '4','3.7','elective_units');
INSERT INTO past_classes(student_id, section_id, title, year, quarter, instructor_name, grade, units, grade_conversion,class_type) 
VALUES('2', '6', 'CSE142', '2021', 'FA', 'Flo_Rence', 'A-', '4','3.7','UP&ELT_units');
INSERT INTO past_classes(student_id, section_id, title, year, quarter, instructor_name, grade, units, grade_conversion,class_type) 
VALUES('3', '4', 'CSE142', '2023', 'FA', 'Flo_Rence', 'B+', '4','3.4','lower_units');
INSERT INTO past_classes(student_id, section_id, title, year, quarter, instructor_name, grade, units, grade_conversion,class_type) 
VALUES('4', '6', 'DSC120', '2021', 'SP', 'Robert_Clarkson', 'B', '4','3.1', 'upper_units');
INSERT INTO past_classes(student_id, section_id, title, year, quarter, instructor_name, grade, units, grade_conversion,class_type) 
VALUES('5', '7', 'ECE108', '2021', 'WI', 'Taylor_Swan', 'S', '4','0.0','lower_units');
INSERT INTO past_classes(student_id, section_id, title, year, quarter, instructor_name, grade, units, grade_conversion,class_type) 
VALUES('6', '9', 'MAE180A', '2021', 'FA', 'Ada_Riz', 'U', '4','0.0','UP&ELT_units');
INSERT INTO past_classes(student_id, section_id, title, year, quarter, instructor_name, grade, units, grade_conversion,class_type) 
VALUES('7', '10', 'MAE180A', '2020', 'SP', 'Ada_Riz', 'S', '4','0.0','elective_units');
INSERT INTO past_classes(student_id, section_id, title, year, quarter, instructor_name, grade, units, grade_conversion,class_type) 
VALUES('8', '12', 'SE110B', '2021', 'WI', 'Tim_Asreal', 'A+', '4','4.3','lower_units');
INSERT INTO past_classes(student_id, section_id, title, year, quarter, instructor_name, grade, units, grade_conversion,class_type) 
VALUES('9', '14', 'COGS101A', '2020', 'FA', 'Justin_Smith', 'C', '4','2.2','upper_units');
INSERT INTO past_classes(student_id, section_id, title, year, quarter, instructor_name, grade, units, grade_conversion,class_type) 
VALUES('10', '15', 'DSC104', '2023', 'FA', 'Robert_Clarkson', 'B-', '4','2.8', 'upper_units');

INSERT INTO past_classes(student_id, section_id, title, year, quarter, instructor_name, grade, units, grade_conversion,class_type) 
VALUES('16', '26', 'CE110', '2022', 'SP', 'Adam_Cao', 'B', '4','3.1', 'concentration_1_units');
INSERT INTO past_classes(student_id, section_id, title, year, quarter, instructor_name, grade, units, grade_conversion,class_type) 
VALUES('16', '32', 'CE330', '2023', 'FA', 'Adam_E', 'B', '4','3.1', 'concentration_3_units');
INSERT INTO past_classes(student_id, section_id, title, year, quarter, instructor_name, grade, units, grade_conversion,class_type) 
VALUES('16', '29', 'CE220', '2023', 'WI', 'Adam_C', 'B', '4','3.1', 'concentration_2_units');

INSERT INTO past_classes(student_id, section_id, title, year, quarter, instructor_name, grade, units, grade_conversion,class_type) 
VALUES('17', '37', 'CSE220', '2022', 'SP', 'GreenFord_C', 'S', '4','0.0','concentration_2_units');
INSERT INTO past_classes(student_id, section_id, title, year, quarter, instructor_name, grade, units, grade_conversion,class_type) 
VALUES('17', '35', 'CSE110', '2023', 'WI', 'GreenFord_A', 'S', '4','0.0','concentration_1_units');

INSERT INTO past_classes(student_id, section_id, title, year, quarter, instructor_name, grade, units, grade_conversion,class_type) 
VALUES('18', '39', 'ME110', '2022', 'SP', 'Chris_A', 'U', '4','0.0','concentration_1_units');

INSERT INTO past_classes(student_id, section_id, title, year, quarter, instructor_name, grade, units, grade_conversion,class_type) 
VALUES('19', '29', 'CE220', '2023', 'WI', 'Adam_C', 'S', '4','0.0','concentration_2_units');

INSERT INTO past_classes(student_id, section_id, title, year, quarter, instructor_name, grade, units, grade_conversion,class_type) 
VALUES('20', '41', 'DS110', '2022', 'SP', 'Chris_C', 'A+', '4','4.3','concentration_1_units');
INSERT INTO past_classes(student_id, section_id, title, year, quarter, instructor_name, grade, units, grade_conversion,class_type) 
VALUES('20', '42', 'DS220', '2022', 'SP', 'Chris_D', 'A+', '4','4.3','concentration_2_units');
INSERT INTO past_classes(student_id, section_id, title, year, quarter, instructor_name, grade, units, grade_conversion,class_type) 
VALUES('20', '43', 'DS330', '2023', 'FA', 'Chris_E', 'A+', '4','4.3','concentration_3_units');

INSERT INTO past_classes(student_id, section_id, title, year, quarter, instructor_name, grade, units, grade_conversion,class_type) 
VALUES('21', '42', 'DS220', '2022', 'SP', 'Chris_D', 'C', '4','2.2','concentration_2_units');

INSERT INTO past_classes(student_id, section_id, title, year, quarter, instructor_name, grade, units, grade_conversion,class_type) 
VALUES('22', '46', 'COGS330', '2023', 'WI', 'Ben_3', 'B-', '4','2.8', 'concentration_3_units');

-----------------Grade Conversion Info-----------------
INSERT INTO grade_conversion VALUES('A+', 4.3);
INSERT INTO grade_conversion VALUES('A', 4.0);
INSERT INTO grade_conversion VALUES('A-', 3.7);
INSERT INTO grade_conversion VALUES('B+', 3.4);
INSERT INTO grade_conversion VALUES('B', 3.1);
INSERT INTO grade_conversion VALUES('B-', 2.8);
INSERT INTO grade_conversion VALUES('C+', 2.5);
INSERT INTO grade_conversion VALUES('C', 2.2);
INSERT INTO grade_conversion VALUES('C-', 1.9);
INSERT INTO grade_conversion VALUES('D', 1.6);

-----------------Weekly Section Info-----------------
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('63', 'DSC120', '2023-04-03', '14:00:00', '15:30:00', '1', 'DSC', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('63', 'DSC120', '2023-04-05', '14:00:00', '15:30:00', '1', 'DSC', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('63', 'DSC120', '2023-04-10', '14:00:00', '15:30:00', '1', 'DSC', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('63', 'DSC120', '2023-04-12', '14:00:00', '15:30:00', '1', 'DSC', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('63', 'DSC120', '2023-04-17', '14:00:00', '15:30:00', '1', 'DSC', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('63', 'DSC120', '2023-04-19', '14:00:00', '15:30:00', '1', 'DSC', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('63', 'DSC120', '2023-04-24', '14:00:00', '15:30:00', '1', 'DSC', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('63', 'DSC120', '2023-04-26', '14:00:00', '15:30:00', '1', 'DSC', 'Yes', 'LECTURE');

INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('72', 'ECE108', '2023-04-03', '15:00:00', '17:00:00', '1', 'ECE', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('72', 'ECE108', '2023-04-05', '15:00:00', '17:00:00', '1', 'ECE', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('72', 'ECE108', '2023-04-10', '15:00:00', '17:00:00', '1', 'ECE', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('72', 'ECE108', '2023-04-12', '15:00:00', '17:00:00', '1', 'ECE', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('72', 'ECE108', '2023-04-17', '15:00:00', '17:00:00', '1', 'ECE', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('72', 'ECE108', '2023-04-19', '15:00:00', '17:00:00', '1', 'ECE', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('72', 'ECE108', '2023-04-24', '15:00:00', '17:00:00', '1', 'ECE', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('72', 'ECE108', '2023-04-26', '15:00:00', '17:00:00', '1', 'ECE', 'Yes', 'LECTURE');

INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('81', 'MAE180A', '2023-04-03', '14:00:00', '15:30:00', '2', 'MAE', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('81', 'MAE180A', '2023-04-06', '13:00:00', '14:30:00', '2', 'MAE', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('81', 'MAE180A', '2023-04-10', '14:00:00', '15:30:00', '2', 'MAE', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('81', 'MAE180A', '2023-04-13', '13:00:00', '14:30:00', '2', 'MAE', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('81', 'MAE180A', '2023-04-17', '14:00:00', '15:30:00', '2', 'MAE', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('81', 'MAE180A', '2023-04-20', '13:00:00', '14:30:00', '2', 'MAE', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('81', 'MAE180A', '2023-04-24', '14:00:00', '15:30:00', '2', 'MAE', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('81', 'MAE180A', '2023-04-27', '13:00:00', '14:30:00', '2', 'MAE', 'Yes', 'LECTURE');

INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('82', 'MAE180A', '2023-04-03', '17:00:00', '17:50:00', '3', 'MAE', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('82', 'MAE180A', '2023-04-05', '15:00:00', '15:50:00', '3', 'MAE', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('82', 'MAE180A', '2023-04-07', '13:00:00', '13:50:00', '3', 'MAE', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('82', 'MAE180A', '2023-04-10', '17:00:00', '17:50:00', '3', 'MAE', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('82', 'MAE180A', '2023-04-12', '15:00:00', '15:50:00', '3', 'MAE', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('82', 'MAE180A', '2023-04-14', '13:00:00', '13:50:00', '3', 'MAE', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('82', 'MAE180A', '2023-04-17', '17:00:00', '17:50:00', '3', 'MAE', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('82', 'MAE180A', '2023-04-19', '15:00:00', '15:50:00', '3', 'MAE', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('82', 'MAE180A', '2023-04-21', '13:00:00', '13:50:00', '3', 'MAE', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('82', 'MAE180A', '2023-04-24', '17:00:00', '17:50:00', '3', 'MAE', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('82', 'MAE180A', '2023-04-26', '15:00:00', '15:50:00', '3', 'MAE', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('82', 'MAE180A', '2023-04-28', '13:00:00', '13:50:00', '3', 'MAE', 'Yes', 'LECTURE');

INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('91', 'NANO119', '2023-04-03', '14:00:00', '15:30:00', '4', 'NANO', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('91', 'NANO119', '2023-04-05', '13:00:00', '14:00:00', '4', 'NANO', 'Yes', 'LECTURE');

INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('91', 'NANO119', '2023-04-10', '14:00:00', '15:30:00', '4', 'NANO', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('91', 'NANO119', '2023-04-12', '13:00:00', '14:00:00', '4', 'NANO', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('91', 'NANO119', '2023-04-17', '14:00:00', '15:30:00', '4', 'NANO', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('91', 'NANO119', '2023-04-19', '13:00:00', '14:00:00', '4', 'NANO', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('91', 'NANO119', '2023-04-24', '14:00:00', '15:30:00', '4', 'NANO', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('91', 'NANO119', '2023-04-26', '13:00:00', '14:00:00', '4', 'NANO', 'Yes', 'LECTURE');

INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('92', 'NANO119', '2023-04-03', '13:00:00', '14:00:00', '5', 'NANO', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('92', 'NANO119', '2023-04-05', '13:00:00', '14:00:00', '5', 'NANO', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('92', 'NANO119', '2023-04-10', '13:00:00', '14:00:00', '5', 'NANO', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('92', 'NANO119', '2023-04-12', '13:00:00', '14:00:00', '5', 'NANO', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('92', 'NANO119', '2023-04-17', '13:00:00', '14:00:00', '5', 'NANO', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('92', 'NANO119', '2023-04-19', '13:00:00', '14:00:00', '5', 'NANO', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('92', 'NANO119', '2023-04-24', '13:00:00', '14:00:00', '5', 'NANO', 'Yes', 'LECTURE');
INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('92', 'NANO119', '2023-04-26', '13:00:00', '14:00:00', '5', 'NANO', 'Yes', 'LECTURE');

INSERT INTO weekly(section_id, new_number, date_time, begin_time, end_time, room, building, mandatory, session_type)
VALUES('93', 'NANO119', '2023-04-05', '13:30:00', '14:30:00', '5', 'NANO', 'Yes', 'LECTURE');

-----------------degree Info-----------------
INSERT INTO degree(degree_id, upper_units, lower_units, elective_units, total_units, min_grade, degree_name, degree_type) 
VALUES ('1', '100', '80', '20', '200', '3.5', 'DSC', 'BS');
INSERT INTO degree(degree_id, upper_units, lower_units, elective_units, total_units, min_grade, degree_name, degree_type) 
VALUES ('2', '5', '10', '15', '30', '3.5', 'Math', 'BS');
INSERT INTO degree(degree_id, upper_units, lower_units, elective_units, total_units, min_grade, degree_name, degree_type) 
VALUES ('3', '40', '100', '15', '155', '3.5', 'COGS', 'BS');
INSERT INTO degree(degree_id, upper_units, lower_units, elective_units, total_units, min_grade, degree_name, degree_type) 
VALUES ('4', '30', '90', '15', '135', '3.5', 'CSE', 'BS');
INSERT INTO degree(degree_id, upper_units, lower_units, elective_units, total_units, min_grade, degree_name, degree_type) 
VALUES ('5', '55', '85', '15', '155', '3.5', 'MUS', 'BS');
INSERT INTO degree(degree_id, upper_units, lower_units, elective_units, total_units, min_grade, degree_name, degree_type) 
VALUES ('6', '50', '125', '15', '190', '3.5', 'TEA', 'BS');
INSERT INTO degree(degree_id, upper_units, lower_units, elective_units, total_units, min_grade, degree_name, degree_type) 
VALUES ('7', '60', '90', '15', '165', '3.5', 'MAE', 'BS');
INSERT INTO degree(degree_id, upper_units, lower_units, elective_units, total_units, min_grade, degree_name, degree_type) 
VALUES ('8', '40', '85', '15', '140', '3.5', 'SE', 'BS');
INSERT INTO degree(degree_id, upper_units, lower_units, elective_units, total_units, min_grade, degree_name, degree_type) 
VALUES ('9', '10', '125', '15', '150', '3.5', 'ECE', 'BS');

-----------------MS degree Info-----------------
INSERT INTO ms_degree(degree_id, concentration_min_grade, concentration_1_units, concentration_2_units, concentration_3_units, concentration_total_units, ms_name) 
VALUES ('1', '3.5', '12', '12', '12', '36', 'CE');
INSERT INTO ms_degree(degree_id, concentration_min_grade, concentration_1_units, concentration_2_units, concentration_3_units, concentration_total_units, ms_name) 
VALUES ('2', '3.5', '8', '8', '0', '16', 'CSE');
INSERT INTO ms_degree(degree_id, concentration_min_grade, concentration_1_units, concentration_2_units, concentration_3_units, concentration_total_units, ms_name) 
VALUES ('3', '3.5', '4', '4', '0', '8', 'ME');
INSERT INTO ms_degree(degree_id, concentration_min_grade, concentration_1_units, concentration_2_units, concentration_3_units, concentration_total_units, ms_name) 
VALUES ('4', '3.5', '4', '4', '4', '12', 'DS');
INSERT INTO ms_degree(degree_id, concentration_min_grade, concentration_1_units, concentration_2_units, concentration_3_units, concentration_total_units, ms_name) 
VALUES ('5', '3.5', '4', '4', '4', '12', 'COGS');





-----------------Concentration Info-----------------
INSERT INTO concentration (id, department, concentration, class_name)
VALUES (1, 'CE', 'concentration_1', 'CE110');
INSERT INTO concentration (id, department, concentration, class_name)
VALUES (2, 'CE', 'concentration_1', 'CE111');
INSERT INTO concentration (id, department, concentration, class_name)
VALUES (3, 'CE', 'concentration_1', 'CE112');
INSERT INTO concentration (id, department, concentration, class_name)
VALUES (4, 'CE', 'concentration_2', 'CE220');
INSERT INTO concentration (id, department, concentration, class_name)
VALUES (5, 'CE', 'concentration_2', 'CE221');
INSERT INTO concentration (id, department, concentration, class_name)
VALUES (6, 'CE', 'concentration_2', 'CE222');
INSERT INTO concentration (id, department, concentration, class_name)
VALUES (7, 'CE', 'concentration_3', 'CE330');
INSERT INTO concentration (id, department, concentration, class_name)
VALUES (8, 'CE', 'concentration_3', 'CE331');
INSERT INTO concentration (id, department, concentration, class_name)
VALUES (9, 'CE', 'concentration_3', 'CE332');
INSERT INTO concentration (id, department, concentration, class_name)
VALUES (10, 'CSE', 'concentration_1', 'CSE110');
INSERT INTO concentration (id, department, concentration, class_name)
VALUES (12, 'CSE', 'concentration_1', 'CSE111');
INSERT INTO concentration (id, department, concentration, class_name)
VALUES (13, 'CSE', 'concentration_2', 'CSE220');
INSERT INTO concentration (id, department, concentration, class_name)
VALUES (14, 'CSE', 'concentration_2', 'CSE221');
INSERT INTO concentration (id, department, concentration, class_name)
VALUES (15, 'ME', 'concentration_1', 'ME110');
INSERT INTO concentration (id, department, concentration, class_name)
VALUES (16, 'ME', 'concentration_2', 'ME220');
INSERT INTO concentration (id, department, concentration, class_name)
VALUES (17, 'DS', 'concentration_1', 'DS110');
INSERT INTO concentration (id, department, concentration, class_name)
VALUES (18, 'DS', 'concentration_2', 'DS220');
INSERT INTO concentration (id, department, concentration, class_name)
VALUES (19, 'DS', 'concentration_3', 'DS330');
INSERT INTO concentration (id, department, concentration, class_name)
VALUES (20, 'COGS', 'concentration_1', 'COGS110');
INSERT INTO concentration (id, department, concentration, class_name)
VALUES (21, 'COGS', 'concentration_2', 'COGS220');
INSERT INTO concentration (id, department, concentration, class_name)
VALUES (22, 'COGS', 'concentration_3', 'COGS330');

-----------------Teaching Info----------------- 
INSERT INTO teaching (section_id, faculty_name)
VALUES('72', 'Taylor_Swan');
INSERT INTO teaching (section_id, faculty_name)
VALUES('91', 'Adam_Cao');
INSERT INTO teaching (section_id, faculty_name)
VALUES('92', 'Adam_Cao');
INSERT INTO teaching (section_id, faculty_name)
VALUES('93', 'Adam_Cao');

----------------------Check Existing Triggers----------------------
SELECT trigger_name 
FROM information_schema.triggers;