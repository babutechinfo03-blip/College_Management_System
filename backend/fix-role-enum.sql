-- Fix Missing OFFICE Role in Database

USE college_erp;

-- Option 1: Alter existing table to add OFFICE to ENUM
ALTER TABLE users MODIFY COLUMN role ENUM('PRINCIPAL', 'OFFICE', 'HOD', 'FACULTY', 'ADVISOR', 'ASSISTANT_STAFF', 'STUDENT', 'PARENT') NOT NULL;

-- Verify the change
DESCRIBE users;

-- Check if any users exist
SELECT username, role, is_active FROM users;
