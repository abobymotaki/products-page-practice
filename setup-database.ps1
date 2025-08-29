#!/usr/bin/env pwsh
# Database Setup Script for Laravel Application
# This script ensures the database and all tables are created properly

Write-Host "Starting database setup..." -ForegroundColor Green

# Check if .env file exists
if (-not (Test-Path ".env")) {
    Write-Host "Error: .env file not found. Please copy .env.example to .env and configure it." -ForegroundColor Red
    exit 1
}

# Check database connection
Write-Host "Checking database connection..." -ForegroundColor Yellow
try {
    $result = php artisan db:show 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Database connection failed. Creating SQLite database..." -ForegroundColor Yellow
        
        # Ensure database directory exists
        if (-not (Test-Path "database")) {
            New-Item -ItemType Directory -Path "database" -Force
        }
        
        # Create SQLite database file if it doesn't exist
        if (-not (Test-Path "database/database.sqlite")) {
            New-Item -ItemType File -Path "database/database.sqlite" -Force
            Write-Host "Created SQLite database file." -ForegroundColor Green
        }
    }
} catch {
    Write-Host "Error checking database connection: $_" -ForegroundColor Red
    exit 1
}

# Run migrations to create tables
Write-Host "Running database migrations..." -ForegroundColor Yellow
try {
    php artisan migrate --force
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Database migrations completed successfully." -ForegroundColor Green
    } else {
        Write-Host "Migration failed with exit code: $LASTEXITCODE" -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "Error running migrations: $_" -ForegroundColor Red
    exit 1
}

# Verify tables were created
Write-Host "Verifying database tables..." -ForegroundColor Yellow
try {
    $tables = php artisan db:show --json | ConvertFrom-Json
    $tableCount = $tables.tables.Count
    
    if ($tableCount -gt 0) {
        Write-Host "Database setup completed successfully!" -ForegroundColor Green
        Write-Host "Total tables created: $tableCount" -ForegroundColor Cyan
        
        # Show table details
        Write-Host "\nDatabase Tables:" -ForegroundColor Cyan
        php artisan db:show
        
        # Specifically check products table
        Write-Host "\nProducts table structure:" -ForegroundColor Cyan
        php artisan db:table products
        
    } else {
        Write-Host "Warning: No tables found in database." -ForegroundColor Yellow
    }
} catch {
    Write-Host "Error verifying database: $_" -ForegroundColor Red
}

Write-Host "\nDatabase setup script completed." -ForegroundColor Green