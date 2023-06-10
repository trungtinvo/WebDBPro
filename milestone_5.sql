------------------------Milestone 5-----------------------
------------------------Materialized View CPQG-----------------------

DROP TABLE IF EXISTS CPQG CASCADE;
CREATE TABLE CPQG AS
    SELECT title, year, quarter, instructor_name,
       COUNT(CASE WHEN grade IN ('A+', 'A', 'A-') THEN 1 ELSE NULL END) AS count_A,
       COUNT(CASE WHEN grade IN ('B+', 'B', 'B-') THEN 1 ELSE NULL END) AS count_B,
       COUNT(CASE WHEN grade IN ('C+', 'C', 'C-') THEN 1 ELSE NULL END) AS count_C,
       COUNT(CASE WHEN grade IN ('D+', 'D', 'D-') THEN 1 ELSE NULL END) AS count_D,
       COUNT(CASE WHEN grade NOT IN ('A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D+', 'D', 'D-') THEN 1 ELSE NULL END) AS count_other
    FROM past_classes
    GROUP BY title, year, quarter, instructor_name;

------------------------Insert Or Update CPQG Trigger-----------------------
DROP TRIGGER IF EXISTS insert_update_CPQG_trigger ON past_classes;
DROP FUNCTION IF EXISTS insert_update_CPQG_trigger();

CREATE OR REPLACE FUNCTION insert_update_CPQG_trigger() RETURNS TRIGGER AS $insert_update_CPQG_trigger$
BEGIN

    IF NOT EXISTS (SELECT 1 
                    FROM CPQG
                    WHERE CPQG.title = NEW.title
                        AND CPQG.year = NEW.year
                        AND CPQG.quarter = NEW.quarter
                        AND CPQG.instructor_name =  NEW.instructor_name)
    THEN
        INSERT INTO CPQG(title, year, quarter, instructor_name, count_A, count_B, count_C, count_D, count_other)
        VALUES (
            NEW.title, NEW.year, NEW.quarter, NEW.instructor_name,
            (CASE WHEN NEW.grade IN ('A+', 'A', 'A-') THEN 1 ELSE 0 END),
            (CASE WHEN NEW.grade IN ('B+', 'B', 'B-') THEN 1 ELSE 0 END),
            (CASE WHEN NEW.grade IN ('C+', 'C', 'C-') THEN 1 ELSE 0 END),
            (CASE WHEN NEW.grade IN ('D') THEN 1 ELSE 0 END),
            (CASE WHEN NEW.grade NOT IN ('A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D') THEN 1 ELSE 0 END)
        );
    ELSE
        UPDATE CPQG
        SET
        count_A = CASE WHEN OLD.grade IN ('A+', 'A', 'A-') THEN count_A - 1 ELSE count_A END,
        count_B = CASE WHEN OLD.grade IN ('B+', 'B', 'B-') THEN count_B - 1 ELSE count_B END,
        count_C = CASE WHEN OLD.grade IN ('C+', 'C', 'C-') THEN count_C - 1 ELSE count_C END,
        count_D = CASE WHEN OLD.grade IN ('D') THEN count_D - 1 ELSE count_D END,
        count_other = CASE WHEN OLD.grade NOT IN ('A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D') THEN count_other - 1 ELSE count_other END
        WHERE title = OLD.title
            AND year = OLD.year
            AND quarter = OLD.quarter
            AND instructor_name = OLD.instructor_name;
            
        UPDATE CPQG
        SET
        count_A = CASE WHEN NEW.grade IN ('A+', 'A', 'A-') THEN count_A + 1 ELSE count_A END,
        count_B = CASE WHEN NEW.grade IN ('B+', 'B', 'B-') THEN count_B + 1 ELSE count_B END,
        count_C = CASE WHEN NEW.grade IN ('C+', 'C', 'C-') THEN count_C + 1 ELSE count_C END,
        count_D = CASE WHEN NEW.grade IN ('D') THEN count_D + 1 ELSE count_D END,
        count_other = CASE WHEN NEW.grade NOT IN ('A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D') THEN count_other + 1 ELSE count_other END
        WHERE title = NEW.title
            AND year = NEW.year
            AND quarter = NEW.quarter
            AND instructor_name = NEW.instructor_name;
        
    END IF;
    RETURN NEW;
