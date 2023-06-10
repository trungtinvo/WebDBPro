------------------------Milestone 4-----------------------
-----------------Weekly Meeting Trigger-----------------
DROP TRIGGER IF EXISTS weekly_meeting_trigger ON weekly;
DROP FUNCTION IF EXISTS weekly_meeting_trigger();

CREATE FUNCTION weekly_meeting_trigger() 
RETURNS trigger AS $weekly_meeting_trigger$
    BEGIN
        -- Compare current enrollment size with section's limit
        IF EXISTS (SELECT * 
            FROM weekly as w
            INNER JOIN classes c 
                ON w.section_id = c.section_id
                AND c.year = 2023 AND c.quarter IN ('SP', 'SPRING')
            WHERE w.section_id = NEW.section_id
                AND w.date_time = NEW.date_time
                AND (NEW.begin_time, NEW.end_time) OVERLAPS (w.begin_time, w.end_time)
                AND w.session_type <> NEW.session_type) 
        THEN
            RAISE EXCEPTION 'Conflicting meetings for %''s from % to % for section ID % detected. Lectures, discussions, and labs cannot happen simultaneously.', 
            NEW.session_type, NEW.begin_time, NEW.end_time, NEW.section_id;
        END IF;

        RETURN NEW;
    END;
$weekly_meeting_trigger$ LANGUAGE plpgsql;

CREATE TRIGGER weekly_meeting_trigger BEFORE INSERT ON weekly
FOR EACH ROW EXECUTE PROCEDURE weekly_meeting_trigger();


-----------------Enrollment Limit Trigger-----------------
DROP TRIGGER IF EXISTS enrollment_limit_trigger ON course_enrollment;
DROP FUNCTION IF EXISTS enrollment_limit_trigger();

CREATE FUNCTION enrollment_limit_trigger() 
RETURNS trigger AS $enrollment_limit_trigger$
    BEGIN
        -- Compare current enrollment size with section's limit
        IF (SELECT COUNT(*) 
            FROM course_enrollment 
            WHERE section_id = NEW.section_id) 
            >=
            (SELECT enrollment_limit 
            FROM classes 
            WHERE section_id = NEW.section_id) 
        THEN
            RAISE EXCEPTION 'Enrollment in section ID % is reaching its maximum limit of %.', NEW.section_id,
            (SELECT enrollment_limit 
            FROM classes 
            WHERE section_id = NEW.section_id);
        END IF;

        RETURN NEW;
    END;
$enrollment_limit_trigger$ LANGUAGE plpgsql;

CREATE TRIGGER enrollment_limit_trigger BEFORE INSERT ON course_enrollment
FOR EACH ROW EXECUTE PROCEDURE enrollment_limit_trigger();

-------------- Create a trigger function to check for conflicting sections---------------
DROP TRIGGER IF EXISTS overlapped_teaching ON teaching;
DROP FUNCTION IF EXISTS overlapped_teaching();

CREATE FUNCTION overlapped_teaching() RETURNS trigger AS $overlapped_teaching$
      DECLARE
        overlap_exists BOOLEAN;
	BEGIN
        -- current schedule of teaching       
        CREATE TEMP TABLE current_schedule AS
        SELECT DISTINCT ct.section_id, w.date_time AS date_current_teaching , w.begin_time AS begin_current_teaching,
        w.end_time AS end_current_teaching
        FROM teaching ct
        JOIN weekly w ON ct.section_id = w.section_id
        WHERE faculty_name = NEW.faculty_name;
        

        -- weekly meeting sections to be inserted
        CREATE TEMP TABLE inserted_schedule AS
        SELECT DISTINCT date_time AS date_inserted_teaching, begin_time AS begin_inserted_teaching, end_time AS end_inserted_teaching
        FROM weekly WHERE section_id = NEW.section_id;

        
        -- overlapping times in Day, HH12:MI:SS format        
        SELECT EXISTS (
            SELECT 1
            FROM current_schedule, inserted_schedule
            WHERE date_current_teaching = date_inserted_teaching
            AND (begin_current_teaching, end_current_teaching) OVERLAPS (begin_inserted_teaching, end_inserted_teaching)
        ) INTO overlap_exists;

        IF overlap_exists THEN
            RAISE EXCEPTION '% overlapped section id % The instructor is not available at this schedule.',
            NEW.faculty_name, NEW.section_id;
        END IF;

		
        -- drop temp tables
        DROP TABLE IF EXISTS current_schedule;
        DROP TABLE IF EXISTS inserted_schedule;
        
        RETURN NEW;
    END;
$overlapped_teaching$ LANGUAGE plpgsql;

CREATE TRIGGER overlapped_teaching BEFORE INSERT ON teaching
FOR EACH ROW EXECUTE PROCEDURE overlapped_teaching();