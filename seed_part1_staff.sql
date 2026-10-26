-- ============================================================
-- ERP FULL SEED — PART 1: STAFF (HOD + FACULTY + ASSISTANT)
-- All 7 Departments: CSE, IT, ECE, EEE, MECH, CIVIL, AIDS
-- Password for ALL: Demo@1234 (BCrypt hash below)
-- Run this file in MySQL after dummy_data.sql
-- ============================================================

SET @pass = '$2a$10$eAccYoNOHEqXve8aIWT8Nu3.hD.S.yveD..p/';

-- ============================================================
-- SPECIALIZATIONS (INSERT IGNORE — safe to re-run)
-- ============================================================
INSERT IGNORE INTO specializations (degree_id, name, code)
SELECT id, 'Information Technology', 'IT' FROM degrees WHERE code='BE' LIMIT 1;
INSERT IGNORE INTO specializations (degree_id, name, code)
SELECT id, 'Electronics & Communication Engg', 'ECE' FROM degrees WHERE code='BE' LIMIT 1;
INSERT IGNORE INTO specializations (degree_id, name, code)
SELECT id, 'Electrical & Electronics Engg', 'EEE' FROM degrees WHERE code='BE' LIMIT 1;
INSERT IGNORE INTO specializations (degree_id, name, code)
SELECT id, 'Mechanical Engineering', 'MECH' FROM degrees WHERE code='BE' LIMIT 1;
INSERT IGNORE INTO specializations (degree_id, name, code)
SELECT id, 'Civil Engineering', 'CIVIL' FROM degrees WHERE code='BE' LIMIT 1;
INSERT IGNORE INTO specializations (degree_id, name, code)
SELECT id, 'Artificial Intelligence & Data Science', 'AIDS' FROM degrees WHERE code='BE' LIMIT 1;

-- ============================================================
-- ASSISTANT STAFF (1 per dept — needed for attendance marking)
-- ============================================================
-- CSE Assistant
INSERT INTO users (username,password,visible_password,email,role,is_active,created_at) VALUES
('AST_CSE01',@pass,'Demo@1234','ast.cse01@college.edu','ASSISTANT_STAFF',1,NOW())
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
INSERT IGNORE INTO assistant_staff (user_id,assistant_id,first_name,last_name,department_id,designation,phone,whatsapp_number,dob,blood_group,is_active)
SELECT LAST_INSERT_ID(),'AST-CSE01','Priya','Rajan',(SELECT id FROM departments WHERE code='CSE' LIMIT 1),'Lab Assistant','8500000001','8500000001','1990-05-10','O+',1;

-- IT Assistant
INSERT INTO users (username,password,visible_password,email,role,is_active,created_at) VALUES
('AST_IT01',@pass,'Demo@1234','ast.it01@college.edu','ASSISTANT_STAFF',1,NOW())
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
INSERT IGNORE INTO assistant_staff (user_id,assistant_id,first_name,last_name,department_id,designation,phone,whatsapp_number,dob,blood_group,is_active)
SELECT LAST_INSERT_ID(),'AST-IT01','Karthik','Vel',(SELECT id FROM departments WHERE code='IT' LIMIT 1),'Lab Assistant','8500000002','8500000002','1992-07-15','B+',1;

-- ECE Assistant
INSERT INTO users (username,password,visible_password,email,role,is_active,created_at) VALUES
('AST_ECE01',@pass,'Demo@1234','ast.ece01@college.edu','ASSISTANT_STAFF',1,NOW())
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
INSERT IGNORE INTO assistant_staff (user_id,assistant_id,first_name,last_name,department_id,designation,phone,whatsapp_number,dob,blood_group,is_active)
SELECT LAST_INSERT_ID(),'AST-ECE01','Meena','Devi',(SELECT id FROM departments WHERE code='ECE' LIMIT 1),'Lab Assistant','8500000003','8500000003','1991-03-20','A+',1;