END;

$insert_update_CPQG_trigger$ LANGUAGE plpgsql;

-- Create the trigger to invoke the update_CPQG function upon insertion or update of grades
CREATE TRIGGER insert_update_CPQG_trigger
AFTER INSERT OR UPDATE ON past_classes
FOR EACH ROW
EXECUTE FUNCTION insert_update_CPQG_trigger();

------------------------Delete CPQG Trigger-----------------------
DROP TRIGGER IF EXISTS delete_CPQG_trigger ON past_classes;
DROP FUNCTION IF EXISTS delete_CPQG_trigger();

CREATE OR REPLACE FUNCTION delete_CPQG_trigger() RETURNS TRIGGER AS $delete_CPQG_trigger$
BEGIN

    UPDATE CPQG
    SET
    count_A = CASE WHEN OLD.grade IN ('A+', 'A', 'A-') THEN count_A - 1 ELSE count_A END,
    count_B = CASE WHEN OLD.grade IN ('B+', 'B', 'B-') THEN count_B - 1 ELSE count_B END,
    count_C = CASE WHEN OLD.grade IN ('C+', 'C', 'C-') THEN count_C - 1 ELSE count_C END,
    count_D = CASE WHEN OLD.grade IN ('D') THEN count_D - 1 ELSE count_D END,
    count_other = CASE WHEN OLD.grade NOT IN ('A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D') THEN count_other - 1 ELSE count_other END
    WHERE title = OLD.title
        AND year = OLD.year
        AND quarter = OLD.quarter
        AND instructor_name = OLD.instructor_name;

    RETURN NEW;
END;

$delete_CPQG_trigger$ LANGUAGE plpgsql;

-- Create the trigger to invoke the update_CPQG function upon insertion or update of grades
CREATE TRIGGER delete_CPQG_trigger
AFTER DELETE ON past_classes
FOR EACH ROW
EXECUTE FUNCTION delete_CPQG_trigger();

------------------------Materialized View CPG-----------------------
DROP TABLE IF EXISTS CPG CASCADE;
CREATE TABLE CPG AS
    SELECT title, instructor_name,
       COUNT(CASE WHEN grade IN ('A+', 'A', 'A-') THEN 1 ELSE NULL END) AS count_A,
       COUNT(CASE WHEN grade IN ('B+', 'B', 'B-') THEN 1 ELSE NULL END) AS count_B,
       COUNT(CASE WHEN grade IN ('C+', 'C', 'C-') THEN 1 ELSE NULL END) AS count_C,
       COUNT(CASE WHEN grade IN ('D+', 'D', 'D-') THEN 1 ELSE NULL END) AS count_D,
       COUNT(CASE WHEN grade NOT IN ('A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D+', 'D', 'D-') THEN 1 ELSE NULL END) AS count_other
    FROM past_classes
    GROUP BY title, instructor_name;

------------------------Insert Or Update CPG Trigger-----------------------
DROP TRIGGER IF EXISTS insert_update_CPG_trigger ON past_classes;
DROP FUNCTION IF EXISTS insert_update_CPG_trigger();

