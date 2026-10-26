

-- ERP FULL SEED — PART 3: ACADEMIC DATA
-- Sections, Teaching Assignments, Timetable, Marks, Attendance
-- Run AFTER seed_part2_students.sql
-- ============================================================

-- ============================================================
-- SECTIONS (Year 1-4, Sec A & B for all 7 departments)
-- class_advisor_id is nullable so we skip it here; update later
-- ============================================================
INSERT IGNORE INTO sections (department_id, year, name, class_advisor_id)
SELECT d.id, y.yr, s.sec, NULL
FROM departments d
CROSS JOIN (SELECT 1 yr UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) y
CROSS JOIN (SELECT 'A' sec UNION SELECT 'B') s
WHERE d.code IN ('CSE','IT','ECE','EEE','MECH','CIVIL','AIDS');

-- ── Assign class advisors to CSE Sections (use existing HOD as fallback) ──
UPDATE sections
SET class_advisor_id = (SELECT id FROM faculty WHERE staff_id='STF-IT004' LIMIT 1)
WHERE department_id = (SELECT id FROM departments WHERE code='IT' LIMIT 1)
  AND year = 1 AND name = 'A';

UPDATE sections
SET class_advisor_id = (SELECT id FROM faculty WHERE staff_id='STF-IT004' LIMIT 1)
WHERE department_id = (SELECT id FROM departments WHERE code='IT' LIMIT 1)
  AND year = 1 AND name = 'B';

UPDATE sections
SET class_advisor_id = (SELECT id FROM faculty WHERE staff_id='STF-ECE004' LIMIT 1)
WHERE department_id = (SELECT id FROM departments WHERE code='ECE' LIMIT 1)
  AND year = 1 AND name = 'A';

UPDATE sections
SET class_advisor_id = (SELECT id FROM faculty WHERE staff_id='STF-ECE004' LIMIT 1)
WHERE department_id = (SELECT id FROM departments WHERE code='ECE' LIMIT 1)
  AND year = 1 AND name = 'B';

UPDATE sections
SET class_advisor_id = (SELECT id FROM faculty WHERE staff_id='STF-EEE004' LIMIT 1)
WHERE department_id = (SELECT id FROM departments WHERE code='EEE' LIMIT 1)
  AND year = 1 AND name = 'A';

UPDATE sections
SET class_advisor_id = (SELECT id FROM faculty WHERE staff_id='STF-MECH004' LIMIT 1)
WHERE department_id = (SELECT id FROM departments WHERE code='MECH' LIMIT 1)
  AND year = 1 AND name = 'A';

UPDATE sections
SET class_advisor_id = (SELECT id FROM faculty WHERE staff_id='STF-CIV004' LIMIT 1)
WHERE department_id = (SELECT id FROM departments WHERE code='CIVIL' LIMIT 1)
  AND year = 1 AND name = 'A';

UPDATE sections
SET class_advisor_id = (SELECT id FROM faculty WHERE staff_id='STF-AIDS004' LIMIT 1)
WHERE department_id = (SELECT id FROM departments WHERE code='AIDS' LIMIT 1)
  AND year = 1 AND name = 'A';

-- ============================================================
-- TEACHING ASSIGNMENTS — All departments Y1-Y4
-- Using stored procedure for compact generation
-- ============================================================
DROP PROCEDURE IF EXISTS gen_assignments;
DELIMITER //
CREATE PROCEDURE gen_assignments(
    IN dept_code VARCHAR(10),
    IN staff_id_val VARCHAR(20),
    IN yr INT,
    IN sem INT,
    IN subj_name VARCHAR(100),
    IN subj_code VARCHAR(20)
)
BEGIN
    DECLARE did INT;
    DECLARE fid INT;
    DECLARE sec_a INT;
    DECLARE sec_b INT;

    SELECT id INTO did FROM departments WHERE code = dept_code LIMIT 1;
    SELECT id INTO fid FROM faculty WHERE staff_id = staff_id_val LIMIT 1;
    SELECT id INTO sec_a FROM sections
        WHERE department_id = did AND year = yr AND name = 'A' LIMIT 1;
    SELECT id INTO sec_b FROM sections
        WHERE department_id = did AND year = yr AND name = 'B' LIMIT 1;

    IF fid IS NOT NULL AND did IS NOT NULL THEN
        INSERT IGNORE INTO teaching_assignments
            (faculty_id, department_id, year, semester, subject_name, subject_code, section_id)
        VALUES (fid, did, yr, sem, subj_name, subj_code, sec_a);

        INSERT IGNORE INTO teaching_assignments
            (faculty_id, department_id, year, semester, subject_name, subject_code, section_id)
        VALUES (fid, did, yr, sem, subj_name, subj_code, sec_b);
    END IF;