-- EEE Assistant
INSERT INTO users (username,password,visible_password,email,role,is_active,created_at) VALUES
('AST_EEE01',@pass,'Demo@1234','ast.eee01@college.edu','ASSISTANT_STAFF',1,NOW())
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
INSERT IGNORE INTO assistant_staff (user_id,assistant_id,first_name,last_name,department_id,designation,phone,whatsapp_number,dob,blood_group,is_active)
SELECT LAST_INSERT_ID(),'AST-EEE01','Suresh','Kumar',(SELECT id FROM departments WHERE code='EEE' LIMIT 1),'Lab Assistant','8500000004','8500000004','1989-11-05','O+',1;

-- MECH Assistant
INSERT INTO users (username,password,visible_password,email,role,is_active,created_at) VALUES
('AST_MECH01',@pass,'Demo@1234','ast.mech01@college.edu','ASSISTANT_STAFF',1,NOW())
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
INSERT IGNORE INTO assistant_staff (user_id,assistant_id,first_name,last_name,department_id,designation,phone,whatsapp_number,dob,blood_group,is_active)
SELECT LAST_INSERT_ID(),'AST-MECH01','Anbu','Selvan',(SELECT id FROM departments WHERE code='MECH' LIMIT 1),'Lab Assistant','8500000005','8500000005','1990-09-25','B-',1;

-- CIVIL Assistant
INSERT INTO users (username,password,visible_password,email,role,is_active,created_at) VALUES
('AST_CIVIL01',@pass,'Demo@1234','ast.civil01@college.edu','ASSISTANT_STAFF',1,NOW())
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
INSERT IGNORE INTO assistant_staff (user_id,assistant_id,first_name,last_name,department_id,designation,phone,whatsapp_number,dob,blood_group,is_active)
SELECT LAST_INSERT_ID(),'AST-CIVIL01','Valli','Murugan',(SELECT id FROM departments WHERE code='CIVIL' LIMIT 1),'Lab Assistant','8500000006','8500000006','1993-01-12','AB+',1;

-- AIDS Assistant
INSERT INTO users (username,password,visible_password,email,role,is_active,created_at) VALUES
('AST_AIDS01',@pass,'Demo@1234','ast.aids01@college.edu','ASSISTANT_STAFF',1,NOW())
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
INSERT IGNORE INTO assistant_staff (user_id,assistant_id,first_name,last_name,department_id,designation,phone,whatsapp_number,dob,blood_group,is_active)
SELECT LAST_INSERT_ID(),'AST-AIDS01','Deepa','Krishnan',(SELECT id FROM departments WHERE code='AIDS' LIMIT 1),'Lab Assistant','8500000007','8500000007','1994-06-18','A-',1;

-- ============================================================
-- CSE HOD (already exists as STF001 — update if needed)
-- If CSE HOD exists, skip. Adding IT-AIDS HODs below.
-- ============================================================

-- ── IT DEPARTMENT ─────────────────────────────────────────
-- IT HOD
INSERT INTO users (username,password,visible_password,email,role,is_active,created_at) VALUES
('STF_IT_HOD',@pass,'Demo@1234','hod.it@college.edu','HOD',1,NOW())
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @it_hod_uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id,staff_id,first_name,last_name,department_id,designation,phone,whatsapp_number,dob,blood_group,is_active)
VALUES (@it_hod_uid,'STF-IT001','Dr. Ramesh','Pandi',(SELECT id FROM departments WHERE code='IT' LIMIT 1),'Professor & HOD','8500000010','8500000010','1972-04-15','O+',1);
SET @it_hod_fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id,role) VALUES (@it_hod_fid,'HOD');
INSERT IGNORE INTO staff_roles (faculty_id,role) VALUES (@it_hod_fid,'FACULTY');

-- IT Faculty 1
INSERT INTO users (username,password,visible_password,email,role,is_active,created_at) VALUES
('STF_IT_F01',@pass,'Demo@1234','it.faculty01@college.edu','FACULTY',1,NOW())
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
INSERT IGNORE INTO faculty (user_id,staff_id,first_name,last_name,department_id,designation,phone,whatsapp_number,dob,blood_group,is_active)
VALUES (LAST_INSERT_ID(),'STF-IT002','Priya','Shankar',(SELECT id FROM departments WHERE code='IT' LIMIT 1),'Assistant Professor','8500000011','8500000011','1985-08-20','A+',1);