CREATE OR REPLACE FUNCTION insert_update_CPG_trigger() RETURNS TRIGGER AS $insert_update_CPG_trigger$
BEGIN

    IF NOT EXISTS (SELECT 1 
                    FROM CPG
                    WHERE CPG.title = NEW.title
                        AND CPG.instructor_name =  NEW.instructor_name)
    THEN
        INSERT INTO CPG(title, instructor_name, count_A, count_B, count_C, count_D, count_other)
        VALUES (
            NEW.title, NEW.instructor_name,
            (CASE WHEN NEW.grade IN ('A+', 'A', 'A-') THEN 1 ELSE 0 END),
            (CASE WHEN NEW.grade IN ('B+', 'B', 'B-') THEN 1 ELSE 0 END),
            (CASE WHEN NEW.grade IN ('C+', 'C', 'C-') THEN 1 ELSE 0 END),
            (CASE WHEN NEW.grade IN ('D') THEN 1 ELSE 0 END),
            (CASE WHEN NEW.grade NOT IN ('A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D') THEN 1 ELSE 0 END)
        );
    ELSE
        UPDATE CPG
        SET
        count_A = CASE WHEN OLD.grade IN ('A+', 'A', 'A-') THEN count_A - 1 ELSE count_A END,
        count_B = CASE WHEN OLD.grade IN ('B+', 'B', 'B-') THEN count_B - 1 ELSE count_B END,
        count_C = CASE WHEN OLD.grade IN ('C+', 'C', 'C-') THEN count_C - 1 ELSE count_C END,
        count_D = CASE WHEN OLD.grade IN ('D') THEN count_D - 1 ELSE count_D END,
        count_other = CASE WHEN OLD.grade NOT IN ('A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D') THEN count_other - 1 ELSE count_other END
        WHERE title = OLD.title
            AND instructor_name = OLD.instructor_name;
            
        UPDATE CPG
        SET
        count_A = CASE WHEN NEW.grade IN ('A+', 'A', 'A-') THEN count_A + 1 ELSE count_A END,
        count_B = CASE WHEN NEW.grade IN ('B+', 'B', 'B-') THEN count_B + 1 ELSE count_B END,
        count_C = CASE WHEN NEW.grade IN ('C+', 'C', 'C-') THEN count_C + 1 ELSE count_C END,
        count_D = CASE WHEN NEW.grade IN ('D') THEN count_D + 1 ELSE count_D END,
        count_other = CASE WHEN NEW.grade NOT IN ('A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D') THEN count_other + 1 ELSE count_other END
        WHERE title = NEW.title
            AND instructor_name = NEW.instructor_name;
        
    END IF;
    RETURN NEW;
END;

$insert_update_CPG_trigger$ LANGUAGE plpgsql;

-- Create the trigger to invoke the update_CPQG function upon insertion or update of grades
CREATE TRIGGER insert_update_CPG_trigger
AFTER INSERT OR UPDATE ON past_classes
FOR EACH ROW
EXECUTE FUNCTION insert_update_CPG_trigger();

------------------------Insert Or Update CPQG Trigger-----------------------
DROP TRIGGER IF EXISTS delete_CPG_trigger ON past_classes;
DROP FUNCTION IF EXISTS delete_CPG_trigger();

CREATE OR REPLACE FUNCTION delete_CPG_trigger() RETURNS TRIGGER AS $delete_CPG_trigger$
BEGIN

    UPDATE CPG
    SET
    count_A = CASE WHEN OLD.grade IN ('A+', 'A', 'A-') THEN count_A - 1 ELSE count_A END,
    count_B = CASE WHEN OLD.grade IN ('B+', 'B', 'B-') THEN count_B - 1 ELSE count_B END,
    count_C = CASE WHEN OLD.grade IN ('C+', 'C', 'C-') THEN count_C - 1 ELSE count_C END,
    count_D = CASE WHEN OLD.grade IN ('D') THEN count_D - 1 ELSE count_D END,
    count_other = CASE WHEN OLD.grade NOT IN ('A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D') THEN count_other - 1 ELSE count_other END
    WHERE title = OLD.title
        AND instructor_name = OLD.instructor_name;

    RETURN NEW;
END;

$delete_CPG_trigger$ LANGUAGE plpgsql;

CREATE TRIGGER delete_CPG_trigger
AFTER DELETE ON past_classes
FOR EACH ROW
EXECUTE FUNCTION delete_CPG_trigger();


------------------------CPQG AND CPG TEST CASES-----------------------
INSERT INTO past_classes(student_id, section_id, title, year, quarter, instructor_name, grade, units, grade_conversion,class_type) 
VALUES('21', '3', 'CSE142', '2021', 'FA', 'Flo_Rence', 'B-', '4','2.8', 'upper_units');

UPDATE past_classes
SET grade = 'D'
WHERE student_id = '21' AND section_id = '3';

DELETE FROM past_classes WHERE student_id = '21' AND section_id = '3';

--Insert new classes, new student_id, new section_id into past_classes
INSERT INTO past_classes(student_id, section_id, title, year, quarter, instructor_name, grade, units, grade_conversion,class_type) 
VALUES('15', '31', 'CE222', '2023', 'FA', 'Adam_D', 'D', '4','1.6', 'upper_units');