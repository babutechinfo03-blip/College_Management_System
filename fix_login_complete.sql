-- ============================================================
-- COMPLETE STAFF LOGIN FIX
-- Run this SINGLE file in MySQL Workbench or phpMyAdmin
--
-- LOGIN WITH:
--   Faculty ID : STF-IT001    (IT HOD)
--   Password   : Demo@1234
-- ============================================================

-- BCrypt hash for "Demo@1234" (60 chars, cost=10)
SET @h = '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy';

-- ── VERIFY hash length (must be 60) ─────────────────────────
-- SELECT LENGTH(@h);   -- uncomment to test

-- ── Add specializations (safe to re-run) ────────────────────
INSERT IGNORE INTO specializations (degree_id, name, code)
SELECT id, 'Information Technology', 'IT'
FROM degrees WHERE code = 'BE' LIMIT 1;
INSERT IGNORE INTO specializations (degree_id, name, code)
SELECT id, 'Electronics & Communication Engg', 'ECE'
FROM degrees WHERE code = 'BE' LIMIT 1;
INSERT IGNORE INTO specializations (degree_id, name, code)
SELECT id, 'Electrical & Electronics Engg', 'EEE'
FROM degrees WHERE code = 'BE' LIMIT 1;
INSERT IGNORE INTO specializations (degree_id, name, code)
SELECT id, 'Mechanical Engineering', 'MECH'
FROM degrees WHERE code = 'BE' LIMIT 1;
INSERT IGNORE INTO specializations (degree_id, name, code)
SELECT id, 'Civil Engineering', 'CIVIL'
FROM degrees WHERE code = 'BE' LIMIT 1;
INSERT IGNORE INTO specializations (degree_id, name, code)
SELECT id, 'Artificial Intelligence & Data Science', 'AIDS'
FROM degrees WHERE code = 'BE' LIMIT 1;

-- ============================================================
-- INSERT IT HOD
-- ============================================================
INSERT INTO users (username, password, visible_password, email, role, is_active, created_at)
VALUES ('STF_IT_HOD', @h, 'Demo@1234', 'hod.it@college.edu', 'HOD', 1, NOW())
ON DUPLICATE KEY UPDATE password = @h, visible_password = 'Demo@1234', is_active = 1;
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, dob, blood_group, is_active)
VALUES (@uid, 'STF-IT001', 'Dr. Ramesh', 'Pandi',
    (SELECT id FROM departments WHERE code='IT' LIMIT 1),
    'Professor & HOD', '8500000010', '8500000010', '1972-04-15', 'O+', 1);
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'HOD');
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');

-- ============================================================
-- INSERT IT FACULTY
-- ============================================================
INSERT INTO users (username, password, visible_password, email, role, is_active, created_at)
VALUES ('STF_IT_F01', @h, 'Demo@1234', 'it.faculty01@college.edu', 'FACULTY', 1, NOW())
ON DUPLICATE KEY UPDATE password = @h, visible_password = 'Demo@1234';
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, dob, blood_group, is_active)
VALUES (@uid, 'STF-IT002', 'Priya', 'Shankar', (SELECT id FROM departments WHERE code='IT' LIMIT 1), 'Assistant Professor', '8500000011', '8500000011', '1985-08-20', 'A+', 1);
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');

INSERT INTO users (username, password, visible_password, email, role, is_active, created_at)
VALUES ('STF_IT_F02', @h, 'Demo@1234', 'it.faculty02@college.edu', 'FACULTY', 1, NOW())
ON DUPLICATE KEY UPDATE password = @h, visible_password = 'Demo@1234';
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, dob, blood_group, is_active)
VALUES (@uid, 'STF-IT003', 'Vijay', 'Kumar', (SELECT id FROM departments WHERE code='IT' LIMIT 1), 'Associate Professor', '8500000012', '8500000012', '1980-03-10', 'B+', 1);
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');

-- IT Class Advisor
INSERT INTO users (username, password, visible_password, email, role, is_active, created_at)
VALUES ('STF_IT_CA01', @h, 'Demo@1234', 'it.advisor01@college.edu', 'ADVISOR', 1, NOW())
ON DUPLICATE KEY UPDATE password = @h, visible_password = 'Demo@1234';
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, dob, blood_group, is_active)
VALUES (@uid, 'STF-IT004', 'Anitha', 'Rajendran', (SELECT id FROM departments WHERE code='IT' LIMIT 1), 'Assistant Professor', '8500000013', '8500000013', '1988-11-25', 'O-', 1);
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'CLASS_ADVISOR');