-- IT Faculty 2
INSERT INTO users (username,password,visible_password,email,role,is_active,created_at) VALUES
('STF_IT_F02',@pass,'Demo@1234','it.faculty02@college.edu','FACULTY',1,NOW())
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
INSERT IGNORE INTO faculty (user_id,staff_id,first_name,last_name,department_id,designation,phone,whatsapp_number,dob,blood_group,is_active)
VALUES (LAST_INSERT_ID(),'STF-IT003','Vijay','Kumar',(SELECT id FROM departments WHERE code='IT' LIMIT 1),'Associate Professor','8500000012','8500000012','1980-03-10','B+',1);

-- IT Faculty 3 (also Class Advisor)
INSERT INTO users (username,password,visible_password,email,role,is_active,created_at) VALUES
('STF_IT_CA01',@pass,'Demo@1234','it.advisor01@college.edu','ADVISOR',1,NOW())
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @it_ca1_uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id,staff_id,first_name,last_name,department_id,designation,phone,whatsapp_number,dob,blood_group,is_active)
VALUES (@it_ca1_uid,'STF-IT004','Anitha','Rajendran',(SELECT id FROM departments WHERE code='IT' LIMIT 1),'Assistant Professor','8500000013','8500000013','1988-11-25','O-',1);
SET @it_ca1_fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id,role) VALUES (@it_ca1_fid,'FACULTY');
INSERT IGNORE INTO staff_roles (faculty_id,role) VALUES (@it_ca1_fid,'CLASS_ADVISOR');

-- IT Faculty 4
INSERT INTO users (username,password,visible_password,email,role,is_active,created_at) VALUES
('STF_IT_F04',@pass,'Demo@1234','it.faculty04@college.edu','FACULTY',1,NOW())
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
INSERT IGNORE INTO faculty (user_id,staff_id,first_name,last_name,department_id,designation,phone,whatsapp_number,dob,blood_group,is_active)
VALUES (LAST_INSERT_ID(),'STF-IT005','Murugan','Doss',(SELECT id FROM departments WHERE code='IT' LIMIT 1),'Assistant Professor','8500000014','8500000014','1983-06-05','AB+',1);

-- IT Faculty 5 (cross-dept — teaches AIDS subjects too)
INSERT INTO users (username,password,visible_password,email,role,is_active,created_at) VALUES
('STF_IT_CROSS',@pass,'Demo@1234','it.cross01@college.edu','FACULTY',1,NOW())
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
INSERT IGNORE INTO faculty (user_id,staff_id,first_name,last_name,department_id,designation,phone,whatsapp_number,dob,blood_group,is_active)
VALUES (LAST_INSERT_ID(),'STF-IT006','Kavitha','Nair',(SELECT id FROM departments WHERE code='IT' LIMIT 1),'Associate Professor','8500000015','8500000015','1979-09-30','B-',1);

-- ── ECE DEPARTMENT ─────────────────────────────────────────
INSERT INTO users (username,password,visible_password,email,role,is_active,created_at) VALUES
('STF_ECE_HOD',@pass,'Demo@1234','hod.ece@college.edu','HOD',1,NOW())
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @ece_hod_uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id,staff_id,first_name,last_name,department_id,designation,phone,whatsapp_number,dob,blood_group,is_active)
VALUES (@ece_hod_uid,'STF-ECE001','Dr. Saravanan','Pillai',(SELECT id FROM departments WHERE code='ECE' LIMIT 1),'Professor & HOD','8500000020','8500000020','1970-12-01','A+',1);
SET @ece_hod_fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id,role) VALUES (@ece_hod_fid,'HOD');
INSERT IGNORE INTO staff_roles (faculty_id,role) VALUES (@ece_hod_fid,'FACULTY');

INSERT INTO users (username,password,visible_password,email,role,is_active,created_at) VALUES
('STF_ECE_F01',@pass,'Demo@1234','ece.faculty01@college.edu','FACULTY',1,NOW())
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
INSERT IGNORE INTO faculty (user_id,staff_id,first_name,last_name,department_id,designation,phone,whatsapp_number,dob,blood_group,is_active)
VALUES (LAST_INSERT_ID(),'STF-ECE002','Lakshmi','Subramanian',(SELECT id FROM departments WHERE code='ECE' LIMIT 1),'Assistant Professor','8500000021','8500000021','1986-02-14','O+',1);

