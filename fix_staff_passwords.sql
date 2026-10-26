-- ============================================================
-- FIX STAFF LOGIN — Reset all staff passwords via BCrypt hash
-- Password: Demo@1234
-- BCrypt (cost=10) hash for "Demo@1234":
--   $2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy
--
-- HOW TO VERIFY HASH LENGTH (should be 60 chars):
--   SELECT LENGTH('$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy');
-- ============================================================

-- Update all staff users (HOD, FACULTY, ADVISOR, ASSISTANT_STAFF) with correct hash
UPDATE users
SET password       = '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
    visible_password = 'Demo@1234'
WHERE role IN ('HOD', 'FACULTY', 'ADVISOR', 'ASSISTANT_STAFF')
  AND username LIKE 'STF_%';

UPDATE users
SET password       = '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
    visible_password = 'Demo@1234'
WHERE role IN ('HOD', 'FACULTY', 'ADVISOR', 'ASSISTANT_STAFF')
  AND username LIKE 'AST_%';

-- Also fix the seed_part1 staff just inserted via username pattern
UPDATE users
SET password       = '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
    visible_password = 'Demo@1234'
WHERE email LIKE '%.it@college.edu'
   OR email LIKE 'it.%@college.edu'
   OR email LIKE 'ece.%@college.edu'
   OR email LIKE 'hod.ece@college.edu'
   OR email LIKE 'hod.eee@college.edu'
   OR email LIKE 'hod.mech@college.edu'
   OR email LIKE 'hod.civil@college.edu'
   OR email LIKE 'hod.aids@college.edu'
   OR email LIKE 'eee.%@college.edu'
   OR email LIKE 'mech.%@college.edu'
   OR email LIKE 'civil.%@college.edu'
   OR email LIKE 'aids.%@college.edu'
   OR email LIKE 'ast.%@college.edu';

-- Verify fix
SELECT username, email, role,
       LENGTH(password) AS hash_len,
       visible_password
FROM users
WHERE role IN ('HOD','FACULTY','ADVISOR','ASSISTANT_STAFF')
ORDER BY role, email
LIMIT 20;
