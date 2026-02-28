@echo off
setlocal

:: Database Connection Details
set DB_HOST=localhost
set DB_PORT=3306
set DB_NAME=college_erp
set DB_USERNAME=root
set DB_PASSWORD=Sanjai@2005

echo ================================================
echo Starting Backend with Externalized MySQL Config
echo ================================================
echo Target: %DB_HOST%:%DB_PORT% / %DB_NAME%
echo.

:: Find the JAR file (simple approach: first one in target)
for %%f in ("target\*.jar") do set JAR_FILE=%%f

if "%JAR_FILE%"=="" (
    echo ERROR: No JAR file found in target folder.
    echo Please build the project first: mvn clean package
    goto :end
)

echo Found JAR: %JAR_FILE%
echo Launching...
echo.

java -jar "%JAR_FILE%"

:end
echo.
echo ================================================
echo Server process ended.
echo ================================================
pause
