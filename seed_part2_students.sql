-- ============================================================
-- ERP FULL SEED — PART 2: STUDENTS (all non-CSE departments)
-- IT, ECE, EEE, MECH, CIVIL, AIDS — 25 students/year/dept
-- Uses stored procedure for compact generation
-- Run AFTER seed_part1_staff.sql
-- ============================================================

DROP PROCEDURE IF EXISTS gen_dept_students;
DELIMITER //
CREATE PROCEDURE gen_dept_students(
    IN spec_code   VARCHAR(10),
    IN yr          INT,
    IN sem         INT,
    IN batch_str   VARCHAR(9),
    IN id_prefix   VARCHAR(15),
    IN phone_base  BIGINT
)
BEGIN
    DECLARE i    INT DEFAULT 1;
    DECLARE pass VARCHAR(200) DEFAULT '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy';
    DECLARE uname  VARCHAR(50);
    DECLARE em     VARCHAR(100);
    DECLARE sid    VARCHAR(20);
    DECLARE ph     VARCHAR(15);
    DECLARE pph    VARCHAR(15);
    DECLARE fn     VARCHAR(50);
    DECLARE ln     VARCHAR(50);
    DECLARE bg     VARCHAR(5);
    DECLARE rel    VARCHAR(20);
    DECLARE cas    VARCHAR(10);
    DECLARE dob_v  VARCHAR(15);

    WHILE i <= 25 DO
        SET uname = CONCAT(id_prefix, LPAD(i, 3, '0'));
        SET em    = CONCAT(LOWER(id_prefix), LPAD(i, 3, '0'), '@college.edu');
        SET sid   = uname;
        SET ph    = CAST(phone_base + i AS CHAR);
        SET pph   = CAST(phone_base + i + 50000 AS CHAR);

        SET fn = ELT(1 + (i MOD 15),
            'Arjun','Priya','Karthik','Meena','Rajan','Lakshmi','Arun',
            'Deepa','Suresh','Kavitha','Vijay','Mani','Sundar','Anitha','Mohan');
        SET ln = ELT(1 + (i MOD 10),
            'Kumar','Devi','Raj','Pillai','Nair','Iyer','Murugan','Selvam','Rajan','Krishnan');
        SET bg  = ELT(1 + (i MOD 6), 'O+','A+','B+','AB+','O-','A-');
        SET rel = ELT(1 + (i MOD 3), 'Hindu','Christian','Muslim');
        SET cas = ELT(1 + (i MOD 4), 'BC','MBC','OC','SC');
        SET dob_v = CONCAT('200', 1 + (i MOD 5), '-',
                           LPAD(1 + (i MOD 12), 2, '0'), '-',
                           LPAD(1 + (i MOD 28), 2, '0'));

        INSERT INTO users (username, password, email, role, is_active, created_at)
        VALUES (uname, pass, em, 'STUDENT', 1, NOW())
        ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);

        INSERT IGNORE INTO students
            (user_id, student_id, first_name, last_name,
             degree_id, specialization_id,
             current_year, current_semester, batch,
             address, phone, whatsapp_number,
             blood_group, religion, caste, dob,
             parent_name, parent_mobile, is_active)
        SELECT
            LAST_INSERT_ID(), sid, fn, ln,
            (SELECT id FROM degrees        WHERE code = 'BE'       LIMIT 1),
            (SELECT id FROM specializations WHERE code = spec_code LIMIT 1),
            yr, sem, batch_str,
            'Tamil Nadu, India', ph, ph,
            bg, rel, cas, dob_v,
            CONCAT('Parent of ', fn), pph,
            1;

        SET i = i + 1;
    END WHILE;
END //
DELIMITER ;

-- ── IT Department ──────────────────────────────────────────
CALL gen_dept_students('IT', 1, 2, '2025-2029', '2025IT', 9200000000);
CALL gen_dept_students('IT', 2, 4, '2024-2028', '2024IT', 9200000025);
CALL gen_dept_students('IT', 3, 6, '2023-2027', '2023IT', 9200000050);
CALL gen_dept_students('IT', 4, 8, '2022-2026', '2022IT', 9200000075);

-- ── ECE Department ─────────────────────────────────────────
CALL gen_dept_students('ECE', 1, 2, '2025-2029', '2025ECE', 9300000000);
CALL gen_dept_students('ECE', 2, 4, '2024-2028', '2024ECE', 9300000025);
CALL gen_dept_students('ECE', 3, 6, '2023-2027', '2023ECE', 9300000050);
CALL gen_dept_students('ECE', 4, 8, '2022-2026', '2022ECE', 9300000075);

-- ── EEE Department ─────────────────────────────────────────
CALL gen_dept_students('EEE', 1, 2, '2025-2029', '2025EEE', 9400000000);
CALL gen_dept_students('EEE', 2, 4, '2024-2028', '2024EEE', 9400000025);
CALL gen_dept_students('EEE', 3, 6, '2023-2027', '2023EEE', 9400000050);
CALL gen_dept_students('EEE', 4, 8, '2022-2026', '2022EEE', 9400000075);

-- ── MECH Department ────────────────────────────────────────
CALL gen_dept_students('MECH', 1, 2, '2025-2029', '2025MECH', 9500000000);
CALL gen_dept_students('MECH', 2, 4, '2024-2028', '2024MECH', 9500000025);
CALL gen_dept_students('MECH', 3, 6, '2023-2027', '2023MECH', 9500000050);
CALL gen_dept_students('MECH', 4, 8, '2022-2026', '2022MECH', 9500000075);

-- ── CIVIL Department ───────────────────────────────────────
CALL gen_dept_students('CIVIL', 1, 2, '2025-2029', '2025CIVIL', 9600000000);
CALL gen_dept_students('CIVIL', 2, 4, '2024-2028', '2024CIVIL', 9600000025);
CALL gen_dept_students('CIVIL', 3, 6, '2023-2027', '2023CIVIL', 9600000050);
CALL gen_dept_students('CIVIL', 4, 8, '2022-2026', '2022CIVIL', 9600000075);

-- ── AIDS Department ────────────────────────────────────────
CALL gen_dept_students('AIDS', 1, 2, '2025-2029', '2025AIDS', 9700000000);
CALL gen_dept_students('AIDS', 2, 4, '2024-2028', '2024AIDS', 9700000025);
CALL gen_dept_students('AIDS', 3, 6, '2023-2027', '2023AIDS', 9700000050);
CALL gen_dept_students('AIDS', 4, 8, '2022-2026', '2022AIDS', 9700000075);

DROP PROCEDURE IF EXISTS gen_dept_students;

SELECT 'Part 2 Students Complete — Next run seed_part3_academic.sql' AS Status;