END //
DELIMITER ;

-- ── IT Teaching Assignments ─────────────────────────────────

-- HOD teaches Y3
CALL gen_assignments('IT','STF-IT001',3,6,'Software Engineering','IT6301');
CALL gen_assignments('IT','STF-IT001',3,6,'Project Management','IT6302');

-- Faculty 1 teaches Y1 & Y2
CALL gen_assignments('IT','STF-IT002',1,2,'Programming in C','IT1201');
CALL gen_assignments('IT','STF-IT002',1,2,'Digital Fundamentals','IT1202');
CALL gen_assignments('IT','STF-IT002',2,4,'Data Structures','IT2401');

-- Faculty 2 teaches Y2 & Y3
CALL gen_assignments('IT','STF-IT003',2,4,'Database Management','IT2402');
CALL gen_assignments('IT','STF-IT003',2,4,'Computer Networks','IT2403');
CALL gen_assignments('IT','STF-IT003',3,6,'Operating Systems','IT3601');

-- Class Advisor teaches Y1
CALL gen_assignments('IT','STF-IT004',1,2,'Mathematics I','IT1203');
CALL gen_assignments('IT','STF-IT004',1,2,'Engineering Physics','IT1204');

-- Cross-dept faculty also teaches AIDS
CALL gen_assignments('IT','STF-IT006',4,8,'Machine Learning','IT4801');
CALL gen_assignments('IT','STF-IT006',4,8,'Cloud Computing','IT4802');
CALL gen_assignments('AIDS','STF-IT006',2,4,'Python Programming','AIDS2401');

-- ── ECE Teaching Assignments ────────────────────────────────
CALL gen_assignments('ECE','STF-ECE001',4,8,'VLSI Design','ECE4801');
CALL gen_assignments('ECE','STF-ECE001',3,6,'Embedded Systems','ECE3601');
CALL gen_assignments('ECE','STF-ECE002',1,2,'Basic Electronics','ECE1201');
CALL gen_assignments('ECE','STF-ECE002',1,2,'Engineering Maths','ECE1202');
CALL gen_assignments('ECE','STF-ECE002',2,4,'Signals & Systems','ECE2401');
CALL gen_assignments('ECE','STF-ECE003',2,4,'Analog Circuits','ECE2402');
CALL gen_assignments('ECE','STF-ECE003',3,6,'Digital Communication','ECE3602');
CALL gen_assignments('ECE','STF-ECE004',1,2,'Engineering Drawing','ECE1203');
CALL gen_assignments('ECE','STF-ECE004',2,4,'Microprocessors','ECE2403');
-- Cross-dept ECE teaches IT networks
CALL gen_assignments('IT','STF-ECE005',3,6,'Network Security','IT3602');
CALL gen_assignments('ECE','STF-ECE005',4,8,'Wireless Communication','ECE4802');

