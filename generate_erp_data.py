import random
import datetime

# Configuration
TOTAL_STUDENTS = 5280 # 22 depts * 4 years * 60 students (avg)
STUDENTS_PER_YEAR = 60
BCRYPT_HASH = "$2a$10$8.UnVuG9HHgffUDAlk8qfOuVGkqRzgVymGe07xd00DMxs.TVuHOn2" # Demo@1234
VISIBLE_PWD = "Demo@1234"

# Academic Structure
UG_BE_DEPTS = [
    ("Computer Science Engineering", "CSE"),
    ("Information Technology", "IT"),
    ("Electronics and Communication Engineering", "ECE"),
    ("Mechanical Engineering", "MECH"),
    ("Civil Engineering", "CIVIL"),
    ("Electrical and Electronics Engineering", "EEE"),
    ("Artificial Intelligence and Data Science", "AIDS")
]

UG_BTECH_DEPTS = [
    ("Artificial Intelligence and Machine Learning", "AIML"),
    ("Data Science", "DS"),
    ("Cyber Security", "CYS"),
    ("Computer Engineering", "COMP"),
    ("Information Technology (BTech)", "IT-B")
]

PG_DEPTS = [
    ("MBA", "MBA"),
    ("MCA", "MCA"),
    ("ME Computer Science", "MECS"),
    ("ME Structural Engineering", "MESE"),
    ("ME Power Electronics", "MEPE"),
    ("ME Communication Systems", "MECS2"),
    ("MTech Artificial Intelligence", "MTAI"),
    ("MTech Data Science", "MTDS"),
    ("MTech Cyber Security", "MTCYS"),
    ("MTech Software Engineering", "MTSE"),
    ("MTech Robotics", "MTROB"),
    ("MTech Embedded Systems", "MTEMB"),
    ("MTech Cloud Computing", "MTCC")
]

ALL_DEPTS = []
for name, code in UG_BE_DEPTS:
    ALL_DEPTS.append({"name": name, "code": code, "type": "UG", "degree": "BE"})
for name, code in UG_BTECH_DEPTS:
    ALL_DEPTS.append({"name": name, "code": code, "type": "UG", "degree": "BTech"})
for name, code in PG_DEPTS:
    degree = "ME"
    if "MBA" in name: degree = "MBA"
    elif "MCA" in name: degree = "MCA"
    elif "MTech" in name: degree = "MTech"
    ALL_DEPTS.append({"name": name, "code": code, "type": "PG", "degree": degree})

# Sample Data
FIRST_NAMES = ["Arun", "Bala", "Chitra", "Deepak", "Eswari", "Farooq", "Ganesh", "Hari", "Indhu", "Jegan", "Kavita", "Lokesh", "Mani", "Naveen", "Oviya", "Prakash", "Qadir", "Ramya", "Sanjai", "Tharun", "Usha", "Varun", "Waseem", "Xavier", "Yuvraaj", "Zoya"]
LAST_NAMES = ["S", "R", "K", "M", "P", "A", "J", "V", " Kumar", " Devi", " Raja", " Mani"]
DESIGNATIONS = ["Professor", "Associate Professor", "Assistant Professor"]

sql_file = open("seed_erp_data.sql", "w", encoding="utf-8")
sql_file.write("SET FOREIGN_KEY_CHECKS = 0;\n")
sql_file.write("TRUNCATE TABLE users;\n")
sql_file.write("TRUNCATE TABLE departments;\n")
sql_file.write("TRUNCATE TABLE degrees;\n")
sql_file.write("TRUNCATE TABLE sections;\n")
sql_file.write("TRUNCATE TABLE students;\n")
sql_file.write("TRUNCATE TABLE faculty;\n")
sql_file.write("TRUNCATE TABLE assistant_staff;\n")
sql_file.write("TRUNCATE TABLE staff_roles;\n")
sql_file.write("TRUNCATE TABLE timetable_entries;\n")
sql_file.write("TRUNCATE TABLE mark_entries;\n")
sql_file.write("TRUNCATE TABLE attendance;\n")
sql_file.write("TRUNCATE TABLE attendance_header;\n")
sql_file.write("TRUNCATE TABLE circulars;\n")
sql_file.write("TRUNCATE TABLE semester_results;\n")
sql_file.write("TRUNCATE TABLE assignments;\n")
sql_file.write("TRUNCATE TABLE assignment_submissions;\n")
sql_file.write("SET FOREIGN_KEY_CHECKS = 1;\n\n")

