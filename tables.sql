DROP TABLE IF EXISTS students CASCADE;

DROP TABLE IF EXISTS attendance_period  CASCADE; 

DROP TABLE IF EXISTS degree_earned CASCADE; 

DROP TABLE IF EXISTS probation_status CASCADE; 

DROP TABLE IF EXISTS undergraduate CASCADE;  

DROP TABLE IF EXISTS BS_MS CASCADE;

DROP TABLE IF EXISTS graduate CASCADE;

DROP TABLE IF EXISTS ms_student CASCADE;

DROP TABLE IF EXISTS PhD_candidates CASCADE;

DROP TABLE IF EXISTS degree CASCADE;

DROP TABLE IF EXISTS ms_degree CASCADE;

DROP TABLE IF EXISTS faculty CASCADE; 

DROP TABLE IF EXISTS classes CASCADE; 

DROP TABLE IF EXISTS meeting_sections CASCADE;  

DROP TABLE IF EXISTS weekly CASCADE;

DROP TABLE IF EXISTS review CASCADE;

DROP TABLE IF EXISTS courses CASCADE;

DROP TABLE IF EXISTS course_enrollment CASCADE;

DROP TABLE IF EXISTS past_classes CASCADE;

DROP TABLE IF EXISTS thesis_committee CASCADE;

DROP TABLE IF EXISTS teaching CASCADE;

DROP TABLE IF EXISTS advisor CASCADE;

DROP TABLE IF EXISTS grade_conversion CASCADE;

DROP TABLE IF EXISTS concentration CASCADE;


CREATE TABLE students
(
    student_id serial PRIMARY KEY,
    ssn int,
    first_name varchar(256),
    middle_name varchar(256),
    last_name varchar(256),
    resident_status varchar(256),
    enrollment boolean
);

CREATE TABLE courses
(
    new_number varchar(20) PRIMARY KEY,
    old_number varchar(20),
    units int,
    department varchar(20), 
    prerequisites varchar(20), 
    lab_requirements varchar(20),
    grade varchar(20)
);

CREATE TABLE classes
(
    section_id serial UNIQUE,
    new_number varchar(20),
    title varchar(20),
    year int,
    quarter varchar(20),
    instructor_name varchar(20),
    enrollment_limit int,
    PRIMARY KEY(section_id, new_number),
    FOREIGN KEY(new_number) references courses(new_number) ON DELETE CASCADE
);

CREATE TABLE meeting_sections
(
    section_id int,
    new_number varchar(20),
    date_time Date,
    begin_time Time,
    end_time Time,
    room varchar(20),
    building varchar(10),
    section_type varchar(10),
    PRIMARY KEY(section_id, new_number, date_time),
    FOREIGN KEY(section_id) references classes(section_id) ON DELETE CASCADE
);

CREATE TABLE weekly
(
    section_id int,
    new_number varchar(20),
    date_time Date,
    begin_time Time,
    end_time Time,
    room varchar(20),
    building varchar(10),
    mandatory boolean,
    session_type varchar(10),
    PRIMARY KEY(section_id, new_number, date_time),
    FOREIGN KEY(section_id) references classes(section_id) ON DELETE CASCADE
);

CREATE TABLE review
(
    section_id int ,
    new_number varchar(20),
    date_time Date,
    begin_time Time,
    end_time Time,
    room varchar(20),
    building varchar(10),
    PRIMARY KEY(section_id, new_number, date_time),
    FOREIGN KEY(section_id) references classes(section_id) ON DELETE CASCADE
);

CREATE TABLE faculty
(
    faculty_name varchar(20) PRIMARY KEY,
    department varchar(20),
    member_title varchar(20)
);

CREATE TABLE teaching
(
    section_id serial,
    faculty_name varchar(20),
    PRIMARY KEY(section_id),
    FOREIGN KEY(faculty_name) references faculty(faculty_name) ON DELETE CASCADE,
    FOREIGN KEY(section_id) references classes(section_id) ON DELETE CASCADE
);

CREATE TABLE attendance_period
(
    student_id int PRIMARY KEY,
    begin varchar(20),
    complete varchar(20),
    FOREIGN KEY(student_id) references students(student_id) ON DELETE CASCADE
);

CREATE TABLE degree_earned
(
    student_id int PRIMARY KEY,
    degree_id int,
    degree_type varchar(20),
    school varchar(20),
    FOREIGN KEY(student_id) references students(student_id) ON DELETE CASCADE
);