-- ── EEE Teaching Assignments ────────────────────────────────
CALL gen_assignments('EEE','STF-EEE001',4,8,'Power Electronics','EEE4801');
CALL gen_assignments('EEE','STF-EEE001',3,6,'Electrical Machines','EEE3601');
CALL gen_assignments('EEE','STF-EEE002',1,2,'Circuit Theory','EEE1201');
CALL gen_assignments('EEE','STF-EEE002',2,4,'Control Systems','EEE2401');
CALL gen_assignments('EEE','STF-EEE003',1,2,'Engineering Physics','EEE1202');
CALL gen_assignments('EEE','STF-EEE003',2,4,'Digital Electronics','EEE2402');
CALL gen_assignments('EEE','STF-EEE004',1,2,'Maths for EEE','EEE1203');
CALL gen_assignments('EEE','STF-EEE004',2,4,'Analog Electronics','EEE2403');
CALL gen_assignments('EEE','STF-EEE005',3,6,'Power Systems','EEE3602');
CALL gen_assignments('EEE','STF-EEE005',4,8,'Renewable Energy','EEE4802');

-- ── MECH Teaching Assignments ───────────────────────────────
CALL gen_assignments('MECH','STF-MECH001',4,8,'CAD/CAM','MECH4801');
CALL gen_assignments('MECH','STF-MECH001',3,6,'Fluid Mechanics','MECH3601');
CALL gen_assignments('MECH','STF-MECH002',1,2,'Engineering Mechanics','MECH1201');
CALL gen_assignments('MECH','STF-MECH002',2,4,'Thermodynamics','MECH2401');
CALL gen_assignments('MECH','STF-MECH003',1,2,'Engineering Drawing','MECH1202');
CALL gen_assignments('MECH','STF-MECH003',2,4,'Strength of Materials','MECH2402');
CALL gen_assignments('MECH','STF-MECH004',1,2,'Manufacturing Processes','MECH1203');
CALL gen_assignments('MECH','STF-MECH004',3,6,'Heat Transfer','MECH3602');
CALL gen_assignments('MECH','STF-MECH005',3,6,'Machine Design','MECH3603');
CALL gen_assignments('MECH','STF-MECH005',4,8,'Industrial Engineering','MECH4802');

-- ── CIVIL Teaching Assignments ──────────────────────────────
CALL gen_assignments('CIVIL','STF-CIV001',4,8,'Structural Analysis','CIVIL4801');
CALL gen_assignments('CIVIL','STF-CIV001',3,6,'Soil Mechanics','CIVIL3601');
CALL gen_assignments('CIVIL','STF-CIV002',1,2,'Engineering Maths','CIVIL1201');
CALL gen_assignments('CIVIL','STF-CIV002',2,4,'Fluid Mechanics','CIVIL2401');
CALL gen_assignments('CIVIL','STF-CIV003',1,2,'Engineering Physics','CIVIL1202');
CALL gen_assignments('CIVIL','STF-CIV003',2,4,'Building Materials','CIVIL2402');
CALL gen_assignments('CIVIL','STF-CIV004',1,2,'Surveying','CIVIL1203');
CALL gen_assignments('CIVIL','STF-CIV004',3,6,'Transportation Engg','CIVIL3602');
CALL gen_assignments('CIVIL','STF-CIV005',3,6,'Environmental Engg','CIVIL3603');
CALL gen_assignments('CIVIL','STF-CIV005',4,8,'Construction Management','CIVIL4802');

-- ── AIDS Teaching Assignments ───────────────────────────────
CALL gen_assignments('AIDS','STF-AIDS001',4,8,'Deep Learning','AIDS4801');
CALL gen_assignments('AIDS','STF-AIDS001',3,6,'Machine Learning','AIDS3601');
CALL gen_assignments('AIDS','STF-AIDS002',1,2,'Programming in Python','AIDS1201');
CALL gen_assignments('AIDS','STF-AIDS002',2,4,'Data Structures','AIDS2402');
CALL gen_assignments('AIDS','STF-AIDS003',1,2,'Statistics & Probability','AIDS1202');
CALL gen_assignments('AIDS','STF-AIDS003',2,4,'Database Systems','AIDS2403');
CALL gen_assignments('AIDS','STF-AIDS004',1,2,'Discrete Mathematics','AIDS1203');
CALL gen_assignments('AIDS','STF-AIDS004',3,6,'Natural Language Processing','AIDS3602');
CALL gen_assignments('AIDS','STF-AIDS005',3,6,'Computer Vision','AIDS3603');
CALL gen_assignments('AIDS','STF-AIDS005',4,8,'AI Ethics & Governance','AIDS4802');