INSERT INTO users (username,password,visible_password,email,role,is_active,created_at) VALUES
('STF_ECE_F02',@pass,'Demo@1234','ece.faculty02@college.edu','FACULTY',1,NOW())
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
INSERT IGNORE INTO faculty (user_id,staff_id,first_name,last_name,department_id,designation,phone,whatsapp_number,dob,blood_group,is_active)
VALUES (LAST_INSERT_ID(),'STF-ECE003','Arun','Balaji',(SELECT id FROM departments WHERE code='ECE' LIMIT 1),'Associate Professor','8500000022','8500000022','1981-07-22','B+',1);

INSERT INTO users (username,password,visible_password,email,role,is_active,created_at) VALUES
('STF_ECE_CA01',@pass,'Demo@1234','ece.advisor01@college.edu','ADVISOR',1,NOW())
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @ece_ca1_uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id,staff_id,first_name,last_name,department_id,designation,phone,whatsapp_number,dob,blood_group,is_active)
VALUES (@ece_ca1_uid,'STF-ECE004','Sudha','Venkat',(SELECT id FROM departments WHERE code='ECE' LIMIT 1),'Assistant Professor','8500000023','8500000023','1987-04-08','AB-',1);
SET @ece_ca1_fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id,role) VALUES (@ece_ca1_fid,'FACULTY');
INSERT IGNORE INTO staff_roles (faculty_id,role) VALUES (@ece_ca1_fid,'CLASS_ADVISOR');

-- ECE cross-dept (teaches IT subjects)
INSERT INTO users (username,password,visible_password,email,role,is_active,created_at) VALUES
('STF_ECE_CROSS',@pass,'Demo@1234','ece.cross01@college.edu','FACULTY',1,NOW())
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
INSERT IGNORE INTO faculty (user_id,staff_id,first_name,last_name,department_id,designation,phone,whatsapp_number,dob,blood_group,is_active)
VALUES (LAST_INSERT_ID(),'STF-ECE005','Bharath','Raj',(SELECT id FROM departments WHERE code='ECE' LIMIT 1),'Assistant Professor','8500000024','8500000024','1984-10-16','O+',1);

-- ── EEE DEPARTMENT ─────────────────────────────────────────
INSERT INTO users (username,password,visible_password,email,role,is_active,created_at) VALUES
('STF_EEE_HOD',@pass,'Demo@1234','hod.eee@college.edu','HOD',1,NOW())
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @eee_hod_uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id,staff_id,first_name,last_name,department_id,designation,phone,whatsapp_number,dob,blood_group,is_active)
VALUES (@eee_hod_uid,'STF-EEE001','Dr. Padmanabhan','Iyer',(SELECT id FROM departments WHERE code='EEE' LIMIT 1),'Professor & HOD','8500000030','8500000030','1969-08-28','A+',1);
SET @eee_hod_fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id,role) VALUES (@eee_hod_fid,'HOD');
INSERT IGNORE INTO staff_roles (faculty_id,role) VALUES (@eee_hod_fid,'FACULTY');

INSERT INTO users (username,password,visible_password,email,role,is_active,created_at) VALUES
('STF_EEE_F01',@pass,'Demo@1234','eee.faculty01@college.edu','FACULTY',1,NOW())
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
INSERT IGNORE INTO faculty (user_id,staff_id,first_name,last_name,department_id,designation,phone,whatsapp_number,dob,blood_group,is_active)
VALUES (LAST_INSERT_ID(),'STF-EEE002','Nirmala','Devi',(SELECT id FROM departments WHERE code='EEE' LIMIT 1),'Associate Professor','8500000031','8500000031','1982-01-19','B+',1);

INSERT INTO users (username,password,visible_password,email,role,is_active,created_at) VALUES
('STF_EEE_F02',@pass,'Demo@1234','eee.faculty02@college.edu','FACULTY',1,NOW())
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
INSERT IGNORE INTO faculty (user_id,staff_id,first_name,last_name,department_id,designation,phone,whatsapp_number,dob,blood_group,is_active)
VALUES (LAST_INSERT_ID(),'STF-EEE003','Ganesh','Mohan',(SELECT id FROM departments WHERE code='EEE' LIMIT 1),'Assistant Professor','8500000032','8500000032','1986-05-30','O+',1);

