@echo off
REM ================================================
REM Authentication Test Script
REM ================================================
REM Tests all login endpoints with correct credentials

echo ================================================
echo AUTHENTICATION SYSTEM TEST
echo ================================================
echo.

set BASE_URL=http://localhost:8080/api

echo Testing Principal Login...
curl -X POST %BASE_URL%/auth/principal/login ^
  -H "Content-Type: application/json" ^
  -d "{\"username\":\"principal\",\"password\":\"admin123\"}"
echo.
echo.

echo Testing Office Login...
curl -X POST %BASE_URL%/auth/office/login ^
  -H "Content-Type: application/json" ^
  -d "{\"username\":\"office\",\"password\":\"office123\"}"
echo.
echo.

echo Testing HOD Login (via Staff endpoint)...
curl -X POST %BASE_URL%/auth/staff/login ^
  -H "Content-Type: application/json" ^
  -d "{\"username\":\"hod\",\"password\":\"hod123\"}"
echo.
echo.

echo Testing Faculty Login (via Staff endpoint)...
curl -X POST %BASE_URL%/auth/staff/login ^
  -H "Content-Type: application/json" ^
  -d "{\"username\":\"faculty\",\"password\":\"faculty123\"}"
echo.
echo.

echo Testing Advisor Login (via Staff endpoint)...
curl -X POST %BASE_URL%/auth/staff/login ^
  -H "Content-Type: application/json" ^
  -d "{\"username\":\"advisor\",\"password\":\"advisor123\"}"
echo.
echo.

echo Testing Assistant Login...
curl -X POST %BASE_URL%/auth/assistant/login ^
  -H "Content-Type: application/json" ^
  -d "{\"username\":\"assistant\",\"password\":\"assistant123\"}"
echo.
echo.

echo Testing Student Login...
curl -X POST %BASE_URL%/auth/student/login ^
  -H "Content-Type: application/json" ^
  -d "{\"username\":\"student\",\"password\":\"student123\"}"
echo.
echo.

echo ================================================
echo CROSS-ROLE REJECTION TEST (Should Fail)
echo ================================================
echo.

echo Testing Student login via Principal endpoint (should fail)...
curl -X POST %BASE_URL%/auth/principal/login ^
  -H "Content-Type: application/json" ^
  -d "{\"username\":\"student\",\"password\":\"student123\"}"
echo.
echo.

echo Testing Principal login via Student endpoint (should fail)...
curl -X POST %BASE_URL%/auth/student/login ^
  -H "Content-Type: application/json" ^
  -d "{\"username\":\"principal\",\"password\":\"admin123\"}"
echo.
echo.

echo ================================================
echo WRONG PASSWORD TEST (Should Fail)
echo ================================================
echo.

echo Testing Principal with wrong password...
curl -X POST %BASE_URL%/auth/principal/login ^
  -H "Content-Type: application/json" ^
  -d "{\"username\":\"principal\",\"password\":\"wrongpassword\"}"
echo.
echo.

echo ================================================
echo TEST COMPLETE
echo ================================================
pause
