SELECT 'Starting Import...' as DebugMessage;
-- DUMMY DATA INSERTS
-- Encoded Password: 'password'
SET @default_pass = '$2a$10$eAccYoNOHEqXve8aIWT8Nu3.hD.S.yveD..p/';
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE001', @default_pass, '2025cse001@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE001', 'Student', '001',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000000', '9000000000', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE002', @default_pass, '2025cse002@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE002', 'Student', '002',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000001', '9000000001', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE003', @default_pass, '2025cse003@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE003', 'Student', '003',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000002', '9000000002', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE004', @default_pass, '2025cse004@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE004', 'Student', '004',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000003', '9000000003', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE005', @default_pass, '2025cse005@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE005', 'Student', '005',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000004', '9000000004', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE006', @default_pass, '2025cse006@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE006', 'Student', '006',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000005', '9000000005', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE007', @default_pass, '2025cse007@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE007', 'Student', '007',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000006', '9000000006', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE008', @default_pass, '2025cse008@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE008', 'Student', '008',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000007', '9000000007', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE009', @default_pass, '2025cse009@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE009', 'Student', '009',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000008', '9000000008', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE010', @default_pass, '2025cse010@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE010', 'Student', '010',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000009', '9000000009', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE011', @default_pass, '2025cse011@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE011', 'Student', '011',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000010', '9000000010', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE012', @default_pass, '2025cse012@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE012', 'Student', '012',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000011', '9000000011', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE013', @default_pass, '2025cse013@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE013', 'Student', '013',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000012', '9000000012', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE014', @default_pass, '2025cse014@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE014', 'Student', '014',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000013', '9000000013', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE015', @default_pass, '2025cse015@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE015', 'Student', '015',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000014', '9000000014', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE016', @default_pass, '2025cse016@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE016', 'Student', '016',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000015', '9000000015', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE017', @default_pass, '2025cse017@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE017', 'Student', '017',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000016', '9000000016', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE018', @default_pass, '2025cse018@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE018', 'Student', '018',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000017', '9000000017', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE019', @default_pass, '2025cse019@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE019', 'Student', '019',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000018', '9000000018', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE020', @default_pass, '2025cse020@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE020', 'Student', '020',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000019', '9000000019', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE021', @default_pass, '2025cse021@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE021', 'Student', '021',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000020', '9000000020', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE022', @default_pass, '2025cse022@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE022', 'Student', '022',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000021', '9000000021', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE023', @default_pass, '2025cse023@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE023', 'Student', '023',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000022', '9000000022', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE024', @default_pass, '2025cse024@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE024', 'Student', '024',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000023', '9000000023', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE025', @default_pass, '2025cse025@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE025', 'Student', '025',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000024', '9000000024', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE026', @default_pass, '2025cse026@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE026', 'Student', '026',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000025', '9000000025', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE027', @default_pass, '2025cse027@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE027', 'Student', '027',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000026', '9000000026', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE028', @default_pass, '2025cse028@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE028', 'Student', '028',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000027', '9000000027', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE029', @default_pass, '2025cse029@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE029', 'Student', '029',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000028', '9000000028', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE030', @default_pass, '2025cse030@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE030', 'Student', '030',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000029', '9000000029', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE031', @default_pass, '2025cse031@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE031', 'Student', '031',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000030', '9000000030', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE032', @default_pass, '2025cse032@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE032', 'Student', '032',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000031', '9000000031', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE033', @default_pass, '2025cse033@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE033', 'Student', '033',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000032', '9000000032', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE034', @default_pass, '2025cse034@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE034', 'Student', '034',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000033', '9000000033', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE035', @default_pass, '2025cse035@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE035', 'Student', '035',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000034', '9000000034', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE036', @default_pass, '2025cse036@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE036', 'Student', '036',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000035', '9000000035', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE037', @default_pass, '2025cse037@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE037', 'Student', '037',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000036', '9000000036', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE038', @default_pass, '2025cse038@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE038', 'Student', '038',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000037', '9000000037', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE039', @default_pass, '2025cse039@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE039', 'Student', '039',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000038', '9000000038', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE040', @default_pass, '2025cse040@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE040', 'Student', '040',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000039', '9000000039', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE041', @default_pass, '2025cse041@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE041', 'Student', '041',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000040', '9000000040', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE042', @default_pass, '2025cse042@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE042', 'Student', '042',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000041', '9000000041', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE043', @default_pass, '2025cse043@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE043', 'Student', '043',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000042', '9000000042', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE044', @default_pass, '2025cse044@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE044', 'Student', '044',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000043', '9000000043', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE045', @default_pass, '2025cse045@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE045', 'Student', '045',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000044', '9000000044', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE046', @default_pass, '2025cse046@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE046', 'Student', '046',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000045', '9000000045', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE047', @default_pass, '2025cse047@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE047', 'Student', '047',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000046', '9000000046', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE048', @default_pass, '2025cse048@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE048', 'Student', '048',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000047', '9000000047', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE049', @default_pass, '2025cse049@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE049', 'Student', '049',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000048', '9000000048', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025CSE050', @default_pass, '2025cse050@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025CSE050', 'Student', '050',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000049', '9000000049', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE001', @default_pass, '2024cse001@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE001', 'Student', '001',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000050', '9000000050', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE002', @default_pass, '2024cse002@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE002', 'Student', '002',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000051', '9000000051', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE003', @default_pass, '2024cse003@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE003', 'Student', '003',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000052', '9000000052', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE004', @default_pass, '2024cse004@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE004', 'Student', '004',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000053', '9000000053', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE005', @default_pass, '2024cse005@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE005', 'Student', '005',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000054', '9000000054', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE006', @default_pass, '2024cse006@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE006', 'Student', '006',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000055', '9000000055', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE007', @default_pass, '2024cse007@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE007', 'Student', '007',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000056', '9000000056', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE008', @default_pass, '2024cse008@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE008', 'Student', '008',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000057', '9000000057', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE009', @default_pass, '2024cse009@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE009', 'Student', '009',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000058', '9000000058', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE010', @default_pass, '2024cse010@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE010', 'Student', '010',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000059', '9000000059', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE011', @default_pass, '2024cse011@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE011', 'Student', '011',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000060', '9000000060', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE012', @default_pass, '2024cse012@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE012', 'Student', '012',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000061', '9000000061', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE013', @default_pass, '2024cse013@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE013', 'Student', '013',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000062', '9000000062', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE014', @default_pass, '2024cse014@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE014', 'Student', '014',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000063', '9000000063', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE015', @default_pass, '2024cse015@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE015', 'Student', '015',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000064', '9000000064', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE016', @default_pass, '2024cse016@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE016', 'Student', '016',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000065', '9000000065', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE017', @default_pass, '2024cse017@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE017', 'Student', '017',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000066', '9000000066', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE018', @default_pass, '2024cse018@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE018', 'Student', '018',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000067', '9000000067', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE019', @default_pass, '2024cse019@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE019', 'Student', '019',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000068', '9000000068', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE020', @default_pass, '2024cse020@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE020', 'Student', '020',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000069', '9000000069', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE021', @default_pass, '2024cse021@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE021', 'Student', '021',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000070', '9000000070', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE022', @default_pass, '2024cse022@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE022', 'Student', '022',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000071', '9000000071', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE023', @default_pass, '2024cse023@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE023', 'Student', '023',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000072', '9000000072', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE024', @default_pass, '2024cse024@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE024', 'Student', '024',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000073', '9000000073', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE025', @default_pass, '2024cse025@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE025', 'Student', '025',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000074', '9000000074', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE026', @default_pass, '2024cse026@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE026', 'Student', '026',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000075', '9000000075', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE027', @default_pass, '2024cse027@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE027', 'Student', '027',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000076', '9000000076', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE028', @default_pass, '2024cse028@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE028', 'Student', '028',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000077', '9000000077', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE029', @default_pass, '2024cse029@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE029', 'Student', '029',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000078', '9000000078', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE030', @default_pass, '2024cse030@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE030', 'Student', '030',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000079', '9000000079', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE031', @default_pass, '2024cse031@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE031', 'Student', '031',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000080', '9000000080', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE032', @default_pass, '2024cse032@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE032', 'Student', '032',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000081', '9000000081', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE033', @default_pass, '2024cse033@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE033', 'Student', '033',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000082', '9000000082', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE034', @default_pass, '2024cse034@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE034', 'Student', '034',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000083', '9000000083', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE035', @default_pass, '2024cse035@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE035', 'Student', '035',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000084', '9000000084', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE036', @default_pass, '2024cse036@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE036', 'Student', '036',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000085', '9000000085', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE037', @default_pass, '2024cse037@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE037', 'Student', '037',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000086', '9000000086', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE038', @default_pass, '2024cse038@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE038', 'Student', '038',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000087', '9000000087', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE039', @default_pass, '2024cse039@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE039', 'Student', '039',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000088', '9000000088', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE040', @default_pass, '2024cse040@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE040', 'Student', '040',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000089', '9000000089', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE041', @default_pass, '2024cse041@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE041', 'Student', '041',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000090', '9000000090', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE042', @default_pass, '2024cse042@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE042', 'Student', '042',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000091', '9000000091', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE043', @default_pass, '2024cse043@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE043', 'Student', '043',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000092', '9000000092', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE044', @default_pass, '2024cse044@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE044', 'Student', '044',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000093', '9000000093', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE045', @default_pass, '2024cse045@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE045', 'Student', '045',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000094', '9000000094', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE046', @default_pass, '2024cse046@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE046', 'Student', '046',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000095', '9000000095', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE047', @default_pass, '2024cse047@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE047', 'Student', '047',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000096', '9000000096', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE048', @default_pass, '2024cse048@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE048', 'Student', '048',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000097', '9000000097', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE049', @default_pass, '2024cse049@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE049', 'Student', '049',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000098', '9000000098', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024CSE050', @default_pass, '2024cse050@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024CSE050', 'Student', '050',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000099', '9000000099', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE001', @default_pass, '2023cse001@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE001', 'Student', '001',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000100', '9000000100', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE002', @default_pass, '2023cse002@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE002', 'Student', '002',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000101', '9000000101', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE003', @default_pass, '2023cse003@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE003', 'Student', '003',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000102', '9000000102', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE004', @default_pass, '2023cse004@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE004', 'Student', '004',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000103', '9000000103', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE005', @default_pass, '2023cse005@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE005', 'Student', '005',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000104', '9000000104', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE006', @default_pass, '2023cse006@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE006', 'Student', '006',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000105', '9000000105', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE007', @default_pass, '2023cse007@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE007', 'Student', '007',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000106', '9000000106', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE008', @default_pass, '2023cse008@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE008', 'Student', '008',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000107', '9000000107', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE009', @default_pass, '2023cse009@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE009', 'Student', '009',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000108', '9000000108', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE010', @default_pass, '2023cse010@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE010', 'Student', '010',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000109', '9000000109', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE011', @default_pass, '2023cse011@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE011', 'Student', '011',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000110', '9000000110', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE012', @default_pass, '2023cse012@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE012', 'Student', '012',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000111', '9000000111', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE013', @default_pass, '2023cse013@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE013', 'Student', '013',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000112', '9000000112', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE014', @default_pass, '2023cse014@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE014', 'Student', '014',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000113', '9000000113', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE015', @default_pass, '2023cse015@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE015', 'Student', '015',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000114', '9000000114', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE016', @default_pass, '2023cse016@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE016', 'Student', '016',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000115', '9000000115', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE017', @default_pass, '2023cse017@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE017', 'Student', '017',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000116', '9000000116', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE018', @default_pass, '2023cse018@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE018', 'Student', '018',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000117', '9000000117', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE019', @default_pass, '2023cse019@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE019', 'Student', '019',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000118', '9000000118', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE020', @default_pass, '2023cse020@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE020', 'Student', '020',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000119', '9000000119', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE021', @default_pass, '2023cse021@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE021', 'Student', '021',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000120', '9000000120', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE022', @default_pass, '2023cse022@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE022', 'Student', '022',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000121', '9000000121', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE023', @default_pass, '2023cse023@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE023', 'Student', '023',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000122', '9000000122', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE024', @default_pass, '2023cse024@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE024', 'Student', '024',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000123', '9000000123', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE025', @default_pass, '2023cse025@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE025', 'Student', '025',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000124', '9000000124', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE026', @default_pass, '2023cse026@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE026', 'Student', '026',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000125', '9000000125', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE027', @default_pass, '2023cse027@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE027', 'Student', '027',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000126', '9000000126', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE028', @default_pass, '2023cse028@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE028', 'Student', '028',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000127', '9000000127', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE029', @default_pass, '2023cse029@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE029', 'Student', '029',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000128', '9000000128', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE030', @default_pass, '2023cse030@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE030', 'Student', '030',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000129', '9000000129', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE031', @default_pass, '2023cse031@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE031', 'Student', '031',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000130', '9000000130', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE032', @default_pass, '2023cse032@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE032', 'Student', '032',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000131', '9000000131', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE033', @default_pass, '2023cse033@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE033', 'Student', '033',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000132', '9000000132', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE034', @default_pass, '2023cse034@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE034', 'Student', '034',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000133', '9000000133', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE035', @default_pass, '2023cse035@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE035', 'Student', '035',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000134', '9000000134', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE036', @default_pass, '2023cse036@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE036', 'Student', '036',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000135', '9000000135', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE037', @default_pass, '2023cse037@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE037', 'Student', '037',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000136', '9000000136', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE038', @default_pass, '2023cse038@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE038', 'Student', '038',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000137', '9000000137', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE039', @default_pass, '2023cse039@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE039', 'Student', '039',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000138', '9000000138', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE040', @default_pass, '2023cse040@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE040', 'Student', '040',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000139', '9000000139', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE041', @default_pass, '2023cse041@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE041', 'Student', '041',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000140', '9000000140', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE042', @default_pass, '2023cse042@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE042', 'Student', '042',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000141', '9000000141', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE043', @default_pass, '2023cse043@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE043', 'Student', '043',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000142', '9000000142', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE044', @default_pass, '2023cse044@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE044', 'Student', '044',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000143', '9000000143', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE045', @default_pass, '2023cse045@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE045', 'Student', '045',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000144', '9000000144', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE046', @default_pass, '2023cse046@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE046', 'Student', '046',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000145', '9000000145', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE047', @default_pass, '2023cse047@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE047', 'Student', '047',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000146', '9000000146', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE048', @default_pass, '2023cse048@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE048', 'Student', '048',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000147', '9000000147', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE049', @default_pass, '2023cse049@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE049', 'Student', '049',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000148', '9000000148', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023CSE050', @default_pass, '2023cse050@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023CSE050', 'Student', '050',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000149', '9000000149', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE001', @default_pass, '2022cse001@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE001', 'Student', '001',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000150', '9000000150', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE002', @default_pass, '2022cse002@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE002', 'Student', '002',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000151', '9000000151', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE003', @default_pass, '2022cse003@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE003', 'Student', '003',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000152', '9000000152', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE004', @default_pass, '2022cse004@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE004', 'Student', '004',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000153', '9000000153', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE005', @default_pass, '2022cse005@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE005', 'Student', '005',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000154', '9000000154', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE006', @default_pass, '2022cse006@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE006', 'Student', '006',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000155', '9000000155', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE007', @default_pass, '2022cse007@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE007', 'Student', '007',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000156', '9000000156', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE008', @default_pass, '2022cse008@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE008', 'Student', '008',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000157', '9000000157', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE009', @default_pass, '2022cse009@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE009', 'Student', '009',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000158', '9000000158', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE010', @default_pass, '2022cse010@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE010', 'Student', '010',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000159', '9000000159', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE011', @default_pass, '2022cse011@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE011', 'Student', '011',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000160', '9000000160', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE012', @default_pass, '2022cse012@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE012', 'Student', '012',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000161', '9000000161', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE013', @default_pass, '2022cse013@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE013', 'Student', '013',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000162', '9000000162', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE014', @default_pass, '2022cse014@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE014', 'Student', '014',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000163', '9000000163', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE015', @default_pass, '2022cse015@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE015', 'Student', '015',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000164', '9000000164', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE016', @default_pass, '2022cse016@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE016', 'Student', '016',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000165', '9000000165', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE017', @default_pass, '2022cse017@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE017', 'Student', '017',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000166', '9000000166', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE018', @default_pass, '2022cse018@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE018', 'Student', '018',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000167', '9000000167', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE019', @default_pass, '2022cse019@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE019', 'Student', '019',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000168', '9000000168', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE020', @default_pass, '2022cse020@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE020', 'Student', '020',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000169', '9000000169', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE021', @default_pass, '2022cse021@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE021', 'Student', '021',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000170', '9000000170', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE022', @default_pass, '2022cse022@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE022', 'Student', '022',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000171', '9000000171', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE023', @default_pass, '2022cse023@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE023', 'Student', '023',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000172', '9000000172', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE024', @default_pass, '2022cse024@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE024', 'Student', '024',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000173', '9000000173', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE025', @default_pass, '2022cse025@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE025', 'Student', '025',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000174', '9000000174', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE026', @default_pass, '2022cse026@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE026', 'Student', '026',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000175', '9000000175', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE027', @default_pass, '2022cse027@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE027', 'Student', '027',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000176', '9000000176', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE028', @default_pass, '2022cse028@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE028', 'Student', '028',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000177', '9000000177', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE029', @default_pass, '2022cse029@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE029', 'Student', '029',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000178', '9000000178', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE030', @default_pass, '2022cse030@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE030', 'Student', '030',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000179', '9000000179', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE031', @default_pass, '2022cse031@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE031', 'Student', '031',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000180', '9000000180', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE032', @default_pass, '2022cse032@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE032', 'Student', '032',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000181', '9000000181', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE033', @default_pass, '2022cse033@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE033', 'Student', '033',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000182', '9000000182', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE034', @default_pass, '2022cse034@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE034', 'Student', '034',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000183', '9000000183', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE035', @default_pass, '2022cse035@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE035', 'Student', '035',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000184', '9000000184', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE036', @default_pass, '2022cse036@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE036', 'Student', '036',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000185', '9000000185', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE037', @default_pass, '2022cse037@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE037', 'Student', '037',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000186', '9000000186', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE038', @default_pass, '2022cse038@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE038', 'Student', '038',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000187', '9000000187', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE039', @default_pass, '2022cse039@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE039', 'Student', '039',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000188', '9000000188', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE040', @default_pass, '2022cse040@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE040', 'Student', '040',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000189', '9000000189', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE041', @default_pass, '2022cse041@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE041', 'Student', '041',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000190', '9000000190', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE042', @default_pass, '2022cse042@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE042', 'Student', '042',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000191', '9000000191', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE043', @default_pass, '2022cse043@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE043', 'Student', '043',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000192', '9000000192', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE044', @default_pass, '2022cse044@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE044', 'Student', '044',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000193', '9000000193', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE045', @default_pass, '2022cse045@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE045', 'Student', '045',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000194', '9000000194', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE046', @default_pass, '2022cse046@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE046', 'Student', '046',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000195', '9000000195', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE047', @default_pass, '2022cse047@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE047', 'Student', '047',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000196', '9000000196', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE048', @default_pass, '2022cse048@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE048', 'Student', '048',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000197', '9000000197', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE049', @default_pass, '2022cse049@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE049', 'Student', '049',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000198', '9000000198', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022CSE050', @default_pass, '2022cse050@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022CSE050', 'Student', '050',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='CSE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000199', '9000000199', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE001', @default_pass, '2025ece001@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE001', 'Student', '001',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000200', '9000000200', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE002', @default_pass, '2025ece002@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE002', 'Student', '002',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000201', '9000000201', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE003', @default_pass, '2025ece003@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE003', 'Student', '003',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000202', '9000000202', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE004', @default_pass, '2025ece004@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE004', 'Student', '004',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000203', '9000000203', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE005', @default_pass, '2025ece005@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE005', 'Student', '005',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000204', '9000000204', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE006', @default_pass, '2025ece006@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE006', 'Student', '006',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000205', '9000000205', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE007', @default_pass, '2025ece007@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE007', 'Student', '007',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000206', '9000000206', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE008', @default_pass, '2025ece008@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE008', 'Student', '008',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000207', '9000000207', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE009', @default_pass, '2025ece009@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE009', 'Student', '009',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000208', '9000000208', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE010', @default_pass, '2025ece010@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE010', 'Student', '010',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000209', '9000000209', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE011', @default_pass, '2025ece011@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE011', 'Student', '011',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000210', '9000000210', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE012', @default_pass, '2025ece012@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE012', 'Student', '012',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000211', '9000000211', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE013', @default_pass, '2025ece013@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE013', 'Student', '013',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000212', '9000000212', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE014', @default_pass, '2025ece014@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE014', 'Student', '014',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000213', '9000000213', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE015', @default_pass, '2025ece015@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE015', 'Student', '015',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000214', '9000000214', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE016', @default_pass, '2025ece016@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE016', 'Student', '016',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000215', '9000000215', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE017', @default_pass, '2025ece017@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE017', 'Student', '017',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000216', '9000000216', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE018', @default_pass, '2025ece018@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE018', 'Student', '018',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000217', '9000000217', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE019', @default_pass, '2025ece019@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE019', 'Student', '019',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000218', '9000000218', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE020', @default_pass, '2025ece020@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE020', 'Student', '020',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000219', '9000000219', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE021', @default_pass, '2025ece021@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE021', 'Student', '021',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000220', '9000000220', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE022', @default_pass, '2025ece022@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE022', 'Student', '022',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000221', '9000000221', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE023', @default_pass, '2025ece023@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE023', 'Student', '023',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000222', '9000000222', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE024', @default_pass, '2025ece024@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE024', 'Student', '024',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000223', '9000000223', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE025', @default_pass, '2025ece025@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE025', 'Student', '025',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000224', '9000000224', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE026', @default_pass, '2025ece026@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE026', 'Student', '026',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000225', '9000000225', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE027', @default_pass, '2025ece027@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE027', 'Student', '027',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000226', '9000000226', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE028', @default_pass, '2025ece028@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE028', 'Student', '028',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000227', '9000000227', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE029', @default_pass, '2025ece029@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE029', 'Student', '029',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000228', '9000000228', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE030', @default_pass, '2025ece030@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE030', 'Student', '030',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000229', '9000000229', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE031', @default_pass, '2025ece031@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE031', 'Student', '031',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000230', '9000000230', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE032', @default_pass, '2025ece032@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE032', 'Student', '032',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000231', '9000000231', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE033', @default_pass, '2025ece033@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE033', 'Student', '033',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000232', '9000000232', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE034', @default_pass, '2025ece034@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE034', 'Student', '034',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000233', '9000000233', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE035', @default_pass, '2025ece035@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE035', 'Student', '035',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000234', '9000000234', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE036', @default_pass, '2025ece036@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE036', 'Student', '036',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000235', '9000000235', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE037', @default_pass, '2025ece037@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE037', 'Student', '037',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000236', '9000000236', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE038', @default_pass, '2025ece038@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE038', 'Student', '038',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000237', '9000000237', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE039', @default_pass, '2025ece039@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE039', 'Student', '039',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000238', '9000000238', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE040', @default_pass, '2025ece040@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE040', 'Student', '040',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000239', '9000000239', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE041', @default_pass, '2025ece041@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE041', 'Student', '041',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000240', '9000000240', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE042', @default_pass, '2025ece042@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE042', 'Student', '042',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000241', '9000000241', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE043', @default_pass, '2025ece043@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE043', 'Student', '043',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000242', '9000000242', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE044', @default_pass, '2025ece044@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE044', 'Student', '044',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000243', '9000000243', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE045', @default_pass, '2025ece045@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE045', 'Student', '045',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000244', '9000000244', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE046', @default_pass, '2025ece046@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE046', 'Student', '046',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000245', '9000000245', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE047', @default_pass, '2025ece047@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE047', 'Student', '047',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000246', '9000000246', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE048', @default_pass, '2025ece048@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE048', 'Student', '048',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000247', '9000000247', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE049', @default_pass, '2025ece049@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE049', 'Student', '049',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000248', '9000000248', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025ECE050', @default_pass, '2025ece050@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025ECE050', 'Student', '050',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000249', '9000000249', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE001', @default_pass, '2024ece001@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE001', 'Student', '001',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000250', '9000000250', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE002', @default_pass, '2024ece002@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE002', 'Student', '002',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000251', '9000000251', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE003', @default_pass, '2024ece003@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE003', 'Student', '003',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000252', '9000000252', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE004', @default_pass, '2024ece004@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE004', 'Student', '004',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000253', '9000000253', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE005', @default_pass, '2024ece005@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE005', 'Student', '005',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000254', '9000000254', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE006', @default_pass, '2024ece006@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE006', 'Student', '006',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000255', '9000000255', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE007', @default_pass, '2024ece007@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE007', 'Student', '007',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000256', '9000000256', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE008', @default_pass, '2024ece008@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE008', 'Student', '008',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000257', '9000000257', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE009', @default_pass, '2024ece009@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE009', 'Student', '009',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000258', '9000000258', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE010', @default_pass, '2024ece010@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE010', 'Student', '010',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000259', '9000000259', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE011', @default_pass, '2024ece011@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE011', 'Student', '011',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000260', '9000000260', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE012', @default_pass, '2024ece012@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE012', 'Student', '012',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000261', '9000000261', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE013', @default_pass, '2024ece013@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE013', 'Student', '013',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000262', '9000000262', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE014', @default_pass, '2024ece014@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE014', 'Student', '014',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000263', '9000000263', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE015', @default_pass, '2024ece015@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE015', 'Student', '015',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000264', '9000000264', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE016', @default_pass, '2024ece016@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE016', 'Student', '016',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000265', '9000000265', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE017', @default_pass, '2024ece017@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE017', 'Student', '017',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000266', '9000000266', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE018', @default_pass, '2024ece018@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE018', 'Student', '018',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000267', '9000000267', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE019', @default_pass, '2024ece019@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE019', 'Student', '019',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000268', '9000000268', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE020', @default_pass, '2024ece020@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE020', 'Student', '020',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000269', '9000000269', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE021', @default_pass, '2024ece021@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE021', 'Student', '021',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000270', '9000000270', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE022', @default_pass, '2024ece022@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE022', 'Student', '022',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000271', '9000000271', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE023', @default_pass, '2024ece023@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE023', 'Student', '023',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000272', '9000000272', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE024', @default_pass, '2024ece024@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE024', 'Student', '024',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000273', '9000000273', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE025', @default_pass, '2024ece025@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE025', 'Student', '025',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000274', '9000000274', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE026', @default_pass, '2024ece026@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE026', 'Student', '026',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000275', '9000000275', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE027', @default_pass, '2024ece027@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE027', 'Student', '027',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000276', '9000000276', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE028', @default_pass, '2024ece028@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE028', 'Student', '028',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000277', '9000000277', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE029', @default_pass, '2024ece029@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE029', 'Student', '029',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000278', '9000000278', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE030', @default_pass, '2024ece030@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE030', 'Student', '030',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000279', '9000000279', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE031', @default_pass, '2024ece031@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE031', 'Student', '031',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000280', '9000000280', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE032', @default_pass, '2024ece032@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE032', 'Student', '032',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000281', '9000000281', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE033', @default_pass, '2024ece033@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE033', 'Student', '033',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000282', '9000000282', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE034', @default_pass, '2024ece034@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE034', 'Student', '034',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000283', '9000000283', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE035', @default_pass, '2024ece035@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE035', 'Student', '035',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000284', '9000000284', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE036', @default_pass, '2024ece036@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE036', 'Student', '036',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000285', '9000000285', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE037', @default_pass, '2024ece037@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE037', 'Student', '037',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000286', '9000000286', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE038', @default_pass, '2024ece038@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE038', 'Student', '038',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000287', '9000000287', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE039', @default_pass, '2024ece039@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE039', 'Student', '039',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000288', '9000000288', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE040', @default_pass, '2024ece040@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE040', 'Student', '040',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000289', '9000000289', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE041', @default_pass, '2024ece041@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE041', 'Student', '041',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000290', '9000000290', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE042', @default_pass, '2024ece042@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE042', 'Student', '042',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000291', '9000000291', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE043', @default_pass, '2024ece043@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE043', 'Student', '043',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000292', '9000000292', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE044', @default_pass, '2024ece044@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE044', 'Student', '044',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000293', '9000000293', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE045', @default_pass, '2024ece045@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE045', 'Student', '045',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000294', '9000000294', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE046', @default_pass, '2024ece046@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE046', 'Student', '046',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000295', '9000000295', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE047', @default_pass, '2024ece047@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE047', 'Student', '047',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000296', '9000000296', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE048', @default_pass, '2024ece048@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE048', 'Student', '048',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000297', '9000000297', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE049', @default_pass, '2024ece049@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE049', 'Student', '049',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000298', '9000000298', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024ECE050', @default_pass, '2024ece050@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024ECE050', 'Student', '050',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000299', '9000000299', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE001', @default_pass, '2023ece001@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE001', 'Student', '001',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000300', '9000000300', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE002', @default_pass, '2023ece002@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE002', 'Student', '002',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000301', '9000000301', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE003', @default_pass, '2023ece003@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE003', 'Student', '003',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000302', '9000000302', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE004', @default_pass, '2023ece004@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE004', 'Student', '004',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000303', '9000000303', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE005', @default_pass, '2023ece005@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE005', 'Student', '005',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000304', '9000000304', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE006', @default_pass, '2023ece006@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE006', 'Student', '006',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000305', '9000000305', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE007', @default_pass, '2023ece007@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE007', 'Student', '007',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000306', '9000000306', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE008', @default_pass, '2023ece008@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE008', 'Student', '008',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000307', '9000000307', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE009', @default_pass, '2023ece009@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE009', 'Student', '009',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000308', '9000000308', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE010', @default_pass, '2023ece010@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE010', 'Student', '010',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000309', '9000000309', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE011', @default_pass, '2023ece011@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE011', 'Student', '011',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000310', '9000000310', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE012', @default_pass, '2023ece012@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE012', 'Student', '012',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000311', '9000000311', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE013', @default_pass, '2023ece013@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE013', 'Student', '013',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000312', '9000000312', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE014', @default_pass, '2023ece014@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE014', 'Student', '014',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000313', '9000000313', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE015', @default_pass, '2023ece015@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE015', 'Student', '015',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000314', '9000000314', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE016', @default_pass, '2023ece016@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE016', 'Student', '016',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000315', '9000000315', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE017', @default_pass, '2023ece017@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE017', 'Student', '017',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000316', '9000000316', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE018', @default_pass, '2023ece018@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE018', 'Student', '018',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000317', '9000000317', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE019', @default_pass, '2023ece019@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE019', 'Student', '019',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000318', '9000000318', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE020', @default_pass, '2023ece020@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE020', 'Student', '020',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000319', '9000000319', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE021', @default_pass, '2023ece021@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE021', 'Student', '021',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000320', '9000000320', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE022', @default_pass, '2023ece022@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE022', 'Student', '022',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000321', '9000000321', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE023', @default_pass, '2023ece023@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE023', 'Student', '023',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000322', '9000000322', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE024', @default_pass, '2023ece024@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE024', 'Student', '024',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000323', '9000000323', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE025', @default_pass, '2023ece025@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE025', 'Student', '025',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000324', '9000000324', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE026', @default_pass, '2023ece026@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE026', 'Student', '026',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000325', '9000000325', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE027', @default_pass, '2023ece027@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE027', 'Student', '027',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000326', '9000000326', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE028', @default_pass, '2023ece028@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE028', 'Student', '028',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000327', '9000000327', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE029', @default_pass, '2023ece029@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE029', 'Student', '029',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000328', '9000000328', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE030', @default_pass, '2023ece030@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE030', 'Student', '030',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000329', '9000000329', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE031', @default_pass, '2023ece031@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE031', 'Student', '031',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000330', '9000000330', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE032', @default_pass, '2023ece032@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE032', 'Student', '032',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000331', '9000000331', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE033', @default_pass, '2023ece033@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE033', 'Student', '033',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000332', '9000000332', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE034', @default_pass, '2023ece034@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE034', 'Student', '034',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000333', '9000000333', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE035', @default_pass, '2023ece035@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE035', 'Student', '035',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000334', '9000000334', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE036', @default_pass, '2023ece036@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE036', 'Student', '036',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000335', '9000000335', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE037', @default_pass, '2023ece037@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE037', 'Student', '037',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000336', '9000000336', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE038', @default_pass, '2023ece038@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE038', 'Student', '038',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000337', '9000000337', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE039', @default_pass, '2023ece039@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE039', 'Student', '039',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000338', '9000000338', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE040', @default_pass, '2023ece040@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE040', 'Student', '040',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000339', '9000000339', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE041', @default_pass, '2023ece041@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE041', 'Student', '041',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000340', '9000000340', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE042', @default_pass, '2023ece042@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE042', 'Student', '042',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000341', '9000000341', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE043', @default_pass, '2023ece043@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE043', 'Student', '043',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000342', '9000000342', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE044', @default_pass, '2023ece044@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE044', 'Student', '044',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000343', '9000000343', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE045', @default_pass, '2023ece045@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE045', 'Student', '045',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000344', '9000000344', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE046', @default_pass, '2023ece046@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE046', 'Student', '046',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000345', '9000000345', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE047', @default_pass, '2023ece047@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE047', 'Student', '047',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000346', '9000000346', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE048', @default_pass, '2023ece048@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE048', 'Student', '048',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000347', '9000000347', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE049', @default_pass, '2023ece049@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE049', 'Student', '049',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000348', '9000000348', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023ECE050', @default_pass, '2023ece050@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023ECE050', 'Student', '050',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000349', '9000000349', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE001', @default_pass, '2022ece001@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE001', 'Student', '001',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000350', '9000000350', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE002', @default_pass, '2022ece002@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE002', 'Student', '002',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000351', '9000000351', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE003', @default_pass, '2022ece003@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE003', 'Student', '003',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000352', '9000000352', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE004', @default_pass, '2022ece004@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE004', 'Student', '004',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000353', '9000000353', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE005', @default_pass, '2022ece005@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE005', 'Student', '005',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000354', '9000000354', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE006', @default_pass, '2022ece006@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE006', 'Student', '006',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000355', '9000000355', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE007', @default_pass, '2022ece007@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE007', 'Student', '007',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000356', '9000000356', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE008', @default_pass, '2022ece008@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE008', 'Student', '008',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000357', '9000000357', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE009', @default_pass, '2022ece009@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE009', 'Student', '009',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000358', '9000000358', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE010', @default_pass, '2022ece010@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE010', 'Student', '010',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000359', '9000000359', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE011', @default_pass, '2022ece011@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE011', 'Student', '011',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000360', '9000000360', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE012', @default_pass, '2022ece012@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE012', 'Student', '012',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000361', '9000000361', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE013', @default_pass, '2022ece013@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE013', 'Student', '013',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000362', '9000000362', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE014', @default_pass, '2022ece014@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE014', 'Student', '014',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000363', '9000000363', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE015', @default_pass, '2022ece015@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE015', 'Student', '015',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000364', '9000000364', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE016', @default_pass, '2022ece016@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE016', 'Student', '016',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000365', '9000000365', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE017', @default_pass, '2022ece017@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE017', 'Student', '017',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000366', '9000000366', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE018', @default_pass, '2022ece018@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE018', 'Student', '018',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000367', '9000000367', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE019', @default_pass, '2022ece019@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE019', 'Student', '019',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000368', '9000000368', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE020', @default_pass, '2022ece020@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE020', 'Student', '020',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000369', '9000000369', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE021', @default_pass, '2022ece021@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE021', 'Student', '021',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000370', '9000000370', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE022', @default_pass, '2022ece022@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE022', 'Student', '022',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000371', '9000000371', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE023', @default_pass, '2022ece023@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE023', 'Student', '023',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000372', '9000000372', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE024', @default_pass, '2022ece024@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE024', 'Student', '024',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000373', '9000000373', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE025', @default_pass, '2022ece025@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE025', 'Student', '025',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000374', '9000000374', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE026', @default_pass, '2022ece026@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE026', 'Student', '026',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000375', '9000000375', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE027', @default_pass, '2022ece027@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE027', 'Student', '027',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000376', '9000000376', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE028', @default_pass, '2022ece028@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE028', 'Student', '028',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000377', '9000000377', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE029', @default_pass, '2022ece029@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE029', 'Student', '029',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000378', '9000000378', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE030', @default_pass, '2022ece030@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE030', 'Student', '030',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000379', '9000000379', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE031', @default_pass, '2022ece031@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE031', 'Student', '031',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000380', '9000000380', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE032', @default_pass, '2022ece032@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE032', 'Student', '032',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000381', '9000000381', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE033', @default_pass, '2022ece033@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE033', 'Student', '033',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000382', '9000000382', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE034', @default_pass, '2022ece034@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE034', 'Student', '034',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000383', '9000000383', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE035', @default_pass, '2022ece035@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE035', 'Student', '035',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000384', '9000000384', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE036', @default_pass, '2022ece036@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE036', 'Student', '036',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000385', '9000000385', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE037', @default_pass, '2022ece037@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE037', 'Student', '037',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000386', '9000000386', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE038', @default_pass, '2022ece038@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE038', 'Student', '038',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000387', '9000000387', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE039', @default_pass, '2022ece039@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE039', 'Student', '039',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000388', '9000000388', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE040', @default_pass, '2022ece040@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE040', 'Student', '040',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000389', '9000000389', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE041', @default_pass, '2022ece041@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE041', 'Student', '041',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000390', '9000000390', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE042', @default_pass, '2022ece042@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE042', 'Student', '042',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000391', '9000000391', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE043', @default_pass, '2022ece043@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE043', 'Student', '043',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000392', '9000000392', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE044', @default_pass, '2022ece044@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE044', 'Student', '044',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000393', '9000000393', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE045', @default_pass, '2022ece045@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE045', 'Student', '045',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000394', '9000000394', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE046', @default_pass, '2022ece046@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE046', 'Student', '046',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000395', '9000000395', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE047', @default_pass, '2022ece047@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE047', 'Student', '047',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000396', '9000000396', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE048', @default_pass, '2022ece048@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE048', 'Student', '048',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000397', '9000000397', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE049', @default_pass, '2022ece049@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE049', 'Student', '049',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000398', '9000000398', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022ECE050', @default_pass, '2022ece050@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022ECE050', 'Student', '050',
(SELECT id FROM degrees WHERE code='BE' LIMIT 1),
(SELECT id FROM specializations WHERE code='ECE' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000399', '9000000399', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT001', @default_pass, '2025it001@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT001', 'Student', '001',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000400', '9000000400', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT002', @default_pass, '2025it002@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT002', 'Student', '002',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000401', '9000000401', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT003', @default_pass, '2025it003@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT003', 'Student', '003',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000402', '9000000402', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT004', @default_pass, '2025it004@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT004', 'Student', '004',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000403', '9000000403', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT005', @default_pass, '2025it005@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT005', 'Student', '005',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000404', '9000000404', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT006', @default_pass, '2025it006@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT006', 'Student', '006',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000405', '9000000405', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT007', @default_pass, '2025it007@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT007', 'Student', '007',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000406', '9000000406', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT008', @default_pass, '2025it008@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT008', 'Student', '008',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000407', '9000000407', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT009', @default_pass, '2025it009@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT009', 'Student', '009',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000408', '9000000408', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT010', @default_pass, '2025it010@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT010', 'Student', '010',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000409', '9000000409', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT011', @default_pass, '2025it011@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT011', 'Student', '011',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000410', '9000000410', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT012', @default_pass, '2025it012@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT012', 'Student', '012',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000411', '9000000411', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT013', @default_pass, '2025it013@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT013', 'Student', '013',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000412', '9000000412', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT014', @default_pass, '2025it014@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT014', 'Student', '014',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000413', '9000000413', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT015', @default_pass, '2025it015@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT015', 'Student', '015',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000414', '9000000414', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT016', @default_pass, '2025it016@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT016', 'Student', '016',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000415', '9000000415', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT017', @default_pass, '2025it017@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT017', 'Student', '017',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000416', '9000000416', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT018', @default_pass, '2025it018@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT018', 'Student', '018',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000417', '9000000417', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT019', @default_pass, '2025it019@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT019', 'Student', '019',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000418', '9000000418', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT020', @default_pass, '2025it020@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT020', 'Student', '020',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000419', '9000000419', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT021', @default_pass, '2025it021@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT021', 'Student', '021',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000420', '9000000420', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT022', @default_pass, '2025it022@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT022', 'Student', '022',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000421', '9000000421', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT023', @default_pass, '2025it023@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT023', 'Student', '023',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000422', '9000000422', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT024', @default_pass, '2025it024@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT024', 'Student', '024',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000423', '9000000423', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT025', @default_pass, '2025it025@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT025', 'Student', '025',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000424', '9000000424', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT026', @default_pass, '2025it026@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT026', 'Student', '026',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000425', '9000000425', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT027', @default_pass, '2025it027@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT027', 'Student', '027',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000426', '9000000426', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT028', @default_pass, '2025it028@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT028', 'Student', '028',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000427', '9000000427', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT029', @default_pass, '2025it029@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT029', 'Student', '029',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000428', '9000000428', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT030', @default_pass, '2025it030@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT030', 'Student', '030',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000429', '9000000429', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT031', @default_pass, '2025it031@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT031', 'Student', '031',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000430', '9000000430', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT032', @default_pass, '2025it032@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT032', 'Student', '032',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000431', '9000000431', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT033', @default_pass, '2025it033@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT033', 'Student', '033',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000432', '9000000432', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT034', @default_pass, '2025it034@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT034', 'Student', '034',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000433', '9000000433', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT035', @default_pass, '2025it035@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT035', 'Student', '035',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000434', '9000000434', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT036', @default_pass, '2025it036@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT036', 'Student', '036',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000435', '9000000435', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT037', @default_pass, '2025it037@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT037', 'Student', '037',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000436', '9000000436', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT038', @default_pass, '2025it038@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT038', 'Student', '038',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000437', '9000000437', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT039', @default_pass, '2025it039@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT039', 'Student', '039',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000438', '9000000438', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT040', @default_pass, '2025it040@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT040', 'Student', '040',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000439', '9000000439', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT041', @default_pass, '2025it041@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT041', 'Student', '041',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000440', '9000000440', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT042', @default_pass, '2025it042@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT042', 'Student', '042',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000441', '9000000441', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT043', @default_pass, '2025it043@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT043', 'Student', '043',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000442', '9000000442', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT044', @default_pass, '2025it044@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT044', 'Student', '044',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000443', '9000000443', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT045', @default_pass, '2025it045@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT045', 'Student', '045',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000444', '9000000444', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT046', @default_pass, '2025it046@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT046', 'Student', '046',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000445', '9000000445', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT047', @default_pass, '2025it047@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT047', 'Student', '047',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000446', '9000000446', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT048', @default_pass, '2025it048@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT048', 'Student', '048',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000447', '9000000447', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT049', @default_pass, '2025it049@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT049', 'Student', '049',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000448', '9000000448', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2025IT050', @default_pass, '2025it050@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2025IT050', 'Student', '050',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
1, 2, '2025-2029', 'Chennai, India', '9000000449', '9000000449', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT001', @default_pass, '2024it001@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT001', 'Student', '001',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000450', '9000000450', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT002', @default_pass, '2024it002@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT002', 'Student', '002',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000451', '9000000451', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT003', @default_pass, '2024it003@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT003', 'Student', '003',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000452', '9000000452', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT004', @default_pass, '2024it004@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT004', 'Student', '004',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000453', '9000000453', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT005', @default_pass, '2024it005@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT005', 'Student', '005',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000454', '9000000454', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT006', @default_pass, '2024it006@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT006', 'Student', '006',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000455', '9000000455', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT007', @default_pass, '2024it007@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT007', 'Student', '007',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000456', '9000000456', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT008', @default_pass, '2024it008@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT008', 'Student', '008',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000457', '9000000457', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT009', @default_pass, '2024it009@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT009', 'Student', '009',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000458', '9000000458', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT010', @default_pass, '2024it010@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT010', 'Student', '010',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000459', '9000000459', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT011', @default_pass, '2024it011@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT011', 'Student', '011',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000460', '9000000460', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT012', @default_pass, '2024it012@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT012', 'Student', '012',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000461', '9000000461', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT013', @default_pass, '2024it013@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT013', 'Student', '013',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000462', '9000000462', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT014', @default_pass, '2024it014@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT014', 'Student', '014',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000463', '9000000463', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT015', @default_pass, '2024it015@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT015', 'Student', '015',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000464', '9000000464', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT016', @default_pass, '2024it016@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT016', 'Student', '016',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000465', '9000000465', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT017', @default_pass, '2024it017@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT017', 'Student', '017',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000466', '9000000466', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT018', @default_pass, '2024it018@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT018', 'Student', '018',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000467', '9000000467', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT019', @default_pass, '2024it019@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT019', 'Student', '019',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000468', '9000000468', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT020', @default_pass, '2024it020@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT020', 'Student', '020',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000469', '9000000469', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT021', @default_pass, '2024it021@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT021', 'Student', '021',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000470', '9000000470', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT022', @default_pass, '2024it022@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT022', 'Student', '022',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000471', '9000000471', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT023', @default_pass, '2024it023@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT023', 'Student', '023',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000472', '9000000472', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT024', @default_pass, '2024it024@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT024', 'Student', '024',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000473', '9000000473', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT025', @default_pass, '2024it025@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT025', 'Student', '025',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000474', '9000000474', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT026', @default_pass, '2024it026@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT026', 'Student', '026',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000475', '9000000475', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT027', @default_pass, '2024it027@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT027', 'Student', '027',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000476', '9000000476', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT028', @default_pass, '2024it028@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT028', 'Student', '028',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000477', '9000000477', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT029', @default_pass, '2024it029@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT029', 'Student', '029',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000478', '9000000478', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT030', @default_pass, '2024it030@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT030', 'Student', '030',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000479', '9000000479', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT031', @default_pass, '2024it031@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT031', 'Student', '031',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000480', '9000000480', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT032', @default_pass, '2024it032@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT032', 'Student', '032',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000481', '9000000481', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT033', @default_pass, '2024it033@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT033', 'Student', '033',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000482', '9000000482', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT034', @default_pass, '2024it034@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT034', 'Student', '034',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000483', '9000000483', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT035', @default_pass, '2024it035@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT035', 'Student', '035',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000484', '9000000484', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT036', @default_pass, '2024it036@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT036', 'Student', '036',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000485', '9000000485', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT037', @default_pass, '2024it037@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT037', 'Student', '037',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000486', '9000000486', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT038', @default_pass, '2024it038@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT038', 'Student', '038',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000487', '9000000487', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT039', @default_pass, '2024it039@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT039', 'Student', '039',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000488', '9000000488', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT040', @default_pass, '2024it040@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT040', 'Student', '040',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000489', '9000000489', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT041', @default_pass, '2024it041@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT041', 'Student', '041',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000490', '9000000490', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT042', @default_pass, '2024it042@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT042', 'Student', '042',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000491', '9000000491', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT043', @default_pass, '2024it043@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT043', 'Student', '043',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000492', '9000000492', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT044', @default_pass, '2024it044@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT044', 'Student', '044',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000493', '9000000493', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT045', @default_pass, '2024it045@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT045', 'Student', '045',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000494', '9000000494', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT046', @default_pass, '2024it046@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT046', 'Student', '046',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000495', '9000000495', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT047', @default_pass, '2024it047@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT047', 'Student', '047',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000496', '9000000496', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT048', @default_pass, '2024it048@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT048', 'Student', '048',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000497', '9000000497', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT049', @default_pass, '2024it049@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT049', 'Student', '049',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000498', '9000000498', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2024IT050', @default_pass, '2024it050@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2024IT050', 'Student', '050',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
2, 4, '2024-2028', 'Chennai, India', '9000000499', '9000000499', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT001', @default_pass, '2023it001@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT001', 'Student', '001',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000500', '9000000500', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT002', @default_pass, '2023it002@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT002', 'Student', '002',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000501', '9000000501', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT003', @default_pass, '2023it003@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT003', 'Student', '003',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000502', '9000000502', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT004', @default_pass, '2023it004@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT004', 'Student', '004',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000503', '9000000503', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT005', @default_pass, '2023it005@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT005', 'Student', '005',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000504', '9000000504', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT006', @default_pass, '2023it006@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT006', 'Student', '006',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000505', '9000000505', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT007', @default_pass, '2023it007@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT007', 'Student', '007',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000506', '9000000506', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT008', @default_pass, '2023it008@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT008', 'Student', '008',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000507', '9000000507', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT009', @default_pass, '2023it009@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT009', 'Student', '009',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000508', '9000000508', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT010', @default_pass, '2023it010@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT010', 'Student', '010',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000509', '9000000509', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT011', @default_pass, '2023it011@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT011', 'Student', '011',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000510', '9000000510', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT012', @default_pass, '2023it012@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT012', 'Student', '012',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000511', '9000000511', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT013', @default_pass, '2023it013@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT013', 'Student', '013',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000512', '9000000512', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT014', @default_pass, '2023it014@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT014', 'Student', '014',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000513', '9000000513', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT015', @default_pass, '2023it015@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT015', 'Student', '015',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000514', '9000000514', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT016', @default_pass, '2023it016@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT016', 'Student', '016',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000515', '9000000515', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT017', @default_pass, '2023it017@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT017', 'Student', '017',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000516', '9000000516', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT018', @default_pass, '2023it018@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT018', 'Student', '018',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000517', '9000000517', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT019', @default_pass, '2023it019@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT019', 'Student', '019',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000518', '9000000518', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT020', @default_pass, '2023it020@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT020', 'Student', '020',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000519', '9000000519', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT021', @default_pass, '2023it021@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT021', 'Student', '021',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000520', '9000000520', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT022', @default_pass, '2023it022@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT022', 'Student', '022',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000521', '9000000521', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT023', @default_pass, '2023it023@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT023', 'Student', '023',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000522', '9000000522', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT024', @default_pass, '2023it024@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT024', 'Student', '024',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000523', '9000000523', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT025', @default_pass, '2023it025@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT025', 'Student', '025',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000524', '9000000524', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT026', @default_pass, '2023it026@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT026', 'Student', '026',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000525', '9000000525', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT027', @default_pass, '2023it027@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT027', 'Student', '027',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000526', '9000000526', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT028', @default_pass, '2023it028@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT028', 'Student', '028',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000527', '9000000527', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT029', @default_pass, '2023it029@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT029', 'Student', '029',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000528', '9000000528', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT030', @default_pass, '2023it030@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT030', 'Student', '030',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000529', '9000000529', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT031', @default_pass, '2023it031@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT031', 'Student', '031',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000530', '9000000530', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT032', @default_pass, '2023it032@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT032', 'Student', '032',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000531', '9000000531', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT033', @default_pass, '2023it033@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT033', 'Student', '033',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000532', '9000000532', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT034', @default_pass, '2023it034@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT034', 'Student', '034',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000533', '9000000533', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT035', @default_pass, '2023it035@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT035', 'Student', '035',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000534', '9000000534', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT036', @default_pass, '2023it036@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT036', 'Student', '036',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000535', '9000000535', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT037', @default_pass, '2023it037@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT037', 'Student', '037',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000536', '9000000536', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT038', @default_pass, '2023it038@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT038', 'Student', '038',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000537', '9000000537', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT039', @default_pass, '2023it039@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT039', 'Student', '039',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000538', '9000000538', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT040', @default_pass, '2023it040@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT040', 'Student', '040',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000539', '9000000539', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT041', @default_pass, '2023it041@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT041', 'Student', '041',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000540', '9000000540', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT042', @default_pass, '2023it042@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT042', 'Student', '042',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000541', '9000000541', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT043', @default_pass, '2023it043@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT043', 'Student', '043',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000542', '9000000542', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT044', @default_pass, '2023it044@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT044', 'Student', '044',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000543', '9000000543', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT045', @default_pass, '2023it045@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT045', 'Student', '045',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000544', '9000000544', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT046', @default_pass, '2023it046@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT046', 'Student', '046',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000545', '9000000545', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT047', @default_pass, '2023it047@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT047', 'Student', '047',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000546', '9000000546', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT048', @default_pass, '2023it048@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT048', 'Student', '048',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000547', '9000000547', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT049', @default_pass, '2023it049@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT049', 'Student', '049',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000548', '9000000548', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2023IT050', @default_pass, '2023it050@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2023IT050', 'Student', '050',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
3, 6, '2023-2027', 'Chennai, India', '9000000549', '9000000549', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT001', @default_pass, '2022it001@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT001', 'Student', '001',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000550', '9000000550', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT002', @default_pass, '2022it002@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT002', 'Student', '002',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000551', '9000000551', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT003', @default_pass, '2022it003@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT003', 'Student', '003',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000552', '9000000552', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT004', @default_pass, '2022it004@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT004', 'Student', '004',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000553', '9000000553', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT005', @default_pass, '2022it005@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT005', 'Student', '005',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000554', '9000000554', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT006', @default_pass, '2022it006@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT006', 'Student', '006',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000555', '9000000555', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT007', @default_pass, '2022it007@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT007', 'Student', '007',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000556', '9000000556', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT008', @default_pass, '2022it008@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT008', 'Student', '008',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000557', '9000000557', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT009', @default_pass, '2022it009@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT009', 'Student', '009',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000558', '9000000558', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT010', @default_pass, '2022it010@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT010', 'Student', '010',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000559', '9000000559', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT011', @default_pass, '2022it011@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT011', 'Student', '011',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000560', '9000000560', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT012', @default_pass, '2022it012@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT012', 'Student', '012',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000561', '9000000561', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT013', @default_pass, '2022it013@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT013', 'Student', '013',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000562', '9000000562', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT014', @default_pass, '2022it014@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT014', 'Student', '014',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000563', '9000000563', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT015', @default_pass, '2022it015@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT015', 'Student', '015',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000564', '9000000564', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT016', @default_pass, '2022it016@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT016', 'Student', '016',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000565', '9000000565', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT017', @default_pass, '2022it017@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT017', 'Student', '017',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000566', '9000000566', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT018', @default_pass, '2022it018@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT018', 'Student', '018',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000567', '9000000567', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT019', @default_pass, '2022it019@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT019', 'Student', '019',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000568', '9000000568', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT020', @default_pass, '2022it020@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT020', 'Student', '020',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000569', '9000000569', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT021', @default_pass, '2022it021@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT021', 'Student', '021',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000570', '9000000570', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT022', @default_pass, '2022it022@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT022', 'Student', '022',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000571', '9000000571', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT023', @default_pass, '2022it023@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT023', 'Student', '023',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000572', '9000000572', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT024', @default_pass, '2022it024@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT024', 'Student', '024',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000573', '9000000573', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT025', @default_pass, '2022it025@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT025', 'Student', '025',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000574', '9000000574', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT026', @default_pass, '2022it026@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT026', 'Student', '026',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000575', '9000000575', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT027', @default_pass, '2022it027@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT027', 'Student', '027',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000576', '9000000576', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT028', @default_pass, '2022it028@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT028', 'Student', '028',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000577', '9000000577', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT029', @default_pass, '2022it029@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT029', 'Student', '029',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000578', '9000000578', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT030', @default_pass, '2022it030@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT030', 'Student', '030',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000579', '9000000579', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT031', @default_pass, '2022it031@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT031', 'Student', '031',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000580', '9000000580', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT032', @default_pass, '2022it032@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT032', 'Student', '032',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000581', '9000000581', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT033', @default_pass, '2022it033@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT033', 'Student', '033',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000582', '9000000582', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT034', @default_pass, '2022it034@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT034', 'Student', '034',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000583', '9000000583', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT035', @default_pass, '2022it035@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT035', 'Student', '035',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000584', '9000000584', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT036', @default_pass, '2022it036@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT036', 'Student', '036',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000585', '9000000585', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT037', @default_pass, '2022it037@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT037', 'Student', '037',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000586', '9000000586', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT038', @default_pass, '2022it038@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT038', 'Student', '038',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000587', '9000000587', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT039', @default_pass, '2022it039@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT039', 'Student', '039',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000588', '9000000588', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT040', @default_pass, '2022it040@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT040', 'Student', '040',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000589', '9000000589', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT041', @default_pass, '2022it041@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT041', 'Student', '041',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000590', '9000000590', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT042', @default_pass, '2022it042@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT042', 'Student', '042',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000591', '9000000591', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT043', @default_pass, '2022it043@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT043', 'Student', '043',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000592', '9000000592', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT044', @default_pass, '2022it044@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT044', 'Student', '044',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000593', '9000000593', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT045', @default_pass, '2022it045@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT045', 'Student', '045',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000594', '9000000594', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT046', @default_pass, '2022it046@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT046', 'Student', '046',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000595', '9000000595', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT047', @default_pass, '2022it047@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT047', 'Student', '047',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000596', '9000000596', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT048', @default_pass, '2022it048@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT048', 'Student', '048',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000597', '9000000597', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT049', @default_pass, '2022it049@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT049', 'Student', '049',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000598', '9000000598', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('2022IT050', @default_pass, '2022it050@college.edu', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '2022IT050', 'Student', '050',
(SELECT id FROM degrees WHERE code='BTECH' LIMIT 1),
(SELECT id FROM specializations WHERE code='IT' LIMIT 1),
4, 8, '2022-2026', 'Chennai, India', '9000000599', '9000000599', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACCSE001', @default_pass, 'facultycse1.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACCSE001', 'FacultyCSE1', 'Staff',
(SELECT id FROM departments WHERE code='CSE' LIMIT 1),
'Assistant Professor', '9000000600', '9000000600', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACCSE002', @default_pass, 'facultycse2.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACCSE002', 'FacultyCSE2', 'Staff',
(SELECT id FROM departments WHERE code='CSE' LIMIT 1),
'Assistant Professor', '9000000601', '9000000601', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACCSE003', @default_pass, 'facultycse3.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACCSE003', 'FacultyCSE3', 'Staff',
(SELECT id FROM departments WHERE code='CSE' LIMIT 1),
'Assistant Professor', '9000000602', '9000000602', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACCSE004', @default_pass, 'facultycse4.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACCSE004', 'FacultyCSE4', 'Staff',
(SELECT id FROM departments WHERE code='CSE' LIMIT 1),
'Assistant Professor', '9000000603', '9000000603', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACCSE005', @default_pass, 'facultycse5.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACCSE005', 'FacultyCSE5', 'Staff',
(SELECT id FROM departments WHERE code='CSE' LIMIT 1),
'Assistant Professor', '9000000604', '9000000604', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACCSE006', @default_pass, 'facultycse6.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACCSE006', 'FacultyCSE6', 'Staff',
(SELECT id FROM departments WHERE code='CSE' LIMIT 1),
'Assistant Professor', '9000000605', '9000000605', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACCSE007', @default_pass, 'facultycse7.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACCSE007', 'FacultyCSE7', 'Staff',
(SELECT id FROM departments WHERE code='CSE' LIMIT 1),
'Assistant Professor', '9000000606', '9000000606', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACCSE008', @default_pass, 'facultycse8.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACCSE008', 'FacultyCSE8', 'Staff',
(SELECT id FROM departments WHERE code='CSE' LIMIT 1),
'Assistant Professor', '9000000607', '9000000607', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACECE001', @default_pass, 'facultyece1.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACECE001', 'FacultyECE1', 'Staff',
(SELECT id FROM departments WHERE code='ECE' LIMIT 1),
'Assistant Professor', '9000000608', '9000000608', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACECE002', @default_pass, 'facultyece2.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACECE002', 'FacultyECE2', 'Staff',
(SELECT id FROM departments WHERE code='ECE' LIMIT 1),
'Assistant Professor', '9000000609', '9000000609', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACECE003', @default_pass, 'facultyece3.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACECE003', 'FacultyECE3', 'Staff',
(SELECT id FROM departments WHERE code='ECE' LIMIT 1),
'Assistant Professor', '9000000610', '9000000610', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACECE004', @default_pass, 'facultyece4.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACECE004', 'FacultyECE4', 'Staff',
(SELECT id FROM departments WHERE code='ECE' LIMIT 1),
'Assistant Professor', '9000000611', '9000000611', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACECE005', @default_pass, 'facultyece5.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACECE005', 'FacultyECE5', 'Staff',
(SELECT id FROM departments WHERE code='ECE' LIMIT 1),
'Assistant Professor', '9000000612', '9000000612', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACECE006', @default_pass, 'facultyece6.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACECE006', 'FacultyECE6', 'Staff',
(SELECT id FROM departments WHERE code='ECE' LIMIT 1),
'Assistant Professor', '9000000613', '9000000613', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACECE007', @default_pass, 'facultyece7.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACECE007', 'FacultyECE7', 'Staff',
(SELECT id FROM departments WHERE code='ECE' LIMIT 1),
'Assistant Professor', '9000000614', '9000000614', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACECE008', @default_pass, 'facultyece8.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACECE008', 'FacultyECE8', 'Staff',
(SELECT id FROM departments WHERE code='ECE' LIMIT 1),
'Assistant Professor', '9000000615', '9000000615', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACIT001', @default_pass, 'facultyit1.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACIT001', 'FacultyIT1', 'Staff',
(SELECT id FROM departments WHERE code='IT' LIMIT 1),
'Assistant Professor', '9000000616', '9000000616', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACIT002', @default_pass, 'facultyit2.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACIT002', 'FacultyIT2', 'Staff',
(SELECT id FROM departments WHERE code='IT' LIMIT 1),
'Assistant Professor', '9000000617', '9000000617', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACIT003', @default_pass, 'facultyit3.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACIT003', 'FacultyIT3', 'Staff',
(SELECT id FROM departments WHERE code='IT' LIMIT 1),
'Assistant Professor', '9000000618', '9000000618', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACIT004', @default_pass, 'facultyit4.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACIT004', 'FacultyIT4', 'Staff',
(SELECT id FROM departments WHERE code='IT' LIMIT 1),
'Assistant Professor', '9000000619', '9000000619', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACIT005', @default_pass, 'facultyit5.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACIT005', 'FacultyIT5', 'Staff',
(SELECT id FROM departments WHERE code='IT' LIMIT 1),
'Assistant Professor', '9000000620', '9000000620', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACIT006', @default_pass, 'facultyit6.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACIT006', 'FacultyIT6', 'Staff',
(SELECT id FROM departments WHERE code='IT' LIMIT 1),
'Assistant Professor', '9000000621', '9000000621', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACIT007', @default_pass, 'facultyit7.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACIT007', 'FacultyIT7', 'Staff',
(SELECT id FROM departments WHERE code='IT' LIMIT 1),
'Assistant Professor', '9000000622', '9000000622', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACIT008', @default_pass, 'facultyit8.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACIT008', 'FacultyIT8', 'Staff',
(SELECT id FROM departments WHERE code='IT' LIMIT 1),
'Assistant Professor', '9000000623', '9000000623', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACIT009', @default_pass, 'facultyit9.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACIT009', 'FacultyIT9', 'Staff',
(SELECT id FROM departments WHERE code='IT' LIMIT 1),
'Assistant Professor', '9000000624', '9000000624', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACIT010', @default_pass, 'facultyit10.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACIT010', 'FacultyIT10', 'Staff',
(SELECT id FROM departments WHERE code='IT' LIMIT 1),
'Assistant Professor', '9000000625', '9000000625', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACIT011', @default_pass, 'facultyit11.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACIT011', 'FacultyIT11', 'Staff',
(SELECT id FROM departments WHERE code='IT' LIMIT 1),
'Assistant Professor', '9000000626', '9000000626', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACIT012', @default_pass, 'facultyit12.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACIT012', 'FacultyIT12', 'Staff',
(SELECT id FROM departments WHERE code='IT' LIMIT 1),
'Assistant Professor', '9000000627', '9000000627', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACMECH001', @default_pass, 'facultymech1.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACMECH001', 'FacultyMECH1', 'Staff',
(SELECT id FROM departments WHERE code='MECH' LIMIT 1),
'Assistant Professor', '9000000628', '9000000628', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACMECH002', @default_pass, 'facultymech2.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACMECH002', 'FacultyMECH2', 'Staff',
(SELECT id FROM departments WHERE code='MECH' LIMIT 1),
'Assistant Professor', '9000000629', '9000000629', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACMECH003', @default_pass, 'facultymech3.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACMECH003', 'FacultyMECH3', 'Staff',
(SELECT id FROM departments WHERE code='MECH' LIMIT 1),
'Assistant Professor', '9000000630', '9000000630', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACMECH004', @default_pass, 'facultymech4.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACMECH004', 'FacultyMECH4', 'Staff',
(SELECT id FROM departments WHERE code='MECH' LIMIT 1),
'Assistant Professor', '9000000631', '9000000631', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACMECH005', @default_pass, 'facultymech5.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACMECH005', 'FacultyMECH5', 'Staff',
(SELECT id FROM departments WHERE code='MECH' LIMIT 1),
'Assistant Professor', '9000000632', '9000000632', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACMECH006', @default_pass, 'facultymech6.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACMECH006', 'FacultyMECH6', 'Staff',
(SELECT id FROM departments WHERE code='MECH' LIMIT 1),
'Assistant Professor', '9000000633', '9000000633', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACMECH007', @default_pass, 'facultymech7.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACMECH007', 'FacultyMECH7', 'Staff',
(SELECT id FROM departments WHERE code='MECH' LIMIT 1),
'Assistant Professor', '9000000634', '9000000634', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACMECH008', @default_pass, 'facultymech8.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACMECH008', 'FacultyMECH8', 'Staff',
(SELECT id FROM departments WHERE code='MECH' LIMIT 1),
'Assistant Professor', '9000000635', '9000000635', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACMECH009', @default_pass, 'facultymech9.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACMECH009', 'FacultyMECH9', 'Staff',
(SELECT id FROM departments WHERE code='MECH' LIMIT 1),
'Assistant Professor', '9000000636', '9000000636', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACCIVIL001', @default_pass, 'facultycivil1.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACCIVIL001', 'FacultyCIVIL1', 'Staff',
(SELECT id FROM departments WHERE code='CIVIL' LIMIT 1),
'Assistant Professor', '9000000637', '9000000637', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACCIVIL002', @default_pass, 'facultycivil2.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACCIVIL002', 'FacultyCIVIL2', 'Staff',
(SELECT id FROM departments WHERE code='CIVIL' LIMIT 1),
'Assistant Professor', '9000000638', '9000000638', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACCIVIL003', @default_pass, 'facultycivil3.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACCIVIL003', 'FacultyCIVIL3', 'Staff',
(SELECT id FROM departments WHERE code='CIVIL' LIMIT 1),
'Assistant Professor', '9000000639', '9000000639', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACCIVIL004', @default_pass, 'facultycivil4.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACCIVIL004', 'FacultyCIVIL4', 'Staff',
(SELECT id FROM departments WHERE code='CIVIL' LIMIT 1),
'Assistant Professor', '9000000640', '9000000640', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACCIVIL005', @default_pass, 'facultycivil5.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACCIVIL005', 'FacultyCIVIL5', 'Staff',
(SELECT id FROM departments WHERE code='CIVIL' LIMIT 1),
'Assistant Professor', '9000000641', '9000000641', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACCIVIL006', @default_pass, 'facultycivil6.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACCIVIL006', 'FacultyCIVIL6', 'Staff',
(SELECT id FROM departments WHERE code='CIVIL' LIMIT 1),
'Assistant Professor', '9000000642', '9000000642', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACCIVIL007', @default_pass, 'facultycivil7.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACCIVIL007', 'FacultyCIVIL7', 'Staff',
(SELECT id FROM departments WHERE code='CIVIL' LIMIT 1),
'Assistant Professor', '9000000643', '9000000643', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('FACCIVIL008', @default_pass, 'facultycivil8.staff@college.edu', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, 'FACCIVIL008', 'FacultyCIVIL8', 'Staff',
(SELECT id FROM departments WHERE code='CIVIL' LIMIT 1),
'Assistant Professor', '9000000644', '9000000644', 1;
SET @fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('AST0001', @default_pass, 'assistant0001.staff@college.edu', 'ASSISTANT_STAFF', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO assistant_staff (user_id, assistant_id, first_name, last_name, department_id, designation, phone, is_active)
SELECT @uid, 'AST0001', 'Assistant0001', 'Staff',
(SELECT id FROM departments WHERE code='CSE' LIMIT 1),
'Lab Assistant', '9000000645', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('AST0002', @default_pass, 'assistant0002.staff@college.edu', 'ASSISTANT_STAFF', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO assistant_staff (user_id, assistant_id, first_name, last_name, department_id, designation, phone, is_active)
SELECT @uid, 'AST0002', 'Assistant0002', 'Staff',
(SELECT id FROM departments WHERE code='CSE' LIMIT 1),
'Lab Assistant', '9000000646', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('AST0003', @default_pass, 'assistant0003.staff@college.edu', 'ASSISTANT_STAFF', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO assistant_staff (user_id, assistant_id, first_name, last_name, department_id, designation, phone, is_active)
SELECT @uid, 'AST0003', 'Assistant0003', 'Staff',
(SELECT id FROM departments WHERE code='CSE' LIMIT 1),
'Lab Assistant', '9000000647', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('AST0004', @default_pass, 'assistant0004.staff@college.edu', 'ASSISTANT_STAFF', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO assistant_staff (user_id, assistant_id, first_name, last_name, department_id, designation, phone, is_active)
SELECT @uid, 'AST0004', 'Assistant0004', 'Staff',
(SELECT id FROM departments WHERE code='CSE' LIMIT 1),
'Lab Assistant', '9000000648', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('AST0005', @default_pass, 'assistant0005.staff@college.edu', 'ASSISTANT_STAFF', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO assistant_staff (user_id, assistant_id, first_name, last_name, department_id, designation, phone, is_active)
SELECT @uid, 'AST0005', 'Assistant0005', 'Staff',
(SELECT id FROM departments WHERE code='CSE' LIMIT 1),
'Lab Assistant', '9000000649', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('AST0006', @default_pass, 'assistant0006.staff@college.edu', 'ASSISTANT_STAFF', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO assistant_staff (user_id, assistant_id, first_name, last_name, department_id, designation, phone, is_active)
SELECT @uid, 'AST0006', 'Assistant0006', 'Staff',
(SELECT id FROM departments WHERE code='CSE' LIMIT 1),
'Lab Assistant', '9000000650', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('AST0007', @default_pass, 'assistant0007.staff@college.edu', 'ASSISTANT_STAFF', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO assistant_staff (user_id, assistant_id, first_name, last_name, department_id, designation, phone, is_active)
SELECT @uid, 'AST0007', 'Assistant0007', 'Staff',
(SELECT id FROM departments WHERE code='CSE' LIMIT 1),
'Lab Assistant', '9000000651', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('AST0008', @default_pass, 'assistant0008.staff@college.edu', 'ASSISTANT_STAFF', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO assistant_staff (user_id, assistant_id, first_name, last_name, department_id, designation, phone, is_active)
SELECT @uid, 'AST0008', 'Assistant0008', 'Staff',
(SELECT id FROM departments WHERE code='CSE' LIMIT 1),
'Lab Assistant', '9000000652', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('AST0009', @default_pass, 'assistant0009.staff@college.edu', 'ASSISTANT_STAFF', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO assistant_staff (user_id, assistant_id, first_name, last_name, department_id, designation, phone, is_active)
SELECT @uid, 'AST0009', 'Assistant0009', 'Staff',
(SELECT id FROM departments WHERE code='ECE' LIMIT 1),
'Lab Assistant', '9000000653', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('AST0010', @default_pass, 'assistant0010.staff@college.edu', 'ASSISTANT_STAFF', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO assistant_staff (user_id, assistant_id, first_name, last_name, department_id, designation, phone, is_active)
SELECT @uid, 'AST0010', 'Assistant0010', 'Staff',
(SELECT id FROM departments WHERE code='ECE' LIMIT 1),
'Lab Assistant', '9000000654', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('AST0011', @default_pass, 'assistant0011.staff@college.edu', 'ASSISTANT_STAFF', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO assistant_staff (user_id, assistant_id, first_name, last_name, department_id, designation, phone, is_active)
SELECT @uid, 'AST0011', 'Assistant0011', 'Staff',
(SELECT id FROM departments WHERE code='ECE' LIMIT 1),
'Lab Assistant', '9000000655', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('AST0012', @default_pass, 'assistant0012.staff@college.edu', 'ASSISTANT_STAFF', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO assistant_staff (user_id, assistant_id, first_name, last_name, department_id, designation, phone, is_active)
SELECT @uid, 'AST0012', 'Assistant0012', 'Staff',
(SELECT id FROM departments WHERE code='ECE' LIMIT 1),
'Lab Assistant', '9000000656', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('AST0013', @default_pass, 'assistant0013.staff@college.edu', 'ASSISTANT_STAFF', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO assistant_staff (user_id, assistant_id, first_name, last_name, department_id, designation, phone, is_active)
SELECT @uid, 'AST0013', 'Assistant0013', 'Staff',
(SELECT id FROM departments WHERE code='ECE' LIMIT 1),
'Lab Assistant', '9000000657', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('AST0014', @default_pass, 'assistant0014.staff@college.edu', 'ASSISTANT_STAFF', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO assistant_staff (user_id, assistant_id, first_name, last_name, department_id, designation, phone, is_active)
SELECT @uid, 'AST0014', 'Assistant0014', 'Staff',
(SELECT id FROM departments WHERE code='IT' LIMIT 1),
'Lab Assistant', '9000000658', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('AST0015', @default_pass, 'assistant0015.staff@college.edu', 'ASSISTANT_STAFF', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO assistant_staff (user_id, assistant_id, first_name, last_name, department_id, designation, phone, is_active)
SELECT @uid, 'AST0015', 'Assistant0015', 'Staff',
(SELECT id FROM departments WHERE code='IT' LIMIT 1),
'Lab Assistant', '9000000659', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('AST0016', @default_pass, 'assistant0016.staff@college.edu', 'ASSISTANT_STAFF', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO assistant_staff (user_id, assistant_id, first_name, last_name, department_id, designation, phone, is_active)
SELECT @uid, 'AST0016', 'Assistant0016', 'Staff',
(SELECT id FROM departments WHERE code='IT' LIMIT 1),
'Lab Assistant', '9000000660', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('AST0017', @default_pass, 'assistant0017.staff@college.edu', 'ASSISTANT_STAFF', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO assistant_staff (user_id, assistant_id, first_name, last_name, department_id, designation, phone, is_active)
SELECT @uid, 'AST0017', 'Assistant0017', 'Staff',
(SELECT id FROM departments WHERE code='IT' LIMIT 1),
'Lab Assistant', '9000000661', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('AST0018', @default_pass, 'assistant0018.staff@college.edu', 'ASSISTANT_STAFF', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO assistant_staff (user_id, assistant_id, first_name, last_name, department_id, designation, phone, is_active)
SELECT @uid, 'AST0018', 'Assistant0018', 'Staff',
(SELECT id FROM departments WHERE code='IT' LIMIT 1),
'Lab Assistant', '9000000662', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('AST0019', @default_pass, 'assistant0019.staff@college.edu', 'ASSISTANT_STAFF', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO assistant_staff (user_id, assistant_id, first_name, last_name, department_id, designation, phone, is_active)
SELECT @uid, 'AST0019', 'Assistant0019', 'Staff',
(SELECT id FROM departments WHERE code='MECH' LIMIT 1),
'Lab Assistant', '9000000663', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('AST0020', @default_pass, 'assistant0020.staff@college.edu', 'ASSISTANT_STAFF', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO assistant_staff (user_id, assistant_id, first_name, last_name, department_id, designation, phone, is_active)
SELECT @uid, 'AST0020', 'Assistant0020', 'Staff',
(SELECT id FROM departments WHERE code='MECH' LIMIT 1),
'Lab Assistant', '9000000664', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('AST0021', @default_pass, 'assistant0021.staff@college.edu', 'ASSISTANT_STAFF', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO assistant_staff (user_id, assistant_id, first_name, last_name, department_id, designation, phone, is_active)
SELECT @uid, 'AST0021', 'Assistant0021', 'Staff',
(SELECT id FROM departments WHERE code='MECH' LIMIT 1),
'Lab Assistant', '9000000665', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('AST0022', @default_pass, 'assistant0022.staff@college.edu', 'ASSISTANT_STAFF', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO assistant_staff (user_id, assistant_id, first_name, last_name, department_id, designation, phone, is_active)
SELECT @uid, 'AST0022', 'Assistant0022', 'Staff',
(SELECT id FROM departments WHERE code='MECH' LIMIT 1),
'Lab Assistant', '9000000666', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('AST0023', @default_pass, 'assistant0023.staff@college.edu', 'ASSISTANT_STAFF', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO assistant_staff (user_id, assistant_id, first_name, last_name, department_id, designation, phone, is_active)
SELECT @uid, 'AST0023', 'Assistant0023', 'Staff',
(SELECT id FROM departments WHERE code='MECH' LIMIT 1),
'Lab Assistant', '9000000667', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('AST0024', @default_pass, 'assistant0024.staff@college.edu', 'ASSISTANT_STAFF', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO assistant_staff (user_id, assistant_id, first_name, last_name, department_id, designation, phone, is_active)
SELECT @uid, 'AST0024', 'Assistant0024', 'Staff',
(SELECT id FROM departments WHERE code='CIVIL' LIMIT 1),
'Lab Assistant', '9000000668', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('AST0025', @default_pass, 'assistant0025.staff@college.edu', 'ASSISTANT_STAFF', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO assistant_staff (user_id, assistant_id, first_name, last_name, department_id, designation, phone, is_active)
SELECT @uid, 'AST0025', 'Assistant0025', 'Staff',
(SELECT id FROM departments WHERE code='CIVIL' LIMIT 1),
'Lab Assistant', '9000000669', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('AST0026', @default_pass, 'assistant0026.staff@college.edu', 'ASSISTANT_STAFF', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO assistant_staff (user_id, assistant_id, first_name, last_name, department_id, designation, phone, is_active)
SELECT @uid, 'AST0026', 'Assistant0026', 'Staff',
(SELECT id FROM departments WHERE code='CIVIL' LIMIT 1),
'Lab Assistant', '9000000670', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('AST0027', @default_pass, 'assistant0027.staff@college.edu', 'ASSISTANT_STAFF', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO assistant_staff (user_id, assistant_id, first_name, last_name, department_id, designation, phone, is_active)
SELECT @uid, 'AST0027', 'Assistant0027', 'Staff',
(SELECT id FROM departments WHERE code='CIVIL' LIMIT 1),
'Lab Assistant', '9000000671', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('AST0028', @default_pass, 'assistant0028.staff@college.edu', 'ASSISTANT_STAFF', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO assistant_staff (user_id, assistant_id, first_name, last_name, department_id, designation, phone, is_active)
SELECT @uid, 'AST0028', 'Assistant0028', 'Staff',
(SELECT id FROM departments WHERE code='CIVIL' LIMIT 1),
'Lab Assistant', '9000000672', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('AST0029', @default_pass, 'assistant0029.staff@college.edu', 'ASSISTANT_STAFF', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO assistant_staff (user_id, assistant_id, first_name, last_name, department_id, designation, phone, is_active)
SELECT @uid, 'AST0029', 'Assistant0029', 'Staff',
(SELECT id FROM departments WHERE code='CIVIL' LIMIT 1),
'Lab Assistant', '9000000673', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('AST0030', @default_pass, 'assistant0030.staff@college.edu', 'ASSISTANT_STAFF', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO assistant_staff (user_id, assistant_id, first_name, last_name, department_id, designation, phone, is_active)
SELECT @uid, 'AST0030', 'Assistant0030', 'Staff',
(SELECT id FROM departments WHERE code='CIVIL' LIMIT 1),
'Lab Assistant', '9000000674', 1;
INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('AST0031', @default_pass, 'assistant0031.staff@college.edu', 'ASSISTANT_STAFF', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @uid = LAST_INSERT_ID();
INSERT IGNORE INTO assistant_staff (user_id, assistant_id, first_name, last_name, department_id, designation, phone, is_active)
SELECT @uid, 'AST0031', 'Assistant0031', 'Staff',
(SELECT id FROM departments WHERE code='CIVIL' LIMIT 1),
'Lab Assistant', '9000000675', 1;