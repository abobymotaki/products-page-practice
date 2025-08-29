@echo off
echo ========================================
echo Laravel Database Setup Script
echo ========================================
echo.
echo This script will help you set up your MySQL database.
echo Make sure you have:
echo 1. MySQL server running
echo 2. Database credentials configured in .env file
echo 3. Created the database specified in DB_DATABASE
echo.
pause
echo.
echo Running database setup...
php artisan db:setup
echo.
echo Setup complete! You can also use these commands:
echo.
echo php artisan db:setup --fresh     (Drop all tables and recreate)
echo php artisan db:setup --seed      (Run with database seeders)
echo php artisan db:setup --fresh --seed (Fresh install with seeders)
echo.
pause