-- ============================================================
-- INSERT ECE HOD
-- ============================================================
INSERT INTO users (username, password, visible_password, email, role, is_active, created_at)
VALUES ('STF_ECE_HOD', @h, 'Demo@1234', 'hod.ece@college.edu', 'HOD', 1, NOW())
ON DUPLICATE KEY UPDATE password = @h, visible_password = 'Demo@1234', is_active = 1;
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, dob, blood_group, is_active)
VALUES (@uid, 'STF-ECE001', 'Dr. Saravanan', 'Pillai', (SELECT id FROM departments WHERE code='ECE' LIMIT 1), 'Professor & HOD', '8500000020', '8500000020', '1970-12-01', 'A+', 1);
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'HOD');
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');

-- ============================================================
-- INSERT EEE HOD
-- ============================================================
INSERT INTO users (username, password, visible_password, email, role, is_active, created_at)
VALUES ('STF_EEE_HOD', @h, 'Demo@1234', 'hod.eee@college.edu', 'HOD', 1, NOW())
ON DUPLICATE KEY UPDATE password = @h, visible_password = 'Demo@1234', is_active = 1;
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, dob, blood_group, is_active)
VALUES (@uid, 'STF-EEE001', 'Dr. Padmanabhan', 'Iyer', (SELECT id FROM departments WHERE code='EEE' LIMIT 1), 'Professor & HOD', '8500000030', '8500000030', '1969-08-28', 'A+', 1);
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'HOD');
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');

-- ============================================================
-- INSERT MECH HOD
-- ============================================================
INSERT INTO users (username, password, visible_password, email, role, is_active, created_at)
VALUES ('STF_MECH_HOD', @h, 'Demo@1234', 'hod.mech@college.edu', 'HOD', 1, NOW())
ON DUPLICATE KEY UPDATE password = @h, visible_password = 'Demo@1234', is_active = 1;
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, dob, blood_group, is_active)
VALUES (@uid, 'STF-MECH001', 'Dr. Balasubramanian', 'S', (SELECT id FROM departments WHERE code='MECH' LIMIT 1), 'Professor & HOD', '8500000040', '8500000040', '1968-03-17', 'O+', 1);
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'HOD');
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');

-- ============================================================
-- INSERT CIVIL HOD
-- ============================================================
INSERT INTO users (username, password, visible_password, email, role, is_active, created_at)
VALUES ('STF_CIVIL_HOD', @h, 'Demo@1234', 'hod.civil@college.edu', 'HOD', 1, NOW())
ON DUPLICATE KEY UPDATE password = @h, visible_password = 'Demo@1234', is_active = 1;
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, dob, blood_group, is_active)
VALUES (@uid, 'STF-CIV001', 'Dr. Jeyagowri', 'P', (SELECT id FROM departments WHERE code='CIVIL' LIMIT 1), 'Professor & HOD', '8500000050', '8500000050', '1971-06-22', 'B+', 1);
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'HOD');
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');

-- ============================================================
-- INSERT AIDS HOD
-- ============================================================
INSERT INTO users (username, password, visible_password, email, role, is_active, created_at)
VALUES ('STF_AIDS_HOD', @h, 'Demo@1234', 'hod.aids@college.edu', 'HOD', 1, NOW())
ON DUPLICATE KEY UPDATE password = @h, visible_password = 'Demo@1234', is_active = 1;
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, dob, blood_group, is_active)
VALUES (@uid, 'STF-AIDS001', 'Dr. Mythili', 'Krishnan', (SELECT id FROM departments WHERE code='AIDS' LIMIT 1), 'Professor & HOD', '8500000060', '8500000060', '1973-11-30', 'AB+', 1);
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'HOD');
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');

-- ============================================================
-- FIX ALL EXISTING STAFF PASSWORDS (in case seed_part1 was run before)
-- ============================================================
UPDATE users
SET password = @h, visible_password = 'Demo@1234'
WHERE role IN ('HOD', 'FACULTY', 'ADVISOR', 'ASSISTANT_STAFF');

-- ============================================================
-- VERIFY — Should show all staff with hash_len = 60
-- ============================================================
SELECT staff_id, first_name, u.role,
       u.email,
       LENGTH(u.password) AS hash_len,
       u.visible_password AS pass_hint
FROM faculty f
JOIN users u ON u.id = f.user_id
ORDER BY u.role, staff_id;