DROP PROCEDURE IF EXISTS gen_assignments;

-- ============================================================
-- TIMETABLE — CSE Year 1 Section A (Mon-Sat, Hours 1-8)
-- Using existing CSE faculty (STF001) and IT cross-dept
-- ============================================================
DROP PROCEDURE IF EXISTS gen_tt;
DELIMITER //
CREATE PROCEDURE gen_tt(
    IN dept_c VARCHAR(10),
    IN yr INT,
    IN sem INT,
    IN sec_name VARCHAR(2),
    IN day_name VARCHAR(10),
    IN hr INT,
    IN subj_n VARCHAR(100),
    IN subj_c VARCHAR(20),
    IN faculty_sid VARCHAR(20)
)
BEGIN
    DECLARE did   INT;
    DECLARE fid   INT;
    DECLARE secid INT;

    SELECT id INTO did   FROM departments WHERE code = dept_c LIMIT 1;
    SELECT id INTO fid   FROM faculty WHERE staff_id = faculty_sid LIMIT 1;
    SELECT id INTO secid FROM sections
        WHERE department_id = did AND year = yr AND name = sec_name LIMIT 1;

    IF fid IS NOT NULL AND did IS NOT NULL AND secid IS NOT NULL THEN
        INSERT IGNORE INTO timetable_entries
            (department_id, year, semester, section_id,
             day_of_week, hour, subject_name, subject_code, faculty_id, type)
        VALUES (did, yr, sem, secid, day_name, hr, subj_n, subj_c, fid, 'LECTURE');
    END IF;
END //
DELIMITER ;

-- IT Y1 Sec A — full week timetable
CALL gen_tt('IT',1,2,'A','MONDAY',   1,'Programming in C',     'IT1201','STF-IT002');
CALL gen_tt('IT',1,2,'A','MONDAY',   2,'Digital Fundamentals', 'IT1202','STF-IT002');
CALL gen_tt('IT',1,2,'A','MONDAY',   3,'Mathematics I',        'IT1203','STF-IT004');
CALL gen_tt('IT',1,2,'A','MONDAY',   4,'Engineering Physics',  'IT1204','STF-IT004');
CALL gen_tt('IT',1,2,'A','MONDAY',   5,'Programming in C',     'IT1201','STF-IT002');
CALL gen_tt('IT',1,2,'A','MONDAY',   6,'Mathematics I',        'IT1203','STF-IT004');

CALL gen_tt('IT',1,2,'A','TUESDAY',  1,'Digital Fundamentals', 'IT1202','STF-IT002');
CALL gen_tt('IT',1,2,'A','TUESDAY',  2,'Mathematics I',        'IT1203','STF-IT004');
CALL gen_tt('IT',1,2,'A','TUESDAY',  3,'Programming in C',     'IT1201','STF-IT002');
CALL gen_tt('IT',1,2,'A','TUESDAY',  4,'Engineering Physics',  'IT1204','STF-IT004');
CALL gen_tt('IT',1,2,'A','TUESDAY',  5,'Digital Fundamentals', 'IT1202','STF-IT002');
CALL gen_tt('IT',1,2,'A','TUESDAY',  6,'Mathematics I',        'IT1203','STF-IT004');

CALL gen_tt('IT',1,2,'A','WEDNESDAY',1,'Programming in C',     'IT1201','STF-IT002');
CALL gen_tt('IT',1,2,'A','WEDNESDAY',2,'Digital Fundamentals', 'IT1202','STF-IT002');
CALL gen_tt('IT',1,2,'A','WEDNESDAY',3,'Engineering Physics',  'IT1204','STF-IT004');
CALL gen_tt('IT',1,2,'A','WEDNESDAY',4,'Mathematics I',        'IT1203','STF-IT004');
CALL gen_tt('IT',1,2,'A','WEDNESDAY',5,'Programming in C',     'IT1201','STF-IT002');
CALL gen_tt('IT',1,2,'A','WEDNESDAY',6,'Digital Fundamentals', 'IT1202','STF-IT002');