# 1. Departments & Degrees
dept_id_map = {}
degree_id_map = {}
for i, d in enumerate(ALL_DEPTS):
    sql_file.write(f"INSERT INTO departments (id, name, code, type) VALUES ({i+1}, '{d['name']}', '{d['code']}', '{d['type']}');\n")
    dept_id_map[d['code']] = i + 1
    sql_file.write(f"INSERT INTO degrees (id, name, code, program_type, department_id) VALUES ({i+1}, '{d['degree']}', '{d['code']}_DEG', '{d['type']}', {i+1});\n")
    degree_id_map[d['code']] = i + 1

sql_file.write("\n")

# 2. Sections
section_id_map = {}
section_counter = 1
for d in ALL_DEPTS:
    years = 4 if d['type'] == 'UG' else 2
    for year in range(1, years + 1):
        sql_file.write(f"INSERT INTO sections (id, name, department_id, year) VALUES ({section_counter}, 'Section A', {dept_id_map[d['code']]}, {year});\n")
        section_id_map[(d['code'], year)] = section_counter
        section_counter += 1

sql_file.write("\n")

user_counter = 1
faculty_counter = 1
student_counter = 1
staff_counter = 1

# 3. Principal & Office (Special users)
sql_file.write(f"INSERT INTO users (id, username, password, visible_password, email, role, is_active) VALUES ({user_counter}, 'principal', '{BCRYPT_HASH}', '{VISIBLE_PWD}', 'principal@elite.edu', 'PRINCIPAL', 1);\n")
principal_user_id = user_counter
user_counter += 1

sql_file.write(f"INSERT INTO users (id, username, password, visible_password, email, role, is_active) VALUES ({user_counter}, 'office', '{BCRYPT_HASH}', '{VISIBLE_PWD}', 'office@elite.edu', 'OFFICE', 1);\n")
office_user_id = user_counter
user_counter += 1

# 4. Faculty
faculty_list = []
for d in ALL_DEPTS:
    num_faculty = random.randint(14, 18) # 22 depts * 15 avg = 330 faculty
    for f_idx in range(num_faculty + 1):
        role = "HOD" if f_idx == 0 else "FACULTY"
        designation = "Professor" if role == "HOD" else random.choice(DESIGNATIONS)
        fname = random.choice(FIRST_NAMES)
        lname = random.choice(LAST_NAMES)
        email = f"f_{f_idx}_{d['code'].lower()}@elite.edu"
        staff_id = f"STF_{d['code']}_{f_idx:02d}"
        sql_file.write(f"INSERT INTO users (id, username, password, visible_password, email, role, is_active) VALUES ({user_counter}, '{staff_id}', '{BCRYPT_HASH}', '{VISIBLE_PWD}', '{email}', '{role}', 1);\n")
        sql_file.write(f"INSERT INTO faculty (id, user_id, staff_id, first_name, last_name, department_id, designation, is_active) VALUES ({faculty_counter}, {user_counter}, '{staff_id}', '{fname}', '{lname}', {dept_id_map[d['code']]}, '{designation}', 1);\n")
        faculty_list.append({"id": faculty_counter, "dept": d['code'], "role": role, "user_id": user_counter})
        user_counter += 1
        faculty_counter += 1
    
    # Assistant Staff
    staff_id = f"AST_{d['code']}_01"
    email = f"ast_{d['code'].lower()}@elite.edu"
    sql_file.write(f"INSERT INTO users (id, username, password, visible_password, email, role, is_active) VALUES ({user_counter}, '{staff_id}', '{BCRYPT_HASH}', '{VISIBLE_PWD}', '{email}', 'ASSISTANT_STAFF', 1);\n")
    sql_file.write(f"INSERT INTO assistant_staff (id, user_id, assistant_id, first_name, last_name, department_id, is_active) VALUES ({staff_counter}, {user_counter}, '{staff_id}', '{random.choice(FIRST_NAMES)}', 'Staff', {dept_id_map[d['code']]}, 1);\n")
    user_counter += 1
    staff_counter += 1

