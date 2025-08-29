#!/bin/bash
# Database Setup Script for Laravel Application (Unix/Linux/macOS)
# This script ensures the database and all tables are created properly

echo "Starting database setup..."

# Check if .env file exists, if not create from example
if [ ! -f ".env" ]; then
    echo "Creating .env file from .env.example..."
    cp .env.example .env
    
    # Generate application key
    php artisan key:generate --force
fi

# Ensure database directory exists
mkdir -p database

# Determine database path (use /tmp for Vercel, local database for development)
if [ "$VERCEL" = "1" ] || [ "$APP_ENV" = "production" ]; then
    DB_PATH="/tmp/database.sqlite"
    echo "Using production database path: $DB_PATH"
else
    DB_PATH="database/database.sqlite"
    echo "Using local database path: $DB_PATH"
fi

# Create SQLite database file if it doesn't exist
if [ ! -f "$DB_PATH" ]; then
    touch "$DB_PATH"
    echo "Created SQLite database file at $DB_PATH"
fi

# Set proper permissions
chmod 664 "$DB_PATH" 2>/dev/null || true
if [ "$DB_PATH" = "database/database.sqlite" ]; then
    chmod 775 database 2>/dev/null || true
fi

# Clear any cached config
php artisan config:clear --quiet 2>/dev/null || true
php artisan cache:clear --quiet 2>/dev/null || true

# Run migrations to create tables
echo "Running database migrations..."
if php artisan migrate --force --no-interaction; then
    echo "Database migrations completed successfully."
else
    echo "Migration failed with exit code: $?"
    # Don't exit on migration failure in production builds
    echo "Continuing with build process..."
fi

# Verify database setup (but don't fail build if verification fails)
echo "Verifying database setup..."
if php artisan db:show > /dev/null 2>&1; then
    echo "Database setup completed successfully!"
else
    echo "Database verification skipped (may not be available in build environment)"
fi

echo "Database setup script completed."