INSERT INTO users (username,password,visible_password,email,role,is_active,created_at) VALUES
('STF_EEE_CA01',@pass,'Demo@1234','eee.advisor01@college.edu','ADVISOR',1,NOW())
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @eee_ca1_fid_u = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id,staff_id,first_name,last_name,department_id,designation,phone,whatsapp_number,dob,blood_group,is_active)
VALUES (@eee_ca1_fid_u,'STF-EEE004','Revathi','Natarajan',(SELECT id FROM departments WHERE code='EEE' LIMIT 1),'Assistant Professor','8500000033','8500000033','1989-09-09','AB+',1);
SET @eee_ca1_fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id,role) VALUES (@eee_ca1_fid,'FACULTY');
INSERT IGNORE INTO staff_roles (faculty_id,role) VALUES (@eee_ca1_fid,'CLASS_ADVISOR');

INSERT INTO users (username,password,visible_password,email,role,is_active,created_at) VALUES
('STF_EEE_F04',@pass,'Demo@1234','eee.faculty04@college.edu','FACULTY',1,NOW())
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
INSERT IGNORE INTO faculty (user_id,staff_id,first_name,last_name,department_id,designation,phone,whatsapp_number,dob,blood_group,is_active)
VALUES (LAST_INSERT_ID(),'STF-EEE005','Tamizharasan','G',(SELECT id FROM departments WHERE code='EEE' LIMIT 1),'Assistant Professor','8500000034','8500000034','1983-12-25','B-',1);

-- ── MECH DEPARTMENT ────────────────────────────────────────
INSERT INTO users (username,password,visible_password,email,role,is_active,created_at) VALUES
('STF_MECH_HOD',@pass,'Demo@1234','hod.mech@college.edu','HOD',1,NOW())
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @mech_hod_uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id,staff_id,first_name,last_name,department_id,designation,phone,whatsapp_number,dob,blood_group,is_active)
VALUES (@mech_hod_uid,'STF-MECH001','Dr. Balasubramanian','S',(SELECT id FROM departments WHERE code='MECH' LIMIT 1),'Professor & HOD','8500000040','8500000040','1968-03-17','O+',1);
SET @mech_hod_fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id,role) VALUES (@mech_hod_fid,'HOD');
INSERT IGNORE INTO staff_roles (faculty_id,role) VALUES (@mech_hod_fid,'FACULTY');

INSERT INTO users (username,password,visible_password,email,role,is_active,created_at) VALUES
('STF_MECH_F01',@pass,'Demo@1234','mech.faculty01@college.edu','FACULTY',1,NOW())
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
INSERT IGNORE INTO faculty (user_id,staff_id,first_name,last_name,department_id,designation,phone,whatsapp_number,dob,blood_group,is_active)
VALUES (LAST_INSERT_ID(),'STF-MECH002','Rajan','Krishnaswamy',(SELECT id FROM departments WHERE code='MECH' LIMIT 1),'Associate Professor','8500000041','8500000041','1978-07-04','A+',1);

INSERT INTO users (username,password,visible_password,email,role,is_active,created_at) VALUES
('STF_MECH_F02',@pass,'Demo@1234','mech.faculty02@college.edu','FACULTY',1,NOW())
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
INSERT IGNORE INTO faculty (user_id,staff_id,first_name,last_name,department_id,designation,phone,whatsapp_number,dob,blood_group,is_active)
VALUES (LAST_INSERT_ID(),'STF-MECH003','Senthil','Vadivu',(SELECT id FROM departments WHERE code='MECH' LIMIT 1),'Assistant Professor','8500000042','8500000042','1985-11-11','B+',1);

INSERT INTO users (username,password,visible_password,email,role,is_active,created_at) VALUES
('STF_MECH_CA01',@pass,'Demo@1234','mech.advisor01@college.edu','ADVISOR',1,NOW())
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @mech_ca1_u = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id,staff_id,first_name,last_name,department_id,designation,phone,whatsapp_number,dob,blood_group,is_active)
VALUES (@mech_ca1_u,'STF-MECH004','Kala','Sivakumar',(SELECT id FROM departments WHERE code='MECH' LIMIT 1),'Assistant Professor','8500000043','8500000043','1990-02-28','O-',1);
SET @mech_ca1_fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id,role) VALUES (@mech_ca1_fid,'FACULTY');
INSERT IGNORE INTO staff_roles (faculty_id,role) VALUES (@mech_ca1_fid,'CLASS_ADVISOR');