CREATE TABLE probation_status
(
    student_id int PRIMARY KEY,
    start varchar(20),
    finish varchar(20),
    reason varchar(20),
    FOREIGN KEY(student_id) references students(student_id) ON DELETE CASCADE
);

CREATE TABLE undergraduate
(
    student_id int PRIMARY KEY,
    major varchar(20),
    minor varchar(20),
    college varchar(20),
    FOREIGN KEY(student_id) references students(student_id) ON DELETE CASCADE
);

CREATE TABLE BS_MS
(
    student_id int PRIMARY KEY,
    department varchar(10),
    major varchar(10),
    minor varchar(10),
    college varchar(10),
    FOREIGN KEY(student_id) references students(student_id) ON DELETE CASCADE
);

CREATE TABLE graduate
(
    student_id int PRIMARY KEY,
    department varchar(10),
    FOREIGN KEY(student_id) references students(student_id) ON DELETE CASCADE
);

CREATE TABLE ms_student
(
    student_id int PRIMARY KEY,
    department varchar(10),
    FOREIGN KEY(student_id) references students(student_id) ON DELETE CASCADE
);

CREATE TABLE PhD_candidates
(
    student_id int PRIMARY KEY,
    department varchar(10),
    PhD_candidate boolean,
    FOREIGN KEY(student_id) references students(student_id) ON DELETE CASCADE
);

CREATE TABLE advisor
(
    student_id int,
    faculty_name varchar(20),
    PRIMARY KEY(student_id),
    FOREIGN KEY(faculty_name) references faculty(faculty_name) ON DELETE CASCADE,
    FOREIGN KEY(student_id) references students(student_id) ON DELETE CASCADE
);

CREATE TABLE degree
(
    degree_id serial PRIMARY KEY,
    upper_units int,
    lower_units int,
    elective_units int,
    total_units int,
    min_grade varchar(20), 
    degree_name varchar(20),
    degree_type varchar(20)
);

CREATE TABLE ms_degree
(
    degree_id int PRIMARY KEY,
    concentration_min_grade varchar(20),
    concentration_1_units int,
    concentration_2_units int,
    concentration_3_units int,
    concentration_total_units int,
    ms_name varchar(20),
    FOREIGN KEY(degree_id) references degree(degree_id) ON DELETE CASCADE
);

CREATE TABLE past_classes
(
    student_id serial,
    section_id serial,
    title varchar(20),
    year int,
    quarter varchar(20),
    instructor_name varchar(20),
    grade varchar(20),
    units int,
    grade_conversion decimal(2,1),
    class_type varchar(30),
    PRIMARY KEY(student_id, section_id),
    FOREIGN KEY(section_id) references classes(section_id) ON DELETE CASCADE,
    FOREIGN KEY(student_id) references students(student_id) ON DELETE CASCADE,
    FOREIGN KEY(title) references courses(new_number) ON DELETE CASCADE,
    CONSTRAINT Year_Quarter CHECK (NOT(Year = 2023 and quarter IN ('SP', 'SPRING')))
);

CREATE TABLE thesis_committee
(
    student_id int,
    instructor_name varchar(20),
    department varchar(20),
    PRIMARY KEY(student_id, instructor_name),
    FOREIGN KEY(student_id) references graduate(student_id) ON DELETE CASCADE,
    FOREIGN KEY(instructor_name) references faculty(faculty_name) ON DELETE CASCADE
);

CREATE TABLE course_enrollment
(
    student_id int,
    section_id serial,
    class_name varchar(20),
    year int CHECK (year = 2023),
    quarter varchar(20) CHECK (quarter IN ('SP', 'SPRING')),
    units int,
    grade varchar(20),
    PRIMARY KEY(student_id, section_id),
    FOREIGN KEY(student_id) references students(student_id) ON DELETE CASCADE,
    FOREIGN KEY(section_id) references classes(section_id) ON DELETE CASCADE,
    FOREIGN KEY(class_name) references courses(new_number) ON DELETE CASCADE
);

create table grade_conversion
(
    letter_grade char(2) not null,
    number_grade decimal(2,1)
);

create table concentration
(
  id int PRIMARY KEY,
  department VARCHAR(30),
  concentration VARCHAR(30),
  class_name VARCHAR(20)
);
