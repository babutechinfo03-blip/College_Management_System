-- ============================================================
-- FIX STUDENT LOGIN
-- Sets all student passwords to 'Demo@1234'
-- ============================================================

SET @h = '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy';

UPDATE users 
SET password = @h, 
    visible_password = 'Demo@1234'
WHERE role = 'STUDENT';

-- Verify
SELECT username, role, LENGTH(password) as hash_len 
FROM users 
WHERE role = 'STUDENT' 
LIMIT 5;