INSERT INTO users (username,password,visible_password,email,role,is_active,created_at) VALUES
('STF_MECH_F04',@pass,'Demo@1234','mech.faculty04@college.edu','FACULTY',1,NOW())
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
INSERT IGNORE INTO faculty (user_id,staff_id,first_name,last_name,department_id,designation,phone,whatsapp_number,dob,blood_group,is_active)
VALUES (LAST_INSERT_ID(),'STF-MECH005','Durai','Pandian',(SELECT id FROM departments WHERE code='MECH' LIMIT 1),'Assistant Professor','8500000044','8500000044','1982-08-15','AB+',1);

-- ── CIVIL DEPARTMENT ───────────────────────────────────────
INSERT INTO users (username,password,visible_password,email,role,is_active,created_at) VALUES
('STF_CIVIL_HOD',@pass,'Demo@1234','hod.civil@college.edu','HOD',1,NOW())
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @civil_hod_uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id,staff_id,first_name,last_name,department_id,designation,phone,whatsapp_number,dob,blood_group,is_active)
VALUES (@civil_hod_uid,'STF-CIV001','Dr. Jeyagowri','P',(SELECT id FROM departments WHERE code='CIVIL' LIMIT 1),'Professor & HOD','8500000050','8500000050','1971-06-22','B+',1);
SET @civil_hod_fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id,role) VALUES (@civil_hod_fid,'HOD');
INSERT IGNORE INTO staff_roles (faculty_id,role) VALUES (@civil_hod_fid,'FACULTY');

INSERT INTO users (username,password,visible_password,email,role,is_active,created_at) VALUES
('STF_CIVIL_F01',@pass,'Demo@1234','civil.faculty01@college.edu','FACULTY',1,NOW())
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
INSERT IGNORE INTO faculty (user_id,staff_id,first_name,last_name,department_id,designation,phone,whatsapp_number,dob,blood_group,is_active)
VALUES (LAST_INSERT_ID(),'STF-CIV002','Ramachandran','Naidu',(SELECT id FROM departments WHERE code='CIVIL' LIMIT 1),'Associate Professor','8500000051','8500000051','1977-10-03','O+',1);

INSERT INTO users (username,password,visible_password,email,role,is_active,created_at) VALUES
('STF_CIVIL_F02',@pass,'Demo@1234','civil.faculty02@college.edu','FACULTY',1,NOW())
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
INSERT IGNORE INTO faculty (user_id,staff_id,first_name,last_name,department_id,designation,phone,whatsapp_number,dob,blood_group,is_active)
VALUES (LAST_INSERT_ID(),'STF-CIV003','Tamilselvi','C',(SELECT id FROM departments WHERE code='CIVIL' LIMIT 1),'Assistant Professor','8500000052','8500000052','1984-04-19','A-',1);

INSERT INTO users (username,password,visible_password,email,role,is_active,created_at) VALUES
('STF_CIVIL_CA01',@pass,'Demo@1234','civil.advisor01@college.edu','ADVISOR',1,NOW())
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @civil_ca1_u = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id,staff_id,first_name,last_name,department_id,designation,phone,whatsapp_number,dob,blood_group,is_active)
VALUES (@civil_ca1_u,'STF-CIV004','Indira','Raman',(SELECT id FROM departments WHERE code='CIVIL' LIMIT 1),'Assistant Professor','8500000053','8500000053','1988-08-08','B+',1);
SET @civil_ca1_fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id,role) VALUES (@civil_ca1_fid,'FACULTY');
INSERT IGNORE INTO staff_roles (faculty_id,role) VALUES (@civil_ca1_fid,'CLASS_ADVISOR');

