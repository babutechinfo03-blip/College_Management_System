-- ============================================================
-- FINAL LOGIN FIX — Uses the SAME password hash as STF001 (admin123)
-- All new staff will use: password = admin123
-- Run this in MySQL — safe to re-run
-- ============================================================

-- Step 1: Copy the working hash from STF001 (system-seeded HOD)
SET @working_hash = (SELECT password FROM users WHERE username = 'STF001' LIMIT 1);

-- Verify the hash was found (should show 60)
SELECT LENGTH(@working_hash) AS hash_len, LEFT(@working_hash, 15) AS hash_preview;

-- Step 2: Apply this working hash to ALL new staff we inserted
UPDATE users
SET password         = @working_hash,
    visible_password = 'admin123'
WHERE role IN ('HOD', 'FACULTY', 'ADVISOR', 'ASSISTANT_STAFF')
  AND username != 'STF001'
  AND username != 'STF002'
  AND username != 'AST001';

-- Step 3: Verify all staff have correct hash
SELECT
    f.staff_id,
    u.username,
    u.role,
    u.email,
    LENGTH(u.password) AS hash_len,
    u.visible_password AS password_to_use
FROM faculty f
JOIN users u ON u.id = f.user_id
ORDER BY u.role, f.staff_id;

SELECT 'SUCCESS: All staff now use password = admin123' AS Result;
