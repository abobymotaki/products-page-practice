# Database Setup Guide

This guide explains how to set up the database for this Laravel application with automatic table creation.

## Overview

The application uses SQLite as the default database and includes automated scripts to ensure proper database setup during the build process.

## Database Tables

The following tables are automatically created:

### Core Tables
- **users**: User authentication and profile data
  - `id` (integer, autoincrement, primary key)
  - `name` (varchar)
  - `email` (varchar, unique)
  - `email_verified_at` (timestamp, nullable)
  - `password` (varchar)
  - `remember_token` (varchar, nullable)
  - `created_at`, `updated_at` (timestamps)

- **products**: Product catalog data
  - `id` (integer, autoincrement, primary key)
  - `name` (varchar)
  - `price` (numeric, 10,2)
  - `description` (text, nullable)
  - `created_at`, `updated_at` (timestamps)

### System Tables
- **cache**: Application caching
- **cache_locks**: Cache locking mechanism
- **jobs**: Queue job processing
- **job_batches**: Batch job processing
- **failed_jobs**: Failed job tracking
- **sessions**: User session storage
- **password_reset_tokens**: Password reset functionality
- **migrations**: Laravel migration tracking

## Automatic Setup

### During Build Process
The database is automatically set up when you run:
```bash
npm run build
```

This command:
1. Runs the database setup script
2. Creates the SQLite database file if it doesn't exist
3. Executes all migrations to create tables
4. Verifies the database structure
5. Builds the application assets

### Manual Database Setup
You can also run the database setup independently:

**Windows:**
```bash
npm run setup:db
```

**Unix/Linux/macOS:**
```bash
npm run setup:db:unix
```

**Direct Laravel Commands:**
```bash
php artisan migrate
php artisan db:show
php artisan db:table products
```

## Database Configuration

The application is configured to use SQLite by default in the `.env` file:
```env
DB_CONNECTION=sqlite
```

The SQLite database file is located at:
```
database/database.sqlite
```

## Verification

To verify your database setup:

1. **Check database connection:**
   ```bash
   php artisan db:show
   ```

2. **View table structure:**
   ```bash
   php artisan db:table products
   php artisan db:table users
   ```

3. **Run migrations manually:**
   ```bash
   php artisan migrate
   ```

## Troubleshooting

### Database File Missing
If the SQLite database file is missing, it will be automatically created by the setup scripts.

### Migration Issues
If migrations fail:
1. Check the `.env` file configuration
2. Ensure the `database` directory exists
3. Run `php artisan migrate:status` to check migration status
4. Use `php artisan migrate:fresh` to recreate all tables (⚠️ This will delete all data)

### Permission Issues
Ensure the `database` directory and `database.sqlite` file have proper write permissions.

## Production Deployment

For production deployments:
1. The `npm run build:production` command includes database setup
2. Migrations run with the `--force` flag to avoid prompts
3. Consider using a more robust database system (MySQL, PostgreSQL) for production

## Scripts Reference

- `npm run build` - Build with database setup
- `npm run build:production` - Production build with database setup
- `npm run setup:db` - Database setup only (Windows)
- `npm run setup:db:unix` - Database setup only (Unix/Linux/macOS)
- `setup-database.ps1` - PowerShell database setup script
- `setup-database-unix.sh` - Bash database setup script