INSERT INTO users (username,password,visible_password,email,role,is_active,created_at) VALUES
('STF_CIVIL_F04',@pass,'Demo@1234','civil.faculty04@college.edu','FACULTY',1,NOW())
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
INSERT IGNORE INTO faculty (user_id,staff_id,first_name,last_name,department_id,designation,phone,whatsapp_number,dob,blood_group,is_active)
VALUES (LAST_INSERT_ID(),'STF-CIV005','Arulkumar','S',(SELECT id FROM departments WHERE code='CIVIL' LIMIT 1),'Assistant Professor','8500000054','8500000054','1981-03-27','O+',1);

-- ── AIDS DEPARTMENT ────────────────────────────────────────
INSERT INTO users (username,password,visible_password,email,role,is_active,created_at) VALUES
('STF_AIDS_HOD',@pass,'Demo@1234','hod.aids@college.edu','HOD',1,NOW())
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @aids_hod_uid = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id,staff_id,first_name,last_name,department_id,designation,phone,whatsapp_number,dob,blood_group,is_active)
VALUES (@aids_hod_uid,'STF-AIDS001','Dr. Mythili','Krishnan',(SELECT id FROM departments WHERE code='AIDS' LIMIT 1),'Professor & HOD','8500000060','8500000060','1973-11-30','AB+',1);
SET @aids_hod_fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id,role) VALUES (@aids_hod_fid,'HOD');
INSERT IGNORE INTO staff_roles (faculty_id,role) VALUES (@aids_hod_fid,'FACULTY');

INSERT INTO users (username,password,visible_password,email,role,is_active,created_at) VALUES
('STF_AIDS_F01',@pass,'Demo@1234','aids.faculty01@college.edu','FACULTY',1,NOW())
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
INSERT IGNORE INTO faculty (user_id,staff_id,first_name,last_name,department_id,designation,phone,whatsapp_number,dob,blood_group,is_active)
VALUES (LAST_INSERT_ID(),'STF-AIDS002','Harish','Babu',(SELECT id FROM departments WHERE code='AIDS' LIMIT 1),'Associate Professor','8500000061','8500000061','1980-09-14','O+',1);

INSERT INTO users (username,password,visible_password,email,role,is_active,created_at) VALUES
('STF_AIDS_F02',@pass,'Demo@1234','aids.faculty02@college.edu','FACULTY',1,NOW())
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
INSERT IGNORE INTO faculty (user_id,staff_id,first_name,last_name,department_id,designation,phone,whatsapp_number,dob,blood_group,is_active)
VALUES (LAST_INSERT_ID(),'STF-AIDS003','Sangeetha','M',(SELECT id FROM departments WHERE code='AIDS' LIMIT 1),'Assistant Professor','8500000062','8500000062','1987-02-02','B+',1);

INSERT INTO users (username,password,visible_password,email,role,is_active,created_at) VALUES
('STF_AIDS_CA01',@pass,'Demo@1234','aids.advisor01@college.edu','ADVISOR',1,NOW())
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
SET @aids_ca1_u = LAST_INSERT_ID();
INSERT IGNORE INTO faculty (user_id,staff_id,first_name,last_name,department_id,designation,phone,whatsapp_number,dob,blood_group,is_active)
VALUES (@aids_ca1_u,'STF-AIDS004','Deepika','Rajan',(SELECT id FROM departments WHERE code='AIDS' LIMIT 1),'Assistant Professor','8500000063','8500000063','1991-06-11','A+',1);
SET @aids_ca1_fid = LAST_INSERT_ID();
INSERT IGNORE INTO staff_roles (faculty_id,role) VALUES (@aids_ca1_fid,'FACULTY');
INSERT IGNORE INTO staff_roles (faculty_id,role) VALUES (@aids_ca1_fid,'CLASS_ADVISOR');

INSERT INTO users (username,password,visible_password,email,role,is_active,created_at) VALUES
('STF_AIDS_F04',@pass,'Demo@1234','aids.faculty04@college.edu','FACULTY',1,NOW())
ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);
INSERT IGNORE INTO faculty (user_id,staff_id,first_name,last_name,department_id,designation,phone,whatsapp_number,dob,blood_group,is_active)
VALUES (LAST_INSERT_ID(),'STF-AIDS005','Praveen','Mohan',(SELECT id FROM departments WHERE code='AIDS' LIMIT 1),'Assistant Professor','8500000064','8500000064','1986-07-07','O-',1);

SELECT 'Part 1 Staff Complete — Next run seed_part2_students.sql' AS Status;
