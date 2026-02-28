@echo off
echo ================================================
echo Starting College ERP Backend Server
echo ================================================
echo.

cd /d "%~dp0"

echo Checking Java installation...
java -version
if errorlevel 1 (
    echo ERROR: Java is not installed or not in PATH
    pause
    exit /b 1
)

echo.
echo Starting Spring Boot application...
echo Backend will be available at: http://localhost:8080
echo Press Ctrl+C to stop the server
echo.

java -jar target/erp-0.0.1-SNAPSHOT.jar

if errorlevel 1 (
    echo.
    echo JAR file not found. Trying to run from classes...
    java -cp "target/classes;target/dependency/*" com.college.erp.ErpApplication
)

pause
