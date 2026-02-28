import random

# Configuration
STUDENT_DEPTS = ['CSE', 'ECE', 'IT']
FACULTY_DEPTS = ['CSE', 'ECE', 'IT', 'MECH', 'CIVIL'] # Assuming these might exist
YEARS = [1, 2, 3, 4]
STUDENT_COUNT = 50 
FACULTY_COUNT_MIN = 8
FACULTY_COUNT_MAX = 12
ASSISTANT_COUNT_MIN = 5
ASSISTANT_COUNT_MAX = 8

# Phone number generator
current_phone = 9000000000
def get_phone():
    global current_phone
    p = str(current_phone)
    current_phone += 1
    return p

# Determine Join Year based on Current Year (2026)
# Current Year 1 (2025-2029) -> Joined 2025
# Current Year 2 (2024-2028) -> Joined 2024
# Current Year 3 (2023-2027) -> Joined 2023
# Current Year 4 (2022-2026) -> Joined 2022
def get_batch_and_prefix(year):
    join_year = 2026 - year
    end_year = join_year + 4
    batch = f"{join_year}-{end_year}"
    return join_year, batch

sql = []
sql.append("SELECT 'Starting Import...' as DebugMessage;")
sql.append("-- DUMMY DATA INSERTS") 

# ... (middle content)

# Output
with open('dummy_data.sql', 'w', encoding='utf-8') as f:
    f.write('\n'.join(sql))
sql.append("-- Encoded Password: 'password'")
sql.append("SET @default_pass = '$2a$10$eAccYoNOHEqXve8aIWT8Nu3.hD.S.yveD..p/';")

# 1. STUDENTS
for dept in STUDENT_DEPTS:
    degree = 'BE' if dept != 'IT' else 'BTECH'
    
    for year in YEARS:
        join_year, batch = get_batch_and_prefix(year)
        
        for i in range(1, STUDENT_COUNT + 1):
            # ID Pattern: YEAR + DEPT + SEQ (2024CSE001)
            # Use 'join_year' for the prefix to match typical logic
            seq = str(i).zfill(3)
            student_id = f"{join_year}{dept}{seq}"
            email = f"{student_id.lower()}@college.edu"
            phone = get_phone()
            
            # User Insert
            sql.append(f"INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('{student_id}', @default_pass, '{email}', 'STUDENT', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);")
            sql.append("SET @uid = LAST_INSERT_ID();")
            
            # Student Insert
            # Using subqueries for safety
            sql.append(f"""INSERT IGNORE INTO students (user_id, student_id, first_name, last_name, degree_id, specialization_id, current_year, current_semester, batch, address, phone, whatsapp_number, is_active)
SELECT @uid, '{student_id}', 'Student', '{seq}',
(SELECT id FROM degrees WHERE code='{degree}' LIMIT 1),
(SELECT id FROM specializations WHERE code='{dept}' LIMIT 1),
{year}, {year * 2}, '{batch}', 'Chennai, India', '{phone}', '{phone}', 1;""")

# 2. FACULTY
for dept in FACULTY_DEPTS:
    # Check if we should generate for this dept. 
    # Use insert ignore logic or rely on valid dept code.
    # To be safe, we will use the subquery validation.
    # If subquery returns NULL, column cannot be null -> Error.
    # We will assume these departments exist.
    
    count = random.randint(FACULTY_COUNT_MIN, FACULTY_COUNT_MAX)
    for i in range(1, count + 1):
        seq = str(i).zfill(3)
        staff_id = f"FAC{dept}{seq}"
        fname = f"Faculty{dept}{i}"
        lname = "Staff"
        email = f"{fname.lower()}.{lname.lower()}@college.edu"
        phone = get_phone()
        
        sql.append(f"INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('{staff_id}', @default_pass, '{email}', 'FACULTY', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);")
        sql.append("SET @uid = LAST_INSERT_ID();")
        
        sql.append(f"""INSERT IGNORE INTO faculty (user_id, staff_id, first_name, last_name, department_id, designation, phone, whatsapp_number, is_active)
SELECT @uid, '{staff_id}', '{fname}', '{lname}',
(SELECT id FROM departments WHERE code='{dept}' LIMIT 1),
'Assistant Professor', '{phone}', '{phone}', 1;""")
        
        # Add Staff Role
        sql.append("SET @fid = LAST_INSERT_ID();")
        sql.append(f"INSERT IGNORE INTO staff_roles (faculty_id, role) VALUES (@fid, 'FACULTY');")

# 3. ASSISTANT STAFF
for dept in FACULTY_DEPTS:
    count = random.randint(ASSISTANT_COUNT_MIN, ASSISTANT_COUNT_MAX)
    for i in range(1, count + 1):
        # AST + 4 digit? "AST0123". Unique across college?
        # Prompt: "Assistant Staff ID: AST + 4-digit sequence"
        # We need a global sequence or per dept? "AST + 4-digit sequence Example: AST0123" suggests global or long number.
        # Let's use a unique sequence based on dept to avoid collision.
        # We'll use a rigorous counter or random?
        # Let's specific ranges per dept to ensure uniqueness easily.
        # CSE: 1000+, ECE 2000+?
        # Or just global counter.
        
        pass # Handle in loop below to maintain global counter context if needed, but here simple is fine.

# Global counter for Assistant Staff to ensure ASTxxxx uniqueness
ast_counter = 1

for dept in FACULTY_DEPTS:
    count = random.randint(ASSISTANT_COUNT_MIN, ASSISTANT_COUNT_MAX)
    for i in range(1, count + 1):
        seq = str(ast_counter).zfill(4)
        ast_id = f"AST{seq}"
        ast_counter += 1
        
        fname = f"Assistant{seq}"
        lname = "Staff"
        email = f"{fname.lower()}.staff@college.edu"
        phone = get_phone()
        
        sql.append(f"INSERT INTO users (username, password, email, role, is_active, created_at) VALUES ('{ast_id}', @default_pass, '{email}', 'ASSISTANT_STAFF', 1, NOW()) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id);")
        sql.append("SET @uid = LAST_INSERT_ID();")
        
        sql.append(f"""INSERT IGNORE INTO assistant_staff (user_id, assistant_id, first_name, last_name, department_id, designation, phone, is_active)
SELECT @uid, '{ast_id}', '{fname}', '{lname}',
(SELECT id FROM departments WHERE code='{dept}' LIMIT 1),
'Lab Assistant', '{phone}', 1;""")

# Output
with open('dummy_data.sql', 'w') as f:
    f.write('\n'.join(sql))

print("SQL Generated successfully.")
