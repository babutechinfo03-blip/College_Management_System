-- ================================================
-- DATABASE AUDIT AND FIX SCRIPT
-- ================================================
-- This script verifies and fixes authentication issues

USE college_erp;

-- ================================================
-- STEP 1: VERIFY TABLE STRUCTURE
-- ================================================
DESCRIBE users;

-- ================================================
-- STEP 2: CHECK EXISTING USERS
-- ================================================
SELECT 
    id,
    username,
    email,
    role,
    is_active,
    LEFT(password, 20) as password_hash_preview,
    created_at
FROM users
ORDER BY id;

-- ================================================
-- STEP 3: VERIFY PASSWORD HASHES ARE BCRYPT
-- ================================================
-- BCrypt hashes start with $2a$, $2b$, or $2y$ and are 60 characters long
SELECT 
    username,
    role,
    CASE 
        WHEN password LIKE '$2a$%' OR password LIKE '$2b$%' OR password LIKE '$2y$%' THEN 'BCrypt ✓'
        ELSE 'INVALID - Not BCrypt!'
    END as password_format,
    LENGTH(password) as password_length,
    is_active
FROM users;

-- ================================================
-- STEP 4: VERIFY ALL USERS ARE ACTIVE
-- ================================================
SELECT 
    username,
    role,
    is_active,
    CASE 
        WHEN is_active = 1 THEN 'Active ✓'
        ELSE 'DISABLED - FIX REQUIRED!'
    END as status
FROM users;

-- ================================================
-- STEP 5: VERIFY ROLE VALUES MATCH ENUM
-- ================================================
-- Valid roles: PRINCIPAL, OFFICE, HOD, FACULTY, ADVISOR, ASSISTANT_STAFF, STUDENT, PARENT
SELECT 
    username,
    role,
    CASE 
        WHEN role IN ('PRINCIPAL', 'OFFICE', 'HOD', 'FACULTY', 'ADVISOR', 'ASSISTANT_STAFF', 'STUDENT', 'PARENT') 
        THEN 'Valid ✓'
        ELSE 'INVALID ROLE!'
    END as role_validation
FROM users;

-- ================================================
-- STEP 6: COUNT USERS BY ROLE
-- ================================================
SELECT 
    role,
    COUNT(*) as user_count,
    SUM(CASE WHEN is_active = 1 THEN 1 ELSE 0 END) as active_count
FROM users
GROUP BY role
ORDER BY role;

-- ================================================
-- STEP 7: FIX - ENABLE ALL USERS IF DISABLED
-- ================================================
-- Uncomment the line below to activate all users
-- UPDATE users SET is_active = 1 WHERE is_active = 0;

-- ================================================
-- STEP 8: VERIFY NO NULL VALUES
-- ================================================
SELECT 
    'NULL username' as issue,
    COUNT(*) as count
FROM users 
WHERE username IS NULL
UNION ALL
SELECT 
    'NULL password' as issue,
    COUNT(*) as count
FROM users 
WHERE password IS NULL
UNION ALL
SELECT 
    'NULL role' as issue,
    COUNT(*) as count
FROM users 
WHERE role IS NULL
UNION ALL
SELECT 
    'NULL email' as issue,
    COUNT(*) as count
FROM users 
WHERE email IS NULL;

-- ================================================
-- STEP 9: TEST CREDENTIALS SUMMARY
-- ================================================
SELECT 
    '=== TEST CREDENTIALS ===' as info
UNION ALL
SELECT CONCAT('Principal: principal / admin123 (Role: ', role, ')') 
FROM users WHERE username = 'principal'
UNION ALL
SELECT CONCAT('Office: office / office123 (Role: ', role, ')') 
FROM users WHERE username = 'office'
UNION ALL
SELECT CONCAT('HOD: hod / hod123 (Role: ', role, ')') 
FROM users WHERE username = 'hod'
UNION ALL
SELECT CONCAT('Faculty: faculty / faculty123 (Role: ', role, ')') 
FROM users WHERE username = 'faculty'
UNION ALL
SELECT CONCAT('Advisor: advisor / advisor123 (Role: ', role, ')') 
FROM users WHERE username = 'advisor'
UNION ALL
SELECT CONCAT('Assistant: assistant / assistant123 (Role: ', role, ')') 
FROM users WHERE username = 'assistant'
UNION ALL
SELECT CONCAT('Student: student / student123 (Role: ', role, ')') 
FROM users WHERE username = 'student';