CALL gen_tt('IT',1,2,'A','THURSDAY', 1,'Mathematics I',        'IT1203','STF-IT004');
CALL gen_tt('IT',1,2,'A','THURSDAY', 2,'Engineering Physics',  'IT1204','STF-IT004');
CALL gen_tt('IT',1,2,'A','THURSDAY', 3,'Digital Fundamentals', 'IT1202','STF-IT002');
CALL gen_tt('IT',1,2,'A','THURSDAY', 4,'Programming in C',     'IT1201','STF-IT002');
CALL gen_tt('IT',1,2,'A','THURSDAY', 5,'Mathematics I',        'IT1203','STF-IT004');
CALL gen_tt('IT',1,2,'A','THURSDAY', 6,'Engineering Physics',  'IT1204','STF-IT004');

CALL gen_tt('IT',1,2,'A','FRIDAY',   1,'Engineering Physics',  'IT1204','STF-IT004');
CALL gen_tt('IT',1,2,'A','FRIDAY',   2,'Programming in C',     'IT1201','STF-IT002');
CALL gen_tt('IT',1,2,'A','FRIDAY',   3,'Mathematics I',        'IT1203','STF-IT004');
CALL gen_tt('IT',1,2,'A','FRIDAY',   4,'Digital Fundamentals', 'IT1202','STF-IT002');
CALL gen_tt('IT',1,2,'A','FRIDAY',   5,'Engineering Physics',  'IT1204','STF-IT004');
CALL gen_tt('IT',1,2,'A','FRIDAY',   6,'Programming in C',     'IT1201','STF-IT002');

CALL gen_tt('IT',1,2,'A','SATURDAY', 1,'Programming in C',     'IT1201','STF-IT002');
CALL gen_tt('IT',1,2,'A','SATURDAY', 2,'Mathematics I',        'IT1203','STF-IT004');
CALL gen_tt('IT',1,2,'A','SATURDAY', 3,'Digital Fundamentals', 'IT1202','STF-IT002');
CALL gen_tt('IT',1,2,'A','SATURDAY', 4,'Engineering Physics',  'IT1204','STF-IT004');

DROP PROCEDURE IF EXISTS gen_tt;

-- ============================================================
-- INTERNAL MARKS — IT Year 1 students (IT1201 & IT1202)
-- ============================================================
DROP PROCEDURE IF EXISTS gen_marks;
DELIMITER //
CREATE PROCEDURE gen_marks(IN sem_num INT)
BEGIN
    DECLARE sid INT;
    DECLARE curs CURSOR FOR
        SELECT s.id FROM students s
        JOIN specializations sp ON s.specialization_id = sp.id
        JOIN semesters sem ON sem.semester_number = sem_num
        WHERE sp.code = 'IT' AND s.current_year = 1
        LIMIT 25;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET @done = 1;
    DECLARE sid_ INT;
    DECLARE sem_id INT;
    DECLARE i INT DEFAULT 0;

    SELECT id INTO sem_id FROM semesters WHERE semester_number = sem_num LIMIT 1;

    IF sem_id IS NOT NULL THEN
        OPEN curs;
        SET @done = 0;
        mk_loop: LOOP
            FETCH curs INTO sid_;
            IF @done = 1 THEN LEAVE mk_loop; END IF;
            SET i = i + 1;

            INSERT IGNORE INTO internal_marks
                (student_id, semester_id, subject_code, marks, max_marks, exam_type)
            VALUES
                (sid_, sem_id, 'IT1201', 30 + (i * 3 MOD 45), 75, 'INTERNAL 1'),
                (sid_, sem_id, 'IT1201', 25 + (i * 5 MOD 50), 75, 'INTERNAL 2'),
                (sid_, sem_id, 'IT1202', 28 + (i * 4 MOD 47), 75, 'INTERNAL 1'),
                (sid_, sem_id, 'IT1202', 32 + (i * 2 MOD 43), 75, 'INTERNAL 2');
        END LOOP;
        CLOSE curs;
    END IF;
