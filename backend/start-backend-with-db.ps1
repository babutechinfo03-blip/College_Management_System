# Database Connection Environment Variables
$env:DB_HOST = "localhost"
$env:DB_PORT = "3306"
$env:DB_NAME = "college_erp"
$env:DB_USERNAME = "root"
$env:DB_PASSWORD = "Sanjai@2005"

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "Starting Backend with Externalized MySQL Config" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "Target: $env:DB_HOST : $env:DB_PORT / $env:DB_NAME"

# Find JAR file
$startDir = $PSScriptRoot
if (-not $startDir) { $startDir = Get-Location }
$jarFile = Get-ChildItem -Path "$startDir\target" -Filter "*.jar" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1

if ($jarFile) {
    Write-Host "Found JAR: $($jarFile.Name)" -ForegroundColor Green
    Write-Host "Launching..." -ForegroundColor Yellow
    # Pass environment variables to the process
    try {
        java -jar $jarFile.FullName
    }
    catch {
        Write-Host "CRITICAL ERROR: Java process failed to start or crashed." -ForegroundColor Red
        Write-Host $_.Exception.Message -ForegroundColor Red
    }
}
else {
    Write-Host "ERROR: No JAR file found in target folder." -ForegroundColor Red
    Write-Host "Please build the project first (e.g., mvn clean package)" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Press Enter to close..." -ForegroundColor Cyan
Read-Host