sql_file.write("\n")

# 5. Students
student_list = []
print(f"Generating Approximately {TOTAL_STUDENTS} students...")
for d in ALL_DEPTS:
    years = 4 if d['type'] == 'UG' else 2
    for year in range(1, years + 1):
        for s_idx in range(1, STUDENTS_PER_YEAR + 1):
            student_id = f"202{5-year}{d['code']}{s_idx:03d}"
            fname = random.choice(FIRST_NAMES)
            lname = random.choice(LAST_NAMES)
            email = f"{student_id.lower()}@elite.edu"
            sql_file.write(f"INSERT INTO users (id, username, password, visible_password, email, role, is_active) VALUES ({user_counter}, '{student_id}', '{BCRYPT_HASH}', '{VISIBLE_PWD}', '{email}', 'STUDENT', 1);\n")
            sql_file.write(f"INSERT INTO students (id, user_id, student_id, first_name, last_name, degree_id, section_id, current_year, current_semester, batch, is_active) VALUES ({student_counter}, {user_counter}, '{student_id}', '{fname}', '{lname}', {degree_id_map[d['code']]}, {section_id_map[(d['code'], year)]}, {year}, {year*2-1}, '202{5-year}-202{9-year}', 1);\n")
            student_list.append({"id": student_counter, "dept": d['code'], "year": year, "sid": section_id_map[(d['code'], year)]})
            user_counter += 1
            student_counter += 1

sql_file.write("\n")

# 6. Subjects & Timetable
subjects = [
    ("MA101", "Engineering Mathematics", 4),
    ("PH101", "Engineering Physics", 3),
    ("CS101", "Programming in C", 4),
    ("EE101", "Basic Electrical Engg", 3),
    ("HS101", "Professional Ethics", 2)
]

faculty_schedule = {}

for d_code, year in section_id_map:
    sid = section_id_map[(d_code, year)]
    dept_faculty = [f for f in faculty_list if f['dept'] == d_code]
    for day in ["MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY"]:
        for hour in range(1, 6):
            subj = subjects[hour-1]
            available_facs = [f for f in dept_faculty if f['id'] not in faculty_schedule.get((day, hour), set())]
            if not available_facs:
                fac = random.choice(dept_faculty)
            else:
                fac = random.choice(available_facs)
            
            if (day, hour) not in faculty_schedule:
                faculty_schedule[(day, hour)] = set()
            faculty_schedule[(day, hour)].add(fac['id'])
            
            sql_file.write(f"INSERT INTO timetable_entries (department_id, year, semester, section_id, day_of_week, hour, subject_name, subject_code, faculty_id, type) VALUES ({dept_id_map[d_code]}, {year}, {year*2-1}, {sid}, '{day}', {hour}, '{subj[1]}', '{subj[0]}', {fac['id']}, 'LECTURE');\n")

sql_file.write("\n")

# 7. Attendance (Bulk sample)
print("Generating Attendance records...")
for s in student_list:
    for subj in subjects:
        for day_offset in range(20): # 5000 students * 5 subjects * 20 days = 500,000 records
            status = "PRESENT" if random.random() > 0.15 else "ABSENT"
            date = (datetime.date.today() - datetime.timedelta(days=day_offset)).isoformat()
            sql_file.write(f"INSERT INTO attendance (student_id, subject_code, date, status) VALUES ({s['id']}, '{subj[0]}', '{date}', '{status}');\n")

# 8. Marks (Bulk sample)
print("Generating Mark Entries...")
for s in student_list:
    for subj in subjects:
        marks = random.randint(30, 100)
        status = "APPROVED"
        sql_file.write(f"INSERT INTO mark_entries (student_id, subject_code, marks_obtained, max_marks, exam_type, semester, status, created_at) VALUES ({s['id']}, '{subj[0]}', {marks}, 100, 'INTERNAL', {s['year']*2-1}, '{status}', NOW());\n")

