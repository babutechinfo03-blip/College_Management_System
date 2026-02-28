-- Reset database for new test users
USE college_erp;

-- Delete all existing users
DELETE FROM users;

-- Verify deletion
SELECT COUNT(*) as user_count FROM users;
