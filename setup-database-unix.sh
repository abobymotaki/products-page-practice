#!/bin/bash
# Database Setup Script for Laravel Application (Unix/Linux/macOS)
# This script ensures the database and all tables are created properly

echo "Starting database setup..."

# Check if .env file exists
if [ ! -f ".env" ]; then
    echo "Error: .env file not found. Please copy .env.example to .env and configure it."
    exit 1
fi

# Check database connection
echo "Checking database connection..."
if ! php artisan db:show > /dev/null 2>&1; then
    echo "Database connection failed. Creating SQLite database..."
    
    # Ensure database directory exists
    mkdir -p database
    
    # Create SQLite database file if it doesn't exist
    if [ ! -f "database/database.sqlite" ]; then
        touch database/database.sqlite
        echo "Created SQLite database file."
    fi
fi

# Run migrations to create tables
echo "Running database migrations..."
if php artisan migrate --force; then
    echo "Database migrations completed successfully."
else
    echo "Migration failed with exit code: $?"
    exit 1
fi

# Verify tables were created
echo "Verifying database tables..."
if php artisan db:show > /dev/null 2>&1; then
    echo "Database setup completed successfully!"
    
    # Show table details
    echo ""
    echo "Database Tables:"
    php artisan db:show
    
    # Specifically check products table
    echo ""
    echo "Products table structure:"
    php artisan db:table products
else
    echo "Error verifying database."
    exit 1
fi

echo ""
echo "Database setup script completed."