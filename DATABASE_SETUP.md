# Database Setup Guide

This guide will help you set up MySQL database for your Laravel application.

## Prerequisites

1. **MySQL Server**: Make sure MySQL is installed and running on your system
2. **Database Creation**: Create a database for your application
3. **Environment Configuration**: Update your `.env` file with database credentials

## Step 1: Configure Environment Variables

The `.env` file has been updated to use MySQL. Update the following values with your actual database credentials:

```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=laravel          # Change this to your database name
DB_USERNAME=root             # Change this to your MySQL username
DB_PASSWORD=                 # Add your MySQL password here
```

## Step 2: Create Database

Create a MySQL database that matches your `DB_DATABASE` value:

```sql
CREATE DATABASE laravel CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

## Step 3: Run Database Setup

Use one of the following methods to set up your database:

### Method 1: Using the Custom Setup Command

```bash
# Basic setup (runs migrations)
php artisan db:setup

# Fresh installation (drops all tables and recreates)
php artisan db:setup --fresh

# Setup with sample data
php artisan db:setup --seed

# Fresh installation with sample data
php artisan db:setup --fresh --seed
```

### Method 2: Using Setup Scripts

**Windows:**
```cmd
setup-database.bat
```

**Linux/Mac:**
```bash
chmod +x setup-database.sh
./setup-database.sh
```

### Method 3: Manual Laravel Commands

```bash
# Run migrations
php artisan migrate

# Check migration status
php artisan migrate:status

# Run seeders (if available)
php artisan db:seed
```

## Database Structure

The application includes the following tables:

### Core Tables
- **users**: User accounts and authentication
- **products**: Product catalog
- **password_reset_tokens**: Password reset functionality
- **sessions**: User session management

### System Tables
- **cache** & **cache_locks**: Application caching
- **jobs**, **job_batches**, **failed_jobs**: Queue management
- **migrations**: Migration tracking

## Troubleshooting

### Connection Issues

1. **"Connection refused"**: Make sure MySQL server is running
2. **"Access denied"**: Check your username and password in `.env`
3. **"Database doesn't exist"**: Create the database first
4. **"Unknown database"**: Verify the database name in `DB_DATABASE`

### Common Solutions

```bash
# Test database connection
php artisan tinker
>>> DB::connection()->getPdo();

# Clear configuration cache
php artisan config:clear

# Check current configuration
php artisan config:show database
```

## Production Deployment

For production environments (like Vercel), consider using:

- **Vercel Postgres**: Serverless PostgreSQL database
- **PlanetScale**: Serverless MySQL platform
- **Supabase**: Open source Firebase alternative
- **Turso**: SQLite for the edge

### Environment Variables for Production

Update your production environment with:

```env
DB_CONNECTION=mysql  # or pgsql for PostgreSQL
DB_HOST=your-production-host
DB_PORT=3306
DB_DATABASE=your-production-database
DB_USERNAME=your-production-username
DB_PASSWORD=your-production-password
DB_SSLMODE=require  # For secure connections
```

## Additional Commands

```bash
# Rollback migrations
php artisan migrate:rollback

# Reset and re-run all migrations
php artisan migrate:refresh

# Drop all tables and re-run migrations with seeders
php artisan migrate:fresh --seed

# Create new migration
php artisan make:migration create_table_name

# Create new seeder
php artisan make:seeder TableNameSeeder
```

## Support

If you encounter any issues:

1. Check the Laravel logs: `storage/logs/laravel.log`
2. Verify your MySQL server is running
3. Ensure database credentials are correct
4. Make sure the database exists and is accessible

For more information, refer to the [Laravel Database Documentation](https://laravel.com/docs/database).