# 9. Assignments & Submissions
print("Generating Assignments and Submissions...")
assignment_counter = 1
for s in student_list:
    # Each student gets about 2 assignments per subject
    for subj in subjects:
        if random.random() > 0.5: # 50% chance for an assignment per student/subject combo to keep it around 500+ total assignments
            # Actually, total assignments should be > 500. 
            # If we generate 1 assignment per section/subject, that's better.
            pass

# Let's generate assignments per section instead
assignment_list = []
for (d_code, year), sid in section_id_map.items():
    dept_faculty = [f for f in faculty_list if f['dept'] == d_code]
    for subj in subjects:
        fac = random.choice(dept_faculty)
        deadline = (datetime.datetime.now() + datetime.timedelta(days=random.randint(1, 14))).strftime('%Y-%m-%d %H:%M:%S')
        sql_file.write(f"INSERT INTO assignments (id, title, description, faculty_id, section_id, subject_code, deadline, created_at) VALUES ({assignment_counter}, 'Assignment on {subj[1]}', 'Please submit by deadline.', {fac['id']}, {sid}, '{subj[0]}', '{deadline}', NOW());\n")
        assignment_list.append({"id": assignment_counter, "sid": sid})
        assignment_counter += 1

# Generate submissions for a subset of students
print(f"Generated {assignment_counter-1} assignments. Now generating submissions...")
submission_counter = 1
for s in student_list:
    # Find assignments for this student's section
    student_assignments = [a for a in assignment_list if a['sid'] == s['sid']]
    for a in student_assignments:
        if random.random() > 0.2: # 80% submission rate
            marks = random.randint(10, 20)
            sql_file.write(f"INSERT INTO assignment_submissions (id, assignment_id, student_id, file_path, file_name, submission_date, marks, status) VALUES ({submission_counter}, {a['id']}, {s['id']}, '/uploads/submissions/file_{submission_counter}.pdf', 'submission.pdf', NOW(), {marks}, 'GRADED');\n")
            submission_counter += 1

# 10. Results
print("Generating Semester Results...")
GRADES = ["O", "A+", "A", "B+", "B", "C"]
for s in student_list:
    for sem in range(1, s['year']*2 - 1):
        for subj in subjects:
            grade = random.choice(GRADES)
            sql_file.write(f"INSERT INTO semester_results (student_id, subject_code, subject_name, grade, credits, semester, result_status) VALUES ({s['id']}, '{subj[0]}', '{subj[1]}', '{grade}', {subj[2]}, {sem}, 'PASS');\n")

# 10. Circulars
# Correct schema: id, title, content, created_by, created_role, status, type, priority, is_active, created_at
print("Generating Circulars...")
circular_types = ["GENERAL", "TIMETABLE", "EXAM", "EVENT", "HOLIDAY", "ALERT", "FEE"]
for issuer_role, user_id in [("PRINCIPAL", principal_user_id), ("OFFICE", office_user_id)]:
    sql_file.write(f"INSERT INTO circulars (title, content, created_by, created_role, status, type, priority, is_active, created_at) VALUES ('Important Announcement', 'Please check the notice board.', {user_id}, '{issuer_role}', 'APPROVED', 'GENERAL', 'NORMAL', 1, NOW());\n")

# Add HOD circulars
for d in ALL_DEPTS:
    hod = next((f for f in faculty_list if f['dept'] == d['code'] and f['role'] == "HOD"), None)
    if hod:
        sql_file.write(f"INSERT INTO circulars (title, content, created_by, created_role, status, type, priority, is_active, created_at) VALUES ('Department Notice', 'Meeting tomorrow.', {hod['user_id']}, 'HOD', 'APPROVED', 'GENERAL', 'NORMAL', 1, NOW());\n")

sql_file.close()
print("Generation Complete. SQL saved to seed_erp_data.sql")
