@echo off
echo ================================================
echo Testing Backend Authentication
echo ================================================
echo.

echo Testing Principal Login...
curl -X POST http://localhost:8080/api/auth/principal/login ^
  -H "Content-Type: application/json" ^
  -d "{\"username\":\"principal\",\"password\":\"admin123\"}"

echo.
echo.
echo ================================================
echo If you see a JWT token above, backend is working!
echo ================================================
pause
