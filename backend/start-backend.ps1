# College ERP Backend Starter Script
# This script starts the Spring Boot backend

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "College ERP Backend Starter" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Change to backend directory
$backendDir = "f:\Full Stack App\backend"
Set-Location $backendDir

Write-Host "Checking Java installation..." -ForegroundColor Yellow
$javaVersion = java -version 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Java is not installed or not in PATH!" -ForegroundColor Red
    Write-Host "Please install Java 21 or higher" -ForegroundColor Red
    pause
    exit 1
}

Write-Host "Java found:" -ForegroundColor Green
Write-Host $javaVersion[0] -ForegroundColor Green
Write-Host ""

# Check if port 8080 is already in use
Write-Host "Checking if port 8080 is available..." -ForegroundColor Yellow
$portCheck = netstat -ano | findstr :8080
if ($portCheck) {
    Write-Host "WARNING: Port 8080 is already in use!" -ForegroundColor Red
    Write-Host "Another application might be running on this port." -ForegroundColor Red
    Write-Host ""
    $response = Read-Host "Do you want to kill the process and continue? (y/n)"
    if ($response -eq 'y') {
        $pid = ($portCheck -split '\s+')[-1]
        Write-Host "Killing process $pid..." -ForegroundColor Yellow
        taskkill /PID $pid /F
        Start-Sleep -Seconds 2
    } else {
        Write-Host "Exiting..." -ForegroundColor Yellow
        pause
        exit 1
    }
}

Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "Starting Spring Boot Backend..." -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Backend will be available at: http://localhost:8080" -ForegroundColor Green
Write-Host "Frontend should connect to: http://localhost:8080/api" -ForegroundColor Green
Write-Host ""
Write-Host "Press Ctrl+C to stop the server" -ForegroundColor Yellow
Write-Host ""

# Try to find and run the JAR file
$jarFile = Get-ChildItem -Path "target" -Filter "*.jar" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1

if ($jarFile) {
    Write-Host "Found JAR file: $($jarFile.Name)" -ForegroundColor Green
    Write-Host "Starting from JAR..." -ForegroundColor Yellow
    Write-Host ""
    java -jar $jarFile.FullName
} else {
    Write-Host "JAR file not found. Starting from compiled classes..." -ForegroundColor Yellow
    Write-Host ""
    
    # Build classpath
    $classPath = "target\classes"
    
    # Check if we need to download dependencies first
    if (-not (Test-Path "target\classes\com\college\erp\ErpApplication.class")) {
        Write-Host "ERROR: Compiled classes not found!" -ForegroundColor Red
        Write-Host ""
        Write-Host "Please compile the project first using one of these methods:" -ForegroundColor Yellow
        Write-Host "1. Open in IntelliJ IDEA and run ErpApplication.java" -ForegroundColor Yellow
        Write-Host "2. Open in Eclipse and run ErpApplication.java" -ForegroundColor Yellow
        Write-Host "3. Install Maven and run: mvn spring-boot:run" -ForegroundColor Yellow
        Write-Host ""
        pause
        exit 1
    }
    
    # This won't work without dependencies, but we'll try
    Write-Host "WARNING: This method requires Maven dependencies!" -ForegroundColor Red
    Write-Host "Recommended: Use IntelliJ IDEA or Eclipse to run the backend" -ForegroundColor Yellow
    Write-Host ""
    pause
}