END //
DELIMITER ;

CALL gen_marks(2);
DROP PROCEDURE IF EXISTS gen_marks;

-- ============================================================
-- ATTENDANCE — IT Year 1 Sec A — last 10 working days
-- ============================================================
DROP PROCEDURE IF EXISTS gen_attendance;
DELIMITER //
CREATE PROCEDURE gen_attendance()
BEGIN
    DECLARE ast_id INT;
    DECLARE did    INT;
    DECLARE deg_id INT;
    DECLARE spec_id INT;
    DECLARE d      INT DEFAULT 1;
    DECLARE h      INT;
    DECLARE att_date DATE;
    DECLARE hdr_id INT;
    DECLARE sid    INT;

    SELECT id INTO ast_id FROM assistant_staff WHERE assistant_id='AST-IT01' LIMIT 1;
    SELECT id INTO did    FROM departments      WHERE code='IT'       LIMIT 1;
    SELECT id INTO deg_id FROM degrees          WHERE code='BE'       LIMIT 1;
    SELECT id INTO spec_id FROM specializations WHERE code='IT'       LIMIT 1;

    WHILE d <= 10 DO
        SET att_date = DATE_SUB(CURDATE(), INTERVAL d DAY);
        -- Skip weekends
        IF DAYOFWEEK(att_date) NOT IN (1,7) THEN
            SET h = 1;
            WHILE h <= 5 DO
                IF NOT EXISTS (
                    SELECT 1 FROM attendance_header
                    WHERE program_type='UG' AND degree_id=deg_id
                      AND specialization_id=spec_id AND year=1 AND semester=2
                      AND date=att_date AND hour=h
                ) THEN
                    INSERT INTO attendance_header
                        (program_type, degree_id, specialization_id, year, semester, date, hour, assistant_id, submitted_at)
                    VALUES ('UG', deg_id, spec_id, 1, 2, att_date, h, ast_id, NOW());
                    SET hdr_id = LAST_INSERT_ID();

                    -- Mark all IT Y1 students for this session
                    INSERT IGNORE INTO attendance_detail (header_id, student_id, status)
                    SELECT hdr_id, s.id,
                        CASE WHEN (s.id + d + h) MOD 7 = 0 THEN 'ABSENT' ELSE 'PRESENT' END
                    FROM students s
                    JOIN specializations sp ON s.specialization_id = sp.id
                    WHERE sp.code='IT' AND s.current_year=1
                    LIMIT 25;
                END IF;
                SET h = h + 1;
            END WHILE;
        END IF;
        SET d = d + 1;
    END WHILE;
END //
DELIMITER ;

CALL gen_attendance();
DROP PROCEDURE IF EXISTS gen_attendance;

SELECT 'Part 3 Academic Data Complete — ERP Seed DONE!' AS Status;
SELECT 'Login Credentials Summary:' AS Info;
SELECT 'IT HOD     → hod.it@college.edu     / Demo@1234' AS Creds
UNION ALL SELECT 'ECE HOD    → hod.ece@college.edu    / Demo@1234'
UNION ALL SELECT 'EEE HOD    → hod.eee@college.edu    / Demo@1234'
UNION ALL SELECT 'MECH HOD   → hod.mech@college.edu   / Demo@1234'
UNION ALL SELECT 'CIVIL HOD  → hod.civil@college.edu  / Demo@1234'
UNION ALL SELECT 'AIDS HOD   → hod.aids@college.edu   / Demo@1234'
UNION ALL SELECT 'IT Faculty → it.faculty01@college.edu / Demo@1234'
UNION ALL SELECT 'IT Advisor → it.advisor01@college.edu / Demo@1234'
UNION ALL SELECT 'Cross-dept → it.cross01@college.edu  / Demo@1234';
